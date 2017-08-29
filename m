From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Tue, 29 Aug 2017 12:23:36 +0100
Message-ID: <811dfba8-097c-0deb-c283-a7b1e0c6ee38@arm.com>
References: <1503496204-2527-1-git-send-email-joro@8bytes.org>
	<1503496204-2527-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503496204-2527-3-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 23/08/17 14:50, Joerg Roedel wrote:
[...]
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

Do we still need this, or has it just slipped through from v1?

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

Ditto here.

Robin.

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
