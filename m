From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/4] dma-mapping: remove dma_configure
Date: Mon, 27 Aug 2018 10:47:09 +0200
Message-ID: <20180827084711.23407-3-hch@lst.de>
References: <20180827084711.23407-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827084711.23407-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

There is no good reason for this indirection given that the method
always exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/dd.c           |  8 +++++---
 include/linux/dma-mapping.h |  6 ------
 kernel/dma/mapping.c        | 10 ----------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index edfc9f0b1180..65128cf8427c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -480,9 +480,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (ret)
 		goto pinctrl_bind_failed;
 
-	ret = dma_configure(dev);
-	if (ret)
-		goto dma_failed;
+	if (dev->bus->dma_configure) {
+		ret = dev->bus->dma_configure(dev);
+		if (ret)
+			goto dma_failed;
+	}
 
 	if (driver_sysfs_add(dev)) {
 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 1db6a6b46d0d..1c6c7c09bcf2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -754,14 +754,8 @@ dma_mark_declared_memory_occupied(struct device *dev,
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
 #ifdef CONFIG_HAS_DMA
-int dma_configure(struct device *dev);
 void dma_deconfigure(struct device *dev);
 #else
-static inline int dma_configure(struct device *dev)
-{
-	return 0;
-}
-
 static inline void dma_deconfigure(struct device *dev) {}
 #endif
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d2a92ddaac4d..25607ceb4a50 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -328,16 +328,6 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 }
 #endif
 
-/*
- * enables DMA API use for a device
- */
-int dma_configure(struct device *dev)
-{
-	if (dev->bus->dma_configure)
-		return dev->bus->dma_configure(dev);
-	return 0;
-}
-
 void dma_deconfigure(struct device *dev)
 {
 	of_dma_deconfigure(dev);
-- 
2.18.0
