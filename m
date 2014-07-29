From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Mon, 28 Jul 2014 17:50:08 -0700
Message-ID: <53D6EFC0.1060308@codeaurora.org>
References: <1406572731-6216-1-git-send-email-ohaugan@codeaurora.org>
	<1406572731-6216-2-git-send-email-ohaugan@codeaurora.org>
	<20140728191111.GW15536@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140728191111.GW15536-5wv7dgnIgG8@public.gmane.org>
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

Hi Will,

On 7/28/2014 12:11 PM, Will Deacon wrote:
> Hi Olav,
> 
> On Mon, Jul 28, 2014 at 07:38:51PM +0100, Olav Haugan wrote:
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
>> Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/iommu.h | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 76 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 1698360..cd65511 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1088,6 +1088,54 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_unmap);
>>  
>> +int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>> +			struct scatterlist *sg, unsigned int nents,
>> +			int prot, unsigned long flags)
>> +{
>> +	int ret = 0;
>> +	unsigned long offset = 0;
>> +
>> +	BUG_ON(iova & (~PAGE_MASK));
>> +
>> +	if (unlikely(domain->ops->map_sg == NULL)) {
>> +		unsigned int i;
>> +		struct scatterlist *s;
>> +
>> +		for_each_sg(sg, s, nents, i) {
>> +			phys_addr_t phys = page_to_phys(sg_page(s));
>> +			u32 page_len = PAGE_ALIGN(s->offset + s->length);
> 
> Hmm, this is a pretty horrible place where CPU page size (from the sg list)
> meets the IOMMU and I think we need to do something better to avoid spurious
> failures. In other words, the sg list should be iterated in such a way that
> we always pass a multiple of a supported iommu page size to iommu_map.
> 
> All the code using PAGE_MASK and PAGE_ALIGN needn't match what is supported
> by the IOMMU hardware.

I am not sure what you mean. How can we iterate over the sg list in a
different way to ensure we pass a multiple of a supported iommu page
size? Each entry in the sg list are physically discontinuous from each
other. If the page is too big iommu_map will take care of it for us. It
already finds the biggest supported page size and splits up the calls to
domain->ops->map(). Also, whoever allocates memory for use by IOMMU
needs to be aware of what the supported minimum size is or else they
would get mapping failures anyway.

(The code in __map_sg_chunk in arch/arm/mm/dma-mapping.c does the same
thing btw.)

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
