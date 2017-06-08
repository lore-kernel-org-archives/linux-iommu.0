From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/8] iommu/io-pgtable-arm: Improve split_blk_unmap
Date: Thu,  8 Jun 2017 12:52:01 +0100
Message-ID: <ea6da7c87d1d4cba570dd00d1de12a1cf489aecf.1496921366.git.robin.murphy@arm.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1496921366.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, joro@8bytes.org
Cc: salil.mehta@huawei.com, sunil.goutham@cavium.com, iommu@lists.linux-foundation.org, ray.jui@broadcom.com, linux-arm-kernel@lists.infradead.org, linu.cherian@cavium.com, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

The current split_blk_unmap implementation suffers from some inscrutable
pointer trickery for creating the tables to replace the block entry, but
more than that it also suffers from hideous inefficiency. For example,
the most pathological case of unmapping a level 3 page from a level 1
block will allocate 513 lower-level tables to remap the entire block at
page granularity, when only 2 are actually needed (the rest can be
covered by level 2 block entries).

Also, we would like to be able to relax the spinlock requirement in
future, for which the roll-back-and-try-again logic for race resolution
would be pretty hideous under the current paradigm.

Both issues can be resolved most neatly by turning things sideways:
instead of repeatedly recursing into __arm_lpae_map() map to build up an
entire new sub-table depth-first, we can directly replace the block
entry with a next-level table of block/page entries, then repeat by
unmapping at the next level if necessary. With a little refactoring of
some helper functions, the code ends up not much bigger than before, but
considerably easier to follow and to adapt in future.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 116 ++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6e5df5e0a3bd..97d039952367 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -264,13 +264,32 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			    unsigned long iova, size_t size, int lvl,
 			    arm_lpae_iopte *ptep);
 
+static arm_lpae_iopte __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
+					  arm_lpae_iopte prot, int lvl,
+					  phys_addr_t paddr)
+{
+	arm_lpae_iopte pte = prot;
+
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
+		pte |= ARM_LPAE_PTE_NS;
+
+	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
+		pte |= ARM_LPAE_PTE_TYPE_PAGE;
+	else
+		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
+
+	pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
+	pte |= pfn_to_iopte(paddr >> data->pg_shift, data);
+
+	return pte;
+}
+
 static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			     unsigned long iova, phys_addr_t paddr,
 			     arm_lpae_iopte prot, int lvl,
 			     arm_lpae_iopte *ptep)
 {
-	arm_lpae_iopte pte = prot;
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte pte;
 
 	if (iopte_leaf(*ptep, lvl)) {
 		/* We require an unmap first */
@@ -289,21 +308,25 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			return -EINVAL;
 	}
 
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
-		pte |= ARM_LPAE_PTE_NS;
-
-	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
-		pte |= ARM_LPAE_PTE_TYPE_PAGE;
-	else
-		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
-
-	pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
-	pte |= pfn_to_iopte(paddr >> data->pg_shift, data);
-
-	__arm_lpae_set_pte(ptep, pte, cfg);
+	pte = __arm_lpae_init_pte(data, prot, lvl, paddr);
+	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
 	return 0;
 }
 
+static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
+					     arm_lpae_iopte *ptep,
+					     struct io_pgtable_cfg *cfg)
+{
+	arm_lpae_iopte new;
+
+	new = __pa(table) | ARM_LPAE_PTE_TYPE_TABLE;
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
+		new |= ARM_LPAE_PTE_NSTABLE;
+
+	__arm_lpae_set_pte(ptep, new, cfg);
+	return new;
+}
+
 static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 			  phys_addr_t paddr, size_t size, arm_lpae_iopte prot,
 			  int lvl, arm_lpae_iopte *ptep)
@@ -331,10 +354,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		if (!cptep)
 			return -ENOMEM;
 
