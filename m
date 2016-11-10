From: Will Deacon <will.deacon@arm.com>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Thu, 10 Nov 2016 02:01:31 +0000
Message-ID: <20161110020130.GA19108@arm.com>
References: <582371FB.2040808@redhat.com>
 <20161109192303.GD15676@cbox>
 <20161109203145.GO17771@arm.com>
 <20161109151709.74927f83@t450s.home>
 <20161109222522.GS17771@arm.com>
 <20161109162458.39594fdb@t450s.home>
 <20161109233847.GT17771@arm.com>
 <20161109165957.62c1eb61@t450s.home>
 <83b6440a-31eb-c1b4-642c-a4c311f37ef2@redhat.com>
 <20161109175517.174e7803@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161109175517.174e7803@t450s.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, drjones@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, benh@kernel.crashing.org, joro@8bytes.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, arnd@arndb.de, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, Don Dutile <ddutile@redhat.com>, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, tglx@linutronix.de, robin.murphy@arm.com, dwmw@amazon.co.uk, Christoffer Dall <christoffer.dall@linaro.org>, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 09, 2016 at 05:55:17PM -0700, Alex Williamson wrote:
> On Thu, 10 Nov 2016 01:14:42 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> > On 10/11/2016 00:59, Alex Williamson wrote:
> > > On Wed, 9 Nov 2016 23:38:50 +0000
> > > Will Deacon <will.deacon@arm.com> wrote:
> > >> On Wed, Nov 09, 2016 at 04:24:58PM -0700, Alex Williamson wrote:  
> > >>> The VFIO_IOMMU_MAP_DMA ioctl is a contract, the user ask to map a range
> > >>> of IOVAs to a range of virtual addresses for a given device.  If VFIO
> > >>> cannot reasonably fulfill that contract, it must fail.  It's up to QEMU
> > >>> how to manage the hotplug and what memory regions it asks VFIO to map
> > >>> for a device, but VFIO must reject mappings that it (or the SMMU by
> > >>> virtue of using the IOMMU API) know to overlap reserved ranges.  So I
> > >>> still disagree with the referenced statement.  Thanks,    
> > >>
> > >> I think that's a pity. Not only does it mean that both QEMU and the kernel
> > >> have more work to do (the former has to carve up its mapping requests,
> > >> whilst the latter has to check that it is indeed doing this), but it also
> > >> precludes the use of hugepage mappings on the IOMMU because of reserved
> > >> regions. For example, a 4k hole someplace may mean we can't put down 1GB
> > >> table entries for the guest memory in the SMMU.
> > >>
> > >> All this seems to do is add complexity and decrease performance. For what?
> > >> QEMU has to go read the reserved regions from someplace anyway. It's also
> > >> the way that VFIO works *today* on arm64 wrt reserved regions, it just has
> > >> no way to identify those holes at present.  
> > > 
> > > Sure, that sucks, but how is the alternative even an option?  The user
> > > asked to map something, we can't, if we allow that to happen now it's a
> > > bug.  Put the MSI doorbells somewhere that this won't be an issue.  If
> > > the platform has it fixed somewhere that this is an issue, don't use
> > > that platform.  The correctness of the interface is more important than
> > > catering to a poorly designed system layout IMO.  Thanks,  
> > 
> > Besides above problematic, I started to prototype the sysfs API. A first
> > issue I face is the reserved regions become global to the iommu instead
> > of characterizing the iommu_domain, ie. the "reserved_regions" attribute
> > file sits below an iommu instance (~
> > /sys/class/iommu/dmar0/intel-iommu/reserved_regions ||
> > /sys/class/iommu/arm-smmu0/arm-smmu/reserved_regions).
> > 
> > MSI reserved window can be considered global to the IOMMU. However PCIe
> > host bridge P2P regions rather are per iommu-domain.

I don't think we can treat them as per-domain, given that we want to
enumerate this stuff before we've decided to do a hotplug (and therefore
don't have a domain).

> > 
> > Do you confirm the attribute file should contain both global reserved
> > regions and all per iommu_domain reserved regions?
> > 
> > Thoughts?
> 
> I don't think we have any business describing IOVA addresses consumed
> by peer devices in an IOMMU sysfs file.  If it's a separate device it
> should be exposed by examining the rest of the topology.  Regions
> consumed by PCI endpoints and interconnects are already exposed in
> sysfs.  In fact, is this perhaps a more accurate model for these MSI
> controllers too?  Perhaps they should be exposed in the bus topology
> somewhere as consuming the IOVA range.  If DMA to an IOVA is consumed
> by an intermediate device before it hits the IOMMU vs not being
> translated as specified by the user at the IOMMU, I'm less inclined to
> call that something VFIO should reject.

Oh, so perhaps we've been talking past each other. In all of these cases,
the SMMU can translate the access if it makes it that far. The issue is
that not all accesses do make it that far, because they may be "consumed"
by another device, such as an MSI doorbell or another endpoint. In other
words, I don't envisage a scenario where e.g. some address range just
bypasses the SMMU straight to memory. I realise now that that's not clear
from the slides I presented.

> However, instantiating a VM
> with holes to account for every potential peer device seems like it
> borders on insanity.  Thanks,

Ok, so rather than having a list of reserved regions under the iommu node,
you're proposing that each region is attributed to the device that "owns"
(consumes) it? I think that can work, but we need to make sure that:

 (a) The topology is walkable from userspace (where do you start?)

 (b) It also works for platform (non-PCI) devices, that lack much in the
     way of bus hierarchy

 (c) It doesn't require Linux to have a driver bound to a device in order
     for the ranges consumed by that device to be advertised (again,
     more of an issue for non-PCI).

How is this currently advertised for PCI? I'd really like to use the same
scheme irrespective of the bus type.

Will
