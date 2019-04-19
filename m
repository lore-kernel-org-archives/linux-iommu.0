From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Log CBFRSYNRA register on context
 fault
Date: Thu, 18 Apr 2019 17:24:57 -0700
Message-ID: <20190419002457.GA3137@builder>
References: <4cfc7b3b-bc74-6b37-19f5-40b6394fa762@codeaurora.org>
 <20190415173758.22112-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415173758.22112-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon 15 Apr 10:37 PDT 2019, Vivek Gautam wrote:

> Bits[15:0] in CBFRSYNRA register contain information about
> StreamID of the incoming transaction that generated the
> fault. Dump CBFRSYNRA register to get this info.
> This is specially useful in a distributed SMMU architecture
> where multiple masters are connected to the SMMU.
> SID information helps to quickly identify the faulting
> master device.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
> V1 of the patch available @
> https://lore.kernel.org/patchwork/patch/1061615/
> 
> Changes from v1:
>  - Dump the raw register value of CBFRSYNRA register in the
>    context fault log rather than extracting the SID inforamtion
>    and dumping that.
> 
>  drivers/iommu/arm-smmu-regs.h | 2 ++
>  drivers/iommu/arm-smmu.c      | 8 ++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4ab5f8..e9132a926761 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -147,6 +147,8 @@ enum arm_smmu_s2cr_privcfg {
>  #define CBAR_IRPTNDX_SHIFT		24
>  #define CBAR_IRPTNDX_MASK		0xff
>  
> +#define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
> +
>  #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
>  #define CBA2R_RW64_32BIT		(0 << 0)
>  #define CBA2R_RW64_64BIT		(1 << 0)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 045d93884164..a4773e8c6b0e 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -575,7 +575,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
>  	void __iomem *cb_base;
> +	u32 cbfrsynra;
>  
>  	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
>  	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> @@ -585,10 +587,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  
>  	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
>  	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> +	cbfrsynra = readl_relaxed(gr1_base +
> +				  ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));

The 80 char limit is more like a guideline anyways...please don't wrap
this.

>  
>  	dev_err_ratelimited(smmu->dev,
> -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> -			    fsr, iova, fsynr, cfg->cbndx);
> +	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra = 0x%x, cb=%d\n",

Drop the spaces around '='.

With those addressed, you have my

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +			    fsr, iova, fsynr, cbfrsynra, cfg->cbndx);
>  
>  	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>  	return IRQ_HANDLED;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
