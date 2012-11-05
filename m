From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 3/4 v4] iommu/fsl: Add iommu domain attributes required
	by fsl PAMU driver.
Date: Mon, 5 Nov 2012 16:10:46 -0600
Message-ID: <50983966.4080805@freescale.com>
References: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
	<1352114361-25192-2-git-send-email-Varun.Sethi@freescale.com>
	<1352114361-25192-3-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1352114361-25192-3-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Varun Sethi wrote:
> Added the following domain attributes required by FSL PAMU driver:
> 1. Subwindows field added to the iommu domain geometry attribute.
> 2. Added new iommu stash attribute, which allows setting of the
>    LIODN specific stash id parameter through IOMMU API.
> 3. Added an attribute for enabling/disabling DMA to a particular
>    memory window.
> 
> 
> Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> changes in v4:
> - Updated comment explaining subwindows(as mentioned by Scott).
> change in v3:
> -renamed the stash attribute targets
>  include/linux/iommu.h |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f3b99e1..e72f5e5 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -44,6 +44,34 @@ struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped    */
>  	dma_addr_t aperture_end;   /* Last address that can be mapped     */
>  	bool force_aperture;       /* DMA only allowed in mappable range? */
> +
> +	/**

/** is used by kerneldoc to indicate a kerneldoc-style comment.  Normal
comments should start with just "/*".

> +	 * There could be a single contiguous window tha maps the entire
> +	 * geometry or it could be split in to multiple subwindows.
> +	 * Subwindows allow for supporting physically discontiguous mappings.
> +	 * This attribute indicates number of DMA subwindows supported by
> +	 * the geometry. If there is a single window that maps the entire
> +	 * geometry, attribute must be set to "1". A value of "0" implies
> +	 * that there are 256 subwindows each of size 4K. Value other than
> +	 * "0" or "1" indicates the actual number of subwindows.
> +	 */
> +	u32 subwindows;

Why is this a sized integer?

> +};
> +
> +/* cache stash targets */
> +#define IOMMU_ATTR_CACHE_L1 1
> +#define IOMMU_ATTR_CACHE_L2 2
> +#define IOMMU_ATTR_CACHE_L3 3

This seems kinda silly.  The value of the enum is in the enum name.

> +
> +/* This attribute corresponds to IOMMUs capable of generating
> + * a stash transaction. A stash transaction is typically a
> + * hardware initiated prefetch of data from memory to cache.
> + * This attribute allows configuring stashig specific parameters
> + * in the IOMMU hardware.
> + */
> +struct iommu_stash_attribute {
> +	u32 	cpu;	/* cpu number */
> +	u32 	cache;	/* cache to stash to: L1,L2,L3 */
>  };
>  
>  struct iommu_domain {
> @@ -60,6 +88,14 @@ struct iommu_domain {
>  enum iommu_attr {
>  	DOMAIN_ATTR_MAX,
>  	DOMAIN_ATTR_GEOMETRY,
> +	/* Set the IOMMU hardware stashing
> +	 * parameters.
> +	 */
> +	DOMAIN_ATTR_STASH,
> +	/* Explicity enable/disable DMA for a
> +         * particular memory window.
> +         */
> +	DOMAIN_ATTR_ENABLE,
>  };
>  
>  #ifdef CONFIG_IOMMU_API
> 


-- 
Timur Tabi
Linux kernel developer at Freescale
