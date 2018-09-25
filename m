From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu: Add support to handle Qcom's TLBI
 serialization errata
Date: Tue, 25 Sep 2018 13:31:45 +0100
Message-ID: <29fd7e9e-708b-b884-4de1-ecc141f41692@arm.com>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180910062551.28175-5-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910062551.28175-5-vivek.gautam@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com, bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
Cc: david.brown@linaro.org, tfiga@chromium.org, swboyd@chromium.org, linux-kernel@vger.kernel.org, robdclark@gmail.com
List-Id: iommu@lists.linux-foundation.org

On 10/09/18 07:25, Vivek Gautam wrote:
> Qcom's implementation of arm,mmu-500 require to serialize all
> TLB invalidations for context banks.

What does "serailize all TLB invalidations" actually mean, because it's 
not entirely clear from context, and furthermore this patch appears to 
behave subtly differently to the downstream code so I'm really 
struggling to figure out whether it's actually doing what it's intended 
to do.

> In case the TLB invalidation requests don't go through the first
> time, there's a way to disable/enable the wait for safe logic.
> Disabling this logic expadites the TLBIs.
> 
> Different bootloaders with their access control policies allow this
> register access differntly. With one, we should be able to directly
> make qcom-scm call to do io read/write, while with other we should
> use the specific SCM command to send request to do the complete
> register configuration.
> A separate device tree flag for arm-smmu will allow to identify
> which firmware configuration of the two mentioned above we use.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu-regs.h |   2 +
>   drivers/iommu/arm-smmu.c      | 133 +++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 133 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4ab5f8..71662cae9806 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -177,6 +177,8 @@ enum arm_smmu_s2cr_privcfg {
>   #define ARM_SMMU_CB_ATS1PR		0x800
>   #define ARM_SMMU_CB_ATSR		0x8f0
>   
> +#define ARM_SMMU_GID_QCOM_CUSTOM_CFG	0x300
> +
>   #define SCTLR_S1_ASIDPNE		(1 << 12)
>   #define SCTLR_CFCFG			(1 << 7)
>   #define SCTLR_CFIE			(1 << 6)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 411e5ac57c64..de9c4a5bf686 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -49,6 +49,7 @@
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/qcom_scm.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   
> @@ -181,7 +182,8 @@ struct arm_smmu_device {
>   #define ARM_SMMU_FEAT_EXIDS		(1 << 12)
>   	u32				features;
>   
> -#define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
> +#define ARM_SMMU_OPT_SECURE_CFG_ACCESS	 (1 << 0)
> +#define ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA (1 << 1)
>   	u32				options;
>   	enum arm_smmu_arch_version	version;
>   	enum arm_smmu_implementation	model;
> @@ -266,6 +268,7 @@ static bool using_legacy_binding, using_generic_binding;
>   
>   static struct arm_smmu_option_prop arm_smmu_options[] = {
>   	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
> +	{ ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA, "qcom,smmu-500-fw-impl-errata" },
>   	{ 0, NULL},
>   };
>   
> @@ -531,12 +534,134 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
>   	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
>   }
>   
> +#define CUSTOM_CFG_MDP_SAFE_ENABLE		BIT(15)
> +#define CUSTOM_CFG_IFE1_SAFE_ENABLE		BIT(14)
> +#define CUSTOM_CFG_IFE0_SAFE_ENABLE		BIT(13)
> +
> +static int __qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu, int en)
> +{
> +	int ret;
> +	u32 val, gid_phys_base;
> +	phys_addr_t reg;
> +	struct vm_struct *vm;
> +
> +	/* We want physical address of SMMU, so the vm_area */
> +	vm = find_vm_area(smmu->base);
> +
> +	/*
> +	 * GID (implementation defined address space) is located at
> +	 * SMMU_BASE + (2 × PAGESIZE).
> +	 */
> +	gid_phys_base = vm->phys_addr + (2 << (smmu)->pgshift);
> +	reg = gid_phys_base + ARM_SMMU_GID_QCOM_CUSTOM_CFG;
> +
> +	ret = qcom_scm_io_readl_atomic(reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (en)
> +		val |= CUSTOM_CFG_MDP_SAFE_ENABLE |
> +		       CUSTOM_CFG_IFE0_SAFE_ENABLE |
> +		       CUSTOM_CFG_IFE1_SAFE_ENABLE;
> +	else
> +		val &= ~(CUSTOM_CFG_MDP_SAFE_ENABLE |
> +			 CUSTOM_CFG_IFE0_SAFE_ENABLE |
> +			 CUSTOM_CFG_IFE1_SAFE_ENABLE);
> +
> +	ret = qcom_scm_io_writel_atomic(reg, val);
> +
> +	return ret;
> +}
> +
> +static int qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu,
> +				     int en, bool is_fw_impl)
> +{
> +	if (is_fw_impl)
> +		return qcom_scm_qsmmu500_wait_safe_toggle(en);
> +	else
> +		return __qsmmu500_wait_safe_toggle(smmu, en);
> +}
> +
> +static void qcom_errata_tlb_sync(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	void __iomem *base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
> +	bool is_fw_impl;
> +	u32 val;
> +
> +	writel_relaxed(0, base + ARM_SMMU_CB_TLBSYNC);
> +
> +	if (!readl_poll_timeout_atomic(base + ARM_SMMU_CB_TLBSTATUS, val,
> +				       !(val & sTLBGSTATUS_GSACTIVE), 0, 100))
> +		return;
> +
> +	is_fw_impl = smmu->options & ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA ?
> +			true : false;
> +
> +	/* SCM call here to disable the wait-for-safe logic. */

I take it this is a global state, so it can't just be turned off for the 
relevant contexts and left that way?

> +	if (WARN(qsmmu500_wait_safe_toggle(smmu, false, is_fw_impl),
> +		 "Failed to disable wait-safe logic, bad hw state\n"))
> +		return;
> +
> +	if (!readl_poll_timeout_atomic(base + ARM_SMMU_CB_TLBSTATUS, val,
> +				       !(val & sTLBGSTATUS_GSACTIVE), 0, 10000))
> +		return;
> +
> +	/* SCM call here to re-enable the wait-for-safe logic. */
> +	WARN(qsmmu500_wait_safe_toggle(smmu, true, is_fw_impl),
> +	     "Failed to re-enable wait-safe logic, bad hw state\n");
> +
> +	dev_err_ratelimited(smmu->dev,
> +			    "TLB sync timed out -- SMMU in bad state\n");
> +}
> +
> +static void qcom_errata_tlb_sync_context(void *cookie)
> +{
> +	struct arm_smmu_domain *smmu_domain = cookie;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> +	qcom_errata_tlb_sync(smmu_domain);
> +	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
> +}
> +
> +static void qcom_errata_tlb_inv_context_s1(void *cookie)
> +{
> +	struct arm_smmu_domain *smmu_domain = cookie;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	void __iomem *base = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> +	writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
> +	qcom_errata_tlb_sync(cookie);
> +	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
> +}
> +
> +static void qcom_errata_tlb_inv_range_nosync(unsigned long iova, size_t size,
> +					     size_t granule, bool leaf,
> +					     void *cookie)
> +{
> +	struct arm_smmu_domain *smmu_domain = cookie;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> +	arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
> +	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);

