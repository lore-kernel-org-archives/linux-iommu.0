From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/4] iommu/arm-smmu: Use per-context TLB sync as appropriate
Date: Tue,  7 Mar 2017 18:09:07 +0000
Message-ID: <03ef837586cd991f2d8431908230fd3a3dd8c9cf.1488907474.git.robin.murphy@arm.com>
References: <cover.1488907474.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1488907474.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

TLB synchronisation typically involves the SMMU blocking all incoming
transactions until the TLBs report completion of all outstanding
operations. In the common SMMUv2 configuration of a single distributed
SMMU serving multiple peripherals, that means that a single unmap
request has the potential to bring the hammer down on the entire system
if synchronised globally. Since stage 1 contexts, and stage 2 contexts
under SMMUv2, offer local sync operations, let's make use of those
wherever we can in the hope of minimising global disruption.

To that end, rather than add any more branches to the already unwieldy
monolithic TLB maintenance ops, break them up into smaller, neater,
functions which we can then mix and match as appropriate.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 156 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 100 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c8aafe304171..f7411109670f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -237,6 +237,8 @@ enum arm_smmu_s2cr_privcfg {
 #define ARM_SMMU_CB_S1_TLBIVAL		0x620
 #define ARM_SMMU_CB_S2_TLBIIPAS2	0x630
 #define ARM_SMMU_CB_S2_TLBIIPAS2L	0x638
+#define ARM_SMMU_CB_TLBSYNC		0x7f0
+#define ARM_SMMU_CB_TLBSTATUS		0x7f4
 #define ARM_SMMU_CB_ATS1PR		0x800
 #define ARM_SMMU_CB_ATSR		0x8f0
 
@@ -569,14 +571,13 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 }
 
 /* Wait for any pending TLB invalidations to complete */
-static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
+static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
+				void __iomem *sync, void __iomem *status)
 {
 	int count = 0;
-	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_sTLBGSYNC);
-	while (readl_relaxed(gr0_base + ARM_SMMU_GR0_sTLBGSTATUS)
-	       & sTLBGSTATUS_GSACTIVE) {
+	writel_relaxed(0, sync);
+	while (readl_relaxed(status) & sTLBGSTATUS_GSACTIVE) {
 		cpu_relax();
 		if (++count == TLB_LOOP_TIMEOUT) {
 			dev_err_ratelimited(smmu->dev,
@@ -587,29 +588,49 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 	}
 }
 
-static void arm_smmu_tlb_sync(void *cookie)
+static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
 {
-	struct arm_smmu_domain *smmu_domain = cookie;
-	__arm_smmu_tlb_sync(smmu_domain->smmu);
+	void __iomem *base = ARM_SMMU_GR0(smmu);
+
+	__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_GR0_sTLBGSYNC,
+			    base + ARM_SMMU_GR0_sTLBGSTATUS);
 }
 
-static void arm_smmu_tlb_inv_context(void *cookie)
+static void arm_smmu_tlb_sync_context(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
+
+	__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_CB_TLBSYNC,
+			    base + ARM_SMMU_CB_TLBSTATUS);
+}
+
+static void arm_smmu_tlb_sync_vmid(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	arm_smmu_tlb_sync_global(smmu_domain->smmu);
+}
+
+static void arm_smmu_tlb_inv_context_s1(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	void __iomem *base = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
+
+	writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
+	arm_smmu_tlb_sync_context(cookie);
+}
+
+static void arm_smmu_tlb_inv_context_s2(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
-	void __iomem *base;
+	void __iomem *base = ARM_SMMU_GR0(smmu);
 
-	if (stage1) {
-		base = ARM_SMMU_CB(smmu, cfg->cbndx);
-		writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
-	} else {
-		base = ARM_SMMU_GR0(smmu);
-		writel_relaxed(cfg->vmid, base + ARM_SMMU_GR0_TLBIVMID);
-	}
-
-	__arm_smmu_tlb_sync(smmu);
+	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
+	arm_smmu_tlb_sync_global(smmu);
 }
 
 static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
@@ -617,48 +638,66 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
-	void __iomem *reg;
+	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
+	size_t step;
 
