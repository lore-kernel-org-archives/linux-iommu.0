From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3 v2] iommu/fsl: Add iommu domain attributes required by fsl PAMU driver.
Date: Thu, 4 Oct 2012 08:17:24 -0500
Message-ID: <43F13A8A-BF97-427C-8736-8F2E55B7A3D1@kernel.crashing.org>
References: <1349351808-7156-1-git-send-email-b16395@freescale.com> <1349351808-7156-3-git-send-email-b16395@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349351808-7156-3-git-send-email-b16395@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "<b16395@freescale.com>" <b16395@freescale.com>
Cc: joerg.roedel@amd.com, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org


On Oct 4, 2012, at 6:56 AM, <b16395@freescale.com> <b16395@freescale.com> wrote:

> From: Varun Sethi <Varun.Sethi@freescale.com>
> 
> Added the following domain attributes required by FSL PAMU driver:
> 1. Subwindows field added to the iommu domain geometry attribute.
> 2. Added new iommu stash attribute, which allows setting of the
>   LIODN specific stash id parameter through IOMMU API.
> 3. Added an attribute for enabling/disabling DMA to a particular
>   memory window.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> include/linux/iommu.h |   35 +++++++++++++++++++++++++++++++++++
> 1 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f3b99e1..62e22f0 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -44,6 +44,33 @@ struct iommu_domain_geometry {
> 	dma_addr_t aperture_start; /* First address that can be mapped    */
> 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
> 	bool force_aperture;       /* DMA only allowed in mappable range? */
> +
> +	/* The subwindows field indicates number of DMA subwindows supported
> +	 * by the geometry. Following is the interpretation of
> +	 * values for this field:
> +	 * 0 : This implies that the supported geometry size is 1 MB
> +         * with each subwindow size being 4KB. Thus number of subwindows
> +	 * being = 1MB/4KB = 256.
> +	 * 1 : Only one DMA window i.e. no subwindows.
> +	 * value other than 0 or 1 would indicate actual number of subwindows.
> +	 */
> +	u32 subwindows;
> +};
> +
> +/* cache stash targets */
> +#define L1_CACHE 1
> +#define L2_CACHE 2
> +#define L3_CACHE 3

These names are way to generic for being exposed to user space

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
> };
> 
> struct iommu_domain {
> @@ -60,6 +87,14 @@ struct iommu_domain {
> enum iommu_attr {
> 	DOMAIN_ATTR_MAX,
> 	DOMAIN_ATTR_GEOMETRY,
> +	/* Set the IOMMU hardware stashing
> +	 * parameters.
> +	 */
> +	DOMAIN_ATTR_STASH,
> +	/* Explicity enable/disable DMA for a
> +         * particular memory window.
> +         */
> +	DOMAIN_ATTR_ENABLE,
> };
> 
> #ifdef CONFIG_IOMMU_API
> -- 
> 1.7.4.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
