From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/8] iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
Date: Thu, 22 Jun 2017 16:53:52 +0100
Message-ID: <5e102f868fc8d291f05cb9f33f24bb9e6be79485.1498145008.git.robin.murphy@arm.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1498145008.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Whilst the short-descriptor format's split_blk_unmap implementation has
no need to be recursive, it followed the pattern of the LPAE version
anyway for the sake of consistency. With the latter now reworked for
both efficiency and future scalability improvements, tweak the former
similarly, not least to make it less obtuse.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: One trivial cosmetic tweak to the loop increment

 drivers/iommu/io-pgtable-arm-v7s.c | 85 ++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index a490db032c51..692621f1022a 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -281,6 +281,13 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 	else if (prot & IOMMU_CACHE)
 		pte |= ARM_V7S_ATTR_B | ARM_V7S_ATTR_C;
 
+	pte |= ARM_V7S_PTE_TYPE_PAGE;
+	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
+		pte |= ARM_V7S_ATTR_NS_SECTION;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
+		pte |= ARM_V7S_ATTR_MTK_4GB;
+
 	return pte;
 }
 
@@ -353,7 +360,7 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 			    int lvl, int num_entries, arm_v7s_iopte *ptep)
 {
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-	arm_v7s_iopte pte = arm_v7s_prot_to_pte(prot, lvl, cfg);
+	arm_v7s_iopte pte;
 	int i;
 
 	for (i = 0; i < num_entries; i++)
@@ -375,13 +382,7 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 			return -EEXIST;
 		}
 
-	pte |= ARM_V7S_PTE_TYPE_PAGE;
-	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
-		pte |= ARM_V7S_ATTR_NS_SECTION;
-
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
-		pte |= ARM_V7S_ATTR_MTK_4GB;
-
+	pte = arm_v7s_prot_to_pte(prot, lvl, cfg);
 	if (num_entries > 1)
 		pte = arm_v7s_pte_to_cont(pte, lvl);
 
@@ -391,6 +392,20 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 	return 0;
 }
 
+static arm_v7s_iopte arm_v7s_install_table(arm_v7s_iopte *table,
+					   arm_v7s_iopte *ptep,
+					   struct io_pgtable_cfg *cfg)
+{
+	arm_v7s_iopte new;
+
+	new = virt_to_phys(table) | ARM_V7S_PTE_TYPE_TABLE;
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
+		new |= ARM_V7S_ATTR_NS_TABLE;
+
+	__arm_v7s_set_pte(ptep, new, 1, cfg);
+	return new;
+}
+
 static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot,
 			 int lvl, arm_v7s_iopte *ptep)
@@ -418,11 +433,7 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 		if (!cptep)
 			return -ENOMEM;
 
-		pte = virt_to_phys(cptep) | ARM_V7S_PTE_TYPE_TABLE;
-		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
-			pte |= ARM_V7S_ATTR_NS_TABLE;
-
-		__arm_v7s_set_pte(ptep, pte, 1, cfg);
+		arm_v7s_install_table(cptep, ptep, cfg);
 	} else if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
 		cptep = iopte_deref(pte, lvl);
 	} else {
@@ -503,41 +514,35 @@ static void arm_v7s_split_cont(struct arm_v7s_io_pgtable *data,
 
 static int arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
 				   unsigned long iova, size_t size,
-				   arm_v7s_iopte *ptep)
+				   arm_v7s_iopte blk_pte, arm_v7s_iopte *ptep)
 {
-	unsigned long blk_start, blk_end, blk_size;
-	phys_addr_t blk_paddr;
-	arm_v7s_iopte table = 0;
-	int prot = arm_v7s_pte_to_prot(*ptep, 1);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_v7s_iopte pte, *tablep;
+	int i, unmap_idx, num_entries, num_ptes;
 
-	blk_size = ARM_V7S_BLOCK_SIZE(1);
-	blk_start = iova & ARM_V7S_LVL_MASK(1);
-	blk_end = blk_start + ARM_V7S_BLOCK_SIZE(1);
-	blk_paddr = *ptep & ARM_V7S_LVL_MASK(1);
+	tablep = __arm_v7s_alloc_table(2, GFP_ATOMIC, data);
+	if (!tablep)
+		return 0; /* Bytes unmapped */
 
-	for (; blk_start < blk_end; blk_start += size, blk_paddr += size) {
-		arm_v7s_iopte *tablep;
+	num_ptes = ARM_V7S_PTES_PER_LVL(2);
+	num_entries = size >> ARM_V7S_LVL_SHIFT(2);
+	unmap_idx = ARM_V7S_LVL_IDX(iova, 2);
 
+	pte = arm_v7s_prot_to_pte(arm_v7s_pte_to_prot(blk_pte, 1), 2, cfg);
+	if (num_entries > 1)
+		pte = arm_v7s_pte_to_cont(pte, 2);
+
+	for (i = 0; i < num_ptes; i += num_entries, pte += size) {
 		/* Unmap! */
-		if (blk_start == iova)
+		if (i == unmap_idx)
 			continue;
 
-		/* __arm_v7s_map expects a pointer to the start of the table */
-		tablep = &table - ARM_V7S_LVL_IDX(blk_start, 1);
-		if (__arm_v7s_map(data, blk_start, blk_paddr, size, prot, 1,
-				  tablep) < 0) {
-			if (table) {
-				/* Free the table we allocated */
-				tablep = iopte_deref(table, 1);
-				__arm_v7s_free_table(tablep, 2, data);
-			}
-			return 0; /* Bytes unmapped */
-		}
+		__arm_v7s_set_pte(&tablep[i], pte, num_entries, cfg);
 	}
 
-	__arm_v7s_set_pte(ptep, table, 1, &data->iop.cfg);
-	iova &= ~(blk_size - 1);
-	io_pgtable_tlb_add_flush(&data->iop, iova, blk_size, blk_size, true);
+	arm_v7s_install_table(tablep, ptep, cfg);
+
+	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
 	return size;
 }
 
@@ -594,7 +599,7 @@ static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 		 * Insert a table at the next level to map the old region,
 		 * minus the part we want to unmap
 		 */
-		return arm_v7s_split_blk_unmap(data, iova, size, ptep);
+		return arm_v7s_split_blk_unmap(data, iova, size, pte[0], ptep);
 	}
 
 	/* Keep on walkin' */
-- 
2.12.2.dirty