I don't get what this locking is trying to achieve - the only thing it 
protects is one or more writes to TLBIVA{L}, which *must* surely be 
"serialised" by the interconnect anyway?

The downstream code doesn't appear to implement .tlb_add_flush at all, 
so something smells off.

Robin.

> +}
> +
>   static const struct iommu_gather_ops arm_smmu_s1_tlb_ops = {
>   	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
>   	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
>   	.tlb_sync	= arm_smmu_tlb_sync_context,
>   };
>   
> +static const struct iommu_gather_ops qcom_errata_s1_tlb_ops = {
> +	.tlb_flush_all	= qcom_errata_tlb_inv_context_s1,
> +	.tlb_add_flush	= qcom_errata_tlb_inv_range_nosync,
> +	.tlb_sync	= qcom_errata_tlb_sync_context,
> +};
> +
>   static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v2 = {
>   	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
>   	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
> @@ -824,7 +949,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   			ias = min(ias, 32UL);
>   			oas = min(oas, 32UL);
>   		}
> -		smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
> +		if (of_device_is_compatible(smmu->dev->of_node,
> +					    "qcom,sdm845-smmu-500"))
> +			smmu_domain->tlb_ops = &qcom_errata_s1_tlb_ops;
> +		else
> +			smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
>   		break;
>   	case ARM_SMMU_DOMAIN_NESTED:
>   		/*
> 
