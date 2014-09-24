From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 3/3] iommu/arm-smmu: add support for DOMAIN_ATTR_NESTING
	attribute
Date: Wed, 24 Sep 2014 10:21:25 +0100
Message-ID: <1411550485-32483-4-git-send-email-will.deacon@arm.com>
References: <1411550485-32483-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1411550485-32483-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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

When domains are set with the DOMAIN_ATTR_NESTING flag, we must ensure
that we allocate them to stage-2 context banks if the hardware permits
it.

This patch adds support for the attribute to the ARM SMMU driver, with
the actual stage being determined depending on the features supported
by the hardware.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 110 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 37dc3dd0df96..e0cc50ac4574 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -404,9 +404,16 @@ struct arm_smmu_cfg {
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
 
@@ -906,19 +913,46 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
-	if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
+	/*
+	 * Mapping the requested stage onto what we support is surprisingly
+	 * complicated, mainly because the spec allows S1+S2 SMMUs without
+	 * support for nested translation. That means we end up with the
+	 * following table:
+	 *
+	 * Requested        Supported        Actual
+	 *     S1               N              S1
+	 *     S1             S1+S2            S1
+	 *     S1               S2             S2
+	 *     S1               S1             S1
+	 *     N                N              N
+	 *     N              S1+S2            S2
+	 *     N                S2             S2
+	 *     N                S1             S1
+	 *
+	 * Note that you can't actually request stage-2 mappings.
+	 */
+	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
+		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
+	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
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
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
@@ -1645,20 +1679,56 @@ static void arm_smmu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 
+static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
+				    enum iommu_attr attr, void *data)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+
+	switch (attr) {
+	case DOMAIN_ATTR_NESTING:
+		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
+		return 0;
+	default:
+		return -ENODEV;
+	}
+}
+
+static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
+				    enum iommu_attr attr, void *data)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+
+	switch (attr) {
+	case DOMAIN_ATTR_NESTING:
+		if (smmu_domain->smmu)
+			return -EPERM;
+		if (*(int *)data)
+			smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
+		else
+			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
+
+		return 0;
+	default:
+		return -ENODEV;
+	}
+}
+
 static const struct iommu_ops arm_smmu_ops = {
-	.domain_init	= arm_smmu_domain_init,
-	.domain_destroy	= arm_smmu_domain_destroy,
-	.attach_dev	= arm_smmu_attach_dev,
-	.detach_dev	= arm_smmu_detach_dev,
-	.map		= arm_smmu_map,
-	.unmap		= arm_smmu_unmap,
-	.iova_to_phys	= arm_smmu_iova_to_phys,
-	.domain_has_cap	= arm_smmu_domain_has_cap,
-	.add_device	= arm_smmu_add_device,
-	.remove_device	= arm_smmu_remove_device,
-	.pgsize_bitmap	= (SECTION_SIZE |
-			   ARM_SMMU_PTE_CONT_SIZE |
-			   PAGE_SIZE),
+	.domain_init		= arm_smmu_domain_init,
+	.domain_destroy		= arm_smmu_domain_destroy,
+	.attach_dev		= arm_smmu_attach_dev,
+	.detach_dev		= arm_smmu_detach_dev,
+	.map			= arm_smmu_map,
+	.unmap			= arm_smmu_unmap,
+	.iova_to_phys		= arm_smmu_iova_to_phys,
+	.domain_has_cap		= arm_smmu_domain_has_cap,
+	.add_device		= arm_smmu_add_device,
+	.remove_device		= arm_smmu_remove_device,
+	.domain_get_attr	= arm_smmu_domain_get_attr,
+	.domain_set_attr	= arm_smmu_domain_set_attr,
+	.pgsize_bitmap		= (SECTION_SIZE |
+				   ARM_SMMU_PTE_CONT_SIZE |
+				   PAGE_SIZE),
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
-- 
2.1.0
