From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable caching of
	bypass entries
Date: Wed, 2 Nov 2016 19:05:14 +0530
Message-ID: <1478093714-17219-1-git-send-email-nipun.gupta@nxp.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: stuart.yoder-3arQi8VN3Tc@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The SMTNMB_TLBEN in the Auxiliary Configuration Register (ACR) provides an
option to enable the updation of TLB in case of bypass transactions due to
no stream match in the stream match table. This reduces the latencies of
the subsequent transactions with the same stream-id which bypasses the SMMU.
This provides a significant performance benefit for certain networking
workloads.

Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ce2a9d4..7010a5c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -246,6 +246,7 @@ enum arm_smmu_s2cr_privcfg {
 
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
 
+#define ACR_SMTNMB_TLBEN		(1 << 8)
 #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
 
 #define CB_PAR_F			(1 << 0)
@@ -1569,18 +1570,26 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	for (i = 0; i < smmu->num_mapping_groups; ++i)
 		arm_smmu_write_sme(smmu, i);
 
+	/* Get the major rev required for configuring ACR */
+	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID7);
+	major = (reg >> ID7_MAJOR_SHIFT) & ID7_MAJOR_MASK;
+
 	/*
 	 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
 	 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
 	 * bit is only present in MMU-500r2 onwards.
 	 */
-	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID7);
-	major = (reg >> ID7_MAJOR_SHIFT) & ID7_MAJOR_MASK;
-	if ((smmu->model == ARM_MMU500) && (major >= 2)) {
-		reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sACR);
+	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sACR);
+	if ((smmu->model == ARM_MMU500) && (major >= 2))
 		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
-		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
-	}
+
+	/*
+	 * Set the SMTNMB_TLBEN in ACR so that the transactions which
+	 * bypass with SMMU due to no stream match found in the SMR table
+	 * are updated in the TLB's.
+	 */
+	reg |= ACR_SMTNMB_TLBEN;
+	writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
 
 	/* Make sure all context banks are disabled and clear CB_FSR  */
 	for (i = 0; i < smmu->num_context_banks; ++i) {
-- 
1.9.1
