From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] dma-mapping: remove dma_zalloc_coherent()
Date: Tue,  8 Jan 2019 08:07:01 -0500
Message-ID: <20190108130701.14161-4-hch@lst.de>
References: <20190108130701.14161-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108130701.14161-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Luis Chamberlain <mcgrof@kernel.org>

dma_zalloc_coherent() is no longer needed as it has no users because
dma_alloc_coherent() already zeroes out memory for us.

The Coccinelle grammar rule that used to check for dma_alloc_coherent()
+ memset() is modified so that it just tells the user that the memset is
not needed anymore.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h                      |  9 ---------
 scripts/coccinelle/api/alloc/alloc_cast.cocci    |  8 ++++----
 scripts/coccinelle/api/alloc/zalloc-simple.cocci | 11 +----------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index cef2127e1d70..f6ded992c183 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -717,15 +717,6 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #endif
 
-/*
- * Please always use dma_alloc_coherent instead as it already zeroes the memory!
- */
-static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
-					dma_addr_t *dma_handle, gfp_t flag)
-{
-	return dma_alloc_coherent(dev, size, dma_handle, flag);
-}
-
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
index 408ee3879f9b..18fedf7c60ed 100644
--- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
+++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
@@ -32,7 +32,7 @@ type T;
   (T *)
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
-   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
+   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
    kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
    pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
@@ -55,7 +55,7 @@ type r1.T;
 * (T *)
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
-   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
+   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
    kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
    pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
@@ -78,7 +78,7 @@ type r1.T;
 - (T *)
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
-   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
+   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
    kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
    pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
@@ -95,7 +95,7 @@ position p;
  (T@p *)
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
-   dma_alloc_coherent\|dma_zalloc_coherent\|devm_kmalloc\|devm_kzalloc\|
+   dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
    kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
    pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
index d819275b7fde..5cd1991c582e 100644
--- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
+++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
@@ -69,15 +69,6 @@ statement S;
 - x = (T)vmalloc(E1);
 + x = (T)vzalloc(E1);
 |
-- x = dma_alloc_coherent(E2,E1,E3,E4);
-+ x = dma_zalloc_coherent(E2,E1,E3,E4);
-|
-- x = (T *)dma_alloc_coherent(E2,E1,E3,E4);
-+ x = dma_zalloc_coherent(E2,E1,E3,E4);
-|
-- x = (T)dma_alloc_coherent(E2,E1,E3,E4);
-+ x = (T)dma_zalloc_coherent(E2,E1,E3,E4);
-|
 - x = kmalloc_node(E1,E2,E3);
 + x = kzalloc_node(E1,E2,E3);
 |
@@ -225,7 +216,7 @@ p << r2.p;
 x << r2.x;
 @@
 
-msg="WARNING: dma_zalloc_coherent should be used for %s, instead of dma_alloc_coherent/memset" % (x)
+msg="WARNING: dma_alloc_coherent use in %s already zeroes out memory,  so memset is not needed" % (x)
 coccilib.report.print_report(p[0], msg)
 
 //-----------------------------------------------------------------
-- 
2.20.1
