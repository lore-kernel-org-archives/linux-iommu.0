From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 05/22] dma-mapping: pci: add pci_(un)map_peer_resource
Date: Tue, 15 Sep 2015 12:10:50 -0500
Message-ID: <1442337067-22964-6-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Simply route these through to the new dma_(un)map_peer_resource APIs.

Also route pci_peer_mapping_error through to the new dma_peer_mapping_error
API.

Guard these new functions behind CONFIG_HAS_DMA_P2P.

Signed-off-by: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Reviewed-by: John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/asm-generic/pci-dma-compat.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
index c110843..7baf09e 100644
--- a/include/asm-generic/pci-dma-compat.h
+++ b/include/asm-generic/pci-dma-compat.h
@@ -61,6 +61,29 @@ pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
 }
 
+#ifdef CONFIG_HAS_DMA_P2P
+static inline dma_peer_addr_t
+pci_map_peer_resource(struct pci_dev *hwdev, struct pci_dev *peer,
+		      int res, unsigned long offset, size_t size,
+		      int direction)
+{
+	return dma_map_peer_resource(hwdev == NULL ? NULL : &hwdev->dev, peer == NULL ? NULL : &peer->dev, peer == NULL ? NULL : &peer->resource[res], offset, size, (enum dma_data_direction)direction);
+}
+
+static inline int
+pci_dma_peer_mapping_error(struct pci_dev *pdev, dma_peer_addr_t dma_addr)
+{
+	return dma_peer_mapping_error(&pdev->dev, dma_addr);
+}
+
+static inline void
+pci_unmap_peer_resource(struct pci_dev *hwdev, dma_peer_addr_t dma_address,
+			size_t size, int direction)
+{
+	dma_unmap_peer_resource(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
+}
+#endif
+
 static inline int
 pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 	   int nents, int direction)
-- 
2.5.1
