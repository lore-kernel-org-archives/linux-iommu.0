From: Inki Dae <inki.dae@samsung.com>
Subject: RE: [PATCH] iommu/exynos: add devices attached to the System MMU to an
 IOMMU group
Date: Tue, 23 Jul 2013 19:31:54 +0900
Message-ID: <00d701ce878f$da099fe0$8e1cdfa0$%dae@samsung.com>
References: <1374573694-30595-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1374573694-30595-1-git-send-email-a.motakis@virtualopensystems.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Antonios Motakis' <a.motakis@virtualopensystems.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: kvmarm@lists.cs.columbia.edu, 'Cho KyongHo' <pullip.cho@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Jiri Kosina' <jkosina@suse.cz>, 'Wei Yongjun' <yongjun_wei@trendmicro.com.cn>, 'open list' <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: linux-samsung-soc-owner@vger.kernel.org [mailto:linux-samsung-soc-
> owner@vger.kernel.org] On Behalf Of Antonios Motakis
> Sent: Tuesday, July 23, 2013 7:02 PM
> To: linux-arm-kernel@lists.infradead.org;
iommu@lists.linux-foundation.org;
> linux-samsung-soc@vger.kernel.org
> Cc: kvmarm@lists.cs.columbia.edu; Antonios Motakis; Cho KyongHo; Joerg
> Roedel; Sachin Kamat; Jiri Kosina; Wei Yongjun; open list
> Subject: [PATCH] iommu/exynos: add devices attached to the System MMU to
> an IOMMU group
> 
> IOMMU groups are expected by certain users of the IOMMU API,
> e.g. VFIO. Since each device is behind its own System MMU, we
> can allocate a new IOMMU group for each device.
> 
> This patch depends on Cho KyongHo's patch series titled "[PATCH v7 00/12]
> iommu/exynos: Fixes and Enhancements of System MMU driver with DT",
> applied on a Linux 3.10.1 kernel. It has been tested on the Arndale board.
> 
> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> ---
>  drivers/iommu/exynos-iommu.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 51d43bb..9f39eaa 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1134,6 +1134,28 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct
> iommu_domain *domain,
>  	return phys;
>  }
> 
> +static int exynos_iommu_add_device(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	int ret;
> +
> +	group = iommu_group_alloc();

Is that correct? I don't see why you allocate a group object every time
add_device callback is called. That doesn't have any meaning we have to use
iommu group feature. I think the implementation should be one more devices
per a group. So I guess a given device object should be wrapped by higher
device object than the given device object. For a good example, you can
refer to intel-iommu.c file.

Thanks,
Inki Dae

> +	if (IS_ERR(group)) {
> +		dev_err(dev, "Failed to allocate IOMMU group\n");
> +		return PTR_ERR(group);
> +	}
> +
> +	ret = iommu_group_add_device(group, dev);
> +	iommu_group_put(group);
> +
> +	return ret;
> +}
> +
> +static void exynos_iommu_remove_device(struct device *dev)
> +{
> +	iommu_group_remove_device(dev);
> +}
> +
>  static struct iommu_ops exynos_iommu_ops = {
>  	.domain_init = &exynos_iommu_domain_init,
>  	.domain_destroy = &exynos_iommu_domain_destroy,
> @@ -1142,6 +1164,8 @@ static struct iommu_ops exynos_iommu_ops = {
>  	.map = &exynos_iommu_map,
>  	.unmap = &exynos_iommu_unmap,
>  	.iova_to_phys = &exynos_iommu_iova_to_phys,
> +	.add_device	= exynos_iommu_add_device,
> +	.remove_device	= exynos_iommu_remove_device,
>  	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>  };
> 
> --
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
