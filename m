From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu: Error out only if not enough context
 interrupts
Date: Tue, 24 Jul 2018 09:36:34 +0100
Message-ID: <20180724083633.GA19324@arm.com>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-4-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180719175356.14753-4-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com, andy.gross@linaro.org, mark.rutland@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tfiga@chromium.org, sricharan@codeaurora.org, linux-arm-msm@vger.kernel.org, david.brown@linaro.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 19, 2018 at 11:23:56PM +0530, Vivek Gautam wrote:
> Currently we check if the number of context banks is not equal to
> num_context_interrupts. However, there are booloaders such as, one
> on sdm845 that reserves few context banks and thus kernel views
> less than the total available context banks.
> So, although the hardware definition in device tree would mention
> the correct number of context interrupts, this number can be
> greater than the number of context banks visible to smmu in kernel.
> We should therefore error out only when the number of context banks
> is greater than the available number of context interrupts.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7c69736a30f8..4cb53bf4f423 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2229,12 +2229,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	if (smmu->version == ARM_SMMU_V2 &&
> -	    smmu->num_context_banks != smmu->num_context_irqs) {
> -		dev_err(dev,
> -			"found only %d context interrupt(s) but %d required\n",
> -			smmu->num_context_irqs, smmu->num_context_banks);
> -		return -ENODEV;
> +	if (smmu->version == ARM_SMMU_V2) {
> +		if (smmu->num_context_banks > smmu->num_context_irqs) {
> +			dev_err(dev,
> +			      "found only %d context irq(s) but %d required\n",
> +			      smmu->num_context_irqs, smmu->num_context_banks);
> +			return -ENODEV;
> +		} else if (smmu->num_context_banks < smmu->num_context_irqs) {
> +			/* loose extra context interrupts */
> +			dev_notice(dev,
> +			      "found %d context irq(s) but only %d required\n",
> +			      smmu->num_context_irqs, smmu->num_context_banks);
> +			smmu->num_context_irqs = smmu->num_context_banks;
> +		}

I don't see the utility in the new message. Can you simplify with the patch
below on top? It's a bit weird that we only decide to ignore the extra irqs
after calling platform_get_irq() on them, but that seems to be harmless.

Will

--->8

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index aa46c1ed5bf9..5349e22b5c78 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2109,13 +2109,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 			      "found only %d context irq(s) but %d required\n",
 			      smmu->num_context_irqs, smmu->num_context_banks);
 			return -ENODEV;
-		} else if (smmu->num_context_banks < smmu->num_context_irqs) {
-			/* loose extra context interrupts */
-			dev_notice(dev,
-			      "found %d context irq(s) but only %d required\n",
-			      smmu->num_context_irqs, smmu->num_context_banks);
-			smmu->num_context_irqs = smmu->num_context_banks;
 		}
+
+		/* Ignore superfluous interrupts */
+		smmu->num_context_irqs = smmu->num_context_banks;
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
