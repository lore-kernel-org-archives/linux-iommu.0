From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v9 10/16] iommu/exynos: remove custom fault handler
Date: Thu, 08 Aug 2013 18:39:48 +0900
Message-ID: <002e01ce941b$394d2cf0$abe786d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This commit removes custom fault handler. The device drivers that
need to register fault handler can register
with iommu_set_fault_handler().

Reviewed-by: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   71 ++++++++++--------------------------------
 1 files changed, 17 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 88b9139..e8f3e82 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -131,16 +131,6 @@ enum exynos_sysmmu_inttype {
 	SYSMMU_FAULTS_NUM
 };
 
-/*
- * @itype: type of fault.
- * @pgtable_base: the physical address of page table base. This is 0 if @itype
- *                is SYSMMU_BUSERROR.
- * @fault_addr: the device (virtual) address that the System MMU tried to
- *             translated. This is 0 if @itype is SYSMMU_BUSERROR.
- */
-typedef int (*sysmmu_fault_handler_t)(enum exynos_sysmmu_inttype itype,
-			unsigned long pgtable_base, unsigned long fault_addr);
-
 static unsigned short fault_reg_offset[SYSMMU_FAULTS_NUM] = {
 	REG_PAGE_FAULT_ADDR,
 	REG_AR_FAULT_ADDR,
@@ -182,7 +172,6 @@ struct sysmmu_drvdata {
 	int activations;
 	rwlock_t lock;
 	struct iommu_domain *domain;
-	sysmmu_fault_handler_t fault_handler;
 	unsigned long pgtable;
 	void __iomem *sfrbases[0];
 };
@@ -318,34 +307,17 @@ finish:
 	read_unlock_irqrestore(&data->lock, flags);
 }
 
-static void __set_fault_handler(struct sysmmu_drvdata *data,
-					sysmmu_fault_handler_t handler)
-{
-	unsigned long flags;
-
-	write_lock_irqsave(&data->lock, flags);
-	data->fault_handler = handler;
-	write_unlock_irqrestore(&data->lock, flags);
-}
-
-void exynos_sysmmu_set_fault_handler(struct device *dev,
-					sysmmu_fault_handler_t handler)
-{
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
-
-	__set_fault_handler(data, handler);
-}
-
-static int default_fault_handler(enum exynos_sysmmu_inttype itype,
-		     unsigned long pgtable_base, unsigned long fault_addr)
+static void show_fault_information(const char *name,
+		enum exynos_sysmmu_inttype itype,
+		unsigned long pgtable_base, unsigned long fault_addr)
 {
 	unsigned long *ent;
 
 	if ((itype >= SYSMMU_FAULTS_NUM) || (itype < SYSMMU_PAGEFAULT))
 		itype = SYSMMU_FAULT_UNKNOWN;
 
-	pr_err("%s occurred at 0x%lx(Page table base: 0x%lx)\n",
-			sysmmu_fault_name[itype], fault_addr, pgtable_base);
+	pr_err("%s occurred at 0x%lx by %s(Page table base: 0x%lx)\n",
+		sysmmu_fault_name[itype], fault_addr, name, pgtable_base);
 
 	ent = section_entry(__va(pgtable_base), fault_addr);
 	pr_err("\tLv1 entry: 0x%lx\n", *ent);
@@ -358,16 +330,12 @@ static int default_fault_handler(enum exynos_sysmmu_inttype itype,
 	pr_err("Generating Kernel OOPS... because it is unrecoverable.\n");
 
 	BUG();
-
-	return 0;
 }
 
 static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 {
 	/* SYSMMU is in blocked when interrupt occurred. */
 	struct sysmmu_drvdata *data = dev_id;
-	struct resource *irqres;
-	struct platform_device *pdev;
 	enum exynos_sysmmu_inttype itype;
 	unsigned long addr = -1;
 
@@ -377,16 +345,17 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	WARN_ON(!is_sysmmu_active(data));
 
-	pdev = to_platform_device(data->sysmmu);
-	for (i = 0; i < (pdev->num_resources / 2); i++) {
-		irqres = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+	for (i = 0; i < data->nsfrs; i++) {
+		struct resource *irqres;
+		irqres = platform_get_resource(to_platform_device(data->sysmmu),
+						IORESOURCE_IRQ, i);
 		if (irqres && ((int)irqres->start == irq))
 			break;
 	}
 
 	clk_enable(data->clk_master);
 
-	if (i == pdev->num_resources) {
+	if (i == data->nsfrs) {
 		itype = SYSMMU_FAULT_UNKNOWN;
 	} else {
 		itype = (enum exynos_sysmmu_inttype)
@@ -402,19 +371,15 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 		ret = report_iommu_fault(data->domain, data->dev,
 				addr, itype);
 
-	if ((ret == -ENOSYS) && data->fault_handler) {
-		unsigned long base = data->pgtable;
-		if (itype != SYSMMU_FAULT_UNKNOWN)
-			base = __raw_readl(
-					data->sfrbases[i] + REG_PT_BASE_ADDR);
-		ret = data->fault_handler(itype, base, addr);
-	}
-
 	if (!ret && (itype != SYSMMU_FAULT_UNKNOWN))
 		__raw_writel(1 << itype, data->sfrbases[i] + REG_INT_CLEAR);
-	else
-		dev_dbg(data->sysmmu, "%s is not handled.\n",
-				sysmmu_fault_name[itype]);
+	else {
+		unsigned long ba = data->pgtable;
+		if (itype != SYSMMU_FAULT_UNKNOWN)
+			ba = __raw_readl(data->sfrbases[i] + REG_PT_BASE_ADDR);
+		show_fault_information(dev_name(data->sysmmu),
+					itype, ba, addr);
+	}
 
 	if (itype != SYSMMU_FAULT_UNKNOWN)
 		sysmmu_unblock(data->sfrbases[i]);
@@ -663,8 +628,6 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	__set_fault_handler(data, &default_fault_handler);
-
 	data->sysmmu = dev;
 	data->clk = devm_clk_get(dev, "sysmmu");
 	if (IS_ERR(data->clk)) {
-- 
1.7.2.5
