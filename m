From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 11/13] iommu/arm-smmu: Fix write to GERRORN register
Date: Thu, 17 Dec 2015 12:12:11 +0000
Message-ID: <1450354333-27256-12-git-send-email-will.deacon@arm.com>
References: <1450354333-27256-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450354333-27256-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, zhangbo_a-95E7rUnPDLLQT0dZR+AlfA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

When acknowledging global errors, the GERRORN register should be written
with the original GERROR value so that active errors are toggled.

This patch fixed the driver to write the original GERROR value to
GERRORN, instead of an active error mask.

Signed-off-by: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
[will: reworked use of active bits and fixed commit log]
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4991e79465ee..488f763877d2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1256,50 +1256,50 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
-	u32 gerror, gerrorn;
+	u32 gerror, gerrorn, active;
 	struct arm_smmu_device *smmu = dev;
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
 
-	gerror ^= gerrorn;
-	if (!(gerror & GERROR_ERR_MASK))
+	active = gerror ^ gerrorn;
+	if (!(active & GERROR_ERR_MASK))
 		return IRQ_NONE; /* No errors pending */
 
 	dev_warn(smmu->dev,
 		 "unexpected global error reported (0x%08x), this could be serious\n",
-		 gerror);
+		 active);
 
-	if (gerror & GERROR_SFM_ERR) {
+	if (active & GERROR_SFM_ERR) {
 		dev_err(smmu->dev, "device has entered Service Failure Mode!\n");
 		arm_smmu_device_disable(smmu);
 	}
 
-	if (gerror & GERROR_MSI_GERROR_ABT_ERR)
+	if (active & GERROR_MSI_GERROR_ABT_ERR)
 		dev_warn(smmu->dev, "GERROR MSI write aborted\n");
 
-	if (gerror & GERROR_MSI_PRIQ_ABT_ERR) {
+	if (active & GERROR_MSI_PRIQ_ABT_ERR) {
 		dev_warn(smmu->dev, "PRIQ MSI write aborted\n");
 		arm_smmu_priq_handler(irq, smmu->dev);
 	}
 
-	if (gerror & GERROR_MSI_EVTQ_ABT_ERR) {
+	if (active & GERROR_MSI_EVTQ_ABT_ERR) {
 		dev_warn(smmu->dev, "EVTQ MSI write aborted\n");
 		arm_smmu_evtq_handler(irq, smmu->dev);
 	}
 
-	if (gerror & GERROR_MSI_CMDQ_ABT_ERR) {
+	if (active & GERROR_MSI_CMDQ_ABT_ERR) {
 		dev_warn(smmu->dev, "CMDQ MSI write aborted\n");
 		arm_smmu_cmdq_sync_handler(irq, smmu->dev);
 	}
 
-	if (gerror & GERROR_PRIQ_ABT_ERR)
+	if (active & GERROR_PRIQ_ABT_ERR)
 		dev_err(smmu->dev, "PRIQ write aborted -- events may have been lost\n");
 
-	if (gerror & GERROR_EVTQ_ABT_ERR)
+	if (active & GERROR_EVTQ_ABT_ERR)
 		dev_err(smmu->dev, "EVTQ write aborted -- events may have been lost\n");
 
-	if (gerror & GERROR_CMDQ_ERR)
+	if (active & GERROR_CMDQ_ERR)
 		arm_smmu_cmdq_skip_err(smmu);
 
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
-- 
2.1.4
