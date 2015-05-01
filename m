From: <wdavis@nvidia.com>
Subject: [PATCH 6/6] x86: add pci-nommu implementation of map_resource
Date: Fri, 1 May 2015 13:32:18 -0500
Message-ID: <1430505138-2877-7-git-send-email-wdavis@nvidia.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, tripperda@nvidia.com, jhubbard@nvidia.com, jglisse@redhat.com, Will Davis <wdavis@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

From: Will Davis <wdavis@nvidia.com>

Simply pass through the physical address as the DMA address.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 arch/x86/kernel/pci-nommu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index da15918..6e9e66d 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -38,6 +38,22 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	return bus;
 }
 
+static dma_addr_t nommu_map_resource(struct device *dev, struct resource *res,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir,
+				     struct dma_attrs *attrs)
+{
+	dma_addr_t bus = res->start + offset;
+
+	WARN_ON(size == 0);
+
+	if (!check_addr("map_resource", dev, bus, size))
+		return DMA_ERROR_CODE;
+	flush_write_buffers();
+	return bus;
+}
+
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scatter-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -93,6 +109,7 @@ struct dma_map_ops nommu_dma_ops = {
 	.free			= dma_generic_free_coherent,
 	.map_sg			= nommu_map_sg,
 	.map_page		= nommu_map_page,
+	.map_resource		= nommu_map_resource,
 	.sync_single_for_device = nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 	.is_phys		= 1,
-- 
2.3.7