-		pte = __pa(cptep) | ARM_LPAE_PTE_TYPE_TABLE;
-		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
-			pte |= ARM_LPAE_PTE_NSTABLE;
-		__arm_lpae_set_pte(ptep, pte, cfg);
+		arm_lpae_install_table(cptep, ptep, cfg);
 	} else if (!iopte_leaf(pte, lvl)) {
 		cptep = iopte_deref(pte, data);
 	} else {
@@ -452,40 +472,42 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
 
 static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 				    unsigned long iova, size_t size,
-				    arm_lpae_iopte prot, int lvl,
-				    arm_lpae_iopte *ptep, size_t blk_size)
+				    arm_lpae_iopte blk_pte, int lvl,
+				    arm_lpae_iopte *ptep)
 {
-	unsigned long blk_start, blk_end;
-	phys_addr_t blk_paddr;
-	arm_lpae_iopte table = 0;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte pte, *tablep;
+	size_t tablesz = ARM_LPAE_GRANULE(data);
+	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int i, unmap_idx = -1;
 
-	blk_start = iova & ~(blk_size - 1);
-	blk_end = blk_start + blk_size;
-	blk_paddr = iopte_to_pfn(*ptep, data) << data->pg_shift;
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
 
-	for (; blk_start < blk_end; blk_start += size, blk_paddr += size) {
-		arm_lpae_iopte *tablep;
+	tablep = __arm_lpae_alloc_pages(tablesz, GFP_ATOMIC, cfg);
+	if (!tablep)
+		return 0; /* Bytes unmapped */
 
+	if (size == split_sz)
+		unmap_idx = ARM_LPAE_LVL_IDX(iova, lvl, data);
+
+	pte = __arm_lpae_init_pte(data, iopte_prot(blk_pte), lvl,
+				iopte_to_pfn(blk_pte, data) << data->pg_shift);
+
+	for (i = 0; i < tablesz / sizeof(pte); pte += split_sz, i++) {
 		/* Unmap! */
-		if (blk_start == iova)
+		if (i == unmap_idx)
 			continue;
 
-		/* __arm_lpae_map expects a pointer to the start of the table */
-		tablep = &table - ARM_LPAE_LVL_IDX(blk_start, lvl, data);
-		if (__arm_lpae_map(data, blk_start, blk_paddr, size, prot, lvl,
-				   tablep) < 0) {
-			if (table) {
-				/* Free the table we allocated */
-				tablep = iopte_deref(table, data);
-				__arm_lpae_free_pgtable(data, lvl + 1, tablep);
-			}
-			return 0; /* Bytes unmapped */
-		}
+		__arm_lpae_set_pte(&tablep[i], pte, cfg);
 	}
 
-	__arm_lpae_set_pte(ptep, table, &data->iop.cfg);
-	iova &= ~(blk_size - 1);
-	io_pgtable_tlb_add_flush(&data->iop, iova, blk_size, blk_size, true);
+	arm_lpae_install_table(tablep, ptep, cfg);
+
+	if (unmap_idx < 0)
+		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
+
+	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
 	return size;
 }
 
@@ -495,7 +517,6 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte;
 	struct io_pgtable *iop = &data->iop;
-	size_t blk_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 
 	/* Something went horribly wrong and we ran out of page table */
 	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
@@ -507,7 +528,7 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		return 0;
 
 	/* If the size matches this level, we're in the right place */
-	if (size == blk_size) {
+	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
 		__arm_lpae_set_pte(ptep, 0, &iop->cfg);
 
 		if (!iopte_leaf(pte, lvl)) {
@@ -527,9 +548,8 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		 * Insert a table at the next level to map the old region,
 		 * minus the part we want to unmap
 		 */
-		return arm_lpae_split_blk_unmap(data, iova, size,
-						iopte_prot(pte), lvl, ptep,
-						blk_size);
+		return arm_lpae_split_blk_unmap(data, iova, size, pte,
+						lvl + 1, ptep);
 	}
 
 	/* Keep on walkin' */
-- 
2.12.2.dirty
