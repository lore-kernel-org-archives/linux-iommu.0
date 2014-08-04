From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Mon, 04 Aug 2014 11:03:51 -0700
Message-ID: <53DFCB07.5090209@codeaurora.org>
References: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
	<1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
	<20140801082228.GC15733@arm.com> <53DBC3F1.40705@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53DBC3F1.40705-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Any more comments on this from anyone before I submit v5?

On 8/1/2014 9:44 AM, Olav Haugan wrote:
> Hi Will,
> 
> On 8/1/2014 1:22 AM, Will Deacon wrote:
>> Hi Olav,
>>
>> On Fri, Aug 01, 2014 at 01:54:44AM +0100, Olav Haugan wrote:
>>> Mapping and unmapping are more often than not in the critical path.
>>> map_sg and unmap_sg allows IOMMU driver implementations to optimize
>>> the process of mapping and unmapping buffers into the IOMMU page tables.
>>>
>>> Instead of mapping a buffer one page at a time and requiring potentially
>>> expensive TLB operations for each page, this function allows the driver
>>> to map all pages in one go and defer TLB maintenance until after all
>>> pages have been mapped.
>>>
>>> Additionally, the mapping operation would be faster in general since
>>> clients does not have to keep calling map API over and over again for
>>> each physically contiguous chunk of memory that needs to be mapped to a
>>> virtually contiguous region.
>>
>> Just a couple of minor comments, but I think this is almost there now.
>>
>>> Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> ---
>>>  drivers/iommu/iommu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/iommu.h | 28 ++++++++++++++++++++++++++++
>>>  2 files changed, 72 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 1698360..1d5dc2e 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1088,6 +1088,50 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>>>  }
>>>  EXPORT_SYMBOL_GPL(iommu_unmap);
>>>  
>>> +int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>>> +			struct scatterlist *sg, unsigned int nents,
>>> +			int prot, unsigned long flags)
>>> +{
>>
>> What do you anticipate passing in the flags parameter? I assume it's
>> something specific to the scatterlist, since we can't provide this to
>> iommu_map as it stands?
> 
> Initially the flags argument is planned to be used by clients to
> indicate to the driver that no TLB operation is necessary. This allows
> clients to for example map/unmap multiple scatter-gather lists without
> doing expensive TLB invalidate operations for each call but just do this
> at the last mapping/unmapping call instead. I believe Rob Clark was
> looking for this feature and I can see the benefit for our use cases also.
> 
>>> +	int ret = 0;
>>> +	unsigned long offset = 0;
>>> +
>>> +	if (unlikely(domain->ops->map_sg == NULL)) {
>>> +		unsigned int i;
>>> +		struct scatterlist *s;
>>> +
>>> +		for_each_sg(sg, s, nents, i) {
>>> +			phys_addr_t phys = page_to_phys(sg_page(s));
>>> +			size_t page_len = s->offset + s->length;
>>> +
>>> +			ret = iommu_map(domain, iova + offset, phys, page_len,
>>> +					prot);
>>> +			if (ret)
>>> +				goto fail;
>>> +
>>> +			offset += page_len;
>>> +		}
>>> +	} else {
>>> +		ret = domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
>>> +	}
>>> +	goto out;
>>> +
>>> +fail:
>>> +	/* undo mappings already done in case of error */
>>> +	iommu_unmap(domain, iova, offset);
>>
>> I think this would be cleaner if you stuck it in the loop above and removed
>> all these labels:
>>
>>   if (ret) {
>> 	iommu_unmap(...);
>> 	break;
>>   }
> 
> Sure, I can do that.
> 
> Thanks,
> 
> Olav
> 


Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
