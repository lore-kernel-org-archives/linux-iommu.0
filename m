From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Wed, 06 Aug 2014 10:08:55 -0700
Message-ID: <53E26127.1040805@codeaurora.org>
References: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
	<1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
	<20140805151323.GB19709@laptop.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140805151323.GB19709-0iZWjJA6G8GSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 8/5/2014 8:13 AM, Konrad Rzeszutek Wilk wrote:
> On Thu, Jul 31, 2014 at 05:54:44PM -0700, Olav Haugan wrote:
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
> 
> That is assuming that physical == bus topology.
> 
>>
>> Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/iommu/iommu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/iommu.h | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 72 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 1698360..1d5dc2e 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1088,6 +1088,50 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
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
>> +	if (unlikely(domain->ops->map_sg == NULL)) {
>> +		unsigned int i;
>> +		struct scatterlist *s;
>> +
>> +		for_each_sg(sg, s, nents, i) {
>> +			phys_addr_t phys = page_to_phys(sg_page(s));
>> +			size_t page_len = s->offset + s->length;
>> +
>> +			ret = iommu_map(domain, iova + offset, phys, page_len,
>> +					prot);
>> +			if (ret)
>> +				goto fail;
>> +
>> +			offset += page_len;
>> +		}
> 
> I think it would be better if you had an 'default_iommu_map_sg' with
> the implementation above. And then the default ops->map_sg would point to
> that and each IOMMU would over-write with its own version.
> 
> That way you don't need any of this 'if' and can have the 'iommu_map_sg'
> be in the header file (either as static inline or an macro).

so you are suggesting that I check in "bus_set_iommu()" whether the
driver has set the map_sg/unmap_sg function pointers or not and if not
set it to the default? Is bus_set_iommu() the only way drivers can set
up the callbacks?

> 
>> +	} else {
>> +		ret = domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
>> +	}
>> +	goto out;
>> +
>> +fail:
>> +	/* undo mappings already done in case of error */
>> +	iommu_unmap(domain, iova, offset);
>> +out:
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_map_sg);
>> +
>> +int iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
>> +			size_t size, unsigned long flags)
>> +{
>> +	if (unlikely(domain->ops->unmap_sg == NULL))
>> +		return iommu_unmap(domain, iova, size);
>> +	else
>> +		return domain->ops->unmap_sg(domain, iova, size, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_unmap_sg);
>>  
>>  int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
>>  			       phys_addr_t paddr, u64 size, int prot)
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 20f9a52..66ad543 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -22,6 +22,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/err.h>
>>  #include <linux/types.h>
>> +#include <linux/scatterlist.h>
>>  #include <trace/events/iommu.h>
>>  
>>  #define IOMMU_READ	(1 << 0)
>> @@ -93,6 +94,10 @@ enum iommu_attr {
>>   * @detach_dev: detach device from an iommu domain
>>   * @map: map a physically contiguous memory region to an iommu domain
>>   * @unmap: unmap a physically contiguous memory region from an iommu domain
>> + * @map_sg: map a scatter-gather list of physically contiguous memory chunks
>> + * to an iommu domain
>> + * @unmap_sg: unmap a scatter-gather list of physically contiguous memory
>> + * chunks from an iommu domain
>>   * @iova_to_phys: translate iova to physical address
>>   * @domain_has_cap: domain capabilities query
>>   * @add_device: add device to iommu grouping
>> @@ -110,6 +115,11 @@ struct iommu_ops {
>>  		   phys_addr_t paddr, size_t size, int prot);
>>  	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>>  		     size_t size);
>> +	int (*map_sg)(struct iommu_domain *domain, unsigned long iova,
>> +			struct scatterlist *sg, unsigned int nents, int prot,
>> +			unsigned long flags);
>> +	int (*unmap_sg)(struct iommu_domain *domain, unsigned long iova,
>> +			size_t size, unsigned long flags);
>>  	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
>>  	int (*domain_has_cap)(struct iommu_domain *domain,
>>  			      unsigned long cap);
>> @@ -153,6 +163,11 @@ extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>>  		     phys_addr_t paddr, size_t size, int prot);
>>  extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
>>  		       size_t size);
>> +extern int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>> +			struct scatterlist *sg, unsigned int nents, int prot,
>> +			unsigned long flags);
>> +extern int iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
>> +				size_t size, unsigned long flags);
>>  extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
>>  extern int iommu_domain_has_cap(struct iommu_domain *domain,
>>  				unsigned long cap);
>> @@ -287,6 +302,19 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
>>  	return -ENODEV;
>>  }
>>  
>> +static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>> +			struct scatterlist *sg, unsigned int nents, int prot,
>> +			unsigned long flags)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline int iommu_unmap_sg(struct iommu_domain *domain,
>> +			unsigned long iova, size_t size, unsigned long flags)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>>  static inline int iommu_domain_window_enable(struct iommu_domain *domain,
>>  					     u32 wnd_nr, phys_addr_t paddr,
>>  					     u64 size, int prot)
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> hosted by The Linux Foundation
>>
>> _______________________________________________
>> iommu mailing list
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
