From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 05/11] iommu/dma: iommu_dma_(un)map_mixed
Date: Mon, 3 Oct 2016 11:38:02 +0200
Message-ID: <ea947436-95d4-807c-1720-1e26a60ddafb@redhat.com>
References: <1475009318-2617-1-git-send-email-eric.auger@redhat.com>
	<1475009318-2617-6-git-send-email-eric.auger@redhat.com>
	<1b1b30b3-4199-9e18-362c-b8bc9d45277d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1b1b30b3-4199-9e18-362c-b8bc9d45277d-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 30/09/2016 15:24, Robin Murphy wrote:
> Hi Eric,
> 
> On 27/09/16 21:48, Eric Auger wrote:
>> iommu_dma_map_mixed and iommu_dma_unmap_mixed operate on
>> IOMMU_DOMAIN_MIXED typed domains. On top of standard iommu_map/unmap
>> they reserve the IOVA window to prevent the iova allocator to
>> allocate in those areas.
>>
>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/iommu/dma-iommu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/dma-iommu.h | 18 ++++++++++++++++++
>>  2 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 04bbc85..db21143 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -759,3 +759,51 @@ int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(iommu_get_dma_msi_region_cookie);
>> +
>> +int iommu_dma_map_mixed(struct iommu_domain *domain, unsigned long iova,
>> +			phys_addr_t paddr, size_t size, int prot)
>> +{
>> +	struct iova_domain *iovad;
>> +	unsigned long lo, hi;
>> +	int ret;
>> +
>> +	if (domain->type != IOMMU_DOMAIN_MIXED)
>> +		return -EINVAL;
>> +
>> +	if (!domain->iova_cookie)
>> +		return -EINVAL;
>> +
>> +	iovad = cookie_iovad(domain);
>> +
>> +	lo = iova_pfn(iovad, iova);
>> +	hi = iova_pfn(iovad, iova + size - 1);
>> +	reserve_iova(iovad, lo, hi);
> 
> This can't work reliably - reserve_iova() will (for good reason) merge
> any adjacent or overlapping entries, so any unmap is liable to free more
> IOVA space than actually gets unmapped, and things will get subtly out
> of sync and go wrong later.
OK. I did not notice that.
> 
> The more general issue with this whole approach, though, is that it
> effectively rules out userspace doing guest memory hotplug or similar,
> and I'm not we want to paint ourselves into that corner. Basically, as
> soon as a device is attached to a guest, the entirety of the unallocated
> IPA space becomes reserved, and userspace can never add anything further
> to it, because any given address *might* be in use for an MSI mapping.
I fully agree. My bad, I mixed up about how/when the PCI MMIO space was
iommu mapped. So we don't have any other solution than having the guest
providing unused and non reserved GPA. Back to the original approach then.
> 
> I think it still makes most sense to stick with the original approach of
> cooperating with userspace to reserve a bounded area - it's just that we
> can then let automatic mapping take care of itself within that area.
OK will respin asap.
> 
> Speaking of which, I've realised the same fundamental reservation
> problem already applies to PCI without ACS, regardless of MSIs. I just
> tried on my Juno with guest memory placed at 0x4000000000, (i.e.
> matching the host PA of the 64-bit PCI window), and sure enough when the
> guest kicks off some DMA on the passed-through NIC, the root complex
> interprets the guest IPA as (unsupported) peer-to-peer DMA to a BAR
> claimed by the video card, and it fails. I guess this doesn't get hit in
> practice on x86 because the guest memory map is unlikely to be much
> different from the host's.
> 
> It seems like we basically need a general way of communicating fixed and
> movable host reservations to userspace :/

Yes I saw "iommu/dma: Avoid PCI host bridge windows". Well this looks
like a generalisation of the MSI geometry issue (they also face this one
on x86 with a non x86 guest). This will also hit the fact that on QEMU
the ARM guest memory map is static.

Thank you for your time

Best Regards

Eric
> 
> Robin.
> 
>> +	ret = iommu_map(domain, iova, paddr, size, prot);
>> +	if (ret)
>> +		free_iova(iovad, lo);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(iommu_dma_map_mixed);
>> +
>> +size_t iommu_dma_unmap_mixed(struct iommu_domain *domain, unsigned long iova,
>> +			     size_t size)
>> +{
>> +	struct iova_domain *iovad;
>> +	unsigned long lo;
>> +	size_t ret;
>> +
>> +	if (domain->type != IOMMU_DOMAIN_MIXED)
>> +		return -EINVAL;
>> +
>> +	if (!domain->iova_cookie)
>> +		return -EINVAL;
>> +
>> +	iovad = cookie_iovad(domain);
>> +	lo = iova_pfn(iovad, iova);
>> +
>> +	ret = iommu_unmap(domain, iova, size);
>> +	if (ret == size)
>> +		free_iova(iovad, lo);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(iommu_dma_unmap_mixed);
>> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
>> index 1c55413..f2aa855 100644
>> --- a/include/linux/dma-iommu.h
>> +++ b/include/linux/dma-iommu.h
>> @@ -70,6 +70,12 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>>  int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
>>  		dma_addr_t base, u64 size);
>>  
>> +int iommu_dma_map_mixed(struct iommu_domain *domain, unsigned long iova,
>> +			phys_addr_t paddr, size_t size, int prot);
>> +
>> +size_t iommu_dma_unmap_mixed(struct iommu_domain *domain, unsigned long iova,
>> +			     size_t size);
>> +
>>  #else
>>  
>>  struct iommu_domain;
>> @@ -99,6 +105,18 @@ static inline int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
>>  	return -ENODEV;
>>  }
>>  
>> +int iommu_dma_map_mixed(struct iommu_domain *domain, unsigned long iova,
>> +			phys_addr_t paddr, size_t size, int prot)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +size_t iommu_dma_unmap_mixed(struct iommu_domain *domain, unsigned long iova,
>> +			     size_t size)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>>  #endif	/* CONFIG_IOMMU_DMA */
>>  #endif	/* __KERNEL__ */
>>  #endif	/* __DMA_IOMMU_H */
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
