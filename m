From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/4] iommu: add self-consistency tests to ARM LPAE IO page
	table allocator
Date: Thu, 27 Nov 2014 11:51:17 +0000
Message-ID: <1417089078-22900-4-git-send-email-will.deacon@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417089078-22900-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Robin.Murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds a series of basic self-consistency tests to the ARM LPAE
IO page table allocator that exercise corner cases in map/unmap, as well
as testing all valid configurations of pagesize, ias and stage.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/Kconfig          |   9 ++
 drivers/iommu/io-pgtable-arm.c | 190 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e1742a0146f8..dde72d0990b0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -28,6 +28,15 @@ config IOMMU_IO_PGTABLE_LPAE
 	  sizes at both stage-1 and stage-2, as well as address spaces
 	  up to 48-bits in size.
 
+config IOMMU_IO_PGTABLE_LPAE_SELFTEST
+	bool "LPAE selftests"
+	depends on IOMMU_IO_PGTABLE_LPAE
+	help
+	  Enable self-tests for LPAE page table allocator. This performs
+	  a series of page-table consistency checks during boot.
+
+	  If unsure, say N here.
+
 endmenu
 
 config OF_IOMMU
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 9dbaa2e48424..669e322a83a4 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -733,3 +733,193 @@ struct io_pgtable_init_fns io_pgtable_arm_lpae_s2_init_fns = {
 	.alloc	= arm_lpae_alloc_pgtable_s2,
 	.free	= arm_lpae_free_pgtable,
 };
+
+#ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
+
+static struct io_pgtable_cfg *cfg_cookie;
+
+static void dummy_tlb_flush_all(void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+}
+
+static void dummy_tlb_add_flush(unsigned long iova, size_t size, bool leaf,
+				void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
+}
+
+static void dummy_tlb_sync(void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+}
+
+static void dummy_flush_pgtable(void *ptr, size_t size, void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+}
+
+static struct iommu_gather_ops dummy_tlb_ops __initdata = {
+	.tlb_flush_all	= dummy_tlb_flush_all,
+	.tlb_add_flush	= dummy_tlb_add_flush,
+	.tlb_sync	= dummy_tlb_sync,
+	.flush_pgtable	= dummy_flush_pgtable,
+};
+
+static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+
+	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
+		cfg->pgsize_bitmap, cfg->ias);
+	pr_err("data: %d levels, %d pages_per_pgd, %lu pg_shift, %lu bits_per_level, pgd @ %p\n",
+		data->levels, data->pages_per_pgd, data->pg_shift,
+		data->bits_per_level, data->pgd);
+}
+
+#define __FAIL(ops, i)	({						\
+		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
+		arm_lpae_dump_ops(ops);					\
+		-EFAULT;						\
+})
+
+static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
+{
+	static const enum io_pgtable_fmt fmts[] = {
+		ARM_LPAE_S1,
+		ARM_LPAE_S2,
+	};
+
+	int i, j;
+	unsigned long iova;
+	size_t size;
+	struct io_pgtable_ops *ops;
+
+	for (i = 0; i < ARRAY_SIZE(fmts); ++i) {
+		cfg_cookie = cfg;
+		ops = alloc_io_pgtable_ops(fmts[i], cfg, cfg);
+		if (!ops) {
+			pr_err("selftest: failed to allocate io pgtable ops\n");
+			return -ENOMEM;
+		}
+
+		/*
+		 * Initial sanity checks.
+		 * Empty page tables shouldn't provide any translations.
+		 */
+		if (ops->iova_to_phys(ops, 42))
+			return __FAIL(ops, i);
+
+		if (ops->iova_to_phys(ops, SZ_1G + 42))
+			return __FAIL(ops, i);
+
+		if (ops->iova_to_phys(ops, SZ_2G + 42))
+			return __FAIL(ops, i);
+
+		/*
+		 * Distinct mappings of different granule sizes.
+		 */
+		iova = 0;
+		j = find_first_bit(&cfg->pgsize_bitmap, BITS_PER_LONG);
+		while (j != BITS_PER_LONG) {
+			size = 1UL << j;
+
+			if (ops->map(ops, iova, iova, size, IOMMU_READ |
+							    IOMMU_WRITE |
+							    IOMMU_NOEXEC |
+							    IOMMU_CACHE))
+				return __FAIL(ops, i);
+
+			/* Overlapping mappings */
+			if (!ops->map(ops, iova, iova + size, size,
+				      IOMMU_READ | IOMMU_NOEXEC))
+				return __FAIL(ops, i);
+
+			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+				return __FAIL(ops, i);
+
+			iova += SZ_1G;
+			j++;
+			j = find_next_bit(&cfg->pgsize_bitmap, BITS_PER_LONG, j);
+		}
+
+		/* Partial unmap */
+		size = 1UL << __ffs(cfg->pgsize_bitmap);
+		if (ops->unmap(ops, SZ_1G + size, size) != size)
+			return __FAIL(ops, i);
+
+		/* Remap of partial unmap */
+		if (ops->map(ops, SZ_1G + size, size, size, IOMMU_READ))
+			return __FAIL(ops, i);
+
+		if (ops->iova_to_phys(ops, SZ_1G + size + 42) != (size + 42))
+			return __FAIL(ops, i);
+
+		/* Full unmap */
+		iova = 0;
+		j = find_first_bit(&cfg->pgsize_bitmap, BITS_PER_LONG);
+		while (j != BITS_PER_LONG) {
+			size = 1UL << j;
+
+			if (ops->unmap(ops, iova, size) != size)
+				return __FAIL(ops, i);
+
+			if (ops->iova_to_phys(ops, iova + 42))
+				return __FAIL(ops, i);
+
+			/* Remap full block */
+			if (ops->map(ops, iova, iova, size, IOMMU_WRITE))
+				return __FAIL(ops, i);
+
+			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+				return __FAIL(ops, i);
+
+			iova += SZ_1G;
+			j++;
+			j = find_next_bit(&cfg->pgsize_bitmap, BITS_PER_LONG, j);
+		}
+
+		free_io_pgtable_ops(ops);
+	}
+
+	return 0;
+}
+
+static int __init arm_lpae_do_selftests(void)
+{
+	static const unsigned long pgsize[] = {
+		SZ_4K | SZ_2M | SZ_1G,
+		SZ_16K | SZ_32M,
+		SZ_64K | SZ_512M,
+	};
+
+	static const unsigned int ias[] = {
+		32, 36, 40, 42, 44, 48,
+	};
+
+	int i, j, pass = 0, fail = 0;
+	struct io_pgtable_cfg cfg = {
+		.tlb = &dummy_tlb_ops,
+		.oas = 48,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
+		for (j = 0; j < ARRAY_SIZE(ias); ++j) {
+			cfg.pgsize_bitmap = pgsize[i];
+			cfg.ias = ias[j];
+			pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u\n",
+				pgsize[i], ias[j]);
+			if (arm_lpae_run_tests(&cfg))
+				fail++;
+			else
+				pass++;
+		}
+	}
+
+	pr_info("selftest: completed with %d PASS %d FAIL\n", pass, fail);
+	return fail ? -EFAULT : 0;
+}
+subsys_initcall(arm_lpae_do_selftests);
+#endif
-- 
2.1.1
