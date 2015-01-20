From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for
	IOMMU masters
Date: Tue, 20 Jan 2015 18:56:03 +0200
Message-ID: <12178745.U2ZdLpocXO@avalon>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
	<2043949.GdM3BkS8d4@wuerfel> <20150119160620.GB2373@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150119160620.GB2373-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

Thank you for the patch.

On Monday 19 January 2015 16:06:20 Will Deacon wrote:
> (resurrecting an old thread)
> 
> On Fri, Nov 14, 2014 at 08:01:56PM +0000, Arnd Bergmann wrote:
> > On Friday 14 November 2014 19:27:54 Will Deacon wrote:
> > > > At the moment, iommu_ops is a structure that can get used for any
> > > > number of iommus of the same type, but by putting per-device private
> > > > data into the same structure you have to duplicate it per instance.
> > > 
> > > I'm not sure I agree -- the pgsize_bitmap, for example, could vary
> > > between different implementations of the same IOMMU. I think we already
> > > have this in Juno (some SMMUs can only do 64k pages, whilst others can
> > > do 4k and 64k).
> >
> > Ah, I hadn't noticed that, it should be in the 'struct iommu' then of
> > course, not in iommu_ops.
> 
> Now that of_iommu_get_ops has its own list of iommu_ops, we can actually
> just move pgsize_bitmap into the iommu_domain, which I think makes a lot
> more sense anyway.

The code looks good to me, but what does it have to do with of_iommu_get_ops() 
having its own list of iommu_ops ?

