From: Geetha sowjanya <gakula@caviumnetworks.com>
Subject: [v4 4/4] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126
Date: Tue,  9 May 2017 17:15:14 +0530
Message-ID: <1494330314-30179-5-git-send-email-gakula@caviumnetworks.com>
References: <1494330314-30179-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1494330314-30179-1-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org
Cc: jcm@redhat.com, linux-kernel@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>

Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
lines for gerror, eventq and cmdq-sync.

This patch addresses the issue by checking if any interrupt sources are
using same irq number, then they are registered as shared irqs.

Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 drivers/iommu/arm-smmu-v3.c            | 29 +++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 4693a32..42422f6 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -63,6 +63,7 @@ stable kernels.
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
 | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
+| Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
 |                |                 |                 |                             |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 |                |                 |                 |                             |
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1e986a0..a1c09f4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2236,6 +2236,25 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	devm_add_action(dev, arm_smmu_free_msis, dev);
 }
 
+static int get_irq_flags(struct arm_smmu_device *smmu, int irq)
+{
+	int match_count = 0;
+
+	if (irq == smmu->evtq.q.irq)
+		match_count++;
+	if (irq == smmu->cmdq.q.irq)
+		match_count++;
+	if (irq == smmu->gerr_irq)
+		match_count++;
+	if (irq == smmu->priq.q.irq)
+		match_count++;
+
+	if (match_count > 1)
+		return IRQF_SHARED | IRQF_ONESHOT;
+
+	return IRQF_ONESHOT;
+}
+
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
@@ -2256,7 +2275,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	if (irq) {
 		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 						arm_smmu_evtq_thread,
-						IRQF_ONESHOT,
+						get_irq_flags(smmu, irq),
 						"arm-smmu-v3-evtq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable evtq irq\n");
@@ -2265,7 +2284,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	irq = smmu->cmdq.q.irq;
 	if (irq) {
 		ret = devm_request_irq(smmu->dev, irq,
-				       arm_smmu_cmdq_sync_handler, 0,
+				       arm_smmu_cmdq_sync_handler,
+					   get_irq_flags(smmu, irq),
 				       "arm-smmu-v3-cmdq-sync", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable cmdq-sync irq\n");
@@ -2274,7 +2294,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	irq = smmu->gerr_irq;
 	if (irq) {
 		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
-				       0, "arm-smmu-v3-gerror", smmu);
+						get_irq_flags(smmu, irq),
+						"arm-smmu-v3-gerror", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable gerror irq\n");
 	}
@@ -2284,7 +2305,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		if (irq) {
 			ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 							arm_smmu_priq_thread,
-							IRQF_ONESHOT,
+							get_irq_flags(smmu, irq),
 							"arm-smmu-v3-priq",
 							smmu);
 			if (ret < 0)
-- 
1.8.3.1

