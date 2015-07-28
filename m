From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/io-pgtable-arm: Allow appropriate DMA API use
Date: Tue, 28 Jul 2015 16:39:23 +0100
Message-ID: <55B7A22B.6010608@arm.com>
References: <c8cc82fea26044e393ff857014d4146faac5ec1e.1438019069.git.robin.murphy@arm.com>
	<20150728101722.GF29209@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150728101722.GF29209-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 28/07/15 11:17, Will Deacon wrote:
[...]
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index 4e46021..b93a60e 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -200,12 +200,76 @@ typedef u64 arm_lpae_iopte;
>>
>>   static bool selftest_running = false;
>>
>> +static dma_addr_t __arm_lpae_dma(struct device *dev, void *pages)
>> +{
>> +	return phys_to_dma(dev, virt_to_phys(pages));
>> +}
>> +
>> +static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>> +				    struct io_pgtable_cfg *cfg, void *cookie)
>> +{
>> +	void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
>> +	struct device *dev = cfg->iommu_dev;
>> +	dma_addr_t dma;
>> +
>> +	if (!pages)
>> +		return NULL;
>
> Missing newline here.

Coding style flamewar, go! Or not, since I have neither the energy or 
inclination, so I'll go with the status quo.

(Here we come and here we come and here we go etc.)

>> +	if (dev) {
>> +		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
>> +		if (dma_mapping_error(dev, dma))
>> +			goto out_free;
>> +		/*
>> +		 * We depend on the IOMMU being able to work with any physical
>> +		 * address directly, so if the DMA layer suggests it can't by
>> +		 * giving us back some translation, that bodes very badly...
>> +		 */
>> +		if (WARN(dma != __arm_lpae_dma(dev, pages),
>> +			 "Cannot accommodate DMA translation for IOMMU page tables\n"))
>
> Now that we have a struct device for the iommu, we could use dev_err to make
> this diagnostic more useful.

Good point.

>> +			goto out_unmap;
>> +	}
>
> Missing newline again...
>
>> +	if (cfg->tlb->flush_pgtable)
>
> Why would you have both a dev and a flush callback? In which cases is the
> DMA API insufficient?

a) Bisectability given existing users.
b) When the device is coherent, the DMA API stuff should be a nop even 
if a device was provided, therefore some other synchronisation is needed.

>> +		cfg->tlb->flush_pgtable(pages, size, cookie);
>
> ... and here (yeah, pedantry, but consistency keeps this file easier to
> read).
>
>> +	return pages;
>> +
>> +out_unmap:
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
>> +		dma_unmap_single(dev, __arm_lpae_dma(dev, pages),
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
>> +		dma_sync_single_for_device(dev, __arm_lpae_dma(dev, ptep),
>> +					   sizeof(pte), DMA_TO_DEVICE);
>> +	if (cfg->tlb->flush_pgtable)
>> +		cfg->tlb->flush_pgtable(ptep, sizeof(pte), cookie);
>
> Could we kill the flush_pgtable callback completely and just stick in a
> dma_wmb() here? Ideally, we've have something like dma_store_release,
> which we could use to set the parent page table entry, but that's left
> as a future exercise ;)

I couldn't convince myself that there wouldn't never be some weird case 
where an IOMMU driver still needs to do something funky for a coherent 
device, so I left it in. Given that the existing implementations are 
either dsb or nothing, however, I agree it may be worth taking out now 
and only bringing back later if proven necessary.

I would think we'd need at least wmb() though, since dma_wmb() only 
gives us a dmb on arm64; if the PTE is going from invalid to valid (i.e. 
no TLB involved), we'd have the normal cacheable write of the PTE 
potentially racing with an MMIO write after we return (the "do DMA with 
this address" command to the master) and I think we might need a dsb to 
avoid that - if the PTE write hasn't got far enough for the IOMMU to 
snoop it, the walk hits the stale invalid entry, aborts the incoming 
transaction and kills the device.

>> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
>> index 10e32f6..39fe864 100644
>> --- a/drivers/iommu/io-pgtable.h
>> +++ b/drivers/iommu/io-pgtable.h
>> @@ -41,6 +41,7 @@ struct iommu_gather_ops {
>>    * @ias:           Input address (iova) size, in bits.
>>    * @oas:           Output address (paddr) size, in bits.
>>    * @tlb:           TLB management callbacks for this set of tables.
>> + * @iommu_dev:     The owner of the page table memory (for DMA purposes).
>>    */
>>   struct io_pgtable_cfg {
>>   	#define IO_PGTABLE_QUIRK_ARM_NS	(1 << 0)	/* Set NS bit in PTEs */
>> @@ -49,6 +50,7 @@ struct io_pgtable_cfg {
>>   	unsigned int			ias;
>>   	unsigned int			oas;
>>   	const struct iommu_gather_ops	*tlb;
>> +	struct device			*iommu_dev;
>
> I think we should also update the comments for iommu_gather_ops once
> we decide on the fate of flush_pgtable.

Agreed. I'm thinking I can add an extra patch to the end of the series 
removing it after the driver conversion patches.

Robin.
