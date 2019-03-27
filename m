From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 16/21] dma-iommu: factor contiguous remapped allocations into helpers
Date: Wed, 27 Mar 2019 09:04:43 +0100
Message-ID: <20190327080448.5500-17-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This moves the last remaning non-dispatch code out of iommu_dma_alloc,
preparing to refactor the allocation method selection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index dd28452ab3c2..09b29f6093bb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -674,6 +674,29 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return NULL;
 }
 
+static void *iommu_dma_alloc_contiguous_remap(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+	struct page *page;
+	void *addr;
+
+	addr = iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
+	if (!addr)
+		return NULL;
+
+	page = virt_to_page(addr);
+	addr = dma_common_contiguous_remap(page, PAGE_ALIGN(size), VM_USERMAP,
+			prot, __builtin_return_address(0));
+	if (!addr)
+		goto out_free;
+	arch_dma_prep_coherent(page, size);
+	return addr;
+out_free:
+	iommu_dma_free_contiguous(dev, size, page, *dma_handle);
+	return NULL;
+}
+
 /**
  * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
  * @cpu_addr: virtual address of the memory to be remapped
@@ -1023,8 +1046,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	size_t iosize = size;
 	void *addr;
 
-	size = PAGE_ALIGN(size);
-
 	/*
 	 * Some drivers rely on this, and we probably don't want the
 	 * possibility of stale kernel data being read by devices anyway.
@@ -1043,23 +1064,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		return iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
 				attrs);
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page *page;
-
-		addr = iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
-				attrs);
-		if (coherent || !addr)
-			return addr;
-
-		page = virt_to_page(addr);
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
-				__builtin_return_address(0));
-		if (!addr) {
-			iommu_dma_free_contiguous(dev, iosize, page, *handle);
-			return NULL;
-		}
-
-		arch_dma_prep_coherent(page, iosize);
+		if (coherent)
+			addr = iommu_dma_alloc_contiguous(dev, iosize, handle,
+					gfp, attrs);
+		else
+			addr = iommu_dma_alloc_contiguous_remap(dev, iosize,
+					handle, gfp, attrs);
 	} else {
 		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 	}
-- 
2.20.1
