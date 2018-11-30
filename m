From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PCI passthrough with multiple devices in same iommu group
Date: Fri, 30 Nov 2018 09:05:05 -0700
Message-ID: <20181130090505.364232b3@x1.home>
References: <CAFP4jM9xWFcNjJCcedVngvRMV3SHPipzpukbP0+mvZwayKs=RA@mail.gmail.com>
	<20181128082619.26cd9242@x1.home>
	<CAFP4jM9218pEQnkxR-k-Ti0t4U0X4nToKbEqREiwK_cZAm=MGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFP4jM9218pEQnkxR-k-Ti0t4U0X4nToKbEqREiwK_cZAm=MGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: gokul cg <gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 30 Nov 2018 12:04:26 +0530
gokul cg <gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Thanks for info
> 
> See inline
> On Wed, Nov 28, 2018 at 8:56 PM Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> wrote:
> 
> > On Wed, 28 Nov 2018 20:21:02 +0530
> > gokul cg <gokuljnpr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >  
> > > Hi Folks,
> > >
> > > Please excuse me , I just writing to you as i could see you had made
> > > changes regarding iommu and I thought you could give help me here.
> > >
> > > We are testing visualization with QEMU-2.7.0 + Linux-4.8+, we are facing
> > > issue while configuring pass through PCI devices in QEMU to pass it to
> > > guest OS.
> > > We are using following QEMU argument to configure PCI device as  
> > passthrough  
> > > device to guest, which was working with Linux 3.10 distro (hypervisor:  
> > QEMU  
> > > 1.7.2, Linux:  3.10+).
> > >
> > > /usr/bin/qemu-system-x86_64 -name guest_1 -S -machine
> > > pc-i440fx-1.7,accel=kvm,usb=off -m 49152    \
> > >  -device kvm-pci-assign,host=0000:00:1f.3 -device
> > > kvm-pci-assign,host=0000:09:0e.0  ..<etc..>  
> >
> > Legacy KVM device assignment (aka kvm-pci-assign) has been deprecated
> > for some time now, you'll find it doesn't even exist in newer kernels
> > and QEMU.
> >
> > Understood .  
> 
> > > Here is the error message that we will get when we try to configure PCI
> > > devices as passthrough using kvm pci assignment method in Linux 4.8+
> > > (hypervisor: QEMU 2.7.0, Linux:  4.8+).
> > >
> > > which is shown below.
> > >
> > > ---log---
> > >
> > > From QEMU:
> > > qemu-system-x86_64: -device kvm-pci-assign,host=0000:00:1f.3: Failed to
> > > assign device "(null)": Invalid argument
> > >
> > > From dmesg:
> > > pci-stub 0000:00:1f.3: kvm assign device failed ret -22
> > >
> > > ---end----
> > >
> > > Info about devices (CPU:  Intel(R) Xeon(R) CPU E5-2608L):
> > >
> > > root@shining-node:~# lspci -k -s 00:1f.3
> > > 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller
> > > (rev 05)
> > >         Subsystem: Intel Corporation C610/X99 series chipset SMBus
> > > Controller
> > >         Kernel driver in use: pci-stub
> > >         Kernel modules: i2c_i801  
> >
> > Why are you trying to assign an SMBus controller to a VM?
> >
> > We want guest of to read out eprom and sensor devices  and manage our  
> chassis .
> Our i2c devices are connected to  Intel SMbus controller

It seems fundamentally unsafe to allow a user driver (where QEMU is
just a userspace driver exposing the device into a VM) to manage the
host chassis.  Additionally since this set of multifunction devices do
not expose access control services, we must assume that untranslated
DMA between the function is possible and thus group them together.  It
would be up to the hardware vendor whether the devices are in fact DMA
isolated to provide an ACS quirk to split this grouping.  Otherwise
you'll need to provide that isolation as a downstream assumption.

