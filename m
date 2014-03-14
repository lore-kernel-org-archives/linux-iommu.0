From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 13/27] iommu/exynos: support for device tree
Date: Fri, 14 Mar 2014 14:39:33 +0100
Message-ID: <53230695.9080606@samsung.com>
References: <20140314140935.e0652b58ce16591b54d0e10b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140314140935.e0652b58ce16591b54d0e10b-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi KyongHo,

On 14.03.2014 06:09, Cho KyongHo wrote:
> This commit adds device tree support for System MMU.
>
> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/iommu/Kconfig        |    5 ++---
>   drivers/iommu/exynos-iommu.c |   21 +++++++++++++++++----
>   2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index df56e4c..22af807 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -178,16 +178,15 @@ config TEGRA_IOMMU_SMMU
>
>   config EXYNOS_IOMMU
>   	bool "Exynos IOMMU Support"
> -	depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
> +	depends on ARCH_EXYNOS
>   	select IOMMU_API
> +	default n
>   	help
>   	  Support for the IOMMU(System MMU) of Samsung Exynos application

nit: There should be a white space before the opening parenthesis.

>   	  processor family. This enables H/W multimedia accellerators to see

typo: s/accellerators/accelerators/

>   	  non-linear physical memory chunks as a linear memory in their
>   	  address spaces
>
> -	  If unsure, say N here.
> -
>   config EXYNOS_IOMMU_DEBUG
>   	bool "Debugging log for Exynos IOMMU"
>   	depends on EXYNOS_IOMMU
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 33b424d..34feb04 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -26,6 +26,7 @@
>   #include <linux/list.h>
>   #include <linux/memblock.h>
>   #include <linux/export.h>
> +#include <linux/of.h>
>
>   #include <asm/cacheflush.h>
>   #include <asm/pgtable.h>
> @@ -497,7 +498,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
>   	read_unlock_irqrestore(&data->lock, flags);
>   }
>
> -static int exynos_sysmmu_probe(struct platform_device *pdev)
> +static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
>   	struct device *dev = &pdev->dev;
> @@ -557,11 +558,23 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   	return 0;
>   }
>
> -static struct platform_driver exynos_sysmmu_driver = {
> -	.probe		= exynos_sysmmu_probe,
> -	.driver		= {
> +#ifdef CONFIG_OF
> +static struct of_device_id sysmmu_of_match[] __initconst = {
> +	{ .compatible	= "samsung,sysmmu-v1", },
> +	{ .compatible	= "samsung,sysmmu-v2", },
> +	{ .compatible	= "samsung,sysmmu-v3.1", },
> +	{ .compatible	= "samsung,sysmmu-v3.2", },
> +	{ .compatible	= "samsung,sysmmu-v3.3", },

Do you need all these compatible strings? I mean, are there any 
implementation differences that can't be identified by reading IP 
registers, such as REG_MMU_VERSION?

Best regards,
Tomasz
