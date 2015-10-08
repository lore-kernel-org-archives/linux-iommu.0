From: Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 2/3] iommu/hisilicon: Add hi6220 iommu driver
Date: Thu, 8 Oct 2015 15:45:47 +0800
Message-ID: <1444290348-66509-2-git-send-email-puck.chen@hisilicon.com>
References: <1444290348-66509-1-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444290348-66509-1-git-send-email-puck.chen@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: puck.chen@hisilicon.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, haojian.zhuang@linaro.org, devicetree@vger.kernel.org, xuwei5@hisilicon.com, xuyiping@hisilicon.com, w.f@huawei.com, kong.kongxinwei@hisilicon.com, z.liuxinliang@hisilicon.com, yudongbin@hisilicon.com, weidong2@hisilicon.com, saberlily.xia@hisilicon.com
Cc: linuxarm@huawei.com, dan.zhao@hisilicon.com, peter.panshilin@hisilicon.com, qijiwen@hisilicon.com
List-Id: iommu@lists.linux-foundation.org

Enable iommu on hi6220 SoC platform.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Yu Dongbin <yudongbin@hisilicon.com>
---
 drivers/iommu/Kconfig        |   8 +
 drivers/iommu/Makefile       |   1 +
 drivers/iommu/hi6220_iommu.c | 503 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 512 insertions(+)
 create mode 100644 drivers/iommu/hi6220_iommu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 4664c2a..9b41708 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -343,6 +343,14 @@ config SPAPR_TCE_IOMMU
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
 	  is not implemented as it is not necessary for VFIO.
 
+config HI6220_IOMMU
+	bool "Hi6220 IOMMU Support"
+	depends on ARM64
+	select IOMMU_API
+	select IOMMU_IOVA
+	help
+	  Enable IOMMU Driver for hi6220 SoC.
+
 # ARM IOMMU support
 config ARM_SMMU
 	bool "ARM Ltd. System MMU (SMMU) Support"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index c6dcc51..ee4dfef 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
 obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
