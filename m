From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V3 3/8] of: dma: Make of_dma_deconfigure() public
Date: Tue,  4 Oct 2016 22:33:47 +0530
Message-ID: <1475600632-21289-4-git-send-email-sricharan@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, laurent.pinchart@ideasonboard.com, m.szyprowski@samsung.com, tfiga@chromium.org, srinivas.kandagatla@linaro.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

As part of moving DMA initializing to probe time the
of_dma_deconfigure() function will need to be called from different
source files. Make it public and move it to drivers/of/device.c where
the of_dma_configure() function is.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
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
index f39ccd5..9cb7090 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -153,11 +153,6 @@ struct platform_device *of_device_alloc(struct device_node *np,
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
