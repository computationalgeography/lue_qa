#!/usr/bin/env python
import ast
import os.path
import sys

import docopt
import lue.framework as lfr
import lue.qa as lqa
import numpy as np


@lfr.runtime_scope
def hello_world(
    nr_workers,
    count,
    array_shape,
    partition_shape,
    result_pathname,
):

    # Given the information passed in, perform some computation and report the amount of time
    # this took.

    experiment = lqa.ArrayExperiment(nr_workers, array_shape, partition_shape)
    experiment.start()

    for _ in range(count):
        # Perform some calculations on the workers and keep track of the timings

        run = lqa.Run()

        # Perform "I/O" and wait for it to finish. Preprocessing.
        array = lfr.uniform(array_shape, partition_shape, np.dtype(np.float32), 0, 10)
        lfr.wait(array)

        # Everything is ready to determine the latency of the calculations. Press start on the
        # stopwatch for this run.
        run.start()

        # Perform the computations
        result = (lfr.sqrt(array) ** array) * (array / array)

        # Wait for result to be available and only then press stop on the stopwatch for this run
        lfr.wait(result)
        run.stop()

        experiment.add(run)

    experiment.stop()
    lqa.save_results(experiment, result_pathname)


def parse_count(string):

    return int(string)


def parse_shape(string):

    literal = ast.literal_eval(string)
    assert isinstance(literal, list), literal
    assert all(isinstance(element, int) for element in literal), literal
    assert len(literal) == 2, literal

    return tuple(literal)


def main():
    command = os.path.basename(sys.argv[0])
    lue_usage = f"""\
    Dummy script for scalability experiments

    Usage:
        {command} --lue:count=<count> --lue:nr_workers=<nr_workers>
            --lue:array_shape=<shape> --lue:partition_shape=<shape>
            --lue:result=<result>

    Options:
        --lue:count=<count>             Number of times to repeat the experiment
        --lue:nr_workers=<nr_workers>   Number of workers used in experiment
        --lue:array_shape=<shape>       Shape of array: nr_rows,nr_cols
        --lue::partition_shape=<shape>  Shape of partition: nr_rows,nr_cols
        --lue::result=<result>          Pathname of file to write results in
    """

    # Filter out arguments meant for the HPX runtime. These are automatically parsed by the
    # code that starts the runtime.
    # hpx_arguments = [arg for arg in sys.argv[1:] if arg.startswith("--hpx:")]

    # Parse arguments which are passed in by the LUE QA generated script
    lue_arguments = [arg for arg in sys.argv[1:] if arg.startswith("--lue:")]
    lue_arguments = docopt.docopt(lue_usage, lue_arguments)
    nr_workers = parse_count(lue_arguments["--lue:nr_workers"])  # type: ignore
    count = parse_count(lue_arguments["--lue:count"])  # type: ignore
    array_shape = parse_shape(lue_arguments["--lue:array_shape"])  # type: ignore
    partition_shape = parse_shape(lue_arguments["--lue:partition_shape"])  # type: ignore
    result_pathname = lue_arguments["--lue:result"]  # type: ignore

    hello_world(nr_workers, count, array_shape, partition_shape, result_pathname)


if __name__ == "__main__":
    main()
