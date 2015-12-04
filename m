From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/5] iommu/arm-smmu: Invalidate TLBs properly
Date: Fri,  4 Dec 2015 17:53:00 +0000
Message-ID: <2acaea8656f14a4421d7d466dd242fe5a3d0f6f6.1449246988.git.robin.murphy@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1449246988.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When invalidating an IOVA range potentially spanning multiple pages,
such as when removing an entire intermediate-level table, we currently
only issue an invalidation for the first IOVA of that range. Since the
architecture specifies that address-based TLB maintenance operations
target a single entry, an SMMU could feasibly retain live entries for
subsequent pages within that unmapped range, which is not good.

Make sure we hit every possible entry by iterating over the whole range
at the granularity provided by the pagetable implementation.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 601e3dd..f1d6fa7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -597,12 +597,20 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 		if (!IS_ENABLED(CONFIG_64BIT) || smmu->version == ARM_SMMU_V1) {
 			iova &= ~12UL;
 			iova |= ARM_SMMU_CB_ASID(cfg);
-			writel_relaxed(iova, reg);
+			while (size) {
+				writel_relaxed(iova, reg);
+				size -= granule;
+				iova += granule;
+			}
 #ifdef CONFIG_64BIT
 		} else {
 			iova >>= 12;
 			iova |= (u64)ARM_SMMU_CB_ASID(cfg) << 48;
-			writeq_relaxed(iova, reg);
+			while (size) {
+				writeq_relaxed(iova, reg);
+				size -= granule;
+				iova += granule >> 12;
+			}
 #endif
 		}
 #ifdef CONFIG_64BIT
@@ -610,7 +618,12 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 		reg = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 		reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L :
 			      ARM_SMMU_CB_S2_TLBIIPAS2;
-		writeq_relaxed(iova >> 12, reg);
+		iova >>= 12;
+		while (size) {
+			writeq_relaxed(iova, reg);
+			size -= granule;
+			iova += granule >> 12;
+		}
 #endif
 	} else {
 		reg = ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_TLBIVMID;
-- 
1.9.1
