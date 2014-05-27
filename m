From: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu: msm: use devm_ioremap_resource to simplify code
Date: Tue, 27 May 2014 18:18:42 +0800
Message-ID: <1401185922-6908-1-git-send-email-wangkefeng.wang@huawei.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use devm_ioremap_resource() to make the code simpler, drop unused variable,
redundant return value check, and error-handing code.

Signed-off-by: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/msm_iommu_dev.c |   38 +++++++-------------------------------
 1 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev.c
index 08ba497..61def7c 100644
--- a/drivers/iommu/msm_iommu_dev.c
+++ b/drivers/iommu/msm_iommu_dev.c
@@ -127,13 +127,12 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
 
 static int msm_iommu_probe(struct platform_device *pdev)
 {
-	struct resource *r, *r2;
+	struct resource *r;
 	struct clk *iommu_clk;
 	struct clk *iommu_pclk;
 	struct msm_iommu_drvdata *drvdata;
 	struct msm_iommu_dev *iommu_dev = pdev->dev.platform_data;
 	void __iomem *regs_base;
-	resource_size_t	len;
 	int ret, irq, par;
 
 	if (pdev->id == -1) {
@@ -178,35 +177,16 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		iommu_clk = NULL;
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "physbase");
-
-	if (!r) {
-		ret = -ENODEV;
-		goto fail_clk;
-	}
-
-	len = resource_size(r);
-
-	r2 = request_mem_region(r->start, len, r->name);
-	if (!r2) {
-		pr_err("Could not request memory region: start=%p, len=%d\n",
-							(void *) r->start, len);
-		ret = -EBUSY;
+	regs_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(regs_base)) {
+		ret = PTR_ERR(regs_base);
 		goto fail_clk;
 	}
 
-	regs_base = ioremap(r2->start, len);
-
-	if (!regs_base) {
-		pr_err("Could not ioremap: start=%p, len=%d\n",
-			 (void *) r2->start, len);
-		ret = -EBUSY;
-		goto fail_mem;
-	}
-
 	irq = platform_get_irq_byname(pdev, "secure_irq");
 	if (irq < 0) {
 		ret = -ENODEV;
-		goto fail_io;
+		goto fail_clk;
 	}
 
 	msm_iommu_reset(regs_base, iommu_dev->ncb);
@@ -222,14 +202,14 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	if (!par) {
 		pr_err("%s: Invalid PAR value detected\n", iommu_dev->name);
 		ret = -ENODEV;
-		goto fail_io;
+		goto fail_clk;
 	}
 
 	ret = request_irq(irq, msm_iommu_fault_handler, 0,
 			"msm_iommu_secure_irpt_handler", drvdata);
 	if (ret) {
 		pr_err("Request IRQ %d failed with ret=%d\n", irq, ret);
-		goto fail_io;
+		goto fail_clk;
 	}
 
 
@@ -250,10 +230,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 	clk_disable(iommu_pclk);
 
 	return 0;
-fail_io:
-	iounmap(regs_base);
-fail_mem:
-	release_mem_region(r->start, len);
 fail_clk:
 	if (iommu_clk) {
 		clk_disable(iommu_clk);
-- 
1.7.1
