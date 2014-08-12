From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Tue, 12 Aug 2014 10:10:33 -0700
Message-ID: <53EA4A89.30108@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org> <1407797150-515-2-git-send-email-ohaugan@codeaurora.org> <4605275.P2SLc4fsBd@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4605275.P2SLc4fsBd@avalon>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: joro@8bytes.org, laurent.pinchart+renesas@ideasonboard.com, robdclark@gmail.com, will.deacon@arm.com, thierry.reding@gmail.com, kgene.kim@samsung.com, dwmw2@infradead.org, hdoyu@nvidia.com, Varun.Sethi@freescale.com, konrad.wilk@oracle.com, s-anna@ti.com, mitchelh@codeaurora.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On 8/12/2014 9:55 AM, Laurent Pinchart wrote:
> Hi Olav,
> 
> Thank you for the patch.
> 
> On Monday 11 August 2014 15:45:50 Olav Haugan wrote:
>> Mapping and unmapping are more often than not in the critical path.
>> map_sg and unmap_sg allows IOMMU driver implementations to optimize
>> the process of mapping and unmapping buffers into the IOMMU page tables.
>>
>> Instead of mapping a buffer one page at a time and requiring potentially
>> expensive TLB operations for each page, this function allows the driver
>> to map all pages in one go and defer TLB maintenance until after all
>> pages have been mapped.
>>
>> Additionally, the mapping operation would be faster in general since
>> clients does not have to keep calling map API over and over again for
>> each physically contiguous chunk of memory that needs to be mapped to a
>> virtually contiguous region.
>>
>> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
>> ---
>>  drivers/iommu/amd_iommu.c      |  2 ++
>>  drivers/iommu/arm-smmu.c       |  2 ++
>>  drivers/iommu/exynos-iommu.c   |  2 ++
>>  drivers/iommu/intel-iommu.c    |  2 ++
>>  drivers/iommu/iommu.c          | 33 +++++++++++++++++++++++++++++++
>>  drivers/iommu/ipmmu-vmsa.c     |  2 ++
>>  drivers/iommu/msm_iommu.c      |  2 ++
>>  drivers/iommu/omap-iommu.c     |  2 ++
>>  drivers/iommu/shmobile-iommu.c |  2 ++
>>  drivers/iommu/tegra-smmu.c     |  2 ++
>>  include/linux/iommu.h          | 44 +++++++++++++++++++++++++++++++++++++++
>>  11 files changed, 95 insertions(+)
> 
> [snip]
> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 1698360..24cf727 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1088,6 +1088,39 @@ size_t iommu_unmap(struct iommu_domain *domain,
>> unsigned long iova, size_t size)
> 
> [snip]
> 
>> +int default_iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
>> +			       size_t size, unsigned long flags)
> 
> I would have called this iommu_default_unmap_sg (and same comment for 
> default_iommu_map_sg) to keep the iommu_ prefix, but that's up to you.
> 
>> +{
>> +	return iommu_unmap(domain, iova, size);
>> +}
>> +EXPORT_SYMBOL_GPL(default_iommu_unmap_sg);
> 
> Do you expect drivers to need to override this ? What are the use cases for 
> non-default implementation of unmap_sg different than this ?

Good question. Yes, maybe some drivers does not need or want to override
this but a use case is to provide a more optimized version of the
map_sg/unmap_sg functions. For example a very simple way to optimize
this would be to have an implementation that unmaps everything and then
does a TLB invalidate instead of doing a TLB invalidate after every
single unmap (which happens with the default implementation if your
driver does TLB invalidate after unmapping).

> [snip]
> 
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 20f9a52..ee106ce 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
> 
> [snip]
> 
>> @@ -240,6 +256,20 @@ static inline int report_iommu_fault(struct
>> iommu_domain *domain, return ret;
>>  }
>>
>> +static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long
>> iova,
>> +			       struct scatterlist *sg, unsigned int nents,
>> +			       int prot, unsigned long flags)
>> +{
>> +	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
> 
> Instead of having to modify all IOMMU drivers to set the map_sg operation to 
> default_iommu_map_sg, how about calling it automatically as a fallback when 
> map_sg is NULL ? Something like
> 
> 	if (domain->ops->map_sg)
> 		return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
> 
> 	return default_iommu_map_sg(domain, iova, sg, nents, prot, flags);

This was my original proposal but after some discussion on the list we
ended up with what we have now.

> 
>> +}
>> +
>> +static inline int iommu_unmap_sg(struct iommu_domain *domain,
>> +				 unsigned long iova, size_t size,
>> +				 unsigned long flags)
>> +{
>> +	return domain->ops->unmap_sg(domain, iova, size, flags);
>> +}
>> +
> 

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
