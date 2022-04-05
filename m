Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6E2C433F5
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 14:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65EB74053E;
	Tue,  5 Apr 2022 14:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2BKKTV584YnS; Tue,  5 Apr 2022 14:33:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 233F040525;
	Tue,  5 Apr 2022 14:33:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECE01C001D;
	Tue,  5 Apr 2022 14:33:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B08B6C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 14:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89241401B2
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 14:33:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rXaZjDnlqetR for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 14:32:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDAE0415C8
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 14:32:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E0A623A;
 Tue,  5 Apr 2022 07:32:56 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AB513F5A1;
 Tue,  5 Apr 2022 07:32:55 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: hjc@rock-chips.com,
	heiko@sntech.de
Subject: [PATCH] drm/rockchip: Refactor IOMMU initialisation
Date: Tue,  5 Apr 2022 15:32:50 +0100
Message-Id: <94eee7ab434fe11eb0787f691e9f1ab03a2e91be.1649168685.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 s.hauer@pengutronix.de, dri-devel@lists.freedesktop.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Defer the IOMMU domain setup until after successfully binding
components, so we can figure out IOMMU support directly from the VOP
devices themselves, rather than manually inferring it from the DT (which
also fails to account for whether the IOMMU driver is actually loaded).
Although this is somewhat of a logical cleanup, the main motivation is
to prepare for a change in the iommu_domain_alloc() interface.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Lightly tested on RK3288. This does stand to collide with the in-flight
VOP2 driver a little, if only that that will want an equivalent
rockchip_drm_dma_init_device() call too be able to use its IOMMU. I'm
happy to help sort that out either way, it just depends on what we want
to merge first.

Thanks,
Robin.

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 60 +++++++++------------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  3 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  2 +
 3 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 4eaeb430c83a..7efd12312354 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/dma-mapping.h>
-#include <linux/dma-iommu.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
@@ -34,7 +33,6 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
-static bool is_support_iommu = true;
 static const struct drm_driver rockchip_drm_driver;
 
 /*
@@ -48,7 +46,7 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 	struct rockchip_drm_private *private = drm_dev->dev_private;
 	int ret;
 
-	if (!is_support_iommu)
+	if (!private->domain)
 		return 0;
 
 	ret = iommu_attach_device(private->domain, dev);
@@ -64,12 +62,22 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev)
 {
 	struct rockchip_drm_private *private = drm_dev->dev_private;
-	struct iommu_domain *domain = private->domain;
 
-	if (!is_support_iommu)
+	if (!private->domain)
 		return;
 
-	iommu_detach_device(domain, dev);
+	iommu_detach_device(private->domain, dev);
+}
+
+void rockchip_drm_dma_init_device(struct drm_device *drm_dev,
+				  struct device *dev)
+{
+	struct rockchip_drm_private *private = drm_dev->dev_private;
+
+	if (!device_iommu_mapped(dev))
+		private->iommu_dev = ERR_PTR(-ENODEV);
+	else if (!private->iommu_dev)
+		private->iommu_dev = dev;
 }
 
 static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
@@ -78,10 +86,10 @@ static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
 	struct iommu_domain_geometry *geometry;
 	u64 start, end;
 
-	if (!is_support_iommu)
+	if (IS_ERR_OR_NULL(private->iommu_dev))
 		return 0;
 
-	private->domain = iommu_domain_alloc(&platform_bus_type);
+	private->domain = iommu_domain_alloc(private->iommu_dev->bus);
 	if (!private->domain)
 		return -ENOMEM;
 
@@ -101,7 +109,7 @@ static void rockchip_iommu_cleanup(struct drm_device *drm_dev)
 {
 	struct rockchip_drm_private *private = drm_dev->dev_private;
 
-	if (!is_support_iommu)
+	if (!private->domain)
 		return;
 
 	drm_mm_takedown(&private->mm);
@@ -137,24 +145,24 @@ static int rockchip_drm_bind(struct device *dev)
 
 	drm_dev->dev_private = private;
 
-	ret = rockchip_drm_init_iommu(drm_dev);
-	if (ret)
-		goto err_free;
-
 	ret = drmm_mode_config_init(drm_dev);
 	if (ret)
-		goto err_iommu_cleanup;
+		goto err_free;
 
 	rockchip_drm_mode_config_init(drm_dev);
 
 	/* Try to bind all sub drivers. */
 	ret = component_bind_all(dev, drm_dev);
 	if (ret)
-		goto err_iommu_cleanup;
+		goto err_free;
+
+	ret = rockchip_drm_init_iommu(drm_dev);
+	if (ret)
+		goto err_unbind_all;
 
 	ret = drm_vblank_init(drm_dev, drm_dev->mode_config.num_crtc);
 	if (ret)
-		goto err_unbind_all;
+		goto err_iommu_cleanup;
 
 	drm_mode_config_reset(drm_dev);
 
@@ -170,10 +178,10 @@ static int rockchip_drm_bind(struct device *dev)
 	return 0;
 err_kms_helper_poll_fini:
 	drm_kms_helper_poll_fini(drm_dev);
-err_unbind_all:
-	component_unbind_all(dev, drm_dev);
 err_iommu_cleanup:
 	rockchip_iommu_cleanup(drm_dev);
+err_unbind_all:
+	component_unbind_all(dev, drm_dev);
 err_free:
 	drm_dev_put(drm_dev);
 	return ret;
@@ -342,8 +350,6 @@ static int rockchip_drm_platform_of_probe(struct device *dev)
 		return -ENODEV;
 
 	for (i = 0;; i++) {
-		struct device_node *iommu;
-
 		port = of_parse_phandle(np, "ports", i);
 		if (!port)
 			break;
@@ -353,21 +359,7 @@ static int rockchip_drm_platform_of_probe(struct device *dev)
 			continue;
 		}
 
-		iommu = of_parse_phandle(port->parent, "iommus", 0);
-		if (!iommu || !of_device_is_available(iommu)) {
-			DRM_DEV_DEBUG(dev,
-				      "no iommu attached for %pOF, using non-iommu buffers\n",
-				      port->parent);
-			/*
-			 * if there is a crtc not support iommu, force set all
-			 * crtc use non-iommu buffer.
-			 */
-			is_support_iommu = false;
-		}
-
 		found = true;
-
-		of_node_put(iommu);
 		of_node_put(port);
 	}
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 143a48330f84..008c44aef400 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -44,6 +44,7 @@ struct rockchip_crtc_state {
  */
 struct rockchip_drm_private {
 	struct iommu_domain *domain;
+	struct device *iommu_dev;
 	struct mutex mm_lock;
 	struct drm_mm mm;
 };
@@ -52,6 +53,8 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
+void rockchip_drm_dma_init_device(struct drm_device *drm_dev,
+				  struct device *dev);
 int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
 
 int rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 3e8d9e2d1b67..4c38c53e9f65 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -2175,6 +2175,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 		}
 	}
 
+	rockchip_drm_dma_init_device(drm_dev, dev);
+
 	return 0;
 
 err_disable_pm_runtime:
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
