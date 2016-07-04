From: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu: arm-smmu: use devm_request_irq and devm_free_irq
Date: Mon,  4 Jul 2016 17:38:22 +0800
Message-ID: <1467625102-9755-1-git-send-email-van.freenix@gmail.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use devm_request_irq to simplify error handling path,
when probe smmu device.

Also devm_{request|free}_irq when init or destroy domain context.

Signed-off-by: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9345a3f..860652e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -987,8 +987,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	 * handler seeing a half-initialised domain state.
 	 */
 	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
-	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
-			  "arm-smmu-context-fault", domain);
+	ret = devm_request_irq(smmu->dev, irq, arm_smmu_context_fault,
+			       IRQF_SHARED, "arm-smmu-context-fault", domain);
 	if (ret < 0) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
 			cfg->irptndx, irq);
@@ -1028,7 +1028,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	if (cfg->irptndx != INVALID_IRPTNDX) {
 		irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
-		free_irq(irq, domain);
+		devm_free_irq(smmu->dev, irq, domain);
 	}
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
@@ -1986,15 +1986,15 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
-		err = request_irq(smmu->irqs[i],
-				  arm_smmu_global_fault,
-				  IRQF_SHARED,
-				  "arm-smmu global fault",
-				  smmu);
+		err = devm_request_irq(smmu->dev, smmu->irqs[i],
+				       arm_smmu_global_fault,
+				       IRQF_SHARED,
+				       "arm-smmu global fault",
+				       smmu);
 		if (err) {
 			dev_err(dev, "failed to request global IRQ %d (%u)\n",
 				i, smmu->irqs[i]);
-			goto out_free_irqs;
+			goto out_put_masters;
 		}
 	}
 
@@ -2006,10 +2006,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	arm_smmu_device_reset(smmu);
 	return 0;
 
-out_free_irqs:
-	while (i--)
-		free_irq(smmu->irqs[i], smmu);
-
 out_put_masters:
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master
@@ -2050,7 +2046,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		dev_err(dev, "removing device with active domains!\n");
 
 	for (i = 0; i < smmu->num_global_irqs; ++i)
-		free_irq(smmu->irqs[i], smmu);
+		devm_free_irq(smmu->dev, smmu->irqs[i], smmu);
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
-- 
2.6.2
