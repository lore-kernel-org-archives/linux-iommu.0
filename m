From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] Revert "drm/vmwgfx: Improve on IOMMU detection"
Date: Mon,  8 Apr 2019 12:55:25 +0200
Message-ID: <20190408105525.5493-2-hch@lst.de>
References: <20190408105525.5493-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408105525.5493-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Hellstrom <thellstrom@vmware.com>
Cc: Deepak Rawat <drawat@vmware.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This reverts commit 9ddac734aa310c5fbc0ec93602335d2a39092451.
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 6165fe2c4504..9294b76c8084 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -26,7 +26,6 @@
  **************************************************************************/
 #include <linux/module.h>
 #include <linux/console.h>
-#include <linux/dma-mapping.h>
 
 #include <drm/drmP.h>
 #include "vmwgfx_drv.h"
@@ -35,6 +34,7 @@
 #include <drm/ttm/ttm_placement.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_module.h>
+#include <linux/intel-iommu.h>
 
 #define VMWGFX_DRIVER_DESC "Linux drm driver for VMware graphics devices"
 #define VMWGFX_CHIP_SVGAII 0
@@ -545,21 +545,6 @@ static void vmw_get_initial_size(struct vmw_private *dev_priv)
 	dev_priv->initial_height = height;
 }
 
-/**
- * vmw_assume_iommu - Figure out whether coherent dma-remapping might be
- * taking place.
- * @dev: Pointer to the struct drm_device.
- *
- * Return: true if iommu present, false otherwise.
- */
-static bool vmw_assume_iommu(struct drm_device *dev)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev->dev);
-
-	return !dma_is_direct(ops) && ops &&
-		ops->map_page != dma_direct_map_page;
-}
-
 /**
  * vmw_dma_select_mode - Determine how DMA mappings should be set up for this
  * system.
@@ -583,7 +568,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 
 	if (vmw_force_coherent)
 		dev_priv->map_mode = vmw_dma_alloc_coherent;
-	else if (vmw_assume_iommu(dev_priv->dev))
+	else if (intel_iommu_enabled)
 		dev_priv->map_mode = vmw_dma_map_populate;
 	else if (!vmw_force_iommu)
 		dev_priv->map_mode = vmw_dma_phys;
-- 
2.20.1
