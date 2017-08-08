From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/arm-smmu: Track context bank state
Date: Tue, 8 Aug 2017 12:11:51 +0100
Message-ID: <20170808111151.GC13355@arm.com>
References: <71247263f4d88e7776f483fb1cc1139b516c0835.1500381551.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <71247263f4d88e7776f483fb1cc1139b516c0835.1500381551.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

I like the idea, but I think there are a few minor issues with the patch.
Comments below.

On Tue, Jul 18, 2017 at 01:44:41PM +0100, Robin Murphy wrote:
> Echoing what we do for Stream Map Entries, maintain a software shadow
> state for context bank configuration. With this in place, we are mere
> moments away from blissfully easy suspend/resume support.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Since the runtime PM discussion has come back again, I figured it was
> probably about time to finish off my plan for system PM. Lightly tested
> on Juno (MMU-401) with hibernation.
> 
> Robin.
> 
>  drivers/iommu/arm-smmu.c | 159 +++++++++++++++++++++++++++++------------------
>  1 file changed, 97 insertions(+), 62 deletions(-)

[...]

> +static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> +{
> +	u32 reg;
> +	bool stage1;
> +	struct arm_smmu_cb *cb = &smmu->cbs[idx];
> +	struct arm_smmu_cfg *cfg = cb->cfg;
> +	struct arm_smmu_cfg default_cfg = {0};
>  	void __iomem *cb_base, *gr1_base;
>  
> +	if (!cfg)
> +		cfg = &default_cfg;
> +
>  	gr1_base = ARM_SMMU_GR1(smmu);
>  	stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
> -	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
> +	cb_base = ARM_SMMU_CB(smmu, idx);
>  
> +	/* CBA2R */
>  	if (smmu->version > ARM_SMMU_V1) {
>  		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
>  			reg = CBA2R_RW64_64BIT;
> @@ -788,7 +848,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>  		if (smmu->features & ARM_SMMU_FEAT_VMID16)
>  			reg |= cfg->vmid << CBA2R_VMID_SHIFT;
>  
> -		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
> +		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(idx));
>  	}
>  
>  	/* CBAR */
> @@ -807,72 +867,43 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>  		/* 8-bit VMIDs live in CBAR */
>  		reg |= cfg->vmid << CBAR_VMID_SHIFT;
>  	}
> -	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
> +	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(idx));
>  
>  	/*
>  	 * TTBCR
>  	 * We must write this before the TTBRs, since it determines the
>  	 * access behaviour of some fields (in particular, ASID[15:8]).
>  	 */
> -	if (stage1) {
> -		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
> -			reg = pgtbl_cfg->arm_v7s_cfg.tcr;
> -			reg2 = 0;
> -		} else {
> -			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
> -			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
> -			reg2 |= TTBCR2_SEP_UPSTREAM;
> -			if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
> -				reg2 |= TTBCR2_AS;
> -		}
> -		if (smmu->version > ARM_SMMU_V1)
> -			writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);
> -	} else {
> -		reg = pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
> -	}
> -	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
> +	if (stage1 && smmu->version > ARM_SMMU_V1)
> +		writel_relaxed(cb->tcr[1], cb_base + ARM_SMMU_CB_TTBCR2);
> +	writel_relaxed(cb->tcr[0], cb_base + ARM_SMMU_CB_TTBCR);
>  
>  	/* TTBRs */
> -	if (stage1) {
> -		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
> -			reg = pgtbl_cfg->arm_v7s_cfg.ttbr[0];
> -			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0);
> -			reg = pgtbl_cfg->arm_v7s_cfg.ttbr[1];
> -			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1);
> -			writel_relaxed(cfg->asid, cb_base + ARM_SMMU_CB_CONTEXTIDR);
> -		} else {
> -			reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> -			reg64 |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
> -			writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR0);
> -			reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
> -			reg64 |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
> -			writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR1);
> -		}
> +	if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
> +		writel_relaxed(cfg->asid, cb_base + ARM_SMMU_CB_CONTEXTIDR);
> +		writel_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
> +		writel_relaxed(cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);
>  	} else {
> -		reg64 = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
> -		writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR0);
> +		writeq_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
> +		writeq_relaxed(cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);

This doesn't look right to me. For the LPAE S1 case, we don't set the ASID
afaict, and for the S2 case we write to a RESERVED register (since we only
have one TTBR).
>  	}
>  
>  	/* MAIRs (stage-1 only) */
>  	if (stage1) {
> -		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
> -			reg = pgtbl_cfg->arm_v7s_cfg.prrr;
> -			reg2 = pgtbl_cfg->arm_v7s_cfg.nmrr;
> -		} else {
> -			reg = pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
> -			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.mair[1];
> -		}
> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_S1_MAIR0);
> -		writel_relaxed(reg2, cb_base + ARM_SMMU_CB_S1_MAIR1);
> +		writel_relaxed(cb->mair[0], cb_base + ARM_SMMU_CB_S1_MAIR0);
> +		writel_relaxed(cb->mair[1], cb_base + ARM_SMMU_CB_S1_MAIR1);
>  	}
>  
>  	/* SCTLR */
> -	reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
> -	if (stage1)
> -		reg |= SCTLR_S1_ASIDPNE;
> -#ifdef __BIG_ENDIAN
> -	reg |= SCTLR_E;
> -#endif
> +	if (!cb->cfg) {
> +		reg = 0;

I think this might be too late. See below.

> +	} else {
> +		reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
> +		if (stage1)
> +			reg |= SCTLR_S1_ASIDPNE;
> +		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +			reg |= SCTLR_E;
> +	}
>  	writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
>  }
>  
> @@ -1035,6 +1066,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  
>  	/* Initialise the context bank with our page table cfg */
>  	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> +	arm_smmu_write_context_bank(smmu, cfg->cbndx);
>  
>  	/*
>  	 * Request context fault interrupt. Do this last to avoid the
> @@ -1067,7 +1099,6 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> -	void __iomem *cb_base;
>  	int irq;
>  
>  	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
> @@ -1077,8 +1108,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>  	 * Disable the context bank and free the page tables before freeing
>  	 * it.
>  	 */
> -	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
> -	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
> +	smmu->cbs[cfg->cbndx] = (struct arm_smmu_cb){0};
> +	arm_smmu_write_context_bank(smmu, cfg->cbndx);

So here, we end up passing a zeroed structure to
arm_smmu_write_context_bank, but afaict that will write to the TTBR and TCR
before SCTLR, which worries me. Couldn't we get whacky speculative table
walks through physical address 0 with ASID 0 before we kill the SCTLR?

If the only time we pass something with a NULL cfg is on the destroy path,
perhaps just do:

  if (!cfg) {
	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
	return;
  }

instead?

Will
