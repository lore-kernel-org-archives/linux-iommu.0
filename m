Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822253ED0A
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987108; cv=none; b=ckofF1aQU3jU4cWnp7H4HJWZ0uODM/9t+9uO8VucElrQomAwJ0VUBusWlACJakKXvwGKzU34u+vL2KtKZ2AzLgEiZu1wuTmUiOS3orHU7Tsk1daUnBjNoo3Rxixy5v2i6UGfv50N7SUCZ6wSFpN2hbbCFjC4oaT3rEFbRpsIm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987108; c=relaxed/simple;
	bh=GREiAX0XTRRzYDdshwynjkxzWH1m9oXEZo3HT0HeWus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSTHO1gm08zmmcz0fpAqJtE0/qrSX1owcfYdhbtiGw/0b4J1FCrBgIU5HbmuIsYaBAOgNfZu8z1J+JQGRXU/Lc/UfVRkacvBgFjqsQvgoTw/5qnNOSrdIqUxnLKm1TiKGGA0uCR4teXr/jhEsVrpE7LafN4eFJVSkKixtqg8dvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e9WWLZ4a; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e9WWLZ4a"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791987098; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UMeQJiIhi3N1WM7pDeMhvff+GLRFDhHq1z1NCwRI5vo=;
	b=e9WWLZ4aTk9H6MEaVyldlZeZAPgRY+Z/XWREWPV22SBttjqN4uS6rtrBtXF8aJca8+URrmbri1Bnt6r3kUb0AMQUpBKR0czKRmxWsIue88Sme642nnAOSa/o4TqcJUdQKTcz/R1TwajJ8ZevSKz0cs2Qo4TBAOkM6C0bFv3Ndfs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XCp41.4_1791987095;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XCp41.4_1791987095 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 22:11:36 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@oss.qualcomm.com,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	gsh517025@gmail.com
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH v2 1/4] iommupt: Add replace_leaf to atomically swap a leaf OA
Date: Wed, 14 Oct 2026 22:11:21 +0800
Message-Id: <20261014141124.48569-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261014141124.48569-1-fangyu.yu@linux.alibaba.com>
References: <20261014141124.48569-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Some users need to repoint a leaf entry to a different physical page
without ever making the IOVA non-present. RISC-V IRQ forwarding without
an MSI page table maps the guest IMSIC page in the second-stage domain
and must follow the page when a vCPU's VS-file host page moves; an
unmap/map sequence would leave a window where device MSI writes fault.

Add a pt_entry_replace_oa() format op that atomically swaps the OA
stored in a leaf entry that fits in a single PTE word via cmpxchg,
validating that the entry still holds the expected old OA, and a
pt_iommu_riscv_64_replace_leaf() export that walks to the leaf. Formats
that cannot do this atomically do not provide the op, following the
pt_iommu_fmt_hw_info() pattern. Covered by a kunit case checking the
granule and superpage swaps, stale OA rejection, and missing
translation.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/generic_pt/fmt/riscv.h      | 47 ++++++++++++++++
 drivers/iommu/generic_pt/iommu_pt.h       | 65 +++++++++++++++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h    |  7 +++
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 54 +++++++++++++++++++
 include/linux/generic_pt/iommu.h          |  4 ++
 5 files changed, 177 insertions(+)

diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index 2f4838eb44af..38c837805df0 100644
--- a/drivers/iommu/generic_pt/fmt/riscv.h
+++ b/drivers/iommu/generic_pt/fmt/riscv.h
@@ -27,6 +27,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/container_of.h>
+#include <linux/errno.h>
 #include <linux/log2.h>
 #include <linux/sizes.h>
 
@@ -272,6 +273,52 @@ static inline bool riscvpt_dirty_supported(struct pt_common *common)
 }
 #define pt_dirty_supported riscvpt_dirty_supported
 
