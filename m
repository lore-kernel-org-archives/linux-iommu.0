From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: arm-smmu: drop devm_free_irq when driver detach
Date: Tue, 12 Jul 2016 11:13:15 +0100
Message-ID: <5784C2BB.4000503@arm.com>
References: <1468287224-12036-1-git-send-email-van.freenix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468287224-12036-1-git-send-email-van.freenix@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Fan <van.freenix@gmail.com>, will.deacon@arm.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 12/07/16 02:33, Peng Fan wrote:
> There is no need to call devm_free_irq when driver detach.
> devres_release_all which is called after 'drv->remove' will
> release all managed resources.
> 
> Signed-off-by: Peng Fan <van.freenix@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>

drivers/iommu/arm-smmu.c: In function 'arm_smmu_device_remove':
drivers/iommu/arm-smmu.c:2021:6: warning: unused variable 'i'
[-Wunused-variable]
  int i;
      ^

With that addressed:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> ---
>  drivers/iommu/arm-smmu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 860652e..5837391c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2045,9 +2045,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>  	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>  		dev_err(dev, "removing device with active domains!\n");
>  
> -	for (i = 0; i < smmu->num_global_irqs; ++i)
> -		devm_free_irq(smmu->dev, smmu->irqs[i], smmu);
> -
>  	/* Turn the thing off */
>  	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>  	return 0;
> 
