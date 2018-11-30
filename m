From: gokul cg <gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCI passthrough with multiple devices in same iommu group
Date: Fri, 30 Nov 2018 12:04:26 +0530
Message-ID: <CAFP4jM9218pEQnkxR-k-Ti0t4U0X4nToKbEqREiwK_cZAm=MGA@mail.gmail.com>
References: <CAFP4jM9xWFcNjJCcedVngvRMV3SHPipzpukbP0+mvZwayKs=RA@mail.gmail.com>
	<20181128082619.26cd9242@x1.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1185176155608923742=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181128082619.26cd9242-hfcDOgR9qeA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1185176155608923742==
Content-Type: multipart/alternative; boundary="00000000000082691f057bdbf6b5"

--00000000000082691f057bdbf6b5
Content-Type: text/plain; charset="UTF-8"

Thanks for info

See inline
On Wed, Nov 28, 2018 at 8:56 PM Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
wrote:

> On Wed, 28 Nov 2018 20:21:02 +0530
> gokul cg <gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> > Hi Folks,
> >
> > Please excuse me , I just writing to you as i could see you had made
> > changes regarding iommu and I thought you could give help me here.
> >
> > We are testing visualization with QEMU-2.7.0 + Linux-4.8+, we are facing
> > issue while configuring pass through PCI devices in QEMU to pass it to
> > guest OS.
> > We are using following QEMU argument to configure PCI device as
> passthrough
> > device to guest, which was working with Linux 3.10 distro (hypervisor:
> QEMU
> > 1.7.2, Linux:  3.10+).
> >
> > /usr/bin/qemu-system-x86_64 -name guest_1 -S -machine
> > pc-i440fx-1.7,accel=kvm,usb=off -m 49152    \
> >  -device kvm-pci-assign,host=0000:00:1f.3 -device
> > kvm-pci-assign,host=0000:09:0e.0  ..<etc..>
>
> Legacy KVM device assignment (aka kvm-pci-assign) has been deprecated
> for some time now, you'll find it doesn't even exist in newer kernels
> and QEMU.
>
> Understood .

> > Here is the error message that we will get when we try to configure PCI
> > devices as passthrough using kvm pci assignment method in Linux 4.8+
> > (hypervisor: QEMU 2.7.0, Linux:  4.8+).
> >
> > which is shown below.
> >
> > ---log---
> >
> > From QEMU:
> > qemu-system-x86_64: -device kvm-pci-assign,host=0000:00:1f.3: Failed to
> > assign device "(null)": Invalid argument
> >
> > From dmesg:
> > pci-stub 0000:00:1f.3: kvm assign device failed ret -22
> >
> > ---end----
> >
> > Info about devices (CPU:  Intel(R) Xeon(R) CPU E5-2608L):
> >
> > root@shining-node:~# lspci -k -s 00:1f.3
> > 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller
> > (rev 05)
> >         Subsystem: Intel Corporation C610/X99 series chipset SMBus
> > Controller
> >         Kernel driver in use: pci-stub
> >         Kernel modules: i2c_i801
>
> Why are you trying to assign an SMBus controller to a VM?
>
> We want guest of to read out eprom and sensor devices  and manage our
chassis .
Our i2c devices are connected to  Intel SMbus controller

