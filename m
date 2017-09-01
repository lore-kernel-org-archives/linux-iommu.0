From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Fri, 1 Sep 2017 18:20:45 +0100
Message-ID: <20170901172044.GB20817@arm.com>
References: <1503496204-2527-1-git-send-email-joro@8bytes.org>
	<1503496204-2527-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Wed, Aug 23, 2017 at 03:50:04PM +0200, Joerg Roedel wrote:
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

[...]

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
> +	return __iommu_unmap(domain, iova, size, false);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unmap_fast);

Really minor nit, but I think that iommu_unmap_nosync is a more descriptive
name (who wouldn't want to use the _fast version?!).

But anyway, this looks like a really welcome change and it addresses most
of my concerns on v1, so, modulo Robin's comments about map_sg:

Reviewed-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Will
