From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: move pgsize_bitmap from struct iommu_ops to
	struct iommu_domain
Date: Fri, 06 Mar 2015 13:24:24 +0100
Message-ID: <54F99C78.5000205@samsung.com>
References: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
	<1425641688-26438-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1425641688-26438-2-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-03-06 12:34, Will Deacon wrote:
> struct iommu_ops contains function pointers for IOMMU driver callbacks
> in order to implement the core IOMMU API. Amongst these pointers is
> an unsigned long pgsize_bitmap field, which is problematic because the
> set of supported page sizes is not necessarily the same across all
> instances of a given IOMMU type in the system. Furthermore, the set of
> supported page sizes may be restricted following domain initialisation
> when a particular page table format is chosen for the domain.
>
> This patch moves the field from iommu_ops into the iommu_domain and
> updates all users accordingly.
>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

For the exynos iommu part:
Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> ---
>   drivers/iommu/amd_iommu.c       |  2 +-
>   drivers/iommu/arm-smmu.c        | 12 +++++-------
>   drivers/iommu/exynos-iommu.c    |  3 ++-
>   drivers/iommu/intel-iommu.c     |  2 +-
>   drivers/iommu/iommu.c           | 16 ++++++++--------
>   drivers/iommu/ipmmu-vmsa.c      |  2 +-
>   drivers/iommu/msm_iommu.c       |  3 ++-
>   drivers/iommu/omap-iommu.c      |  3 ++-
>   drivers/iommu/rockchip-iommu.c  |  2 +-
>   drivers/iommu/shmobile-iommu.c  |  2 +-
>   drivers/iommu/tegra-gart.c      |  2 +-
>   drivers/iommu/tegra-smmu.c      |  3 +--
>   drivers/vfio/vfio_iommu_type1.c |  2 +-
>   include/linux/iommu.h           |  6 +-----
>   14 files changed, 28 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 48882c126245..83d9e500f737 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3257,6 +3257,7 @@ static int amd_iommu_domain_init(struct iommu_domain *dom)
>   	dom->geometry.aperture_end   = ~0ULL;
>   	dom->geometry.force_aperture = true;
>   
> +	dom->pgsize_bitmap = AMD_IOMMU_PGSIZES;
>   	return 0;
>   
>   out_free:
> @@ -3428,7 +3429,6 @@ static const struct iommu_ops amd_iommu_ops = {
>   	.unmap = amd_iommu_unmap,
>   	.map_sg = default_iommu_map_sg,
>   	.iova_to_phys = amd_iommu_iova_to_phys,
> -	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
>   };
>   
>   /*****************************************************************************
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index fc13dd56953e..16980001e73d 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -287,6 +287,7 @@ struct arm_smmu_device {
>   	void __iomem			*base;
>   	unsigned long			size;
>   	unsigned long			pgshift;
> +	unsigned long			pgsize_bitmap;
>   
>   #define ARM_SMMU_FEAT_COHERENT_WALK	(1 << 0)
>   #define ARM_SMMU_FEAT_STREAM_MATCH	(1 << 1)
> @@ -345,8 +346,6 @@ struct arm_smmu_domain {
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   };
>   
> -static struct iommu_ops arm_smmu_ops;
> -
>   static DEFINE_SPINLOCK(arm_smmu_devices_lock);
>   static LIST_HEAD(arm_smmu_devices);
>   
> @@ -911,7 +910,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	}
>   
>   	pgtbl_cfg = (struct io_pgtable_cfg) {
> -		.pgsize_bitmap	= arm_smmu_ops.pgsize_bitmap,
> +		.pgsize_bitmap	= smmu->pgsize_bitmap,
>   		.ias		= ias,
>   		.oas		= oas,
>   		.tlb		= &arm_smmu_gather_ops,
> @@ -925,7 +924,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	}
>   
>   	/* Update our support page sizes to reflect the page table format */
> -	arm_smmu_ops.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> +	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>   
>   	/* Initialise the context bank with our page table cfg */
>   	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> @@ -1430,7 +1429,7 @@ out_unlock:
>   	return ret;
>   }
>   
> -static struct iommu_ops arm_smmu_ops = {
> +static const struct iommu_ops arm_smmu_ops = {
>   	.capable		= arm_smmu_capable,
>   	.domain_init		= arm_smmu_domain_init,
>   	.domain_destroy		= arm_smmu_domain_destroy,
> @@ -1444,7 +1443,6 @@ static struct iommu_ops arm_smmu_ops = {
>   	.remove_device		= arm_smmu_remove_device,
>   	.domain_get_attr	= arm_smmu_domain_get_attr,
>   	.domain_set_attr	= arm_smmu_domain_set_attr,
> -	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>   };
>   
>   static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> @@ -1648,7 +1646,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   			size |= SZ_64K | SZ_512M;
>   	}
>   
> -	arm_smmu_ops.pgsize_bitmap &= size;
> +	smmu->pgsize_bitmap = size;
>   	dev_notice(smmu->dev, "\tSupported page sizes: 0x%08lx\n", size);
>   
>   	if (smmu->features & ARM_SMMU_FEAT_TRANS_S1)
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 7ce52737c7a1..404cad25db9b 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -735,6 +735,8 @@ static int exynos_iommu_domain_init(struct iommu_domain *domain)
>   	domain->geometry.aperture_end   = ~0UL;
>   	domain->geometry.force_aperture = true;
>   
> +	domain->pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE;
> +
>   	domain->priv = priv;
>   	return 0;
>   
> @@ -1181,7 +1183,6 @@ static const struct iommu_ops exynos_iommu_ops = {
>   	.iova_to_phys = exynos_iommu_iova_to_phys,
>   	.add_device = exynos_iommu_add_device,
>   	.remove_device = exynos_iommu_remove_device,
> -	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>   };
>   
>   static int __init exynos_iommu_init(void)
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ae4c1a854e57..e1bb010d9b26 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4363,6 +4363,7 @@ static int intel_iommu_domain_init(struct iommu_domain *domain)
>   	domain->geometry.aperture_end   = __DOMAIN_MAX_ADDR(dmar_domain->gaw);
>   	domain->geometry.force_aperture = true;
>   
> +	domain->pgsize_bitmap = INTEL_IOMMU_PGSIZES;
>   	return 0;
>   }
>   
> @@ -4605,7 +4606,6 @@ static const struct iommu_ops intel_iommu_ops = {
>   	.iova_to_phys	= intel_iommu_iova_to_phys,
>   	.add_device	= intel_iommu_add_device,
>   	.remove_device	= intel_iommu_remove_device,
> -	.pgsize_bitmap	= INTEL_IOMMU_PGSIZES,
>   };
>   
>   static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 72e683df0731..48544211221d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1025,7 +1025,7 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
>   	pgsize = (1UL << (pgsize_idx + 1)) - 1;
>   
>   	/* throw away page sizes not supported by the hardware */
> -	pgsize &= domain->ops->pgsize_bitmap;
> +	pgsize &= domain->pgsize_bitmap;
>   
>   	/* make sure we're still sane */
>   	BUG_ON(!pgsize);
> @@ -1046,11 +1046,11 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	int ret = 0;
>   
>   	if (unlikely(domain->ops->map == NULL ||
> -		     domain->ops->pgsize_bitmap == 0UL))
> +		     domain->pgsize_bitmap == 0UL))
>   		return -ENODEV;
>   
>   	/* find out the minimum page size supported */
> -	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
>   
>   	/*
>   	 * both the virtual address and the physical one, as well as
> @@ -1097,11 +1097,11 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>   	unsigned long orig_iova = iova;
>   
>   	if (unlikely(domain->ops->unmap == NULL ||
> -		     domain->ops->pgsize_bitmap == 0UL))
> +		     domain->pgsize_bitmap == 0UL))
>   		return -ENODEV;
>   
>   	/* find out the minimum page size supported */
> -	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
>   
>   	/*
>   	 * The virtual address, as well as the size of the mapping, must be
> @@ -1147,10 +1147,10 @@ size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   	unsigned int i, min_pagesz;
>   	int ret;
>   
> -	if (unlikely(domain->ops->pgsize_bitmap == 0UL))
> +	if (unlikely(domain->pgsize_bitmap == 0UL))
>   		return 0;
>   
> -	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
>   
>   	for_each_sg(sg, s, nents, i) {
>   		phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
> @@ -1231,7 +1231,7 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
>   		break;
>   	case DOMAIN_ATTR_PAGING:
>   		paging  = data;
> -		*paging = (domain->ops->pgsize_bitmap != 0UL);
> +		*paging = (domain->pgsize_bitmap != 0UL);
>   		break;
>   	case DOMAIN_ATTR_WINDOWS:
>   		count = data;
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 10186cac7716..cd867b255b99 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -469,6 +469,7 @@ static int ipmmu_domain_init(struct iommu_domain *io_domain)
>   
>   	io_domain->priv = domain;
>   	domain->io_domain = io_domain;
> +	domain->pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K;
>   
>   	return 0;
>   }
> @@ -747,7 +748,6 @@ static const struct iommu_ops ipmmu_ops = {
>   	.iova_to_phys = ipmmu_iova_to_phys,
>   	.add_device = ipmmu_add_device,
>   	.remove_device = ipmmu_remove_device,
> -	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
>   };
>   
>   /* -----------------------------------------------------------------------------
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index e1b05379ca0e..8b623dce8161 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -230,6 +230,8 @@ static int msm_iommu_domain_init(struct iommu_domain *domain)
>   	domain->geometry.aperture_end   = (1ULL << 32) - 1;
>   	domain->geometry.force_aperture = true;
>   
> +	domain->pgsize_bitmap = MSM_IOMMU_PGSIZES;
> +
>   	return 0;
>   
>   fail_nomem:
> @@ -682,7 +684,6 @@ static const struct iommu_ops msm_iommu_ops = {
>   	.unmap = msm_iommu_unmap,
>   	.map_sg = default_iommu_map_sg,
>   	.iova_to_phys = msm_iommu_iova_to_phys,
> -	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
>   };
>   
>   static int __init get_tex_class(int icp, int ocp, int mt, int nos)
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index f59f857b702e..272beb31cddd 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1250,6 +1250,8 @@ static int omap_iommu_domain_init(struct iommu_domain *domain)
>   	domain->geometry.aperture_end   = (1ULL << 32) - 1;
>   	domain->geometry.force_aperture = true;
>   
> +	domain->pgsize_bitmap = OMAP_IOMMU_PGSIZES;
> +
>   	return 0;
>   
>   fail_nomem:
> @@ -1368,7 +1370,6 @@ static const struct iommu_ops omap_iommu_ops = {
>   	.iova_to_phys	= omap_iommu_iova_to_phys,
>   	.add_device	= omap_iommu_add_device,
>   	.remove_device	= omap_iommu_remove_device,
> -	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
>   };
>   
>   static int __init omap_iommu_init(void)
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 6a8b1ec4a48a..5ab63e51e1c0 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -828,6 +828,7 @@ static int rk_iommu_domain_init(struct iommu_domain *domain)
>   	INIT_LIST_HEAD(&rk_domain->iommus);
>   
>   	domain->priv = rk_domain;
> +	domain->pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP;
>   
>   	return 0;
>   err_dt:
> @@ -961,7 +962,6 @@ static const struct iommu_ops rk_iommu_ops = {
>   	.add_device = rk_iommu_add_device,
>   	.remove_device = rk_iommu_remove_device,
>   	.iova_to_phys = rk_iommu_iova_to_phys,
> -	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
>   };
>   
>   static int rk_iommu_probe(struct platform_device *pdev)
> diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
> index f1b00774e4de..552bde09a69b 100644
> --- a/drivers/iommu/shmobile-iommu.c
> +++ b/drivers/iommu/shmobile-iommu.c
> @@ -101,6 +101,7 @@ static int shmobile_iommu_domain_init(struct iommu_domain *domain)
>   	spin_lock_init(&sh_domain->attached_list_lock);
>   	INIT_LIST_HEAD(&sh_domain->attached_list);
>   	domain->priv = sh_domain;
> +	domain->pgsize_bitmap = SZ_1M | SZ_64K | SZ_4K;
>   	return 0;
>   }
>   
> @@ -364,7 +365,6 @@ static const struct iommu_ops shmobile_iommu_ops = {
>   	.map_sg = default_iommu_map_sg,
>   	.iova_to_phys = shmobile_iommu_iova_to_phys,
>   	.add_device = shmobile_iommu_add_device,
> -	.pgsize_bitmap = SZ_1M | SZ_64K | SZ_4K,
>   };
>   
>   int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu)
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index c48da057dbb1..328ae11282f2 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -218,6 +218,7 @@ out:
>   
>   static int gart_iommu_domain_init(struct iommu_domain *domain)
>   {
> +	domain->pgsize_bitmap = GART_IOMMU_PGSIZES;
>   	return 0;
>   }
>   
> @@ -318,7 +319,6 @@ static const struct iommu_ops gart_iommu_ops = {
>   	.map_sg		= default_iommu_map_sg,
>   	.unmap		= gart_iommu_unmap,
>   	.iova_to_phys	= gart_iommu_iova_to_phys,
> -	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
>   };
>   
>   static int tegra_gart_suspend(struct device *dev)
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 6e134c7c227f..a423ed9a19da 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -265,6 +265,7 @@ static int tegra_smmu_domain_init(struct iommu_domain *domain)
>   		pd[i] = 0;
>   
>   	domain->priv = as;
> +	domain->pgsize_bitmap = SZ_4K;
>   
>   	return 0;
>   }
> @@ -643,8 +644,6 @@ static const struct iommu_ops tegra_smmu_ops = {
>   	.unmap = tegra_smmu_unmap,
>   	.map_sg = default_iommu_map_sg,
>   	.iova_to_phys = tegra_smmu_iova_to_phys,
> -
> -	.pgsize_bitmap = SZ_4K,
>   };
>   
>   static void tegra_smmu_ahb_enable(void)
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 57d8c37a002b..afbd7fefa4e6 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -407,7 +407,7 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
>   
>   	mutex_lock(&iommu->lock);
>   	list_for_each_entry(domain, &iommu->domain_list, next)
> -		bitmap &= domain->domain->ops->pgsize_bitmap;
> +		bitmap &= domain->domain->pgsize_bitmap;
>   	mutex_unlock(&iommu->lock);
>   
>   	return bitmap;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 38daa453f2e5..baa05c09ca1b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -53,6 +53,7 @@ struct iommu_domain_geometry {
>   
>   struct iommu_domain {
>   	const struct iommu_ops *ops;
> +	unsigned long pgsize_bitmap;	/* Bitmap of supported page sizes */
>   	void *priv;
>   	iommu_fault_handler_t handler;
>   	void *handler_token;
> @@ -108,8 +109,6 @@ enum iommu_attr {
>    * @domain_get_attr: Query domain attributes
>    * @domain_set_attr: Change domain attributes
>    * @of_xlate: add OF master IDs to iommu grouping
> - * @pgsize_bitmap: bitmap of supported page sizes
> - * @priv: per-instance data private to the iommu driver
>    */
>   struct iommu_ops {
>   	bool (*capable)(enum iommu_cap);
> @@ -144,9 +143,6 @@ struct iommu_ops {
>   #ifdef CONFIG_OF_IOMMU
>   	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>   #endif
> -
> -	unsigned long pgsize_bitmap;
> -	void *priv;
>   };
>   
>   #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
