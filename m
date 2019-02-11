From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/12] dma-mapping: remove dma_mark_declared_memory_occupied
Date: Mon, 11 Feb 2019 14:35:50 +0100
Message-ID: <20190211133554.30055-9-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, x86@kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This API is not used anywhere, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API.txt   | 17 -----------------
 include/linux/dma-mapping.h |  9 ---------
 kernel/dma/coherent.c       | 23 -----------------------
 3 files changed, 49 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 78114ee63057..b9d0cba83877 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -605,23 +605,6 @@ unconditionally having removed all the required structures.  It is the
 driver's job to ensure that no parts of this memory region are
 currently in use.
 
-::
-
-	void *
-	dma_mark_declared_memory_occupied(struct device *dev,
-					  dma_addr_t device_addr, size_t size)
-
-This is used to occupy specific regions of the declared space
-(dma_alloc_coherent() will hand out the first free region it finds).
-
-device_addr is the *device* address of the region requested.
-
-size is the size (and should be a page-sized multiple).
-
-The return value will be either a pointer to the processor virtual
-address of the memory, or an error (via PTR_ERR()) if any part of the
-region is occupied.
-
 Part III - Debug drivers use of the DMA-API
 -------------------------------------------
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index fde0cfc71824..9df0f4d318c5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -735,8 +735,6 @@ static inline int dma_get_cache_alignment(void)
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size, int flags);
 void dma_release_declared_memory(struct device *dev);
-void *dma_mark_declared_memory_occupied(struct device *dev,
-					dma_addr_t device_addr, size_t size);
 #else
 static inline int
 dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
@@ -749,13 +747,6 @@ static inline void
 dma_release_declared_memory(struct device *dev)
 {
 }
-
-static inline void *
-dma_mark_declared_memory_occupied(struct device *dev,
-				  dma_addr_t device_addr, size_t size)
-{
-	return ERR_PTR(-EBUSY);
-}
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 4b76aba574c2..1d12a31af6d7 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -137,29 +137,6 @@ void dma_release_declared_memory(struct device *dev)
 }
 EXPORT_SYMBOL(dma_release_declared_memory);
 
-void *dma_mark_declared_memory_occupied(struct device *dev,
-					dma_addr_t device_addr, size_t size)
-{
-	struct dma_coherent_mem *mem = dev->dma_mem;
-	unsigned long flags;
-	int pos, err;
-
-	size += device_addr & ~PAGE_MASK;
-
-	if (!mem)
-		return ERR_PTR(-EINVAL);
-
-	spin_lock_irqsave(&mem->spinlock, flags);
-	pos = PFN_DOWN(device_addr - dma_get_device_base(dev, mem));
-	err = bitmap_allocate_region(mem->bitmap, pos, get_order(size));
-	spin_unlock_irqrestore(&mem->spinlock, flags);
-
-	if (err != 0)
-		return ERR_PTR(err);
-	return mem->virt_base + (pos << PAGE_SHIFT);
-}
-EXPORT_SYMBOL(dma_mark_declared_memory_occupied);
-
 static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
 		ssize_t size, dma_addr_t *dma_handle)
 {
-- 
2.20.1
