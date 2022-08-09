## Loading and the xdp hook

---

To load the program using our own loader, simply issue this command:

```
sudo ./bodyguard_xdp_user --dev lo --skb-mode
Success: Loading XDP prog name:bodyguard_xdp_p(id:1780) on device:lo(ifindex:1)
```

OR

```
sudo ip link set lo xdpgeneric obj bodyguard_xdp_kern.o sec xdp
```

Loading it again will fail, as there is already a program loaded. This is because we use the xdp_flag XDP_FLAGS_UPDATE_IF_NOEXIST. This is good practice to avoid accidentally unloading an unrelated XDP program.

```
sudo ./bodyguard_xdp_user --dev lo --skb-mode
libbpf: Kernel error message: XDP program already attached
ERR: ifindex(1) link set xdp fd failed (16): Device or resource busy
Hint: XDP already loaded on device use --force to swap/replace
```

As the hint suggest, the option `--force` can be used to replace the existing XDP program.

```
sudo ./bodyguard_xdp_user --dev lo --skb-mode --force
Success: Loading XDP prog name:bodyguard_xdp_p(id:1788) on device:lo(ifindex:1)
```

You can list XDP programs on the device using different commands, and verify that the program ID is the same:

```
ip link list dev lo
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 xdpgeneric qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    prog/xdp id 1788
```

```
sudo bpftool net list dev lo
xdp:
lo(1) generic id 1788

tc:

flow_dissector:
```

To unload

```
sudo ip link set lo xdpgeneric off
```

OR

```
sudo ./bodyguard_xdp_user --unload --dev lo
```