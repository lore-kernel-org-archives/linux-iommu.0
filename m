From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 05/13] iommu/io-pgtable-arm: Allow appropriate DMA API use
Date: Tue, 04 Aug 2015 15:47:13 +0100
Message-ID: <55C0D071.1040104@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
	<1438608355-7335-6-git-send-email-will.deacon@arm.com>
	<1652248.uq2uhTW4Yd@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1652248.uq2uhTW4Yd@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

[ +RMK, as his patch is indirectly involved here ]

On 04/08/15 14:16, Laurent Pinchart wrote:
> Hi Will and Robin,
>
> Thank you for the patch.
>
> On Monday 03 August 2015 14:25:47 Will Deacon wrote:
>> From: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
>>
>> Currently, users of the LPAE page table code are (ab)using dma_map_page()
>> as a means to flush page table updates for non-coherent IOMMUs. Since
>> from the CPU's point of view, creating IOMMU page tables *is* passing
>> DMA buffers to a device (the IOMMU's page table walker), there's little
>> reason not to use the DMA API correctly.
>>
>> Allow IOMMU drivers to opt into DMA API operations for page table
>> allocation and updates by providing their appropriate device pointer.
>> The expectation is that an LPAE IOMMU should have a full view of system
>> memory, so use streaming mappings to avoid unnecessary pressure on
>> ZONE_DMA, and treat any DMA translation as a warning sign.
>
> I like the idea of doing this in core code rather than in individual drivers,
> but I believe we're not using the right API. Please see below.

Perhaps this could have one of my trademark "for now"s - the aim of this 
series is really just to stop the per-driver hacks proliferating, as per 
Russell's comment[1]. I left the semi-artificial DMA==phys restriction 
for expediency, since it follows the current usage and keeps the code 
changes minimal. With this series in place I'd be happy to go back and 
try a full-blown DMA conversion if and when a real need shows up, but I 
think it would significantly complicate all the current software page 
table walking.

>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/Kconfig          |   3 +-
>>   drivers/iommu/io-pgtable-arm.c | 107 +++++++++++++++++++++++++++++---------
>>   drivers/iommu/io-pgtable.h     |   3 ++
>>   3 files changed, 89 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index f1fb1d3ccc56..d77a848d50de 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -23,7 +23,8 @@ config IOMMU_IO_PGTABLE
>>   config IOMMU_IO_PGTABLE_LPAE
>>   	bool "ARMv7/v8 Long Descriptor Format"
>>   	select IOMMU_IO_PGTABLE
>> -	depends on ARM || ARM64 || COMPILE_TEST
>> +	# SWIOTLB guarantees a dma_to_phys() implementation
>> +	depends on ARM || ARM64 || (COMPILE_TEST && SWIOTLB)
>>   	help
>>   	  Enable support for the ARM long descriptor pagetable format.
>>   	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index 4e460216bd16..28cca8a652f9 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -200,12 +200,76 @@ typedef u64 arm_lpae_iopte;
>>
>>   static bool selftest_running = false;
>>
>> +static dma_addr_t __arm_lpae_dma_addr(struct device *dev, void *pages)
>> +{
>> +	return phys_to_dma(dev, virt_to_phys(pages));
>> +}
>> +
>> +static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>> +				    struct io_pgtable_cfg *cfg)
>> +{
>> +	struct device *dev = cfg->iommu_dev;
>> +	dma_addr_t dma;
>> +	void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
>> +
>> +	if (!pages)
>> +		return NULL;
>> +
>> +	if (dev) {
>> +		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
>> +		if (dma_mapping_error(dev, dma))
>> +			goto out_free;
>> +		/*
>> +		 * We depend on the IOMMU being able to work with any physical
>> +		 * address directly, so if the DMA layer suggests it can't by
>> +		 * giving us back some translation, that bodes very badly...
>> +		 */
>> +		if (dma != __arm_lpae_dma_addr(dev, pages))
>> +			goto out_unmap;
>
> Why do we need to create a mapping at all then ? Because
> dma_sync_single_for_device() requires it ?

We still need to expose this new table to the device. If we never update 
it, we'll never have reason to call dma_sync_, but we definitely want 
the IOMMU to know there's a page of invalid PTEs there.

>> +	}
>> +
>> +	return pages;
>> +
>> +out_unmap:
>> +	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page
>> tables\n");
>> +	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
>> +out_free:
>> +	free_pages_exact(pages, size);
>> +	return NULL;
>> +}
>> +
>> +static void __arm_lpae_free_pages(void *pages, size_t size,
>> +				  struct io_pgtable_cfg *cfg)
>> +{
>> +	struct device *dev = cfg->iommu_dev;
>> +
>> +	if (dev)
>> +		dma_unmap_single(dev, __arm_lpae_dma_addr(dev, pages),
>> +				 size, DMA_TO_DEVICE);
>> +	free_pages_exact(pages, size);
>> +}
>> +
>> +static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
>> +			       struct io_pgtable_cfg *cfg, void *cookie)
>> +{
>> +	struct device *dev = cfg->iommu_dev;
>> +
>> +	*ptep = pte;
>> +
>> +	if (dev)
>> +		dma_sync_single_for_device(dev, __arm_lpae_dma_addr(dev, ptep),
>> +					   sizeof(pte), DMA_TO_DEVICE);
>
> This is what I believe to be an API abuse. The dma_sync_single_for_device()
> API is meant to pass ownership of a buffer to the device. Unless I'm mistaken,
> once that's done the CPU isn't allowed to touch the buffer anymore until
> dma_sync_single_for_cpu() is called to get ownership of the buffer back. Sure,
> it might work on many ARM systems, but we really should be careful not to use
> APIs as delicate as DMA mapping and cache handling for purposes different than
> what they explicitly allow.
>
> It might be that I'm wrong and that the streaming DMA API allows this exact
> kind of usage, but I haven't found a clear indication of that in the
> documentation. It could also be that all implementations would support it
> today, and that we would then consider it should be explicitly allowed by the
> API. In both cases a documentation patch would be welcome.

TBH, I was largely going by Russell's Tegra patch, which similarly 
elides any sync_*_for_cpu. In reality, since everything is DMA_TO_DEVICE 
and the IOMMU itself can't modify the page tables[3], I can't think of 
any situation where sync_*_for_cpu would actually do anything.

 From reading this part of DMA-API.txt:

   Notes:  You must do this:

   - Before reading values that have been written by DMA from the device
     (use the DMA_FROM_DEVICE direction)
   - After writing values that will be written to the device using DMA
     (use the DMA_TO_DEVICE) direction
   - before *and* after handing memory to the device if the memory is
     DMA_BIDIRECTIONAL

I would conclude that since a sync using DMA_TO_DEVICE *before* writing 
is not a "must", then it's probably unnecessary.

Robin.

[1]:http://article.gmane.org/gmane.linux.kernel/2005551
[2]:http://article.gmane.org/gmane.linux.ports.tegra/23150
[3]:Yes, there may generally be exceptions to that, but not in the 
context of this code. Unless the Renesas IPMMU does something I don't 
know about?
