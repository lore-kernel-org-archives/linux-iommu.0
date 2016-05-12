From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
	remapping is supported
Date: Thu, 12 May 2016 01:19:44 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F850046@SHSMSX101.ccr.corp.intel.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
	<f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
	<e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
	<063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
	<4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F8474A4@SHSMSX101.ccr.corp.intel.com>
	<20160505090513.56886c12@t450s.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F84EEBA@SHSMSX101.ccr.corp.intel.com>
	<20160511095331.18436241@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160511095331.18436241-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org" <alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org>, "nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org" <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org" <ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>, Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org" <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Wednesday, May 11, 2016 11:54 PM
> 
> On Wed, 11 May 2016 06:29:06 +0000
> "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > > Sent: Thursday, May 05, 2016 11:05 PM
> > >
> > > On Thu, 5 May 2016 12:15:46 +0000
> > > "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > > > > From: Yongji Xie [mailto:xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org]
> > > > > Sent: Thursday, May 05, 2016 7:43 PM
> > > > >
> > > > > Hi David and Kevin,
> > > > >
> > > > > On 2016/5/5 17:54, David Laight wrote:
> > > > >
> > > > > > From: Tian, Kevin
> > > > > >> Sent: 05 May 2016 10:37
> > > > > > ...
> > > > > >>> Acutually, we are not aimed at accessing MSI-X table from
> > > > > >>> guest. So I think it's safe to passthrough MSI-X table if we
> > > > > >>> can make sure guest kernel would not touch MSI-X table in
> > > > > >>> normal code path such as para-virtualized guest kernel on PPC64.
> > > > > >>>
> > > > > >> Then how do you prevent malicious guest kernel accessing it?
> > > > > > Or a malicious guest driver for an ethernet card setting up
> > > > > > the receive buffer ring to contain a single word entry that
> > > > > > contains the address associated with an MSI-X interrupt and
> > > > > > then using a loopback mode to cause a specific packet be
> > > > > > received that writes the required word through that address.
> > > > > >
> > > > > > Remember the PCIe cycle for an interrupt is a normal memory write
> > > > > > cycle.
> > > > > >
> > > > > > 	David
> > > > > >
> > > > >
> > > > > If we have enough permission to load a malicious driver or
> > > > > kernel, we can easily break the guest without exposed
> > > > > MSI-X table.
> > > > >
> > > > > I think it should be safe to expose MSI-X table if we can
> > > > > make sure that malicious guest driver/kernel can't use
> > > > > the MSI-X table to break other guest or host. The
> > > > > capability of IRQ remapping could provide this
> > > > > kind of protection.
> > > > >
> > > >
> > > > With IRQ remapping it doesn't mean you can pass through MSI-X
> > > > structure to guest. I know actual IRQ remapping might be platform
> > > > specific, but at least for Intel VT-d specification, MSI-X entry must
> > > > be configured with a remappable format by host kernel which
> > > > contains an index into IRQ remapping table. The index will find a
> > > > IRQ remapping entry which controls interrupt routing for a specific
> > > > device. If you allow a malicious program random index into MSI-X
> > > > entry of assigned device, the hole is obvious...
> > > >
> > > > Above might make sense only for a IRQ remapping implementation
> > > > which doesn't rely on extended MSI-X format (e.g. simply based on
> > > > BDF). If that's the case for PPC, then you should build MSI-X
> > > > passthrough based on this fact instead of general IRQ remapping
> > > > enabled or not.
> > >
> > > I don't think anyone is expecting that we can expose the MSI-X vector
> > > table to the guest and the guest can make direct use of it.  The end
> > > goal here is that the guest on a power system is already
> > > paravirtualized to not program the device MSI-X by directly writing to
> > > the MSI-X vector table.  They have hypercalls for this since they
> > > always run virtualized.  Therefore a) they never intend to touch the
> > > MSI-X vector table and b) they have sufficient isolation that a guest
> > > can only hurt itself by doing so.
> > >
> > > On x86 we don't have a), our method of programming the MSI-X vector
> > > table is to directly write to it. Therefore we will always require QEMU
> > > to place a MemoryRegion over the vector table to intercept those
> > > accesses.  However with interrupt remapping, we do have b) on x86, which
> > > means that we don't need to be so strict in disallowing user accesses
> > > to the MSI-X vector table.  It's not useful for configuring MSI-X on
> > > the device, but the user should only be able to hurt themselves by
> > > writing it directly.  x86 doesn't really get anything out of this
> > > change, but it helps this special case on power pretty significantly
> > > aiui.  Thanks,
> > >
> >
> > Allowing guest direct write to MSI-x table has system-wide impact.
> > As I explained earlier, hypervisor needs to control "interrupt_index"
> > programmed in MSI-X entry, which is used to associate a specific
> > IRQ remapping entry. Now if you expose whole MSI-x table to guest,
> > it can program random index into MSI-X entry to associate with
> > any IRQ remapping entry and then there won't be any isolation per se.
> >
> > You can check "5.5.2 MSI and MSI-X Register Programming" in VT-d
> > spec.
> 
> I think you're extrapolating beyond the vfio interface.  The change
> here is to remove the vfio protection of the MSI-X vector table when
> the system provides interrupt isolation.  The argument is that this is
> safe to do because the hardware protects the host from erroneous and
> malicious user programming, but it is not meant to provide a means to
> program MSI-X directly through the vector table.  This is effectively

Sorry I didn't get this point. Once we allow userspace to mmap MSI-X
table, isn't it equivalent to allowing userspace directly program vector
table? Or is there other mechanism to prevent direct programming?

> the same as general DMA programming, if the vfio programming model is
> not followed the device generates iommu faults.  I do have a concern
> that userspace driver writers are going to more often presume they can
> use the vector table directly because of this change, but I don't know
> that that is sufficient reason to prevent such a change.  They'll
> quickly discover the device generates faults on interrupt rather than
> working as expected.

If userspace can actually program vector table directly, there is not
always fault triggered. As long as MSI-X table is fully under control
of userspace, any interrupt index can be used here which may link
to a IRQ remapping entry allocated for other devices.

> 
> The question of how this affects the hypervisor is completely
> separate.  Vfio in the kernel is a userspace driver interface, not a
> hypervisor.  QEMU is the hypervisor.  We have no plans to provide the VM
> with direct access to the MSI-X vector table for x86 guests on QEMU.
> There will still be a MemoryRegion emulating access to the vector table
> in order to translate writes into vfio interrupt ioctls.  POWER would
> drop the MemoryRegion so that the full page is mapped to the guest,
> with the expectation that the guest never makes use of it since MSI-X
> is always configured via hypercalls on POWER systems.  Likewise I
> expect ARM will still make use of the MemoryRegion emulating the vector
> table, which leaves them exposed to the performance issue POWER is
> trying to solve here since ARM also has 64k page support and has no
> paravirtualized MSI-X programming interface afaik.  x86 is not
> impervious to this issue either, but a 4k page size falls within the
> PCI spec recommendations for MSI-X structure alignment, so it's much
> more rare to have issues. We have certainly seen hardware vendors that
> ignore the PCI spec alignment recommendations, but so far only for
> placing device registers within the same page as the PBA, which is an
> easier problem to deal with since the PBA is relatively unused by
> drivers.  This may be an area where we need to develop a paravirt
> interface for MSI-X programming which disable the MemoryRegion
> emulating the vector table when used.  Thanks,
> 

I get this point. I incorrectly line allowing userspace mmap MSI-X
table to allowing guest direct access to MSI-X.

Thanks
Kevin
