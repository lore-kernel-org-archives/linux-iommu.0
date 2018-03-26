From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 5/7] iommu/io-pgtable-arm: Support 52-bit physical address
Date: Mon, 26 Mar 2018 13:35:13 +0100
Message-ID: <9ef51e5c1264e481d885735cecdd0ae39de09d7c.1522065584.git.robin.murphy@arm.com>
References: <cover.1522065583.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1522065583.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Bring io-pgtable-arm in line with the ARMv8.2-LPA feature allowing
52-bit physical addresses when using the 64KB translation granule.
This will be supported by SMMUv3.1.

Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v3: 64K-granule-specific logic in iopte_to_paddr() makes it much more
    symmetrical with paddr_to_iopte() and generates shorter code.

    I haven't implemented explicit input masking in paddr_to_iopte()
    since I realised that if we did ever get an out-of-range address
    there, it would only make the difference between silently mapping
    the wrong address and silently mapping a slightly different wrong
    address.

    I also went to add a comment about io_pgtable_alloc() updating the
    cfg, only to find that it's been documented as such from the start.

 drivers/iommu/io-pgtable-arm.c | 67 ++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 51e5c43caed1..a5be4c92c5c8 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -21,6 +21,7 @@
 #define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
@@ -32,7 +33,7 @@
 
 #include "io-pgtable.h"
 
-#define ARM_LPAE_MAX_ADDR_BITS		48
+#define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
 #define ARM_LPAE_MAX_LEVELS		4
 
@@ -86,6 +87,8 @@
 #define ARM_LPAE_PTE_TYPE_TABLE		3
 #define ARM_LPAE_PTE_TYPE_PAGE		3
 
+#define ARM_LPAE_PTE_ADDR_MASK		GENMASK_ULL(47,12)
+
 #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
 #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
 #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
@@ -159,6 +162,7 @@
 #define ARM_LPAE_TCR_PS_42_BIT		0x3ULL
 #define ARM_LPAE_TCR_PS_44_BIT		0x4ULL
 #define ARM_LPAE_TCR_PS_48_BIT		0x5ULL
+#define ARM_LPAE_TCR_PS_52_BIT		0x6ULL
 
 #define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)
 #define ARM_LPAE_MAIR_ATTR_MASK		0xff
@@ -170,9 +174,7 @@
 #define ARM_LPAE_MAIR_ATTR_IDX_DEV	2
 
 /* IOPTE accessors */
-#define iopte_deref(pte,d)					\
-	(__va((pte) & ((1ULL << ARM_LPAE_MAX_ADDR_BITS) - 1)	\
-	& ~(ARM_LPAE_GRANULE(d) - 1ULL)))
+#define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
 #define iopte_type(pte,l)					\
 	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
@@ -184,12 +186,6 @@
 		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE) :	\
 		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK))
 
-#define iopte_to_pfn(pte,d)					\
-	(((pte) & ((1ULL << ARM_LPAE_MAX_ADDR_BITS) - 1)) >> (d)->pg_shift)
-
-#define pfn_to_iopte(pfn,d)					\
-	(((pfn) << (d)->pg_shift) & ((1ULL << ARM_LPAE_MAX_ADDR_BITS) - 1))
-
 struct arm_lpae_io_pgtable {
 	struct io_pgtable	iop;
 
@@ -203,6 +199,27 @@ struct arm_lpae_io_pgtable {
 
 typedef u64 arm_lpae_iopte;
 
+static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
+				     struct arm_lpae_io_pgtable *data)
+{
+	arm_lpae_iopte pte = paddr;
+
+	/* Of the bits which overlap, either 51:48 or 15:12 are always RES0 */
+	return (pte | (pte >> (48 - 12))) & ARM_LPAE_PTE_ADDR_MASK;
+}
+
+static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
+				  struct arm_lpae_io_pgtable *data)
+{
+	phys_addr_t paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
+
+	if (data->pg_shift < 16)
+		return paddr;
+
+	/* Rotate the packed high-order bits back to the top */
+	return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK << 4);
+}
+
 static bool selftest_running = false;
 
 static dma_addr_t __arm_lpae_dma_addr(void *pages)
@@ -287,7 +304,7 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
 	pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
-	pte |= pfn_to_iopte(paddr >> data->pg_shift, data);
+	pte |= paddr_to_iopte(paddr, data);
 
 	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
 }
@@ -528,7 +545,7 @@ static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 	if (size == split_sz)
 		unmap_idx = ARM_LPAE_LVL_IDX(iova, lvl, data);
 
-	blk_paddr = iopte_to_pfn(blk_pte, data) << data->pg_shift;
+	blk_paddr = iopte_to_paddr(blk_pte, data);
 	pte = iopte_prot(blk_pte);
 
 	for (i = 0; i < tablesz / sizeof(pte); i++, blk_paddr += split_sz) {
@@ -652,12 +669,13 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 
 found_translation:
 	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
-	return ((phys_addr_t)iopte_to_pfn(pte,data) << data->pg_shift) | iova;
+	return iopte_to_paddr(pte, data) | iova;
 }
 
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
-	unsigned long granule;
+	unsigned long granule, page_sizes;
+	unsigned int max_addr_bits = 48;
 
 	/*
 	 * We need to restrict the supported page sizes to match the
@@ -677,17 +695,24 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 
 	switch (granule) {
 	case SZ_4K:
-		cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
+		page_sizes = (SZ_4K | SZ_2M | SZ_1G);
 		break;
 	case SZ_16K:
-		cfg->pgsize_bitmap &= (SZ_16K | SZ_32M);
+		page_sizes = (SZ_16K | SZ_32M);
 		break;
 	case SZ_64K:
-		cfg->pgsize_bitmap &= (SZ_64K | SZ_512M);
+		max_addr_bits = 52;
+		page_sizes = (SZ_64K | SZ_512M);
+		if (cfg->oas > 48)
+			page_sizes |= 1ULL << 42; /* 4TB */
 		break;
 	default:
-		cfg->pgsize_bitmap = 0;
+		page_sizes = 0;
 	}
+
+	cfg->pgsize_bitmap &= page_sizes;
+	cfg->ias = min(cfg->ias, max_addr_bits);
+	cfg->oas = min(cfg->oas, max_addr_bits);
 }
 
 static struct arm_lpae_io_pgtable *
@@ -784,6 +809,9 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	case 48:
 		reg |= (ARM_LPAE_TCR_PS_48_BIT << ARM_LPAE_TCR_IPS_SHIFT);
 		break;
+	case 52:
+		reg |= (ARM_LPAE_TCR_PS_52_BIT << ARM_LPAE_TCR_IPS_SHIFT);
+		break;
 	default:
 		goto out_free_data;
 	}
@@ -891,6 +919,9 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	case 48:
 		reg |= (ARM_LPAE_TCR_PS_48_BIT << ARM_LPAE_TCR_PS_SHIFT);
 		break;
+	case 52:
+		reg |= (ARM_LPAE_TCR_PS_52_BIT << ARM_LPAE_TCR_PS_SHIFT);
+		break;
 	default:
 		goto out_free_data;
 	}
-- 
2.16.1.dirty
