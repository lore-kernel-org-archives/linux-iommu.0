From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] iommu/exynos: Play nice in multi-platform builds
Date: Wed, 04 Feb 2015 12:26:40 +0100
Message-ID: <54D201F0.9090105@samsung.com>
References: <1423036690-3862-1-git-send-email-thierry.reding@gmail.com>
	<1423036690-3862-2-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1423036690-3862-2-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-02-04 08:58, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> The Exynos System MMU driver unconditionally executes code and registers
> a struct iommu_ops with the platform bus irrespective of whether it runs
> on an Exynos SoC or not. This causes problems in multi-platform kernels
> where drivers for other SoCs will no longer be able to register their
> own struct iommu_ops or even try to use a struct iommu_ops for an IOMMU
> that obviously isn't there.
>
> The smallest fix I could think of is to check for the existence of any
> Exynos System MMU devices in the device tree and skip initialization
> otherwise.
>
> This fixes a problem on Tegra20 where the DRM driver will try to use the
> obviously non-existent Exynos System MMU.
>
> Reported-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Frankly, you may mark the existing exynos iommu driver as BROKEN, what will
solve a few other issues as well. In the current version this driver is not
functional and not used on any platform. I thought that my fixes will get
into v3.20, but it looks that it won't happen.

> ---
>   drivers/iommu/exynos-iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 7ce52737c7a1..d4b41fa32368 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1188,6 +1188,9 @@ static int __init exynos_iommu_init(void)
>   {
>   	int ret;
>   
> +	if (!of_find_matching_node(NULL, sysmmu_of_match))
> +		return 0;
> +
>   	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
>   				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
>   	if (!lv2table_kmem_cache) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
