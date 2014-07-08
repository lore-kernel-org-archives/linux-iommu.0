From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [RFC/PATCH 2/7] iommu-api: Add map_range/unmap_range functions
Date: Tue, 08 Jul 2014 14:53:42 -0700
Message-ID: <53BC6866.30803@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org> <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org> <20140704072940.c1e8e8cdd38fbc295fe5c086@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140704072940.c1e8e8cdd38fbc295fe5c086@nvidia.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vgandhi@codeaurora.org" <vgandhi@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi Hiroshi,

On 7/3/2014 9:29 PM, Hiroshi Doyu wrote:
> Hi Olav,
> 
> Olav Haugan <ohaugan@codeaurora.org> writes:
> 
>> Mapping and unmapping are more often than not in the critical path.
>> map_range and unmap_range allows SMMU driver implementations to optimize
>> the process of mapping and unmapping buffers into the SMMU page tables.
>> Instead of mapping one physical address, do TLB operation (expensive),
>> mapping, do TLB operation, mapping, do TLB operation the driver can map
>> a scatter-gatherlist of physically contiguous pages into one virtual
>> address space and then at the end do one TLB operation.
>>
>> Additionally, the mapping operation would be faster in general since
>> clients does not have to keep calling map API over and over again for
>> each physically contiguous chunk of memory that needs to be mapped to a
>> virtually contiguous region.
>>
>> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
>> ---
>>  drivers/iommu/iommu.c | 24 ++++++++++++++++++++++++
>>  include/linux/iommu.h | 24 ++++++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index e5555fc..f2a6b80 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -898,6 +898,30 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>>  EXPORT_SYMBOL_GPL(iommu_unmap);
>>  
>>  
>> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
>> +		    struct scatterlist *sg, unsigned int len, int prot)
>> +{
>> +	if (unlikely(domain->ops->map_range == NULL))
>> +		return -ENODEV;
>> +
>> +	BUG_ON(iova & (~PAGE_MASK));
>> +
>> +	return domain->ops->map_range(domain, iova, sg, len, prot);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_map_range);
> 
> We have the similar one internally, which is named, "iommu_map_sg()",
> called from DMA API.

Great, so this new API will be useful to more people!

>> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
>> +		      unsigned int len)
>> +{
>> +	if (unlikely(domain->ops->unmap_range == NULL))
>> +		return -ENODEV;
>> +
>> +	BUG_ON(iova & (~PAGE_MASK));
>> +
>> +	return domain->ops->unmap_range(domain, iova, len);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_unmap_range);
> 
> Can the existing iommu_unmap() do the same?

I believe iommu_unmap() behaves a bit differently because it will keep
on calling domain->ops->unmap() until everything is unmapped instead of
letting the iommu implementation take care of unmapping everything in
one call.

I am abandoning the patch series since our driver was not accepted.
However, if there are no objections I will resubmit this patch (PATCH
2/7) as an independent patch to add this new map_range API.

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
