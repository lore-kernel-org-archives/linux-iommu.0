From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 5/5] iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
Date: Tue, 14 Aug 2018 16:25:28 +0530
Message-ID: <20180814105528.20592-6-vivek.gautam@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com, robin.murphy@arm.com, bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org
Cc: mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org, swboyd@chromium.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Qcom's implementation of arm,mmu-500 require to serialize all
TLB invalidations for context banks.
In case the TLB invalidation requests don't go through the first
time, there's a way to disable/enable the wait for safe logic.
Disabling this logic expadites the TLBIs.

Different bootloaders with their access control policies allow this
register access differntly. With one, we should be able to directly
make qcom-scm call to do io read/write, while with other we should
use the specific SCM command to send request to do the complete
register configuration.
A separate device tree flag for arm-smmu will allow to identify
which firmware configuration of the two mentioned above we use.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu-regs.h |   2 +
 drivers/iommu/arm-smmu.c      | 136 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index a1226e4ab5f8..71662cae9806 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -177,6 +177,8 @@ enum arm_smmu_s2cr_privcfg {
 #define ARM_SMMU_CB_ATS1PR		0x800
 #define ARM_SMMU_CB_ATSR		0x8f0
 
+#define ARM_SMMU_GID_QCOM_CUSTOM_CFG	0x300
+
 #define SCTLR_S1_ASIDPNE		(1 << 12)
 #define SCTLR_CFCFG			(1 << 7)
 #define SCTLR_CFIE			(1 << 6)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 75c146751c87..fafdaeb4d097 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -48,6 +48,7 @@
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/qcom_scm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -179,7 +180,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_EXIDS		(1 << 12)
 	u32				features;
 
-#define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
+#define ARM_SMMU_OPT_SECURE_CFG_ACCESS	 (1 << 0)
+#define ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA (1 << 1)
 	u32				options;
 	enum arm_smmu_arch_version	version;
 	enum arm_smmu_implementation	model;
@@ -262,6 +264,7 @@ static bool using_legacy_binding, using_generic_binding;
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
+	{ ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA, "qcom,smmu-500-fw-impl-errata" },
 	{ 0, NULL},
 };
 
@@ -531,12 +534,137 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
 	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
 }
 
+#define CUSTOM_CFG_MDP_SAFE_ENABLE		BIT(15)
+#define CUSTOM_CFG_IFE1_SAFE_ENABLE		BIT(14)
+#define CUSTOM_CFG_IFE0_SAFE_ENABLE		BIT(13)
+
+static int __qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu, int en)
+{
+	int ret;
+	u32 val, gid_phys_base;
+	phys_addr_t reg;
+	struct vm_struct *vm;
+
+	/* We want physical address of SMMU, so the vm_area */
+	vm = find_vm_area(smmu->base);
+
+	/*
+	 * GID (implementation defined address space) is located at
+	 * SMMU_BASE + (2 × PAGESIZE).
+	 */
+	gid_phys_base = vm->phys_addr + (2 << (smmu)->pgshift);
+	reg = gid_phys_base + ARM_SMMU_GID_QCOM_CUSTOM_CFG;
+
+	ret = qcom_scm_io_readl_atomic(reg, &val);
+	if (ret)
+		return ret;
+
+	if (en)
+		val |= CUSTOM_CFG_MDP_SAFE_ENABLE |
+		       CUSTOM_CFG_IFE0_SAFE_ENABLE |
+		       CUSTOM_CFG_IFE1_SAFE_ENABLE;
+	else
+		val &= ~(CUSTOM_CFG_MDP_SAFE_ENABLE |
+			 CUSTOM_CFG_IFE0_SAFE_ENABLE |
+			 CUSTOM_CFG_IFE1_SAFE_ENABLE);
+
+	ret = qcom_scm_io_writel_atomic(reg, val);
+
+	return ret;
+}
+
+static int qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu,
+				     int en, bool is_fw_impl)
+{
+	if (is_fw_impl)
+		return qcom_scm_qsmmu500_wait_safe_toggle(en);
+	else
+		return __qsmmu500_wait_safe_toggle(smmu, en);
+}
+
+static void qcom_errata_tlb_sync(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
+	void __iomem *status = base + ARM_SMMU_CB_TLBSTATUS;
+	bool is_fw_impl;
+
+	writel_relaxed(0, base + ARM_SMMU_CB_TLBSYNC);
+
+	if (!__arm_smmu_tlb_sync_wait(status))
+		return;
+
+	is_fw_impl = smmu->options & ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA ?
+			true : false;
+
+	/* SCM call here to disable the wait-for-safe logic. */
+	if (WARN(qsmmu500_wait_safe_toggle(smmu, false, is_fw_impl),
+		 "Failed to disable wait-safe logic, bad hw state\n"))
+		return;
+
+	if (!__arm_smmu_tlb_sync_wait(status))
+		return;
+
+	/* SCM call here to re-enable the wait-for-safe logic. */
+	WARN(qsmmu500_wait_safe_toggle(smmu, true, is_fw_impl),
+	     "Failed to re-enable wait-safe logic, bad hw state\n");
+
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU in bad state\n");
+}
+
+static void __qcom_errata_tlb_sync_context(struct arm_smmu_domain *smmu_domain)
+{
+	qcom_errata_tlb_sync(smmu_domain);
+}
+
+static void qcom_errata_tlb_sync_context(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+	qcom_errata_tlb_sync(smmu_domain);
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+}
+
+static void qcom_errata_tlb_inv_context_s1(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	void __iomem *base = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+	writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
+	__qcom_errata_tlb_sync_context(cookie);
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+}
+
+static void qcom_errata_tlb_inv_range_nosync(unsigned long iova, size_t size,
+					     size_t granule, bool leaf,
+					     void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+	__arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+}
+
 static const struct iommu_gather_ops arm_smmu_s1_tlb_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync_context,
 };
 
+static const struct iommu_gather_ops qcom_errata_s1_tlb_ops = {
+	.tlb_flush_all	= qcom_errata_tlb_inv_context_s1,
+	.tlb_add_flush	= qcom_errata_tlb_inv_range_nosync,
+	.tlb_sync	= qcom_errata_tlb_sync_context,
+};
+
 static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v2 = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
@@ -824,7 +952,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			ias = min(ias, 32UL);
 			oas = min(oas, 32UL);
 		}
-		smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
+		if (of_device_is_compatible(smmu->dev->of_node,
+					    "qcom,sdm845-smmu-500"))
+			smmu_domain->tlb_ops = &qcom_errata_s1_tlb_ops;
+		else
+			smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 		/*
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
