From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Thu, 16 Jul 2015 17:04:34 +0800
Message-ID: <1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437037475-9065-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds support for mediatek m4u (MultiMedia Memory Management
Unit).

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/Kconfig     |   13 +
 drivers/iommu/Makefile    |    1 +
 drivers/iommu/mtk_iommu.c |  724 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 738 insertions(+)
 create mode 100644 drivers/iommu/mtk_iommu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f50dbf3..3178c12 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -386,4 +386,17 @@ config ARM_SMMU_V3
 	  Say Y here if your system includes an IOMMU device implementing
 	  the ARM SMMUv3 architecture.
 
+config MTK_IOMMU
+	bool "MTK IOMMU Support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select IOMMU_API
+	select IOMMU_DMA
+	select IOMMU_IO_PGTABLE_SHORT
+	select MEMORY
+	select MTK_SMI
+	help
+	  Support for the IOMMUs on certain Mediatek SOCs.
+
+	  If unsure, say N here.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 06df3e6..f4f2f2c 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_ROCKCHIP_IOMMU) += rockchip-iommu.o
 obj-$(CONFIG_TEGRA_IOMMU_GART) += tegra-gart.o
 obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
+obj-$(CONFIG_MTK_IOMMU) += mtk_iommu.o
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
 obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
