From: gokul cg <gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCI passthrough with multiple devices in same iommu group
Date: Mon, 3 Dec 2018 16:48:39 +0530
Message-ID: <CAFP4jM9P5_om+f02oN8R_B2en3rPcJminf1at4dd-dV4S+3kgg@mail.gmail.com>
References: <CAFP4jM9xWFcNjJCcedVngvRMV3SHPipzpukbP0+mvZwayKs=RA@mail.gmail.com>
	<20181128082619.26cd9242@x1.home>
	<CAFP4jM9218pEQnkxR-k-Ti0t4U0X4nToKbEqREiwK_cZAm=MGA@mail.gmail.com>
	<20181130090505.364232b3@x1.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7688264762912580342=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181130090505.364232b3-hfcDOgR9qeA@public.gmane.org>
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

--===============7688264762912580342==
Content-Type: multipart/alternative; boundary="000000000000e52313057c1c4764"

--000000000000e52313057c1c4764
Content-Type: text/plain; charset="UTF-8"

Thanks for the info.

Yes. we need to do this as our architecture manages everything from one of
super privileged guest .
Rest of the guest don't have access to these devices .

Let me check with hardware vendor to see if we can segregate SMBus device
into separate  iommu group.

-Gokul
On Fri, Nov 30, 2018 at 9:35 PM Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
wrote:

