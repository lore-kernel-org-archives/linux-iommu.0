From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 7/8] iommu/mediatek: Enlarge the validate PA range for 4GB
	mode
Date: Mon, 21 Aug 2017 19:00:20 +0800
Message-ID: <1503313221-26453-8-git-send-email-yong.wu@mediatek.com>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503313221-26453-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cloud.zhou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch is for 4GB mode, mainly for 4 issues:
1) Fix a 4GB bug:
   if the dram base is 0x4000_0000, the dram size is 0xc000_0000.
   then the code just meet a corner case because max_pfn is
   0x10_0000.
   data->enable_4GB = !!(max_pfn > (0xffffffffUL >> PAGE_SHIFT));
   It's true at the case above. That is unexpected.
2) In mt2712, there is a new register for the 4GB PA range(0x118)
   we should enlarge the max PA range, or the HW will report
   error.
   The dram range is from 0x1_0000_0000 to 0x1_ffff_ffff in the 4GB
   mode, we cut out the bit[32:30] of the SA(Start address) and
   EA(End address) into this REG_MMU_VLD_PA_RNG(0x118).
3) In mt2712, the register(0x13c) is extended for 4GB mode.
   bit[7:6] indicate the valid PA[32:33]. Thus, we don't mask the
   value and print it directly for debug.
4) if 4GB is enabled, the dram PA range is from 0x1_0000_0000 to
   0x1_ffff_ffff. Thus, the PA from iova_to_pa should also '|' BIT(32)

Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/mtk_iommu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e21de86..4f233e1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -61,6 +61,8 @@
 
 #define REG_MMU_IVRP_PADDR			0x114
 #define F_MMU_IVRP_PA_SET(pa, ext)		(((pa) >> 1) | ((!!(ext)) << 31))
+#define REG_MMU_VLD_PA_RNG			0x118
+#define F_MMU_VLD_PA_RNG(EA, SA)		(((EA) << 8) | (SA))
 
 #define REG_MMU_INT_CONTROL0			0x120
 #define F_L2_MULIT_HIT_EN			BIT(0)
@@ -85,7 +87,6 @@
 #define REG_MMU_FAULT_ST1			0x134
 
 #define REG_MMU_FAULT_VA			0x13c
-#define F_MMU_FAULT_VA_MSK			0xfffff000
 #define F_MMU_FAULT_VA_WRITE_BIT		BIT(1)
 #define F_MMU_FAULT_VA_LAYER_BIT		BIT(0)
 
@@ -214,7 +215,6 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	fault_iova = readl_relaxed(data->base + REG_MMU_FAULT_VA);
 	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
 	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
-	fault_iova &= F_MMU_FAULT_VA_MSK;
 	fault_pa = readl_relaxed(data->base + REG_MMU_INVLD_PA);
 	regval = readl_relaxed(data->base + REG_MMU_INT_ID);
 	fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
@@ -395,6 +395,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	phys_addr_t pa;
 
@@ -402,6 +403,9 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	if (data->enable_4GB)
+		pa |= BIT(32);
+
 	return pa;
 }
 
@@ -529,6 +533,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 
 	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
 		       data->base + REG_MMU_IVRP_PADDR);
+	if (data->enable_4GB && data->m4u_type != M4U_MT8173) {
+		/*
+		 * If 4GB mode is enabled, the validate PA range is from
+		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
+		 */
+		regval = F_MMU_VLD_PA_RNG(7, 4);
+		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
+	}
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
 
 	/* It's MISC control register whose default value is ok except mt8173.*/
@@ -574,7 +586,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
 	/* Whether the current dram is over 4GB */
-	data->enable_4GB = !!(max_pfn > (0xffffffffUL >> PAGE_SHIFT));
+	data->enable_4GB = !!(max_pfn > (BIT(32) >> PAGE_SHIFT));
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->base = devm_ioremap_resource(dev, res);
-- 
1.9.1
