From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC 1/3] drm/exynos: rewrite IOMMU support code
Date: Fri, 19 Feb 2016 09:22:42 +0100
Message-ID: <1455870164-25337-2-git-send-email-m.szyprowski@samsung.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1455870164-25337-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch replaces usage of ARM-specific IOMMU/DMA-mapping related calls
with new generic code for managing DMA-IOMMU integration layer. It also
removes all the hacks, which were needed to configure common DMA/IO address
space on the virtual exynos-drm device. Since moving Exynos GEM code to use
on of real devices for DMA-mapping operations, such hacks are no longer
needed. The only requirement is to have all the devices, which build
Exynos DRM, attached to the same IOMMU domain (to share IO address space).

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/gpu/drm/exynos/Kconfig            |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c   |  7 +--
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_iommu.c | 91 +++++++++++++++++++------------
 drivers/gpu/drm/exynos/exynos_drm_iommu.h |  2 +-
 5 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index 83efca941388..b0d0aaa7fea5 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -15,7 +15,7 @@ if DRM_EXYNOS
 
 config DRM_EXYNOS_IOMMU
 	bool
-	depends on EXYNOS_IOMMU && ARM_DMA_USE_IOMMU
+	depends on EXYNOS_IOMMU && IOMMU_DMA
 	default y
 
 comment "CRTCs"
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index c7fce7ffeef5..45aa480f1890 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -159,12 +159,7 @@ static int exynos_drm_load(struct drm_device *dev, unsigned long flags)
 	DRM_INFO("Exynos DRM: using %s device for DMA mapping operations\n",
 		 dev_name(private->dma_dev));
 
