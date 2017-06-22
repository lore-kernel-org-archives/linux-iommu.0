From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 4/8] iommu/io-pgtable: Introduce explicit coherency
Date: Thu, 22 Jun 2017 16:53:53 +0100
Message-ID: <6d1b579801022ef00b9a724ff3f4250930bfbea3.1498145008.git.robin.murphy@arm.com>
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

Once we remove the serialising spinlock, a potential race opens up for
non-coherent IOMMUs whereby a caller of .map() can be sure that cache
maintenance has been performed on their new PTE, but will have no
guarantee that such maintenance for table entries above it has actually
completed (e.g. if another CPU took an interrupt immediately after
writing the table entry, but before initiating the DMA sync).

Handling this race safely will add some potentially non-trivial overhead
to installing a table entry, which we would much rather avoid on
coherent systems where it will be unnecessary, and where we are stirivng
to minimise latency by removing the locking in the first place.

To that end, let's introduce an explicit notion of cache-coherency to
io-pgtable, such that we will be able to avoid penalising IOMMUs which
know enough to know when they are coherent.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: No change

 drivers/iommu/arm-smmu-v3.c        |  3 +++
 drivers/iommu/arm-smmu.c           |  3 +++
 drivers/iommu/io-pgtable-arm-v7s.c | 17 ++++++++++-------
 drivers/iommu/io-pgtable-arm.c     | 11 ++++++-----
 drivers/iommu/io-pgtable.h         |  6 ++++++
 5 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969aa60d5..b9c4cf4ccca2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1555,6 +1555,9 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		.iommu_dev	= smmu->dev,
 	};
 
+	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
+		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
+
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7ec30b08b3bd..1f42f339a284 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1010,6 +1010,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.iommu_dev	= smmu->dev,
 	};
 
+	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
+
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 692621f1022a..1e283be39668 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -187,7 +187,8 @@ static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl)
 static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 				   struct arm_v7s_io_pgtable *data)
 {
-	struct device *dev = data->iop.cfg.iommu_dev;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	struct device *dev = cfg->iommu_dev;
 	dma_addr_t dma;
 	size_t size = ARM_V7S_TABLE_SIZE(lvl);
 	void *table = NULL;
@@ -196,7 +197,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
 	else if (lvl == 2)
 		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
-	if (table && !selftest_running) {
+	if (table && !(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
 		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
 			goto out_free;
@@ -225,10 +226,11 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 static void __arm_v7s_free_table(void *table, int lvl,
 				 struct arm_v7s_io_pgtable *data)
 {
-	struct device *dev = data->iop.cfg.iommu_dev;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	struct device *dev = cfg->iommu_dev;
 	size_t size = ARM_V7S_TABLE_SIZE(lvl);
 
-	if (!selftest_running)
+	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
 		dma_unmap_single(dev, __arm_v7s_dma_addr(table), size,
 				 DMA_TO_DEVICE);
 	if (lvl == 1)
@@ -240,7 +242,7 @@ static void __arm_v7s_free_table(void *table, int lvl,
 static void __arm_v7s_pte_sync(arm_v7s_iopte *ptep, int num_entries,
 			       struct io_pgtable_cfg *cfg)
 {
-	if (selftest_running)
+	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
 		return;
 
 	dma_sync_single_for_device(cfg->iommu_dev, __arm_v7s_dma_addr(ptep),
@@ -657,7 +659,8 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_NO_PERMS |
 			    IO_PGTABLE_QUIRK_TLBI_ON_MAP |
-			    IO_PGTABLE_QUIRK_ARM_MTK_4GB))
+			    IO_PGTABLE_QUIRK_ARM_MTK_4GB |
+			    IO_PGTABLE_QUIRK_NO_DMA))
 		return NULL;
 
 	/* If ARM_MTK_4GB is enabled, the NO_PERMS is also expected. */
@@ -774,7 +777,7 @@ static int __init arm_v7s_do_selftests(void)
 		.tlb = &dummy_tlb_ops,
 		.oas = 32,
 		.ias = 32,
-		.quirks = IO_PGTABLE_QUIRK_ARM_NS,
+		.quirks = IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA,
 		.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	};
 	unsigned int iova, size, iova_start;
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index dd7477010291..6334f51912ea 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -217,7 +217,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	if (!pages)
 		return NULL;
 
-	if (!selftest_running) {
+	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
 		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
 			goto out_free;
@@ -243,7 +243,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 static void __arm_lpae_free_pages(void *pages, size_t size,
 				  struct io_pgtable_cfg *cfg)
 {
-	if (!selftest_running)
+	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
 		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
 				 size, DMA_TO_DEVICE);
 	free_pages_exact(pages, size);
@@ -254,7 +254,7 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
 {
 	*ptep = pte;
 
-	if (!selftest_running)
+	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
 		dma_sync_single_for_device(cfg->iommu_dev,
 					   __arm_lpae_dma_addr(ptep),
 					   sizeof(pte), DMA_TO_DEVICE);
@@ -693,7 +693,7 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	u64 reg;
 	struct arm_lpae_io_pgtable *data;
 
-	if (cfg->quirks & ~IO_PGTABLE_QUIRK_ARM_NS)
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -782,7 +782,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 
 	/* The NS quirk doesn't apply at stage 2 */
-	if (cfg->quirks)
+	if (cfg->quirks & ~IO_PGTABLE_QUIRK_NO_DMA)
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -1086,6 +1086,7 @@ static int __init arm_lpae_do_selftests(void)
 	struct io_pgtable_cfg cfg = {
 		.tlb = &dummy_tlb_ops,
 		.oas = 48,
+		.quirks = IO_PGTABLE_QUIRK_NO_DMA,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 969d82cc92ca..524263a7ae6f 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -65,11 +65,17 @@ struct io_pgtable_cfg {
 	 *	PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
 	 *	when the SoC is in "4GB mode" and they can only access the high
 	 *	remap of DRAM (0x1_00000000 to 0x1_ffffffff).
+	 *
+	 * IO_PGTABLE_QUIRK_NO_DMA: Guarantees that the tables will only ever
+	 *	be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
+	 *	software-emulated IOMMU), such that pagetable updates need not
+	 *	be treated as explicit DMA data.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
 	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
 	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
+	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
2.12.2.dirty
