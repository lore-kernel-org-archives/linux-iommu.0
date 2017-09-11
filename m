From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] iommu: QCOM_IOMMU should depend on HAS_DMA
Date: Mon, 11 Sep 2017 14:34:34 +0200
Message-ID: <1505133274-25669-1-git-send-email-geert@linux-m68k.org>
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
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

If NO_DMA=y:

    warning: (IPMMU_VMSA && ARM_SMMU && ARM_SMMU_V3 && QCOM_IOMMU) selects IOMMU_IO_PGTABLE_LPAE which has unmet direct dependencies (IOMMU_SUPPORT && HAS_DMA && (ARM || ARM64 || COMPILE_TEST && !GENERIC_ATOMIC64))

and

    drivers/iommu/io-pgtable-arm.o: In function `__arm_lpae_sync_pte':
    io-pgtable-arm.c:(.text+0x206): undefined reference to `bad_dma_ops'
    drivers/iommu/io-pgtable-arm.o: In function `__arm_lpae_free_pages':
    io-pgtable-arm.c:(.text+0x6a6): undefined reference to `bad_dma_ops'
    drivers/iommu/io-pgtable-arm.o: In function `__arm_lpae_alloc_pages':
    io-pgtable-arm.c:(.text+0x812): undefined reference to `bad_dma_ops'
    io-pgtable-arm.c:(.text+0x81c): undefined reference to `bad_dma_ops'
    io-pgtable-arm.c:(.text+0x862): undefined reference to `bad_dma_ops'
    drivers/iommu/io-pgtable-arm.o: In function `arm_lpae_run_tests':
    io-pgtable-arm.c:(.init.text+0x86): undefined reference to `alloc_io_pgtable_ops'
    io-pgtable-arm.c:(.init.text+0x47c): undefined reference to `free_io_pgtable_ops'
    drivers/iommu/qcom_iommu.o: In function `qcom_iommu_init_domain':
    qcom_iommu.c:(.text+0x1ce): undefined reference to `alloc_io_pgtable_ops'
    drivers/iommu/qcom_iommu.o: In function `qcom_iommu_domain_free':
    qcom_iommu.c:(.text+0x754): undefined reference to `free_io_pgtable_ops'

QCOM_IOMMU selects IOMMU_IO_PGTABLE_LPAE, which bypasses its dependency
on HAS_DMA.  Make QCOM_IOMMU depend on HAS_DMA to fix this.

Fixes: 0ae349a0f33fb040 ("iommu/qcom: Add qcom_iommu")
Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 49bd2ab8c5075859..8c6a910a532e1c17 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -373,6 +373,7 @@ config MTK_IOMMU_V1
 config QCOM_IOMMU
 	# Note: iommu drivers cannot (yet?) be built as modules
 	bool "Qualcomm IOMMU Support"
+	depends on HAS_DMA
 	depends on ARCH_QCOM || COMPILE_TEST
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
-- 
2.7.4
