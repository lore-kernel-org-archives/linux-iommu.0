From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/exynos: Make driver depend on REGULATOR
Date: Tue, 03 Feb 2015 15:37:27 +0100
Message-ID: <54D0DD27.5030000@samsung.com>
References: <1422316230-18893-1-git-send-email-joro@8bytes.org>
	<1422316230-18893-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1422316230-18893-3-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 2015-01-27 00:50, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>
> When regulator is not selected during kconfig, linking of
> the exynos iommu driver fails due to missing symbols.
> Fix it!

Frankly, I never observed such issue. Could you provide the .config for 
such case? I know that existing exynos iommu driver is broken, but 
please, don't break it even more...

> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>   drivers/iommu/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dfa6cf1..2e6100d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -190,7 +190,7 @@ config TEGRA_IOMMU_SMMU
>   
>   config EXYNOS_IOMMU
>   	bool "Exynos IOMMU Support"
> -	depends on ARCH_EXYNOS && ARM
> +	depends on ARCH_EXYNOS && ARM && REGULATOR
>   	select IOMMU_API
>   	select ARM_DMA_USE_IOMMU
>   	help

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
