From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2] iommu/rockchip: add multi irqs support
Date: Fri, 21 Jul 2017 10:02:40 +0800
Message-ID: <944370c8-7ac7-8e87-62f1-109284350544@rock-chips.com>
References: <1500600921-102537-1-git-send-email-xxm@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500600921-102537-1-git-send-email-xxm@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Xue <xxm@rock-chips.com>
Cc: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>, shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Simon,

On 2017/7/21 9:35, Simon Xue wrote:
> From: Simon <xxm@rock-chips.com>
> 
> RK3368 vpu mmu have two irqs, this patch support multi irqs
> 
> Signed-off-by: Simon <xxm@rock-chips.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 4ba48a2..b38283e 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -90,7 +90,8 @@ struct rk_iommu {
>   	struct device *dev;
>   	void __iomem **bases;
>   	int num_mmu;
> -	int irq;
> +	int *irq > +	int num_irq;
>   	struct iommu_device iommu;
>   	struct list_head node; /* entry in rk_iommu_domain.iommus */
>   	struct iommu_domain *domain; /* domain to which iommu is attached */
> @@ -825,10 +826,12 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   	iommu->domain = domain;
>   
> -	ret = devm_request_irq(iommu->dev, iommu->irq, rk_iommu_irq,
> -			       IRQF_SHARED, dev_name(dev), iommu);
> -	if (ret)
> -		return ret;
> +	for (i = 0; i < iommu->num_irq; i++) {
> +		ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
> +				       IRQF_SHARED, dev_name(dev), iommu);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	for (i = 0; i < iommu->num_mmu; i++) {
>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
> @@ -878,7 +881,8 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>   	}
>   	rk_iommu_disable_stall(iommu);
>   
> -	devm_free_irq(iommu->dev, iommu->irq, iommu);
> +	for (i = 0; i < iommu->num_irq; i++)
> +		devm_free_irq(iommu->dev, iommu->irq[i], iommu);
>   
>   	iommu->domain = NULL;
>   
> @@ -1157,10 +1161,20 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	if (iommu->num_mmu == 0)
>   		return PTR_ERR(iommu->bases[0]);
>   
> -	iommu->irq = platform_get_irq(pdev, 0);
> -	if (iommu->irq < 0) {
> -		dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq);
> -		return -ENXIO;
> +	while (platform_get_irq(pdev, iommu->num_irq) >= 0)
> +		iommu->num_irq++;
> +
> +	iommu->irq = devm_kzalloc(dev, sizeof(*iommu->irq) * iommu->num_irq,
> +				  GFP_KERNEL);

Prefer to used devm_kcalloc for array allocation,see
Documentation/process/coding-style.rst +831

> +	if (!iommu->irq)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < iommu->num_irq; i++) {
> +		iommu->irq[i] = platform_get_irq(pdev, i);
> +		if (iommu->irq[i] < 0) {
> +			dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq[i]);
> +			return -ENXIO;
> +		}
>   	}
>   
>   	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
> 
