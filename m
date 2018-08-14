From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 4/5] iommu/arm-smmu: Make way to add Qcom's smmu-500 errata
	handling
Date: Tue, 14 Aug 2018 16:25:27 +0530
Message-ID: <20180814105528.20592-5-vivek.gautam@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180814105528.20592-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Cleanup to re-use some of the stuff

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 32e86df80428..75c146751c87 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -391,21 +391,31 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 	clear_bit(idx, map);
 }
 
-/* Wait for any pending TLB invalidations to complete */
-static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
-				void __iomem *sync, void __iomem *status)
+static int __arm_smmu_tlb_sync_wait(void __iomem *status)
 {
 	unsigned int spin_cnt, delay;
 
-	writel_relaxed(0, sync);
 	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
 		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
 			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
-				return;
+				return 0;
 			cpu_relax();
 		}
 		udelay(delay);
 	}
+
+	return -EBUSY;
+}
+
+/* Wait for any pending TLB invalidations to complete */
+static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
+				void __iomem *sync, void __iomem *status)
+{
+	writel_relaxed(0, sync);
+
+	if (!__arm_smmu_tlb_sync_wait(status))
+		return;
+
 	dev_err_ratelimited(smmu->dev,
 			    "TLB sync timed out -- SMMU may be deadlocked\n");
 }
@@ -461,8 +471,9 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
 	arm_smmu_tlb_sync_global(smmu);
 }
 
-static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
-					  size_t granule, bool leaf, void *cookie)
+static void __arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
+					    size_t granule, bool leaf,
+					    void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
@@ -498,6 +509,13 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	}
 }
 
+static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
+					  size_t granule, bool leaf,
+					  void *cookie)
+{
+	__arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
+}
+
 /*
  * On MMU-401 at least, the cost of firing off multiple TLBIVMIDs appears
  * almost negligible, but the benefit of getting the first one in as far ahead
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
