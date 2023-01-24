set -e

lue_install_prefix=$LUE_OBJECTS

export PATH="$lue_install_prefix/bin:$PATH"

hostname=$LUE_HOSTNAME

command="hello_world.py"


export PATH="$LUE/../lue_qa/environment/script:$PATH"

lue_qa="$LUE/../lue_qa"

export PYTHONPATH="$(echo $lue_install_prefix/lib/python3.*):$PYTHONPATH"

if [[ $hostname == "gransasso" ]];
then
    ### export PYTHONPATH="$lue_install_prefix/lib/python3.10:$PYTHONPATH"
    export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4"
    result_prefix="/mnt/data2/kor/data/lue_qa"
    worker="thread_numa_node"
elif [[ $hostname == "eejit" ]];
then
    ### export PYTHONPATH="$lue_install_prefix/lib/python3.9:$PYTHONPATH"
    # TODO Setting this loads the wrong libz ...
    # export LD_PRELOAD="$GOOGLE_PERFTOOLS_ROOT/lib/libtcmalloc_minimal.so.4"
    result_prefix="$HOME/development/data/lue_qa"
    worker="cluster_node"
    worker="numa_node"
    worker="thread_cluster_node"
    worker="thread_numa_node"
elif [[ $hostname == "snellius" ]];
then
    export LD_PRELOAD=$EBROOTGPERFTOOLS/lib/libtcmalloc_minimal.so.4
    result_prefix="$HOME/development/data/lue_qa"
    worker="cluster_node"
    worker="numa_node"
    worker="thread_cluster_node"
    worker="thread_numa_node"
elif [[ $hostname == "snowdon" ]];
then
    ### export PYTHONPATH="$lue_install_prefix/lib/python3.10:$PYTHONPATH"
    export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4"
    result_prefix="$HOME/development/data/lue_qa"
    worker="thread_numa_node"
elif [[ $hostname == "velocity" ]];
then
    ### export PYTHONPATH="$lue_install_prefix/lib/python3.10:$PYTHONPATH"
    export LD_PRELOAD="$EBROOTGPERFTOOLS/lib/libtcmalloc_minimal.so.4"
    result_prefix="/developtest/data/lue_qa"
    worker="thread_numa_node"
fi


# Maybe put the stuff above this line in some header bash script that contains the platform specific stuff?


config_prefix="$lue_qa/configuration/$hostname"
sm_args="--cores 1 --configfile "$config_prefix/config.yaml" -- "


experiment="partition_shape"
output_directory="$result_prefix/${hostname}/${command}/${worker}/${experiment}"
# if [ -d $output_directory ]; then
#     mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
# fi
# snakemake ${sm_args} $output_directory/$experiment.sh
# snakemake ${sm_args} $output_directory/execute.done
# snakemake ${sm_args} $output_directory/import.done
# snakemake ${sm_args} $output_directory/postprocess.done


experiment="strong_scalability"
output_directory=$result_prefix/${hostname}/${command}/${worker}/${experiment}
# if [ -d $output_directory ]; then
#     mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
# fi
# snakemake ${sm_args} $output_directory/$experiment.sh
# snakemake ${sm_args} $output_directory/execute.done
# snakemake ${sm_args} $output_directory/import.done
# snakemake ${sm_args} $output_directory/postprocess.done


experiment="weak_scalability"
output_directory=$result_prefix/${hostname}/${command}/${worker}/${experiment}
# if [ -d $output_directory ]; then
#     mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
# fi
# snakemake ${sm_args} $output_directory/$experiment.sh
# snakemake ${sm_args} $output_directory/execute.done
# snakemake ${sm_args} $output_directory/import.done
# snakemake ${sm_args} $output_directory/postprocess.done
