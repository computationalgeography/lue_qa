set -e
set -x


lue_install_prefix=$LUE_OBJECTS

export PATH="$lue_install_prefix/bin:$PATH"
export PYTHONPATH="$lue_install_prefix/lib/python3.10:$PYTHONPATH"
export LD_PRELOAD=$EBROOTGPERFTOOLS/lib/libtcmalloc_minimal.so.4

hostname=$(hostname -s)
command="hello_world.py"

worker="thread_numa_node"

export PATH="`pwd`:$PATH"

LUE_QA="$LUE/../lue_qa"
### export LUE_QA_CONFIG_PREFIX="$LUE_QA/experiment/configuration/$command"
### export LUE_QA_COMMAND_PREFIX="$LUE_QA/experiment/configuration/$command"
LUE_QA_CONFIG_PREFIX="$LUE_QA/configuration/$hostname"
LUE_QA_RESULT_PREFIX="/developtest/data/lue_qa"

sm_args="--cores 1 --configfile "$LUE_QA_CONFIG_PREFIX/config.yaml" -- "


experiment="partition_shape"
output_directory=$LUE_QA_RESULT_PREFIX/${hostname}/${command}/${worker}/${experiment}
if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/${experiment}.sh
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/execute.done
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/import.done
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/postprocess.done


experiment="strong_scalability"
output_directory=$LUE_QA_RESULT_PREFIX/${hostname}/${command}/${worker}/${experiment}
if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}.sh
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/execute.done
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/import.done
snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/postprocess.done


experiment="weak_scalability"
output_directory=$LUE_QA_RESULT_PREFIX/${hostname}/${command}/${worker}/${experiment}
if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}.sh
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/execute.done
# snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/import.done
snakemake ${sm_args} ${LUE_QA_RESULT_PREFIX}/${hostname}/${command}/${worker}/${experiment}/postprocess.done
