From: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v5 7/8] drm/rockchip: Use common IOMMU API to attach devices
Date: Fri, 24 Jun 2016 10:13:32 +0800
Message-ID: <1466734413-7453-8-git-send-email-zhengsq@rock-chips.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1466734413-7453-1-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

Since previous patch added support for direct IOMMU address space
management, there is no need to use DMA API anymore and this patch wires
things to use the new method.

Signed-off-by: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 100 +++++++++++++++-------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 8b96c69..ca9624f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -14,18 +14,18 @@
  * GNU General Public License for more details.
  */
 
-#include <asm/dma-iommu.h>
-
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-iommu.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
 #include <linux/component.h>
 #include <linux/console.h>
+#include <linux/iommu.h>
 
 #include <drm/rockchip_drm.h>
 
@@ -51,28 +51,31 @@ static struct drm_driver rockchip_drm_driver;
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev)
 {
-	struct dma_iommu_mapping *mapping = drm_dev->dev->archdata.mapping;
+	struct rockchip_drm_private *private = drm_dev->dev_private;
 	int ret;
 
 	if (!is_support_iommu)
 		return 0;
 
-	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
-	if (ret)
+	ret = iommu_attach_device(private->domain, dev);
+	if (ret) {
+		dev_err(dev, "Failed to attach iommu device\n");
 		return ret;
+	}
 
-	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
-
-	return arm_iommu_attach_device(dev, mapping);
+	return 0;
 }
 
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev)
 {
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+	struct iommu_domain *domain = private->domain;
+
 	if (!is_support_iommu)
 		return;
 
-	arm_iommu_detach_device(dev);
+	iommu_detach_device(domain, dev);
 }
 
 int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
@@ -137,11 +140,45 @@ static void rockchip_drm_crtc_disable_vblank(struct drm_device *dev,
 		priv->crtc_funcs[pipe]->disable_vblank(crtc);
 }
 
+static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
+{
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+	struct iommu_domain_geometry *geometry;
+	u64 start, end;
+
+	if (!is_support_iommu)
+		return 0;
+
+	private->domain = iommu_domain_alloc(&platform_bus_type);
+	if (!private->domain)
+		return -ENOMEM;
+
+	geometry = &private->domain->geometry;
+	start = geometry->aperture_start;
+	end = geometry->aperture_end;
+
+	DRM_DEBUG("IOMMU context initialized (aperture: %#llx-%#llx)\n",
+		  start, end);
+	drm_mm_init(&private->mm, start, end - start + 1);
+
+	return 0;
+}
+
+static void rockchip_iommu_cleanup(struct drm_device *drm_dev)
+{
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+
+	if (!is_support_iommu)
+		return;
+
+	drm_mm_takedown(&private->mm);
+	iommu_domain_free(private->domain);
+}
+
 static int rockchip_drm_bind(struct device *dev)
 {
 	struct drm_device *drm_dev;
 	struct rockchip_drm_private *private;
-	struct dma_iommu_mapping *mapping = NULL;
 	int ret;
 
 	drm_dev = drm_dev_alloc(&rockchip_drm_driver, dev);
@@ -162,38 +199,14 @@ static int rockchip_drm_bind(struct device *dev)
 
 	rockchip_drm_mode_config_init(drm_dev);
 
-	dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
-				      GFP_KERNEL);
-	if (!dev->dma_parms) {
-		ret = -ENOMEM;
+	ret = rockchip_drm_init_iommu(drm_dev);
+	if (ret)
 		goto err_config_cleanup;
-	}
-
-	if (is_support_iommu) {
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
-		if (ret)
-			goto err_release_mapping;
-	}
 
 	/* Try to bind all sub drivers. */
 	ret = component_bind_all(dev, drm_dev);
 	if (ret)
-		goto err_detach_device;
+		goto err_iommu_cleanup;
 
 	/* init kms poll for handling hpd */
 	drm_kms_helper_poll_init(drm_dev);
@@ -218,8 +231,6 @@ static int rockchip_drm_bind(struct device *dev)
 	if (ret)
 		goto err_fbdev_fini;
 
-	if (is_support_iommu)
-		arm_iommu_release_mapping(mapping);
 	return 0;
 err_fbdev_fini:
 	rockchip_drm_fbdev_fini(drm_dev);
@@ -228,12 +239,8 @@ err_vblank_cleanup:
 err_kms_helper_poll_fini:
 	drm_kms_helper_poll_fini(drm_dev);
 	component_unbind_all(dev, drm_dev);
-err_detach_device:
-	if (is_support_iommu)
-		arm_iommu_detach_device(dev);
-err_release_mapping:
-	if (is_support_iommu)
-		arm_iommu_release_mapping(mapping);
+err_iommu_cleanup:
+	rockchip_iommu_cleanup(drm_dev);
 err_config_cleanup:
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
@@ -250,8 +257,7 @@ static void rockchip_drm_unbind(struct device *dev)
 	drm_vblank_cleanup(drm_dev);
 	drm_kms_helper_poll_fini(drm_dev);
 	component_unbind_all(dev, drm_dev);
-	if (is_support_iommu)
-		arm_iommu_detach_device(dev);
+	rockchip_iommu_cleanup(drm_dev);
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev->dev_private = NULL;
 	drm_dev_unregister(drm_dev);
-- 
1.9.1
