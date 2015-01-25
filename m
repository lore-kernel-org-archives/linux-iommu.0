From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 11/18] iommu: exynos: remove useless device_add/remove callbacks
Date: Sun, 25 Jan 2015 17:38:22 +0200
Message-ID: <2829552.kzfCU5HyxQ@avalon>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com> <1422028288-891-12-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422028288-891-12-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

Thank you for the patch.

On Friday 23 January 2015 16:51:21 Marek Szyprowski wrote:
> The driver doesn't need to do anything important in device add/remove
> callbacks, because initialization will be done from device-tree specific
> callbacks added later. IOMMU groups created by current code were never
> used.

IOMMU groups still seem a bit unclear to me. Will Deacon has nicely explained 
what they represent in http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310816.html. The IOMMU core doesn't make groups 
mandatory, but requires them in some code paths.

For example the coldplug device add function add_iommu_group() called for all 
devices already registered when bus_set_iommu() is called will try to warn of 
devices added multiple times with a WARN_ON(dev->iommu_group). Another example 
is the iommu_bus_notifier() function which will call the remove_device() 
operation only when dev->iommu_group isn't NULL.

I'm thus unsure whether groups should be made mandatory, or whether the IOMMU 
core should be fixed to make them really optional (or, third option, whether 
there's something I haven't understood properly).

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index e62cb96..e40e699 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1055,32 +1055,6 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct
> iommu_domain *domain, return phys;
>  }
> 
> -static int exynos_iommu_add_device(struct device *dev)
> -{
> -	struct iommu_group *group;
> -	int ret;
> -
> -	group = iommu_group_get(dev);
> -
> -	if (!group) {
> -		group = iommu_group_alloc();
> -		if (IS_ERR(group)) {
> -			dev_err(dev, "Failed to allocate IOMMU group\n");
> -			return PTR_ERR(group);
> -		}
> -	}
> -
> -	ret = iommu_group_add_device(group, dev);
> -	iommu_group_put(group);
> -
> -	return ret;
> -}
> -
> -static void exynos_iommu_remove_device(struct device *dev)
> -{
> -	iommu_group_remove_device(dev);
> -}
> -
>  static const struct iommu_ops exynos_iommu_ops = {
>  	.domain_init = exynos_iommu_domain_init,
>  	.domain_destroy = exynos_iommu_domain_destroy,
> @@ -1090,8 +1064,6 @@ static const struct iommu_ops exynos_iommu_ops = {
>  	.unmap = exynos_iommu_unmap,
>  	.map_sg = default_iommu_map_sg,
>  	.iova_to_phys = exynos_iommu_iova_to_phys,
> -	.add_device = exynos_iommu_add_device,
> -	.remove_device = exynos_iommu_remove_device,
>  	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>  };

-- 
Regards,

Laurent Pinchart