> On Fri, 30 Nov 2018 12:04:26 +0530
> gokul cg <gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> > Thanks for info
> >
> > See inline
> > On Wed, Nov 28, 2018 at 8:56 PM Alex Williamson <
> alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > wrote:
> >
> > > On Wed, 28 Nov 2018 20:21:02 +0530
> > > gokul cg <gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > > > Hi Folks,
> > > >
> > > > Please excuse me , I just writing to you as i could see you had made
> > > > changes regarding iommu and I thought you could give help me here.
> > > >
> > > > We are testing visualization with QEMU-2.7.0 + Linux-4.8+, we are
> facing
> > > > issue while configuring pass through PCI devices in QEMU to pass it
> to
> > > > guest OS.
> > > > We are using following QEMU argument to configure PCI device as
> > > passthrough
> > > > device to guest, which was working with Linux 3.10 distro
> (hypervisor:
> > > QEMU
> > > > 1.7.2, Linux:  3.10+).
> > > >
> > > > /usr/bin/qemu-system-x86_64 -name guest_1 -S -machine
> > > > pc-i440fx-1.7,accel=kvm,usb=off -m 49152    \
> > > >  -device kvm-pci-assign,host=0000:00:1f.3 -device
> > > > kvm-pci-assign,host=0000:09:0e.0  ..<etc..>
> > >
> > > Legacy KVM device assignment (aka kvm-pci-assign) has been deprecated
> > > for some time now, you'll find it doesn't even exist in newer kernels
> > > and QEMU.
> > >
> > > Understood .
> >
> > > > Here is the error message that we will get when we try to configure
> PCI
> > > > devices as passthrough using kvm pci assignment method in Linux 4.8+
> > > > (hypervisor: QEMU 2.7.0, Linux:  4.8+).
> > > >
> > > > which is shown below.
> > > >
> > > > ---log---
> > > >
> > > > From QEMU:
> > > > qemu-system-x86_64: -device kvm-pci-assign,host=0000:00:1f.3: Failed
> to
> > > > assign device "(null)": Invalid argument
> > > >
> > > > From dmesg:
> > > > pci-stub 0000:00:1f.3: kvm assign device failed ret -22
> > > >
> > > > ---end----
> > > >
> > > > Info about devices (CPU:  Intel(R) Xeon(R) CPU E5-2608L):
> > > >
> > > > root@shining-node:~# lspci -k -s 00:1f.3
> > > > 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus
> Controller
> > > > (rev 05)
> > > >         Subsystem: Intel Corporation C610/X99 series chipset SMBus
> > > > Controller
> > > >         Kernel driver in use: pci-stub
> > > >         Kernel modules: i2c_i801
> > >
> > > Why are you trying to assign an SMBus controller to a VM?
> > >
> > > We want guest of to read out eprom and sensor devices  and manage our
> > chassis .
> > Our i2c devices are connected to  Intel SMbus controller
>
> It seems fundamentally unsafe to allow a user driver (where QEMU is
> just a userspace driver exposing the device into a VM) to manage the
> host chassis.  Additionally since this set of multifunction devices do
> not expose access control services, we must assume that untranslated
> DMA between the function is possible and thus group them together.  It
> would be up to the hardware vendor whether the devices are in fact DMA
> isolated to provide an ACS quirk to split this grouping.  Otherwise
> you'll need to provide that isolation as a downstream assumption.
>
> > > root@shining-node:~#
> > > > root@shining-node:~# lspci -k -s  09:0e.0
> > > > 09:0e.0 Network controller: Broadcom Limited Device b680 (rev 12)
> > > > root@shining-node:~#
> > > >
> > > > From the web search i could see that it is because there are multiple
> > > > devices in same iommu_group that the passthrough device belongs to.
> > > > When i check iommu_group , i have multiple devices in same group but
> all
> > > > those are intel devices under Wellsburg PCH.
> > >
> > > Nope, kvm-pci-assign doesn't make use of IOMMU groups, more likely just
> > > some state of disrepair as it's deprecated and replaced by vfio-pci,
> > > which does use iommu groups.  So iommu groups will be a problem, but
> > > not in the configuration you're attempting to use above.
> > >
> > >  The error i had pasted above "< pci-stub 0000:00:1f.3: kvm assign
> device
> > failed ret -22 >" is comming as iommu attach device
> > fails because of following check .
> > 1094 int iommu_attach_device(struct iommu_domain *domain, struct device
> > *dev)
> > 1095 {
> > 1096         struct iommu_group *group;
> > 1097         int ret;
> > 1098
> > 1099         group = iommu_group_get(dev);
> > 1100         /* FIXME: Remove this when groups a mandatory for iommu
> > drivers */
> > 1101         if (group == NULL)
> > 1102                 return __iommu_attach_device(domain, dev);
> > 1103
>
> Ah yes, I forget about this since legacy KVM device assignment has been
> deprecated for so long.
>
> > > > root@shining-node:~# ls
> > > > /sys/bus/pci/devices/0000\:00\:1f.3/iommu_group/devices/
> > > > 0000:00:1f.0  0000:00:1f.2  0000:00:1f.3  0000:00:1f.6
> > > > root@shining-node:~#
> > > > root@shining-node:~# lspci -v -s 0000:00:1f
> > > > 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC
> > > > Controller (rev 05)
> > > > Subsystem: Intel Corporation C610/X99 series chipset LPC Controller
> > > > Flags: bus master, medium devsel, latency 0, NUMA node 0
> > > > Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> > > > Kernel driver in use: lpc_ich
> > > > Kernel modules: lpc_ich
> > > >
> > > > 00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset
> 6-Port
> > > > SATA Controller [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
> > > > Subsystem: Intel Corporation C610/X99 series chipset 6-Port SATA
> > > Controller
> > > > [AHCI mode]
> > > > Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 35, NUMA
> node 0
> > > > I/O ports at 3068 [size=8]
> > > > I/O ports at 3074 [size=4]
> > > > I/O ports at 3060 [size=8]
> > > > I/O ports at 3070 [size=4]
> > > > I/O ports at 3020 [size=32]
> > > > Memory at 91d20000 (32-bit, non-prefetchable) [size=2K]
> > > > Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > Capabilities: [70] Power Management version 3
> > > > Capabilities: [a8] SATA HBA v1.0
> > > > Kernel driver in use: ahci
> > > >
> > > > 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus
> Controller
> > > > (rev 05)
> > > > Subsystem: Intel Corporation C610/X99 series chipset SMBus Controller
> > > > Flags: medium devsel, IRQ 18, NUMA node 0
> > > > Memory at 180000600000 (64-bit, non-prefetchable) [size=4K]
> > > > I/O ports at 3000 [size=32]
> > > > Kernel driver in use: pci-stub
> > > > Kernel modules: i2c_i801
> > > >
> > > > 00:1f.6 Signal processing controller: Intel Corporation C610/X99
> series
> > > > chipset Thermal Subsystem (rev 05)
> > > > Subsystem: Intel Corporation C610/X99 series chipset Thermal
> Subsystem
> > > > Flags: bus master, fast devsel, latency 0, IRQ 255, NUMA node 0
> > > > Memory at 183fc0010000 (64-bit, non-prefetchable) [size=4K]
> > > > Capabilities: [50] Power Management version 3
> > > > Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
> > >
> > > Again I have to ask, why are these things you'd want to pass to a VM?
> > > The SATA controller is the only reasonable thing to assign here, but
> > > can easily be replaced by a plugin card with proper isolation or the
> > > performance can be nearly matched with virtio devices.  These devices
> > > do not provide isolation between them therefore the assignment group is
> > > the full set of devices within the iommu group.
> > >
> > > This is our POC with one of our guest will have access to our sensor
> > devices . So need to do this .
>
> Your use case seems unique and unsafe from a generic userspace drive
> perspective.  You could possibly use the vfio mediated device interface
> to provide a host driver that polices userspace access to the device.
> This might not be too difficult if the device primarily uses a PIO
> rather than DMA interface.  Potentially some sort of generic i2c
> paravirtualization could also provide this.  For direct assignment, the
> grouping needs to be resolved, either upstream with hardware vendor
> isolation guarantees or downstream with custom patches.
>
> > > root@shining-node:~#
> > > >
> > > >
> > > > I have tried ACS override patch to rearrange these devices to
> different
> > > > iommu_group and its not working for these devices.I have tried to
> > > > passthrough vfio method, vfio complains that it needs all driver to
> be
> > > vfio
> > > > compatible.
> > > >
> > > > How can we achieve pci passthrough for Intel SMBus Controller
> [00:1f.3
> > > > here] with latest kernel(We use 4.8+ now)
> > >
> > > The only theoretically supported mechanism would be to assign all of
> > > the devices in the group to the VM, but you're putting the host system
> > > at risk by assigning system management controllers to a VM.
> >
> > We don't wan't to   do this . We just need only SMBUS controller to be
> > passed to guest .
> >
> > Again, why
> > > would you want to assign the SMBus controller to a VM?  The unsupported
> > > path is with the ACS override patch, using the multifunction option or
> > > specific vendor and device IDs.  Thanks,
> > >
> > > I tried "ACS override patch" with multifunction option and specific
> vendor
> > and device IDs.
> > But it didn't works for us. I don't know whether this grouping is based
> on
> > DMAR/RMRR configuration in BIOS.
>
> RMRRs would be yet another compounding problem, but AFAIK it would be
> unusual to have RMRRs on the SMBus device.  The override patch can
> certainly be made to work, but it's not upstream, not likely to ever
> get upstream, and not supported.  Thanks,
>
> Alex
>

--000000000000e52313057c1c4764
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the info.=C2=A0<br><br>Yes. we need to do this =
as our architecture manages everything from one of super privileged guest .=
<div>Rest of the guest don&#39;t have access to these devices .<br><br>Let =
me check with hardware vendor to see if we can segregate SMBus device into =
separate=C2=A0 iommu group.</div><div><br></div><div>-Gokul=C2=A0<br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr">On Fri, Nov 30, 2018 at 9:35 PM Alex =
Williamson &lt;<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">alex.williamso=
n@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri,=
 30 Nov 2018 12:04:26 +0530<br>
gokul cg &lt;<a href=3D"mailto:gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">gokul=
jnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
<br>
&gt; Thanks for info<br>
&gt; <br>
&gt; See inline<br>
&gt; On Wed, Nov 28, 2018 at 8:56 PM Alex Williamson &lt;<a href=3D"mailto:=
alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a=
>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Wed, 28 Nov 2018 20:21:02 +0530<br>
&gt; &gt; gokul cg &lt;<a href=3D"mailto:gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_bl=
ank">gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; Hi Folks,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please excuse me , I just writing to you as i could see you =
had made<br>
&gt; &gt; &gt; changes regarding iommu and I thought you could give help me=
 here.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We are testing visualization with QEMU-2.7.0 + Linux-4.8+, w=
e are facing<br>
&gt; &gt; &gt; issue while configuring pass through PCI devices in QEMU to =
pass it to<br>
&gt; &gt; &gt; guest OS.<br>
&gt; &gt; &gt; We are using following QEMU argument to configure PCI device=
 as=C2=A0 <br>
&gt; &gt; passthrough=C2=A0 <br>
&gt; &gt; &gt; device to guest, which was working with Linux 3.10 distro (h=
ypervisor:=C2=A0 <br>
&gt; &gt; QEMU=C2=A0 <br>
&gt; &gt; &gt; 1.7.2, Linux:=C2=A0 3.10+).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; /usr/bin/qemu-system-x86_64 -name guest_1 -S -machine<br>
&gt; &gt; &gt; pc-i440fx-1.7,accel=3Dkvm,usb=3Doff -m 49152=C2=A0 =C2=A0 \<=
br>
&gt; &gt; &gt;=C2=A0 -device kvm-pci-assign,host=3D0000:00:1f.3 -device<br>
&gt; &gt; &gt; kvm-pci-assign,host=3D0000:09:0e.0=C2=A0 ..&lt;etc..&gt;=C2=
=A0 <br>
&gt; &gt;<br>
&gt; &gt; Legacy KVM device assignment (aka kvm-pci-assign) has been deprec=
ated<br>
&gt; &gt; for some time now, you&#39;ll find it doesn&#39;t even exist in n=
ewer kernels<br>
&gt; &gt; and QEMU.<br>
&gt; &gt;<br>
&gt; &gt; Understood .=C2=A0 <br>
&gt; <br>
&gt; &gt; &gt; Here is the error message that we will get when we try to co=
nfigure PCI<br>
&gt; &gt; &gt; devices as passthrough using kvm pci assignment method in Li=
nux 4.8+<br>
&gt; &gt; &gt; (hypervisor: QEMU 2.7.0, Linux:=C2=A0 4.8+).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; which is shown below.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; ---log---<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From QEMU:<br>
&gt; &gt; &gt; qemu-system-x86_64: -device kvm-pci-assign,host=3D0000:00:1f=
.3: Failed to<br>
&gt; &gt; &gt; assign device &quot;(null)&quot;: Invalid argument<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From dmesg:<br>
&gt; &gt; &gt; pci-stub 0000:00:1f.3: kvm assign device failed ret -22<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; ---end----<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Info about devices (CPU:=C2=A0 Intel(R) Xeon(R) CPU E5-2608L=
):<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; root@shining-node:~# lspci -k -s 00:1f.3<br>
&gt; &gt; &gt; 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMB=
us Controller<br>
&gt; &gt; &gt; (rev 05)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Subsystem: Intel Corporatio=
n C610/X99 series chipset SMBus<br>
&gt; &gt; &gt; Controller<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Kernel driver in use: pci-s=
tub<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Kernel modules: i2c_i801=C2=
=A0 <br>
&gt; &gt;<br>
&gt; &gt; Why are you trying to assign an SMBus controller to a VM?<br>
&gt; &gt;<br>
&gt; &gt; We want guest of to read out eprom and sensor devices=C2=A0 and m=
anage our=C2=A0 <br>
&gt; chassis .<br>
&gt; Our i2c devices are connected to=C2=A0 Intel SMbus controller<br>
<br>
It seems fundamentally unsafe to allow a user driver (where QEMU is<br>
just a userspace driver exposing the device into a VM) to manage the<br>
host chassis.=C2=A0 Additionally since this set of multifunction devices do=
<br>
not expose access control services, we must assume that untranslated<br>
DMA between the function is possible and thus group them together.=C2=A0 It=
<br>
would be up to the hardware vendor whether the devices are in fact DMA<br>
isolated to provide an ACS quirk to split this grouping.=C2=A0 Otherwise<br=
>
you&#39;ll need to provide that isolation as a downstream assumption.<br>
<br>
&gt; &gt; root@shining-node:~#=C2=A0 <br>
&gt; &gt; &gt; root@shining-node:~# lspci -k -s=C2=A0 09:0e.0<br>
&gt; &gt; &gt; 09:0e.0 Network controller: Broadcom Limited Device b680 (re=
v 12)<br>
&gt; &gt; &gt; root@shining-node:~#<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From the web search i could see that it is because there are=
 multiple<br>
&gt; &gt; &gt; devices in same iommu_group that the passthrough device belo=
ngs to.<br>
&gt; &gt; &gt; When i check iommu_group , i have multiple devices in same g=
roup but all<br>
&gt; &gt; &gt; those are intel devices under Wellsburg PCH.=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; Nope, kvm-pci-assign doesn&#39;t make use of IOMMU groups, more l=
ikely just<br>
&gt; &gt; some state of disrepair as it&#39;s deprecated and replaced by vf=
io-pci,<br>
&gt; &gt; which does use iommu groups.=C2=A0 So iommu groups will be a prob=
lem, but<br>
&gt; &gt; not in the configuration you&#39;re attempting to use above.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 The error i had pasted above &quot;&lt; pci-stub 0000:00:1f=
.3: kvm assign device=C2=A0 <br>
&gt; failed ret -22 &gt;&quot; is comming as iommu attach device<br>
&gt; fails because of following check .<br>
&gt; 1094 int iommu_attach_device(struct iommu_domain *domain, struct devic=
e<br>
&gt; *dev)<br>
&gt; 1095 {<br>
&gt; 1096=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iommu_group *group;<br>
&gt; 1097=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; 1098<br>
&gt; 1099=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0group =3D iommu_group_get(dev);<=
br>
&gt; 1100=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME: Remove this when group=
s a mandatory for iommu<br>
&gt; drivers */<br>
&gt; 1101=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (group =3D=3D NULL)<br>
&gt; 1102=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn __iommu_attach_device(domain, dev);<br>
&gt; 1103<br>
<br>
Ah yes, I forget about this since legacy KVM device assignment has been<br>
deprecated for so long.<br>
<br>
&gt; &gt; &gt; root@shining-node:~# ls<br>
&gt; &gt; &gt; /sys/bus/pci/devices/0000\:00\:1f.3/iommu_group/devices/<br>
&gt; &gt; &gt; 0000:00:1f.0=C2=A0 0000:00:1f.2=C2=A0 0000:00:1f.3=C2=A0 000=
0:00:1f.6<br>
&gt; &gt; &gt; root@shining-node:~#<br>
&gt; &gt; &gt; root@shining-node:~# lspci -v -s 0000:00:1f<br>
&gt; &gt; &gt; 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipse=
t LPC<br>
&gt; &gt; &gt; Controller (rev 05)<br>
&gt; &gt; &gt; Subsystem: Intel Corporation C610/X99 series chipset LPC Con=
troller<br>
&gt; &gt; &gt; Flags: bus master, medium devsel, latency 0, NUMA node 0<br>
&gt; &gt; &gt; Capabilities: [e0] Vendor Specific Information: Len=3D0c &lt=
;?&gt;<br>
&gt; &gt; &gt; Kernel driver in use: lpc_ich<br>
&gt; &gt; &gt; Kernel modules: lpc_ich<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 00:1f.2 SATA controller: Intel Corporation C610/X99 series c=
hipset 6-Port<br>
&gt; &gt; &gt; SATA Controller [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])=
<br>
&gt; &gt; &gt; Subsystem: Intel Corporation C610/X99 series chipset 6-Port =
SATA=C2=A0 <br>
&gt; &gt; Controller=C2=A0 <br>
&gt; &gt; &gt; [AHCI mode]<br>
&gt; &gt; &gt; Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 35, =
NUMA node 0<br>
&gt; &gt; &gt; I/O ports at 3068 [size=3D8]<br>
&gt; &gt; &gt; I/O ports at 3074 [size=3D4]<br>
&gt; &gt; &gt; I/O ports at 3060 [size=3D8]<br>
&gt; &gt; &gt; I/O ports at 3070 [size=3D4]<br>
&gt; &gt; &gt; I/O ports at 3020 [size=3D32]<br>
&gt; &gt; &gt; Memory at 91d20000 (32-bit, non-prefetchable) [size=3D2K]<br=
>
&gt; &gt; &gt; Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-=
<br>
&gt; &gt; &gt; Capabilities: [70] Power Management version 3<br>
&gt; &gt; &gt; Capabilities: [a8] SATA HBA v1.0<br>
&gt; &gt; &gt; Kernel driver in use: ahci<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMB=
us Controller<br>
&gt; &gt; &gt; (rev 05)<br>
&gt; &gt; &gt; Subsystem: Intel Corporation C610/X99 series chipset SMBus C=
ontroller<br>
&gt; &gt; &gt; Flags: medium devsel, IRQ 18, NUMA node 0<br>
&gt; &gt; &gt; Memory at 180000600000 (64-bit, non-prefetchable) [size=3D4K=
]<br>
&gt; &gt; &gt; I/O ports at 3000 [size=3D32]<br>
&gt; &gt; &gt; Kernel driver in use: pci-stub<br>
&gt; &gt; &gt; Kernel modules: i2c_i801<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 00:1f.6 Signal processing controller: Intel Corporation C610=
/X99 series<br>
&gt; &gt; &gt; chipset Thermal Subsystem (rev 05)<br>
&gt; &gt; &gt; Subsystem: Intel Corporation C610/X99 series chipset Thermal=
 Subsystem<br>
&gt; &gt; &gt; Flags: bus master, fast devsel, latency 0, IRQ 255, NUMA nod=
e 0<br>
&gt; &gt; &gt; Memory at 183fc0010000 (64-bit, non-prefetchable) [size=3D4K=
]<br>
&gt; &gt; &gt; Capabilities: [50] Power Management version 3<br>
&gt; &gt; &gt; Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-=
=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; Again I have to ask, why are these things you&#39;d want to pass =
to a VM?<br>
&gt; &gt; The SATA controller is the only reasonable thing to assign here, =
but<br>
&gt; &gt; can easily be replaced by a plugin card with proper isolation or =
the<br>
&gt; &gt; performance can be nearly matched with virtio devices.=C2=A0 Thes=
e devices<br>
&gt; &gt; do not provide isolation between them therefore the assignment gr=
oup is<br>
&gt; &gt; the full set of devices within the iommu group.<br>
&gt; &gt;<br>
&gt; &gt; This is our POC with one of our guest will have access to our sen=
sor=C2=A0 <br>
&gt; devices . So need to do this .<br>
<br>
Your use case seems unique and unsafe from a generic userspace drive<br>
perspective.=C2=A0 You could possibly use the vfio mediated device interfac=
e<br>
to provide a host driver that polices userspace access to the device.<br>
This might not be too difficult if the device primarily uses a PIO<br>
rather than DMA interface.=C2=A0 Potentially some sort of generic i2c<br>
paravirtualization could also provide this.=C2=A0 For direct assignment, th=
e<br>
grouping needs to be resolved, either upstream with hardware vendor<br>
isolation guarantees or downstream with custom patches.<br>
<br>
&gt; &gt; root@shining-node:~#=C2=A0 <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I have tried ACS override patch to rearrange these devices t=
o different<br>
&gt; &gt; &gt; iommu_group and its not working for these devices.I have tri=
ed to<br>
&gt; &gt; &gt; passthrough vfio method, vfio complains that it needs all dr=
iver to be=C2=A0 <br>
&gt; &gt; vfio=C2=A0 <br>
&gt; &gt; &gt; compatible.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; How can we achieve pci passthrough for Intel SMBus Controlle=
r [00:1f.3<br>
&gt; &gt; &gt; here] with latest kernel(We use 4.8+ now)=C2=A0 <br>
&gt; &gt;<br>
&gt; &gt; The only theoretically supported mechanism would be to assign all=
 of<br>
&gt; &gt; the devices in the group to the VM, but you&#39;re putting the ho=
st system<br>
&gt; &gt; at risk by assigning system management controllers to a VM.=C2=A0=
 <br>
&gt; <br>
&gt; We don&#39;t wan&#39;t to=C2=A0 =C2=A0do this . We just need only SMBU=
S controller to be<br>
&gt; passed to guest .<br>
&gt; <br>
&gt; Again, why<br>
&gt; &gt; would you want to assign the SMBus controller to a VM?=C2=A0 The =
unsupported<br>
&gt; &gt; path is with the ACS override patch, using the multifunction opti=
on or<br>
&gt; &gt; specific vendor and device IDs.=C2=A0 Thanks,<br>
&gt; &gt;<br>
&gt; &gt; I tried &quot;ACS override patch&quot; with multifunction option =
and specific vendor=C2=A0 <br>
&gt; and device IDs.<br>
&gt; But it didn&#39;t works for us. I don&#39;t know whether this grouping=
 is based on<br>
&gt; DMAR/RMRR configuration in BIOS.<br>
<br>
RMRRs would be yet another compounding problem, but AFAIK it would be<br>
unusual to have RMRRs on the SMBus device.=C2=A0 The override patch can<br>
certainly be made to work, but it&#39;s not upstream, not likely to ever<br=
>
get upstream, and not supported.=C2=A0 Thanks,<br>
<br>
Alex<br>
</blockquote></div></div></div>

--000000000000e52313057c1c4764--

--===============7688264762912580342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7688264762912580342==--
