From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 3/3] iommu/arm-smmu: add support for IOMMU_DOMAIN_HYP flag
Date: Tue,  1 Jul 2014 17:10:17 +0100
Message-ID: <1404231017-10856-3-git-send-email-will.deacon@arm.com>
References: <1404231017-10856-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404231017-10856-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When domains are created with the IOMMU_DOMAIN_HYP flag, we must ensure
that we allocate them to stage-2 context banks if the hardware permits
it.

This patch attempts to allocate IOMMU_DOMAIN_HYP domains to stage-2
context-banks and keeps track of which stage the domain ended up being
assigned to. Our capability check is then updated to report
IOMMU_CAP_HYP_MAPPING only for domains using nested translation..

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 37d36e88420b..e0b7c18e88e3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -391,9 +391,16 @@ struct arm_smmu_cfg {
 #define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
 #define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
 
+enum arm_smmu_domain_stage {
+	ARM_SMMU_DOMAIN_S1 = 0,
+	ARM_SMMU_DOMAIN_S2,
+	ARM_SMMU_DOMAIN_NESTED,
+};
+
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_cfg		cfg;
+	enum arm_smmu_domain_stage	stage;
 	spinlock_t			lock;
 };
 
@@ -869,19 +876,25 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 
-	if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
+	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
+		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
+
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_S1:
+		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
+		start = smmu->num_s2_context_banks;
+		break;
+	case ARM_SMMU_DOMAIN_NESTED:
 		/*
 		 * We will likely want to change this if/when KVM gets
 		 * involved.
 		 */
-		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
-		start = smmu->num_s2_context_banks;
-	} else if (smmu->features & ARM_SMMU_FEAT_TRANS_S1) {
-		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
-		start = smmu->num_s2_context_banks;
-	} else {
+	case ARM_SMMU_DOMAIN_S2:
 		cfg->cbar = CBAR_TYPE_S2_TRANS;
 		start = 0;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
@@ -960,6 +973,10 @@ static int arm_smmu_domain_init(struct iommu_domain *domain, int type)
 	smmu_domain->cfg.pgd = pgd;
 
 	spin_lock_init(&smmu_domain->lock);
+
+	if (type == IOMMU_DOMAIN_HYP)
+		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
+
 	domain->priv = smmu_domain;
 	return 0;
 
@@ -1516,6 +1533,8 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
 		return features & ARM_SMMU_FEAT_COHERENT_WALK;
 	case IOMMU_CAP_INTR_REMAP:
 		return 1; /* MSIs are just memory writes */
+	case IOMMU_CAP_HYP_MAPPING:
+		return smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED;
 	default:
 		return 0;
 	}
-- 
2.0.0
