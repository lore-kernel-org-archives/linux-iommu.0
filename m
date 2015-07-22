From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 04/12] DMA-API: Introduce dma_(un)map_peer_resource
Date: Wed, 22 Jul 2015 16:39:49 -0500
Message-ID: <1437601197-6481-5-git-send-email-wdavis@nvidia.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437601197-6481-1-git-send-email-wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "David S.
	Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add functions to DMA-map and -unmap a peer device's resource for a given
device. This will allow devices to DMA-map, for example, another device's
BAR region on PCI to enable peer-to-peer transactions.

Guard these new functions behind CONFIG_HAS_DMA_P2P.

Signed-off-by: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/asm-generic/dma-mapping-common.h | 43 ++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h              | 12 +++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index 940d5ec..45eec17 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -73,6 +73,42 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
+#ifdef CONFIG_HAS_DMA_P2P
+static inline dma_peer_addr_t dma_map_peer_resource_attrs(struct device *dev,
+							  struct device *peer,
+							  struct resource *res,
+							  size_t offset,
+							  size_t size,
+							  enum dma_data_direction dir,
+							  struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	dma_peer_addr_t addr;
+
+	BUG_ON(!valid_dma_direction(dir));
+	BUG_ON(ops->map_peer_resource == NULL);
+	addr = ops->map_peer_resource(dev, peer, res, offset, size, dir,
+				      attrs);
+	debug_dma_map_peer_resource(dev, peer, res, offset, size, dir, addr);
+
+	return addr;
+}
+
+static inline void dma_unmap_peer_resource_attrs(struct device *dev,
+						 dma_peer_addr_t addr,
+						 size_t size,
+						 enum dma_data_direction dir,
+						 struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops->unmap_peer_resource)
+		ops->unmap_peer_resource(dev, addr, size, dir, attrs);
+	debug_dma_unmap_peer_resource(dev, addr, size, dir);
+}
+#endif
+
 static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      enum dma_data_direction dir)
@@ -181,6 +217,13 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
 
+#ifdef CONFIG_HAS_DMA_P2P
+#define dma_map_peer_resource(d, p, e, o, s, r) \
+	dma_map_peer_resource_attrs(d, p, e, o, s, r, NULL)
+#define dma_unmap_peer_resource(d, a, s, r) \
+	dma_unmap_peer_resource_attrs(d, a, s, r, NULL)
+#endif
+
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac07ff0..7b8fddc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -34,6 +34,18 @@ struct dma_map_ops {
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			   size_t size, enum dma_data_direction dir,
 			   struct dma_attrs *attrs);
+#ifdef CONFIG_HAS_DMA_P2P
+	dma_peer_addr_t (*map_peer_resource)(struct device *dev,
+					     struct device *peer,
+					     struct resource *res,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir,
+					     struct dma_attrs *attrs);
+	void (*unmap_peer_resource)(struct device *dev,
+				    dma_peer_addr_t dma_handle,
+				    size_t size, enum dma_data_direction dir,
+				    struct dma_attrs *attrs);
+#endif
 	/*
 	 * map_sg returns 0 on error and a value > 0 on success.
 	 * It should never return a value < 0.
-- 
2.4.6
