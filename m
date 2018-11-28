From: gokul cg <gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: PCI passthrough with multiple devices in same iommu group
Date: Wed, 28 Nov 2018 20:21:02 +0530
Message-ID: <CAFP4jM9xWFcNjJCcedVngvRMV3SHPipzpukbP0+mvZwayKs=RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1684523018520441553=="
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
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1684523018520441553==
Content-Type: multipart/alternative; boundary="000000000000042ac1057bbaab6e"

--000000000000042ac1057bbaab6e
Content-Type: text/plain; charset="UTF-8"

Hi Folks,

Please excuse me , I just writing to you as i could see you had made
changes regarding iommu and I thought you could give help me here.

We are testing visualization with QEMU-2.7.0 + Linux-4.8+, we are facing
issue while configuring pass through PCI devices in QEMU to pass it to
guest OS.
We are using following QEMU argument to configure PCI device as passthrough
device to guest, which was working with Linux 3.10 distro (hypervisor: QEMU
1.7.2, Linux:  3.10+).

/usr/bin/qemu-system-x86_64 -name guest_1 -S -machine
pc-i440fx-1.7,accel=kvm,usb=off -m 49152    \
 -device kvm-pci-assign,host=0000:00:1f.3 -device
kvm-pci-assign,host=0000:09:0e.0  ..<etc..>

Here is the error message that we will get when we try to configure PCI
devices as passthrough using kvm pci assignment method in Linux 4.8+
(hypervisor: QEMU 2.7.0, Linux:  4.8+).

which is shown below.

---log---

>From QEMU:
qemu-system-x86_64: -device kvm-pci-assign,host=0000:00:1f.3: Failed to
assign device "(null)": Invalid argument

>From dmesg:
pci-stub 0000:00:1f.3: kvm assign device failed ret -22

---end----

Info about devices (CPU:  Intel(R) Xeon(R) CPU E5-2608L):

root@shining-node:~# lspci -k -s 00:1f.3
00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller
(rev 05)
        Subsystem: Intel Corporation C610/X99 series chipset SMBus
Controller
        Kernel driver in use: pci-stub
        Kernel modules: i2c_i801
root@shining-node:~#
root@shining-node:~# lspci -k -s  09:0e.0
09:0e.0 Network controller: Broadcom Limited Device b680 (rev 12)
root@shining-node:~#

>From the web search i could see that it is because there are multiple
devices in same iommu_group that the passthrough device belongs to.
When i check iommu_group , i have multiple devices in same group but all
those are intel devices under Wellsburg PCH.

