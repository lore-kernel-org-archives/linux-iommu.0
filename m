From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 3/6] iommu/arm-smmu: add support for iova_to_phys through
	ATS1PR
Date: Tue, 12 Aug 2014 17:51:36 -0700
Message-ID: <1407891099-24641-4-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407891099-24641-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, we provide the iommu_ops.iova_to_phys service by doing a
table walk in software to translate IO virtual addresses to physical
addresses. On SMMUs that support it, it can be useful to ask the SMMU
itself to do the translation. This can be used to warm the TLBs for an
SMMU. It can also be useful for testing and hardware validation.

Since the address translation registers are optional on SMMUv2, only
enable hardware translations when using SMMUv1 or when SMMU_IDR0.S1TS=1
and SMMU_IDR0.ATOSNS=0, as described in the ARM SMMU v1-v2 spec.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7fdc58d8f8..63c6707fad 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -246,11 +246,17 @@
 #define ARM_SMMU_CB_TTBR0_HI		0x24
 #define ARM_SMMU_CB_TTBCR		0x30
 #define ARM_SMMU_CB_S1_MAIR0		0x38
+#define ARM_SMMU_CB_PAR_LO		0x50
+#define ARM_SMMU_CB_PAR_HI		0x54
 #define ARM_SMMU_CB_FSR			0x58
 #define ARM_SMMU_CB_FAR_LO		0x60
 #define ARM_SMMU_CB_FAR_HI		0x64
 #define ARM_SMMU_CB_FSYNR0		0x68
 #define ARM_SMMU_CB_S1_TLBIASID		0x610
+#define ARM_SMMU_CB_ATS1PR_LO		0x800
+#define ARM_SMMU_CB_ATS1PR_HI		0x804
+#define ARM_SMMU_CB_ATSR		0x8f0
+#define ATSR_LOOP_TIMEOUT		1000000	/* 1s! */
 
 #define SCTLR_S1_ASIDPNE		(1 << 12)
 #define SCTLR_CFCFG			(1 << 7)
@@ -262,6 +268,10 @@
 #define SCTLR_M				(1 << 0)
 #define SCTLR_EAE_SBOP			(SCTLR_AFE | SCTLR_TRE)
 
+#define CB_PAR_F			(1 << 0)
+
+#define ATSR_ACTIVE			(1 << 0)
+
 #define RESUME_RETRY			(0 << 0)
 #define RESUME_TERMINATE		(1 << 0)
 
@@ -375,6 +385,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_TRANS_S1		(1 << 2)
 #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
 #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
+#define ARM_SMMU_FEAT_TRANS_OPS		(1 << 5)
 	u32				features;
 
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
@@ -1653,7 +1664,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ret ? 0 : size;
 }
 
-static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
+static phys_addr_t arm_smmu_iova_to_phys_soft(struct iommu_domain *domain,
 					 dma_addr_t iova)
 {
 	pgd_t *pgdp, pgd;
@@ -1686,6 +1697,63 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
 }
 
+static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
+					dma_addr_t iova)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct device *dev = smmu->dev;
+	void __iomem *cb_base;
+	int count = 0;
+	u64 phys;
+
+	arm_smmu_enable_clocks(smmu);
+
+	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+
+	if (smmu->version == 1) {
+		u32 reg = iova & 0xFFFFF000;
+		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
+	} else {
+		u64 reg = iova & 0xfffffffffffff000;
+		writeq_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
+	}
+
+	mb();
+	while (readl_relaxed(cb_base + ARM_SMMU_CB_ATSR) & ATSR_ACTIVE) {
+		if (++count == ATSR_LOOP_TIMEOUT) {
+			dev_err(dev,
+				"iova to phys timed out on 0x%pa for %s. Falling back to software table walk.\n",
+				&iova, dev_name(dev));
+			arm_smmu_disable_clocks(smmu);
+			return arm_smmu_iova_to_phys_soft(domain, iova);
+		}
+		cpu_relax();
+	}
+
+	phys = readl_relaxed(cb_base + ARM_SMMU_CB_PAR_LO);
+	phys |= ((u64) readl_relaxed(cb_base + ARM_SMMU_CB_PAR_HI)) << 32;
+
+	if (phys & CB_PAR_F) {
+		dev_err(dev, "translation fault on %s!\n", dev_name(dev));
+		dev_err(dev, "PAR = 0x%llx\n", phys);
+	}
+	phys = (phys & 0xFFFFFFF000ULL) | (iova & 0x00000FFF);
+
+	arm_smmu_disable_clocks(smmu);
+	return phys;
+}
+
+static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
+					dma_addr_t iova)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_TRANS_OPS)
+		return arm_smmu_iova_to_phys_hard(domain, iova);
+	return arm_smmu_iova_to_phys_soft(domain, iova);
+}
+
 static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
 				   unsigned long cap)
 {
@@ -2005,6 +2073,11 @@ int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		return -ENODEV;
 	}
 
+	if (smmu->version == 1 || (!(id & ID0_ATOSNS) && (id & ID0_S1TS))) {
+		smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
+		dev_notice(smmu->dev, "\taddress translation ops\n");
+	}
+
 	if (id & ID0_CTTW) {
 		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
 		dev_notice(smmu->dev, "\tcoherent table walk\n");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
