From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Subject: [PATCH v12 08/31] iommu/exynos: handle one instance of sysmmu with a
 device descriptor
Date: Sun, 27 Apr 2014 13:07:40 +0530
Message-ID: <1398584283-22846-9-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: kgene.kim@samsung.com, prathyush.k@samsung.com, grundler@chromium.org, joro@8bytes.org, supash.ramaswamy@linaro.org, tomasz.figa@gmail.com, joshi@samsung.com, sachin.kamat@linaro.org, s.nawrocki@samsung.com, Varun.Sethi@freescale.com, a.motakis@virtualopensystems.com, pullip.cho@samsung.com, t.figa@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho@samsung.com>

System MMU driver is changed to control only a single instance of
System MMU at a time. Since a single instance of System MMU has only
a single clock descriptor for its clock gating, single address range
for control registers, there is no need to obtain two or more clock
descriptors and ioremaped region.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |  223 ++++++++++++++----------------------------
 1 file changed, 71 insertions(+), 152 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d466076..a15216f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -170,9 +170,8 @@ struct sysmmu_drvdata {
 	struct device *sysmmu;	/* System MMU's device descriptor */
 	struct device *dev;	/* Owner of system MMU */
 	char *dbgname;
-	int nsfrs;
-	void __iomem **sfrbases;
-	struct clk *clk[2];
+	void __iomem *sfrbase;
+	struct clk *clk;
 	int activations;
 	rwlock_t lock;
 	struct iommu_domain *domain;
@@ -293,56 +292,39 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 {
 	/* SYSMMU is in blocked when interrupt occurred. */
 	struct sysmmu_drvdata *data = dev_id;
-	struct resource *irqres;
-	struct platform_device *pdev;
 	enum exynos_sysmmu_inttype itype;
 	unsigned long addr = -1;
-
-	int i, ret = -ENOSYS;
+	int ret = -ENOSYS;
 
 	read_lock(&data->lock);
 
 	WARN_ON(!is_sysmmu_active(data));
 
-	pdev = to_platform_device(data->sysmmu);
-	for (i = 0; i < (pdev->num_resources / 2); i++) {
-		irqres = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (irqres && ((int)irqres->start == irq))
-			break;
-	}
-
-	if (i == pdev->num_resources) {
+	itype = (enum exynos_sysmmu_inttype)
+		__ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
+	if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
 		itype = SYSMMU_FAULT_UNKNOWN;
-	} else {
-		itype = (enum exynos_sysmmu_inttype)
-			__ffs(__raw_readl(data->sfrbases[i] + REG_INT_STATUS));
-		if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
-			itype = SYSMMU_FAULT_UNKNOWN;
-		else
-			addr = __raw_readl(
-				data->sfrbases[i] + fault_reg_offset[itype]);
-	}
+	else
+		addr = __raw_readl(data->sfrbase + fault_reg_offset[itype]);
 
 	if (data->domain)
-		ret = report_iommu_fault(data->domain, data->dev,
-				addr, itype);
+		ret = report_iommu_fault(data->domain, data->dev, addr, itype);
 
 	if ((ret == -ENOSYS) && data->fault_handler) {
 		unsigned long base = data->pgtable;
 		if (itype != SYSMMU_FAULT_UNKNOWN)
-			base = __raw_readl(
-					data->sfrbases[i] + REG_PT_BASE_ADDR);
+			base = __raw_readl(data->sfrbase + REG_PT_BASE_ADDR);
 		ret = data->fault_handler(itype, base, addr);
 	}
 
 	if (!ret && (itype != SYSMMU_FAULT_UNKNOWN))
-		__raw_writel(1 << itype, data->sfrbases[i] + REG_INT_CLEAR);
+		__raw_writel(1 << itype, data->sfrbase + REG_INT_CLEAR);
 	else
 		dev_dbg(data->sysmmu, "(%s) %s is not handled.\n",
 				data->dbgname, sysmmu_fault_name[itype]);
 
 	if (itype != SYSMMU_FAULT_UNKNOWN)
-		sysmmu_unblock(data->sfrbases[i]);
+		sysmmu_unblock(data->sfrbase);
 
 	read_unlock(&data->lock);
 
@@ -353,20 +335,16 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 {
 	unsigned long flags;
 	bool disabled = false;
-	int i;
 
 	write_lock_irqsave(&data->lock, flags);
 
 	if (!set_sysmmu_inactive(data))
 		goto finish;
 
-	for (i = 0; i < data->nsfrs; i++)
-		__raw_writel(CTRL_DISABLE, data->sfrbases[i] + REG_MMU_CTRL);
+	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 
-	if (data->clk[1])
-		clk_disable(data->clk[1]);
-	if (data->clk[0])
-		clk_disable(data->clk[0]);
+	if (!IS_ERR(data->clk))
+		clk_disable(data->clk);
 
 	disabled = true;
 	data->pgtable = 0;
@@ -392,7 +370,7 @@ finish:
 static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 			unsigned long pgtable, struct iommu_domain *domain)
 {
-	int i, ret = 0;
+	int ret = 0;
 	unsigned long flags;
 
 	write_lock_irqsave(&data->lock, flags);
@@ -409,17 +387,14 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 		goto finish;
 	}
 
-	if (data->clk[0])
-		clk_enable(data->clk[0]);
-	if (data->clk[1])
-		clk_enable(data->clk[1]);
+	if (!IS_ERR(data->clk))
+		clk_enable(data->clk);
 
 	data->pgtable = pgtable;
 
-	for (i = 0; i < data->nsfrs; i++) {
-		__sysmmu_set_ptbase(data->sfrbases[i], pgtable);
-		__raw_writel(CTRL_ENABLE, data->sfrbases[i] + REG_MMU_CTRL);
-	}
+	__sysmmu_set_ptbase(data->sfrbase, pgtable);
+
+	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
 	data->domain = domain;
 
@@ -476,28 +451,26 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 	read_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
-		int i;
-		for (i = 0; i < data->nsfrs; i++) {
-			unsigned int maj;
-			unsigned int num_inv = 1;
-			maj = __raw_readl(data->sfrbases[i] + REG_MMU_VERSION);
-			/*
-			 * L2TLB invalidation required
-			 * 4KB page: 1 invalidation
-			 * 64KB page: 16 invalidation
-			 * 1MB page: 64 invalidation
-			 * because it is set-associative TLB
-			 * with 8-way and 64 sets.
-			 * 1MB page can be cached in one of all sets.
-			 * 64KB page can be one of 16 consecutive sets.
-			 */
-			if ((maj >> 28) == 2) /* major version number */
-				num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
-			if (sysmmu_block(data->sfrbases[i])) {
-				__sysmmu_tlb_invalidate_entry(
-					data->sfrbases[i], iova, num_inv);
-				sysmmu_unblock(data->sfrbases[i]);
-			}
+		unsigned int maj;
+		unsigned int num_inv = 1;
+		maj = __raw_readl(data->sfrbase + REG_MMU_VERSION);
+		/*
+		 * L2TLB invalidation required
+		 * 4KB page: 1 invalidation
+		 * 64KB page: 16 invalidation
+		 * 1MB page: 64 invalidation
+		 * because it is set-associative TLB
+		 * with 8-way and 64 sets.
+		 * 1MB page can be cached in one of all sets.
+		 * 64KB page can be one of 16 consecutive sets.
+		 */
+		if ((maj >> 28) == 2) /* major version number */
+			num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
+
+		if (sysmmu_block(data->sfrbase)) {
+			__sysmmu_tlb_invalidate_entry(data->sfrbase, iova,
+							num_inv);
+			sysmmu_unblock(data->sfrbase);
 		}
 	} else {
 		dev_dbg(data->sysmmu,
@@ -516,12 +489,9 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 	read_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
-		int i;
-		for (i = 0; i < data->nsfrs; i++) {
-			if (sysmmu_block(data->sfrbases[i])) {
-				__sysmmu_tlb_invalidate(data->sfrbases[i]);
-				sysmmu_unblock(data->sfrbases[i]);
-			}
+		if (sysmmu_block(data->sfrbase)) {
+			__sysmmu_tlb_invalidate(data->sfrbase);
+			sysmmu_unblock(data->sfrbase);
 		}
 	} else {
 		dev_dbg(data->sysmmu,
@@ -534,11 +504,10 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 
 static int exynos_sysmmu_probe(struct platform_device *pdev)
 {
-	int i, ret;
-	struct device *dev;
+	int ret;
+	struct device *dev = &pdev->dev;
 	struct sysmmu_drvdata *data;
-
-	dev = &pdev->dev;
+	struct resource *res;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
@@ -547,82 +516,37 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	ret = dev_set_drvdata(dev, data);
-	if (ret) {
-		dev_dbg(dev, "Unabled to initialize driver data\n");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_dbg(dev, "Unable to find IOMEM region\n");
+		ret = -ENOENT;
 		goto err_init;
 	}
 
-	data->nsfrs = pdev->num_resources / 2;
-	data->sfrbases = kmalloc(sizeof(*data->sfrbases) * data->nsfrs,
-								GFP_KERNEL);
-	if (data->sfrbases == NULL) {
-		dev_dbg(dev, "Not enough memory\n");
-		ret = -ENOMEM;
-		goto err_init;
+	data->sfrbase = ioremap(res->start, resource_size(res));
+	if (!data->sfrbase) {
+		dev_dbg(dev, "Unable to map IOMEM @ PA:%#x\n", res->start);
+		ret = -ENOENT;
+		goto err_res;
 	}
 
-	for (i = 0; i < data->nsfrs; i++) {
-		struct resource *res;
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		if (!res) {
-			dev_dbg(dev, "Unable to find IOMEM region\n");
-			ret = -ENOENT;
-			goto err_res;
-		}
-
-		data->sfrbases[i] = ioremap(res->start, resource_size(res));
-		if (!data->sfrbases[i]) {
-			dev_dbg(dev, "Unable to map IOMEM @ PA:%#x\n",
-							res->start);
-			ret = -ENOENT;
-			goto err_res;
-		}
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
+		dev_dbg(dev, "Unable to find IRQ resource\n");
+		goto err_irq;
 	}
 
-	for (i = 0; i < data->nsfrs; i++) {
-		ret = platform_get_irq(pdev, i);
-		if (ret <= 0) {
-			dev_dbg(dev, "Unable to find IRQ resource\n");
-			goto err_irq;
-		}
-
-		ret = request_irq(ret, exynos_sysmmu_irq, 0,
-					dev_name(dev), data);
-		if (ret) {
-			dev_dbg(dev, "Unabled to register interrupt handler\n");
-			goto err_irq;
-		}
+	ret = request_irq(ret, exynos_sysmmu_irq, 0,
+				dev_name(dev), data);
+	if (ret) {
+		dev_dbg(dev, "Unabled to register interrupt handler\n");
+		goto err_irq;
 	}
 
 	if (dev_get_platdata(dev)) {
-		char *deli, *beg;
-		struct sysmmu_platform_data *platdata = dev_get_platdata(dev);
-
-		beg = platdata->clockname;
-
-		for (deli = beg; (*deli != '\0') && (*deli != ','); deli++)
-			/* NOTHING */;
-
-		if (*deli == '\0')
-			deli = NULL;
-		else
-			*deli = '\0';
-
-		data->clk[0] = clk_get(dev, beg);
-		if (IS_ERR(data->clk[0])) {
-			data->clk[0] = NULL;
+		data->clk = clk_get(dev, "sysmmu");
+		if (IS_ERR(data->clk))
 			dev_dbg(dev, "No clock descriptor registered\n");
-		}
-
-		if (data->clk[0] && deli) {
-			*deli = ',';
-			data->clk[1] = clk_get(dev, deli + 1);
-			if (IS_ERR(data->clk[1]))
-				data->clk[1] = NULL;
-		}
-
-		data->dbgname = platdata->dbgname;
 	}
 
 	data->sysmmu = dev;
@@ -631,21 +555,16 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	__set_fault_handler(data, &default_fault_handler);
 
+	platform_set_drvdata(pdev, data);
+
 	pm_runtime_enable(dev);
 
 	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
 	return 0;
 err_irq:
-	while (i-- > 0) {
-		int irq;
-
-		irq = platform_get_irq(pdev, i);
-		free_irq(irq, data);
-	}
+	free_irq(platform_get_irq(pdev, 0), data);
 err_res:
-	while (data->nsfrs-- > 0)
-		iounmap(data->sfrbases[data->nsfrs]);
-	kfree(data->sfrbases);
+	iounmap(data->sfrbase);
 err_init:
 	kfree(data);
 err_alloc:
-- 
1.7.9.5
