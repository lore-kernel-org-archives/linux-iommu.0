From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] powerpc: do not redefined NEED_DMA_MAP_STATE
Date: Mon, 30 Jul 2018 09:37:21 +0200
Message-ID: <20180730073721.15991-1-hch@lst.de>
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
To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

kernel/dma/Kconfig already defines NEED_DMA_MAP_STATE, just select it
from PPC64 and NOT_COHERENT_CACHE instead.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/powerpc/Kconfig                   | 3 ---
 arch/powerpc/platforms/Kconfig.cputype | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f2b75fe2c2d..f9cae7edd735 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -884,9 +884,6 @@ config ZONE_DMA
 	bool
 	default y
 
-config NEED_DMA_MAP_STATE
-	def_bool (PPC64 || NOT_COHERENT_CACHE)
-
 config GENERIC_ISA_DMA
 	bool
 	depends on ISA_DMA_API
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e6a1de521319..a2578bf8d560 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -3,6 +3,7 @@ config PPC64
 	bool "64-bit kernel"
 	default n
 	select ZLIB_DEFLATE
+	select NEED_DMA_MAP_STATE
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
@@ -386,6 +387,7 @@ config NOT_COHERENT_CACHE
 	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
 	default n if PPC_47x
 	default y
+	select NEED_DMA_MAP_STATE
 
 config CHECK_CACHE_COHERENCY
 	bool
-- 
2.18.0
