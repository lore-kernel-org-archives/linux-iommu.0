From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: Ensure IAS is set correctly for
	AArch32-capable SMMUs
Date: Fri, 18 Sep 2015 15:42:04 +0100
Message-ID: <1442587324-16335-1-git-send-email-will.deacon@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

AArch32-capable SMMU implementations have a minimum IAS of 40 bits, so
ensure that is reflected in the stage-2 page table configuration.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index dafaf59dc3b8..a24f359fa0d0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -56,6 +56,7 @@
 #define IDR0_TTF_SHIFT			2
 #define IDR0_TTF_MASK			0x3
 #define IDR0_TTF_AARCH64		(2 << IDR0_TTF_SHIFT)
+#define IDR0_TTF_AARCH32_64		(3 << IDR0_TTF_SHIFT)
 #define IDR0_S1P			(1 << 1)
 #define IDR0_S2P			(1 << 0)
 
@@ -2460,7 +2461,13 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 	}
 
 	/* We only support the AArch64 table format at present */
-	if ((reg & IDR0_TTF_MASK << IDR0_TTF_SHIFT) < IDR0_TTF_AARCH64) {
+	switch (reg & IDR0_TTF_MASK << IDR0_TTF_SHIFT) {
+	case IDR0_TTF_AARCH32_64:
+		smmu->ias = 40;
+		/* Fallthrough */
+	case IDR0_TTF_AARCH64:
+		break;
+	default:
 		dev_err(smmu->dev, "AArch64 table format not supported!\n");
 		return -ENXIO;
 	}
@@ -2541,8 +2548,7 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 		dev_warn(smmu->dev,
 			 "failed to set DMA mask for table walker\n");
 
-	if (!smmu->ias)
-		smmu->ias = smmu->oas;
+	smmu->ias = max(smmu->ias, smmu->oas);
 
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
-- 
2.1.4
