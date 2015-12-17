From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 09/13] iommu/arm-smmu: Invalidate TLBs properly
Date: Thu, 17 Dec 2015 12:12:09 +0000
Message-ID: <1450354333-27256-10-git-send-email-will.deacon@arm.com>
References: <1450354333-27256-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450354333-27256-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, zhangbo_a-95E7rUnPDLLQT0dZR+AlfA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

When invalidating an IOVA range potentially spanning multiple pages,
such as when removing an entire intermediate-level table, we currently
only issue an invalidation for the first IOVA of that range. Since the
architecture specifies that address-based TLB maintenance operations
target a single entry, an SMMU could feasibly retain live entries for
subsequent pages within that unmapped range, which is not good.

Make sure we hit every possible entry by iterating over the whole range
at the granularity provided by the pagetable implementation.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
[will: added missing semicolons...]
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c |  5 ++++-
 drivers/iommu/arm-smmu.c    | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 735ad2c58dd8..4991e79465ee 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1360,7 +1360,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
 
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	do {
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		cmd.tlbi.addr += granule;
+	} while (size -= granule);
 }
 
 static struct iommu_gather_ops arm_smmu_gather_ops = {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7e04bf5640ae..59ee4b8a3236 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -597,12 +597,18 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 		if (!IS_ENABLED(CONFIG_64BIT) || smmu->version == ARM_SMMU_V1) {
 			iova &= ~12UL;
 			iova |= ARM_SMMU_CB_ASID(cfg);
-			writel_relaxed(iova, reg);
+			do {
+				writel_relaxed(iova, reg);
+				iova += granule;
+			} while (size -= granule);
 #ifdef CONFIG_64BIT
 		} else {
 			iova >>= 12;
 			iova |= (u64)ARM_SMMU_CB_ASID(cfg) << 48;
-			writeq_relaxed(iova, reg);
+			do {
+				writeq_relaxed(iova, reg);
+				iova += granule >> 12;
+			} while (size -= granule);
 #endif
 		}
 #ifdef CONFIG_64BIT
@@ -610,7 +616,11 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 		reg = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 		reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L :
 			      ARM_SMMU_CB_S2_TLBIIPAS2;
-		writeq_relaxed(iova >> 12, reg);
+		iova >>= 12;
+		do {
+			writeq_relaxed(iova, reg);
+			iova += granule >> 12;
+		} while (size -= granule);
 #endif
 	} else {
 		reg = ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_TLBIVMID;
-- 
2.1.4
