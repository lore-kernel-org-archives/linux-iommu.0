From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/5] iommu/rockchip: fix devm_request_irq and devm_free_irq parameter
Date: Mon, 23 May 2016 11:28:32 +0200
Message-ID: <3963127.FSql0rTeZT@phil>
References: <1463967439-13354-1-git-send-email-zhengsq@rock-chips.com> <1463967439-13354-2-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463967439-13354-2-git-send-email-zhengsq@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shunqian Zheng <zhengsq@rock-chips.com>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Simon <xxm@rock-chips.com>
List-Id: iommu@lists.linux-foundation.org

Am Montag, 23. Mai 2016, 09:37:15 schrieb Shunqian Zheng:
> From: Simon <xxm@rock-chips.com>

generally a "firstname surename <mail>" is expected, so a first name is not 
really enough.

> 
> When rk_iommu_attach_device or rk_iommu_detach_device be called, the
> second parameter "dev" represent the device who own the iommu, so it is
> not resonable using "dev" for devm_request_irq's first parameter. To
> avoid potential error, we must use iommu device itself "iommu->dev"
> instead, the same as devm_free_irq.
> 
> Signed-off-by: Simon <xxm@rock-chips.com>

same here, and the person sending in the patch also needs a signed-off-by 
line, so that should look like

Signed-off-by: Simon <xxm@rock-chips.com>
Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>

The same applies of course for all other affected patches of this series.


After looking at the iommu code, I think the change itself looks sane, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

although I wonder what we need the devm_* for if we request and free the 
irqs manually all the time anyway?


Heiko

> ---
>  drivers/iommu/rockchip-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c
> b/drivers/iommu/rockchip-iommu.c index c7d6156..ec0ce62 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -807,7 +807,7 @@ static int rk_iommu_attach_device(struct iommu_domain
> *domain,
> 
>  	iommu->domain = domain;
> 
> -	ret = devm_request_irq(dev, iommu->irq, rk_iommu_irq,
> +	ret = devm_request_irq(iommu->dev, iommu->irq, rk_iommu_irq,
>  			       IRQF_SHARED, dev_name(dev), iommu);
>  	if (ret)
>  		return ret;
> @@ -860,7 +860,7 @@ static void rk_iommu_detach_device(struct iommu_domain
> *domain, }
>  	rk_iommu_disable_stall(iommu);
> 
> -	devm_free_irq(dev, iommu->irq, iommu);
> +	devm_free_irq(iommu->dev, iommu->irq, iommu);
> 
>  	iommu->domain = NULL;
