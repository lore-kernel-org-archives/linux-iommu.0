From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: don't touch the secure STLBIALL register
Date: Tue, 23 Dec 2014 09:39:22 -0800
Message-ID: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently we do a STLBIALL when we initialize the SMMU.  However, in
some configurations that register is not supposed to be touched and is
marked as "Secure only" in the spec.  Rip it out.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 60558f794922..9170bbced5e5 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -173,7 +173,6 @@
 #define PIDR2_ARCH_MASK			0xf
 
 /* Global TLB invalidation */
-#define ARM_SMMU_GR0_STLBIALL		0x60
 #define ARM_SMMU_GR0_TLBIVMID		0x64
 #define ARM_SMMU_GR0_TLBIALLNSNH	0x68
 #define ARM_SMMU_GR0_TLBIALLH		0x6c
@@ -1686,7 +1685,6 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	}
 
 	/* Invalidate the TLB, just in case */
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
