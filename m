From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH v2 1/1] iommu-api: Add map_range/unmap_range functions
Date: Mon, 21 Jul 2014 17:59:22 -0700
Message-ID: <53CDB76A.5090602@codeaurora.org>
References: <1405558917-7597-1-git-send-email-ohaugan@codeaurora.org> <1405558917-7597-2-git-send-email-ohaugan@codeaurora.org> <20140717082138.GC18640@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140717082138.GC18640@ulmo>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: joro@8bytes.org, robdclark@gmail.com, will.deacon@arm.com, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On 7/17/2014 1:21 AM, Thierry Reding wrote:
> On Wed, Jul 16, 2014 at 06:01:57PM -0700, Olav Haugan wrote:
>> Mapping and unmapping are more often than not in the critical path.
>> map_range and unmap_range allows SMMU driver implementations to optimize
> 
> s/SMMU/IOMMU/
>
>> the process of mapping and unmapping buffers into the SMMU page tables.
> 
> s/SMMU/IOMMU/
> 
>> Instead of mapping one physical address, do TLB operation (expensive),
>> mapping, do TLB operation, mapping, do TLB operation the driver can map
>> a scatter-gatherlist of physically contiguous pages into one virtual
>> address space and then at the end do one TLB operation.
> 
> I find the above hard to read. Maybe:
> 
> Instead of mapping a buffer one page at a time and requiring potentially
> expensive TLB operations for each page, this function allows the driver
> to map all pages in one go and defer TLB maintenance until after all
> pages have been mapped.

Yeah, all above is OK with me.

> 
>> Additionally, the mapping operation would be faster in general since
>> clients does not have to keep calling map API over and over again for
>> each physically contiguous chunk of memory that needs to be mapped to a
>> virtually contiguous region.
>>
>> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
>> ---
>>  drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/iommu.h | 25 +++++++++++++++++++++++++
>>  2 files changed, 73 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 1698360..a0eebb7 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1089,6 +1089,54 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>>  EXPORT_SYMBOL_GPL(iommu_unmap);
>>  
>>  
>> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
> 
> Maybe iova should be dma_addr_t? Or at least unsigned long? And perhaps
> iommu_map_sg() would be more consistent with the equivalent function in
> struct dma_ops?
> 
>> +		    struct scatterlist *sg, unsigned int len, int opt)
> 
> The length argument seems to be the size of the mapping. Again, the
> struct dma_ops function uses this argument to denote the number of
> entries in the scatterlist.
> 
> opt is somewhat opaque. Perhaps this should be turned into unsigned long
> flags? Although given that there aren't any users yet it's difficult to
> say what's best here. Perhaps the addition of this argument should be
> postponed until there are actual users?

I am thinking something like this:

int iommu_map_sg(struct iommu_domain *domain, struct scatterlist *sg,
unsigned int nents, int prot, unsigned long flags);
int iommu_unmap_sg(struct iommu_domain *domain, struct scatterlist *sg,
unsigned int nents, unsigned long flags);

The iova is contained within sg so we don't need that argument really
and I would like to keep the flags argument. I would prefer not to
change the API after it has been published which could potentially
affect a lot of call sites.

>> +{
>> +	s32 ret = 0;
> 
> Should be int to match the function's return type.
> 
>> +	u32 offset = 0;
>> +	u32 start_iova = iova;
> 
> These should match the type of iova. Also, what's the point of
> start_iova if we can simply keep iova constant and use offset where
> necessary?
> 
>> +	BUG_ON(iova & (~PAGE_MASK));
>> +
>> +	if (unlikely(domain->ops->map_range == NULL)) {
>> +		while (offset < len) {
> 
> Maybe this should use for_each_sg()?
> 
>> +			phys_addr_t phys = page_to_phys(sg_page(sg));
>> +			u32 page_len = PAGE_ALIGN(sg->offset + sg->length);
> 
> Shouldn't this alignment be left to iommu_map() to handle? It has code
> to deal with that already.

I don't see page alignment in the iommu_map function. I only see a check
whether the (iova | paddr | size) is aligned to the minimum page size
and then it errors out if it isn't....


>> +			ret = iommu_map(domain, iova, phys, page_len, opt);
> 
> This conflates the new opt argument with iommu_map()'s prot argument.
> Maybe those two should rather be split?
> 
>> +			if (ret)
>> +				goto fail;
>> +
>> +			iova += page_len;
>> +			offset += page_len;
>> +			if (offset < len)
>> +				sg = sg_next(sg);
>> +		}
>> +	} else {
>> +		ret = domain->ops->map_range(domain, iova, sg, len, opt);
>> +	}
> 
> Perhaps rather than check for a ->map_range implementation everytime a
> better option may be to export this generic implementation so that
> drivers can set it in their iommu_ops if they don't implement it? So the
> contents of the if () block could become a new function:
> 
> 	int iommu_map_range_generic(...)
> 	{
> 		...
> 	}
> 	EXPORT_SYMBOL(iommu_map_range_generic);
> 
> And drivers would do this:
> 
> 	static const struct iommu_ops driver_iommu_ops = {
> 		...
> 		.map_range = iommu_map_range_generic,
> 		...
> 	};

I'd like to keep the new API consistent with the rest of the API. Most
if not all of the other APIs always check if the operation is non-NULL.
A new driver could choose not to set the .map_range callback. I think it
is better to keep this consistent with the behavior of the other APIs.

>> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
>> +		      unsigned int len, int opt)
> 
> Some comments regarding function name and argument types as for
> iommu_map_range().
> 
>> +static inline int iommu_map_range(struct iommu_domain *domain,
>> +				  unsigned int iova, struct scatterlist *sg,
>> +				  unsigned int len, int opt)
>> +{
>> +	return -ENODEV;
> 
> I know other IOMMU API dummies already use this error code, but I find
> it to be a little confusing. The dummies are used when the IOMMU API is
> disabled via Kconfig, so -ENOSYS (Function not implemented) seems like a
> more useful error.

Again, I would prefer to keep this consistent with the other APIs
already there. iommu_map/iommu_unmap both returns -ENODEV. If we want to
change this I think this should be done as a separate patch that changed
all of them to be consistent.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
