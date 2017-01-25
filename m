From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH/RFC 1/4] iommu: dma: track mapped iova
Date: Wed, 25 Jan 2017 16:27:57 +0000
Message-ID: <6939083c-ce85-952c-58cb-aba68d7afb92@arm.com>
References: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1485348842-23712-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485348842-23712-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, joro@8bytes.org
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, iommu@lists.linux-foundation.org, magnus.damm@gmail.com
List-Id: iommu@lists.linux-foundation.org

On 25/01/17 12:53, Yoshihiro Shimoda wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> To track mapped iova for a workaround code in the future.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/iommu/dma-iommu.c | 29 +++++++++++++++++++++++------
>  include/linux/iommu.h     |  2 ++

So what's being added here is a counter of allocations within the
iova_domain held by an iommu_dma_cookie? Then why is it all the way down
in the iommu_domain and not in the cookie? That's needlessly invasive -
it would be almost understandable (but still horrible) if you needed to
refer to it directly from the IOMMU driver, but as far as I can see you
don't.

Robin.

>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2db0d64..a0b8c0f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -19,6 +19,7 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/device.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/gfp.h>
> @@ -147,6 +148,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  	order = __ffs(domain->pgsize_bitmap);
>  	base_pfn = max_t(unsigned long, 1, base >> order);
>  	end_pfn = (base + size - 1) >> order;
> +	atomic_set(&domain->iova_pfns_mapped, 0);
>  
>  	/* Check the domain allows at least some access to the device... */
>  	if (domain->geometry.force_aperture) {
> @@ -209,6 +211,7 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
>  	struct iova_domain *iovad = cookie_iovad(domain);
>  	unsigned long shift = iova_shift(iovad);
>  	unsigned long length = iova_align(iovad, size) >> shift;
> +	struct iova *iova;
>  
>  	if (domain->geometry.force_aperture)
>  		dma_limit = min(dma_limit, domain->geometry.aperture_end);
> @@ -216,9 +219,23 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
>  	 * Enforce size-alignment to be safe - there could perhaps be an
>  	 * attribute to control this per-device, or at least per-domain...
>  	 */
> -	return alloc_iova(iovad, length, dma_limit >> shift, true);
> +	iova = alloc_iova(iovad, length, dma_limit >> shift, true);
> +	if (iova)
> +		atomic_add(iova_size(iova), &domain->iova_pfns_mapped);
> +
> +	return iova;
>  }
>  
> +void
> +__free_iova_domain(struct iommu_domain *domain, struct iova *iova)
> +{
> +	struct iova_domain *iovad = cookie_iovad(domain);
> +
> +	atomic_sub(iova_size(iova), &domain->iova_pfns_mapped);
> +	__free_iova(iovad, iova);
> +}
> +
> +
>  /* The IOVA allocator knows what we mapped, so just unmap whatever that was */
>  static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
>  {
> @@ -235,7 +252,7 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
>  	size -= iommu_unmap(domain, pfn << shift, size);
>  	/* ...and if we can't, then something is horribly, horribly wrong */
>  	WARN_ON(size > 0);
> -	__free_iova(iovad, iova);
> +	__free_iova_domain(domain, iova);
>  }
>  
>  static void __iommu_dma_free_pages(struct page **pages, int count)
> @@ -401,7 +418,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  out_free_sg:
>  	sg_free_table(&sgt);
>  out_free_iova:
> -	__free_iova(iovad, iova);
> +	__free_iova_domain(domain, iova);
>  out_free_pages:
>  	__iommu_dma_free_pages(pages, count);
>  	return NULL;
> @@ -447,7 +464,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>  
>  	dma_addr = iova_dma_addr(iovad, iova);
>  	if (iommu_map(domain, dma_addr, phys - iova_off, len, prot)) {
> -		__free_iova(iovad, iova);
> +		__free_iova_domain(domain, iova);
>  		return DMA_ERROR_CODE;
>  	}
>  	return dma_addr + iova_off;
> @@ -613,7 +630,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  	return __finalise_sg(dev, sg, nents, dma_addr);
>  
>  out_free_iova:
> -	__free_iova(iovad, iova);
> +	__free_iova_domain(domain, iova);
>  out_restore_sg:
>  	__invalidate_sg(sg, nents);
>  	return 0;
> @@ -689,7 +706,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	return msi_page;
>  
>  out_free_iova:
> -	__free_iova(iovad, iova);
> +	__free_iova_domain(domain, iova);
>  out_free_page:
>  	kfree(msi_page);
>  	return NULL;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0ff5111..91d0159 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -19,6 +19,7 @@
>  #ifndef __LINUX_IOMMU_H
>  #define __LINUX_IOMMU_H
>  
> +#include <linux/atomic.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> @@ -84,6 +85,7 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	void *iova_cookie;
> +	atomic_t iova_pfns_mapped;
>  };
>  
>  enum iommu_cap {
> 
