From: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 5/7] drm: rockchip: use common iommu api to attach iommu
Date: Wed,  8 Jun 2016 21:26:30 +0800
Message-ID: <1465392392-2003-6-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1465392392-2003-1-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Rockchip DRM used the arm special API, arm_iommu_*(), to attach
iommu for ARM32 SoCs. This patch convert to common iommu API
so it would support ARM64 like RK3399.

The general idea is domain_alloc(), attach_device() and
arch_setup_dma_ops() to set dma_ops manually for DRM at the last.

Signed-off-by: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 130 +++++++++++++++++++---------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 2 files changed, 89 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f5a68fc..7965a66 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -14,8 +14,6 @@
  * GNU General Public License for more details.
  */
 
-#include <asm/dma-iommu.h>
-
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
@@ -24,6 +22,8 @@
 #include <linux/module.h>
 #include <linux/of_graph.h>
 #include <linux/component.h>
+#include <linux/dma-iommu.h>
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
+
+	if (ret) {
+		dev_err(dev, "Failed to attach iommu device\n");
+		return ret;
+	}
+	arch_setup_dma_ops(dev, 0x00000000, SZ_2G,
+			   (struct iommu_ops *)dev->bus->iommu_ops, false);
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
@@ -132,10 +142,70 @@ static void rockchip_drm_crtc_disable_vblank(struct drm_device *dev,
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
+	if (!dev->dma_parms) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(dev, "Failed to set coherent mask\n");
+		return ret;
+	}
+
+	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
+
+	private->domain = iommu_domain_alloc(&platform_bus_type);
+	if (!private->domain)
+		return -ENOMEM;
+
+	ret = iommu_get_dma_cookie(private->domain);
+	if (ret) {
+		dev_err(dev, "Failed to get dma cookie\n");
+		goto err_free_domain;
+	}
+
+	ret = iommu_dma_init_domain(private->domain, 0x00000000, SZ_2G);
+	if (ret) {
+		dev_err(dev, "Failed to init domain\n");
+		goto err_put_cookie;
+	}
+
+	ret = rockchip_drm_dma_attach_device(drm_dev, dev);
+	if (ret) {
+		dev_err(dev, "Failed to attach device\n");
+		goto err_put_cookie;
+	}
+
+	return 0;
+
+err_put_cookie:
+	iommu_put_dma_cookie(private->domain);
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
+	iommu_put_dma_cookie(private->domain);
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
@@ -153,38 +223,18 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 
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
+		ret = rockchip_drm_init_iommu(drm_dev);
 		if (ret)
-			goto err_release_mapping;
-
-		dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
-
-		ret = arm_iommu_attach_device(dev, mapping);
-		if (ret)
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
@@ -222,21 +272,17 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
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
@@ -252,7 +298,7 @@ static int rockchip_drm_unload(struct drm_device *drm_dev)
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
