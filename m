From: <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 4/5] iommu/mediatek: add support for mtk iommu generation
	one HW
Date: Fri, 27 May 2016 16:56:39 +0800
Message-ID: <1464339400-22559-5-git-send-email-honghui.zhang@mediatek.com>
References: <1464339400-22559-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1464339400-22559-1-git-send-email-honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Mediatek SoC's M4U has two generations of HW architcture. Generation one
uses flat, one layer pagetable, and was shipped with ARM architecture, it
only supports 4K size page mapping. MT2701 SoC uses this generation one
m4u HW. Generation two uses the ARM short-descriptor translation table
format for address translation, and was shipped with ARM64 architecture,
MT8173 uses this generation two m4u HW. All the two generation iommu HW
only have one iommu domain, and all its iommu clients share the same
iova address.

These two generation m4u HW have slit different register groups and
register offset, but most register names are the same. This patch add iommu
support for mediatek SoC mt2701.

Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/Kconfig        |  18 ++
 drivers/iommu/Makefile       |   1 +
 drivers/iommu/mtk_iommu_v1.c | 728 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 747 insertions(+)
 create mode 100644 drivers/iommu/mtk_iommu_v1.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dd1dc39..363c1d8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -354,4 +354,22 @@ config MTK_IOMMU
 
 	  If unsure, say N here.
 
+config MTK_IOMMU_V1
+	bool "MTK IOMMU Version 1 (M4U gen1) Support"
+	depends on ARM
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select ARM_DMA_USE_IOMMU
+	select IOMMU_API
+	select MEMORY
+	select MTK_SMI
+	select COMMON_CLK_MT2701_MMSYS
+	select COMMON_CLK_MT2701_IMGSYS
+	select COMMON_CLK_MT2701_VDECSYS
+	help
+	  Support for the M4U on certain Mediatek SoCs. M4U generation 1 HW is
+	  Multimedia Memory Managememt Unit. This option enables remapping of
+	  DMA memory accesses for the multimedia subsystem.
+
+	  if unsure, say N here.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index c6edb31..778baf5 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
 obj-$(CONFIG_MTK_IOMMU) += mtk_iommu.o
