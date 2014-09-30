From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu: add support for iova_to_phys
	through ATS1PR
Date: Tue, 30 Sep 2014 11:23:34 +0100
Message-ID: <20140930102334.GH8075@arm.com>
References: <1411874849-343-1-git-send-email-mitchelh@codeaurora.org>
	<1411874849-343-3-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411874849-343-3-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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

Hi Mitch,

On Sun, Sep 28, 2014 at 04:27:29AM +0100, Mitchel Humpherys wrote:
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
> +
> +	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
> +
> +	if (smmu->version == 1) {
> +		u32 reg = iova & ~0xFFF;

Cosmetic comment, but hex constants are lowercase everywhere else in the
file.

> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
> +	} else {
> +		u32 reg = iova & ~0xFFF;
> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
> +		reg = (iova & ~0xFFF) >> 32;
> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
> +	}
> +
> +	if (readl_poll_timeout(cb_base + ARM_SMMU_CB_ATSR, tmp,
> +				!(tmp & ATSR_ACTIVE), 10, ATSR_LOOP_TIMEOUT)) {
> +		dev_err(dev,
> +			"iova to phys timed out on 0x%pa. Falling back to software table walk.\n",
> +			&iova);
> +		return arm_smmu_iova_to_phys_soft(domain, iova);
> +	}
> +
> +	phys = readl_relaxed(cb_base + ARM_SMMU_CB_PAR_LO);
> +	phys |= ((u64) readl_relaxed(cb_base + ARM_SMMU_CB_PAR_HI)) << 32;

The absence of locking in this function concerns me a bit. For the software
implementation, we're just reading page tables, but here we're writing ATS
registers and I think we need to ensure serialisation against another
iova_to_phys on the same domain.

> +	if (phys & CB_PAR_F) {
> +		dev_err(dev, "translation fault!\n");
> +		dev_err(dev, "PAR = 0x%llx\n", phys);
> +	}
> +	phys = (phys & 0xFFFFFFF000ULL) | (iova & 0x00000FFF);
> +
> +	return phys;

You can return phys == 0 on failure (at least, the callers in kvm and vfio
treat this as an error).

Will