new file mode 100644
index 0000000..c1c90e6
--- /dev/null
+++ b/drivers/iommu/mtk_iommu.c
@@ -0,0 +1,724 @@
+/*
+ * Copyright (c) 2014-2015 MediaTek Inc.
+ * Author: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/iommu.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-iommu.h>
+#include <linux/of_iommu.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/list.h>
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <asm/cacheflush.h>
+#include <soc/mediatek/smi.h>
+
+#include "io-pgtable.h"
+
+#define REG_MMU_PT_BASE_ADDR			0x000
+
+#define REG_MMU_INVALIDATE			0x020
+#define F_ALL_INVLD				0x2
+#define F_MMU_INV_RANGE				0x1
+
+#define REG_MMU_INVLD_START_A			0x024
+#define REG_MMU_INVLD_END_A			0x028
+
+#define REG_MMU_INV_SEL				0x038
+#define F_INVLD_EN0				BIT(0)
+#define F_INVLD_EN1				BIT(1)
+
+#define REG_MMU_STANDARD_AXI_MODE		0x048
+#define REG_MMU_DCM_DIS				0x050
+
+#define REG_MMU_CTRL_REG			0x110
+#define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
+#define F_MMU_TF_PROTECT_SEL(prot)		(((prot) & 0x3) << 5)
+#define F_COHERENCE_EN				BIT(8)
+
+#define REG_MMU_IVRP_PADDR			0x114
+#define F_MMU_IVRP_PA_SET(pa)			((pa) >> 1)
+
+#define REG_MMU_INT_CONTROL0			0x120
+#define F_L2_MULIT_HIT_EN			BIT(0)
+#define F_TABLE_WALK_FAULT_INT_EN		BIT(1)
+#define F_PREETCH_FIFO_OVERFLOW_INT_EN		BIT(2)
+#define F_MISS_FIFO_OVERFLOW_INT_EN		BIT(3)
+#define F_PREFETCH_FIFO_ERR_INT_EN		BIT(5)
+#define F_MISS_FIFO_ERR_INT_EN			BIT(6)
+#define F_INT_L2_CLR_BIT			BIT(12)
+
+#define REG_MMU_INT_MAIN_CONTROL		0x124
+#define F_INT_TRANSLATION_FAULT			BIT(0)
+#define F_INT_MAIN_MULTI_HIT_FAULT		BIT(1)
+#define F_INT_INVALID_PA_FAULT			BIT(2)
+#define F_INT_ENTRY_REPLACEMENT_FAULT		BIT(3)
+#define F_INT_TLB_MISS_FAULT			BIT(4)
+#define F_INT_MISS_TRANSATION_FIFO_FAULT	BIT(5)
+#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT	BIT(6)
+
+#define REG_MMU_CPE_DONE			0x12C
+
+#define REG_MMU_FAULT_ST1			0x134
+
+#define REG_MMU_FAULT_VA			0x13c
+#define F_MMU_FAULT_VA_MSK			0xfffff000
+#define F_MMU_FAULT_VA_WRITE_BIT		BIT(1)
+#define F_MMU_FAULT_VA_LAYER_BIT		BIT(0)
+
+#define REG_MMU_INVLD_PA			0x140
+#define REG_MMU_INT_ID				0x150
+#define F_MMU0_INT_ID_LARB_ID(a)		(((a) >> 7) & 0x7)
+#define F_MMU0_INT_ID_PORT_ID(a)		(((a) >> 2) & 0x1f)
+
+#define MTK_PROTECT_PA_ALIGN			128
+#define MTK_IOMMU_LARB_MAX_NR			8
+#define MTK_IOMMU_REG_NR			10
+
+struct mtk_iommu_data {
+	void __iomem		*base;
+	int			irq;
+	struct device		*dev;
+	struct device		*larbdev[MTK_IOMMU_LARB_MAX_NR];
+	struct clk		*bclk;
+	phys_addr_t		protect_base; /* protect memory base */
+	int			larb_nr;      /* local arbiter number */
+	u32			reg[MTK_IOMMU_REG_NR];
+};
+
+struct mtk_iommu_domain {
+	struct imu_pgd_t	*pgd;
+	spinlock_t		pgtlock; /* lock for modifying page table */
+
+	struct io_pgtable_cfg   cfg;
+	struct io_pgtable_ops   *iop;
+
+	struct mtk_iommu_data   *data;
+	struct iommu_domain	domain;
+};
+
+struct mtk_iommu_client_priv {
+	struct list_head	client;
+	unsigned int		larbid;
+	unsigned int		portid;
+	struct device		*imudev;
+};
+
+static struct iommu_ops mtk_iommu_ops;
+
+static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct mtk_iommu_domain, domain);
+}
+
+static void mtk_iommu_clear_intr(const struct mtk_iommu_data *data)
+{
+	u32 val;
+
+	val = readl(data->base + REG_MMU_INT_CONTROL0);
+	val |= F_INT_L2_CLR_BIT;
+	writel(val, data->base + REG_MMU_INT_CONTROL0);
+}
+
+static void mtk_iommu_tlb_flush_all(void *cookie)
+{
+	struct mtk_iommu_domain *domain = cookie;
+	void __iomem *base;
+
+	base = domain->data->base;
+	writel(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
+	writel(F_ALL_INVLD, base + REG_MMU_INVALIDATE);
+}
+
+static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
+				    bool leaf, void *cookie)
+{
+	struct mtk_iommu_domain *domain = cookie;
+	void __iomem *base = domain->data->base;
+	unsigned int iova_start = iova, iova_end = iova + size - 1;
+
+	writel(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
+
+	writel(iova_start, base + REG_MMU_INVLD_START_A);
+	writel(iova_end, base + REG_MMU_INVLD_END_A);
+	writel(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);
+}
+
+static void mtk_iommu_tlb_sync(void *cookie)
+{
+	struct mtk_iommu_domain *domain = cookie;
+	void __iomem *base = domain->data->base;
+	int ret;
+	u32 tmp;
+
+	ret = readl_poll_timeout_atomic(base + REG_MMU_CPE_DONE, tmp,
+					tmp != 0, 10, 1000000);
+	if (ret) {
+		dev_warn(domain->data->dev,
+			 "Partial TLB flush timed out, falling back to full flush\n");
+		mtk_iommu_tlb_flush_all(cookie);
+	}
+	writel(0, base + REG_MMU_CPE_DONE);
+}
+
+static void mtk_iommu_flush_pgtable(void *ptr, size_t size, void *cookie)
+{
+	struct mtk_iommu_domain *domain = cookie;
+	unsigned long offset = (unsigned long)ptr & ~PAGE_MASK;
+
+	dma_map_page(domain->data->dev, virt_to_page(ptr), offset,
+		     size, DMA_TO_DEVICE);
+}
+
+static struct iommu_gather_ops mtk_iommu_gather_ops = {
+	.tlb_flush_all = mtk_iommu_tlb_flush_all,
+	.tlb_add_flush = mtk_iommu_tlb_add_flush,
+	.tlb_sync = mtk_iommu_tlb_sync,
+	.flush_pgtable = mtk_iommu_flush_pgtable,
+};
+
+static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
+{
+	struct mtk_iommu_domain *mtkdom = dev_id;
+	struct mtk_iommu_data *data = mtkdom->data;
+	u32 int_state, regval, fault_iova, fault_pa;
+	unsigned int fault_larb, fault_port;
+	bool layer, write;
+
+	int_state = readl(data->base + REG_MMU_FAULT_ST1);
+
+	/* read error info from registers */
+	fault_iova = readl(data->base + REG_MMU_FAULT_VA);
+	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
+	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
+	fault_iova &= F_MMU_FAULT_VA_MSK;
+	fault_pa = readl(data->base + REG_MMU_INVLD_PA);
+	regval = readl(data->base + REG_MMU_INT_ID);
+	fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
+	fault_port = F_MMU0_INT_ID_PORT_ID(regval);
+
+	if (report_iommu_fault(&mtkdom->domain, data->dev, fault_iova,
+			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
+		dev_err_ratelimited(
+			data->dev,
+			"fault type=0x%x iova=0x%x pa=0x%x larb=%d port=%d layer=%d %s\n",
+			int_state, fault_iova, fault_pa, fault_larb, fault_port,
+			layer, write ? "write" : "read");
+	}
+
+	mtk_iommu_tlb_flush_all(mtkdom);
+	mtk_iommu_clear_intr(data);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_iommu_parse_dt(struct platform_device *pdev,
+			      struct mtk_iommu_data *data)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *ofnode;
+	struct resource *res;
+	int i;
+
+	ofnode = dev->of_node;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0)
+		return data->irq;
+
+	data->bclk = devm_clk_get(dev, "bclk");
+	if (IS_ERR(data->bclk))
+		return PTR_ERR(data->bclk);
+
+	data->larb_nr = of_count_phandle_with_args(
+					ofnode, "mediatek,larb", NULL);
+	if (data->larb_nr < 0)
+		return data->larb_nr;
+
+	for (i = 0; i < data->larb_nr; i++) {
+		struct device_node *larbnode;
+		struct platform_device *plarbdev;
+
+		larbnode = of_parse_phandle(ofnode, "mediatek,larb", i);
+		if (!larbnode)
+			return -EINVAL;
+
+		plarbdev = of_find_device_by_node(larbnode);
+		of_node_put(larbnode);
+		if (!plarbdev)
+			return -EPROBE_DEFER;
+		data->larbdev[i] = &plarbdev->dev;
+	}
+
+	return 0;
+}
+
+static int mtk_iommu_hw_init(const struct mtk_iommu_domain *mtkdom)
+{
+	struct mtk_iommu_data *data = mtkdom->data;
+	void __iomem *base = data->base;
+	u32 regval;
+	int ret = 0;
+
+	ret = clk_prepare_enable(data->bclk);
+	if (ret) {
+		dev_err(data->dev, "Failed to enable iommu clk(%d)\n", ret);
+		return ret;
+	}
+
+	writel(mtkdom->cfg.arm_short_cfg.ttbr[0], base + REG_MMU_PT_BASE_ADDR);
+
+	regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
+		F_MMU_TF_PROTECT_SEL(2) |
+		F_COHERENCE_EN;
+	writel(regval, base + REG_MMU_CTRL_REG);
+
+	regval = F_L2_MULIT_HIT_EN |
+		F_TABLE_WALK_FAULT_INT_EN |
+		F_PREETCH_FIFO_OVERFLOW_INT_EN |
+		F_MISS_FIFO_OVERFLOW_INT_EN |
+		F_PREFETCH_FIFO_ERR_INT_EN |
+		F_MISS_FIFO_ERR_INT_EN;
+	writel(regval, base + REG_MMU_INT_CONTROL0);
+
+	regval = F_INT_TRANSLATION_FAULT |
+		F_INT_MAIN_MULTI_HIT_FAULT |
+		F_INT_INVALID_PA_FAULT |
+		F_INT_ENTRY_REPLACEMENT_FAULT |
+		F_INT_TLB_MISS_FAULT |
+		F_INT_MISS_TRANSATION_FIFO_FAULT |
+		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
+	writel(regval, base + REG_MMU_INT_MAIN_CONTROL);
+
+	regval = ALIGN(data->protect_base, MTK_PROTECT_PA_ALIGN);
+	regval = F_MMU_IVRP_PA_SET(regval);
+	writel(regval, base + REG_MMU_IVRP_PADDR);
+
+	writel(0, base + REG_MMU_DCM_DIS);
+	writel(0, base + REG_MMU_STANDARD_AXI_MODE);
+
+	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
+			     dev_name(data->dev), (void *)mtkdom)) {
+		writel(0, base + REG_MMU_PT_BASE_ADDR);
+		clk_disable_unprepare(data->bclk);
+		dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int mtk_iommu_config(struct mtk_iommu_domain *mtkdom,
+			    struct device *dev, bool enable)
+{
+	struct mtk_iommu_data *data = mtkdom->data;
+	struct mtk_iommu_client_priv *head, *cur, *next;
+
+	head = dev->archdata.iommu;
+	list_for_each_entry_safe(cur, next, &head->client, client) {
+		if (cur->larbid >= data->larb_nr) {
+			dev_err(data->dev, "Invalid larb:%d\n", cur->larbid);
+			return -EINVAL;
+		}
+
+		if (enable) {
+			mtk_smi_config_port(data->larbdev[cur->larbid],
+					    cur->portid, true);
+		} else {
+			mtk_smi_config_port(data->larbdev[cur->larbid],
+					    cur->portid, false);
+			list_del(&cur->client);
+			kfree(cur);
+		}
+	}
+
+	if (!enable)
+		kfree(head);
+	return 0;
+}
+
+static int mtk_iommu_init_domain_context(struct mtk_iommu_domain *dom)
+{
+	int ret;
+
+	if (dom->iop)
+		return 0;
+
+	spin_lock_init(&dom->pgtlock);
+	dom->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS |
+			IO_PGTABLE_QUIRK_SHORT_SUPERSECTION |
+			IO_PGTABLE_QUIRK_SHORT_MTK;
+	dom->cfg.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
+	dom->cfg.ias = 32;
+	dom->cfg.oas = 32;
+	dom->cfg.tlb = &mtk_iommu_gather_ops;
+
+	dom->iop = alloc_io_pgtable_ops(ARM_SHORT_DESC, &dom->cfg, dom);
+	if (!dom->iop) {
+		pr_err("Failed to alloc io pgtable\n");
+		return -EINVAL;
+	}
+
+	/* Update our support page sizes bitmap */
+	mtk_iommu_ops.pgsize_bitmap = dom->cfg.pgsize_bitmap;
+
+	ret = mtk_iommu_hw_init(dom);
+	if (ret)
+		free_io_pgtable_ops(dom->iop);
+
+	return ret;
+}
+
+static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
+{
+	struct mtk_iommu_domain *priv;
+
+	/* We only support unmanaged domains for now */
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	priv->domain.geometry.aperture_start = 0;
+	priv->domain.geometry.aperture_end = (1ULL << 32) - 1;
+	priv->domain.geometry.force_aperture = true;
+
+	return &priv->domain;
+}
+
+static void mtk_iommu_domain_free(struct iommu_domain *domain)
+{
+	kfree(to_mtk_domain(domain));
+}
+
+static int mtk_iommu_attach_device(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct mtk_iommu_domain *priv = to_mtk_domain(domain);
+	struct iommu_group *group;
+	struct mtk_iommu_client_priv *devpriv;
+	struct device *imudev;
+	int ret;
+
+	devpriv = dev->archdata.iommu;
+	imudev = devpriv->imudev;
+
+	/*
+	 * Reserve one iommu domain as the m4u domain which
+	 * all Multimedia modules share and free the others.
+	 */
+	if (!imudev->archdata.iommu)
+		imudev->archdata.iommu = priv;
+	else if (imudev->archdata.iommu != priv)
+		iommu_domain_free(domain);
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return 0;
+	iommu_group_put(group);
+
+	ret = mtk_iommu_init_domain_context(priv);
+	if (ret)
+		return ret;
+
+	return mtk_iommu_config(priv, dev, true);;
+}
+
+static void mtk_iommu_detach_device(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	mtk_iommu_config(to_mtk_domain(domain), dev, false);
+}
+
+static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t size, int prot)
+{
+	struct mtk_iommu_domain *priv = to_mtk_domain(domain);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&priv->pgtlock, flags);
+	ret = priv->iop->map(priv->iop, iova, paddr, size, prot);
+	spin_unlock_irqrestore(&priv->pgtlock, flags);
+
+	return ret;
+}
+
+static size_t mtk_iommu_unmap(struct iommu_domain *domain,
+			      unsigned long iova, size_t size)
+{
+	struct mtk_iommu_domain *priv = to_mtk_domain(domain);
+	unsigned long flags;
+	size_t unmapsize;
+
+	spin_lock_irqsave(&priv->pgtlock, flags);
+	unmapsize = priv->iop->unmap(priv->iop, iova, size);
+	spin_unlock_irqrestore(&priv->pgtlock, flags);
+
+	return unmapsize;
+}
+
+static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
+					  dma_addr_t iova)
+{
+	struct mtk_iommu_domain *priv = to_mtk_domain(domain);
+	unsigned long flags;
+	phys_addr_t pa;
+
+	spin_lock_irqsave(&priv->pgtlock, flags);
+	pa = priv->iop->iova_to_phys(priv->iop, iova);
+	spin_unlock_irqrestore(&priv->pgtlock, flags);
+
+	return pa;
+}
+
+static int mtk_iommu_add_device(struct device *dev)
+{
+	struct mtk_iommu_domain *mtkdom;
+	struct iommu_group *group;
+	struct mtk_iommu_client_priv *devhead;
+	int ret;
+
+	if (!dev->archdata.dma_ops)/* Not a iommu client device */
+		return -ENODEV;
+
+	group = iommu_group_get(dev);
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group)) {
+			dev_err(dev, "Failed to allocate IOMMU group\n");
+			return PTR_ERR(group);
+		}
+	}
+
+	ret = iommu_group_add_device(group, dev);
+	if (ret) {
+		dev_err(dev, "Failed to add IOMMU group\n");
+		goto err_group_put;
+	}
+
+	/* get the mtk_iommu_domain from the iommu device */
+	devhead = dev->archdata.iommu;
+	mtkdom = devhead->imudev->archdata.iommu;
+	ret = iommu_attach_group(&mtkdom->domain, group);
+	if (ret)
+		dev_err(dev, "Failed to attach IOMMU group\n");
+
+err_group_put:
+	iommu_group_put(group);
+	return ret;
+}
+
+int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	struct mtk_iommu_client_priv *head, *priv, *next;
+	struct platform_device *imupdev;
+	struct device *imudev;
+
+	if (args->args_count != 2) {
+		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
+			args->args_count);
+		return -EINVAL;
+	}
+
+	if (!dev->archdata.iommu) {
+		/* Get the iommu device */
+		imupdev = of_find_device_by_node(args->np);
+		of_node_put(args->np);
+		if (WARN_ON(!imupdev))
+			return -EINVAL;
+		imudev = &imupdev->dev;
+
+		head = kzalloc(sizeof(*head), GFP_KERNEL);
+		if (!head)
+			return -ENOMEM;
+
+		dev->archdata.iommu = head;
+		INIT_LIST_HEAD(&head->client);
+		head->imudev = imudev;
+	} else {
+		head = dev->archdata.iommu;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		goto err_free_mem;
+
+	priv->larbid = args->args[0];
+	priv->portid = args->args[1];
+	list_add_tail(&priv->client, &head->client);
+
+	return 0;
+
+err_free_mem:
+	list_for_each_entry_safe(priv, next, &head->client, client)
+		kfree(priv);
+	kfree(head);
+	dev->archdata.iommu = NULL;
+	return -ENOMEM;
+}
+
+static struct iommu_ops mtk_iommu_ops = {
+	.domain_alloc	= mtk_iommu_domain_alloc,
+	.domain_free	= mtk_iommu_domain_free,
+	.attach_dev	= mtk_iommu_attach_device,
+	.detach_dev	= mtk_iommu_detach_device,
+	.map		= mtk_iommu_map,
+	.unmap		= mtk_iommu_unmap,
+	.map_sg		= default_iommu_map_sg,
+	.iova_to_phys	= mtk_iommu_iova_to_phys,
+	.add_device	= mtk_iommu_add_device,
+	.of_xlate	= mtk_iommu_of_xlate,
+	.pgsize_bitmap	= -1UL,
+};
+
+static const struct of_device_id mtk_iommu_of_ids[] = {
+	{ .compatible = "mediatek,mt8173-m4u", },
+	{}
+};
+
+static int mtk_iommu_init_fn(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	of_iommu_set_ops(np, &mtk_iommu_ops);
+
+	return 0;
+}
+
+IOMMU_OF_DECLARE(mtkm4u, "mediatek,mt8173-m4u", mtk_iommu_init_fn);
+
+static int mtk_iommu_probe(struct platform_device *pdev)
+{
+	struct mtk_iommu_domain	*mtkdom;
+	struct mtk_iommu_data   *data;
+	struct device           *dev = &pdev->dev;
+	void __iomem	        *protect;
+	int                     ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* Protect memory. HW will access here while translation fault.*/
+	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
+	if (!protect)
+		return -ENOMEM;
+	data->protect_base = virt_to_phys(protect);
+
+	ret = mtk_iommu_parse_dt(pdev, data);
+	if (ret)
+		return ret;
+
+	mtkdom = dev->archdata.iommu;
+	if (!mtkdom)/* There is no iommu client device */
+		return 0;
+
+	mtkdom->data = data;
+	data->dev = dev;
+	dev_set_drvdata(dev, mtkdom);
+
+	return 0;
+}
+
+static int mtk_iommu_remove(struct platform_device *pdev)
+{
+	struct mtk_iommu_domain *mtkdom = dev_get_drvdata(&pdev->dev);
+
+	/* Destroy domain context */
+	free_io_pgtable_ops(mtkdom->iop);
+
+	clk_disable_unprepare(mtkdom->data->bclk);
+	return 0;
+}
+
+static int mtk_iommu_suspend(struct device *dev)
+{
+	struct mtk_iommu_domain *mtkdom = dev_get_drvdata(dev);
+	struct mtk_iommu_data *data = mtkdom->data;
+	void __iomem *base = data->base;
+	unsigned int i = 0;
+
+	data->reg[i++] = readl(base + REG_MMU_PT_BASE_ADDR);
+	data->reg[i++] = readl(base + REG_MMU_STANDARD_AXI_MODE);
+	data->reg[i++] = readl(base + REG_MMU_DCM_DIS);
+	data->reg[i++] = readl(base + REG_MMU_CTRL_REG);
+	data->reg[i++] = readl(base + REG_MMU_IVRP_PADDR);
+	data->reg[i++] = readl(base + REG_MMU_INT_CONTROL0);
+	data->reg[i++] = readl(base + REG_MMU_INT_MAIN_CONTROL);
+	return 0;
+}
+
+static int mtk_iommu_resume(struct device *dev)
+{
+	struct mtk_iommu_domain *mtkdom = dev_get_drvdata(dev);
+	struct mtk_iommu_data *data = mtkdom->data;
+	void __iomem *base = data->base;
+	unsigned int i = 0;
+
+	writel(data->reg[i++], base + REG_MMU_PT_BASE_ADDR);
+	writel(data->reg[i++], base + REG_MMU_STANDARD_AXI_MODE);
+	writel(data->reg[i++], base + REG_MMU_DCM_DIS);
+	writel(data->reg[i++], base + REG_MMU_CTRL_REG);
+	writel(data->reg[i++], base + REG_MMU_IVRP_PADDR);
+	writel(data->reg[i++], base + REG_MMU_INT_CONTROL0);
+	writel(data->reg[i++], base + REG_MMU_INT_MAIN_CONTROL);
+	return 0;
+}
+
+const struct dev_pm_ops mtk_iommu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
+};
+
+static struct platform_driver mtk_iommu_driver = {
+	.probe	= mtk_iommu_probe,
+	.remove	= mtk_iommu_remove,
+	.driver	= {
+		.name = "mtk-iommu",
+		.of_match_table = mtk_iommu_of_ids,
+		.pm = &mtk_iommu_pm_ops,
+	}
+};
+
+static int __init mtk_iommu_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mtk_iommu_driver);
+	if (ret) {
+		pr_err("%s: Failed to register driver\n", __func__);
+		return ret;
+	}
+
+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
+
+	return 0;
+}
+
+subsys_initcall(mtk_iommu_init);
-- 
1.7.9.5
