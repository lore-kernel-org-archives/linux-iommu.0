From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v3] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable caching
	of bypass entries
Date: Fri, 4 Nov 2016 15:25:23 +0530
Message-ID: <1478253323-9231-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: stuart.yoder-3arQi8VN3Tc@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The SMTNMB_TLBEN in the Auxiliary Configuration Register (ACR) provides an
option to enable the updation of TLB in case of bypass transactions due to
no stream match in the stream match table. This reduces the latencies of
the subsequent transactions with the same stream-id which bypasses the SMMU.
This provides a significant performance benefit for certain networking
workloads.

With this change substantial performance improvement of ~9% is observed with
DPDK l3fwd application (http://dpdk.org/doc/guides/sample_app_ug/l3_forward.html)
on NXP's LS2088a platform.

Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
---
Changes for v2:
    - Incorporated Robin's comments on v1 related to
	Setting SMTNMB_TLBEN in ACR only for MMU-500 as ACR is implementation dependent
	Code comments and Naming convention
Changes for v3:
    - Added correct patch version

 drivers/iommu/arm-smmu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ce2a9d4..05901be 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -247,6 +247,7 @@ enum arm_smmu_s2cr_privcfg {
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
 
 #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
+#define ARM_MMU500_ACR_SMTNMB_TLBEN	(1 << 8)
 
 #define CB_PAR_F			(1 << 0)
 
@@ -1569,16 +1570,22 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	for (i = 0; i < smmu->num_mapping_groups; ++i)
 		arm_smmu_write_sme(smmu, i);
 
-	/*
-	 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
-	 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
-	 * bit is only present in MMU-500r2 onwards.
-	 */
-	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID7);
-	major = (reg >> ID7_MAJOR_SHIFT) & ID7_MAJOR_MASK;
-	if ((smmu->model == ARM_MMU500) && (major >= 2)) {
+	if (smmu->model == ARM_MMU500) {
+		/*
+		 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
+		 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
+		 * bit is only present in MMU-500r2 onwards.
+		 */
+		reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID7);
+		major = (reg >> ID7_MAJOR_SHIFT) & ID7_MAJOR_MASK;
 		reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sACR);
-		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
+		if (major >= 2)
+			reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
+		/*
+		 * Allow unmatched Stream IDs to allocate bypass
+		 * TLB entries for reduced latency.
+		 */
+		reg |= ARM_MMU500_ACR_SMTNMB_TLBEN;
 		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
 	}
 
-- 
1.9.1