+/**
+ * pt_entry_replace_oa() - Atomically replace the OA stored in a leaf
+ * @pts: Table entry to change
+ * @old_oa: OA the entry must currently translate to
+ * @new_oa: OA to store in the entry
+ *
+ * Atomically swap the OA stored in a single PTE word leaf entry, keeping
+ * every other bit of the entry unchanged. The entry must currently translate
+ * to @old_oa so a stale view of the table is detectable. Both @old_oa and
+ * @new_oa must be aligned to the size the entry translates. Entries that do
+ * not fit in a single PTE word, such as contiguous entries, are rejected.
+ *
+ * Return: 0 on success, -EAGAIN if the entry changed concurrently, -EADDRINUSE
+ * if the entry does not translate to @old_oa, -EOPNOTSUPP if the entry spans
+ * multiple PTE words, -EINVAL if an argument is malformed.
+ */
+static inline int riscvpt_entry_replace_oa(struct pt_state *pts,
+					   pt_oaddr_t old_oa,
+					   pt_oaddr_t new_oa)
+{
+	pt_riscv_entry_t *tablep =
+		pt_cur_table(pts, pt_riscv_entry_t) + pts->index;
+	pt_riscv_entry_t old = pts->entry, new;
+	unsigned int oasz_lg2 = pt_table_item_lg2sz(pts);
+	u64 ppn = (u64)new_oa >> PT_GRANULE_LG2SZ;
+
+	/* Only a leaf entry that fits in a single PTE word can be replaced. */
+	if (pt_entry_num_contig_lg2(pts))
+		return -EOPNOTSUPP;
+
+	if (oalog2_mod(old_oa, oasz_lg2) || oalog2_mod(new_oa, oasz_lg2) ||
+	    ppn > FIELD_MAX(RISCVPT_PPN))
+		return -EINVAL;
+
+	/* The leaf must still hold the OA the caller expects to replace. */
+	if (pt_entry_oa(pts) != old_oa)
+		return -EADDRINUSE;
+
+	new = (old & ~(pt_riscv_entry_t)RISCVPT_PPN) |
+	      FIELD_PREP(RISCVPT_PPN, ppn);
+	if (!try_cmpxchg64(tablep, &old, new))
+		return -EAGAIN;
+	return 0;
+}
+#define pt_entry_replace_oa riscvpt_entry_replace_oa
+
 /* --- iommu */
 #include <linux/generic_pt/iommu.h>
 #include <linux/iommu.h>
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 3d1fdf1e81d8..5e296992c4df 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -375,6 +375,71 @@ static int __maybe_unused NS(set_dirty)(struct pt_iommu *iommu_table,
 	return pt_walk_range(&range, __set_dirty, NULL);
 }
 
+#ifdef pt_entry_replace_oa
+struct pt_replace_leaf_args {
+	pt_oaddr_t old_oa;
+	pt_oaddr_t new_oa;
+};
+
+static int __replace_leaf(struct pt_range *range, void *arg,
+			  unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_replace_leaf_args *args = arg;
+
+	switch (pt_load_single_entry(&pts)) {
+	case PT_ENTRY_EMPTY:
+		return -ENOENT;
+	case PT_ENTRY_TABLE:
+		return pt_descend(&pts, arg, __replace_leaf);
+	case PT_ENTRY_OA:
+		return pt_entry_replace_oa(&pts, args->old_oa, args->new_oa);
+	}
+	return -ENOENT;
+}
+
+/**
+ * replace_leaf() - Atomically replace the OA stored in a leaf entry
+ * @domain: Table to manipulate
+ * @iova: IO virtual address to locate the leaf
+ * @old_oa: OA the leaf must currently translate to
+ * @new_oa: OA to store in the leaf
+ *
+ * Locate the leaf entry translating @iova and atomically swap its stored OA
+ * from @old_oa to @new_oa, leaving the entry attributes unchanged. HW
+ * walking the table concurrently observes either the old or the new OA. The
+ * caller must invalidate any translation caches before assuming HW no longer
+ * observes the old OA.
+ *
+ * Context: There is no internal locking. The caller must serialize this with
+ * any concurrent map/unmap touching @iova, as with map_range().
+ *
+ * Returns: 0 on success. -EAGAIN indicates the entry changed concurrently,
+ * retry. -ENOENT if @iova has no translation. -EADDRINUSE if the leaf does
+ * not translate to @old_oa. -EOPNOTSUPP if the leaf does not fit in a single
+ * PTE word, such as a contiguous entry.
+ */
+int DOMAIN_NS(replace_leaf)(struct iommu_domain *domain, dma_addr_t iova,
+			    phys_addr_t old_oa, phys_addr_t new_oa)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_replace_leaf_args args = {
+		.old_oa = old_oa,
+		.new_oa = new_oa,
+	};
+	struct pt_range range;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
+	if (ret)
+		return ret;
+
+	return pt_walk_range(&range, __replace_leaf, &args);
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(replace_leaf), "GENERIC_PT_IOMMU");
+#endif
+
 struct pt_iommu_collect_args {
 	struct iommupt_pending_gather pending;
 	/* Fail if any OAs are within the range */
diff --git a/drivers/iommu/generic_pt/kunit_iommu.h b/drivers/iommu/generic_pt/kunit_iommu.h
index 22c9e4c4dd97..d52b82c9942c 100644
--- a/drivers/iommu/generic_pt/kunit_iommu.h
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -16,6 +16,13 @@
 int pt_iommu_init(struct pt_iommu_table *fmt_table,
 		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp);
 
+#ifdef pt_entry_replace_oa
+#define pt_iommu_replace_leaf \
+	CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), replace_leaf)
+int pt_iommu_replace_leaf(struct iommu_domain *domain, dma_addr_t iova,
+			  phys_addr_t old_oa, phys_addr_t new_oa);
+#endif
+
 /* The format can provide a list of configurations it would like to test */
 #ifdef kunit_fmt_cfgs
 static const void *kunit_pt_gen_params_cfg(struct kunit *test, const void *prev,
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
index ece1c9b8c55d..8707d55418d3 100644
--- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -427,6 +427,57 @@ static void test_mixed(struct kunit *test)
 	check_iova(test, start, oa, len);
 }
 
