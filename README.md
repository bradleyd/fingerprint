# Fingerprint

Fingerprint provides operating system utilities for profiling your host.

Fingerprint will do it's best to determine the os type and use the appropriate plugin to give you information

Currently information provieded consists of

* release (platform info)

* network

* block devices

* CPU

* Memory (in progess)


### Release (Platform)

```elixir
iex(1) Fingerprint.Release.release()
%Fingerprint.Plugins.Linux.Release.Attributes{architecture: "x86_64",
 hostname: "bradleyd-900X4C", id: "ubuntu", kernel_version: "4.10.0-20-generic",
 name: "Ubuntu", pretty_name: "Ubuntu 17.04", version: "17.04 (Zesty Zapus)"}
```

### Network

```elixir
iex(1)> Fingerprint.Network.addresses()
[%Fingerprint.Plugins.Linux.Network.Attributes{address: "FE80::44E5:94FF:FE4D:91C8",
  device: "vethf25e7d7", flags: [:up, :broadcast, :running, :multicast],
  netmask: "FFFF:FFFF:FFFF:FFFF::"},
 %Fingerprint.Plugins.Linux.Network.Attributes{address: "FE80::A019:36FF:FEE5:6ABE",
  device: "vethdb5cb6e", flags: [:up, :broadcast, :running, :multicast],
  netmask: "FFFF:FFFF:FFFF:FFFF::"},
 %Fingerprint.Plugins.Linux.Network.Attributes{address: "172.17.42.1",
  device: "docker0", flags: [:up, :broadcast, :running, :multicast],
  netmask: "255.255.0.0"},
 %Fingerprint.Plugins.Linux.Network.Attributes{address: nil,
  device: "virbr0-nic", flags: [:broadcast, :multicast], netmask: nil},
 %Fingerprint.Plugins.Linux.Network.Attributes{address: "192.168.122.1",
  device: "virbr0", flags: [:up, :broadcast, :running, :multicast],
  netmask: "255.255.255.0"},
 %Fingerprint.Plugins.Linux.Network.Attributes{address: "10.0.3.1",
  device: "lxcbr0", flags: [:up, :broadcast, :running, :multicast],
  netmask: "255.255.255.0"},
 %Fingerprint.Plugins.Linux.Network.Attributes{address: "192.168.1.31",
  device: "wlan0", flags: [:up, :broadcast, :running, :multicast],
  netmask: "255.255.255.0"},
 %Fingerprint.Plugins.Linux.Network.Attributes{address: nil, device: "eth0",
  flags: [:up, :broadcast, :running, :multicast], netmask: nil},
 %Fingerprint.Plugins.Linux.Network.Attributes{address: "127.0.0.1",
  device: "lo", flags: [:up, :loopback, :running], netmask: "255.0.0.0"}]
```

### Block Devices

```elixir
iex(1)> Fingerprint.BlockDevices.all()
[%Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "dm-0",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "0",
  size: "233390080", state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "dm-1",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "0", size: "16171008",
  state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "loop0",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "1", size: "0",
  state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "loop1",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "1", size: "0",
  state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "loop2",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "1", size: "0",
  state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "loop3",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "1", size: "0",
  state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "loop4",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "1", size: "0",
  state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "loop5",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "1", size: "0",
  state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "loop6",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "1", size: "0",
  state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "loop7",
  logical_block_size: "512", model: nil, physical_block_size: "512",
  queue_depth: nil, removable: "0", rev: nil, rotational: "1", size: "0",
  state: nil, timeout: nil, vendor: nil},
 %Fingerprint.Plugins.Linux.BlockDevices.Attributes{device: "sda",
  logical_block_size: "512", model: "SanDisk SSD U100",
  physical_block_size: "512", queue_depth: "31", removable: "0", rev: "6.04",
  rotational: "0", size: "250069680", state: "running", timeout: "30",
  vendor: "ATA"}]
```

### CPU

### Memory


### TODO

* more tests

* add more system information

* add more platforms other than linux

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