> > root@shining-node:~#  
> > > root@shining-node:~# lspci -k -s  09:0e.0
> > > 09:0e.0 Network controller: Broadcom Limited Device b680 (rev 12)
> > > root@shining-node:~#
> > >
> > > From the web search i could see that it is because there are multiple
> > > devices in same iommu_group that the passthrough device belongs to.
> > > When i check iommu_group , i have multiple devices in same group but all
> > > those are intel devices under Wellsburg PCH.  
> >
> > Nope, kvm-pci-assign doesn't make use of IOMMU groups, more likely just
> > some state of disrepair as it's deprecated and replaced by vfio-pci,
> > which does use iommu groups.  So iommu groups will be a problem, but
> > not in the configuration you're attempting to use above.
> >
> >  The error i had pasted above "< pci-stub 0000:00:1f.3: kvm assign device  
> failed ret -22 >" is comming as iommu attach device
> fails because of following check .
> 1094 int iommu_attach_device(struct iommu_domain *domain, struct device
> *dev)
> 1095 {
> 1096         struct iommu_group *group;
> 1097         int ret;
> 1098
> 1099         group = iommu_group_get(dev);
> 1100         /* FIXME: Remove this when groups a mandatory for iommu
> drivers */
> 1101         if (group == NULL)
> 1102                 return __iommu_attach_device(domain, dev);
> 1103

Ah yes, I forget about this since legacy KVM device assignment has been
deprecated for so long.

> > > root@shining-node:~# ls
> > > /sys/bus/pci/devices/0000\:00\:1f.3/iommu_group/devices/
> > > 0000:00:1f.0  0000:00:1f.2  0000:00:1f.3  0000:00:1f.6
> > > root@shining-node:~#
> > > root@shining-node:~# lspci -v -s 0000:00:1f
> > > 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC
> > > Controller (rev 05)
> > > Subsystem: Intel Corporation C610/X99 series chipset LPC Controller
> > > Flags: bus master, medium devsel, latency 0, NUMA node 0
> > > Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> > > Kernel driver in use: lpc_ich
> > > Kernel modules: lpc_ich
> > >
> > > 00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-Port
> > > SATA Controller [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
> > > Subsystem: Intel Corporation C610/X99 series chipset 6-Port SATA  
> > Controller  
> > > [AHCI mode]
> > > Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 35, NUMA node 0
> > > I/O ports at 3068 [size=8]
> > > I/O ports at 3074 [size=4]
> > > I/O ports at 3060 [size=8]
> > > I/O ports at 3070 [size=4]
> > > I/O ports at 3020 [size=32]
> > > Memory at 91d20000 (32-bit, non-prefetchable) [size=2K]
> > > Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > Capabilities: [70] Power Management version 3
> > > Capabilities: [a8] SATA HBA v1.0
> > > Kernel driver in use: ahci
> > >
> > > 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller
> > > (rev 05)
> > > Subsystem: Intel Corporation C610/X99 series chipset SMBus Controller
> > > Flags: medium devsel, IRQ 18, NUMA node 0
> > > Memory at 180000600000 (64-bit, non-prefetchable) [size=4K]
> > > I/O ports at 3000 [size=32]
> > > Kernel driver in use: pci-stub
> > > Kernel modules: i2c_i801
> > >
> > > 00:1f.6 Signal processing controller: Intel Corporation C610/X99 series
> > > chipset Thermal Subsystem (rev 05)
> > > Subsystem: Intel Corporation C610/X99 series chipset Thermal Subsystem
> > > Flags: bus master, fast devsel, latency 0, IRQ 255, NUMA node 0
> > > Memory at 183fc0010000 (64-bit, non-prefetchable) [size=4K]
> > > Capabilities: [50] Power Management version 3
> > > Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-  
> >
> > Again I have to ask, why are these things you'd want to pass to a VM?
> > The SATA controller is the only reasonable thing to assign here, but
> > can easily be replaced by a plugin card with proper isolation or the
> > performance can be nearly matched with virtio devices.  These devices
> > do not provide isolation between them therefore the assignment group is
> > the full set of devices within the iommu group.
> >
> > This is our POC with one of our guest will have access to our sensor  
> devices . So need to do this .

Your use case seems unique and unsafe from a generic userspace drive
perspective.  You could possibly use the vfio mediated device interface
to provide a host driver that polices userspace access to the device.
This might not be too difficult if the device primarily uses a PIO
rather than DMA interface.  Potentially some sort of generic i2c
paravirtualization could also provide this.  For direct assignment, the
grouping needs to be resolved, either upstream with hardware vendor
isolation guarantees or downstream with custom patches.

> > root@shining-node:~#  
> > >
> > >
> > > I have tried ACS override patch to rearrange these devices to different
> > > iommu_group and its not working for these devices.I have tried to
> > > passthrough vfio method, vfio complains that it needs all driver to be  
> > vfio  
> > > compatible.
> > >
> > > How can we achieve pci passthrough for Intel SMBus Controller [00:1f.3
> > > here] with latest kernel(We use 4.8+ now)  
> >
> > The only theoretically supported mechanism would be to assign all of
> > the devices in the group to the VM, but you're putting the host system
> > at risk by assigning system management controllers to a VM.  
> 
> We don't wan't to   do this . We just need only SMBUS controller to be
> passed to guest .
> 
> Again, why
> > would you want to assign the SMBus controller to a VM?  The unsupported
> > path is with the ACS override patch, using the multifunction option or
> > specific vendor and device IDs.  Thanks,
> >
> > I tried "ACS override patch" with multifunction option and specific vendor  
> and device IDs.
> But it didn't works for us. I don't know whether this grouping is based on
> DMAR/RMRR configuration in BIOS.

RMRRs would be yet another compounding problem, but AFAIK it would be
unusual to have RMRRs on the SMBus device.  The override patch can
certainly be made to work, but it's not upstream, not likely to ever
get upstream, and not supported.  Thanks,

Alex
