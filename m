From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 2/2] iommu/arm-smmu: add support for iova_to_phys
	through ATS1PR
Date: Mon, 27 Oct 2014 11:44:31 +0000
Message-ID: <20141027114430.GK8768@arm.com>
References: <1413323610-27484-1-git-send-email-mitchelh@codeaurora.org>
	<1413323610-27484-3-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413323610-27484-3-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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

On Tue, Oct 14, 2014 at 10:53:30PM +0100, Mitchel Humpherys wrote:
> Currently, we provide the iommu_ops.iova_to_phys service by doing a
> table walk in software to translate IO virtual addresses to physical
> addresses. On SMMUs that support it, it can be useful to ask the SMMU
> itself to do the translation. This can be used to warm the TLBs for an
> SMMU. It can also be useful for testing and hardware validation.
> 
> Since the address translation registers are optional on SMMUv2, only
> enable hardware translations when using SMMUv1 or when SMMU_IDR0.S1TS=1
> and SMMU_IDR0.ATOSNS=0, as described in the ARM SMMU v1-v2 spec.

[...]

> -static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
> +static phys_addr_t arm_smmu_iova_to_phys_soft(struct iommu_domain *domain,
>  					 dma_addr_t iova)
>  {
>  	pgd_t *pgdp, pgd;
> @@ -1557,6 +1569,66 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
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
> +		dev_err(dev,
> +			"iova to phys timed out on 0x%pa. Falling back to software table walk.\n",
> +			&iova);
> +		return arm_smmu_iova_to_phys_soft(domain, iova);

Missing unlock here.

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
> +		phys = (phys & 0xfffffff000ULL) | (iova & 0x00000fff);
> +	}

I think your mask is too big here -- SMMUv2 puts the MAIR in the top byte.
It probably makes more sense to use PHYS_MASK & ~0xfffUL.

Will
