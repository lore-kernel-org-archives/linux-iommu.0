From: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Subject: [BUG 4.1-rc4] i40e VF creation breaks vt-d
Date: Thu, 21 May 2015 13:33:28 +0200
Message-ID: <555DC288.5030108@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: "Williams, Mitch A" <mitch.a.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, jesse.brandeburg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

While trying to get a sense for performance of i40e and i40evf, I
figured I'd try and create a VF device on the host and activate it.
However, as soon as I brought the VF up, my host became unreachable. The
kernel is current 4.1-rc4.

Main network is connected through ixgbe (eth1), i40e is on a
direct-connect connection with another system. The host is an Intel
Haswell box with XAPIC and Vt-d enabled.

What I did was pretty simple:

$ echo 1 > /sys/devices/pci0000:80/0000:80:02.2/0000:82:00.0/sriov_numvfs
anderson:~/:[0]# ip a
[...]
2: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 qdisc mq state UP
group default qlen 1000
    link/ether 68:05:ca:30:dc:f8 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.2/24 brd 192.168.1.255 scope global eth3
       valid_lft forever preferred_lft forever
    inet6 fe80::6a05:caff:fe30:dcf8/64 scope link
       valid_lft forever preferred_lft forever
3: eth4: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
default qlen 1000
    link/ether 68:05:ca:30:dc:f9 brd ff:ff:ff:ff:ff:ff
4: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
group default qlen 1000
    link/ether a0:36:9f:24:43:bc brd ff:ff:ff:ff:ff:ff
    inet 10.161.16.35/18 brd 10.161.63.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 2620:113:80c0:8000:c::5ca/64 scope global dynamic
       valid_lft 2517977sec preferred_lft 530777sec
    inet6 fe80::a236:9fff:fe24:43bc/64 scope link
       valid_lft forever preferred_lft forever
5: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
default qlen 1000
    link/ether a0:36:9f:24:43:be brd ff:ff:ff:ff:ff:ff
6: eth3.vf0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
default qlen 1000
    link/ether a2:7a:bd:32:e0:21 brd ff:ff:ff:ff:ff:ff
$ ip addr del 192.168.1.2/24 dev eth3
$ ifconfig eth3.vf0 192.168.1.3 mtu 9000

After that network (on eth3) died. On the serial console I can see the
following:

[    0.000000] x2apic: enabled by BIOS, switching to x2apic ops
[...]
[    0.000000] Setting APIC routing to cluster x2apic.
[...]
[    0.560163] dmar: Host address width 46
[    0.568628] dmar: DRHD base: 0x000000c7ffc000 flags: 0x0
[    0.580361] dmar: IOMMU 0: reg_base_addr c7ffc000 ver 1:0 cap
d2078c106f0466 ecap f020df
[    0.598229] dmar: DRHD base: 0x000000e3ffc000 flags: 0x0
[    0.609957] dmar: IOMMU 1: reg_base_addr e3ffc000 ver 1:0 cap
d2078c106f0466 ecap f020df
[    0.627826] dmar: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.639554] dmar: IOMMU 2: reg_base_addr fbffc000 ver 1:0 cap
d2078c106f0466 ecap f020df
[    0.657422] dmar: DRHD base: 0x000000abffc000 flags: 0x1
[    0.669149] dmar: IOMMU 3: reg_base_addr abffc000 ver 1:0 cap
d2078c106f0466 ecap f020df
[    0.687020] dmar: RMRR base: 0x00000070d58000 end: 0x00000070d5afff
[    0.700859] dmar: ATSR flags: 0x0
[    0.708169] dmar: ATSR flags: 0x0
[    0.715479] dmar: ATSR flags: 0x0
[    0.722788] dmar: ATSR flags: 0x0
[    0.730101] IOAPIC id 12 under DRHD base  0xfbffc000 IOMMU 2
[    0.742592] IOAPIC id 11 under DRHD base  0xe3ffc000 IOMMU 1
[    0.755085] IOAPIC id 10 under DRHD base  0xc7ffc000 IOMMU 0
[    0.767577] IOAPIC id 8 under DRHD base  0xabffc000 IOMMU 3
[    0.779861] IOAPIC id 9 under DRHD base  0xabffc000 IOMMU 3
[    0.792145] HPET id 0 under DRHD base 0xabffc000
[    0.804579] Queued invalidation will be enabled to support x2apic and
Intr-remapping.
[    0.821902] Enabled IRQ remapping in x2apic mode
[...]
[    1.260956] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.

---- almost 2 days pass ----

[    9.061798] dmar: DRHD: handling fault status reg 2
[    9.072566] dmar: INTR-REMAP: Request device [[03:00.0] fault index 5e
[    9.072566] INTR-REMAP:[fault reason 34] Present field in the IRTE
entry is clear
[   20.835402] dmar: DRHD: handling fault status reg 102
[   20.846536] dmar: INTR-REMAP: Request device [[03:00.0] fault index 4b
[   20.846536] INTR-REMAP:[fault reason 34] Present field in the IRTE
entry is clear
[   80.219290] dmar: DRHD: handling fault status reg 202
[   80.230441] dmar: INTR-REMAP: Request device [[03:00.0] fault index 42
[   80.230441] INTR-REMAP:[fault reason 34] Present field in the IRTE
entry is clear
[   84.430008] dmar: DRHD: handling fault status reg 302
[   84.441159] dmar: INTR-REMAP: Request device [[03:00.0] fault index 48
[   84.441159] INTR-REMAP:[fault reason 34] Present field in the IRTE
entry is clear
[   89.019287] dmar: DRHD: handling fault status reg 402
[   89.030437] dmar: INTR-REMAP: Request device [[03:00.0] fault index 4f
[   89.030437] INTR-REMAP:[fault reason 34] Present field in the IRTE
entry is clear
[  105.350472] dmar: DRHD: handling fault status reg 502
[  105.361623] dmar: INTR-REMAP: Request device [[03:00.0] fault index 4e
[  105.361623] INTR-REMAP:[fault reason 34] Present field in the IRTE
entry is clear
[  149.464602] dmar: DRHD: handling fault status reg 602
[  149.475753] dmar: INTR-REMAP: Request device [[03:00.0] fault index 4a
[  149.475753] INTR-REMAP:[fault reason 34] Present field in the IRTE
entry is clear
[  641.689787] dmar: DRHD: handling fault status reg 2
[  641.700554] dmar: INTR-REMAP: Request device [[82:00.0] fault index 101
[  641.700554] INTR-REMAP:[fault reason 34] Present field in the IRTE
entry is clear


There are a few things striking me as weird. The first is obviously that
the messages above sound surprisingly close to Jiang Lui's patch when
using xapic vs x2apic.

The other thing that I can see above is that time is completely off. At
the point in time when I started up the VF, the system was already up
for almost 2 days. Why is time back to 9s on the first DMAR error
message? The messages also correlate to traffic on the network, so it's
probably an RX interrupt triggering.

Please let me know if there's any more detail that could be of help to
figure out what's going wrong.


Alex
