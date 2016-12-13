From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V7 5/8] arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
Date: Tue, 13 Dec 2016 20:08:04 +0530
Message-ID: <002301d2554e$89112d20$9b338760$@codeaurora.org>
References: <1481567927-14791-1-git-send-email-sricharan@codeaurora.org> <1481567927-14791-6-git-send-email-sricharan@codeaurora.org> <7d09fc5a-9425-c171-e469-2759534de2dc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7d09fc5a-9425-c171-e469-2759534de2dc@arm.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Robin Murphy' <robin.murphy@arm.com>, jcrouse@codeaurora.org, pdaly@codeaurora.org, jgebben@codeaurora.org, joro@8bytes.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org, iommu@lists.linux-foundation.org, tzeng@codeaurora.org, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, mitchelh@codeaurora.org, vinod.koul@intel.com
Cc: dan.j.williams@intel.com
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Robin Murphy
>Sent: Tuesday, December 13, 2016 7:33 PM
>To: Sricharan R <sricharan@codeaurora.org>; jcrouse@codeaurora.org; pdaly@codeaurora.org; jgebben@codeaurora.org;
>joro@8bytes.org; linux-kernel@vger.kernel.org; pratikp@codeaurora.org; iommu@lists.linux-foundation.org; tzeng@codeaurora.org;
>linux-arm-kernel@lists.infradead.org; will.deacon@arm.com; mitchelh@codeaurora.org; vinod.koul@intel.com
>Cc: dan.j.williams@intel.com
>Subject: Re: [PATCH V7 5/8] arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
>
>On 12/12/16 18:38, Sricharan R wrote:
>> From: Mitchel Humpherys <mitchelh@codeaurora.org>
>>
>> The newly added DMA_ATTR_PRIVILEGED is useful for creating mappings that
>> are only accessible to privileged DMA engines.  Implement it in
>> dma-iommu.c so that the ARM64 DMA IOMMU mapper can make use of it.
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Tested-by: Robin Murphy <robin.murphy@arm.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
>> ---
>>  arch/arm64/mm/dma-mapping.c |  6 +++---
>>  drivers/iommu/dma-iommu.c   | 10 ++++++++--
>>  include/linux/dma-iommu.h   |  3 ++-
>>  3 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index 401f79a..ae76ead 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -557,7 +557,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>>  				 unsigned long attrs)
>>  {
>>  	bool coherent = is_device_dma_coherent(dev);
>> -	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
>> +	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
>>  	size_t iosize = size;
>>  	void *addr;
>>
>> @@ -711,7 +711,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
>>  				   unsigned long attrs)
>>  {
>>  	bool coherent = is_device_dma_coherent(dev);
>> -	int prot = dma_direction_to_prot(dir, coherent);
>> +	int prot = dma_info_to_prot(dir, coherent, attrs);
>>  	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
>>
>>  	if (!iommu_dma_mapping_error(dev, dev_addr) &&
>> @@ -769,7 +769,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
>>  		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
>>
>>  	return iommu_dma_map_sg(dev, sgl, nelems,
>> -			dma_direction_to_prot(dir, coherent));
>> +				dma_info_to_prot(dir, coherent, attrs));
>>  }
>>
>>  static void __iommu_unmap_sg_attrs(struct device *dev,
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index d2a7a46..756d5e0 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -182,16 +182,22 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>  EXPORT_SYMBOL(iommu_dma_init_domain);
>>
>>  /**
>> - * dma_direction_to_prot - Translate DMA API directions to IOMMU API page flags
>> + * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
>> + *                    page flags.
>>   * @dir: Direction of DMA transfer
>>   * @coherent: Is the DMA master cache-coherent?
>> + * @attrs: DMA attributes for the mapping
>>   *
>>   * Return: corresponding IOMMU API page protection flags
>>   */
>> -int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
>> +int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
>> +		     unsigned long attrs)
>>  {
>>  	int prot = coherent ? IOMMU_CACHE : 0;
>>
>> +	if (attrs & DMA_ATTR_PRIVILEGED)
>> +		prot |= IOMMU_PRIV;
>> +
>>  	switch (dir) {
>>  	case DMA_BIDIRECTIONAL:
>>  		return prot | IOMMU_READ | IOMMU_WRITE;
>
>...and applying against -next now also needs this hunk:
>
>@@ -639,7 +639,7 @@ dma_addr_t iommu_dma_map_resource(struct device
>*dev, phys_addr_t phys,
> 		size_t size, enum dma_data_direction dir, unsigned long attrs)
> {
> 	return __iommu_dma_map(dev, phys, size,
>-			dma_direction_to_prot(dir, false) | IOMMU_MMIO);
>+			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
> }
>
> void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>
>With those two issues fixed up, I've given the series (applied to
>next-20161213) a spin on a SMMUv3/PL330 fast model and it still checks out.
>

oops, sorry that i missed this in rebase. I can repost now with this fixed,
'checks out' you mean something is not working correct ?

Regards,
 Sricharan  
