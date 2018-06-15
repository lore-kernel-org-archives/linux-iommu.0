From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 22/25] dma-noncoherent: add a arch_sync_dma_for_cpu_all hook
Date: Fri, 15 Jun 2018 13:08:51 +0200
Message-ID: <20180615110854.19253-23-hch@lst.de>
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

The MIPS bmips platform needs a global flush when transferring ownership
back to the CPU.  Add a hook for that to the dma-noncoherent
implementation.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 include/linux/dma-noncoherent.h | 8 ++++++++
 lib/dma-noncoherent.c           | 8 ++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 10b2654d549b..a0aa00cc909d 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -44,4 +44,12 @@ static inline void arch_sync_dma_for_cpu(struct device *dev,
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+void arch_sync_dma_for_cpu_all(struct device *dev);
+#else
+static inline void arch_sync_dma_for_cpu_all(struct device *dev)
+{
+}
+#endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
+
 #endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/lib/dma-noncoherent.c b/lib/dma-noncoherent.c
index 79e9a757387f..031fe235d958 100644
--- a/lib/dma-noncoherent.c
+++ b/lib/dma-noncoherent.c
@@ -49,11 +49,13 @@ static int dma_noncoherent_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 static void dma_noncoherent_sync_single_for_cpu(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
 	arch_sync_dma_for_cpu(dev, dma_to_phys(dev, addr), size, dir);
+	arch_sync_dma_for_cpu_all(dev);
 }
 
 static void dma_noncoherent_sync_sg_for_cpu(struct device *dev,
@@ -64,6 +66,7 @@ static void dma_noncoherent_sync_sg_for_cpu(struct device *dev,
 
 	for_each_sg(sgl, sg, nents, i)
 		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+	arch_sync_dma_for_cpu_all(dev);
 }
 
 static void dma_noncoherent_unmap_page(struct device *dev, dma_addr_t addr,
@@ -89,7 +92,8 @@ const struct dma_map_ops dma_noncoherent_ops = {
 	.sync_sg_for_device	= dma_noncoherent_sync_sg_for_device,
 	.map_page		= dma_noncoherent_map_page,
 	.map_sg			= dma_noncoherent_map_sg,
-#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	.sync_single_for_cpu	= dma_noncoherent_sync_single_for_cpu,
 	.sync_sg_for_cpu	= dma_noncoherent_sync_sg_for_cpu,
 	.unmap_page		= dma_noncoherent_unmap_page,
-- 
2.17.1
