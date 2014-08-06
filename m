From: Hans Wennborg <hans@hanshq.net>
Subject: [PATCH 03/15] iommu/arm-smmu: fix decimal printf format specifiers prefixed with 0x
Date: Tue,  5 Aug 2014 21:42:01 -0700
Message-ID: <1407300121-32432-1-git-send-email-hans@hanshq.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Hans Wennborg <hans@hanshq.net>
List-Id: iommu@lists.linux-foundation.org

The prefix suggests the number should be printed in hex, so use
the %x specifier to do that.

Found by using regex suggested by Joe Perches.

Signed-off-by: Hans Wennborg <hans@hanshq.net>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ca18d6d..d84f983 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -623,7 +623,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 
 	if (fsr & FSR_IGN)
 		dev_err_ratelimited(smmu->dev,
-				    "Unexpected context fault (fsr 0x%u)\n",
+				    "Unexpected context fault (fsr 0x%x)\n",
 				    fsr);
 
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
-- 
2.0.0.526.g5318336
