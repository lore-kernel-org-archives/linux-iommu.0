From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] iommu/arm-smmu: Add context save restore support
Date: Wed, 26 Oct 2016 17:51:56 +0100
Message-ID: <ddfbb897-b284-5caf-dab7-9b3de08619bd@arm.com>
References: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org>
 <1477070066-15044-4-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1477070066-15044-4-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>, m.szyprowski@samsung.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
List-Id: iommu@lists.linux-foundation.org

On 21/10/16 18:14, Sricharan R wrote:
> The smes registers and the context bank registers are
> the ones that are needs to be saved and restored.
> Fortunately the smes are already stored as a part

"Fortunately"? Hey, that's by design! :P

I was actually planning to finish off suspend/resume beyond those
foundations laid by the big rework, so it's nice to see something already.

> of the smmu device structure. So just write that
> back. The data required to configure the context banks
> are the master's domain data and pgtable cfgs.
> So store them as a part of the context banks info
> and just reconfigure the context banks on the restore
> path.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 45f2762..578cdc2 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -328,6 +328,11 @@ struct arm_smmu_master_cfg {
>  #define for_each_cfg_sme(fw, i, idx) \
>  	for (i = 0; idx = __fwspec_cfg(fw)->smendx[i], i < fw->num_ids; ++i)
>  
> +struct cbinfo {
> +	struct arm_smmu_domain		*domain;
> +	struct io_pgtable_cfg		pgtbl_cfg;
> +};
> +
>  struct arm_smmu_device {
>  	struct device			*dev;
>  
> @@ -378,6 +383,9 @@ struct arm_smmu_device {
>  	struct clk                      **clocks;
>  
>  	u32				cavium_id_base; /* Specific to Cavium */
> +
> +	/* For save/restore of context bank registers */
> +	struct cbinfo                   *cb_saved_ctx;

I'd prefer to follow the same pattern for context banks as for the
stream map registers, i.e. keep just the smmu pointer and cbndx in the
arm_smmu_domain, and move the rest of the context bank state to the
arm_smmu_device. Yes, it requires rather more refactoring, but it's
going to result in cleaner and more obvious code in the end.

>  };
>  
>  enum arm_smmu_context_fmt {
> @@ -972,6 +980,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  
>  	/* Initialise the context bank with our page table cfg */
>  	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
> +	smmu->cb_saved_ctx[cfg->cbndx].domain = smmu_domain;
> +	smmu->cb_saved_ctx[cfg->cbndx].pgtbl_cfg = pgtbl_cfg;
>  
>  	/*
>  	 * Request context fault interrupt. Do this last to avoid the
> @@ -1861,6 +1871,10 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  	}
>  	dev_notice(smmu->dev, "\t%u context banks (%u stage-2 only)\n",
>  		   smmu->num_context_banks, smmu->num_s2_context_banks);
> +
> +	smmu->cb_saved_ctx = devm_kzalloc(smmu->dev,
> +			     sizeof(struct cbinfo) * smmu->num_context_banks,
> +			     GFP_KERNEL);
>  	/*
>  	 * Cavium CN88xx erratum #27704.
>  	 * Ensure ASID and VMID allocation is unique across all SMMUs in
> @@ -2115,8 +2129,44 @@ static int arm_smmu_resume(struct device *dev)
>  {
[...]
  	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
[...]
	int ret = arm_smmu_enable_clocks(smmu);
> +	if (ret)
> +		return ret;
> +
> +	arm_smmu_device_reset(smmu);

For reference, what I'm aiming for is for that to be the entire resume
function.

> -	return arm_smmu_enable_clocks(smmu);
> +	/* Restore the smes and the context banks */
> +	for (idx = 0; idx < smmu->num_mapping_groups; ++idx) {
> +		mutex_lock(&smmu->stream_map_mutex);

What are we taking this lock to protect against - can we resume one SMMU
multiple times in parallel?

> +		if (!smrs[idx].valid) {
> +			mutex_unlock(&smmu->stream_map_mutex);
> +			continue;

Nope, you can't skip anything, because there's no guarantee the SMRs (or
anything else) which are invalid in the saved state are also invalid in
the current hardware state. Consider the case of restoring from hibernate.

> +		}
> +
> +		arm_smmu_write_sme(smmu, idx);

arm_smmu_device_reset() already did that.

> +		cb = smmu->s2crs[idx].cbndx;
> +		mutex_unlock(&smmu->stream_map_mutex);
> +
> +		if (!i || (cb != pcb)) {

This took a while to figure out, and it seems like an unnecessary
micro-optimisation since it still doesn't actually prevent initialising
the same context bank multiple times (there's no guarantee that all
s2crs targeting that context are consecutive).

> +			domain = smmu->cb_saved_ctx[cb].domain;
> +			pgtbl_cfg = &smmu->cb_saved_ctx[cb].pgtbl_cfg;
> +
> +			if (domain) {
> +				mutex_lock(&domain->init_mutex);

Assuming the device link stuff works as I would expect it to (I've not
looked in detail), then shouldn't the SMMU be resumed before any of its
masters are, so what are we taking this lock to protect against?

Robin.

> +				arm_smmu_init_context_bank(domain, pgtbl_cfg);
> +				mutex_unlock(&domain->init_mutex);
> +			}
> +		}
> +		pcb = cb;
> +		i++;
> +	}
> +
> +	return 0;
>  }
>  
>  static int arm_smmu_suspend(struct device *dev)
> 
