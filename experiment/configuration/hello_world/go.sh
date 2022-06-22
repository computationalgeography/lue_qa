set -e
set -x


lue_install_prefix=$LUE_OBJECTS
hostname="velocity"
command="hello_world"


export PATH="$lue_install_prefix/bin:$PATH"
export PYTHONPATH="$lue_install_prefix/lib/python3.8:$PYTHONPATH"
export LD_PRELOAD=/data/software/easybuild/software/gperftools/2.9.1-GCCcore-10.2.0/lib/libtcmalloc_minimal.so.4

export LUE_QA="$LUE/../lue_qa"
export LUE_QA_CONFIG_PREFIX="$LUE_QA/experiment/configuration/$command"
export LUE_QA_COMMAND_PREFIX="$LUE_QA/experiment/configuration/$command"
export LUE_QA_RESULT_PREFIX="$HOME/tmp/lue_qa"


# Partition shape --------------------------------------------------------------
output_directory=$LUE_QA_RESULT_PREFIX/$hostname/${command}.py/thread_numa_node/partition_shape

if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi

# rm -f $output_directory/raw.lue

# Create script to perform experiments
lue_scalability.py partition_shape script $LUE_QA_CONFIG_PREFIX/my_partition_shape_config.json

# Execute experiments. On a cluster, these may run in any order and at the same time. Also,
# on a cluster this script finishes fast, while the experiments are being scheduled for execution.
bash ./${command}-partition_shape.sh

# Once results from all experiments are available. On a cluster, this command must not be run
# immediately after running the previous command. You first have to wait until all experiments
# are done.
rm -f $output_directory/scalability.lue

lue_scalability.py partition_shape import $LUE_QA_CONFIG_PREFIX/my_partition_shape_config.json

# Once results have been imported, postprocess them
lue_scalability.py partition_shape postprocess $LUE_QA_CONFIG_PREFIX/my_partition_shape_config.json


# Strong scalability -----------------------------------------------------------
output_directory=$LUE_QA_RESULT_PREFIX/$hostname/${command}.py/thread_numa_node/strong_scalability

if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi

# rm -f $output_directory/raw.lue

# Create script to perform experiments
lue_scalability.py strong_scalability script $LUE_QA_CONFIG_PREFIX/my_strong_scalability_config.json

# Execute experiments. On a cluster, these may run in any order and at the same time. Also,
# on a cluster this script finishes fast, while the experiments are being scheduled for execution.
bash ./${command}-strong_scalability.sh

# Once results from all experiments are available. On a cluster, this command must not be run
# immediately after running the previous command. You first have to wait until all experiments
# are done.
rm -f $output_directory/scalability.lue

lue_scalability.py strong_scalability import $LUE_QA_CONFIG_PREFIX/my_strong_scalability_config.json

# Once results have been imported, postprocess them
lue_scalability.py strong_scalability postprocess $LUE_QA_CONFIG_PREFIX/my_strong_scalability_config.json


# Weak scalability -------------------------------------------------------------
output_directory=$LUE_QA_RESULT_PREFIX/$hostname/${command}.py/thread_numa_node/weak_scalability

if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi

# rm -f $output_directory/raw.lue

# Create script to perform experiments
lue_scalability.py weak_scalability script $LUE_QA_CONFIG_PREFIX/my_weak_scalability_config.json

# Execute experiments. On a cluster, these may run in any order and at the same time. Also,
# on a cluster this script finishes fast, while the experiments are being scheduled for execution.
bash ./${command}-weak_scalability.sh

# Once results from all experiments are available. On a cluster, this command must not be run
# immediately after running the previous command. You first have to wait until all experiments
# are done.
rm -f $output_directory/scalability.lue

lue_scalability.py weak_scalability import $LUE_QA_CONFIG_PREFIX/my_weak_scalability_config.json

# Once results have been imported, postprocess them
lue_scalability.py weak_scalability postprocess $LUE_QA_CONFIG_PREFIX/my_weak_scalability_config.json
