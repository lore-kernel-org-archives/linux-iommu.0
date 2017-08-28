From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/3] iommu: exynos: constify iommu_ops
Date: Mon, 28 Aug 2017 15:13:43 +0200
Message-ID: <18f05dd3-4305-e607-57bb-dea086481bb8@samsung.com>
References: <CGME20170828121232epcas2p49f8a17002f18d19b613b43ba38f71df9@epcas2p4.samsung.com>
        <1503922325-25905-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1503922325-25905-1-git-send-email-arvind.yadav.cs@gmail.com>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, joro@8bytes.org, kgene@kernel.org, krzk@kernel.org, matthias.bgg@gmail.com, gerald.schaefer@de.ibm.com
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Arvind,

On 2017-08-28 14:12, Arvind Yadav wrote:
> iommu_ops are not supposed to change at runtime.
> Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
> const iommu_ops provided by <linux/iommu.h>. So mark the non-const
> structs as const.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

I remember that in the past there were a reason for non-const iommu_ops 
in the
IOMMU API, but I hope it has been finally resolved.

> ---
>   drivers/iommu/exynos-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 2395478..a540016 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -569,7 +569,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
>   	spin_unlock_irqrestore(&data->lock, flags);
>   }
>   
> -static struct iommu_ops exynos_iommu_ops;
> +static const struct iommu_ops exynos_iommu_ops;
>   
>   static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>   {
> @@ -1323,7 +1323,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
>   	return 0;
>   }
>   
> -static struct iommu_ops exynos_iommu_ops = {
> +static const struct iommu_ops exynos_iommu_ops = {
>   	.domain_alloc = exynos_iommu_domain_alloc,
>   	.domain_free = exynos_iommu_domain_free,
>   	.attach_dev = exynos_iommu_attach_device,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
