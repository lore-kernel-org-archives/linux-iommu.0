From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 1/3] xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU driver.
Date: Mon, 15 Dec 2014 22:25:21 +0530
Message-ID: <1418662523-8458-2-git-send-email-stripathi@apm.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418662523-8458-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds the support for the APM X-Gene SoC AHBC IOMMU driver.
This driver translates the 32-bit AHB address from the dma master to
42-bit AXI address with the help of a set of AHBC inbound mapper (AIM)
registers. The AHB dma master for slaves, eg: sdhci etc, will use this
driver to do a dma transfer operation.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/iommu/Kconfig            |  10 ++
 drivers/iommu/Makefile           |   1 +
 drivers/iommu/xgene-ahbc-iommu.c | 336 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+)
 create mode 100644 drivers/iommu/xgene-ahbc-iommu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dd51122..c0f5f23 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -302,4 +302,14 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.

+config XGENE_AHBC_IOMMU
+	bool "X-Gene AHBC IOMMU Support"
+	default y if ARCH_XGENE
+	select IOMMU_API
+	help
+	  Support for AHBC translation driver for X-Gene. This driver
+	  translates the 32-bit AHB address from dma master to 42-bit
+	  AXI address with the help of some set of AHB inbound mapping
+	  registers.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 16edef7..ae3b663 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
 obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
