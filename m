From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v10 13/20] iommu/exynos: gating clocks of master H/W
Date: Mon, 07 Oct 2013 10:57:33 +0900
Message-ID: <20131007105733.84f7231ff8b043b2fe928ea9@samsung.com>
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
To: Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch gates clocks of master H/W as well as clocks of System MMU
if master clocks are specified.

Some Exynos SoCs (i.e. GScalers in Exynos5250) have dependencies in
the gating clocks of master H/W and its System MMU. If a H/W is the
case, accessing control registers of System MMU is prohibited unless
both of the gating clocks of System MMU and its master H/W.

CC: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |   75 +++++++++++++++++++++++++++++++----------
 1 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index cf30519..75efdb81 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -80,6 +80,8 @@
 #define CTRL_BLOCK	0x7
 #define CTRL_DISABLE	0x0
 
+#define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
+
 #define REG_MMU_CTRL		0x000
 #define REG_MMU_CFG		0x004
 #define REG_MMU_STATUS		0x008
@@ -96,6 +98,9 @@
 
 #define REG_MMU_VERSION		0x034
 
+#define MMU_MAJ_VER(reg)	(reg >> 28)
+#define MMU_MIN_VER(reg)	((reg >> 21) & 0x7F)
+
 #define REG_PB0_SADDR		0x04C
 #define REG_PB0_EADDR		0x050
 #define REG_PB1_SADDR		0x054
@@ -173,6 +178,7 @@ struct sysmmu_drvdata {
 	struct device *dev;	/* Owner of system MMU */
 	void __iomem *sfrbase;
 	struct clk *clk;
+	struct clk *clk_master;
 	int activations;
 	rwlock_t lock;
 	struct iommu_domain *domain;
@@ -199,6 +205,22 @@ static bool is_sysmmu_active(struct sysmmu_drvdata *data)
 	return data->activations > 0;
 }
 
+static unsigned int __sysmmu_version(struct sysmmu_drvdata *data,
+				     unsigned int *minor)
+{
+	unsigned long major;
+
+	major = readl(data->sfrbase + REG_MMU_VERSION);
+
+	if (minor)
+		*minor = MMU_MIN_VER(major);
+
+	if (MMU_MAJ_VER(major) > 3)
+		return 1;
+
+	return MMU_MAJ_VER(major);
+}
+
 static void sysmmu_unblock(void __iomem *sfrbase)
 {
 	__raw_writel(CTRL_ENABLE, sfrbase + REG_MMU_CTRL);
@@ -245,13 +267,6 @@ static void __sysmmu_set_ptbase(void __iomem *sfrbase,
 	__sysmmu_tlb_invalidate(sfrbase);
 }
 
-static void __sysmmu_set_prefbuf(void __iomem *sfrbase, unsigned long base,
-						unsigned long size, int idx)
-{
-	__raw_writel(base, sfrbase + REG_PB0_SADDR + idx * 8);
-	__raw_writel(size - 1 + base,  sfrbase + REG_PB0_EADDR + idx * 8);
-}
-
 static void __set_fault_handler(struct sysmmu_drvdata *data,
 					sysmmu_fault_handler_t handler)
 {
@@ -308,6 +323,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	WARN_ON(!is_sysmmu_active(data));
 
+	clk_enable(data->clk_master);
 	itype = (enum exynos_sysmmu_inttype)
 		__ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
 	if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
@@ -334,6 +350,8 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	if (itype != SYSMMU_FAULT_UNKNOWN)
 		sysmmu_unblock(data->sfrbase);
 
+	clk_disable(data->clk_master);
+
 	read_unlock(&data->lock);
 
 	return IRQ_HANDLED;
@@ -349,10 +367,13 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 	if (!set_sysmmu_inactive(data))
 		goto finish;
 
+	clk_enable(data->clk_master);
+
 	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 
-	if (data->clk)
-		clk_disable(data->clk);
+	clk_disable(data->clk_master);
+
+	clk_disable(data->clk);
 
 	disabled = true;
 	data->pgtable = 0;
@@ -380,6 +401,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 {
 	int ret = 0;
 	unsigned long flags;
+	unsigned int min;
 
 	write_lock_irqsave(&data->lock, flags);
 
@@ -395,22 +417,24 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 		goto finish;
 	}
 
-	if (data->clk)
-		clk_enable(data->clk);
 
 	data->pgtable = pgtable;
 
+	clk_enable(data->clk);
+	clk_enable(data->clk_master);
+
 	__sysmmu_set_ptbase(data->sfrbase, pgtable);
 
-	if ((readl(data->sfrbase + REG_MMU_VERSION) >> 28) == 3) {
-		/* System MMU version is 3.x */
-		__raw_writel((1 << 12) | (2 << 28), data->sfrbase + REG_MMU_CFG);
-		__sysmmu_set_prefbuf(data->sfrbase, 0, -1, 0);
-		__sysmmu_set_prefbuf(data->sfrbase, 0, -1, 1);
+	if ((__sysmmu_version(data, &min) == 3) && (min > 1)) {
+		unsigned long cfg;
+		cfg = __raw_readl(data->sfrbase + REG_MMU_CFG);
+		__raw_writel(cfg | CFG_FLPDCACHE, data->sfrbase + REG_MMU_CFG);
 	}
 
 	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
+	clk_disable(data->clk_master);
+
 	data->domain = domain;
 
 	dev_dbg(data->sysmmu, "Enabled\n");
@@ -465,23 +489,23 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 	read_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
-		unsigned int maj;
 		unsigned int num_inv = 1;
-		maj = __raw_readl(data->sfrbase + REG_MMU_VERSION);
 		/*
 		 * L2TLB invalidation required
 		 * 4KB page: 1 invalidation
 		 * 64KB page: 16 invalidation
 		 * 1MB page: 64 invalidation
 		 */
-		if ((maj >> 28) == 2) /* major version number */
+		if (__sysmmu_version(data, NULL) == 2)
 			num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
 
+		clk_enable(data->clk_master);
 		if (sysmmu_block(data->sfrbase)) {
 			__sysmmu_tlb_invalidate_entry(data->sfrbase, iova,
 							num_inv);
 			sysmmu_unblock(data->sfrbase);
 		}
+		clk_disable(data->clk_master);
 	} else {
 		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
@@ -497,10 +521,12 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 	read_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
+		clk_enable(data->clk_master);
 		if (sysmmu_block(data->sfrbase)) {
 			__sysmmu_tlb_invalidate(data->sfrbase);
 			sysmmu_unblock(data->sfrbase);
 		}
+		clk_disable(data->clk_master);
 	} else {
 		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
@@ -554,6 +580,17 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	data->clk_master = devm_clk_get(dev, "master");
+	if (IS_ERR(data->clk_master))
+		data->clk_master = NULL;
+
+	ret = clk_prepare(data->clk_master);
+	if (ret) {
+		clk_unprepare(data->clk);
+		dev_err(dev, "Failed to prepare master's clk\n");
+		return ret;
+	}
+
 	data->sysmmu = dev;
 	rwlock_init(&data->lock);
 	INIT_LIST_HEAD(&data->node);
-- 
1.7.2.5
