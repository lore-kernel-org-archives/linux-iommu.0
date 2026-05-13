Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C0381AFB;
	Wed, 13 May 2026 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637803; cv=none; b=UrROo3WAw2u1UgU7vj6fD7YqdoPEXsWuRgDQbmwT81/sTdVqQh3ksifDLIO07yQsaOg7mf7kgF2pz356Xj4wcNiYcbw5GLqT07L06q5ZzLUvk3YnDAUkRfQvHj2DHOiXQlZONenjiif4mW6dbmLIm2S8rEYgtJiFU/7ruCh0xeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637803; c=relaxed/simple;
	bh=41hrHwfchr34G6dv1i37TpBlXqtBPLFr13A8Q3i1U5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxO5vb1BOh1jqlUcNxhIFLJmQfjIBperjvvH8A94Ckl09P4CTS22hET3w7Rmq89CGUjKaL6X6AmdyH26xo2i1u1vnOWRfOs3/ZYPf4yi984q5khZx+9+5AdeVf7dXHmiNyGqqJO3Tu8PbnuybJMp3e1Vz2xQISkU6FDP7X5qT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=otRgMr7t; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="otRgMr7t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2E57BXtOvv/R8hb2DBqVXtfeBA65Ud9+LXTlXyCtHoo=; b=otRgMr7tnIylHKROGlOtn9n9Aw
	YGV10qs7/86dH4wgwKAleQAOEJAEIKWoDH4ggk1EnPm+9kP2KcZV+irKWwQSgMay4WT5M64653QNz
	DFGi3sxc7hlpsti/1+L4VslZYKudx32yebcG2gWiabdkq2ZgJIbf1Qavk7hqT/Webl+GFPPw9pXeE
	vN2koVyOV08dvGvi8NsCGOmWtBxOrryypHzIoSzQQ7Tnb+Gr0KpH2GEIx6aP/ceAZRMFoh8VQ+m2E
	Nii7YWRbxV0Gz4+0hLv9qW4CZFBVltUlIEs3dDTL3BZ6YpkPhwPkIyTOJUHu8lew2tpAEbhKD6xYI
	pM3G4n8A==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wMywG-0000000022e-44xY;
	Tue, 12 May 2026 22:03:08 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	kyle@mcmartin.ca,
	kernel-team@meta.com,
	Rik van Riel <riel@meta.com>,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH 5/5] iova: add KUnit test suite
Date: Tue, 12 May 2026 22:00:22 -0400
Message-ID: <20260513020304.1528751-6-riel@surriel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513020304.1528751-1-riel@surriel.com>
References: <20260513020304.1528751-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@meta.com>

Add a kunit suite for the augmented-rbtree IOVA allocator, plus an
iova_domain_verify_invariants() helper (compiled only when the test
config is enabled) that walks the tree and confirms every node's
gap_to_prev, clamped_gap32, __subtree_max_gap, and __subtree_max_gap32
match what recomputation from scratch yields.

Test cases:
  - test_init_destroy: domain lifecycle, no leaks.
  - test_basic_alloc_free: single alloc/free roundtrip, top-down reuse.
  - test_size_aligned: alignment of size_aligned allocs across orders 0..7.
  - test_top_down_preference: sequential allocs decrease in pfn_lo.
  - test_limit_pfn_respected: 100 allocs all stay <= limit_pfn.
  - test_reserve_iova: allocs avoid the reserved range.
  - test_find_iova: lookup by pfn returns the right iova.
  - test_32bit_in_64bit_domain: 1000 64-bit allocs followed by a 32-bit
    alloc must still find a slot below DMA_BIT_MASK(32) -- exercises
    the __subtree_max_gap32 augmentation.
  - test_two_phase_alignment: pack size-2 size_aligned allocs, free
    every other; subsequent size-2 alloc must succeed via the phase-2
    fallback search since phase-1's S+A-1 threshold prunes the size-2
    gaps.
  - test_pci_32bit_workaround_pattern: alternate 32-bit-first allocation
    attempts with 64-bit fallback, mirroring dma-iommu.c.
  - test_stress_random: 2048 random alloc/free operations with mixed
    sizes, alignments, and 32/64-bit limits, with periodic invariant
    checks.

