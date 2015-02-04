From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/omap: Play nice in multi-platform builds
Date: Wed, 04 Feb 2015 16:31:55 +0200
Message-ID: <1718219.kRa6INVfJa@avalon>
References: <1423036690-3862-1-git-send-email-thierry.reding@gmail.com>
	<1423036690-3862-3-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1423036690-3862-3-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

On Wednesday 04 February 2015 08:58:08 Thierry Reding wrote:
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
> ---
>  drivers/iommu/omap-iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index bbb7dcef02d3..e4d4f133a3b3 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1377,6 +1377,9 @@ static int __init omap_iommu_init(void)
>  	const unsigned long flags = SLAB_HWCACHE_ALIGN;
>  	size_t align = 1 << 10; /* L2 pagetable alignement */
> 
> +	if (!of_find_matching_node(NULL, omap_iommu_of_match))
> +		return 0;
> +

We should convert the omap-iommu driver to proper DT instantiation, but this 
should do for now.

>  	p = kmem_cache_create("iopte_cache", IOPTE_TABLE_SIZE, align, flags,
>  			      iopte_cachep_ctor);
>  	if (!p)
> @@ -1394,6 +1397,9 @@ subsys_initcall(omap_iommu_init);
> 
>  static void __exit omap_iommu_exit(void)
>  {
> +	if (!of_find_matching_node(NULL, omap_iommu_of_match))
> +		return;
> +
>  	kmem_cache_destroy(iopte_cachep);
> 
>  	platform_driver_unregister(&omap_iommu_driver);

The exit function will never be called as the omap-iommu driver is always 
built-in. You could just remove the exit function.

-- 
Regards,

Laurent Pinchart
