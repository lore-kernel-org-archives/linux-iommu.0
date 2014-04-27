From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Subject: [PATCH v12 13/31] iommu/exynos: gating clocks of master H/W
Date: Sun, 27 Apr 2014 13:07:45 +0530
Message-ID: <1398584283-22846-14-git-send-email-shaik.ameer@samsung.com>
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

This patch gates clocks of master H/W as well as clocks of System MMU
if master clocks are specified.

Some Exynos SoCs (i.e. GScalers in Exynos5250) have dependencies in
the gating clocks of master H/W and its System MMU. If a H/W is the
case, accessing control registers of System MMU is prohibited unless
both of the gating clocks of System MMU and its master H/W.

CC: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index cbb9b67..ba477c4 100755
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -172,6 +172,7 @@ struct sysmmu_drvdata {
 	struct device *dev;	/* Owner of system MMU */
 	void __iomem *sfrbase;
 	struct clk *clk;
+	struct clk *clk_master;
 	int activations;
 	rwlock_t lock;
 	struct iommu_domain *domain;
@@ -300,6 +301,8 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	WARN_ON(!is_sysmmu_active(data));
 
+	if (!IS_ERR(data->clk_master))
+		clk_enable(data->clk_master);
 	itype = (enum exynos_sysmmu_inttype)
 		__ffs(__raw_readl(data->sfrbase + REG_INT_STATUS));
 	if (WARN_ON(!((itype >= 0) && (itype < SYSMMU_FAULT_UNKNOWN))))
@@ -326,6 +329,9 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	if (itype != SYSMMU_FAULT_UNKNOWN)
 		sysmmu_unblock(data->sfrbase);
 
+	if (!IS_ERR(data->clk_master))
+		clk_disable(data->clk_master);
+
 	read_unlock(&data->lock);
 
 	return IRQ_HANDLED;
@@ -341,9 +347,14 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 	if (!set_sysmmu_inactive(data))
 		goto finish;
 
+	if (!IS_ERR(data->clk_master))
+		clk_enable(data->clk_master);
+
 	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 
 	clk_disable(data->clk);
+	if (!IS_ERR(data->clk_master))
+		clk_disable(data->clk_master);
 
 	disabled = true;
 	data->pgtable = 0;
@@ -386,14 +397,19 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 		goto finish;
 	}
 
-	clk_enable(data->clk);
-
 	data->pgtable = pgtable;
 
+	if (!IS_ERR(data->clk_master))
+		clk_enable(data->clk_master);
+	clk_enable(data->clk);
+
 	__sysmmu_set_ptbase(data->sfrbase, pgtable);
 
 	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
 
+	if (!IS_ERR(data->clk_master))
+		clk_disable(data->clk_master);
+
 	data->domain = domain;
 
 	dev_dbg(data->sysmmu, "Enabled\n");
@@ -450,6 +466,10 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 	if (is_sysmmu_active(data)) {
 		unsigned int maj;
 		unsigned int num_inv = 1;
+
+		if (!IS_ERR(data->clk_master))
+			clk_enable(data->clk_master);
+
 		maj = __raw_readl(data->sfrbase + REG_MMU_VERSION);
 		/*
 		 * L2TLB invalidation required
@@ -469,6 +489,8 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
 							num_inv);
 			sysmmu_unblock(data->sfrbase);
 		}
+		if (!IS_ERR(data->clk_master))
+			clk_disable(data->clk_master);
 	} else {
 		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
@@ -484,10 +506,14 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 	read_lock_irqsave(&data->lock, flags);
 
 	if (is_sysmmu_active(data)) {
+		if (!IS_ERR(data->clk_master))
+			clk_enable(data->clk_master);
 		if (sysmmu_block(data->sfrbase)) {
 			__sysmmu_tlb_invalidate(data->sfrbase);
 			sysmmu_unblock(data->sfrbase);
 		}
+		if (!IS_ERR(data->clk_master))
+			clk_disable(data->clk_master);
 	} else {
 		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
 	}
@@ -536,6 +562,16 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	data->clk_master = devm_clk_get(dev, "master");
+	if (!IS_ERR(data->clk_master)) {
+		ret = clk_prepare(data->clk_master);
+		if (ret) {
+			clk_unprepare(data->clk);
+			dev_err(dev, "Failed to prepare master's clk\n");
+			return ret;
+		}
+	}
+
 	data->sysmmu = dev;
 	rwlock_init(&data->lock);
 	INIT_LIST_HEAD(&data->node);
-- 
1.7.9.5
