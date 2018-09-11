From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH,
	for-4.19] dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
	declaration
Date: Tue, 11 Sep 2018 11:00:49 +0200
Message-ID: <20180911090049.10747-1-hch@lst.de>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, paul.burton-8NJIiSa5LzA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The patch adding the infrastructure failed to actually add the symbol
declaration, oops..

Fixes: faef87723a ("dma-noncoherent: add a arch_sync_dma_for_cpu_all hook")
Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 kernel/dma/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9bd54304446f..1b1d63b3634b 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -23,6 +23,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
 	bool
 	select NEED_DMA_MAP_STATE
 
+config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+	bool
+
 config DMA_DIRECT_OPS
 	bool
 	depends on HAS_DMA
-- 
2.18.0
