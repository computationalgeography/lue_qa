import csv

import lue.data_model as ldm
import numpy as np


def export_partition_shape_results(lue_dataset, csv_writer):

    # Assert that the number of array shapes for which experiments where
    # performed is 1
    lue_array = lue_dataset.array.array
    assert lue_array.shape.value.nr_arrays == 1

    # For each array shape for which experiments where performed
    lue_measurement = lue_dataset.benchmark.measurement

    array_shapes = lue_measurement.array_shape.value[:]
    assert np.all(array_shapes == array_shapes[0])

    count = lue_measurement.duration.value.array_shape[:][0]

    lue_partition = lue_dataset.partition.partition

    partition_shape = lue_measurement.partition_shape.value[:]
    nr_partitions = lue_measurement.nr_partitions.value[:, -1]
    assert len(partition_shape) == len(nr_partitions)

    if count == 1:
        assert False, "Implement!"
    else:
        # Write the following columns:
        # - partition_shape
        # - nr_partitions
        # - {mean,std}_duration
        csv_writer.writerow(
            [
                # "partition_shape",
                "partition_size",
                "nr_partitions",
                "mean_duration",
                "std_duration",
            ]
        )

        array_idx = 0
        mean_duration = lue_partition.properties[f"mean_duration_{array_idx}"].value[:]
        std_duration = lue_partition.properties[f"std_duration_{array_idx}"].value[:]

        for shape_idx, shape in enumerate(partition_shape):
            csv_writer.writerow(
                [
                    # "{},{}".format(*shape),
                    np.prod(shape),
                    nr_partitions[shape_idx],
                    mean_duration[shape_idx],
                    std_duration[shape_idx],
                ]
            )


def export_strong_scaling_results(lue_dataset, csv_writer):
    # pylint: disable=too-many-locals

    lue_measurement = lue_dataset.benchmark.measurement
    count = lue_measurement.duration.value.array_shape[:][0]
    nr_workers = lue_measurement.nr_workers.value[:]
    sort_idxs = np.argsort(nr_workers)
    nr_workers = nr_workers[sort_idxs]

    if count == 1:
        # Write the following columns:
        # - nr_workers
        # - relative_speed_up
        # - relative_efficiency
        # - lups
        csv_writer.writerow(
            [
                "nr_workers",
                "duration",
                "relative_speed_up",
                "relative_efficiency",
                "lups",
            ]
        )

        lue_scaling = lue_dataset.benchmark.scaling
        duration = lue_measurement.duration.value[:][sort_idxs]
        relative_speed_up = lue_scaling.relative_speed_up.value[:][sort_idxs]
        relative_efficiency = lue_scaling.relative_efficiency.value[:][sort_idxs]
        lups = lue_scaling.lups.value[:][sort_idxs]

        for idx, nr_workers_ in enumerate(nr_workers):
            csv_writer.writerow(
                [
                    nr_workers_,
                    duration[idx][0],
                    relative_speed_up[idx][0],
                    relative_efficiency[idx][0],
                    lups[idx][0],
                ]
            )
    else:
        # Write the following columns:
        # - nr_workers
        # - {mean,std}_duration
        # - {mean,std}_relative_efficiency
        # - {mean,std}_lups
        csv_writer.writerow(
            [
                "nr_workers",
                "mean_duration",
                "std_duration",
                "mean_relative_efficiency",
                "std_relative_efficiency",
                "mean_lups",
                "std_lups",
            ]
        )

        lue_scaling = lue_dataset.benchmark.scaling
        mean_duration = lue_scaling.mean_duration.value[:][sort_idxs]
        std_duration = lue_scaling.std_duration.value[:][sort_idxs]
        mean_relative_efficiency = lue_scaling.mean_relative_efficiency.value[:][
            sort_idxs
        ]
        std_relative_efficiency = lue_scaling.std_relative_efficiency.value[:][
            sort_idxs
        ]
        mean_lups = lue_scaling.mean_lups.value[:][sort_idxs]
        std_lups = lue_scaling.std_lups.value[:][sort_idxs]

        for idx, nr_workers_ in enumerate(nr_workers):
            csv_writer.writerow(
                [
                    nr_workers_,
                    mean_duration[idx],
                    std_duration[idx],
                    mean_relative_efficiency[idx],
                    std_relative_efficiency[idx],
                    mean_lups[idx],
                    std_lups[idx],
                ]
            )


def export_weak_scaling_results(lue_dataset, csv_writer):
    # pylint: disable=too-many-locals

    lue_measurement = lue_dataset.benchmark.measurement
    count = lue_measurement.duration.value.array_shape[:][0]
    nr_workers = lue_measurement.nr_workers.value[:]
    sort_idxs = np.argsort(nr_workers)
    nr_workers = nr_workers[sort_idxs]

    if count == 1:
        # Write the following columns:
        # - nr_workers
        # - duration
        # - relative_efficiency
        # - lups
        csv_writer.writerow(
            [
                "nr_workers",
                "duration",
                "relative_efficiency",
                "lups",
            ]
        )

        lue_scaling = lue_dataset.benchmark.scaling
        duration = lue_measurement.duration.value[:]
        relative_efficiency = lue_scaling.relative_efficiency.value[:][sort_idxs]
        lups = lue_scaling.lups.value[:][sort_idxs]

        for idx, nr_workers_ in enumerate(nr_workers):
            csv_writer.writerow(
                [
                    nr_workers_,
                    duration[idx][0],
                    relative_efficiency[idx][0],
                    lups[idx][0],
                ]
            )
    else:
        # Write the following columns:
        # - nr_workers
        # - {mean,std}_duration
        # - {mean,std}_relative_efficiency
        # - {mean,std}_lups
        csv_writer.writerow(
            [
                "nr_workers",
                "mean_duration",
                "std_duration",
                "mean_relative_efficiency",
                "std_relative_efficiency",
                "mean_lups",
                "std_lups",
            ]
        )

        lue_scaling = lue_dataset.benchmark.scaling
        mean_duration = lue_scaling.mean_duration.value[:][sort_idxs]
        std_duration = lue_scaling.std_duration.value[:][sort_idxs]
        mean_relative_efficiency = lue_scaling.mean_relative_efficiency.value[:][
            sort_idxs
        ]
        std_relative_efficiency = lue_scaling.std_relative_efficiency.value[:][
            sort_idxs
        ]
        mean_lups = lue_scaling.mean_lups.value[:][sort_idxs]
        std_lups = lue_scaling.std_lups.value[:][sort_idxs]

        for idx, nr_workers_ in enumerate(nr_workers):
            csv_writer.writerow(
                [
                    nr_workers_,
                    mean_duration[idx],
                    std_duration[idx],
                    mean_relative_efficiency[idx],
                    std_relative_efficiency[idx],
                    mean_lups[idx],
                    std_lups[idx],
                ]
            )


def export_results(lue_dataset_pathname, csv_file_pathname):

    lue_dataset = ldm.open_dataset(lue_dataset_pathname, "r")
    kind = lue_dataset.benchmark.meta_information.kind.value[:][0]

    with open(csv_file_pathname, "w", encoding="utf-8") as csv_file:
        csv_writer = csv.writer(csv_file)

        export_by_kind = {
            "partition_shape": export_partition_shape_results,
            "strong_scaling": export_strong_scaling_results,
            "weak_scaling": export_weak_scaling_results,
        }

        export_by_kind[kind](lue_dataset, csv_writer)
