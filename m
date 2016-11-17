From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] arm: dma-mapping: Reset the device's dma_ops
Date: Thu, 17 Nov 2016 13:00:38 +0100
Message-ID: <0144e67c-ee54-3cfb-872e-f01e702557a1@samsung.com>
References: <CGME20161117112121epcas5p2e4a3cb8471ae045daeb2ee11fc18fd7c@epcas5p2.samsung.com>
 <1479381645-3230-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-reply-to: <1479381645-3230-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>, rmk+kernel@armlinux.org.uk, robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Sricharan,


On 2016-11-17 12:20, Sricharan R wrote:
> arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
> ,dma_ops should be cleared in the teardown path. Otherwise
> this causes problem when the probe of device is retried after
> being deferred. The device's iommu structures are cleared
> after EPROBEDEFER error, but on the next try dma_ops will still
> be set to old value, which is not right.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/mm/dma-mapping.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index ab4f745..a40f03e 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2358,6 +2358,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
>   
>   	__arm_iommu_detach_device(dev);
>   	arm_iommu_release_mapping(mapping);
> +	set_dma_ops(dev, NULL);
>   }
>   
>   #else

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
