From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 29/29] temporary: media: s5p-mfc: add support for IOMMU
Date: Tue, 05 Aug 2014 12:47:57 +0200
Message-ID: <1407235677-26324-30-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch is an example how to use more than one IOMMU controller in a
device driver for hardware blocks, which have more then one dma master
(memory interface with iommu controller).

This patch is temporary, do not merge it yet.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 46 ++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 77b99ae..c2e95ab 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -22,7 +22,11 @@
 #include <media/v4l2-event.h>
 #include <linux/workqueue.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <media/videobuf2-core.h>
+
+#include <asm/dma-iommu.h>
+
 #include "s5p_mfc_common.h"
 #include "s5p_mfc_ctrl.h"
 #include "s5p_mfc_debug.h"
@@ -996,6 +1000,39 @@ static const struct v4l2_file_operations s5p_mfc_fops = {
 	.mmap = s5p_mfc_mmap,
 };
 
+static struct device *s5p_mfc_alloc_memdev(struct device *dev, const char *name)
+{
+	struct device *child;
+	int ret;
+
+	child = devm_kzalloc(dev, sizeof(struct device), GFP_KERNEL);
+	if (!child)
+		return NULL;
+
+	device_initialize(child);
+	dev_set_name(child, "%s:%s", dev_name(dev), name);
+	child->parent = dev;
+	child->bus = dev->bus;
+	child->coherent_dma_mask = dev->coherent_dma_mask;
+	child->dma_mask = dev->dma_mask;
+
+	if (device_add(child) == 0) {
+		ret = arm_iommu_create_default_mapping(child, 0x20000000,
+						       SZ_256M);
+		if (ret == 0)
+			return child;
+	}
+
+	put_device(child);
+	return NULL;
+}
+
+void s5p_mfc_free_memdev(struct device *dev)
+{
+	arm_iommu_release_default_mapping(dev);
+	put_device(dev);
+}
+
 static void *mfc_get_drv_data(struct platform_device *pdev);
 
 /* MFC probe function */
@@ -1049,8 +1086,8 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	dev->mem_dev_l = &dev->plat_dev->dev;
-	dev->mem_dev_r = &dev->plat_dev->dev;
+	dev->mem_dev_l = s5p_mfc_alloc_memdev(&dev->plat_dev->dev, "left");
+	dev->mem_dev_r = s5p_mfc_alloc_memdev(&dev->plat_dev->dev, "right");
 
 	dev->alloc_ctx[0] = vb2_dma_contig_init_ctx(dev->mem_dev_l);
 	if (IS_ERR(dev->alloc_ctx[0])) {
@@ -1181,6 +1218,10 @@ static int s5p_mfc_remove(struct platform_device *pdev)
 	s5p_mfc_release_firmware(dev);
 	vb2_dma_contig_cleanup_ctx(dev->alloc_ctx[0]);
 	vb2_dma_contig_cleanup_ctx(dev->alloc_ctx[1]);
+	if (dev->mem_dev_l)
+		s5p_mfc_free_memdev(dev->mem_dev_l);
+	if (dev->mem_dev_r)
+		s5p_mfc_free_memdev(dev->mem_dev_r);
 
 	s5p_mfc_final_pm(dev);
 	return 0;
@@ -1436,6 +1477,7 @@ static struct platform_driver s5p_mfc_driver = {
 		.owner	= THIS_MODULE,
 		.pm	= &s5p_mfc_pm_ops,
 		.of_match_table = exynos_mfc_match,
+		.flags	= DRIVER_HAS_OWN_IOMMU_MANAGER,
 	},
 };
 
-- 
1.9.2