+obj-$(CONFIG_MTK_IOMMU_V1) += mtk_iommu_v1.o
 obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
 obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
 obj-$(CONFIG_ROCKCHIP_IOMMU) += rockchip-iommu.o
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
new file mode 100644
index 0000000..a2a2554
--- /dev/null
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -0,0 +1,728 @@
+/*
+ * Copyright (c) 2015-2016 MediaTek Inc.
+ * Author: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ *
+ * Based on driver/iommu/mtk_iommu.c
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
+#include <linux/bootmem.h>
+#include <linux/bug.h>
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/dma-iommu.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+#include <linux/kmemleak.h>
+#include <linux/list.h>
+#include <linux/of_address.h>
+#include <linux/of_iommu.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <asm/barrier.h>
+#include <asm/dma-iommu.h>
+#include <linux/module.h>
+#include <dt-bindings/memory/mt2701-larb-port.h>
+#include <soc/mediatek/smi.h>
+#include "mtk_iommu.h"
+
+#define REG_MMU_PT_BASE_ADDR			0x000
+
+#define F_ALL_INVLD				0x2
+#define F_MMU_INV_RANGE				0x1
+#define F_INVLD_EN0				BIT(0)
+#define F_INVLD_EN1				BIT(1)
+
+#define F_MMU_FAULT_VA_MSK			0xfffff000
+#define MTK_PROTECT_PA_ALIGN			128
+
+#define REG_MMU_CTRL_REG			0x210
+#define F_MMU_CTRL_COHERENT_EN			BIT(8)
+#define REG_MMU_IVRP_PADDR			0x214
+#define REG_MMU_INT_CONTROL			0x220
+#define F_INT_TRANSLATION_FAULT			BIT(0)
+#define F_INT_MAIN_MULTI_HIT_FAULT		BIT(1)
+#define F_INT_INVALID_PA_FAULT			BIT(2)
+#define F_INT_ENTRY_REPLACEMENT_FAULT		BIT(3)
+#define F_INT_TABLE_WALK_FAULT			BIT(4)
+#define F_INT_TLB_MISS_FAULT			BIT(5)
+#define F_INT_PFH_DMA_FIFO_OVERFLOW		BIT(6)
+#define F_INT_MISS_DMA_FIFO_OVERFLOW		BIT(7)
+
+#define F_MMU_TF_PROTECT_SEL(prot)		(((prot) & 0x3) << 5)
+#define F_INT_CLR_BIT				BIT(12)
+
+#define REG_MMU_FAULT_ST			0x224
+#define REG_MMU_FAULT_VA			0x228
+#define REG_MMU_INVLD_PA			0x22C
+#define REG_MMU_INT_ID				0x388
+#define REG_MMU_INVALIDATE			0x5c0
+#define REG_MMU_INVLD_START_A			0x5c4
+#define REG_MMU_INVLD_END_A			0x5c8
+
+#define REG_MMU_INV_SEL				0x5d8
+#define REG_MMU_STANDARD_AXI_MODE		0x5e8
+
+#define REG_MMU_DCM				0x5f0
+#define F_MMU_DCM_ON				BIT(1)
+#define REG_MMU_CPE_DONE			0x60c
+#define F_DESC_VALID				0x2
+#define F_DESC_NONSEC				BIT(3)
+#define MT2701_M4U_TF_LARB(TF)			(6 - (((TF) >> 13) & 0x7))
+#define MT2701_M4U_TF_PORT(TF)			(((TF) >> 8) & 0xF)
+/* MTK generation one iommu HW only support 4K size mapping */
+#define MT2701_IOMMU_PAGE_SHIFT			12
+#define MT2701_IOMMU_PAGE_SIZE			(1UL << MT2701_IOMMU_PAGE_SHIFT)
+
+/*
+ * MTK m4u support 4GB iova address space, and only support 4K page
+ * mapping. So the pagetable size should be exactly as 4M.
+ */
+#define M2701_IOMMU_PGT_SIZE			SZ_4M
+
+struct mtk_iommu_domain {
+	spinlock_t			pgtlock; /* lock for page table */
+	struct iommu_domain		domain;
+	u32				*pgt_va;
+	dma_addr_t			pgt_pa;
+	struct mtk_iommu_data		*data;
+};
+
+static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct mtk_iommu_domain, domain);
+}
+
+static const int mt2701_m4u_in_larb[] = {
+	LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
+	LARB2_PORT_OFFSET, LARB3_PORT_OFFSET
+};
+
+static inline int mt2701_m4u_to_larb(int id)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(mt2701_m4u_in_larb) - 1; i >= 0; i--)
+		if ((id) >= mt2701_m4u_in_larb[i])
+			return i;
+
+	return 0;
+}
+
+static inline int mt2701_m4u_to_port(int id)
+{
+	int larb = mt2701_m4u_to_larb(id);
+
+	return id - mt2701_m4u_in_larb[larb];
+}
+
+static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
+{
+	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
+			data->base + REG_MMU_INV_SEL);
+	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
+	wmb(); /* Make sure the tlb flush all done */
+}
+
+static void mtk_iommu_tlb_flush_range(struct mtk_iommu_data *data,
+				unsigned long iova, size_t size)
+{
+	int ret;
+	u32 tmp;
+
+	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
+		data->base + REG_MMU_INV_SEL);
+	writel_relaxed(iova & F_MMU_FAULT_VA_MSK,
+		data->base + REG_MMU_INVLD_START_A);
+	writel_relaxed((iova + size - 1) & F_MMU_FAULT_VA_MSK,
+		data->base + REG_MMU_INVLD_END_A);
+	writel_relaxed(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);
+
+	ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
+				tmp, tmp != 0, 10, 100000);
+	if (ret) {
+		dev_warn(data->dev,
+			 "Partial TLB flush timed out, falling back to full flush\n");
+		mtk_iommu_tlb_flush_all(data);
+	}
+	/* Clear the CPE status */
+	writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
+}
+
+static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
+{
+	struct mtk_iommu_data *data = dev_id;
+	struct mtk_iommu_domain *dom = data->m4u_dom;
+	u32 int_state, regval, fault_iova, fault_pa;
+	unsigned int fault_larb, fault_port;
+
+	/* Read error information from registers */
+	int_state = readl_relaxed(data->base + REG_MMU_FAULT_ST);
+	fault_iova = readl_relaxed(data->base + REG_MMU_FAULT_VA);
+
+	fault_iova &= F_MMU_FAULT_VA_MSK;
+	fault_pa = readl_relaxed(data->base + REG_MMU_INVLD_PA);
+	regval = readl_relaxed(data->base + REG_MMU_INT_ID);
+	fault_larb = MT2701_M4U_TF_LARB(regval);
+	fault_port = MT2701_M4U_TF_PORT(regval);
+
+	/*
+	 * MTK v1 iommu HW could not determine whether the fault is read or
+	 * write fault, report as read fault.
+	 */
+	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
+			IOMMU_FAULT_READ))
+		dev_err_ratelimited(data->dev,
+			"fault type=0x%x iova=0x%x pa=0x%x larb=%d port=%d\n",
+			int_state, fault_iova, fault_pa,
+			fault_larb, fault_port);
+
+	/* Interrupt clear */
+	regval = readl_relaxed(data->base + REG_MMU_INT_CONTROL);
+	regval |= F_INT_CLR_BIT;
+	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL);
+
+	mtk_iommu_tlb_flush_all(data);
+
+	return IRQ_HANDLED;
+}
+
+static void mtk_iommu_config(struct mtk_iommu_data *data,
+			     struct device *dev, bool enable)
+{
+	struct mtk_iommu_client_priv *head, *cur, *next;
+	struct mtk_smi_larb_iommu    *larb_mmu;
+	unsigned int                 larbid, portid;
+
+	head = dev->archdata.iommu;
+	list_for_each_entry_safe(cur, next, &head->client, client) {
+		larbid = mt2701_m4u_to_larb(cur->mtk_m4u_id);
+		portid = mt2701_m4u_to_port(cur->mtk_m4u_id);
+		larb_mmu = &data->smi_imu.larb_imu[larbid];
+
+		dev_dbg(dev, "%s iommu port: %d\n",
+			enable ? "enable" : "disable", portid);
+
+		if (enable)
+			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
+		else
+			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
+	}
+}
+
+static int mtk_iommu_domain_finalise(struct mtk_iommu_data *data)
+{
+	struct mtk_iommu_domain *dom = data->m4u_dom;
+
+	spin_lock_init(&dom->pgtlock);
+
+	dom->pgt_va = dma_zalloc_coherent(data->dev,
+				M2701_IOMMU_PGT_SIZE,
+				&dom->pgt_pa, GFP_KERNEL);
+	if (!dom->pgt_va)
+		return -ENOMEM;
+
+	writel(dom->pgt_pa, data->base + REG_MMU_PT_BASE_ADDR);
+
+	dom->data = data;
+
+	return 0;
+}
+
+static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
+{
+	struct mtk_iommu_domain *dom;
+
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
+	if (!dom)
+		return NULL;
+
+	return &dom->domain;
+}
+
+static void mtk_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = dom->data;
+
+	dma_free_coherent(data->dev, M2701_IOMMU_PGT_SIZE,
+			dom->pgt_va, dom->pgt_pa);
+	kfree(to_mtk_domain(domain));
+}
+
+static int mtk_iommu_attach_device(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_client_priv *priv = dev->archdata.iommu;
+	struct mtk_iommu_data *data;
+	int ret;
+
+	if (!priv)
+		return -ENODEV;
+
+	data = dev_get_drvdata(priv->m4udev);
+	if (!data->m4u_dom) {
+		data->m4u_dom = dom;
+		ret = mtk_iommu_domain_finalise(data);
+		if (ret) {
+			data->m4u_dom = NULL;
+			return ret;
+		}
+	}
+
+	mtk_iommu_config(data, dev, true);
+	return 0;
+}
+
+static void mtk_iommu_detach_device(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	struct mtk_iommu_client_priv *priv = dev->archdata.iommu;
+	struct mtk_iommu_data *data;
+
+	if (!priv)
+		return;
+
+	data = dev_get_drvdata(priv->m4udev);
+	mtk_iommu_config(data, dev, false);
+}
+
+static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t size, int prot)
+{
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	unsigned int page_num = size >> MT2701_IOMMU_PAGE_SHIFT;
+	unsigned long flags;
+	unsigned int i;
+	u32 *pgt_base_iova = dom->pgt_va + (iova  >> MT2701_IOMMU_PAGE_SHIFT);
+	u32 pabase = (u32)paddr;
+	int map_size = 0;
+
+	spin_lock_irqsave(&dom->pgtlock, flags);
+	for (i = 0; i < page_num; i++) {
+		if (pgt_base_iova[i]) {
+			memset(pgt_base_iova, 0, i * sizeof(u32));
+			break;
+		}
+		pgt_base_iova[i] = pabase | F_DESC_VALID | F_DESC_NONSEC;
+		pabase += MT2701_IOMMU_PAGE_SIZE;
+		map_size += MT2701_IOMMU_PAGE_SIZE;
+	}
+
+	spin_unlock_irqrestore(&dom->pgtlock, flags);
+
+	mtk_iommu_tlb_flush_range(dom->data, iova, size);
+
+	return map_size == size ? 0 : -EEXIST;
+}
+
+static size_t mtk_iommu_unmap(struct iommu_domain *domain,
+			      unsigned long iova, size_t size)
+{
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	unsigned long flags;
+	u32 *pgt_base_iova = dom->pgt_va + (iova  >> MT2701_IOMMU_PAGE_SHIFT);
+	unsigned int page_num = size >> MT2701_IOMMU_PAGE_SHIFT;
+
+	spin_lock_irqsave(&dom->pgtlock, flags);
+	memset(pgt_base_iova, 0, page_num * sizeof(u32));
+	spin_unlock_irqrestore(&dom->pgtlock, flags);
+
+	mtk_iommu_tlb_flush_range(dom->data, iova, size);
+
+	return size;
+}
+
+static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
+					  dma_addr_t iova)
+{
+	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	unsigned long flags;
+	phys_addr_t pa;
+
+	spin_lock_irqsave(&dom->pgtlock, flags);
+	pa = *(dom->pgt_va + (iova >> MT2701_IOMMU_PAGE_SHIFT));
+	pa = pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));
+	spin_unlock_irqrestore(&dom->pgtlock, flags);
+
+	return pa;
+}
+
+/*
+ * MTK generation one iommu HW only support one iommu domain, and all the client
+ * sharing the same iova address space.
+ */
+static int mtk_iommu_create_mapping(struct device *dev,
+				    struct of_phandle_args *args)
+{
+	struct mtk_iommu_client_priv *head, *priv, *next;
+	struct platform_device *m4updev;
+	struct dma_iommu_mapping *mtk_mapping;
+	struct device *m4udev;
+	int ret;
+
+	if (args->args_count != 1) {
+		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
+			args->args_count);
+		return -EINVAL;
+	}
+
+	if (!dev->archdata.iommu) {
+		/* Get the m4u device */
+		m4updev = of_find_device_by_node(args->np);
+		of_node_put(args->np);
+		if (WARN_ON(!m4updev))
+			return -EINVAL;
+
+		head = kzalloc(sizeof(*head), GFP_KERNEL);
+		if (!head)
+			return -ENOMEM;
+
+		dev->archdata.iommu = head;
+		INIT_LIST_HEAD(&head->client);
+		head->m4udev = &m4updev->dev;
+	} else {
+		head = dev->archdata.iommu;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_free_mem;
+	}
+	priv->mtk_m4u_id = args->args[0];
+	list_add_tail(&priv->client, &head->client);
+
+	m4udev = head->m4udev;
+	mtk_mapping = m4udev->archdata.iommu;
+	if (!mtk_mapping) {
+		/* MTK iommu support 4GB iova address space. */
+		mtk_mapping = arm_iommu_create_mapping(&platform_bus_type,
+						0, 1ULL << 32);
+		if (IS_ERR(mtk_mapping)) {
+			ret = PTR_ERR(mtk_mapping);
+			goto err_free_mem;
+		}
+		m4udev->archdata.iommu = mtk_mapping;
+	}
+
+	ret = arm_iommu_attach_device(dev, mtk_mapping);
+	if (ret)
+		goto err_release_mapping;
+
+	return 0;
+
+err_release_mapping:
+	arm_iommu_release_mapping(mtk_mapping);
+	m4udev->archdata.iommu = NULL;
+err_free_mem:
+	list_for_each_entry_safe(priv, next, &head->client, client)
+		kfree(priv);
+	kfree(head);
+	dev->archdata.iommu = NULL;
+	return ret;
+}
+
+static int mtk_iommu_add_device(struct device *dev)
+{
+	struct iommu_group *group;
+	struct of_phandle_args iommu_spec;
+	struct of_phandle_iterator it;
+	int err;
+
+	of_for_each_phandle(&it, err, dev->of_node, "iommus",
+			"#iommu-cells", 0) {
+		int count = of_phandle_iterator_args(&it, iommu_spec.args,
+					MAX_PHANDLE_ARGS);
+		iommu_spec.np = of_node_get(it.node);
+		iommu_spec.args_count = count;
+
+		mtk_iommu_create_mapping(dev, &iommu_spec);
+		of_node_put(iommu_spec.np);
+	}
+
+	if (!dev->archdata.iommu) /* Not a iommu client device */
+		return -ENODEV;
+
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	iommu_group_put(group);
+	return 0;
+}
+
+static void mtk_iommu_remove_device(struct device *dev)
+{
+	struct mtk_iommu_client_priv *head, *cur, *next;
+
+	head = dev->archdata.iommu;
+	if (!head)
+		return;
+
+	list_for_each_entry_safe(cur, next, &head->client, client) {
+		list_del(&cur->client);
+		kfree(cur);
+	}
+	kfree(head);
+	dev->archdata.iommu = NULL;
+
+	iommu_group_remove_device(dev);
+}
+
+static struct iommu_group *mtk_iommu_device_group(struct device *dev)
+{
+	struct mtk_iommu_data *data;
+	struct mtk_iommu_client_priv *priv;
+
+	priv = dev->archdata.iommu;
+	if (!priv)
+		return ERR_PTR(-ENODEV);
+
+	/* All the client devices are in the same m4u iommu-group */
+	data = dev_get_drvdata(priv->m4udev);
+	if (!data->m4u_group) {
+		data->m4u_group = iommu_group_alloc();
+		if (IS_ERR(data->m4u_group))
+			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
+	}
+	return data->m4u_group;
+}
+
+static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
+{
+	u32 regval;
+	int ret;
+
+	ret = clk_prepare_enable(data->bclk);
+	if (ret) {
+		dev_err(data->dev, "Failed to enable iommu bclk(%d)\n", ret);
+		return ret;
+	}
+
+	regval = F_MMU_CTRL_COHERENT_EN | F_MMU_TF_PROTECT_SEL(2);
+	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
+
+	regval = F_INT_TRANSLATION_FAULT |
+		F_INT_MAIN_MULTI_HIT_FAULT |
+		F_INT_INVALID_PA_FAULT |
+		F_INT_ENTRY_REPLACEMENT_FAULT |
+		F_INT_TABLE_WALK_FAULT |
+		F_INT_TLB_MISS_FAULT |
+		F_INT_PFH_DMA_FIFO_OVERFLOW |
+		F_INT_MISS_DMA_FIFO_OVERFLOW;
+	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL);
+
+	/* protect memory,hw will write here while translation fault */
+	writel_relaxed(data->protect_base,
+			data->base + REG_MMU_IVRP_PADDR);
+
+	writel_relaxed(F_MMU_DCM_ON, data->base + REG_MMU_DCM);
+
+	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
+			     dev_name(data->dev), (void *)data)) {
+		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
+		clk_disable_unprepare(data->bclk);
+		dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
+		return -ENODEV;
+	}
+
+	return 0;
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
+	.remove_device	= mtk_iommu_remove_device,
+	.device_group	= mtk_iommu_device_group,
+	.pgsize_bitmap	= ~0UL << MT2701_IOMMU_PAGE_SHIFT,
+};
+
+static const struct of_device_id mtk_iommu_of_ids[] = {
+	{ .compatible = "mediatek,mt2701-m4u", },
+	{}
+};
+
+static const struct component_master_ops mtk_iommu_com_ops = {
+	.bind		= mtk_iommu_bind,
+	.unbind		= mtk_iommu_unbind,
+};
+
+static int mtk_iommu_probe(struct platform_device *pdev)
+{
+	struct mtk_iommu_data		*data;
+	struct device			*dev = &pdev->dev;
+	struct resource			*res;
+	struct component_match		*match = NULL;
+	struct of_phandle_args		larb_spec;
+	struct of_phandle_iterator	it;
+	void				*protect;
+	int				larb_nr, ret, err;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+
+	/* Protect memory. HW will access here while translation fault.*/
+	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2,
+			GFP_KERNEL | GFP_DMA);
+	if (!protect)
+		return -ENOMEM;
+	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_ioremap_resource(dev, res);
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
+	larb_nr = 0;
+	of_for_each_phandle(&it, err, dev->of_node,
+			"mediatek,larbs", NULL, 0) {
+		struct platform_device *plarbdev;
+		int count = of_phandle_iterator_args(&it, larb_spec.args,
+					MAX_PHANDLE_ARGS);
+
+		if (count)
+			continue;
+
+		larb_spec.np = of_node_get(it.node);
+		if (!of_device_is_available(larb_spec.np))
+			continue;
+
+		plarbdev = of_find_device_by_node(larb_spec.np);
+		of_node_put(larb_spec.np);
+		if (!plarbdev) {
+			plarbdev = of_platform_device_create(
+						larb_spec.np, NULL,
+						platform_bus_type.dev_root);
+			if (!plarbdev)
+				return -EPROBE_DEFER;
+		}
+
+		data->smi_imu.larb_imu[larb_nr].dev = &plarbdev->dev;
+		component_match_add(dev, &match, compare_of, larb_spec.np);
+		larb_nr++;
+	}
+
+	data->smi_imu.larb_nr = larb_nr;
+
+	platform_set_drvdata(pdev, data);
+
+	ret = mtk_iommu_hw_init(data);
+	if (ret)
+		return ret;
+
+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type,  &mtk_iommu_ops);
+
+	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
+}
+
+static int mtk_iommu_remove(struct platform_device *pdev)
+{
+	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
+
+	if (iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, NULL);
+
+	clk_disable_unprepare(data->bclk);
+	devm_free_irq(&pdev->dev, data->irq, data);
+	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
+	return 0;
+}
+
+static int __maybe_unused mtk_iommu_suspend(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+	struct mtk_iommu_suspend_reg *reg = &data->reg;
+	void __iomem *base = data->base;
+
+	reg->standard_axi_mode = readl_relaxed(base +
+					       REG_MMU_STANDARD_AXI_MODE);
+	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM);
+	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
+	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL);
+	return 0;
+}
+
+static int __maybe_unused mtk_iommu_resume(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+	struct mtk_iommu_suspend_reg *reg = &data->reg;
+	void __iomem *base = data->base;
+
+	writel_relaxed(data->m4u_dom->pgt_pa, base + REG_MMU_PT_BASE_ADDR);
+	writel_relaxed(reg->standard_axi_mode,
+		       base + REG_MMU_STANDARD_AXI_MODE);
+	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM);
+	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
+	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL);
+	writel_relaxed(data->protect_base, base + REG_MMU_IVRP_PADDR);
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
+static int __init m4u_init(void)
+{
+	return platform_driver_register(&mtk_iommu_driver);
+}
+
+static void __exit m4u_exit(void)
+{
+	return platform_driver_unregister(&mtk_iommu_driver);
+}
+
+subsys_initcall(m4u_init);
+module_exit(m4u_exit);
+
+MODULE_DESCRIPTION("IOMMU API for MTK architected m4u v1 implementations");
+MODULE_AUTHOR("Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.8.1.1.dirty
