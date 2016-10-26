From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
Date: Wed, 26 Oct 2016 16:07:12 +0100
Message-ID: <a3d4533f-165d-f444-7681-141479617a18@arm.com>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <1475600632-21289-7-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1475600632-21289-7-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, laurent.pinchart@ideasonboard.com, m.szyprowski@samsung.com, tfiga@chromium.org, srinivas.kandagatla@linaro.org
List-Id: iommu@lists.linux-foundation.org

On 04/10/16 18:03, Sricharan R wrote:
> The dma_ops for the device is not getting set to NULL in
> arch_tear_down_dma_ops and this causes an issue when the
> device's probe gets deferred and retried. So reset the
> dma_ops to NULL.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

This seems like it could stand independently from the rest of the series
- might be worth rewording the commit message to more general terms,
i.e. arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
thus clearing the ops set by the latter, and sending it to Russell as a
fix in its own right.

Robin.

> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/mm/dma-mapping.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index dde6514..b9191f0 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2295,6 +2295,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
>  
>  	__arm_iommu_detach_device(dev);
>  	arm_iommu_release_mapping(mapping);
> +	set_dma_ops(dev, NULL);
>  }
>  
>  #else
> 