root@shining-node:~# ls
/sys/bus/pci/devices/0000\:00\:1f.3/iommu_group/devices/
0000:00:1f.0  0000:00:1f.2  0000:00:1f.3  0000:00:1f.6
root@shining-node:~#
root@shining-node:~# lspci -v -s 0000:00:1f
00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC
Controller (rev 05)
Subsystem: Intel Corporation C610/X99 series chipset LPC Controller
Flags: bus master, medium devsel, latency 0, NUMA node 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel driver in use: lpc_ich
Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-Port
SATA Controller [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
Subsystem: Intel Corporation C610/X99 series chipset 6-Port SATA Controller
[AHCI mode]
Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 35, NUMA node 0
I/O ports at 3068 [size=8]
I/O ports at 3074 [size=4]
I/O ports at 3060 [size=8]
I/O ports at 3070 [size=4]
I/O ports at 3020 [size=32]
Memory at 91d20000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Capabilities: [70] Power Management version 3
Capabilities: [a8] SATA HBA v1.0
Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller
(rev 05)
Subsystem: Intel Corporation C610/X99 series chipset SMBus Controller
Flags: medium devsel, IRQ 18, NUMA node 0
Memory at 180000600000 (64-bit, non-prefetchable) [size=4K]
I/O ports at 3000 [size=32]
Kernel driver in use: pci-stub
Kernel modules: i2c_i801

00:1f.6 Signal processing controller: Intel Corporation C610/X99 series
chipset Thermal Subsystem (rev 05)
Subsystem: Intel Corporation C610/X99 series chipset Thermal Subsystem
Flags: bus master, fast devsel, latency 0, IRQ 255, NUMA node 0
Memory at 183fc0010000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [50] Power Management version 3
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-

root@shining-node:~#


I have tried ACS override patch to rearrange these devices to different
iommu_group and its not working for these devices.I have tried to
passthrough vfio method, vfio complains that it needs all driver to be vfio
compatible.

How can we achieve pci passthrough for Intel SMBus Controller [00:1f.3
here] with latest kernel(We use 4.8+ now)

Regards,
Gokul

--000000000000042ac1057bbaab6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div><div>Hi Folks,</div><div><=
br></div><div>Please excuse me , I just writing to you as i could see you h=
ad made changes regarding iommu and I thought you could give help me here.=
=C2=A0</div><div><br></div><div>We are testing visualization with QEMU-2.7.=
0 + Linux-4.8+, we are facing issue while configuring pass through PCI devi=
ces in QEMU to pass it to guest OS.</div><div>We are using following QEMU a=
rgument to configure PCI device as passthrough device to guest, which was w=
orking with Linux 3.10 distro (hypervisor: QEMU 1.7.2, Linux:=C2=A0 3.10+).=
</div><div>=C2=A0</div><div>/usr/bin/qemu-system-x86_64 -name guest_1 -S -m=
achine pc-i440fx-1.7,accel=3Dkvm,usb=3Doff -m 49152=C2=A0 =C2=A0 \</div><di=
v>=C2=A0-device kvm-pci-assign,host=3D0000:00:1f.3 -device kvm-pci-assign,h=
ost=3D0000:09:0e.0=C2=A0 ..&lt;etc..&gt;</div><div>=C2=A0</div><div>Here is=
 the error message that we will get when we try to configure PCI devices as=
 passthrough using kvm pci assignment method in Linux 4.8+ (hypervisor: QEM=
U 2.7.0, Linux:=C2=A0 4.8+).</div><div><br></div><div>which is shown below.=
</div><div>=C2=A0</div><div>---log---=C2=A0</div><div>=C2=A0</div><div>From=
 QEMU:</div><div>qemu-system-x86_64: -device kvm-pci-assign,host=3D0000:00:=
1f.3: Failed to assign device &quot;(null)&quot;: Invalid argument</div><di=
v>=C2=A0</div><div>From dmesg:</div><div>pci-stub 0000:00:1f.3: kvm assign =
device failed ret -22</div><div><br></div><div>---end----</div><div><br></d=
iv><div>Info about devices (CPU:=C2=A0 Intel(R) Xeon(R) CPU E5-2608L):=C2=
=A0</div><div><br></div><div>root@shining-node:~# lspci -k -s 00:1f.3</div>=
<div>00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Control=
ler (rev 05)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subsystem: Intel Corpora=
tion C610/X99 series chipset SMBus Controller</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Kernel driver in use: pci-stub</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Kernel modules: i2c_i801</div><div>root@shining-node:~#</div><div>ro=
ot@shining-node:~# lspci -k -s=C2=A0 09:0e.0</div><div>09:0e.0 Network cont=
roller: Broadcom Limited Device b680 (rev 12)</div><div>root@shining-node:~=
#</div><div>=C2=A0</div><div>From the web search i could see that it is bec=
ause there are multiple devices in same iommu_group that the passthrough de=
vice belongs to.</div><div>When i check iommu_group , i have multiple devic=
es in same group but all those are intel devices under Wellsburg PCH.</div>=
<div><br></div><div>root@shining-node:~# ls /sys/bus/pci/devices/0000\:00\:=
1f.3/iommu_group/devices/</div><div>0000:00:1f.0=C2=A0 0000:00:1f.2=C2=A0 0=
000:00:1f.3=C2=A0 0000:00:1f.6</div><div>root@shining-node:~#</div><div>roo=
t@shining-node:~# lspci -v -s 0000:00:1f</div><div>00:1f.0 ISA bridge: Inte=
l Corporation C610/X99 series chipset LPC Controller (rev 05)</div><div><sp=
an style=3D"white-space:pre">	</span>Subsystem: Intel Corporation C610/X99 =
series chipset LPC Controller</div><div><span style=3D"white-space:pre">	</=
span>Flags: bus master, medium devsel, latency 0, NUMA node 0</div><div><sp=
an style=3D"white-space:pre">	</span>Capabilities: [e0] Vendor Specific Inf=
ormation: Len=3D0c &lt;?&gt;</div><div><span style=3D"white-space:pre">	</s=
pan>Kernel driver in use: lpc_ich</div><div><span style=3D"white-space:pre"=
>	</span>Kernel modules: lpc_ich</div><div><br></div><div>00:1f.2 SATA cont=
roller: Intel Corporation C610/X99 series chipset 6-Port SATA Controller [A=
HCI mode] (rev 05) (prog-if 01 [AHCI 1.0])</div><div><span style=3D"white-s=
pace:pre">	</span>Subsystem: Intel Corporation C610/X99 series chipset 6-Po=
rt SATA Controller [AHCI mode]</div><div><span style=3D"white-space:pre">	<=
/span>Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 35, NUMA node=
 0</div><div><span style=3D"white-space:pre">	</span>I/O ports at 3068 [siz=
e=3D8]</div><div><span style=3D"white-space:pre">	</span>I/O ports at 3074 =
[size=3D4]</div><div><span style=3D"white-space:pre">	</span>I/O ports at 3=
060 [size=3D8]</div><div><span style=3D"white-space:pre">	</span>I/O ports =
at 3070 [size=3D4]</div><div><span style=3D"white-space:pre">	</span>I/O po=
rts at 3020 [size=3D32]</div><div><span style=3D"white-space:pre">	</span>M=
emory at 91d20000 (32-bit, non-prefetchable) [size=3D2K]</div><div><span st=
yle=3D"white-space:pre">	</span>Capabilities: [80] MSI: Enable+ Count=3D1/1=
 Maskable- 64bit-</div><div><span style=3D"white-space:pre">	</span>Capabil=
ities: [70] Power Management version 3</div><div><span style=3D"white-space=
:pre">	</span>Capabilities: [a8] SATA HBA v1.0</div><div><span style=3D"whi=
te-space:pre">	</span>Kernel driver in use: ahci</div><div><br></div><div>0=
0:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller (r=
ev 05)</div><div><span style=3D"white-space:pre">	</span>Subsystem: Intel C=
orporation C610/X99 series chipset SMBus Controller</div><div><span style=
=3D"white-space:pre">	</span>Flags: medium devsel, IRQ 18, NUMA node 0</div=
><div><span style=3D"white-space:pre">	</span>Memory at 180000600000 (64-bi=
t, non-prefetchable) [size=3D4K]</div><div><span style=3D"white-space:pre">=
	</span>I/O ports at 3000 [size=3D32]</div><div><span style=3D"white-space:=
pre">	</span>Kernel driver in use: pci-stub</div><div><span style=3D"white-=
space:pre">	</span>Kernel modules: i2c_i801</div><div><br></div><div>00:1f.=
6 Signal processing controller: Intel Corporation C610/X99 series chipset T=
hermal Subsystem (rev 05)</div><div><span style=3D"white-space:pre">	</span=
>Subsystem: Intel Corporation C610/X99 series chipset Thermal Subsystem</di=
v><div><span style=3D"white-space:pre">	</span>Flags: bus master, fast devs=
el, latency 0, IRQ 255, NUMA node 0</div><div><span style=3D"white-space:pr=
e">	</span>Memory at 183fc0010000 (64-bit, non-prefetchable) [size=3D4K]</d=
iv><div><span style=3D"white-space:pre">	</span>Capabilities: [50] Power Ma=
nagement version 3</div><div><span style=3D"white-space:pre">	</span>Capabi=
lities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-</div><div><br></div>=
<div>root@shining-node:~#</div><div><br></div><div><br></div><div>I have tr=
ied ACS override patch to rearrange these devices to different iommu_group =
and its not working for these devices.I have tried to passthrough vfio meth=
od, vfio complains that it needs all driver to be vfio compatible.=C2=A0</d=
iv><div><br></div><div>How can we achieve pci passthrough for Intel SMBus C=
ontroller [00:1f.3=C2=A0 here] with latest kernel(We use 4.8+ now)</div><di=
v><br></div><div>Regards,</div><div>Gokul=C2=A0</div></div></div>

--000000000000042ac1057bbaab6e--

--===============1684523018520441553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1684523018520441553==--
