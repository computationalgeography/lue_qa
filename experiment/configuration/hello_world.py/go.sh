set -e

lue_install_prefix=$LUE_OBJECTS

export PATH="$lue_install_prefix/bin:$PATH"

# TODO Port to other platform, generalize
export PYTHONPATH="$lue_install_prefix/lib/python3.10:$PYTHONPATH"
export LD_PRELOAD=$EBROOTGPERFTOOLS/lib/libtcmalloc_minimal.so.4

hostname=$(hostname -s)
command="hello_world.py"

# TODO Make this some argument
worker="thread_numa_node"

export PATH="`pwd`:$PATH"

lue_qa="$LUE/../lue_qa"
result_prefix="/developtest/data/lue_qa"

# Maybe put the stuff above this line in some header bash script that contains the platform specific stuff?


config_prefix="$lue_qa/configuration/$hostname"
sm_args="--cores 1 --configfile "$config_prefix/config.yaml" -- "


experiment="partition_shape"
output_directory=$result_prefix/${hostname}/${command}/${worker}/${experiment}
if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi
# snakemake ${sm_args} $output_directory/$experiment.sh
# snakemake ${sm_args} $output_directory/execute.done
# snakemake ${sm_args} $output_directory/import.done
# snakemake ${sm_args} $output_directory/postprocess.done


experiment="strong_scalability"
output_directory=$result_prefix/${hostname}/${command}/${worker}/${experiment}
if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi
# snakemake ${sm_args} $output_directory/$experiment.sh
# snakemake ${sm_args} $output_directory/execute.done
# snakemake ${sm_args} $output_directory/import.done
# snakemake ${sm_args} $output_directory/postprocess.done


experiment="weak_scalability"
output_directory=$result_prefix/${hostname}/${command}/${worker}/${experiment}
if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi
# snakemake ${sm_args} $output_directory/$experiment.sh
# snakemake ${sm_args} $output_directory/execute.done
# snakemake ${sm_args} $output_directory/import.done
# snakemake ${sm_args} $output_directory/postprocess.done
