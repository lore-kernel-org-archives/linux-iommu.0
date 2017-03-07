From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/4] iommu/arm-smmu: Simplify ASID/VMID handling
Date: Tue,  7 Mar 2017 18:09:05 +0000
Message-ID: <5984b10ddd7e3c38102bc6be9ad9678722b128c8.1488907474.git.robin.murphy@arm.com>
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

Calculating ASIDs/VMIDs dynamically from arm_smmu_cfg was a neat trick,
but the global uniqueness workaround makes it somewhat more awkward, and
means we end up having to pass extra state around in certain cases just
to keep a handle on the offset.

We already have 16 bits going spare in arm_smmu_cfg; let's just
precalculate an ASID/VMID, plop it in there, and tidy up the users
accordingly. We'd also need something like this anyway if we ever get
near to thinking about SVM, so it's no bad thing.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index bc7ef6a0c54d..0b64852baa6a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -404,14 +404,15 @@ enum arm_smmu_context_fmt {
 struct arm_smmu_cfg {
 	u8				cbndx;
 	u8				irptndx;
+	union {
+		u16			asid;
+		u16			vmid;
+	};
 	u32				cbar;
 	enum arm_smmu_context_fmt	fmt;
 };
 #define INVALID_IRPTNDX			0xff
 
-#define ARM_SMMU_CB_ASID(smmu, cfg) ((u16)(smmu)->cavium_id_base + (cfg)->cbndx)
-#define ARM_SMMU_CB_VMID(smmu, cfg) ((u16)(smmu)->cavium_id_base + (cfg)->cbndx + 1)
-
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
@@ -603,12 +604,10 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 
 	if (stage1) {
 		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
-		writel_relaxed(ARM_SMMU_CB_ASID(smmu, cfg),
-			       base + ARM_SMMU_CB_S1_TLBIASID);
+		writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
 	} else {
 		base = ARM_SMMU_GR0(smmu);
-		writel_relaxed(ARM_SMMU_CB_VMID(smmu, cfg),
-			       base + ARM_SMMU_GR0_TLBIVMID);
+		writel_relaxed(cfg->vmid, base + ARM_SMMU_GR0_TLBIVMID);
 	}
 
 	__arm_smmu_tlb_sync(smmu);
@@ -629,14 +628,14 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 
 		if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
 			iova &= ~12UL;
-			iova |= ARM_SMMU_CB_ASID(smmu, cfg);
+			iova |= cfg->asid;
 			do {
 				writel_relaxed(iova, reg);
 				iova += granule;
 			} while (size -= granule);
 		} else {
 			iova >>= 12;
-			iova |= (u64)ARM_SMMU_CB_ASID(smmu, cfg) << 48;
+			iova |= (u64)cfg->asid << 48;
 			do {
 				writeq_relaxed(iova, reg);
 				iova += granule >> 12;
@@ -653,7 +652,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 		} while (size -= granule);
 	} else {
 		reg = ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_TLBIVMID;
-		writel_relaxed(ARM_SMMU_CB_VMID(smmu, cfg), reg);
+		writel_relaxed(cfg->vmid, reg);
 	}
 }
 
@@ -735,7 +734,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 			reg = CBA2R_RW64_32BIT;
 		/* 16-bit VMIDs live in CBA2R */
 		if (smmu->features & ARM_SMMU_FEAT_VMID16)
-			reg |= ARM_SMMU_CB_VMID(smmu, cfg) << CBA2R_VMID_SHIFT;
+			reg |= cfg->vmid << CBA2R_VMID_SHIFT;
 
 		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
 	}
@@ -754,26 +753,24 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
 	} else if (!(smmu->features & ARM_SMMU_FEAT_VMID16)) {
 		/* 8-bit VMIDs live in CBAR */
-		reg |= ARM_SMMU_CB_VMID(smmu, cfg) << CBAR_VMID_SHIFT;
+		reg |= cfg->vmid << CBAR_VMID_SHIFT;
 	}
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
 
 	/* TTBRs */
 	if (stage1) {
-		u16 asid = ARM_SMMU_CB_ASID(smmu, cfg);
-
 		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
 			reg = pgtbl_cfg->arm_v7s_cfg.ttbr[0];
 			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0);
 			reg = pgtbl_cfg->arm_v7s_cfg.ttbr[1];
 			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1);
-			writel_relaxed(asid, cb_base + ARM_SMMU_CB_CONTEXTIDR);
+			writel_relaxed(cfg->asid, cb_base + ARM_SMMU_CB_CONTEXTIDR);
 		} else {
 			reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-			reg64 |= (u64)asid << TTBRn_ASID_SHIFT;
+			reg64 |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
 			writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR0);
 			reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
-			reg64 |= (u64)asid << TTBRn_ASID_SHIFT;
+			reg64 |= (u64)cfg->asid << TTBRn_ASID_SHIFT;
 			writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR1);
 		}
 	} else {
@@ -941,6 +938,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		cfg->irptndx = cfg->cbndx;
 	}
 
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2)
+		cfg->vmid = cfg->cbndx + 1 + smmu->cavium_id_base;
+	else
+		cfg->asid = cfg->cbndx + smmu->cavium_id_base;
+
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.ias		= ias,
-- 
2.11.0.dirty
