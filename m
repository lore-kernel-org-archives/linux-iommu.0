From: Shunqian Zheng <zhengsq@rock-chips.com>
Subject: [PATCH v3 4/6] drm: rockchip: use common iommu api to attach iommu
Date: Wed, 15 Jun 2016 20:04:43 +0800
Message-ID: <1465992285-16187-5-git-send-email-zhengsq@rock-chips.com>
References: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mark.yao@rock-chips.com, airlied@linux.ie, tfiga@google.com, xxm@rock-chips.com
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Shunqian Zheng <zhengsq@rock-chips.com>
List-Id: iommu@lists.linux-foundation.org

Rockchip DRM used the arm special API, arm_iommu_*(), to attach
iommu for ARM32 SoCs. This patch convert to common iommu API
so it would support ARM64 like RK3399.

The general idea is domain_alloc(), attach_device() and
arch_setup_dma_ops() to set dma_ops manually for DRM at the last.

Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 112 +++++++++++++++++-----------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 2 files changed, 71 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f5a68fc..b52c38d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -14,16 +14,16 @@
  * GNU General Public License for more details.
  */
 
-#include <asm/dma-iommu.h>
-
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
 #include <linux/component.h>
+#include <linux/iommu.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_fb.h"
@@ -46,7 +46,8 @@ static bool is_support_iommu = true;
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev)
 {
-	struct dma_iommu_mapping *mapping = drm_dev->dev->archdata.mapping;
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+	struct iommu_domain *domain = private->domain;
 	int ret;
 
 	if (!is_support_iommu)
@@ -58,16 +59,25 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 
 	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
 
-	return arm_iommu_attach_device(dev, mapping);
+	ret = iommu_attach_device(domain, dev);
+	if (ret) {
+		dev_err(dev, "Failed to attach iommu device\n");
+		return ret;
+	}
+
+	/* TODO(djkurtz): fetch the mapping start/size from somewhere */
+	arch_setup_dma_ops(dev, 0x00000000, SZ_2G, dev->bus->iommu_ops, false);
+	return 0;
 }
 
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev)
 {
-	if (!is_support_iommu)
-		return;
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+	struct iommu_domain *domain = private->domain;
 
-	arm_iommu_detach_device(dev);
+	if (is_support_iommu)
+		iommu_detach_device(domain, dev);
 }
 
 int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
@@ -132,10 +142,52 @@ static void rockchip_drm_crtc_disable_vblank(struct drm_device *dev,
 		priv->crtc_funcs[pipe]->disable_vblank(crtc);
 }
 
+static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
+{
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+	struct device *dev = drm_dev->dev;
+	int ret;
+
+	dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
+				      GFP_KERNEL);
+	if (!dev->dma_parms)
+		return -ENOMEM;
+
+	private->domain = iommu_domain_alloc(&platform_bus_type);
+	if (!private->domain)
+		return -ENOMEM;
+
+	/* TODO(djkurtz): fetch the mapping start/size from somewhere */
+	ret = iommu_dma_init_domain(private->domain, 0x00000000, SZ_2G);
+	if (ret) {
+		dev_err(dev, "Failed to init domain\n");
+		goto err_free_domain;
+	}
+
+	ret = rockchip_drm_dma_attach_device(drm_dev, dev);
+	if (ret) {
+		dev_err(dev, "Failed to attach device\n");
+		goto err_free_domain;
+	}
+
+	return 0;
+
+err_free_domain:
+	iommu_domain_free(private->domain);
+
+	return ret;
+}
+
+static void rockchip_iommu_cleanup(struct drm_device *drm_dev)
+{
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+
+	iommu_domain_free(private->domain);
+}
+
 static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 {
 	struct rockchip_drm_private *private;
-	struct dma_iommu_mapping *mapping = NULL;
 	struct device *dev = drm_dev->dev;
 	struct drm_connector *connector;
 	int ret;
@@ -153,38 +205,18 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 
 	rockchip_drm_mode_config_init(drm_dev);
 
-	dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
-				      GFP_KERNEL);
-	if (!dev->dma_parms) {
-		ret = -ENOMEM;
-		goto err_config_cleanup;
-	}
-
 	if (is_support_iommu) {
-		/* TODO(djkurtz): fetch the mapping start/size from somewhere */
-		mapping = arm_iommu_create_mapping(&platform_bus_type,
-						   0x00000000,
-						   SZ_2G);
-		if (IS_ERR(mapping)) {
-			ret = PTR_ERR(mapping);
-			goto err_config_cleanup;
-		}
-
-		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-		if (ret)
-			goto err_release_mapping;
-
-		dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
-
-		ret = arm_iommu_attach_device(dev, mapping);
+		ret = rockchip_drm_init_iommu(drm_dev);
 		if (ret)
-			goto err_release_mapping;
+			goto err_config_cleanup;
 	}
 
 	/* Try to bind all sub drivers. */
 	ret = component_bind_all(dev, drm_dev);
-	if (ret)
-		goto err_detach_device;
+	if (ret) {
+		dev_err(dev, "Failed to bind components\n");
+		goto err_iommu_cleanup;
+	}
 
 	/*
 	 * All components are now added, we can publish the connector sysfs
@@ -222,21 +254,17 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 	if (ret)
 		goto err_vblank_cleanup;
 
-	if (is_support_iommu)
-		arm_iommu_release_mapping(mapping);
 	return 0;
+
 err_vblank_cleanup:
 	drm_vblank_cleanup(drm_dev);
 err_kms_helper_poll_fini:
 	drm_kms_helper_poll_fini(drm_dev);
 err_unbind:
 	component_unbind_all(dev, drm_dev);
-err_detach_device:
-	if (is_support_iommu)
-		arm_iommu_detach_device(dev);
-err_release_mapping:
+err_iommu_cleanup:
 	if (is_support_iommu)
-		arm_iommu_release_mapping(mapping);
+		rockchip_iommu_cleanup(drm_dev);
 err_config_cleanup:
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
@@ -252,7 +280,7 @@ static int rockchip_drm_unload(struct drm_device *drm_dev)
 	drm_kms_helper_poll_fini(drm_dev);
 	component_unbind_all(dev, drm_dev);
 	if (is_support_iommu)
-		arm_iommu_detach_device(dev);
+		rockchip_iommu_cleanup(drm_dev);
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 56f43a3..1e2a666 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -70,6 +70,7 @@ struct rockchip_drm_private {
 	const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
 
 	struct rockchip_atomic_commit commit;
+	struct iommu_domain *domain;
 };
 
 void rockchip_drm_atomic_work(struct work_struct *work);
-- 
1.9.1
