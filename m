From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC 05/11] iommu/dma: iommu_dma_(un)map_mixed
Date: Tue, 4 Oct 2016 19:37:40 +0200
Message-ID: <d6f0b5d1-8044-b121-14aa-7e6787582973@redhat.com>
References: <1475009318-2617-1-git-send-email-eric.auger@redhat.com>
 <1475009318-2617-6-git-send-email-eric.auger@redhat.com>
 <1b1b30b3-4199-9e18-362c-b8bc9d45277d@arm.com> <20161002095614.GA23218@cbox>
 <7474f131-9e44-bfde-6937-7cdbd6b2c8a5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7474f131-9e44-bfde-6937-7cdbd6b2c8a5@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>
Cc: eric.auger.pro@gmail.com, marc.zyngier@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, yehuday@marvell.com, Manish.Jaggi@caviumnetworks.com, Peter Maydell <peter.maydell@linaro.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 04/10/2016 19:18, Robin Murphy wrote:
> On 02/10/16 10:56, Christoffer Dall wrote:
>> On Fri, Sep 30, 2016 at 02:24:40PM +0100, Robin Murphy wrote:
>>> Hi Eric,
>>>
>>> On 27/09/16 21:48, Eric Auger wrote:
>>>> iommu_dma_map_mixed and iommu_dma_unmap_mixed operate on
>>>> IOMMU_DOMAIN_MIXED typed domains. On top of standard iommu_map/unmap
>>>> they reserve the IOVA window to prevent the iova allocator to
>>>> allocate in those areas.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>  drivers/iommu/dma-iommu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/dma-iommu.h | 18 ++++++++++++++++++
>>>>  2 files changed, 66 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>> index 04bbc85..db21143 100644
>>>> --- a/drivers/iommu/dma-iommu.c
>>>> +++ b/drivers/iommu/dma-iommu.c
>>>> @@ -759,3 +759,51 @@ int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
>>>>  	return 0;
>>>>  }
>>>>  EXPORT_SYMBOL(iommu_get_dma_msi_region_cookie);
>>>> +
>>>> +int iommu_dma_map_mixed(struct iommu_domain *domain, unsigned long iova,
>>>> +			phys_addr_t paddr, size_t size, int prot)
>>>> +{
>>>> +	struct iova_domain *iovad;
>>>> +	unsigned long lo, hi;
>>>> +	int ret;
>>>> +
>>>> +	if (domain->type != IOMMU_DOMAIN_MIXED)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (!domain->iova_cookie)
>>>> +		return -EINVAL;
>>>> +
>>>> +	iovad = cookie_iovad(domain);
>>>> +
>>>> +	lo = iova_pfn(iovad, iova);
>>>> +	hi = iova_pfn(iovad, iova + size - 1);
>>>> +	reserve_iova(iovad, lo, hi);
>>>
>>> This can't work reliably - reserve_iova() will (for good reason) merge
>>> any adjacent or overlapping entries, so any unmap is liable to free more
>>> IOVA space than actually gets unmapped, and things will get subtly out
>>> of sync and go wrong later.
>>>
>>> The more general issue with this whole approach, though, is that it
>>> effectively rules out userspace doing guest memory hotplug or similar,
>>> and I'm not we want to paint ourselves into that corner. Basically, as
>>> soon as a device is attached to a guest, the entirety of the unallocated
>>> IPA space becomes reserved, and userspace can never add anything further
>>> to it, because any given address *might* be in use for an MSI mapping.
>>
>> Ah, we didn't think of that when discussing this design at KVM Forum,
>> because the idea was that the IOVA allocator was in charge of that
>> resource, and the IOVA was a separate concept from the IPA space.
>>
>> I think what tripped us up, is that while the above is true for the MSI
>> configuration where we trap the bar and do the allocation at VFIO init
>> time, the guest device driver can program DMA to any address without
>> trapping, and therefore there's an inherent relationship between the
>> IOVA and the IPA space.  Is that right?
> 
> Yes, for anything the guest knows about and/or can touch directly, IOVA
> must equal IPA, or DMA is going to go horribly wrong. It's only direct
> interactions between device and host behind the guest's back where we
> (may) have some freedom with IOVA assignment.
> 
>>> I think it still makes most sense to stick with the original approach of
>>> cooperating with userspace to reserve a bounded area - it's just that we
>>> can then let automatic mapping take care of itself within that area.
>>
>> I was thinking that it's also possible to do it the other way around: To
>> let userspace say wherever memory may be hotplugged and do the
>> allocation within the remaining area, but I suppose that's pretty much
>> the same thing, and it should just depend on what's easiest to implement
>> and what userspace can best predict.
> 
> Indeed, if userspace *is* able to pre-emptively claim everything it
> might ever want, that does kind of implicitly solve the "tell me where I
> can put this" problem (assuming it doesn't simply claim the whole
> address space, of course), but I'm not so sure it works well if there
> are any specific restrictions (e.g. if some device is going to require
> the MSI range to be 32-bit addressable). It also fails to address the
> issue below...
> 
>>> Speaking of which, I've realised the same fundamental reservation
>>> problem already applies to PCI without ACS, regardless of MSIs. I just
>>> tried on my Juno with guest memory placed at 0x4000000000, (i.e.
>>> matching the host PA of the 64-bit PCI window), and sure enough when the
>>> guest kicks off some DMA on the passed-through NIC, the root complex
>>> interprets the guest IPA as (unsupported) peer-to-peer DMA to a BAR
>>> claimed by the video card, and it fails. I guess this doesn't get hit in
>>> practice on x86 because the guest memory map is unlikely to be much
>>> different from the host's.
>>>
>>> It seems like we basically need a general way of communicating fixed and
>>> movable host reservations to userspace :/
>>>
>>
>> Yes, this makes sense to me.   Do we have any existing way of
>> discovering this from userspace or can we think of something?
> 
> I know virtually nothing about the userspace interface, but I was under
> the impression it would require something new. I wasn't even aware you
> could do the VFIO-under-QEMU-TCG thing which Eric points out,
I meant running a non x86 VM on an x86 host. Quoting Alex:

"x86 isn't problem-free in this space.  An x86 VM is going to know that
the 0xfee00000 address range is special, it won't be backed by RAM and
won't be a DMA target, thus we'll never attempt to map it for an iova
address.  However, if we run a non-x86 VM or a userspace driver, it
doesn't necessarily know that there's anything special about that range
of iovas.  I intend to resolve this with an extension to the iommu info
ioctl that describes the available iova space for the iommu.  The
interrupt region would simply be excluded."

In my v12 I added such VFIO IOMMU info ioctl to retrieve the MSI
topology. Now for the issue you pointed out (PCI without ACS) I
understand this is a generalisation of the same issue and the VFIO IOMMU
info capability chain API could be used as well. I can submit something
separately. But anyway at QEMU level, due to the static mapping in
mach-virt, at the moment, we just can reject the assignment I am afraid.

Thanks

Eric

 so it
> seems like the general "tell userspace about addresses it can't use"
> issue is perhaps the more pressing one. On investigation, QEMU's static
> memory map with RAM at 0x4000000 is already busted for VFIO on Juno, as
> that results in attempting DMA to config space, which goes about as well
> as one might expect.
> 
> Robin.
> 
>>
>> Thanks,
>> -Christoffer
>>
> 