-	if (stage1) {
-		reg = ARM_SMMU_CB(smmu, cfg->cbndx);
-		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
-
-		if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
-			iova &= ~12UL;
-			iova |= cfg->asid;
-			do {
-				writel_relaxed(iova, reg);
-				iova += granule;
-			} while (size -= granule);
-		} else {
-			iova >>= 12;
-			iova |= (u64)cfg->asid << 48;
-			do {
-				writeq_relaxed(iova, reg);
-				iova += granule >> 12;
-			} while (size -= granule);
-		}
-	} else if (smmu->version == ARM_SMMU_V2) {
-		reg = ARM_SMMU_CB(smmu, cfg->cbndx);
+	if (stage1)
+		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL :
+			      ARM_SMMU_CB_S1_TLBIVA;
+	else
 		reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L :
 			      ARM_SMMU_CB_S2_TLBIIPAS2;
-		iova >>= 12;
-		do {
-			smmu_write_atomic_lq(iova, reg);
-			iova += granule >> 12;
-		} while (size -= granule);
+
+	if (stage1 && cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
+		iova &= ~12UL;
+		iova |= cfg->asid;
+		step = granule;
 	} else {
-		reg = ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_TLBIVMID;
-		writel_relaxed(cfg->vmid, reg);
+		iova >>= 12;
+		step = granule >> 12;
+		if (stage1)
+			iova |= (u64)cfg->asid << 48;
 	}
+
+	do {
+		smmu_write_atomic_lq(iova, reg);
+		iova += step;
+	} while (size -= granule);
 }
 
-static const struct iommu_gather_ops arm_smmu_gather_ops = {
-	.tlb_flush_all	= arm_smmu_tlb_inv_context,
+/*
+ * On MMU-401 at least, the cost of firing off multiple TLBIVMIDs appears
+ * almost negligible, but the benefit of getting the first one in as far ahead
+ * of the sync as possible is significant, hence we don't just make this a
+ * no-op and set .tlb_sync to arm_smmu_inv_context_s2() as you might think.
+ */
+static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
+					 size_t granule, bool leaf, void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *base = ARM_SMMU_GR0(smmu);
+
+	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
+}
+
+static const struct iommu_gather_ops arm_smmu_s1_tlb_ops = {
+	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
-	.tlb_sync	= arm_smmu_tlb_sync,
+	.tlb_sync	= arm_smmu_tlb_sync_context,
+};
+
+static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v2 = {
+	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
+	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
+	.tlb_sync	= arm_smmu_tlb_sync_context,
+};
+
+static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v1 = {
+	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
+	.tlb_add_flush	= arm_smmu_tlb_inv_vmid_nosync,
+	.tlb_sync	= arm_smmu_tlb_sync_vmid,
 };
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
@@ -829,6 +868,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	enum io_pgtable_fmt fmt;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	const struct iommu_gather_ops *tlb_ops;
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -900,6 +940,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			ias = min(ias, 32UL);
 			oas = min(oas, 32UL);
 		}
+		tlb_ops = &arm_smmu_s1_tlb_ops;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 		/*
@@ -918,12 +959,15 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			ias = min(ias, 40UL);
 			oas = min(oas, 40UL);
 		}
+		if (smmu->version == ARM_SMMU_V2)
+			tlb_ops = &arm_smmu_s2_tlb_ops_v2;
+		else
+			tlb_ops = &arm_smmu_s2_tlb_ops_v1;
 		break;
 	default:
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-
 	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
 				      smmu->num_context_banks);
 	if (ret < 0)
@@ -946,7 +990,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.ias		= ias,
 		.oas		= oas,
-		.tlb		= &arm_smmu_gather_ops,
+		.tlb		= tlb_ops,
 		.iommu_dev	= smmu->dev,
 	};
 
@@ -1730,7 +1774,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		reg |= sCR0_EXIDENABLE;
 
 	/* Push the button */
-	__arm_smmu_tlb_sync(smmu);
+	arm_smmu_tlb_sync_global(smmu);
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 }
 
-- 
2.11.0.dirty
