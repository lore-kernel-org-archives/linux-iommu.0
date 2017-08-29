From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Tue, 29 Aug 2017 12:19:13 +0100
Message-ID: <837fc6a8-4b9b-7ae3-5c74-6f3c202a38fb@arm.com>
References: <1503496204-2527-1-git-send-email-joro@8bytes.org>
	<1503496204-2527-3-git-send-email-joro@8bytes.org>
	<59A4D72F.9040600@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <59A4D72F.9040600-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 29/08/17 03:53, Leizhen (ThunderTown) wrote:
[...]
>> -size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>> +static size_t __iommu_unmap(struct iommu_domain *domain,
>> +			    unsigned long iova, size_t size,
>> +			    bool sync)
>>  {
>> +	const struct iommu_ops *ops = domain->ops;
>>  	size_t unmapped_page, unmapped = 0;
>> -	unsigned int min_pagesz;
>>  	unsigned long orig_iova = iova;
>> +	unsigned int min_pagesz;
>>  
>> -	if (unlikely(domain->ops->unmap == NULL ||
>> +	if (unlikely(ops->unmap == NULL ||
>>  		     domain->pgsize_bitmap == 0UL))
>>  		return -ENODEV;
>>  
>> @@ -1592,10 +1597,13 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>>  	while (unmapped < size) {
>>  		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
>>  
>> -		unmapped_page = domain->ops->unmap(domain, iova, pgsize);
>> +		unmapped_page = ops->unmap(domain, iova, pgsize);
>>  		if (!unmapped_page)
>>  			break;
>>  
>> +		if (sync && ops->iotlb_range_add)
>> +			ops->iotlb_range_add(domain, iova, pgsize);
>> +
>>  		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
>>  			 iova, unmapped_page);
>>  
>> @@ -1603,11 +1611,27 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>>  		unmapped += unmapped_page;
>>  	}
>>  
>> +	if (sync && ops->iotlb_sync)
>> +		ops->iotlb_sync(domain);
>> +
>>  	trace_unmap(orig_iova, size, unmapped);
>>  	return unmapped;
>>  }
>> +
>> +size_t iommu_unmap(struct iommu_domain *domain,
>> +		   unsigned long iova, size_t size)
>> +{
>> +	return __iommu_unmap(domain, iova, size, true);
>> +}
>>  EXPORT_SYMBOL_GPL(iommu_unmap);
>>  
>> +size_t iommu_unmap_fast(struct iommu_domain *domain,
>> +			unsigned long iova, size_t size)
>> +{
> Do we need to add a check "if (!domain->ops->iotlb_sync)". Suppose the new added three hooks are not
> registered, we should fallback to iommu_unmap.

If those callbacks don't exist, then iommu_unmap() isn't going to be
able to call them either, so I don't see what difference that makes :/

>> +	return __iommu_unmap(domain, iova, size, false);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_unmap_fast);
>> +
>>  size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>>  			 struct scatterlist *sg, unsigned int nents, int prot)
>>  {
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 2cb54ad..67fa954 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -167,6 +167,10 @@ struct iommu_resv_region {
>>   * @map: map a physically contiguous memory region to an iommu domain
>>   * @unmap: unmap a physically contiguous memory region from an iommu domain
>>   * @map_sg: map a scatter-gather list of physically contiguous memory chunks
>> + * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
>> + * @tlb_range_add: Add a given iova range to the flush queue for this domain
>> + * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
>> + *            queue
>>   * to an iommu domain
>>   * @iova_to_phys: translate iova to physical address
>>   * @add_device: add device to iommu grouping
>> @@ -199,6 +203,10 @@ struct iommu_ops {
>>  		     size_t size);
>>  	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
>>  			 struct scatterlist *sg, unsigned int nents, int prot);
>> +	void (*flush_iotlb_all)(struct iommu_domain *domain);
>> +	void (*iotlb_range_add)(struct iommu_domain *domain,
>> +				unsigned long iova, size_t size);
>> +	void (*iotlb_sync)(struct iommu_domain *domain);
> I think we'd better to make sure all these three hooks are registered or all are not, in
> function __iommu_domain_alloc or some other suitable place.

I'd prefer for them to be individually optional than for drivers to have
to implement no-op callbacks - e.g. for SMMUv2 where issuing TLBIs is
relatively cheap, but latency-sensitive, we're probably better off not
bothering with with .iotlb_range_add (leaving the TLBIs implicit in
.unmap) only implementing .iotlb_sync.

Robin.
