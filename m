From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 7/8] iommu: Remove IOMMU_OF_DECLARE
Date: Fri, 25 May 2018 12:31:05 +0100
Message-ID: <20180525113104.GA3255@arm.com>
References: <20180524175024.19874-1-robh@kernel.org>
	<20180524175024.19874-8-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180524175024.19874-8-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boot-architecture-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, May 24, 2018 at 12:50:23PM -0500, Rob Herring wrote:
> Now that we use the driver core to stop deferred probe for missing
> drivers, IOMMU_OF_DECLARE can be removed.
> 
> This is slightly less optimal than having a list of built-in drivers in
> that we'll now defer probe twice before giving up. This shouldn't have a
> significant impact on boot times as past discussions about deferred
> probe have given no evidence of deferred probe having a substantial
> impact.
> 
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c    |  2 --
>  drivers/iommu/arm-smmu.c       |  7 -------
>  drivers/iommu/exynos-iommu.c   |  2 --
>  drivers/iommu/ipmmu-vmsa.c     |  3 ---
>  drivers/iommu/msm_iommu.c      |  2 --
>  drivers/iommu/of_iommu.c       | 19 +------------------
>  drivers/iommu/qcom_iommu.c     |  2 --
>  drivers/iommu/rockchip-iommu.c |  2 --
>  include/linux/of_iommu.h       |  4 ----
>  9 files changed, 1 insertion(+), 42 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d647104bccc..22bdabd3d8e0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2915,8 +2915,6 @@ static struct platform_driver arm_smmu_driver = {
>  };
>  module_platform_driver(arm_smmu_driver);
>  
> -IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3");
> -
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>  MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 69e7c60792a8..9dd7cbaa3b0c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2211,13 +2211,6 @@ static struct platform_driver arm_smmu_driver = {
>  };
>  module_platform_driver(arm_smmu_driver);
>  
> -IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1");
> -IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2");
> -IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400");
> -IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
> -IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
> -IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
> -
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>  MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
>  MODULE_LICENSE("GPL v2");

For the SMMU drivers:

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Will
