From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Tue, 29 Aug 2017 10:53:35 +0800
Message-ID: <59A4D72F.9040600@huawei.com>
References: <1503496204-2527-1-git-send-email-joro@8bytes.org>
	<1503496204-2527-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503496204-2527-3-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2017/8/23 21:50, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> With the current IOMMU-API the hardware TLBs have to be
> flushed in every iommu_ops->unmap() call-back.
> 
> For unmapping large amounts of address space, like it
> happens when a KVM domain with assigned devices is
> destroyed, this causes thousands of unnecessary TLB flushes
> in the IOMMU hardware because the unmap call-back runs for
> every unmapped physical page.
> 
> With the TLB Flush Interface and the new iommu_unmap_fast()
> function introduced here the need to clean the hardware TLBs
> is removed from the unmapping code-path. Users of
> iommu_unmap_fast() have to explicitly call the TLB-Flush
> functions to sync the page-table changes to the hardware.
> 
> Three functions for TLB-Flushes are introduced:
> 
> 	* iommu_flush_tlb_all() - Flushes all TLB entries
> 	                          associated with that
> 				  domain. TLBs entries are
> 				  flushed when this function
> 				  returns.
> 
> 	* iommu_tlb_range_add() - This will add a given
> 				  range to the flush queue
> 				  for this domain.
> 
> 	* iommu_tlb_sync() - Flushes all queued ranges from
> 			     the hardware TLBs. Returns when
> 			     the flush is finished.
> 
> The semantic of this interface is intentionally similar to
> the iommu_gather_ops from the io-pgtable code.
> 
> Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 32 ++++++++++++++++++++---
>  include/linux/iommu.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3f6ea16..0f68342 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -527,6 +527,8 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
>  
>  	}
>  
> +	iommu_flush_tlb_all(domain);
> +
>  out:
>  	iommu_put_resv_regions(dev, &mappings);
>  
> @@ -1556,13 +1558,16 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  }
>  EXPORT_SYMBOL_GPL(iommu_map);
>  
> -size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
> +static size_t __iommu_unmap(struct iommu_domain *domain,
> +			    unsigned long iova, size_t size,
> +			    bool sync)
>  {
> +	const struct iommu_ops *ops = domain->ops;
>  	size_t unmapped_page, unmapped = 0;
> -	unsigned int min_pagesz;
>  	unsigned long orig_iova = iova;
> +	unsigned int min_pagesz;
>  
> -	if (unlikely(domain->ops->unmap == NULL ||
> +	if (unlikely(ops->unmap == NULL ||
>  		     domain->pgsize_bitmap == 0UL))
>  		return -ENODEV;
>  
> @@ -1592,10 +1597,13 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>  	while (unmapped < size) {
>  		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
>  
> -		unmapped_page = domain->ops->unmap(domain, iova, pgsize);
> +		unmapped_page = ops->unmap(domain, iova, pgsize);
>  		if (!unmapped_page)
>  			break;
>  
> +		if (sync && ops->iotlb_range_add)
> +			ops->iotlb_range_add(domain, iova, pgsize);
> +
>  		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
>  			 iova, unmapped_page);
>  
> @@ -1603,11 +1611,27 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>  		unmapped += unmapped_page;
>  	}
>  
> +	if (sync && ops->iotlb_sync)
> +		ops->iotlb_sync(domain);
> +
>  	trace_unmap(orig_iova, size, unmapped);
>  	return unmapped;
>  }
> +
> +size_t iommu_unmap(struct iommu_domain *domain,
> +		   unsigned long iova, size_t size)
> +{
> +	return __iommu_unmap(domain, iova, size, true);
> +}
>  EXPORT_SYMBOL_GPL(iommu_unmap);
>  
> +size_t iommu_unmap_fast(struct iommu_domain *domain,
> +			unsigned long iova, size_t size)
> +{
Do we need to add a check "if (!domain->ops->iotlb_sync)". Suppose the new added three hooks are not
registered, we should fallback to iommu_unmap.

> +	return __iommu_unmap(domain, iova, size, false);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unmap_fast);
> +
>  size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>  			 struct scatterlist *sg, unsigned int nents, int prot)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 2cb54ad..67fa954 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -167,6 +167,10 @@ struct iommu_resv_region {
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @unmap: unmap a physically contiguous memory region from an iommu domain
>   * @map_sg: map a scatter-gather list of physically contiguous memory chunks
> + * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
> + * @tlb_range_add: Add a given iova range to the flush queue for this domain
> + * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
> + *            queue
>   * to an iommu domain
>   * @iova_to_phys: translate iova to physical address
>   * @add_device: add device to iommu grouping
> @@ -199,6 +203,10 @@ struct iommu_ops {
>  		     size_t size);
>  	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
>  			 struct scatterlist *sg, unsigned int nents, int prot);
> +	void (*flush_iotlb_all)(struct iommu_domain *domain);
> +	void (*iotlb_range_add)(struct iommu_domain *domain,
> +				unsigned long iova, size_t size);
> +	void (*iotlb_sync)(struct iommu_domain *domain);
I think we'd better to make sure all these three hooks are registered or all are not, in
function __iommu_domain_alloc or some other suitable place.

