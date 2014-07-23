From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH v2 1/1] iommu-api: Add map_range/unmap_range functions
Date: Wed, 23 Jul 2014 10:49:55 -0700
Message-ID: <53CFF5C3.5060600@codeaurora.org>
References: <1405558917-7597-1-git-send-email-ohaugan@codeaurora.org> <1405558917-7597-2-git-send-email-ohaugan@codeaurora.org> <20140717082138.GC18640@ulmo> <53CDB76A.5090602@codeaurora.org> <20140722074507.GB18258@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140722074507.GB18258@ulmo>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: joro@8bytes.org, robdclark@gmail.com, will.deacon@arm.com, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On 7/22/2014 12:45 AM, Thierry Reding wrote:
> On Mon, Jul 21, 2014 at 05:59:22PM -0700, Olav Haugan wrote:
>> On 7/17/2014 1:21 AM, Thierry Reding wrote:
>>> On Wed, Jul 16, 2014 at 06:01:57PM -0700, Olav Haugan wrote:
> [...]
>>>> Additionally, the mapping operation would be faster in general since
>>>> clients does not have to keep calling map API over and over again for
>>>> each physically contiguous chunk of memory that needs to be mapped to a
>>>> virtually contiguous region.
>>>>
>>>> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
>>>> ---
>>>>  drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/iommu.h | 25 +++++++++++++++++++++++++
>>>>  2 files changed, 73 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 1698360..a0eebb7 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -1089,6 +1089,54 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>>>>  EXPORT_SYMBOL_GPL(iommu_unmap);
>>>>  
>>>>  
>>>> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
>>>
>>> Maybe iova should be dma_addr_t? Or at least unsigned long? And perhaps
>>> iommu_map_sg() would be more consistent with the equivalent function in
>>> struct dma_ops?
>>>
>>>> +		    struct scatterlist *sg, unsigned int len, int opt)
>>>
>>> The length argument seems to be the size of the mapping. Again, the
>>> struct dma_ops function uses this argument to denote the number of
>>> entries in the scatterlist.
>>>
>>> opt is somewhat opaque. Perhaps this should be turned into unsigned long
>>> flags? Although given that there aren't any users yet it's difficult to
>>> say what's best here. Perhaps the addition of this argument should be
>>> postponed until there are actual users?
>>
>> I am thinking something like this:
>>
>> int iommu_map_sg(struct iommu_domain *domain, struct scatterlist *sg,
>> unsigned int nents, int prot, unsigned long flags);
>> int iommu_unmap_sg(struct iommu_domain *domain, struct scatterlist *sg,
>> unsigned int nents, unsigned long flags);
> 
> Looks good.
> 
>> The iova is contained within sg so we don't need that argument really
> 
> I'm not sure. I think a common use-case for this function is for some
> driver to map an imported DMA-BUF. In that case you'll get a struct
> sg_table, but I think it won't have sg.dma_address set to anything
> useful. So if we don't have iova as a parameter to this function, the
> driver would have to make it a two-step process, like this:
> 
> 	sg_dma_address(sg) = iova;
> 
> 	err = iommu_map_sg(...);
> 
> And drivers that use the IOMMU API directly need to manage IOVA space
> themselves anyway, so I think passing around the IOVA within the SG
> won't be a very common case. It will almost always be the driver that
> calls this function which allocates the IOVA range.

Yes, I see your point. Rob is not a fan either...
So what about this:

int iommu_map_sg(struct iommu_domain *domain, unsigned long iova, struct
scatterlist *sg, unsigned int nents, int prot, unsigned long flags);
int iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
size_t size, unsigned long flags);

No need for sg in the unmap call then. Keeping iova an unsigned long to
match the existing iommu_map/iommu_unmap calls.


>> and I would like to keep the flags argument. I would prefer not to
>> change the API after it has been published which could potentially
>> affect a lot of call sites.
> 
> We have pretty good tools to help with this kind of mechanical
> conversion, so I don't think changing the API will be much of a problem.
> However it seems likely that we'll want to specify flags eventually, so
> I don't have any strong objections to keeping that parameter.
> 
>>>> +			phys_addr_t phys = page_to_phys(sg_page(sg));
>>>> +			u32 page_len = PAGE_ALIGN(sg->offset + sg->length);
>>>
>>> Shouldn't this alignment be left to iommu_map() to handle? It has code
>>> to deal with that already.
>>
>> I don't see page alignment in the iommu_map function. I only see a check
>> whether the (iova | paddr | size) is aligned to the minimum page size
>> and then it errors out if it isn't....
> 
> Indeed, the above doesn't do what I thought it did.
> 
>>> Perhaps rather than check for a ->map_range implementation everytime a
>>> better option may be to export this generic implementation so that
>>> drivers can set it in their iommu_ops if they don't implement it? So the
>>> contents of the if () block could become a new function:
>>>
>>> 	int iommu_map_range_generic(...)
>>> 	{
>>> 		...
>>> 	}
>>> 	EXPORT_SYMBOL(iommu_map_range_generic);
>>>
>>> And drivers would do this:
>>>
>>> 	static const struct iommu_ops driver_iommu_ops = {
>>> 		...
>>> 		.map_range = iommu_map_range_generic,
>>> 		...
>>> 	};
>>
>> I'd like to keep the new API consistent with the rest of the API. Most
>> if not all of the other APIs always check if the operation is non-NULL.
> 
> But that's because the other operations are either optional or they
> don't provide a fallback implementation. For .map_sg() the issue is
> different because the core provides a slow fallback. The disadvantage
> of keeping the check within iommu_map_sg() is that you have this check
> every time the function is called. If on the other hand drivers
> specifically set a pointer (either a custom implementation or the
> wrapper around iommu_map()) you'll simply call the driver function no
> matter what and don't have to special case.
> 
> It also makes it possible for drivers to opt-in to using the generic
> fallback. Currently if driver writers don't set it explicitly they'll
> silently get a fallback implementation and they may not even notice.
>
>> A new driver could choose not to set the .map_range callback. I think it
>> is better to keep this consistent with the behavior of the other APIs.
> 
> I'd argue that it's more consistent to not provide the fallback by
> default. None of the other functions do that. If the driver doesn't
> implement a callback then the iommu_*() functions will return an error.
> 
> For .map_sg() I think pretty much every driver will want to implement
> it, so requiring developers to explicitly set it for their driver seems
> like a good idea. If there's no advantage in implementing it then they
> can always get the same functionality by explicitly using the fallback.

I feel that requiring drivers to set the default callback defeats the
purpose of having a fallback in the first place. The reason to provide
the default fallback is to catch any driver that does not implement this
themselves.

Joerg, can you comment on what you envisioned when you suggested that we
add the fallback?

>>>> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
>>>> +		      unsigned int len, int opt)
>>>
>>> Some comments regarding function name and argument types as for
>>> iommu_map_range().
>>>
>>>> +static inline int iommu_map_range(struct iommu_domain *domain,
>>>> +				  unsigned int iova, struct scatterlist *sg,
>>>> +				  unsigned int len, int opt)
>>>> +{
>>>> +	return -ENODEV;
>>>
>>> I know other IOMMU API dummies already use this error code, but I find
>>> it to be a little confusing. The dummies are used when the IOMMU API is
>>> disabled via Kconfig, so -ENOSYS (Function not implemented) seems like a
>>> more useful error.
>>
>> Again, I would prefer to keep this consistent with the other APIs
>> already there. iommu_map/iommu_unmap both returns -ENODEV. If we want to
>> change this I think this should be done as a separate patch that changed
>> all of them to be consistent.
> 
> Fair enough.
> 
> Thierry
> 

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