> root@shining-node:~#
> > root@shining-node:~# lspci -k -s  09:0e.0
> > 09:0e.0 Network controller: Broadcom Limited Device b680 (rev 12)
> > root@shining-node:~#
> >
> > From the web search i could see that it is because there are multiple
> > devices in same iommu_group that the passthrough device belongs to.
> > When i check iommu_group , i have multiple devices in same group but all
> > those are intel devices under Wellsburg PCH.
>
> Nope, kvm-pci-assign doesn't make use of IOMMU groups, more likely just
> some state of disrepair as it's deprecated and replaced by vfio-pci,
> which does use iommu groups.  So iommu groups will be a problem, but
> not in the configuration you're attempting to use above.
>
>  The error i had pasted above "< pci-stub 0000:00:1f.3: kvm assign device
failed ret -22 >" is comming as iommu attach device
fails because of following check .
1094 int iommu_attach_device(struct iommu_domain *domain, struct device
*dev)
1095 {
1096         struct iommu_group *group;
1097         int ret;
1098
1099         group = iommu_group_get(dev);
1100         /* FIXME: Remove this when groups a mandatory for iommu
drivers */
1101         if (group == NULL)
1102                 return __iommu_attach_device(domain, dev);
1103

> > root@shining-node:~# ls
> > /sys/bus/pci/devices/0000\:00\:1f.3/iommu_group/devices/
> > 0000:00:1f.0  0000:00:1f.2  0000:00:1f.3  0000:00:1f.6
> > root@shining-node:~#
> > root@shining-node:~# lspci -v -s 0000:00:1f
> > 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC
> > Controller (rev 05)
> > Subsystem: Intel Corporation C610/X99 series chipset LPC Controller
> > Flags: bus master, medium devsel, latency 0, NUMA node 0
> > Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> > Kernel driver in use: lpc_ich
> > Kernel modules: lpc_ich
> >
> > 00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-Port
> > SATA Controller [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
> > Subsystem: Intel Corporation C610/X99 series chipset 6-Port SATA
> Controller
> > [AHCI mode]
> > Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 35, NUMA node 0
> > I/O ports at 3068 [size=8]
> > I/O ports at 3074 [size=4]
> > I/O ports at 3060 [size=8]
> > I/O ports at 3070 [size=4]
> > I/O ports at 3020 [size=32]
> > Memory at 91d20000 (32-bit, non-prefetchable) [size=2K]
> > Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > Capabilities: [70] Power Management version 3
> > Capabilities: [a8] SATA HBA v1.0
> > Kernel driver in use: ahci
> >
> > 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller
> > (rev 05)
> > Subsystem: Intel Corporation C610/X99 series chipset SMBus Controller
> > Flags: medium devsel, IRQ 18, NUMA node 0
> > Memory at 180000600000 (64-bit, non-prefetchable) [size=4K]
> > I/O ports at 3000 [size=32]
> > Kernel driver in use: pci-stub
> > Kernel modules: i2c_i801
> >
> > 00:1f.6 Signal processing controller: Intel Corporation C610/X99 series
> > chipset Thermal Subsystem (rev 05)
> > Subsystem: Intel Corporation C610/X99 series chipset Thermal Subsystem
> > Flags: bus master, fast devsel, latency 0, IRQ 255, NUMA node 0
> > Memory at 183fc0010000 (64-bit, non-prefetchable) [size=4K]
> > Capabilities: [50] Power Management version 3
> > Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>
> Again I have to ask, why are these things you'd want to pass to a VM?
> The SATA controller is the only reasonable thing to assign here, but
> can easily be replaced by a plugin card with proper isolation or the
> performance can be nearly matched with virtio devices.  These devices
> do not provide isolation between them therefore the assignment group is
> the full set of devices within the iommu group.
>
> This is our POC with one of our guest will have access to our sensor
devices . So need to do this .

> root@shining-node:~#
> >
> >
> > I have tried ACS override patch to rearrange these devices to different
> > iommu_group and its not working for these devices.I have tried to
> > passthrough vfio method, vfio complains that it needs all driver to be
> vfio
> > compatible.
> >
> > How can we achieve pci passthrough for Intel SMBus Controller [00:1f.3
> > here] with latest kernel(We use 4.8+ now)
>
> The only theoretically supported mechanism would be to assign all of
> the devices in the group to the VM, but you're putting the host system
> at risk by assigning system management controllers to a VM.

We don't wan't to   do this . We just need only SMBUS controller to be
passed to guest .

Again, why
> would you want to assign the SMBus controller to a VM?  The unsupported
> path is with the ACS override patch, using the multifunction option or
> specific vendor and device IDs.  Thanks,
>
> I tried "ACS override patch" with multifunction option and specific vendor
and device IDs.
But it didn't works for us. I don't know whether this grouping is based on
DMAR/RMRR configuration in BIOS.


> Alex
>

-Gokul

--00000000000082691f057bdbf6b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thanks for info=C2=A0<br><br>See inline=
=C2=A0<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Nov 28, 2018 =
at 8:56 PM Alex Williamson &lt;<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org=
">alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Wed, 28 Nov 2018 20:21:02 +0530<br>
gokul cg &lt;<a href=3D"mailto:gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">gokul=
jnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
<br>
&gt; Hi Folks,<br>
&gt; <br>
&gt; Please excuse me , I just writing to you as i could see you had made<b=
r>
&gt; changes regarding iommu and I thought you could give help me here.<br>
&gt; <br>
&gt; We are testing visualization with QEMU-2.7.0 + Linux-4.8+, we are faci=
ng<br>
&gt; issue while configuring pass through PCI devices in QEMU to pass it to=
<br>
&gt; guest OS.<br>
&gt; We are using following QEMU argument to configure PCI device as passth=
rough<br>
&gt; device to guest, which was working with Linux 3.10 distro (hypervisor:=
 QEMU<br>
&gt; 1.7.2, Linux:=C2=A0 3.10+).<br>
&gt; <br>
&gt; /usr/bin/qemu-system-x86_64 -name guest_1 -S -machine<br>
&gt; pc-i440fx-1.7,accel=3Dkvm,usb=3Doff -m 49152=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 -device kvm-pci-assign,host=3D0000:00:1f.3 -device<br>
&gt; kvm-pci-assign,host=3D0000:09:0e.0=C2=A0 ..&lt;etc..&gt;<br>
<br>
Legacy KVM device assignment (aka kvm-pci-assign) has been deprecated<br>
for some time now, you&#39;ll find it doesn&#39;t even exist in newer kerne=
ls<br>
and QEMU.<br>
<br></blockquote><div>Understood .=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt; Here is the error message that we will get when we try to configure PC=
I<br>
&gt; devices as passthrough using kvm pci assignment method in Linux 4.8+<b=
r>
&gt; (hypervisor: QEMU 2.7.0, Linux:=C2=A0 4.8+).<br>
&gt; <br>
&gt; which is shown below.<br>
&gt; <br>
&gt; ---log---<br>
&gt; <br>
&gt; From QEMU:<br>
&gt; qemu-system-x86_64: -device kvm-pci-assign,host=3D0000:00:1f.3: Failed=
 to<br>
&gt; assign device &quot;(null)&quot;: Invalid argument<br>
&gt; <br>
&gt; From dmesg:<br>
&gt; pci-stub 0000:00:1f.3: kvm assign device failed ret -22<br>
&gt; <br>
&gt; ---end----<br>
&gt; <br>
&gt; Info about devices (CPU:=C2=A0 Intel(R) Xeon(R) CPU E5-2608L):<br>
&gt; <br>
&gt; root@shining-node:~# lspci -k -s 00:1f.3<br>
&gt; 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Control=
ler<br>
&gt; (rev 05)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Subsystem: Intel Corporation C610/X99=
 series chipset SMBus<br>
&gt; Controller<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Kernel driver in use: pci-stub<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Kernel modules: i2c_i801<br>
<br>
Why are you trying to assign an SMBus controller to a VM?<br>
<br></blockquote><div>We want guest of to read out eprom and sensor devices=
=C2=A0 and manage our chassis .</div><div>Our i2c devices are connected to=
=C2=A0 Intel SMbus controller=C2=A0</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; root@shining-node:~#<br>
&gt; root@shining-node:~# lspci -k -s=C2=A0 09:0e.0<br>
&gt; 09:0e.0 Network controller: Broadcom Limited Device b680 (rev 12)<br>
&gt; root@shining-node:~#<br>
&gt; <br>
&gt; From the web search i could see that it is because there are multiple<=
br>
&gt; devices in same iommu_group that the passthrough device belongs to.<br=
>
&gt; When i check iommu_group , i have multiple devices in same group but a=
ll<br>
&gt; those are intel devices under Wellsburg PCH.<br>
<br>
Nope, kvm-pci-assign doesn&#39;t make use of IOMMU groups, more likely just=
<br>
some state of disrepair as it&#39;s deprecated and replaced by vfio-pci,<br=
>
which does use iommu groups.=C2=A0 So iommu groups will be a problem, but<b=
r>
not in the configuration you&#39;re attempting to use above.<br>
<br></blockquote><div>=C2=A0The error i had pasted above &quot;&lt; pci-stu=
b 0000:00:1f.3: kvm assign device failed ret -22 &gt;&quot; is comming as i=
ommu attach device</div><div>fails because of following check .</div><div><=
div>1094 int iommu_attach_device(struct iommu_domain *domain, struct device=
 *dev)</div><div>1095 {</div><div>1096=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0str=
uct iommu_group *group;</div><div>1097=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int=
 ret;</div><div>1098</div><div>1099=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0group =
=3D iommu_group_get(dev);</div><div>1100=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* FIXME: Remove this when groups a mandatory for iommu drivers */</div><div=
>1101=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (group =3D=3D NULL)</div><div>110=
2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return __iom=
mu_attach_device(domain, dev);</div><div>1103</div></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; root@shining-node:~# ls<br>
&gt; /sys/bus/pci/devices/0000\:00\:1f.3/iommu_group/devices/<br>
&gt; 0000:00:1f.0=C2=A0 0000:00:1f.2=C2=A0 0000:00:1f.3=C2=A0 0000:00:1f.6<=
br>
&gt; root@shining-node:~#<br>
&gt; root@shining-node:~# lspci -v -s 0000:00:1f<br>
&gt; 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC<br>
&gt; Controller (rev 05)<br>
&gt; Subsystem: Intel Corporation C610/X99 series chipset LPC Controller<br=
>
&gt; Flags: bus master, medium devsel, latency 0, NUMA node 0<br>
&gt; Capabilities: [e0] Vendor Specific Information: Len=3D0c &lt;?&gt;<br>
&gt; Kernel driver in use: lpc_ich<br>
&gt; Kernel modules: lpc_ich<br>
&gt; <br>
&gt; 00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-P=
ort<br>
&gt; SATA Controller [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])<br>
&gt; Subsystem: Intel Corporation C610/X99 series chipset 6-Port SATA Contr=
oller<br>
&gt; [AHCI mode]<br>
&gt; Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 35, NUMA node =
0<br>
&gt; I/O ports at 3068 [size=3D8]<br>
&gt; I/O ports at 3074 [size=3D4]<br>
&gt; I/O ports at 3060 [size=3D8]<br>
&gt; I/O ports at 3070 [size=3D4]<br>
&gt; I/O ports at 3020 [size=3D32]<br>
&gt; Memory at 91d20000 (32-bit, non-prefetchable) [size=3D2K]<br>
&gt; Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-<br>
&gt; Capabilities: [70] Power Management version 3<br>
&gt; Capabilities: [a8] SATA HBA v1.0<br>
&gt; Kernel driver in use: ahci<br>
&gt; <br>
&gt; 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Control=
ler<br>
&gt; (rev 05)<br>
&gt; Subsystem: Intel Corporation C610/X99 series chipset SMBus Controller<=
br>
&gt; Flags: medium devsel, IRQ 18, NUMA node 0<br>
&gt; Memory at 180000600000 (64-bit, non-prefetchable) [size=3D4K]<br>
&gt; I/O ports at 3000 [size=3D32]<br>
&gt; Kernel driver in use: pci-stub<br>
&gt; Kernel modules: i2c_i801<br>
&gt; <br>
&gt; 00:1f.6 Signal processing controller: Intel Corporation C610/X99 serie=
s<br>
&gt; chipset Thermal Subsystem (rev 05)<br>
&gt; Subsystem: Intel Corporation C610/X99 series chipset Thermal Subsystem=
<br>
&gt; Flags: bus master, fast devsel, latency 0, IRQ 255, NUMA node 0<br>
&gt; Memory at 183fc0010000 (64-bit, non-prefetchable) [size=3D4K]<br>
&gt; Capabilities: [50] Power Management version 3<br>
&gt; Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-<br>
<br>
Again I have to ask, why are these things you&#39;d want to pass to a VM?<b=
r>
The SATA controller is the only reasonable thing to assign here, but<br>
can easily be replaced by a plugin card with proper isolation or the<br>
performance can be nearly matched with virtio devices.=C2=A0 These devices<=
br>
do not provide isolation between them therefore the assignment group is<br>
the full set of devices within the iommu group.<br>
<br></blockquote><div>This is our POC with one of our guest will have acces=
s to our sensor devices . So need to do this .=C2=A0</div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; root@shining-node:~#<br>
&gt; <br>
&gt; <br>
&gt; I have tried ACS override patch to rearrange these devices to differen=
t<br>
&gt; iommu_group and its not working for these devices.I have tried to<br>
&gt; passthrough vfio method, vfio complains that it needs all driver to be=
 vfio<br>
&gt; compatible.<br>
&gt; <br>
&gt; How can we achieve pci passthrough for Intel SMBus Controller [00:1f.3=
<br>
&gt; here] with latest kernel(We use 4.8+ now)<br>
<br>
The only theoretically supported mechanism would be to assign all of<br>
the devices in the group to the VM, but you&#39;re putting the host system<=
br>
at risk by assigning system management controllers to a VM.=C2=A0 </blockqu=
ote><div>We don&#39;t wan&#39;t to=C2=A0 =C2=A0do this . We just need only =
SMBUS controller to be passed to guest .</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Again, why<br>
would you want to assign the SMBus controller to a VM?=C2=A0 The unsupporte=
d<br>
path is with the ACS override patch, using the multifunction option or<br>
specific vendor and device IDs.=C2=A0 Thanks,<br>
<br></blockquote><div>I tried &quot;ACS override patch&quot; with multifunc=
tion option and specific vendor and device IDs.</div><div>But it didn&#39;t=
 works for us. I don&#39;t know whether this grouping is based on DMAR/RMRR=
 configuration in BIOS.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
Alex<br></blockquote><div><br></div><div>-Gokul=C2=A0=C2=A0</div></div></di=
v></div>

--00000000000082691f057bdbf6b5--

--===============1185176155608923742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1185176155608923742==--