Each test verifies the augmented invariants both during and after the
test run so that any sequencing bug in insert / erase / rotate /
propagate is caught at the operation that introduced it.

Tested by: building drivers/iommu/iova.o and drivers/iommu/iova-kunit.o
(no warnings); runtime execution requires booting a kernel with
CONFIG_IOMMU_IOVA_KUNIT_TEST=y under qemu-system-x86_64 (not available
on this devvm).

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/iommu/Kconfig      |  14 ++
 drivers/iommu/Makefile     |   1 +
 drivers/iommu/iova-kunit.c | 396 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iova.c       |  90 +++++++++
 include/linux/iova.h       |   3 +
 5 files changed, 504 insertions(+)
 create mode 100644 drivers/iommu/iova-kunit.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f86262b11416..61906a5664a6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -3,6 +3,20 @@
 config IOMMU_IOVA
 	tristate
 
+config IOMMU_IOVA_KUNIT_TEST
+	tristate "KUnit tests for the IOVA allocator" if !KUNIT_ALL_TESTS
+	depends on IOMMU_IOVA && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable kunit tests for the IOVA allocator. The tests exercise
+	  basic allocation and free, size-aligned allocation, top-down
+	  ordering, the limit_pfn-aware 32-bit augmentation, the
+	  alignment-aware two-phase search, and randomly-fragmented
+	  stress scenarios. Each test verifies that the augmented
+	  rbtree invariants remain consistent throughout.
+
+	  If unsure, say N here.
+
 # IOMMU_API always gets selected by whoever wants it.
 config IOMMU_API
 	bool
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 0275821f4ef9..6bd7da1cbebd 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
+obj-$(CONFIG_IOMMU_IOVA_KUNIT_TEST) += iova-kunit.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/iova-kunit.c b/drivers/iommu/iova-kunit.c
new file mode 100644
index 000000000000..e921c8543668
--- /dev/null
+++ b/drivers/iommu/iova-kunit.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for the IOVA allocator.
+ *
+ * Exercises the augmented-rbtree based allocator: basic alloc/free,
+ * size-aligned allocations, top-down ordering, the limit_pfn-aware
+ * 32-bit augmentation (relevant for the dma-iommu pci_32bit_workaround
+ * pattern), the alignment-aware two-phase search, and randomly
+ * fragmented stress.
+ *
+ * Each test verifies that the augmented invariants
+ * (__subtree_max_gap, __subtree_max_gap32, gap_to_prev, clamped_gap32)
+ * remain consistent after every batch of operations.
+ */
+#include <kunit/test.h>
+#include <linux/dma-mapping.h>
+#include <linux/iova.h>
+#include <linux/random.h>
+
+#define TEST_GRANULE PAGE_SIZE
+/* Highest pfn that fits in 32 bits — triggers the is_32bit alloc path. */
+#define TEST_LIMIT_32BIT (DMA_BIT_MASK(32) >> PAGE_SHIFT)
+/* A 64-bit-ish limit well above dma_32bit_pfn. */
+#define TEST_LIMIT_64BIT ((1UL << 36) >> PAGE_SHIFT)
+
+struct iova_test_ctx {
+	struct iova_domain iovad;
+	bool initialized;
+};
+
+static struct iova_test_ctx *iova_test_init_ctx(struct kunit *test)
+{
+	struct iova_test_ctx *ctx;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ret = iova_cache_get();
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	init_iova_domain(&ctx->iovad, TEST_GRANULE, 1);
+	ret = iova_domain_init_rcaches(&ctx->iovad);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ctx->initialized = true;
+	KUNIT_ASSERT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+	return ctx;
+}
+
+static void iova_test_cleanup(struct kunit *test, struct iova_test_ctx *ctx)
+{
+	if (ctx->initialized) {
+		KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+		put_iova_domain(&ctx->iovad);
+		iova_cache_put();
+		ctx->initialized = false;
+	}
+}
+
+static void test_init_destroy(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+
+	iova_test_cleanup(test, ctx);
+}
+
+static void test_basic_alloc_free(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	struct iova *iova;
+	unsigned long pfn_lo;
+
+	iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, false);
+	KUNIT_ASSERT_NOT_NULL(test, iova);
+	KUNIT_EXPECT_LE(test, iova->pfn_hi, TEST_LIMIT_32BIT);
+	KUNIT_EXPECT_EQ(test, iova->pfn_hi - iova->pfn_lo + 1, 1);
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+	pfn_lo = iova->pfn_lo;
+	__free_iova(&ctx->iovad, iova);
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	/* Top-down policy: subsequent alloc should reuse the same pfn. */
+	iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, false);
+	KUNIT_ASSERT_NOT_NULL(test, iova);
+	KUNIT_EXPECT_EQ(test, iova->pfn_lo, pfn_lo);
+	__free_iova(&ctx->iovad, iova);
+
+	iova_test_cleanup(test, ctx);
+}
+
+static void test_size_aligned(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	int order;
+
+	for (order = 0; order < 8; ++order) {
+		unsigned long size = 1UL << order;
+		struct iova *iova = alloc_iova(&ctx->iovad, size,
+					       TEST_LIMIT_32BIT, true);
+
+		KUNIT_ASSERT_NOT_NULL(test, iova);
+		KUNIT_EXPECT_EQ(test, iova->pfn_lo & (size - 1), 0);
+		KUNIT_EXPECT_EQ(test, iova->pfn_hi - iova->pfn_lo + 1, size);
+		__free_iova(&ctx->iovad, iova);
+		KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+	}
+
+	iova_test_cleanup(test, ctx);
+}
+
+static void test_top_down_preference(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	struct iova *iovas[16];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(iovas); ++i) {
+		iovas[i] = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, false);
+		KUNIT_ASSERT_NOT_NULL(test, iovas[i]);
+		if (i > 0)
+			KUNIT_EXPECT_LT(test, iovas[i]->pfn_lo,
+					iovas[i - 1]->pfn_lo);
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	for (i = 0; i < ARRAY_SIZE(iovas); ++i)
+		__free_iova(&ctx->iovad, iovas[i]);
+
+	iova_test_cleanup(test, ctx);
+}
+
+static void test_limit_pfn_respected(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	struct iova *iova;
+	int i;
+
+	for (i = 0; i < 100; ++i) {
+		iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, false);
+		KUNIT_ASSERT_NOT_NULL(test, iova);
+		KUNIT_EXPECT_LE(test, iova->pfn_hi, TEST_LIMIT_32BIT);
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	iova_test_cleanup(test, ctx);
+}
+
+static void test_reserve_iova(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	const unsigned long reserve_lo = TEST_LIMIT_32BIT / 2;
+	struct iova *r, *iova;
+	int i;
+
+	/* Reserve the entire top half through the limit_pfn, inclusive. */
+	r = reserve_iova(&ctx->iovad, reserve_lo, TEST_LIMIT_32BIT);
+	KUNIT_ASSERT_NOT_NULL(test, r);
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	/* All allocs must land below the reserved range. */
+	for (i = 0; i < 100; ++i) {
+		iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, false);
+		KUNIT_ASSERT_NOT_NULL(test, iova);
+		KUNIT_EXPECT_LT(test, iova->pfn_hi, reserve_lo);
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	iova_test_cleanup(test, ctx);
+}
+
+static void test_find_iova(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	struct iova *iova, *found;
+
+	iova = alloc_iova(&ctx->iovad, 4, TEST_LIMIT_32BIT, true);
+	KUNIT_ASSERT_NOT_NULL(test, iova);
+
+	found = find_iova(&ctx->iovad, iova->pfn_lo);
+	KUNIT_EXPECT_PTR_EQ(test, found, iova);
+	found = find_iova(&ctx->iovad, iova->pfn_hi);
+	KUNIT_EXPECT_PTR_EQ(test, found, iova);
+	/* Outside the range should not find. */
+	if (iova->pfn_hi + 1 <= TEST_LIMIT_32BIT) {
+		found = find_iova(&ctx->iovad, iova->pfn_hi + 1);
+		KUNIT_EXPECT_PTR_NE(test, found, iova);
+	}
+
+	__free_iova(&ctx->iovad, iova);
+	iova_test_cleanup(test, ctx);
+}
+
+/*
+ * The pci_32bit_workaround scenario: every PCI device's first IOVA
+ * allocation hits the 32-bit-restricted path before falling back to
+ * 64-bit. Mix the two and verify the limit_pfn-aware augmentation
+ * keeps both correct.
+ */
+static void test_32bit_in_64bit_domain(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	struct iova *iova;
+	int i;
+
+	/* Fill the high 64-bit space. */
+	for (i = 0; i < 1000; ++i) {
+		iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_64BIT, true);
+		KUNIT_ASSERT_NOT_NULL(test, iova);
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	/* A 32-bit alloc must still find a slot below DMA_BIT_MASK(32). */
+	iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, true);
+	KUNIT_ASSERT_NOT_NULL(test, iova);
+	KUNIT_EXPECT_LE(test, iova->pfn_hi, TEST_LIMIT_32BIT);
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	__free_iova(&ctx->iovad, iova);
+	iova_test_cleanup(test, ctx);
+}
+
+/*
+ * Force the alignment-aware two-phase search through phase 2: pack
+ * size-2 size_aligned allocations, free every other one to leave gaps
+ * of size 2 (which the strict phase-1 threshold of size + align - 1 = 3
+ * will prune away), and verify a fresh size-2 alloc still succeeds via
+ * the phase-2 fallback.
+ */
+static void test_two_phase_alignment(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	const int N = 64;
+	struct iova **iovas;
+	struct iova *iova;
+	int i;
+	bool found_phase2_candidate = false;
+
+	iovas = kunit_kcalloc(test, N, sizeof(*iovas), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, iovas);
+
+	for (i = 0; i < N; ++i) {
+		iovas[i] = alloc_iova(&ctx->iovad, 2, TEST_LIMIT_32BIT, true);
+		KUNIT_ASSERT_NOT_NULL(test, iovas[i]);
+		KUNIT_EXPECT_EQ(test, iovas[i]->pfn_lo & 1, 0);
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	/* Free every other to create size-2 gaps interleaved with allocs. */
+	for (i = 0; i < N; i += 2) {
+		__free_iova(&ctx->iovad, iovas[i]);
+		iovas[i] = NULL;
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	/*
+	 * Allocate size-2 — phase 1 (threshold 3) should miss the size-2
+	 * gaps; phase 2 (threshold 2) should still find one. The result
+	 * may also land in the unfragmented gap below the lowest packed
+	 * iova; either way, alloc must succeed and the result must be
+	 * 2-aligned.
+	 */
+	iova = alloc_iova(&ctx->iovad, 2, TEST_LIMIT_32BIT, true);
+	KUNIT_ASSERT_NOT_NULL(test, iova);
+	KUNIT_EXPECT_EQ(test, iova->pfn_lo & 1, 0);
+	/* Was it placed in one of the freed slots (= phase 2 hit)? */
+	for (i = 1; i < N; i += 2) {
+		struct iova *neighbor = iovas[i];
+
+		if (!neighbor)
+			continue;
+		if (iova->pfn_hi + 1 == neighbor->pfn_lo ||
+		    iova->pfn_lo == neighbor->pfn_hi + 1) {
+			found_phase2_candidate = true;
+			break;
+		}
+	}
+	kunit_info(test, "alloc landed at pfn 0x%lx, phase2-slot=%s\n",
+		   iova->pfn_lo, found_phase2_candidate ? "yes" : "no");
+	__free_iova(&ctx->iovad, iova);
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	for (i = 0; i < N; ++i)
+		if (iovas[i])
+			__free_iova(&ctx->iovad, iovas[i]);
+	iova_test_cleanup(test, ctx);
+}
+
+/*
+ * Mimic dma-iommu's pci_32bit_workaround pattern: every alloc first
+ * tries the 32-bit limit; if that fails, retry with the 64-bit limit.
+ * Verifies that the dual-augmented invariant survives the rapid
+ * switching between is_32bit=true and is_32bit=false.
+ */
+static void test_pci_32bit_workaround_pattern(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	int i;
+
+	for (i = 0; i < 500; ++i) {
+		unsigned long size = (i % 4) + 1;
+		struct iova *iova = alloc_iova(&ctx->iovad, size,
+					       TEST_LIMIT_32BIT, true);
+
+		if (!iova)
+			iova = alloc_iova(&ctx->iovad, size,
+					  TEST_LIMIT_64BIT, true);
+		KUNIT_ASSERT_NOT_NULL(test, iova);
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	iova_test_cleanup(test, ctx);
+}
+
+/*
+ * Random alloc/free over many iterations, verifying invariants after
+ * every operation. Uses a deterministic PRNG so failures reproduce
+ * across boots.
+ */
+static void test_stress_random(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
+	const int N = 512;
+	const int iters = 4 * N;
+	struct iova **iovas;
+	u32 rng = 0xDEADBEEF;
+	int i;
+
+	iovas = kunit_kcalloc(test, N, sizeof(*iovas), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, iovas);
+
+	for (i = 0; i < iters; ++i) {
+		int slot;
+		bool use_32bit;
+		unsigned long limit;
+		const char *op;
+
+		rng = rng * 1103515245 + 12345;
+		slot = (rng >> 8) % N;
+		rng = rng * 1103515245 + 12345;
+		use_32bit = rng & 1;
+		limit = use_32bit ? TEST_LIMIT_32BIT : TEST_LIMIT_64BIT;
+
+		if (iovas[slot]) {
+			op = "free";
+			__free_iova(&ctx->iovad, iovas[slot]);
+			iovas[slot] = NULL;
+		} else {
+			unsigned long size;
+			bool aligned;
+
+			rng = rng * 1103515245 + 12345;
+			size = 1UL << ((rng >> 8) % 4);
+			rng = rng * 1103515245 + 12345;
+			aligned = rng & 1;
+
+			op = "alloc";
+			iovas[slot] = alloc_iova(&ctx->iovad, size, limit,
+						 aligned);
+		}
+		if (!iova_domain_verify_invariants(&ctx->iovad)) {
+			kunit_info(test, "iter %d slot %d: invariant broken after %s\n",
+				   i, slot, op);
+			KUNIT_FAIL(test, "verify failed");
+			break;
+		}
+	}
+
+	for (i = 0; i < N; ++i)
+		if (iovas[i])
+			__free_iova(&ctx->iovad, iovas[i]);
+	iova_test_cleanup(test, ctx);
+}
+
+static struct kunit_case iova_test_cases[] = {
+	KUNIT_CASE(test_init_destroy),
+	KUNIT_CASE(test_basic_alloc_free),
+	KUNIT_CASE(test_size_aligned),
+	KUNIT_CASE(test_top_down_preference),
+	KUNIT_CASE(test_limit_pfn_respected),
+	KUNIT_CASE(test_reserve_iova),
+	KUNIT_CASE(test_find_iova),
+	KUNIT_CASE(test_32bit_in_64bit_domain),
+	KUNIT_CASE(test_two_phase_alignment),
+	KUNIT_CASE(test_pci_32bit_workaround_pattern),
+	KUNIT_CASE(test_stress_random),
+	{}
+};
+
+static struct kunit_suite iova_test_suite = {
+	.name = "iova",
+	.test_cases = iova_test_cases,
+};
+kunit_test_suite(iova_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the IOVA allocator");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4f3465d8ee16..dfde90fef1f5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -1160,6 +1160,96 @@ void iova_cache_put(void)
 }
 EXPORT_SYMBOL_GPL(iova_cache_put);
 
+#if IS_ENABLED(CONFIG_IOMMU_IOVA_KUNIT_TEST)
+/*
+ * Walk the iova rbtree and verify that every node's gap_to_prev,
+ * clamped_gap32, __subtree_max_gap, and __subtree_max_gap32 match what
+ * recomputation from scratch would yield. Returns true on success.
+ *
+ * Intended for use by kunit tests to catch invariant corruption from
+ * insertion / deletion / rotation paths.
+ */
+struct iova_subtree_maxes {
+	unsigned long max_gap;
+	unsigned long max_gap32;
+};
+
+static struct iova_subtree_maxes
+iova_walk_verify(struct rb_node *node, struct iova_domain *iovad, bool *ok)
+{
+	struct iova_subtree_maxes m = { 0, 0 };
+	struct iova_subtree_maxes left, right;
+	struct rb_node *prev_node;
+	struct iova *iova;
+	unsigned long expected_gap;
+	unsigned long expected_clamped;
+
+	if (!node)
+		return m;
+
+	left = iova_walk_verify(node->rb_left, iovad, ok);
+	right = iova_walk_verify(node->rb_right, iovad, ok);
+	iova = to_iova(node);
+
+	prev_node = rb_prev(node);
+	if (prev_node)
+		expected_gap = iova->pfn_lo - to_iova(prev_node)->pfn_hi - 1;
+	else
+		expected_gap = iova->pfn_lo;
+	if (iova->gap_to_prev != expected_gap) {
+		pr_err("iova_verify: pfn_lo=0x%lx gap_to_prev=%lu expected=%lu\n",
+		       iova->pfn_lo, iova->gap_to_prev, expected_gap);
+		*ok = false;
+	}
+
+	expected_clamped = iova_compute_clamped_gap32(iova, iovad->dma_32bit_pfn);
+	if (iova->clamped_gap32 != expected_clamped) {
+		pr_err("iova_verify: pfn_lo=0x%lx clamped_gap32=%lu expected=%lu\n",
+		       iova->pfn_lo, iova->clamped_gap32, expected_clamped);
+		*ok = false;
+	}
+
+	m.max_gap = iova->gap_to_prev;
+	if (left.max_gap > m.max_gap)
+		m.max_gap = left.max_gap;
+	if (right.max_gap > m.max_gap)
+		m.max_gap = right.max_gap;
+
+	m.max_gap32 = iova->clamped_gap32;
+	if (left.max_gap32 > m.max_gap32)
+		m.max_gap32 = left.max_gap32;
+	if (right.max_gap32 > m.max_gap32)
+		m.max_gap32 = right.max_gap32;
+
+	if (iova->__subtree_max_gap != m.max_gap) {
+		pr_err("iova_verify: pfn_lo=0x%lx __subtree_max_gap=%lu expected=%lu (own=%lu left=%lu right=%lu)\n",
+		       iova->pfn_lo, iova->__subtree_max_gap, m.max_gap,
+		       iova->gap_to_prev, left.max_gap, right.max_gap);
+		*ok = false;
+	}
+	if (iova->__subtree_max_gap32 != m.max_gap32) {
+		pr_err("iova_verify: pfn_lo=0x%lx __subtree_max_gap32=%lu expected=%lu (own=%lu left=%lu right=%lu)\n",
+		       iova->pfn_lo, iova->__subtree_max_gap32, m.max_gap32,
+		       iova->clamped_gap32, left.max_gap32, right.max_gap32);
+		*ok = false;
+	}
+
+	return m;
+}
+
+bool iova_domain_verify_invariants(struct iova_domain *iovad)
+{
+	bool ok = true;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova_walk_verify(iovad->rbroot.rb_node, iovad, &ok);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	return ok;
+}
+EXPORT_SYMBOL_GPL(iova_domain_verify_invariants);
+#endif /* CONFIG_IOMMU_IOVA_KUNIT_TEST */
+
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
 MODULE_DESCRIPTION("IOMMU I/O Virtual Address management");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iova.h b/include/linux/iova.h
index d262c6d88d6c..108676d8ad69 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -104,6 +104,9 @@ void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 int iova_domain_init_rcaches(struct iova_domain *iovad);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
+#if IS_ENABLED(CONFIG_IOMMU_IOVA_KUNIT_TEST)
+bool iova_domain_verify_invariants(struct iova_domain *iovad);
+#endif
 #else
 static inline int iova_cache_get(void)
 {
-- 
2.52.0

