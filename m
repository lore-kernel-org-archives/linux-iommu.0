From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V5 04/12] of: dma: Make of_dma_deconfigure() public
Date: Thu, 19 Jan 2017 20:35:48 +0530
Message-ID: <1484838356-24962-5-git-send-email-sricharan@codeaurora.org>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484838356-24962-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

As part of moving DMA initializing to probe time the
of_dma_deconfigure() function will need to be called from different
source files. Make it public and move it to drivers/of/device.c where
the of_dma_configure() function is.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 * No change

 drivers/of/device.c       | 12 ++++++++++++
 drivers/of/platform.c     |  5 -----
 include/linux/of_device.h |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index d9898d9..1c843e2 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -136,6 +136,18 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
 
+/**
+ * of_dma_deconfigure - Clean up DMA configuration
+ * @dev:	Device for which to clean up DMA configuration
+ *
+ * Clean up all configuration performed by of_dma_configure_ops() and free all
+ * resources that have been allocated.
+ */
+void of_dma_deconfigure(struct device *dev)
+{
+	arch_teardown_dma_ops(dev);
+}
+
 int of_device_register(struct platform_device *pdev)
 {
 	device_initialize(&pdev->dev);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b8064bc..57418f7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -158,11 +158,6 @@ struct platform_device *of_device_alloc(struct device_node *np,
 }
 EXPORT_SYMBOL(of_device_alloc);
 
-static void of_dma_deconfigure(struct device *dev)
-{
-	arch_teardown_dma_ops(dev);
-}
-
 /**
  * of_platform_device_create_pdata - Alloc, initialize and register an of_device
  * @np: pointer to node to create device for
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index cc7dd687..d20a31a 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -56,6 +56,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 }
 
 void of_dma_configure(struct device *dev, struct device_node *np);
+void of_dma_deconfigure(struct device *dev);
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -100,6 +101,8 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 }
 static inline void of_dma_configure(struct device *dev, struct device_node *np)
 {}
+static inline void of_dma_deconfigure(struct device *dev)
+{}
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