+#ifdef pt_entry_replace_oa
+static void test_replace_leaf(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	pt_vaddr_t va = range.va + priv->smallest_pgsz * 256;
+	phys_addr_t pa = log2_set_mod(priv->test_oa, 0,
+				      priv->smallest_pgsz_lg2);
+	phys_addr_t new_pa = log2_set_mod(priv->test_oa + priv->smallest_pgsz,
+					  0, priv->smallest_pgsz_lg2);
+	int ret;
+
+	do_map(test, va, pa, priv->smallest_pgsz);
+
+	/* The leaf OA can be swapped in place */
+	ret = pt_iommu_replace_leaf(&priv->domain, va, pa, new_pa);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	check_iova(test, va, new_pa, priv->smallest_pgsz);
+
+	/* A stale old OA is detected */
+	ret = pt_iommu_replace_leaf(&priv->domain, va, pa, pa);
+	KUNIT_ASSERT_EQ(test, ret, -EADDRINUSE);
+
+	/* A not-present IOVA reports -ENOENT */
+	ret = pt_iommu_replace_leaf(&priv->domain, va + priv->smallest_pgsz,
+				    pa, new_pa);
+	KUNIT_ASSERT_EQ(test, ret, -ENOENT);
+
+	do_unmap(test, va, priv->smallest_pgsz);
+
+	if (!(priv->safe_pgsize_bitmap & SZ_2M))
+		return;
+
+	/* A leaf at a higher level can be swapped in place too */
+	va = ALIGN(va, SZ_2M);
+	pa = log2_set_mod(priv->test_oa, 0, ilog2(SZ_2M));
+	new_pa = log2_set_mod(priv->test_oa + SZ_2M, 0, ilog2(SZ_2M));
+	do_map(test, va, pa, SZ_2M);
+
+	ret = pt_iommu_replace_leaf(&priv->domain, va, pa, new_pa);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	check_iova(test, va, new_pa, SZ_2M);
+
+	/* A stale old OA is detected */
+	ret = pt_iommu_replace_leaf(&priv->domain, va, pa, pa);
+	KUNIT_ASSERT_EQ(test, ret, -EADDRINUSE);
+
+	do_unmap(test, va, SZ_2M);
+}
+#endif
+
 static struct kunit_case iommu_test_cases[] = {
 	KUNIT_CASE_FMT(test_increase_level),
 	KUNIT_CASE_FMT(test_map_simple),
@@ -435,6 +486,9 @@ static struct kunit_case iommu_test_cases[] = {
 	KUNIT_CASE_FMT(test_random_map),
 	KUNIT_CASE_FMT(test_pgsize_boundary),
 	KUNIT_CASE_FMT(test_mixed),
+#ifdef pt_entry_replace_oa
+	KUNIT_CASE_FMT(test_replace_leaf),
+#endif
 	{},
 };
 
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 2eed9b78f56c..e9042b509013 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -254,6 +254,10 @@ struct pt_iommu_cfg {
 	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
 		struct iommu_domain *domain, unsigned long iova, size_t size,  \
 		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
+	/* Only defined by formats whose fmt header has pt_entry_replace_oa */ \
+	int pt_iommu_##fmt##_replace_leaf(struct iommu_domain *domain,         \
+					  dma_addr_t iova, phys_addr_t old_oa, \
+					  phys_addr_t new_oa);                 \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
-- 
2.50.1