-	/*
-	 * create mapping to manage iommu table and set a pointer to iommu
-	 * mapping structure to iommu_mapping of private data.
-	 * also this iommu_mapping can be used to check if iommu is supported
-	 * or not.
-	 */
+	/* create common IOMMU mapping for all devices attached to Exynos DRM */
 	ret = drm_create_iommu_mapping(dev);
 	if (ret < 0) {
 		DRM_ERROR("failed to create iommu mapping.\n");
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index 303056311c0c..b107f77d0897 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -222,7 +222,7 @@ struct exynos_drm_private {
 	struct device *dma_dev;
 	unsigned long da_start;
 	unsigned long da_space_size;
-	void *mapping;
+	struct iommu_domain *domain;
 
 	unsigned int pipe;
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.c b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
index 146ac88078ae..89e51ed6499d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
@@ -14,13 +14,28 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
-#include <linux/kref.h>
-
-#include <asm/dma-iommu.h>
+#include <linux/dma-iommu.h>
 
 #include "exynos_drm_drv.h"
 #include "exynos_drm_iommu.h"
 
+static inline int configure_dma_max_seg_size(struct device *dev)
+{
+	if (!dev->dma_parms)
+		dev->dma_parms = kzalloc(sizeof(*dev->dma_parms), GFP_KERNEL);
+	if (!dev->dma_parms)
+		return -ENOMEM;
+
+	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
+	return 0;
+}
+
+static inline void clear_dma_max_seg_size(struct device *dev)
+{
+	kfree(dev->dma_parms);
+	dev->dma_parms = NULL;
+}
+
 /*
  * drm_create_iommu_mapping - create a mapping structure
  *
@@ -28,38 +43,48 @@
  */
 int drm_create_iommu_mapping(struct drm_device *drm_dev)
 {
-	struct dma_iommu_mapping *mapping = NULL;
 	struct exynos_drm_private *priv = drm_dev->dev_private;
+	struct device *dev = to_dma_dev(drm_dev);
+	int ret;
 
 	if (!priv->da_start)
 		priv->da_start = EXYNOS_DEV_ADDR_START;
 	if (!priv->da_space_size)
 		priv->da_space_size = EXYNOS_DEV_ADDR_SIZE;
 
-	mapping = arm_iommu_create_mapping(&platform_bus_type, priv->da_start,
-						priv->da_space_size);
+	priv->domain = iommu_domain_alloc(dev->bus);
+	if (!priv->domain)
+		return -ENOMEM;
 
-	if (IS_ERR(mapping))
-		return PTR_ERR(mapping);
+	ret = iommu_get_dma_cookie(priv->domain);
+	if (ret)
+		goto free_domain;
 
-	priv->mapping = mapping;
+	ret = iommu_dma_init_domain(priv->domain, priv->da_start,
+				    priv->da_space_size);
+	if (ret)
+		goto put_cookie;
 
 	return 0;
+
+put_cookie:
+	iommu_put_dma_cookie(priv->domain);
+free_domain:
+	iommu_domain_free(priv->domain);
+	return ret;
 }
 
 /*
  * drm_release_iommu_mapping - release iommu mapping structure
  *
  * @drm_dev: DRM device
- *
- * if mapping->kref becomes 0 then all things related to iommu mapping
- * will be released
  */
 void drm_release_iommu_mapping(struct drm_device *drm_dev)
 {
 	struct exynos_drm_private *priv = drm_dev->dev_private;
 
-	arm_iommu_release_mapping(priv->mapping);
+	iommu_put_dma_cookie(priv->domain);
+	iommu_domain_free(priv->domain);
 }
 
 /*
@@ -75,29 +100,25 @@ int drm_iommu_attach_device(struct drm_device *drm_dev,
 				struct device *subdrv_dev)
 {
 	struct exynos_drm_private *priv = drm_dev->dev_private;
+	struct device *dev = to_dma_dev(drm_dev);
+	struct iommu_domain *domain = priv->domain;
 	int ret;
 
-	if (!priv->mapping)
-		return 0;
-
-	subdrv_dev->dma_parms = devm_kzalloc(subdrv_dev,
-					sizeof(*subdrv_dev->dma_parms),
-					GFP_KERNEL);
-	if (!subdrv_dev->dma_parms)
-		return -ENOMEM;
-
-	dma_set_max_seg_size(subdrv_dev, 0xffffffffu);
-
-	if (subdrv_dev->archdata.mapping)
-		arm_iommu_detach_device(subdrv_dev);
+	if (get_dma_ops(dev) != get_dma_ops(subdrv_dev)) {
+		DRM_ERROR("Device %s lacks support for IOMMU\n",
+			  dev_name(subdrv_dev));
+		return -EINVAL;
+	}
 
-	ret = arm_iommu_attach_device(subdrv_dev, priv->mapping);
-	if (ret < 0) {
-		DRM_DEBUG_KMS("failed iommu attach.\n");
+	ret = configure_dma_max_seg_size(subdrv_dev);
+	if (ret)
 		return ret;
-	}
 
-	return 0;
+	ret = iommu_attach_device(domain, subdrv_dev);
+	if (ret != 0)
+		clear_dma_max_seg_size(subdrv_dev);
+
+	return ret;
 }
 
 /*
@@ -113,10 +134,8 @@ void drm_iommu_detach_device(struct drm_device *drm_dev,
 				struct device *subdrv_dev)
 {
 	struct exynos_drm_private *priv = drm_dev->dev_private;
-	struct dma_iommu_mapping *mapping = priv->mapping;
-
-	if (!mapping || !mapping->domain)
-		return;
+	struct iommu_domain *domain = priv->domain;
 
-	arm_iommu_detach_device(subdrv_dev);
+	iommu_detach_device(domain, subdrv_dev);
+	clear_dma_max_seg_size(subdrv_dev);
 }
diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.h b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
index c1584f24d23d..8318ebe2de6d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
@@ -30,7 +30,7 @@ void drm_iommu_detach_device(struct drm_device *dev_dev,
 static inline bool is_drm_iommu_supported(struct drm_device *drm_dev)
 {
 	struct exynos_drm_private *priv = drm_dev->dev_private;
-	return priv->mapping ? true : false;
+	return priv->domain ? true : false;
 }
 
 #else
-- 
1.9.2
