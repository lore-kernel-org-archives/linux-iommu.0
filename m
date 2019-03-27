From: =?utf-8?Q?Cl=C3=A9ment?= Leger via iommu
	<iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH resend] dma: select GENERIC_ALLOCATOR for DMA_REMAP
Date: Wed, 27 Mar 2019 14:06:27 +0100 (CET)
Message-ID: <912875890.7194899.1553691987277.JavaMail.zimbra@kalray.eu>
Reply-To: =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger-FNhOzJFKnXGHXe+LvDLADg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When DMA_REMAP is enabled, code in remap.c needs generic allocator.
It currently worked since few architectures uses it (arm64, csky) and
they both select GENERIC_ALLOCATOR. Select it when using DMA_REMAP
to have correct dependencies.

Signed-off-by: Clement Leger <clement.leger-FNhOzJFKnXGHXe+LvDLADg@public.gmane.org>
---
 kernel/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index a06ba3013b3b..6a43c4ae77f9 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -58,6 +58,7 @@ config SWIOTLB
 config DMA_REMAP
         depends on MMU
         bool
+        select GENERIC_ALLOCATOR
 
 config DMA_DIRECT_REMAP
         bool
-- 
2.15.0.276.g89ea799
