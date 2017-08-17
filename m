From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/13] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Thu, 17 Aug 2017 17:32:35 +0100
Message-ID: <20170817163234.GB30719@arm.com>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
	<1502974596-23835-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502974596-23835-3-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

I really like the idea of this, but I have a couple of questions and
comments below.

On Thu, Aug 17, 2017 at 02:56:25PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> With the current IOMMU-API the hardware TLBs have to be
> flushed in every iommu_map(), iommu_map_sg(), and
> iommu_unmap() call.
> 
> For unmapping large amounts of address space, like it
> happens when a KVM domain with assigned devices is
> destroyed, this causes thousands of unnecessary TLB flushes
> in the IOMMU hardware because the unmap call-back runs for
> every unmapped physical page.
> 
> With the TLB Flush Interface introduced here the need to
> clean the hardware TLBs is removed from the iommu_map/unmap
> functions. Users now have to explicitly call these functions
> to sync the page-table changes to the hardware.
> 
> Three functions are introduced:
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
> Additionally, this patch introduces synchronized versions of
> the iommu_map(), iommu_map_sg(), and iommu_unmap()
> functions. They will be used by current users of the
> IOMMU-API, before they are optimized to the unsynchronized
> versions.
> 
> Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 26 +++++++++++++++++
>  include/linux/iommu.h | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3f6ea16..816e248 100644
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
> @@ -1556,6 +1558,18 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  }
>  EXPORT_SYMBOL_GPL(iommu_map);
>  
> +int iommu_map_sync(struct iommu_domain *domain, unsigned long iova,
> +		   phys_addr_t paddr, size_t size, int prot)
> +{
> +	int ret = iommu_map(domain, iova, paddr, size, prot);
> +
> +	iommu_tlb_range_add(domain, iova, size);
> +	iommu_tlb_sync(domain);

Many IOMMUs don't need these callbacks on ->map operations, but they won't
be able to distinguish them easily with this API. Could you add a flags
parameter or something to the iommu_tlb_* functions, please?

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_map_sync);
> +
>  size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>  {
>  	size_t unmapped_page, unmapped = 0;
> @@ -1608,6 +1622,18 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(iommu_unmap);
>  
> +size_t iommu_unmap_sync(struct iommu_domain *domain,
> +			unsigned long iova, size_t size)
> +{
> +	size_t ret = iommu_unmap(domain, iova, size);
> +
> +	iommu_tlb_range_add(domain, iova, size);
> +	iommu_tlb_sync(domain);

I think we will struggle to implement this efficiently on ARM SMMUv3. The
way invalidation works there is that there is a single in-memory command
queue into which we can put TLB invalidation commands (they are inserted
under a lock). These are then processed asynchronously by the hardware, and
you can complete them by inserting a SYNC command and waiting for that to
be consumed by the SMMU. Sounds like a perfect fit, right?

The problem is that we want to add those invalidation commands as early
as possible, so that they can be processed by the hardware concurrently
with us unmapping other pages. That means adding the invalidation commands
in the ->unmap callback and not bothering to implement ->iotlb_range_add
callback at all. Then, we will do the sync in ->iotlb_sync. This falls
apart if somebody decides to use iommu_flush_tlb_all(), where we would
prefer not to insert all of the invalidation commands in unmap and instead
insert a single invalidate-all command, followed up with a SYNC.

In other words, we really need the information about the invalidation as
part of the unmap call.

Any ideas?

Will
