From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] ARM: dma-mapping: Clear DMA ops on teardown
Date: Mon, 4 Feb 2019 12:48:14 +0100
Message-ID: <a2013d45-69d4-5c24-f833-a27e5ac20cb8@samsung.com>
References: <CGME20190121145305epcas4p1df032b4c2c44d5f291eb2bedde9de40d@epcas4p1.samsung.com>
        <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, treding@nvidia.com, rmk+kernel@armlinux.org.uk, bskeggs@redhat.com, tjakobi@math.uni-bielefeld.de, b.zolnierkie@samsung.com
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 2019-01-21 15:52, Robin Murphy wrote:
> Installing the appropriate non-IOMMU DMA ops in arm_iommu_detch_device()
> serves the case where IOMMU-aware drivers choose to control their own
> mapping but still make DMA API calls, however it also affects the case
> when the arch code itself tears down the mapping upon driver unbinding,
> where the ops now get left in place and can inhibit arch_setup_dma_ops()
> on subsequent re-probe attempts.
>
> Fix the latter case by making sure that arch_teardown_dma_ops() cleans
> up whenever the ops were automatically installed by its counterpart.
>
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
> Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Sorry for the delay - there was a giant email infrastructure cock-up just
> at the point I wanted to go back through my archive and double-check the
> discussion around the original commit...

No problem, could you also upload it to rmk's patch tracking system?
IMHO rmk's tree will be the best place to handle this fix.

> Robin.
>
>  arch/arm/mm/dma-mapping.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f1e2922e447c..1e3e08a1c456 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
>  		return;
>  
>  	arm_teardown_iommu_dma_ops(dev);
> +	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
> +	set_dma_ops(dev, NULL);
>  }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
