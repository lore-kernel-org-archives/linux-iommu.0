From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 2/4] iommu/omap: Play nice in multi-platform builds
Date: Mon, 09 Feb 2015 11:31:13 +0200
Message-ID: <4074084.ChUOO287C1@avalon>
References: <1423219448-22683-1-git-send-email-thierry.reding@gmail.com>
	<1423219448-22683-3-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1423219448-22683-3-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

Thank you for the patch.

On Friday 06 February 2015 11:44:06 Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> The OMAP IOMMU driver unconditionally executes code and registers a
> struct iommu_ops with the platform bus irrespective of whether it runs
> on an OMAP SoC or not. This causes problems in multi-platform kernels
> where drivers for other SoCs will no longer be able to register their
> own struct iommu_ops or even try to use a struct iommu_ops for an IOMMU
> that obviously isn't there.
> 
> The smallest fix I could think of is to check for the existence of any
> OMAP IOMMU devices in the device tree and skip initialization otherwise.
> 
> This fixes a problem on Tegra20 where the DRM driver will try to use the
> obviously non-existent OMAP IOMMU.
> 
> Reported-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
> Changes in v2:
> - do not fix up module exit function since it's dead code
> - drop reference to struct device_node
> 
>  drivers/iommu/omap-iommu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index f59f857b702e..a4ba851825c2 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1376,6 +1376,13 @@ static int __init omap_iommu_init(void)
>  	struct kmem_cache *p;
>  	const unsigned long flags = SLAB_HWCACHE_ALIGN;
>  	size_t align = 1 << 10; /* L2 pagetable alignement */
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, omap_iommu_of_match);
> +	if (!np)
> +		return 0;
> +
> +	of_node_put(np);
> 
>  	p = kmem_cache_create("iopte_cache", IOPTE_TABLE_SIZE, align, flags,
>  			      iopte_cachep_ctor);

-- 
Regards,

Laurent Pinchart
