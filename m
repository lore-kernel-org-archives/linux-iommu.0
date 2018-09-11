From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/2] dma-mapping: introduce helper for setting dma_parms
Date: Tue, 11 Sep 2018 18:30:49 +0200
Message-ID: <20180911163050.28072-2-wsa+renesas@sang-engineering.com>
References: <20180911163050.28072-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911163050.28072-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
Cc: linux-renesas-soc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: iommu@lists.linux-foundation.org

Setting up dma_parms seems not so trivial because it is easy to miss
that its pointer has the life cycle of its containing 'struct device'
while the allocation of dma_parms usually happens during the bind/unbind
life cycle. Which can lead to dangling pointers.
If coding this correctly in drivers, this results in boilerplate code.
So, this patch adds a devm_* style helper which is easy to use and make
sure the allocation and the pointer are always handled at the same time.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/dma-mapping.h |  5 ++++
 kernel/dma/mapping.c        | 50 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 1db6a6b46d0d..05a525b4639b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -700,6 +700,11 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
+extern int dmam_set_dma_parms(struct device *dev, unsigned int max_seg_size,
+			      unsigned long seg_bound_mask);
+
+extern void dmam_free_dma_parms(struct device *dev);
+
 #ifndef dma_max_pfn
 static inline unsigned long dma_max_pfn(struct device *dev)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d2a92ddaac4d..082cc651513b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -198,6 +198,56 @@ EXPORT_SYMBOL(dmam_release_declared_memory);
 
 #endif
 
+static void dmam_release_dma_parms(struct device *dev, void *res)
+{
+	dev->dma_parms = NULL;
+}
+
+static int dmam_match_dma_parms(struct device *dev, void *res, void *data)
+{
+	return res == data;
+}
+
+/**
+ * dmam_set_dma_parms - Managed setting of dma_parms
+ * @dev: device to set dma_parms for
+ * @max_seg_size: the maximum segment size for this device
+ * @seg_bound_mask: the segment boundary mask for this device
+ *
+ * RETURNS:
+ * 0 on success, errno on failure.
+ */
+int dmam_set_dma_parms(struct device *dev, unsigned int max_seg_size,
+		       unsigned long seg_bound_mask)
+{
+	struct device_dma_parameters *parms;
+
+	parms = devres_alloc(dmam_release_dma_parms,
+			     sizeof(struct device_dma_parameters), GFP_KERNEL);
+	if (!parms)
+		return -ENOMEM;
+
+	dev->dma_parms = parms;
+	dma_set_max_seg_size(dev, max_seg_size);
+	dma_set_seg_boundary(dev, seg_bound_mask);
+
+	devres_add(dev, parms);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dmam_set_dma_parms);
+
+/**
+ * dmam_free_dma_parms - free dma_parms allocated with dmam_set_dma_parms
+ * @dev: device with dma_parms allocated by dmam_set_dma_parms()
+ */
+void dmam_free_dma_parms(struct device *dev)
+{
+	int rc = devres_destroy(dev, dmam_release_dma_parms, dmam_match_dma_parms,
+				dev->dma_parms);
+	WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(dmam_free_dma_parms);
+
 /*
  * Create scatter-list for the already allocated DMA buffer.
  */
-- 
2.18.0
