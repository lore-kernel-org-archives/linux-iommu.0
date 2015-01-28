From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] iommu: disable on !MMU builds
Date: Wed, 28 Jan 2015 15:45:53 +0100
Message-ID: <1685569.C1Ne1erBMA@wuerfel>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

A lot of the IOMMU support code does not build if the CPU does
not have an MMU itself, and it's not clear if there is any
use case for it, so let's just disable it and wait for anybody
to need it.

This avoids randconfig errors like

../arch/arm/mm/dma-mapping.c: In function '__iommu_alloc_remap':
../arch/arm/mm/dma-mapping.c:1278:34: error: 'VM_ARM_DMA_CONSISTENT' undeclared (first use in this function)
  area = get_vm_area_caller(size, VM_ARM_DMA_CONSISTENT | VM_USERMAP,
                                  ^
../arch/arm/mm/dma-mapping.c:1278:34: note: each undeclared identifier is reported only once for each function it appears in
../arch/arm/mm/dma-mapping.c: In function '__atomic_get_pages':
../arch/arm/mm/dma-mapping.c:1358:27: error: 'atomic_pool' undeclared (first use in this function)
  struct dma_pool *pool = &atomic_pool;

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c68c8db0e6f7..089da97d7c6b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -4,6 +4,7 @@ config IOMMU_API
 
 menuconfig IOMMU_SUPPORT
 	bool "IOMMU Hardware Support"
+	depends on MMU
 	default y
 	---help---
 	  Say Y here if you want to compile device drivers for IO Memory
@@ -170,7 +171,7 @@ config IRQ_REMAP
 # OMAP IOMMU support
 config OMAP_IOMMU
 	bool "OMAP IOMMU Support"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS && MMU
 	select IOMMU_API
 
 config OMAP_IOMMU_DEBUG
@@ -217,7 +218,7 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS && ARM
+	depends on ARCH_EXYNOS && ARM && MMU
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
 	help
@@ -246,7 +247,7 @@ config SHMOBILE_IPMMU_TLB
 config SHMOBILE_IOMMU
 	bool "IOMMU for Renesas IPMMU/IPMMUI"
 	default n
-	depends on ARM
+	depends on ARM && MMU
 	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
@@ -336,6 +337,7 @@ config SPAPR_TCE_IOMMU
 config ARM_SMMU
 	bool "ARM Ltd. System MMU (SMMU) Support"
 	depends on ARM64 || ARM
+	depends on MMU
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