>  	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
>  	int (*add_device)(struct device *dev);
>  	void (*remove_device)(struct device *dev);
> @@ -286,7 +294,9 @@ extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  		     phys_addr_t paddr, size_t size, int prot);
>  extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> -		       size_t size);
> +			  size_t size);
> +extern size_t iommu_unmap_fast(struct iommu_domain *domain,
> +			       unsigned long iova, size_t size);
>  extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>  				struct scatterlist *sg,unsigned int nents,
>  				int prot);
> @@ -343,6 +353,25 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
>  extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
>  			      unsigned long iova, int flags);
>  
> +static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
> +{
> +	if (domain->ops->flush_iotlb_all)
> +		domain->ops->flush_iotlb_all(domain);
> +}
> +
> +static inline void iommu_tlb_range_add(struct iommu_domain *domain,
> +				       unsigned long iova, size_t size)
> +{
> +	if (domain->ops->iotlb_range_add)
> +		domain->ops->iotlb_range_add(domain, iova, size);
> +}
> +
> +static inline void iommu_tlb_sync(struct iommu_domain *domain)
> +{
> +	if (domain->ops->iotlb_sync)
> +		domain->ops->iotlb_sync(domain);
> +}
> +
>  static inline size_t iommu_map_sg(struct iommu_domain *domain,
>  				  unsigned long iova, struct scatterlist *sg,
>  				  unsigned int nents, int prot)
> @@ -350,6 +379,20 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
>  	return domain->ops->map_sg(domain, iova, sg, nents, prot);
>  }
>  
> +static inline size_t iommu_map_sg_sync(struct iommu_domain *domain,
> +				       unsigned long iova,
> +				       struct scatterlist *sg,
> +				       unsigned int nents, int prot)
> +{
> +	size_t size = domain->ops->map_sg(domain, iova, sg, nents, prot);
> +	if (size > 0) {
> +		iommu_tlb_range_add(domain, iova, size);
> +		iommu_tlb_sync(domain);
> +	}
> +
> +	return size;
> +}
> +
>  /* PCI device grouping function */
>  extern struct iommu_group *pci_device_group(struct device *dev);
>  /* Generic device grouping function */
> @@ -436,6 +479,12 @@ static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
>  	return -ENODEV;
>  }
>  
> +static inline int iommu_unmap_fast(struct iommu_domain *domain, unsigned long iova,
> +				   int gfp_order)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline size_t iommu_map_sg(struct iommu_domain *domain,
>  				  unsigned long iova, struct scatterlist *sg,
>  				  unsigned int nents, int prot)
> @@ -443,6 +492,27 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
>  	return -ENODEV;
>  }
>  
> +static inline size_t iommu_map_sg_sync(struct iommu_domain *domain,
> +				       unsigned long iova,
> +				       struct scatterlist *sg,
> +				       unsigned int nents, int prot)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
> +{
> +}
> +
> +static inline void iommu_tlb_range_add(struct iommu_domain *domain,
> +				       unsigned long iova, size_t size)
> +{
> +}
> +
> +static inline void iommu_tlb_sync(struct iommu_domain *domain)
> +{
> +}
> +
>  static inline int iommu_domain_window_enable(struct iommu_domain *domain,
>  					     u32 wnd_nr, phys_addr_t paddr,
>  					     u64 size, int prot)
> 

-- 
Thanks!
BestRegards
