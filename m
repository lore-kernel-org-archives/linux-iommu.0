From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: limit the IOVA allocated to dma-ranges region
Date: Fri, 1 Sep 2017 10:43:05 +0100
Message-ID: <3aeeb13e-045f-4cde-2cfb-62d4a879d207@arm.com>
References: <1504217301-17216-1-git-send-email-vdumpa@nvidia.com>
 <20170901092609.GL19533@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170901092609.GL19533@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Krishna Reddy <vdumpa@nvidia.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 01/09/17 10:26, Joerg Roedel wrote:
> Adding Robin for review.
> 
> On Thu, Aug 31, 2017 at 03:08:21PM -0700, Krishna Reddy wrote:
>> Limit the IOVA allocated to dma-ranges specified for the device.
>> This is necessary to ensure that IOVA allocated is addressable
>> by device.

Why? IOVA allocation is already constrained as much as it should be - if
the device's DMA mask is wrong that's another problem, and this isn't
the right place to fix it.

dma_32bit_pfn means nothing more than an internal detail of IOVA
allocator caching, which is subject to change[1]. As-is, on some
platforms this patch will effectively force all allocations to fail already.

Robin.

[1]:https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg19694.html
>> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
>> ---
>>  drivers/iommu/dma-iommu.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 9d1cebe7f6cb..e8a8320b571b 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -364,6 +364,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>  	struct iova_domain *iovad = &cookie->iovad;
>>  	unsigned long shift, iova_len, iova = 0;
>> +	dma_addr_t dma_end_addr;
>>  
>>  	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>>  		cookie->msi_iova += size;
>> @@ -381,6 +382,10 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>>  	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>>  		iova_len = roundup_pow_of_two(iova_len);
>>  
>> +	/* Limit IOVA allocated to device addressable dma-ranges region. */
>> +	dma_end_addr = (dma_addr_t)iovad->dma_32bit_pfn << shift;
>> +	dma_limit = dma_limit > dma_end_addr ? dma_end_addr : dma_limit;
> 
> This looks like a good use-case for min().
> 
>> +
>>  	if (domain->geometry.force_aperture)
>>  		dma_limit = min(dma_limit, domain->geometry.aperture_end);
>>  
>> -- 
>> 2.1.4
