From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 2/2] iommu/arm-smmu: add support for iova_to_phys
	through ATS1PR
Date: Thu, 30 Oct 2014 11:38:08 +0000
Message-ID: <20141030113808.GA32589@arm.com>
References: <1414617220-21493-1-git-send-email-mitchelh@codeaurora.org>
	<1414617220-21493-3-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414617220-21493-3-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 29, 2014 at 09:13:40PM +0000, Mitchel Humpherys wrote:
> Currently, we provide the iommu_ops.iova_to_phys service by doing a
> table walk in software to translate IO virtual addresses to physical
> addresses. On SMMUs that support it, it can be useful to ask the SMMU
> itself to do the translation. This can be used to warm the TLBs for an
> SMMU. It can also be useful for testing and hardware validation.
> 
> Since the address translation registers are optional on SMMUv2, only
> enable hardware translations when using SMMUv1 or when SMMU_IDR0.S1TS=1
> and SMMU_IDR0.ATOSNS=0, as described in the ARM SMMU v1-v2 spec.
> 
> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> Changes since v6:
>   - added missing lock
>   - fixed physical address mask
> ---
>  drivers/iommu/arm-smmu.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 60558f7949..c6f96ba3b1 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -36,6 +36,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iommu.h>
> +#include <linux/iopoll.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -140,6 +141,7 @@
>  #define ID0_S2TS			(1 << 29)
>  #define ID0_NTS				(1 << 28)
>  #define ID0_SMS				(1 << 27)
> +#define ID0_ATOSNS			(1 << 26)
>  #define ID0_PTFS_SHIFT			24
>  #define ID0_PTFS_MASK			0x2
>  #define ID0_PTFS_V8_ONLY		0x2
> @@ -233,11 +235,16 @@
>  #define ARM_SMMU_CB_TTBR0_HI		0x24
>  #define ARM_SMMU_CB_TTBCR		0x30
>  #define ARM_SMMU_CB_S1_MAIR0		0x38
> +#define ARM_SMMU_CB_PAR_LO		0x50
> +#define ARM_SMMU_CB_PAR_HI		0x54
>  #define ARM_SMMU_CB_FSR			0x58
>  #define ARM_SMMU_CB_FAR_LO		0x60
>  #define ARM_SMMU_CB_FAR_HI		0x64
>  #define ARM_SMMU_CB_FSYNR0		0x68
>  #define ARM_SMMU_CB_S1_TLBIASID		0x610
> +#define ARM_SMMU_CB_ATS1PR_LO		0x800
> +#define ARM_SMMU_CB_ATS1PR_HI		0x804
> +#define ARM_SMMU_CB_ATSR		0x8f0
>  
>  #define SCTLR_S1_ASIDPNE		(1 << 12)
>  #define SCTLR_CFCFG			(1 << 7)
> @@ -249,6 +256,10 @@
>  #define SCTLR_M				(1 << 0)
>  #define SCTLR_EAE_SBOP			(SCTLR_AFE | SCTLR_TRE)
>  
> +#define CB_PAR_F			(1 << 0)
> +
> +#define ATSR_ACTIVE			(1 << 0)
> +
>  #define RESUME_RETRY			(0 << 0)
>  #define RESUME_TERMINATE		(1 << 0)
>  
> @@ -366,6 +377,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_TRANS_S1		(1 << 2)
>  #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
>  #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
> +#define ARM_SMMU_FEAT_TRANS_OPS		(1 << 5)
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
> @@ -1524,7 +1536,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>  	return ret ? 0 : size;
>  }
>  
> -static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
> +static phys_addr_t arm_smmu_iova_to_phys_soft(struct iommu_domain *domain,
>  					 dma_addr_t iova)
>  {
>  	pgd_t *pgdp, pgd;
> @@ -1557,6 +1569,67 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
>  	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
>  }
>  
> +static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
> +					dma_addr_t iova)
> +{
> +	struct arm_smmu_domain *smmu_domain = domain->priv;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	struct device *dev = smmu->dev;
> +	void __iomem *cb_base;
> +	u32 tmp;
> +	u64 phys;
> +	unsigned long flags;
> +
> +	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
> +
> +	spin_lock_irqsave(&smmu_domain->lock, flags);
> +
> +	if (smmu->version == 1) {
> +		u32 reg = iova & ~0xfff;
> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
> +	} else {
> +		u32 reg = iova & ~0xfff;
> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
> +		reg = (iova & ~0xfff) >> 32;
> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
> +	}
> +
> +	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
> +				!(tmp & ATSR_ACTIVE), 5, 50)) {
> +		spin_unlock_irqrestore(&smmu_domain->lock, flags);
> +		dev_err(dev,
> +			"iova to phys timed out on 0x%pa. Falling back to software table walk.\n",
> +			&iova);
> +		return arm_smmu_iova_to_phys_soft(domain, iova);
> +	}
> +
> +	phys = readl_relaxed(cb_base + ARM_SMMU_CB_PAR_LO);
> +	phys |= ((u64) readl_relaxed(cb_base + ARM_SMMU_CB_PAR_HI)) << 32;
> +
> +	spin_unlock_irqrestore(&smmu_domain->lock, flags);
> +
> +	if (phys & CB_PAR_F) {
> +		dev_err(dev, "translation fault!\n");
> +		dev_err(dev, "PAR = 0x%llx\n", phys);
> +		phys = 0;
> +	} else {
> +		phys = (phys & (PHYS_MASK & ~0xfffUL)) | (iova & 0xfff);

That probably wants to be ~0xfffULL for LPAE kernels.

With that:

  Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

I'm not sure how we should merge this, given the dependency on patch 1. If
you can get some acks there, then we can work out whether to take this via
the IOMMU tree or elsewhere.

Cheers,

Will
