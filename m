From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 01/13] iommu/arm-smmu: Fix enabling of PRIQ interrupt
Date: Mon,  3 Aug 2015 14:25:43 +0100
Message-ID: <1438608355-7335-2-git-send-email-will.deacon@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438608355-7335-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>

When an ARM SMMUv3 instance supports PRI, the driver registers
an interrupt handler, but fails to enable the generation of
such interrupt at the SMMU level.

This patches simply moves the enable flags to a variable that
gets updated by the PRI handling code before being written to the
SMMU register.

Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index da902baaa794..5d2cbdab5afa 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -118,6 +118,7 @@
 
 #define ARM_SMMU_IRQ_CTRL		0x50
 #define IRQ_CTRL_EVTQ_IRQEN		(1 << 2)
+#define IRQ_CTRL_PRIQ_IRQEN		(1 << 1)
 #define IRQ_CTRL_GERROR_IRQEN		(1 << 0)
 
 #define ARM_SMMU_IRQ_CTRLACK		0x54
@@ -2198,6 +2199,7 @@ static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
+	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
 
 	/* Disable IRQs first */
 	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
@@ -2252,13 +2254,13 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 			if (IS_ERR_VALUE(ret))
 				dev_warn(smmu->dev,
 					 "failed to enable priq irq\n");
+			else
+				irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 		}
 	}
 
 	/* Enable interrupt generation on the SMMU */
-	ret = arm_smmu_write_reg_sync(smmu,
-				      IRQ_CTRL_EVTQ_IRQEN |
-				      IRQ_CTRL_GERROR_IRQEN,
+	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
 				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
 	if (ret)
 		dev_warn(smmu->dev, "failed to enable irqs\n");
-- 
2.1.4
