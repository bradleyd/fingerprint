# Fingerprint

Fingerprint provides operating system utilities for profiling your host.

Fingerprint will do it's best to determine the OS type (platform) and use the appropriate plugin to give you information.

Currently, system information consists of:

* release (platform info)

* network

* block devices

* CPU (Needs refactoring)

* memory (in progess)

* filesystem (TODO)


#### This library is early on and should be used at your own risk.  The structure can and will change.


### Release (Platform)

```elixir
iex(1) Fingerprint.Release.release()
%{architecture: "x86_64", hostname: "bradleyd-900X4C", id: "ubuntu", kernel_version: "4.10.0-20-generic",
 name: "Ubuntu", pretty_name: "Ubuntu 17.04", version: "17.04 (Zesty Zapus)"}
```

### Network

```elixir
iex(1)> Fingerprint.Network.addresses()
[%{"address" => "FE80::FC54:FF:FECB:F782", "device" => "vnet0",
   "flags" => [:up, :broadcast, :running, :multicast],
   "netmask" => "FFFF:FFFF:FFFF:FFFF::"},
 %{"address" => "172.17.42.1", "device" => "docker0",
   "flags" => [:up, :broadcast, :running, :multicast],
   "netmask" => "255.255.0.0"},
 %{"address" => nil, "device" => "virbr0-nic",
   "flags" => [:broadcast, :multicast], "netmask" => nil},
 %{"address" => "192.168.122.1", "device" => "virbr0",
   "flags" => [:up, :broadcast, :running, :multicast],
   "netmask" => "255.255.255.0"},
 %{"address" => "10.0.3.1", "device" => "lxcbr0",
   "flags" => [:up, :broadcast, :running, :multicast],
   "netmask" => "255.255.255.0"},
 %{"address" => "192.168.1.31", "device" => "wlan0",
   "flags" => [:up, :broadcast, :running, :multicast],
   "netmask" => "255.255.255.0"},
 %{"address" => nil, "device" => "eth0",
   "flags" => [:up, :broadcast, :running, :multicast], "netmask" => nil},
 %{"address" => "127.0.0.1", "device" => "lo",
   "flags" => [:up, :loopback, :running], "netmask" => "255.0.0.0"}]
```

### Block Devices

```elixir
iex(1)> Fingerprint.BlockDevices.all()
[%{"device" => "dm-0", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "0",
   "size" => "233390080"},
 %{"device" => "dm-1", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "0",
   "size" => "16171008"},
 %{"device" => "loop0", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
   "size" => "0"},
 %{"device" => "loop1", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
   "size" => "0"},
 %{"device" => "loop2", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
   "size" => "0"},
 %{"device" => "loop3", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
   "size" => "0"},
 %{"device" => "loop4", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
   "size" => "0"},
 %{"device" => "loop5", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
   "size" => "0"},
 %{"device" => "loop6", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
   "size" => "0"},
 %{"device" => "loop7", "logical_block_size" => "512",
   "physical_block_size" => "512", "removable" => "0", "rotational" => "1",
   "size" => "0"},
 %{"device" => "sda", "logical_block_size" => "512",
   "model" => "SanDisk SSD U100", "physical_block_size" => "512",
   "queue_depth" => "31", "removable" => "0", "rev" => "6.04",
   "rotational" => "0", "size" => "250069680", "state" => "running",
   "timeout" => "30", "vendor" => "ATA"}]
```

### CPU

```elixir
iex> Fingerprint.Plugins.Linux.Cpu.info()
%{"bogomips" => "3392.31", "cache_size" => "3072 KB", "count" => 4, "cpu_cores" => "2", "cpu_family" => "6", "cpu_mhz" => "799.987", "flags" => "fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm epb tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms xsaveopt dtherm ida arat pln pts", "id" => "GenuineIntel", "model" => "58", "model_name" => "Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz", "stepping" => "9"}
```

### Memory

```elixir
iex(2)> Fingerprint.Memory.all
%{"Active" => 4467888, "Hugepagesize" => 2048, "VmallocTotal" => 34359738367,
  "ShmemPmdMapped" => 0, "Mlocked" => 4876, "SwapCached" => 380, "Dirty" => 316,
  "SwapFree" => 8065520, "Inactive" => 2695824, "CmaFree" => 0,
  "MemTotal" => 7869508, "Unevictable" => 4876, "Slab" => 282932,
  "Active(file)" => 1136516, "HardwareCorrupted" => 0, "Writeback" => 0,
  "AnonHugePages" => 1875968, "VmallocUsed" => 0, "Shmem" => 591500,
  "HugePages_Rsvd" => 0, "Buffers" => 722516, "Mapped" => 796444,
  "DirectMap4k" => 303028, "CommitLimit" => 12020252, "HugePages_Total" => 0,
  "WritebackTmp" => 0, "HugePages_Surp" => 0, "Inactive(anon)" => 1458856,
  "KernelStack" => 17344, "DirectMap2M" => 7780352, "ShmemHugePages" => 0,
  "Bounce" => 0, "Active(anon)" => 3331372, "SReclaimable" => 157716,
  "CmaTotal" => 0, "VmallocChunk" => 0, "NFS_Unstable" => 0,
  "MemAvailable" => 2481728, "PageTables" => 74504, "Cached" => 2242468,
  "SwapTotal" => 8085500, "Committed_AS" => 13903064, "AnonPages" => 3972852,
  "Inactive(file)" => 1236968, "SUnreclaim" => 125216, "MemFree" => 248788,
  "HugePages_Free" => 0}
```

### TODO

* more tests

* wrap memory in a struct

* wrap CPU in a struct

* add more system information

* add more platforms other than linux

## Contributors

I need tons of help.  If this project interests you please submit a pull request.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fingerprint` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:fingerprint, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fingerprint](https://hexdocs.pm/fingerprint).