+obj-$(CONFIG_HI6220_IOMMU) += hi6220_iommu.o
diff --git a/drivers/iommu/hi6220_iommu.c b/drivers/iommu/hi6220_iommu.c
new file mode 100644
index 0000000..9e9b19d
--- /dev/null
+++ b/drivers/iommu/hi6220_iommu.c
@@ -0,0 +1,503 @@
+/*
+ * Hisilicon Hi6220 IOMMU driver
+ *
+ * Copyright (c) 2015 Hisilicon Limited.
+ *
+ * Author: Chen Feng <puck.chen@hisilicon.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "IOMMU: " fmt
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/iova.h>
+
+#define SMMU_CTRL_OFFSET             (0x0000)
+#define SMMU_ENABLE_OFFSET           (0x0004)
+#define SMMU_PTBR_OFFSET             (0x0008)
+#define SMMU_START_OFFSET            (0x000C)
+#define SMMU_END_OFFSET              (0x0010)
+#define SMMU_INTMASK_OFFSET          (0x0014)
+#define SMMU_RINTSTS_OFFSET          (0x0018)
+#define SMMU_MINTSTS_OFFSET          (0x001C)
+#define SMMU_INTCLR_OFFSET           (0x0020)
+#define SMMU_STATUS_OFFSET           (0x0024)
+#define SMMU_AXIID_OFFSET            (0x0028)
+#define SMMU_CNTCTRL_OFFSET          (0x002C)
+#define SMMU_TRANSCNT_OFFSET         (0x0030)
+#define SMMU_L0TLBHITCNT_OFFSET      (0x0034)
+#define SMMU_L1TLBHITCNT_OFFSET      (0x0038)
+#define SMMU_WRAPCNT_OFFSET          (0x003C)
+#define SMMU_SEC_START_OFFSET        (0x0040)
+#define SMMU_SEC_END_OFFSET          (0x0044)
+#define SMMU_VERSION_OFFSET          (0x0048)
+#define SMMU_IPTSRC_OFFSET           (0x004C)
+#define SMMU_IPTPA_OFFSET            (0x0050)
+#define SMMU_TRBA_OFFSET             (0x0054)
+#define SMMU_BYS_START_OFFSET        (0x0058)
+#define SMMU_BYS_END_OFFSET          (0x005C)
+#define SMMU_RAM_OFFSET              (0x1000)
+#define SMMU_REGS_MAX                (15)
+#define SMMU_REGS_SGMT_END           (0x60)
+#define SMMU_CHIP_ID_V100            (1)
+#define SMMU_CHIP_ID_V200            (2)
+
+#define SMMU_REGS_OPS_SEGMT_START    (0xf00)
+#define SMMU_REGS_OPS_SEGMT_NUMB     (8)
+#define SMMU_REGS_AXI_SEGMT_START    (0xf80)
+#define SMMU_REGS_AXI_SEGMT_NUMB     (8)
+
+#define SMMU_INIT                    (0x1)
+#define SMMU_RUNNING                 (0x2)
+#define SMMU_SUSPEND                 (0x3)
+#define SMMU_STOP                    (0x4)
+
+#define PAGE_ENTRY_VALID             (0x1)
+
+#define IOVA_START_PFN           (1)
+#define IOPAGE_SHIFT             (12)
+#define IOVA_PFN(addr)           ((addr) >> IOPAGE_SHIFT)
+#define IOVA_PAGE_SZ             (1UL << IOPAGE_SHIFT)
+#define IOVA_START               (0x00002000)
+#define IOVA_END                 (0x80000000)
+
+struct hi6220_smmu {
+	unsigned int irq;
+	irq_handler_t smmu_isr;
+	void __iomem *reg_base;
+	struct clk *smmu_peri_clk;
+	struct clk *smmu_clk;
+	struct clk *media_sc_clk;
+	size_t page_size;
+	struct iova_domain iova_allocator;
+	dma_addr_t pgtable_phy;
+	void *pgtable_virt;
+};
+
+struct hi6220_domain {
+	struct hi6220_smmu *smmu_dev;
+	struct device *dev;
+	spinlock_t spinlock; /*spinlock for device&resource*/
+	struct iommu_domain io_domain;
+	unsigned long iova_start;
+	unsigned long iova_end;
+};
+
+static struct hi6220_smmu *smmu_dev_handle;
+static unsigned int smmu_regs_value[SMMU_REGS_MAX] = {0};
+
+static struct hi6220_domain *to_hi6220_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct hi6220_domain, io_domain);
+}
+
+static inline void __smmu_writel(struct hi6220_smmu *smmu_dev, u32 value,
+				 unsigned long offset)
+{
+	writel(value, smmu_dev->reg_base + offset);
+}
+
+static inline u32 __smmu_readl(struct hi6220_smmu *smmu_dev,
+			       unsigned long offset)
+{
+	return readl(smmu_dev->reg_base + offset);
+}
+
+static void __restore_regs(struct hi6220_smmu *smmu_dev)
+{
+	smmu_regs_value[0] = __smmu_readl(smmu_dev, SMMU_CTRL_OFFSET);
+	smmu_regs_value[1] = __smmu_readl(smmu_dev, SMMU_ENABLE_OFFSET);
+	smmu_regs_value[2] = __smmu_readl(smmu_dev, SMMU_PTBR_OFFSET);
+	smmu_regs_value[3] = __smmu_readl(smmu_dev, SMMU_START_OFFSET);
+	smmu_regs_value[4] = __smmu_readl(smmu_dev, SMMU_END_OFFSET);
+	smmu_regs_value[5] = __smmu_readl(smmu_dev, SMMU_STATUS_OFFSET);
+	smmu_regs_value[6] = __smmu_readl(smmu_dev, SMMU_AXIID_OFFSET);
+	smmu_regs_value[7] = __smmu_readl(smmu_dev, SMMU_SEC_START_OFFSET);
+	smmu_regs_value[8] = __smmu_readl(smmu_dev, SMMU_SEC_END_OFFSET);
+	smmu_regs_value[9] = __smmu_readl(smmu_dev, SMMU_VERSION_OFFSET);
+	smmu_regs_value[10] = __smmu_readl(smmu_dev, SMMU_IPTSRC_OFFSET);
+	smmu_regs_value[11] = __smmu_readl(smmu_dev, SMMU_IPTPA_OFFSET);
+	smmu_regs_value[12] = __smmu_readl(smmu_dev, SMMU_TRBA_OFFSET);
+	smmu_regs_value[13] = __smmu_readl(smmu_dev, SMMU_BYS_START_OFFSET);
+	smmu_regs_value[14] = __smmu_readl(smmu_dev, SMMU_BYS_END_OFFSET);
+}
+
+static void __reload_regs(struct hi6220_smmu *smmu_dev)
+{
+	__smmu_writel(smmu_dev, smmu_regs_value[2], SMMU_PTBR_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[5], SMMU_STATUS_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[6], SMMU_AXIID_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[7], SMMU_SEC_START_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[8], SMMU_SEC_END_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[9], SMMU_VERSION_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[10], SMMU_IPTSRC_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[11], SMMU_IPTPA_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[12], SMMU_TRBA_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[13], SMMU_BYS_START_OFFSET);
+	__smmu_writel(smmu_dev, smmu_regs_value[14], SMMU_BYS_END_OFFSET);
+}
+
+static inline void __set_smmu_pte(unsigned int *pte,
+				  dma_addr_t phys_addr)
+{
+	if ((*pte & PAGE_ENTRY_VALID))
+		pr_err("set pte[%p]->%x already set!\n", pte, *pte);
+
+	*pte = (unsigned int)(phys_addr | PAGE_ENTRY_VALID);
+}
+
+static inline void __clear_smmu_pte(unsigned int *pte)
+{
+	if (!(*pte & PAGE_ENTRY_VALID))
+		pr_err("clear pte[%p] %x err!\n", pte, *pte);
+
+	*pte = 0;
+}
+
+static inline void __invalid_smmu_tlb(struct hi6220_domain *m_domain,
+				      unsigned long iova, size_t size)
+{
+	unsigned long flags;
+	unsigned int smmu_ctrl = 0;
+	unsigned int inv_cnt = 10000;
+	unsigned int start_pfn = 0;
+	unsigned int end_pfn   = 0;
+	struct hi6220_smmu *smmu_dev = m_domain->smmu_dev;
+	dma_addr_t smmu_pgtbl_phy = m_domain->smmu_dev->pgtable_phy;
+
+	spin_lock_irqsave(&m_domain->spinlock, flags);
+
+	start_pfn = IOVA_PFN(iova);
+	end_pfn   = IOVA_PFN(iova + size);
+
+	__smmu_writel(smmu_dev, smmu_pgtbl_phy + start_pfn * sizeof(int),
+		      SMMU_START_OFFSET);
+	__smmu_writel(smmu_dev, smmu_pgtbl_phy + end_pfn  * sizeof(int),
+		      SMMU_END_OFFSET);
+
+	smmu_ctrl = __smmu_readl(smmu_dev, SMMU_CTRL_OFFSET);
+	smmu_ctrl = smmu_ctrl | (1 << 10);
+	__smmu_writel(smmu_dev, smmu_ctrl, SMMU_CTRL_OFFSET);
+
+	do {
+		smmu_ctrl = __smmu_readl(smmu_dev, SMMU_CTRL_OFFSET);
+		if (0x0 == (smmu_ctrl & (1 << 10))) {
+			spin_unlock_irqrestore(&m_domain->spinlock, flags);
+			return;
+		}
+	} while (inv_cnt--);
+
+	spin_unlock_irqrestore(&m_domain->spinlock, flags);
+
+	WARN_ON((!inv_cnt) && ((smmu_ctrl & 0x400) != 0));
+}
+
+static int __smmu_enable(struct hi6220_smmu *smmu_dev)
+{
+	if (clk_prepare_enable(smmu_dev->media_sc_clk)) {
+		pr_err("clk_prepare_enable media_sc_clk is falied\n");
+		return -ENODEV;
+	}
+	if (clk_prepare_enable(smmu_dev->smmu_peri_clk)) {
+		pr_err("clk_prepare_enable smmu_peri_clk is falied\n");
+		return -ENODEV;
+	}
+	if (clk_prepare_enable(smmu_dev->smmu_clk)) {
+		pr_err("clk_prepare_enable smmu_clk is falied\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static int smmu_domain_unprepare(struct hi6220_domain *dom)
+{
+	return 0;
+}
+
+static int smmu_domain_prepare(struct hi6220_domain *dom)
+{
+	return 0;
+}
+
+static irqreturn_t hi6220_smmu_isr(int irq, void *data)
+{
+	int          i;
+	unsigned int irq_stat;
+	unsigned int irq_rawstat;
+	unsigned int pgt = 0;
+	unsigned int pc_pgt = 0;
+	struct hi6220_smmu *smmu_dev = smmu_dev_handle;
+
+	irq_stat = __smmu_readl(smmu_dev, SMMU_MINTSTS_OFFSET);
+	irq_rawstat = __smmu_readl(smmu_dev, SMMU_RINTSTS_OFFSET);
+
+	__smmu_writel(smmu_dev, 0xff, SMMU_INTCLR_OFFSET);
+	pgt = __smmu_readl(smmu_dev, SMMU_PTBR_OFFSET);
+	pc_pgt = __smmu_readl(smmu_dev, SMMU_IPTSRC_OFFSET);
+
+	for (i = 0; i < SMMU_REGS_SGMT_END; i += 4)
+		pr_err("[%08x] ", __smmu_readl(smmu_dev, i));
+
+	WARN_ON(irq_stat & 0x3f);
+
+	return IRQ_HANDLED;
+}
+
+static bool hi6220_smmu_capable(enum iommu_cap cap)
+{
+	return false;
+}
+
+static struct iommu_domain *hi6220_domain_alloc(unsigned type)
+{
+	struct hi6220_domain *m_domain;
+	struct hi6220_smmu *smmu_dev;
+
+	if (type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	smmu_dev = smmu_dev_handle;
+	if (!smmu_dev)
+		return NULL;
+
+	m_domain = kzalloc(sizeof(*m_domain), GFP_KERNEL);
+	if (!m_domain)
+		return NULL;
+
+	m_domain->smmu_dev = smmu_dev_handle;
+	m_domain->io_domain.geometry.aperture_start = IOVA_START;
+	m_domain->io_domain.geometry.aperture_end = IOVA_END;
+	m_domain->io_domain.geometry.force_aperture = true;
+
+	return &m_domain->io_domain;
+}
+
+static void hi6220_domain_free(struct iommu_domain *domain)
+{
+	struct hi6220_domain *hi6220_domain = to_hi6220_domain(domain);
+
+	kfree(hi6220_domain);
+}
+
+static int hi6220_smmu_attach_dev(struct iommu_domain *domain,
+				  struct device *dev)
+{
+	struct hi6220_domain *m_domain = to_hi6220_domain(domain);
+
+	smmu_domain_prepare(m_domain);
+	dev->archdata.iommu = &m_domain->smmu_dev->iova_allocator;
+
+	return 0;
+}
+
+static void hi6220_smmu_detach_dev(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct hi6220_domain *m_domain = to_hi6220_domain(domain);
+
+	smmu_domain_unprepare(m_domain);
+	dev->archdata.iommu = NULL;
+}
+
+static inline void dump_pte(unsigned int *pte)
+{
+	int index;
+
+	for (index = 0; index < SZ_2M / sizeof(int); index++) {
+		if (pte[index])
+			pr_err("pte [%p]\t%x\n", &pte[index], pte[index]);
+	}
+}
+
+static int hi6220_smmu_map(struct iommu_domain *domain,
+			   unsigned long iova, phys_addr_t pa,
+			   size_t size, int smmu_prot)
+{
+	struct hi6220_domain *m_domain = to_hi6220_domain(domain);
+	size_t page_size = m_domain->smmu_dev->page_size;
+	struct hi6220_smmu *smmu_dev = m_domain->smmu_dev;
+	unsigned int *page_table = (unsigned int *)smmu_dev->pgtable_virt;
+
+	if (size != page_size) {
+		pr_err("map size error, only support %zd\n", page_size);
+		return -ENOMEM;
+	}
+
+	__set_smmu_pte(page_table + IOVA_PFN(iova), pa);
+
+	__invalid_smmu_tlb(m_domain, iova, size);
+
+	return 0;
+}
+
+static size_t hi6220_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+				size_t size)
+{
+	struct hi6220_domain *m_domain = to_hi6220_domain(domain);
+	size_t page_size = m_domain->smmu_dev->page_size;
+	struct hi6220_smmu *smmu_dev = m_domain->smmu_dev;
+	int *page_table = (unsigned int *)smmu_dev->pgtable_virt;
+
+	if (size != page_size) {
+		pr_err("unmap size error, only support %zd\n", page_size);
+		return 0;
+	}
+
+	__clear_smmu_pte(page_table + IOVA_PFN(iova));
+
+	return page_size;
+}
+
+static phys_addr_t hi6220_smmu_iova_to_phys(struct iommu_domain *domain,
+					    dma_addr_t iova)
+{
+	return 0;
+}
+
+static const struct iommu_ops hi6220_smmu_ops = {
+	.capable = hi6220_smmu_capable,
+	.domain_alloc = hi6220_domain_alloc,
+	.domain_free = hi6220_domain_free,
+	.attach_dev = hi6220_smmu_attach_dev,
+	.detach_dev = hi6220_smmu_detach_dev,
+	.map = hi6220_smmu_map,
+	.unmap = hi6220_smmu_unmap,
+	.map_sg = default_iommu_map_sg,
+	.iova_to_phys = hi6220_smmu_iova_to_phys,
+
+	.pgsize_bitmap = SZ_4K,
+};
+
+static int hi6220_smmu_probe(struct platform_device *pdev)
+{
+	int ret;
+	int irq;
+	struct hi6220_smmu *smmu_dev  = NULL;
+	struct resource *res = NULL;
+
+	smmu_dev = devm_kzalloc(&pdev->dev, sizeof(*smmu_dev), GFP_KERNEL);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	smmu_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(smmu_dev->reg_base))
+		return PTR_ERR(smmu_dev->reg_base);
+
+	smmu_dev->media_sc_clk = devm_clk_get(&pdev->dev, "media_sc_clk");
+	smmu_dev->smmu_peri_clk  = devm_clk_get(&pdev->dev, "smmu_peri_clk");
+	smmu_dev->smmu_clk  = devm_clk_get(&pdev->dev, "smmu_clk");
+	if (IS_ERR(smmu_dev->media_sc_clk) || IS_ERR(smmu_dev->smmu_peri_clk) ||
+	    IS_ERR(smmu_dev->media_sc_clk)) {
+		pr_err("clk is not ready!\n");
+	}
+
+	irq = platform_get_irq(pdev, 0);
+
+	ret = devm_request_irq(&pdev->dev, irq, hi6220_smmu_isr, 0,
+			       dev_name(&pdev->dev), smmu_dev);
+	if (ret) {
+		pr_err("Unabled to register handler of irq %d\n", irq);
+		return ret;
+	}
+
+	smmu_dev->irq = irq;
+	smmu_dev->smmu_isr = hi6220_smmu_isr;
+	smmu_dev->page_size = IOVA_PAGE_SZ;
+
+	__smmu_enable(smmu_dev);
+
+	iommu_iova_cache_init();
+	init_iova_domain(&smmu_dev->iova_allocator, IOVA_PAGE_SZ,
+			 IOVA_START_PFN, IOVA_PFN(DMA_BIT_MASK(32)));
+
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	smmu_dev->pgtable_virt = dma_alloc_coherent(&pdev->dev, SZ_2M,
+						    &smmu_dev->pgtable_phy,
+						    GFP_KERNEL);
+	memset(smmu_dev->pgtable_virt, 0, SZ_2M);
+
+	platform_set_drvdata(pdev, smmu_dev);
+	bus_set_iommu(&platform_bus_type, &hi6220_smmu_ops);
+	smmu_dev_handle = smmu_dev;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int hi6220_smmu_suspend(struct platform_device *pdev,
+			       pm_message_t state)
+{
+	struct hi6220_smmu *smmu_dev = dev_get_drvdata(&pdev->dev);
+
+	__restore_regs(smmu_dev);
+
+	if (smmu_dev->smmu_clk)
+		clk_disable_unprepare(smmu_dev->smmu_clk);
+	if (smmu_dev->media_sc_clk)
+		clk_disable_unprepare(smmu_dev->media_sc_clk);
+	if (smmu_dev->smmu_peri_clk)
+		clk_disable_unprepare(smmu_dev->smmu_peri_clk);
+
+	return 0;
+}
+
+static int hi6220_smmu_resume(struct platform_device *pdev)
+{
+	struct hi6220_smmu *smmu_dev = dev_get_drvdata(&pdev->dev);
+
+	__smmu_enable(smmu_dev);
+	__reload_regs(smmu_dev);
+	return 0;
+}
+
+#else
+
+#define hi6220_smmu_suspend NULL
+#define hi6220_smmu_resume NULL
+
+#endif /* CONFIG_PM */
+
+static const struct of_device_id of_smmu_match_tbl[] = {
+	{
+		.compatible = "hisilicon,hi6220-smmu",
+	},
+	{ }
+};
+
+static struct platform_driver hi6220_smmu_driver = {
+	.driver  = {
+		.name = "smmu-hi6220",
+		.of_match_table = of_smmu_match_tbl,
+	},
+	.probe  =  hi6220_smmu_probe,
+#ifdef CONFIG_PM
+	.suspend = hi6220_smmu_suspend,
+	.resume  = hi6220_smmu_resume,
+#endif
+};
+
+static int __init hi6220_smmu_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&hi6220_smmu_driver);
+	return ret;
+}
+
+subsys_initcall(hi6220_smmu_init);
-- 
1.9.1
