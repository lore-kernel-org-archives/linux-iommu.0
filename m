From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] iommu/vt-d: constify intel_dma_ops.
Date: Tue, 13 Jun 2017 15:48:34 +0530
Message-ID: <b1e3c53042ae405bf5bf86b0c06a4ee4f74c3fc3.1497349024.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dwmw2@infradead.org, joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

File size before:
   text	   data	    bss	    dec	    hex	filename
  32765	    758	   1824	  35347	   8a13	drivers/iommu/intel-iommu.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  32925	    598	   1824	  35347	   8a13	drivers/iommu/intel-iommu.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 90ab011..de0df48 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3970,7 +3970,7 @@ static int intel_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return !dma_addr;
 }
 
-struct dma_map_ops intel_dma_ops = {
+const struct dma_map_ops intel_dma_ops = {
 	.alloc = intel_alloc_coherent,
 	.free = intel_free_coherent,
 	.map_sg = intel_map_sg,
-- 
1.9.1
