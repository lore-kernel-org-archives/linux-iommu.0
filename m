From: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v7 3/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
	erratum #126
Date: Tue, 30 May 2017 17:33:41 +0530
Message-ID: <1496145821-3411-4-git-send-email-gakula@caviumnetworks.com>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1496145821-3411-1-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
lines for gerror, eventq and cmdq-sync.

This patch addresses the issue by checking if any interrupt sources are
using same irq number, then they are registered as shared irqs.

Signed-off-by: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 Documentation/arm64/silicon-errata.txt |    1 +
 drivers/iommu/arm-smmu-v3.c            |   29 +++++++++++++++++++++++++----
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
index 4e80205..d2db01f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2232,6 +2232,25 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
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
@@ -2252,7 +2271,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	if (irq) {
 		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 						arm_smmu_evtq_thread,
-						IRQF_ONESHOT,
+						get_irq_flags(smmu, irq),
 						"arm-smmu-v3-evtq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable evtq irq\n");
@@ -2261,7 +2280,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	irq = smmu->cmdq.q.irq;
 	if (irq) {
 		ret = devm_request_irq(smmu->dev, irq,
-				       arm_smmu_cmdq_sync_handler, 0,
+				       arm_smmu_cmdq_sync_handler,
+					   get_irq_flags(smmu, irq),
 				       "arm-smmu-v3-cmdq-sync", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable cmdq-sync irq\n");
@@ -2270,7 +2290,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	irq = smmu->gerr_irq;
 	if (irq) {
 		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
-				       0, "arm-smmu-v3-gerror", smmu);
+						get_irq_flags(smmu, irq),
+						"arm-smmu-v3-gerror", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable gerror irq\n");
 	}
@@ -2280,7 +2301,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		if (irq) {
 			ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 							arm_smmu_priq_thread,
-							IRQF_ONESHOT,
+							get_irq_flags(smmu, irq),
 							"arm-smmu-v3-priq",
 							smmu);
 			if (ret < 0)
-- 
1.7.1
