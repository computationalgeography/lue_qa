# orkney


TODO Fix this info!


## Specifications
<table>
    <tr>
        <td>Processor</td>
        <td>AMD Ryzen 9 7900 12-Core</td>
    </tr>
    <tr>
        <td># packages</td>
        <td>1</td>
    </tr>
    <tr>
        <td># cores</td>
        <td>12 / package → 12 total</td>
    </tr>
    <tr>
        <td># threads</td>
        <td>2 / core → 24 total</td>
    </tr>
    <tr>
        <td>Base frequency</td>
        <td>TODO GHz</td>
    </tr>
    <tr>
        <td>Max memory bandwidth</td>
        <td>TODO GB/s</td>
    </tr>
    <tr>
        <td>Main memory</td>
        <td>TODO GiB, TODO GiB/core</td>
    </tr>
    <tr>
        <td>L3</td>
        <td>TODO KB / TODO cores</td>
    </tr>
    <tr>
        <td>L2</td>
        <td>TODO KB / core</td>
    </tr>
    <tr>
        <td>L1i</td>
        <td>TODO KB / core</td>
    </tr>
    <tr>
        <td>L1d</td>
        <td>TODO KB / core</td>
    </tr>
</table>

TODO all stuff below

[Vendor page](https://ark.intel.com/content/www/us/en/ark/products/65523/intel-core-i7-3770k-processor-8m-cache-up-to-3-90-ghz.html)


We use about 5.000x5.000 cells per OS thread


## `partition_shape`

### `thread_cluster_node`
- 4 OS threads / NUMA node
- Experiment uses 4 OS threads
- array size = sqrt(4 * 5000^2) = 10.000x10.000


## `strong_scaling`

### `thread_cluster_node`
- 4 OS threads / cluster node
- Experiment scales over [1, 4] OS threads
- array size = sqrt(4 * 5000^2) = 10.000x10.000


## `weak_scaling`

### `thread_cluster_node`
- 4 OS threads / cluster node
- Experiment scales over [1, 4] OS threads
- array size = sqrt(1 * 5000^2) = 5.000x5.000