> diff below seems to do the trick. The next step would be postponing the
> pgsize_bitmap initialisation until device attach for the ARM SMMU, since
> it's at that point that we know the active page table format (and
> therefore the supported page sizes).
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 98024856df07..ab9702d01e9a 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3257,6 +3257,7 @@ static int amd_iommu_domain_init(struct iommu_domain
> *dom) dom->geometry.aperture_end   = ~0ULL;
>  	dom->geometry.force_aperture = true;
> 
> +	dom->pgsize_bitmap = AMD_IOMMU_PGSIZES;
>  	return 0;
> 
>  out_free:
> @@ -3428,7 +3429,6 @@ static const struct iommu_ops amd_iommu_ops = {
>  	.unmap = amd_iommu_unmap,
>  	.map_sg = default_iommu_map_sg,
>  	.iova_to_phys = amd_iommu_iova_to_phys,
> -	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
>  };
> 
>  /**************************************************************************
> *** diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 6cd47b75286f..898fab8d10a0 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1033,6 +1033,9 @@ static int arm_smmu_domain_init(struct iommu_domain
> *domain)
> 
>  	spin_lock_init(&smmu_domain->lock);
>  	domain->priv = smmu_domain;
> +	domain->pgsize_bitmap = (SECTION_SIZE |
> +				 ARM_SMMU_PTE_CONT_SIZE |
> +				 PAGE_SIZE);
>  	return 0;
> 
>  out_free_domain:
> @@ -1729,9 +1732,6 @@ static const struct iommu_ops arm_smmu_ops = {
>  	.remove_device		= arm_smmu_remove_device,
>  	.domain_get_attr	= arm_smmu_domain_get_attr,
>  	.domain_set_attr	= arm_smmu_domain_set_attr,
> -	.pgsize_bitmap		= (SECTION_SIZE |
> -				   ARM_SMMU_PTE_CONT_SIZE |
> -				   PAGE_SIZE),
>  };
> 
>  static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 7ce52737c7a1..404cad25db9b 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -735,6 +735,8 @@ static int exynos_iommu_domain_init(struct iommu_domain
> *domain) domain->geometry.aperture_end   = ~0UL;
>  	domain->geometry.force_aperture = true;
> 
> +	domain->pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE;
> +
>  	domain->priv = priv;
>  	return 0;
> 
> @@ -1181,7 +1183,6 @@ static const struct iommu_ops exynos_iommu_ops = {
>  	.iova_to_phys = exynos_iommu_iova_to_phys,
>  	.add_device = exynos_iommu_add_device,
>  	.remove_device = exynos_iommu_remove_device,
> -	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>  };
> 
>  static int __init exynos_iommu_init(void)
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 40dfbc0444c0..e2b0f34baa9d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4386,6 +4386,7 @@ static int intel_iommu_domain_init(struct iommu_domain
> *domain) domain->geometry.aperture_end   =
> __DOMAIN_MAX_ADDR(dmar_domain->gaw); domain->geometry.force_aperture =
> true;
> 
> +	domain->pgsize_bitmap = INTEL_IOMMU_PGSIZES;
>  	return 0;
>  }
> 
> @@ -4628,7 +4629,6 @@ static const struct iommu_ops intel_iommu_ops = {
>  	.iova_to_phys	= intel_iommu_iova_to_phys,
>  	.add_device	= intel_iommu_add_device,
>  	.remove_device	= intel_iommu_remove_device,
> -	.pgsize_bitmap	= INTEL_IOMMU_PGSIZES,
>  };
> 
>  static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f7718d73e984..b8b6b0bc6951 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1025,7 +1025,7 @@ static size_t iommu_pgsize(struct iommu_domain
> *domain, pgsize = (1UL << (pgsize_idx + 1)) - 1;
> 
>  	/* throw away page sizes not supported by the hardware */
> -	pgsize &= domain->ops->pgsize_bitmap;
> +	pgsize &= domain->pgsize_bitmap;
> 
>  	/* make sure we're still sane */
>  	BUG_ON(!pgsize);
> @@ -1046,11 +1046,11 @@ int iommu_map(struct iommu_domain *domain, unsigned
> long iova, int ret = 0;
> 
>  	if (unlikely(domain->ops->map == NULL ||
> -		     domain->ops->pgsize_bitmap == 0UL))
> +		     domain->pgsize_bitmap == 0UL))
>  		return -ENODEV;
> 
>  	/* find out the minimum page size supported */
> -	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> 
>  	/*
>  	 * both the virtual address and the physical one, as well as
> @@ -1096,11 +1096,11 @@ size_t iommu_unmap(struct iommu_domain *domain,
> unsigned long iova, size_t size) unsigned int min_pagesz;
> 
>  	if (unlikely(domain->ops->unmap == NULL ||
> -		     domain->ops->pgsize_bitmap == 0UL))
> +		     domain->pgsize_bitmap == 0UL))
>  		return -ENODEV;
> 
>  	/* find out the minimum page size supported */
> -	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> 
>  	/*
>  	 * The virtual address, as well as the size of the mapping, must be
> @@ -1146,10 +1146,10 @@ size_t default_iommu_map_sg(struct iommu_domain
> *domain, unsigned long iova, unsigned int i, min_pagesz;
>  	int ret;
> 
> -	if (unlikely(domain->ops->pgsize_bitmap == 0UL))
> +	if (unlikely(domain->pgsize_bitmap == 0UL))
>  		return 0;
> 
> -	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> 
>  	for_each_sg(sg, s, nents, i) {
>  		phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
> @@ -1230,7 +1230,7 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
> break;
>  	case DOMAIN_ATTR_PAGING:
>  		paging  = data;
> -		*paging = (domain->ops->pgsize_bitmap != 0UL);
> +		*paging = (domain->pgsize_bitmap != 0UL);
>  		break;
>  	case DOMAIN_ATTR_WINDOWS:
>  		count = data;
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 748693192c20..7e6c6a7afd81 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -872,6 +872,7 @@ static int ipmmu_domain_init(struct iommu_domain
> *io_domain)
> 
>  	io_domain->priv = domain;
>  	domain->io_domain = io_domain;
> +	domain->pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K;
> 
>  	return 0;
>  }
> @@ -1131,7 +1132,6 @@ static const struct iommu_ops ipmmu_ops = {
>  	.iova_to_phys = ipmmu_iova_to_phys,
>  	.add_device = ipmmu_add_device,
>  	.remove_device = ipmmu_remove_device,
> -	.pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K,
>  };
> 
>  /*
> ---------------------------------------------------------------------------
> -- diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c index
> e1b05379ca0e..8b623dce8161 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -230,6 +230,8 @@ static int msm_iommu_domain_init(struct iommu_domain
> *domain) domain->geometry.aperture_end   = (1ULL << 32) - 1;
>  	domain->geometry.force_aperture = true;
> 
> +	domain->pgsize_bitmap = MSM_IOMMU_PGSIZES;
> +
>  	return 0;
> 
>  fail_nomem:
> @@ -682,7 +684,6 @@ static const struct iommu_ops msm_iommu_ops = {
>  	.unmap = msm_iommu_unmap,
>  	.map_sg = default_iommu_map_sg,
>  	.iova_to_phys = msm_iommu_iova_to_phys,
> -	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
>  };
> 
>  static int __init get_tex_class(int icp, int ocp, int mt, int nos)
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index bbb7dcef02d3..bc4054967f18 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1250,6 +1250,8 @@ static int omap_iommu_domain_init(struct iommu_domain
> *domain) domain->geometry.aperture_end   = (1ULL << 32) - 1;
>  	domain->geometry.force_aperture = true;
> 
> +	domain->pgsize_bitmap = OMAP_IOMMU_PGSIZES;
> +
>  	return 0;
> 
>  fail_nomem:
> @@ -1368,7 +1370,6 @@ static const struct iommu_ops omap_iommu_ops = {
>  	.iova_to_phys	= omap_iommu_iova_to_phys,
>  	.add_device	= omap_iommu_add_device,
>  	.remove_device	= omap_iommu_remove_device,
> -	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
>  };
> 
>  static int __init omap_iommu_init(void)
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 6a8b1ec4a48a..5ab63e51e1c0 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -828,6 +828,7 @@ static int rk_iommu_domain_init(struct iommu_domain
> *domain) INIT_LIST_HEAD(&rk_domain->iommus);
> 
>  	domain->priv = rk_domain;
> +	domain->pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP;
> 
>  	return 0;
>  err_dt:
> @@ -961,7 +962,6 @@ static const struct iommu_ops rk_iommu_ops = {
>  	.add_device = rk_iommu_add_device,
>  	.remove_device = rk_iommu_remove_device,
>  	.iova_to_phys = rk_iommu_iova_to_phys,
> -	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
>  };
> 
>  static int rk_iommu_probe(struct platform_device *pdev)
> diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
> index f1b00774e4de..552bde09a69b 100644
> --- a/drivers/iommu/shmobile-iommu.c
> +++ b/drivers/iommu/shmobile-iommu.c
> @@ -101,6 +101,7 @@ static int shmobile_iommu_domain_init(struct
> iommu_domain *domain) spin_lock_init(&sh_domain->attached_list_lock);
>  	INIT_LIST_HEAD(&sh_domain->attached_list);
>  	domain->priv = sh_domain;
> +	domain->pgsize_bitmap = SZ_1M | SZ_64K | SZ_4K;
>  	return 0;
>  }
> 
> @@ -364,7 +365,6 @@ static const struct iommu_ops shmobile_iommu_ops = {
>  	.map_sg = default_iommu_map_sg,
>  	.iova_to_phys = shmobile_iommu_iova_to_phys,
>  	.add_device = shmobile_iommu_add_device,
> -	.pgsize_bitmap = SZ_1M | SZ_64K | SZ_4K,
>  };
> 
>  int ipmmu_iommu_init(struct shmobile_ipmmu *ipmmu)
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index f722a0c466cf..6404aba9667a 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -218,6 +218,7 @@ out:
> 
>  static int gart_iommu_domain_init(struct iommu_domain *domain)
>  {
> +	domain->pgsize_bitmap = GART_IOMMU_PGSIZES;
>  	return 0;
>  }
> 
> @@ -317,7 +318,6 @@ static const struct iommu_ops gart_iommu_ops = {
>  	.map		= gart_iommu_map,
>  	.unmap		= gart_iommu_unmap,
>  	.iova_to_phys	= gart_iommu_iova_to_phys,
> -	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
>  };
> 
>  static int tegra_gart_suspend(struct device *dev)
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 6e134c7c227f..a423ed9a19da 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -265,6 +265,7 @@ static int tegra_smmu_domain_init(struct iommu_domain
> *domain) pd[i] = 0;
> 
>  	domain->priv = as;
> +	domain->pgsize_bitmap = SZ_4K;
> 
>  	return 0;
>  }
> @@ -643,8 +644,6 @@ static const struct iommu_ops tegra_smmu_ops = {
>  	.unmap = tegra_smmu_unmap,
>  	.map_sg = default_iommu_map_sg,
>  	.iova_to_phys = tegra_smmu_iova_to_phys,
> -
> -	.pgsize_bitmap = SZ_4K,
>  };
> 
>  static void tegra_smmu_ahb_enable(void)
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c index 4a9d666f1e91..3bb72499e4e1 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -386,7 +386,7 @@ static unsigned long vfio_pgsize_bitmap(struct
> vfio_iommu *iommu)
> 
>  	mutex_lock(&iommu->lock);
>  	list_for_each_entry(domain, &iommu->domain_list, next)
> -		bitmap &= domain->domain->ops->pgsize_bitmap;
> +		bitmap &= domain->domain->pgsize_bitmap;
>  	mutex_unlock(&iommu->lock);
> 
>  	return bitmap;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 38daa453f2e5..ffc023e24b78 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -53,6 +53,7 @@ struct iommu_domain_geometry {
> 
>  struct iommu_domain {
>  	const struct iommu_ops *ops;
> +	unsigned long pgsize_bitmap;	/* Bitmap of supported page sizes */
>  	void *priv;
>  	iommu_fault_handler_t handler;
>  	void *handler_token;
> @@ -108,7 +109,6 @@ enum iommu_attr {
>   * @domain_get_attr: Query domain attributes
>   * @domain_set_attr: Change domain attributes
>   * @of_xlate: add OF master IDs to iommu grouping
> - * @pgsize_bitmap: bitmap of supported page sizes
>   * @priv: per-instance data private to the iommu driver
>   */
>  struct iommu_ops {
> @@ -144,9 +144,6 @@ struct iommu_ops {
>  #ifdef CONFIG_OF_IOMMU
>  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>  #endif
> -
> -	unsigned long pgsize_bitmap;
> -	void *priv;
>  };
> 
>  #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */

-- 
Regards,

Laurent Pinchart
