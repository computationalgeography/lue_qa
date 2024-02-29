set -eu


# Before calling this script, you need to setup the environment so that this command can be called.

# project="202306_lue_course"
command="model.py"

# project="test"
command="hello_world.py"

command="image_land_integrate.py"
command="decreasing_order.py"
command="integrate.py"


lue_hostname=`hostname -s 2>/dev/null`

if [ ! "$lue_hostname" ];
then
    lue_hostname=`hostname`
fi

if [ ! "$lue_hostname" ];
then
    echo "Could not figure out the hostname"
    exit 1
fi

lue_hostname="${lue_hostname,,}"  # Lower-case the hostname

if [[ $lue_hostname == int? || $lue_hostname == tcn* ]];
then
    lue_hostname="snellius"
elif [[ $lue_hostname == uu107273 ]];
then
    lue_hostname="m1compiler"
fi


if [[ $lue_hostname == "gransasso" ]];
then
    export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4"
    result_prefix="/mnt/data2/kor/data/lue_qa"
    worker="thread_numa_node"
elif [[ $lue_hostname == "eejit" ]];
then
    # TODO Setting this loads the wrong libz ...
    # export LD_PRELOAD="$GOOGLE_PERFTOOLS_ROOT/lib/libtcmalloc_minimal.so.4"
    result_prefix="$HOME/development/data/lue_qa"
    worker="cluster_node"
    worker="numa_node"
    worker="thread_cluster_node"
    worker="thread_numa_node"
elif [[ $lue_hostname == "snellius" ]];
then
    export LD_PRELOAD=$EBROOTGPERFTOOLS/lib/libtcmalloc_minimal.so.4
    result_prefix="$HOME/development/data/lue_qa"
    worker="cluster_node"
    worker="numa_node"
    worker="thread_cluster_node"
    worker="thread_numa_node"
elif [[ $lue_hostname == "snowdon" ]];
then
    export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4"
    lue_qa_prefix="$HOME/development/project/github/computational_geography/lue_qa"
    lue_install_prefix="$HOME/development/object/conan/RelWithDebInfo/lue"
    lue_install_prefix="$HOME/tmp/lue_RelWithDebInfo"
    result_prefix="$HOME/development/data/lue_qa"
    worker="thread_numa_node"
elif [[ $lue_hostname == "velocity" ]];
then
    export LD_PRELOAD="$EBROOTGPERFTOOLS/lib/libtcmalloc_minimal.so.4"
    result_prefix="/developtest/data/lue_qa"
    worker="thread_numa_node"
fi

echo "command      : ${command}"
echo "worker       : ${worker}"
echo "result_prefix: ${result_prefix}"

# Maybe put the stuff above this line in some header bash script that contains the platform specific stuff?

export PATH="$lue_install_prefix/bin:$lue_qa_prefix/environment/script:$PATH"
export PYTHONPATH="$(echo $lue_install_prefix/lib/python3.*):${PYTHONPATH:=}"

config_prefix="$lue_qa_prefix/configuration/$lue_hostname"
sm_args="--cores 1 --configfile "$config_prefix/config.yaml" -- "


experiment="partition_shape"
output_directory="$result_prefix/${lue_hostname}/${command}/${worker}/${experiment}"
# if [ -d $output_directory ]; then
#     mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
# fi
# snakemake ${sm_args} $output_directory/$experiment.sh
# snakemake ${sm_args} $output_directory/execute.done
# snakemake ${sm_args} $output_directory/import.done
# snakemake ${sm_args} $output_directory/postprocess.done


experiment="strong_scalability"
output_directory=$result_prefix/${lue_hostname}/${command}/${worker}/${experiment}
if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi
snakemake ${sm_args} $output_directory/$experiment.sh
snakemake ${sm_args} $output_directory/execute.done
snakemake ${sm_args} $output_directory/import.done
snakemake ${sm_args} $output_directory/postprocess.done


experiment="weak_scalability"
output_directory=$result_prefix/${lue_hostname}/${command}/${worker}/${experiment}
if [ -d $output_directory ]; then
    mv $output_directory "$output_directory-`stat -c %y ${output_directory}`"
fi
snakemake ${sm_args} $output_directory/$experiment.sh
snakemake ${sm_args} $output_directory/execute.done
snakemake ${sm_args} $output_directory/import.done
snakemake ${sm_args} $output_directory/postprocess.done
