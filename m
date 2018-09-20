From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v8 5/7] iommu/arm-smmu-v3: Add support for non-strict mode
Date: Thu, 20 Sep 2018 17:10:25 +0100
Message-ID: <b98f8f695178c9c9ac6e081680090d5ac97e8d7c.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Now that io-pgtable knows how to dodge strict TLB maintenance, all
that's left to do is bridge the gap between the IOMMU core requesting
DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE for default domains, and showing the
appropriate IO_PGTABLE_QUIRK_NON_STRICT flag to alloc_io_pgtable_ops().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: convert to domain attribute, tweak commit message]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v8:
 - Use nested switches for attrs
 - Document barrier semantics

 drivers/iommu/arm-smmu-v3.c | 79 ++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f10c852479fc..db402e8b068b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -612,6 +612,7 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
+	bool				non_strict;
 
 	enum arm_smmu_domain_stage	stage;
 	union {
@@ -1407,6 +1408,12 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
 
+	/*
+	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
+	 * PTEs previously cleared by unmaps on the current CPU not yet visible
+	 * to the SMMU. We are relying on the DSB implicit in queue_inc_prod()
+	 * to guarantee those are observed before the TLBI. Do be careful, 007.
+	 */
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
 	__arm_smmu_tlb_sync(smmu);
 }
@@ -1633,6 +1640,9 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
 
+	if (smmu_domain->non_strict)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
@@ -1934,15 +1944,27 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
-		return -EINVAL;
-
-	switch (attr) {
-	case DOMAIN_ATTR_NESTING:
-		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
-		return 0;
+	switch (domain->type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		switch (attr) {
+		case DOMAIN_ATTR_NESTING:
+			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
+			return 0;
+		default:
+			return -ENODEV;
+		}
+		break;
+	case IOMMU_DOMAIN_DMA:
+		switch (attr) {
+		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
+			*(int *)data = smmu_domain->non_strict;
+			return 0;
+		default:
+			return -ENODEV;
+		}
+		break;
 	default:
-		return -ENODEV;
+		return -EINVAL;
 	}
 }
 
@@ -1952,26 +1974,37 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	int ret = 0;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
-		return -EINVAL;
-
 	mutex_lock(&smmu_domain->init_mutex);
 
-	switch (attr) {
-	case DOMAIN_ATTR_NESTING:
-		if (smmu_domain->smmu) {
-			ret = -EPERM;
-			goto out_unlock;
+	switch (domain->type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		switch (attr) {
+		case DOMAIN_ATTR_NESTING:
+			if (smmu_domain->smmu) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+
+			if (*(int *)data)
+				smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
+			else
+				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
+			break;
+		default:
+			ret = -ENODEV;
+		}
+		break;
+	case IOMMU_DOMAIN_DMA:
+		switch(attr) {
+		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
+			smmu_domain->non_strict = *(int *)data;
+			break;
+		default:
+			ret = -ENODEV;
 		}
-
-		if (*(int *)data)
-			smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
-		else
-			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
-
 		break;
 	default:
-		ret = -ENODEV;
+		ret = -EINVAL;
 	}
 
 out_unlock:
-- 
2.19.0.dirty
