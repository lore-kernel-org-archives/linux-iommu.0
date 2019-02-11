From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] dma-mapping: Move debug configuration options to kernel/dma
Date: Mon, 11 Feb 2019 18:12:30 +0200
Message-ID: <20190211161230.85281-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig <hch@lst.de>
List-Id: iommu@lists.linux-foundation.org

This is a follow up to the commit cf65a0f6f6ff

  ("dma-mapping: move all DMA mapping code to kernel/dma")

which moved source code of DMA API to kernel/dma folder. Since there is
no file left in the lib that require DMA API debugging options move the
latter to kernel/dma as well.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: Move to kernel/dma/Kconfig directly

 kernel/dma/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug  | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index ca88b867e7fe..61cebea36d89 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -53,3 +53,39 @@ config DMA_REMAP
 config DMA_DIRECT_REMAP
 	bool
 	select DMA_REMAP
+
+config DMA_API_DEBUG
+	bool "Enable debugging of DMA-API usage"
+	select NEED_DMA_MAP_STATE
+	help
+	  Enable this option to debug the use of the DMA API by device drivers.
+	  With this option you will be able to detect common bugs in device
+	  drivers like double-freeing of DMA mappings or freeing mappings that
+	  were never allocated.
+
+	  This also attempts to catch cases where a page owned by DMA is
+	  accessed by the cpu in a way that could cause data corruption.  For
+	  example, this enables cow_user_page() to check that the source page is
+	  not undergoing DMA.
+
+	  This option causes a performance degradation.  Use only if you want to
+	  debug device drivers and dma interactions.
+
+	  If unsure, say N.
+
+config DMA_API_DEBUG_SG
+	bool "Debug DMA scatter-gather usage"
+	default y
+	depends on DMA_API_DEBUG
+	help
+	  Perform extra checking that callers of dma_map_sg() have respected the
+	  appropriate segment length/boundary limits for the given device when
+	  preparing DMA scatterlists.
+
+	  This is particularly likely to have been overlooked in cases where the
+	  dma_map_sg() API is used for general bulk mapping of pages rather than
+	  preparing literal scatter-gather descriptors, where there is a risk of
+	  unexpected behaviour from DMA API implementations if the scatterlist
+	  is technically out-of-spec.
+
+	  If unsure, say N.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..ef5d7c08e5b9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1655,42 +1655,6 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
-config DMA_API_DEBUG
-	bool "Enable debugging of DMA-API usage"
-	select NEED_DMA_MAP_STATE
-	help
-	  Enable this option to debug the use of the DMA API by device drivers.
-	  With this option you will be able to detect common bugs in device
-	  drivers like double-freeing of DMA mappings or freeing mappings that
-	  were never allocated.
-
-	  This also attempts to catch cases where a page owned by DMA is
-	  accessed by the cpu in a way that could cause data corruption.  For
-	  example, this enables cow_user_page() to check that the source page is
-	  not undergoing DMA.
-
-	  This option causes a performance degradation.  Use only if you want to
-	  debug device drivers and dma interactions.
-
-	  If unsure, say N.
-
-config DMA_API_DEBUG_SG
-	bool "Debug DMA scatter-gather usage"
-	default y
-	depends on DMA_API_DEBUG
-	help
-	  Perform extra checking that callers of dma_map_sg() have respected the
-	  appropriate segment length/boundary limits for the given device when
-	  preparing DMA scatterlists.
-
-	  This is particularly likely to have been overlooked in cases where the
-	  dma_map_sg() API is used for general bulk mapping of pages rather than
-	  preparing literal scatter-gather descriptors, where there is a risk of
-	  unexpected behaviour from DMA API implementations if the scatterlist
-	  is technically out-of-spec.
-
-	  If unsure, say N.
-
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	def_bool y
-- 
2.20.1
