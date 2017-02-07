From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 09/10] iommu/exynos: Make use of iommu_device_register
 interface
Date: Tue, 07 Feb 2017 13:36:15 +0100
Message-ID: <3e4709a7-2231-7c76-18bd-6e2d6b802b8e@samsung.com>
References: <1486397429-29327-1-git-send-email-joro@8bytes.org>
 <CGME20170206161330epcas3p185c7719afc89ab2ad87e55e9f62ccfa1@epcas3p1.samsung.com>
 <1486397429-29327-10-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1486397429-29327-10-git-send-email-joro@8bytes.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 2017-02-06 17:10, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Register Exynos IOMMUs to the IOMMU core and make them
> visible in sysfs. This patch does not add the links between
> IOMMUs and translated devices yet.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/exynos-iommu.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 57ba0d3..90f0f52 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -276,6 +276,8 @@ struct sysmmu_drvdata {
>   	struct list_head owner_node;	/* node for owner controllers list */
>   	phys_addr_t pgtable;		/* assigned page table structure */
>   	unsigned int version;		/* our version */
> +
> +	struct iommu_device iommu;	/* IOMMU core handle */
>   };
>   
>   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> @@ -556,6 +558,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct sysmmu_drvdata *data;
>   	struct resource *res;
> +	resource_size_t ioaddr;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -565,6 +568,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>   	data->sfrbase = devm_ioremap_resource(dev, res);
>   	if (IS_ERR(data->sfrbase))
>   		return PTR_ERR(data->sfrbase);
> +	ioaddr = res->start;
>   
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq <= 0) {
> @@ -611,6 +615,18 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>   	data->sysmmu = dev;
>   	spin_lock_init(&data->lock);
>   
> +	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
> +				     "sysmmu.%pa", &ioaddr);

Can we stick to the common name across the /sysfs and use 
dev_name(data->sysmmu)
or even dev_name(dev) here?

ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL, 
dev_name(dev));

> +	if (ret)
> +		return ret;
> +
> +	data->iommu.ops    = &exynos_iommu_ops;
> +	data->iommu.fwnode = &dev->of_node->fwnode;
> +
> +	ret = iommu_device_register(&data->iommu);
> +	if (ret)
> +		return ret;
> +
>   	platform_set_drvdata(pdev, data);
>   
>   	__sysmmu_get_version(data);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
