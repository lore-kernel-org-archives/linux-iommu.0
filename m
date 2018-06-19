From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/io-pgtable-arm-v7s: Abort allocation when table address
	overflows the PTE
Date: Tue, 19 Jun 2018 13:52:24 +0100
Message-ID: <20180619125224.1008-1-jean-philippe.brucker@arm.com>
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
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When run on a 64-bit system in selftest, the v7s driver may obtain page
table with physical addresses larger than 32-bit. Level-2 tables are 1KB
and are are allocated with slab, which doesn't accept the GFP_DMA32
flag. Currently map() truncates the address written in the PTE, causing
iova_to_phys() or unmap() to access invalid memory. Kasan reports it as
a use-after-free. To avoid any nasty surprise, test if the physical
address fits in a PTE before returning a new table. 32-bit systems,
which are the main users of this page table format, shouldn't see any
difference.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 50e3a9fcf43e..b5948ba6b3b3 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -192,6 +192,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 {
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	struct device *dev = cfg->iommu_dev;
+	phys_addr_t phys;
 	dma_addr_t dma;
 	size_t size = ARM_V7S_TABLE_SIZE(lvl);
 	void *table = NULL;
@@ -200,6 +201,10 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
 	else if (lvl == 2)
 		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
+	phys = virt_to_phys(table);
+	if (phys != (arm_v7s_iopte)phys)
+		/* Doesn't fit in PTE */
+		goto out_free;
 	if (table && !(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
 		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
@@ -209,7 +214,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		 * address directly, so if the DMA layer suggests otherwise by
 		 * translating or truncating them, that bodes very badly...
 		 */
-		if (dma != virt_to_phys(table))
+		if (dma != phys)
 			goto out_unmap;
 	}
 	kmemleak_ignore(table);
-- 
2.17.0
