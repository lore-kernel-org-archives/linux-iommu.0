From: <wdavis@nvidia.com>
Subject: [PATCH v3 3/7] dma-mapping: pci: add pci_(un)map_resource
Date: Fri, 29 May 2015 12:14:42 -0500
Message-ID: <1432919686-32306-4-git-send-email-wdavis@nvidia.com>
References: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Terence Ripperda <tripperda@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Jerome Glisse <jglisse@redhat.com>, Mark Hounschell <markh@compro.net>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Yijing Wang <wangyijing@huawei.com>, Alex Williamson <alex.williamson@redhat.com>, Dave Jiang <dave.jiang@intel.com>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Will Davis <wdavis@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

From: Will Davis <wdavis@nvidia.com>

Simply route these through to the new dma_(un)map_resource APIs.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/asm-generic/pci-dma-compat.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
index c110843..ac4a4ad 100644
--- a/include/asm-generic/pci-dma-compat.h
+++ b/include/asm-generic/pci-dma-compat.h
@@ -61,6 +61,20 @@ pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
 }
 
+static inline dma_addr_t
+pci_map_resource(struct pci_dev *hwdev, struct resource *resource,
+		 unsigned long offset, size_t size, int direction)
+{
+	return dma_map_resource(hwdev == NULL ? NULL : &hwdev->dev, resource, offset, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_unmap_resource(struct pci_dev *hwdev, dma_addr_t dma_address, size_t size,
+		   int direction)
+{
+	dma_unmap_resource(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
+}
+
 static inline int
 pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 	   int nents, int direction)
-- 
2.4.0
