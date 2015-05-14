From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [RFC/PATCH 6/9] drivers: platform: Configure dma operations at probe
	time
Date: Fri, 15 May 2015 02:00:07 +0300
Message-ID: <1431644410-2997-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Configuring DMA ops at probe time will allow deferring device probe when
the IOMMU isn't available yet.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/base/platform.c | 9 +++++++++
 drivers/of/platform.c   | 7 +++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ebf034b97278..508a866859dc 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -516,6 +516,10 @@ static int platform_drv_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
+	ret = of_dma_configure_ops(_dev, _dev->of_node);
+	if (ret < 0)
+		goto done;
+
 	ret = dev_pm_domain_attach(_dev, true);
 	if (ret != -EPROBE_DEFER) {
 		ret = drv->probe(dev);
@@ -523,6 +527,10 @@ static int platform_drv_probe(struct device *_dev)
 			dev_pm_domain_detach(_dev, true);
 	}
 
+	if (ret)
+		of_dma_deconfigure(_dev);
+
+done:
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
 		dev_warn(_dev, "probe deferral not supported\n");
 		ret = -ENXIO;
@@ -544,6 +552,7 @@ static int platform_drv_remove(struct device *_dev)
 
 	ret = drv->remove(dev);
 	dev_pm_domain_detach(_dev, true);
+	of_dma_deconfigure(_dev);
 
 	return ret;
 }
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9a29f09b7723..fc939bec799e 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -178,10 +178,8 @@ static struct platform_device *of_platform_device_create_pdata(
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 	of_dma_configure_masks(&dev->dev, dev->dev.of_node);
-	of_dma_configure_ops(&dev->dev, dev->dev.of_node);
 
 	if (of_device_add(dev) != 0) {
-		of_dma_deconfigure(&dev->dev);
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
@@ -465,11 +463,12 @@ static int of_platform_device_destroy(struct device *dev, void *data)
 	if (dev->bus == &platform_bus_type)
 		platform_device_unregister(to_platform_device(dev));
 #ifdef CONFIG_ARM_AMBA
-	else if (dev->bus == &amba_bustype)
+	else if (dev->bus == &amba_bustype) {
 		amba_device_unregister(to_amba_device(dev));
+		of_dma_deconfigure(dev);
+	}
 #endif
 
-	of_dma_deconfigure(dev);
 	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 	return 0;
-- 
2.3.6
