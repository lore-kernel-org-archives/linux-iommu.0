From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 08/25] MIPS: remove the mips_dma_map_ops indirection
Date: Fri, 15 Jun 2018 13:08:37 +0200
Message-ID: <20180615110854.19253-9-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180615110854.19253-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

And use mips_default_dma_map_ops directly.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/include/asm/dma-mapping.h | 4 ++--
 arch/mips/mm/dma-default.c          | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index ebcce3e22297..f24b052ec740 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -10,7 +10,7 @@
 #include <dma-coherence.h>
 #endif
 
-extern const struct dma_map_ops *mips_dma_map_ops;
+extern const struct dma_map_ops mips_default_dma_map_ops;
 extern const struct dma_map_ops mips_swiotlb_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
@@ -18,7 +18,7 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 #ifdef CONFIG_SWIOTLB
 	return &mips_swiotlb_ops;
 #else
-	return mips_dma_map_ops;
+	return &mips_default_dma_map_ops;
 #endif
 }
 
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index f9fef0028ca2..2db6c2a6f964 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -384,7 +384,7 @@ static void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		__dma_sync_virtual(vaddr, size, direction);
 }
 
-static const struct dma_map_ops mips_default_dma_map_ops = {
+const struct dma_map_ops mips_default_dma_map_ops = {
 	.alloc = mips_dma_alloc_coherent,
 	.free = mips_dma_free_coherent,
 	.mmap = mips_dma_mmap,
@@ -399,6 +399,4 @@ static const struct dma_map_ops mips_default_dma_map_ops = {
 	.dma_supported = mips_dma_supported,
 	.cache_sync = mips_dma_cache_sync,
 };
-
-const struct dma_map_ops *mips_dma_map_ops = &mips_default_dma_map_ops;
-EXPORT_SYMBOL(mips_dma_map_ops);
+EXPORT_SYMBOL(mips_default_dma_map_ops);
-- 
2.17.1