+obj-$(CONFIG_XGENE_AHBC_IOMMU) += xgene-ahbc-iommu.o
diff --git a/drivers/iommu/xgene-ahbc-iommu.c b/drivers/iommu/xgene-ahbc-iommu.c
new file mode 100644
index 0000000..7e3701e
--- /dev/null
+++ b/drivers/iommu/xgene-ahbc-iommu.c
@@ -0,0 +1,336 @@
+/*
+ * APM X-Gene SoC AHBC(IOMMU) Translation Driver
+ *
+ * Copyright (c) 2014 Applied Micro Circuits Corporation.
+ * Author: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/amba/bus.h>
+#include <linux/dma-mapping.h>
+#include <linux/iommu.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+
+#define AHB_PAGE_SIZE		(4*1024)
+#define AHB_MAP_COUNT		8
+
+/* APM X-Gene SoC AHB bridge registers */
+#define AIM0				0x0000
+#define AIM0_SIZE_CTL			0x0004
+#define AIM0_AXI_LO			0x0008
+#define AIM0_AXI_HI			0x0010
+
+#define AIMX				0x0014
+#define AIM_AXI_ADDRESS_HI_N_WR(src)	(((u32) (src) << 20) & 0xfff00000)
+#define AIMX_SIZE_CTL			0x0018
+#define AIM_EN_N_WR(src)		(((u32) (src) << 31) & 0x80000000)
+#define AIM_EN_N_RD(src)		(((u32) (src) & 0x80000000) >> 31)
+#define ARSB_WR(src)			(((u32) (src) << 24) & 0x0f000000)
+#define AWSB_WR(src)			(((u32) (src) << 20) & 0x00f00000)
+#define AIM_MASK_N_WR(src)		(((u32) (src)) & 0x000fffff)
+#define AIMX_AXI_LO			0x001c
+#define AIMX_AXI_HI			0x0020
+#define AIMX_STRIDE			0x0010
+
+#define ENABLE_AIM_TRANSLATION		AIM_EN_N_WR(1) | ARSB_WR(1) | \
+					AWSB_WR(1) | \
+		       			AIM_MASK_N_WR(0)
+
+#define DISABLE_AIM_TRANSLATION        AIM_EN_N_WR(0) | ARSB_WR(0) | \
+					AWSB_WR(0) | \
+		       			AIM_MASK_N_WR(0)
+
+struct xgene_ahbc_mmu_device {
+	struct device *dev;
+	void __iomem *ahb_csr;
+};
+
+struct xgene_ahbc_mmu_domain {
+	struct xgene_ahbc_mmu_device *leaf_ahbc;
+	spinlock_t lock;
+	int slot_used;
+};
+
+struct xgene_ahbc_mmu_device *ahbc_mmu;
+
+static int xgene_ahbc_mmu_find_entry(struct xgene_ahbc_mmu_device *ctx)
+{
+	int i;
+	u32 val;
+
+	/*
+	 * Find free slot by checking the EN-bit
+	 * of AIMX register.
+	 *
+	 * AIMX_SIZE_CTL[31]
+	 * 0 : Register available for reuse.
+	 * 1 : Translation going on using the register.
+	 */
+	for (i = 0; i < AHB_MAP_COUNT; i++) {
+		/*
+		 * The AIM0_LO register offset for slot 0 is different from
+		 * other slots. So explicitly check for slot 0 is
+		 * required
+		 */
+		if (i == 0)
+			val = readl(ctx->ahb_csr + AIM0_SIZE_CTL);
+		else
+			val = readl(ctx->ahb_csr + AIMX +
+				   (i - 1 ) * AIMX_STRIDE);
+		if (!AIM_EN_N_RD(val))
+			return i;
+	}
+	return -ENODEV;
+}
+
+static void xgene_ahbc_mmu_prog_entry(struct xgene_ahbc_mmu_device * ctx,
+				      int slot,
+				      phys_addr_t pa)
+{
+	/*
+	 * Program the upper 32-bits of AXI address into
+	 * one of the 8 set of AHB INBOUND MAPPER(AIM) registers
+	 * for 32-bit AHB address by DMA master to 42-bit AXI address
+	 * translation. Slot0 indicates AHB inbound register mapper 0(AIM0)
+	 * and slot[1-7] is indicated by AIMX. As the AIM0_LO register offset
+	 * for slot 0 is different from other slots, so explicitly check
+	 * for slot 0.
+	 */
+	if (slot == 0) {
+		writel(0, ctx->ahb_csr + AIM0_AXI_LO);
+		writel(AIM_AXI_ADDRESS_HI_N_WR(pa >> 32),
+		       ctx->ahb_csr + AIM0_AXI_HI);
+		writel(0, ctx->ahb_csr + AIM0);
+		/* Enable the AIM0 window translation */
+		writel(ENABLE_AIM_TRANSLATION,
+		       ctx->ahb_csr + AIM0_SIZE_CTL);
+	} else {
+		u32 os = (slot - 1) * AIMX_STRIDE;
+
+		writel(0, ctx->ahb_csr + AIMX_AXI_LO + os);
+		writel(AIM_AXI_ADDRESS_HI_N_WR(pa >> 32),
+		       ctx->ahb_csr + AIMX_AXI_HI + os);
+		writel(0, ctx->ahb_csr + AIMX + os);
+		/* Enable the AIMX[1-7] window translation */
+		writel(ENABLE_AIM_TRANSLATION,
+		       ctx->ahb_csr + AIMX_SIZE_CTL + os);
+	}
+}
+
+static void xgene_ahbc_mmu_clr_entry(struct xgene_ahbc_mmu_device * ctx, int slot)
+{
+	/*
+	 * Disable the AIM window translation to reuse the AIM registers.
+	 * As the AIM0_LO register offset for slot 0 is different from other
+	 * slots, so explicitly check for slot 0.
+	 */
+	if (slot == 0)
+		writel(DISABLE_AIM_TRANSLATION,
+		       ctx->ahb_csr + AIM0_SIZE_CTL);
+	else
+		writel(DISABLE_AIM_TRANSLATION,
+		       ctx->ahb_csr + AIMX_SIZE_CTL +
+		       (slot - 1) * AIMX_STRIDE);
+}
+
+static int xgene_ahbc_mmu_iommu_map(struct iommu_domain *domain,
+				    unsigned long iova,
+				    phys_addr_t pa,
+				    size_t bytes, int prot)
+{
+	struct xgene_ahbc_mmu_domain *ahbc_mmu_domain = domain->priv;
+	unsigned long flags;
+	int slot;
+
+	spin_lock_irqsave(&ahbc_mmu_domain->lock, flags);
+	slot = xgene_ahbc_mmu_find_entry(ahbc_mmu_domain->leaf_ahbc);
+	if (slot < 0) {
+		spin_unlock_irqrestore(&ahbc_mmu_domain->lock, flags);
+		return slot;
+	}
+
+	ahbc_mmu_domain->slot_used = slot;
+
+	xgene_ahbc_mmu_prog_entry(ahbc_mmu_domain->leaf_ahbc, slot, pa);
+	spin_unlock_irqrestore(&ahbc_mmu_domain->lock, flags);
+
+	return 0;
+}
+
+static size_t xgene_ahb_iommu_unmap(struct iommu_domain *domain,
+				    unsigned long iova, size_t bytes)
+{
+	struct xgene_ahbc_mmu_domain *ahbc_mmu_domain = domain->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ahbc_mmu_domain->lock, flags);
+	xgene_ahbc_mmu_clr_entry(ahbc_mmu_domain->leaf_ahbc,
+				 ahbc_mmu_domain->slot_used);
+	spin_unlock_irqrestore(&ahbc_mmu_domain->lock, flags);
+	return AHB_PAGE_SIZE;
+}
+
+
+static int xgene_ahbc_mmu_domain_has_cap(struct iommu_domain *domain,
+				     unsigned long cap)
+{
+	return 0;
+}
+
+static int xgene_ahbc_mmu_attach_dev(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	struct xgene_ahbc_mmu_domain *ahbc_mmu_domain = domain->priv;
+
+	if (!ahbc_mmu_domain) {
+		dev_err(dev, "%s failed to attach\n", dev_name(dev));
+		return -EINVAL;
+	}
+
+	ahbc_mmu_domain->leaf_ahbc = ahbc_mmu;
+
+	dev_dbg(dev, "%s is attached\n", dev_name(dev));
+	return 0;
+}
+
+static void xgene_ahbc_mmu_detach_dev(struct iommu_domain *domain,
+				  struct device *dev)
+{
+	struct xgene_ahbc_mmu_domain *ahbc_mmu_domain = domain->priv;
+
+	ahbc_mmu_domain->leaf_ahbc = NULL;
+
+	dev_dbg(dev, "%s is deattached\n", dev_name(dev));
+}
+
+static int xgene_ahbc_mmu_add_device(struct device *dev)
+{
+	if (dev->archdata.iommu) {
+		dev_warn(dev, "IOMMU driver already assigned to device\n");
+		return -EINVAL;
+	}
+
+	dev->archdata.iommu = ahbc_mmu;
+	return 0;
+}
+
+static void xgene_ahbc_mmu_remove_device(struct device *dev)
+{
+	dev->archdata.iommu = NULL;
+}
+
+static int xgene_ahbc_mmu_domain_init(struct iommu_domain *domain)
+{
+	struct xgene_ahbc_mmu_domain *ahbc_mmu_domain;
+
+	ahbc_mmu_domain = kzalloc(sizeof(*ahbc_mmu_domain), GFP_KERNEL);
+	if (!ahbc_mmu_domain)
+		return -ENOMEM;
+
+	spin_lock_init(&ahbc_mmu_domain->lock);
+	domain->priv = ahbc_mmu_domain;
+	return 0;
+}
+
+static void xgene_ahbc_mmu_domain_destroy(struct iommu_domain *domain)
+{
+	struct xgene_ahbc_mmu_domain *ahbc_mmu_domain = domain->priv;
+
+	domain->priv = NULL;
+	kfree(ahbc_mmu_domain);
+}
+
+static struct iommu_ops xgene_ahbc_mmu_ops = {
+	.domain_init	= xgene_ahbc_mmu_domain_init,
+	.domain_destroy	= xgene_ahbc_mmu_domain_destroy,
+	.attach_dev	= xgene_ahbc_mmu_attach_dev,
+	.detach_dev	= xgene_ahbc_mmu_detach_dev,
+	.add_device	= xgene_ahbc_mmu_add_device,
+	.remove_device	= xgene_ahbc_mmu_remove_device,
+	.map		= xgene_ahbc_mmu_iommu_map,
+	.unmap		= xgene_ahb_iommu_unmap,
+	.domain_has_cap	= xgene_ahbc_mmu_domain_has_cap,
+	.pgsize_bitmap	= AHB_PAGE_SIZE,
+};
+
+static int xgene_ahbc_mmu_probe(struct platform_device *pdev)
+{
+	struct xgene_ahbc_mmu_device *ctx;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctx->ahb_csr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ctx->ahb_csr))
+		return PTR_ERR(ctx->ahb_csr);
+
+	ctx->dev = dev;
+
+	platform_set_drvdata(pdev, ctx);
+	ahbc_mmu = ctx;
+
+	if (!iommu_present(&amba_bustype))
+		bus_set_iommu(&amba_bustype, &xgene_ahbc_mmu_ops);
+
+	return 0;
+}
+
+static int xgene_ahbc_mmu_remove(struct platform_device *pdev)
+{
+	struct xgene_ahbc_mmu_device *ctx = platform_get_drvdata(pdev);
+
+	devm_kfree(&pdev->dev, ctx);
+	return 0;
+}
+
+static struct of_device_id xgene_ahbc_mmu_of_match[] = {
+	{ .compatible = "apm,xgene-ahbc-iommu"},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, xgene_ahbc_mmu_of_match);
+
+static struct platform_driver xgene_ahbc_mmu_driver = {
+	.probe		= xgene_ahbc_mmu_probe,
+	.remove		= xgene_ahbc_mmu_remove,
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "xgene-ahbc",
+		.of_match_table = of_match_ptr(xgene_ahbc_mmu_of_match),
+	},
+};
+
+static int xgene_ahbc_mmu_init(void)
+{
+	return platform_driver_register(&xgene_ahbc_mmu_driver);
+}
+subsys_initcall(xgene_ahbc_mmu_init);
+
+static void __exit xgene_ahbc_mmu_exit(void)
+{
+	platform_driver_unregister(&xgene_ahbc_mmu_driver);
+}
+module_exit(xgene_ahbc_mmu_exit);
+
+MODULE_DESCRIPTION("APM X-Gene SoC AHB Translation");
+MODULE_AUTHOR("Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
