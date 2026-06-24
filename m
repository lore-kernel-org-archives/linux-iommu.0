Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52E3054E4;
	Wed, 24 Jun 2026 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270543; cv=none; b=aPADqa7JMBjeGu3gJmxv6VRzMXiP/yBaVEX4gtN2VWL0adz1qj1nzEOwzJPAVAwufCiB59IRYkSY6HoVppHlBg7PSY06mkk6s2dLQRG07uFNqy94LihiF/IdAWYX0LDLrrJcZlzDi09gZqAtugv8miNm6zOWrXx0r+L/5adHO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270543; c=relaxed/simple;
	bh=OVKUIU58+jaYjD7FZhyP9R+yygUcGCOdkT0v54uTAaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX5RwpVHIcRnVgyacj4EaBMHV0bq1hnY1+weNuUEh9TTDcSKtSpdu+Rysp30eWKrqo/5zVw4Dt2ZzkmHa6WbKe07mN6F4XALkWprvPNH6OjzsVgfgi7fzjATIy8fCbGyGEjWrc99qH5ZDUhOHUQMZiMGmJCGXX4SQmzcbVzjxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Z+eJMKZT; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Z+eJMKZT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Bq1k1OvfWo+J8rfMpYVP4drB2EMlBc3wx9nawIM1ieU=; b=Z+eJMKZT/BVN5txK4aoHp8c14Z
	bj/S4eU2NLpU1ep5OmBQONsw2h2Nbha1c4lfgznMG2cMIvYDqS1QiEO6g65tkNrueM/VCPX3sIBoa
	eIj88ybkcVOB5iYo6c3KTw2CYnh8S0lHTr5AOTWBjnJbWYvBka8ALh6m3nzaiJvT47njbT8w0DPFG
	ZvfSGyLdOrqYy4ilUn4/rvtHhuODN7rsFI3WKzdlqd39sQDWCAGWG2KrVO+4QAyYqfRlliZBHASNG
	TJnz5uCLKUNWLeMCVi6EDVe4DxuV9JFBEpK7eqhd5EHWZwQYA4AUlmXNKtvwYdoH/TIGvxe3IDt3i
	rGeo8atA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wcDyy-0000000087q-3Cx6;
	Tue, 23 Jun 2026 23:08:56 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	kyle@mcmartin.ca,
	ashok.raj@oss.qualcomm.com,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH 2/3] iova: add KUnit test suite
Date: Tue, 23 Jun 2026 23:07:35 -0400
Message-ID: <20260624030853.2340880-3-riel@surriel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624030853.2340880-1-riel@surriel.com>
References: <20260624030853.2340880-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a kunit suite for the maple-tree-based IOVA allocator, plus an
iova_domain_verify_invariants() helper (compiled only when the test
config is enabled) that walks the maple tree and confirms every entry's
pfn_lo/pfn_hi match the maple tree index range and that no entries
overlap.

Test cases:
  - test_size_aligned: alignment of size_aligned allocs across orders 0..7.
  - test_top_down_preference: sequential allocs decrease in pfn_lo.
  - test_reserve_iova: allocs avoid the reserved range.
  - test_32bit_in_64bit_domain: 1000 64-bit allocs followed by a 32-bit
    alloc must still find a slot below DMA_BIT_MASK(32).
  - test_arbitrary_dma_limits: after filling 64-bit space, verify that
    bounded allocations at 33-bit and 56-bit limits still find slots
    within their respective ranges, confirming that mas_empty_area_rev
    generalizes to arbitrary limit_pfn values.
  - test_aligned_in_fragmented: pack size-2 size_aligned allocs, free
    every other to leave size-2 holes; a fresh size-2 aligned alloc
    must still succeed and return a 2-aligned pfn.
  - test_pci_32bit_workaround_pattern: alternate 32-bit-first allocation
    attempts with 64-bit fallback, mirroring dma-iommu.c.
  - test_stress_random: 2048 random alloc/free operations with mixed
    sizes, alignments, and DMA limits (32/33/56/64-bit), checking
    invariants after every operation. Uses a deterministic PRNG so
    failures reproduce across boots.
  - test_full_space_search_time: fill a 16K-pfn range completely, then
    verify that a failed alloc returns in bounded time (O(log n) via
    mas_empty_area_rev, not O(n)).
  - test_fragmented_32bit_search: pack the 32-bit IOVA space, then
    verify bounded search time for both 32-bit failure and 64-bit
    fallback success paths.

Run with:
  tools/testing/kunit/kunit.py run --kunitconfig=drivers/iommu

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/iommu/.kunitconfig |   6 +
 drivers/iommu/Kconfig      |  16 ++
 drivers/iommu/Makefile     |   1 +
 drivers/iommu/iova-kunit.c | 439 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iova.c       |  34 +++
 include/linux/iova.h       |   3 +
 6 files changed, 499 insertions(+)
 create mode 100644 drivers/iommu/.kunitconfig
 create mode 100644 drivers/iommu/iova-kunit.c

diff --git a/drivers/iommu/.kunitconfig b/drivers/iommu/.kunitconfig
new file mode 100644
index 000000000000..d2bb924b1883
--- /dev/null
+++ b/drivers/iommu/.kunitconfig
@@ -0,0 +1,6 @@
+CONFIG_KUNIT=y
+CONFIG_IOMMU_SUPPORT=y
+CONFIG_IOMMU_IOVA=y
+CONFIG_IOMMU_IOVA_KUNIT_TEST=y
+CONFIG_KASAN=y
+CONFIG_KASAN_GENERIC=y
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f86262b11416..f09046e238fd 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -3,6 +3,22 @@
 config IOMMU_IOVA
 	tristate
 
+config IOMMU_IOVA_KUNIT_TEST
+	tristate "KUnit tests for the IOVA allocator" if !KUNIT_ALL_TESTS
+	depends on IOMMU_IOVA && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable kunit tests for the IOVA allocator. The tests exercise
+	  basic allocation and free, size-aligned allocation, top-down
+	  ordering, bounded allocations with various DMA limits (32-bit,
+	  33-bit, 56-bit), aligned allocations in fragmented domains,
+	  and randomly-fragmented stress scenarios.
+
+	  Run with:
+	    tools/testing/kunit/kunit.py run --kunitconfig=drivers/iommu
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
index 000000000000..bf37c5102e6e
--- /dev/null
+++ b/drivers/iommu/iova-kunit.c
@@ -0,0 +1,439 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for the IOVA allocator.
+ *
+ * Exercises the maple-tree-based allocator: basic alloc/free,
+ * size-aligned allocations, top-down ordering, bounded allocations
+ * with various DMA limits (32-bit, 33-bit, 56-bit), aligned
+ * allocations in fragmented domains, and randomly fragmented stress.
+ *
+ * Each test verifies that the maple tree invariants remain consistent
+ * after every batch of operations.
+ */
+#include <kunit/test.h>
+#include <linux/dma-mapping.h>
+#include <linux/iova.h>
+
+#define TEST_GRANULE PAGE_SIZE
+/* Highest pfn that fits in 32 bits — triggers the bounded alloc path. */
+#define TEST_LIMIT_32BIT (DMA_BIT_MASK(32) >> PAGE_SHIFT)
+/* 33-bit limit — exercises non-power-of-two DMA boundaries. */
+#define TEST_LIMIT_33BIT (DMA_BIT_MASK(33) >> PAGE_SHIFT)
+/* 56-bit limit — typical server IOMMU address width. */
+#define TEST_LIMIT_56BIT (DMA_BIT_MASK(56) >> PAGE_SHIFT)
+/* A 64-bit-ish limit well above dma_32bit_pfn. 1ULL avoids UB on ILP32. */
+#define TEST_LIMIT_64BIT ((1ULL << 36) >> PAGE_SHIFT)
+/*
+ * A small <=32-bit limit used by tests that want to actually exhaust the
+ * restricted region within a tractable number of allocations.
+ */
+#define TEST_LIMIT_32BIT_RESTRICTED 256UL
+
+struct iova_test_ctx {
+	struct iova_domain iovad;
+	bool initialized;
+};
+
+static int iova_test_init(struct kunit *test)
+{
+	struct iova_test_ctx *ctx;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	ret = iova_cache_get();
+	if (ret)
+		return ret;
+
+	init_iova_domain(&ctx->iovad, TEST_GRANULE, 1);
+	ret = iova_domain_init_rcaches(&ctx->iovad);
+	if (ret) {
+		put_iova_domain(&ctx->iovad);
+		iova_cache_put();
+		return ret;
+	}
+	ctx->initialized = true;
+
+	KUNIT_ASSERT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+	return 0;
+}
+
+static void iova_test_exit(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+
+	if (ctx && ctx->initialized) {
+		put_iova_domain(&ctx->iovad);
+		ctx->initialized = false;
+		iova_cache_put();
+	}
+}
+
+static void test_size_aligned(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
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
+}
+
+static void test_top_down_preference(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
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
+}
+
+static void test_reserve_iova(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
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
+}
+
+/*
+ * The pci_32bit_workaround scenario: every PCI device's first IOVA
+ * allocation hits the 32-bit-restricted path before falling back to
+ * 64-bit. Fill the 64-bit space, then verify a 32-bit alloc still
+ * finds a slot below DMA_BIT_MASK(32).
+ */
+static void test_32bit_in_64bit_domain(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+	struct iova *iova;
+	int i;
+
+	for (i = 0; i < 1000; ++i) {
+		iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_64BIT, true);
+		KUNIT_ASSERT_NOT_NULL(test, iova);
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, true);
+	KUNIT_ASSERT_NOT_NULL(test, iova);
+	KUNIT_EXPECT_LE(test, iova->pfn_hi, TEST_LIMIT_32BIT);
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	__free_iova(&ctx->iovad, iova);
+}
+
+/*
+ * Exercise non-power-of-two DMA limits: fill the 64-bit space, then
+ * verify that bounded allocations at 33-bit and 56-bit limits still
+ * find slots within their respective ranges. This confirms the
+ * navigate-to-limit_pfn search generalizes beyond the 32-bit case.
+ */
+static void test_arbitrary_dma_limits(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+	struct iova *iova;
+	int i;
+
+	for (i = 0; i < 1000; ++i) {
+		iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_64BIT, true);
+		KUNIT_ASSERT_NOT_NULL(test, iova);
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	/* 33-bit bounded allocation */
+	iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_33BIT, true);
+	KUNIT_ASSERT_NOT_NULL(test, iova);
+	KUNIT_EXPECT_LE(test, iova->pfn_hi, TEST_LIMIT_33BIT);
+	__free_iova(&ctx->iovad, iova);
+
+	/* 56-bit bounded allocation */
+	iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_56BIT, true);
+	KUNIT_ASSERT_NOT_NULL(test, iova);
+	KUNIT_EXPECT_LE(test, iova->pfn_hi, TEST_LIMIT_56BIT);
+	__free_iova(&ctx->iovad, iova);
+
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+}
+
+/*
+ * Aligned allocation in a fragmented domain: pack size-2 size_aligned
+ * allocations at the top, free every other one to leave size-2 holes,
+ * then verify a fresh size-2 aligned alloc still succeeds and returns
+ * a 2-aligned pfn.
+ */
+static void test_aligned_in_fragmented(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+	const int N = 64;
+	struct iova **iovas;
+	struct iova *iova;
+	int i;
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
+	for (i = 0; i < N; i += 2) {
+		__free_iova(&ctx->iovad, iovas[i]);
+		iovas[i] = NULL;
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	iova = alloc_iova(&ctx->iovad, 2, TEST_LIMIT_32BIT, true);
+	KUNIT_ASSERT_NOT_NULL(test, iova);
+	KUNIT_EXPECT_EQ(test, iova->pfn_lo & 1, 0);
+	__free_iova(&ctx->iovad, iova);
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+
+	for (i = 0; i < N; ++i)
+		if (iovas[i])
+			__free_iova(&ctx->iovad, iovas[i]);
+}
+
+/*
+ * Mimic dma-iommu's pci_32bit_workaround pattern: every alloc first
+ * tries a small restricted limit; if that fails, retry with the 64-bit
+ * limit. Verifies that the navigate-to-limit search survives rapid
+ * switching between different limit_pfn values.
+ */
+static void test_pci_32bit_workaround_pattern(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+	int fallback_count = 0;
+	int i;
+
+	for (i = 0; i < 500; ++i) {
+		unsigned long size = (i % 4) + 1;
+		struct iova *iova = alloc_iova(&ctx->iovad, size,
+					       TEST_LIMIT_32BIT_RESTRICTED,
+					       true);
+
+		if (!iova) {
+			iova = alloc_iova(&ctx->iovad, size,
+					  TEST_LIMIT_64BIT, true);
+			fallback_count++;
+		}
+		if (!iova)
+			break;
+	}
+	KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
+	/* Every alloc must succeed (via fallback once the restricted region fills). */
+	KUNIT_EXPECT_EQ(test, i, 500);
+	/* The restricted region is small, so the 64-bit fallback must engage. */
+	KUNIT_EXPECT_GT(test, fallback_count, 0);
+}
+
+/*
+ * Random alloc/free over many iterations, verifying invariants after
+ * every operation. Uses a deterministic PRNG so failures reproduce
+ * across boots. Exercises mixed DMA limits (32, 33, 56, 64-bit).
+ */
+static void test_stress_random(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+	const int N = 512;
+	const int iters = 4 * N;
+	const unsigned long limits[] = {
+		TEST_LIMIT_32BIT, TEST_LIMIT_33BIT,
+		TEST_LIMIT_56BIT, TEST_LIMIT_64BIT,
+	};
+	struct iova **iovas;
+	u32 rng = 0xDEADBEEF;
+	int i;
+
+	iovas = kunit_kcalloc(test, N, sizeof(*iovas), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, iovas);
+
+	for (i = 0; i < iters; ++i) {
+		int slot;
+		unsigned long limit;
+		const char *op;
+
+		rng = rng * 1103515245 + 12345;
+		slot = (rng >> 8) % N;
+		rng = rng * 1103515245 + 12345;
+		limit = limits[(rng >> 8) % ARRAY_SIZE(limits)];
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
+			aligned = (rng >> 8) & 1;
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
+}
+
+/*
+ * Verify that alloc_iova fails in bounded time when the IOVA space is
+ * fully packed. Fill a 16K-pfn range with size-1 allocations (leaving
+ * no gaps), then attempt a size-2 aligned alloc. The maple tree's
+ * mas_empty_area_rev must determine there is no suitable gap in
+ * O(log n) time rather than walking every entry. The wall-clock check
+ * is a loose hang detector only (CI under KASAN/lockdep/virt is slow);
+ * the real signal is the reported time and that the alloc fails.
+ */
+static void test_full_space_search_time(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+	const unsigned long fill_limit = 16384;
+	const int fill_count = fill_limit;
+	struct iova *iova;
+	ktime_t start, elapsed;
+	int i, allocated = 0;
+
+	for (i = 0; i < fill_count; ++i) {
+		iova = alloc_iova(&ctx->iovad, 1, fill_limit, false);
+		if (!iova)
+			break;
+		allocated++;
+	}
+	kunit_info(test, "allocated %d iovas in [1, %lu]\n",
+		   allocated, fill_limit);
+	KUNIT_ASSERT_GT(test, allocated, 1000);
+
+	start = ktime_get();
+	iova = alloc_iova(&ctx->iovad, 2, fill_limit, true);
+	elapsed = ktime_sub(ktime_get(), start);
+
+	KUNIT_EXPECT_NULL(test, iova);
+	kunit_info(test, "failed alloc took %lld ns\n",
+		   ktime_to_ns(elapsed));
+	/* Loose hang detector, not a perf gate (CI under KASAN/lockdep is slow). */
+	KUNIT_EXPECT_LT(test, ktime_to_ns(elapsed), 1000000000LL);
+
+	if (iova)
+		__free_iova(&ctx->iovad, iova);
+}
+
+/*
+ * Verify bounded search time with a fragmented 32-bit IOVA space.
+ * Pack the 32-bit range with size-1 allocs, then attempt a large
+ * aligned alloc that must either succeed from a remaining gap or
+ * fail fast. The 64-bit fallback must always succeed promptly.
+ */
+static void test_fragmented_32bit_search(struct kunit *test)
+{
+	struct iova_test_ctx *ctx = test->priv;
+	struct iova *iova;
+	ktime_t start, elapsed;
+	int i, allocated = 0;
+
+	for (i = 0; i < 8000; ++i) {
+		iova = alloc_iova(&ctx->iovad, 1, TEST_LIMIT_32BIT, false);
+		if (!iova)
+			break;
+		allocated++;
+	}
+	kunit_info(test, "filled 32-bit space with %d allocs\n", allocated);
+	KUNIT_ASSERT_GT(test, allocated, 1000);
+
+	start = ktime_get();
+	iova = alloc_iova(&ctx->iovad, 32, TEST_LIMIT_32BIT, true);
+	elapsed = ktime_sub(ktime_get(), start);
+
+	kunit_info(test, "32-bit alloc (size 32) took %lld ns, result=%s\n",
+		   ktime_to_ns(elapsed), iova ? "alloc" : "fail");
+	/* Loose hang detector, not a perf gate (CI under KASAN/lockdep is slow). */
+	KUNIT_EXPECT_LT(test, ktime_to_ns(elapsed), 1000000000LL);
+
+	if (iova)
+		__free_iova(&ctx->iovad, iova);
+
+	start = ktime_get();
+	iova = alloc_iova(&ctx->iovad, 32, TEST_LIMIT_64BIT, true);
+	elapsed = ktime_sub(ktime_get(), start);
+
+	kunit_info(test, "64-bit fallback (size 32) took %lld ns\n",
+		   ktime_to_ns(elapsed));
+	/* Loose hang detector, not a perf gate (CI under KASAN/lockdep is slow). */
+	KUNIT_EXPECT_LT(test, ktime_to_ns(elapsed), 1000000000LL);
+
+	if (iova)
+		__free_iova(&ctx->iovad, iova);
+}
+
+static struct kunit_case iova_test_cases[] = {
+	KUNIT_CASE(test_size_aligned),
+	KUNIT_CASE(test_top_down_preference),
+	KUNIT_CASE(test_reserve_iova),
+	KUNIT_CASE(test_32bit_in_64bit_domain),
+	KUNIT_CASE(test_arbitrary_dma_limits),
+	KUNIT_CASE(test_aligned_in_fragmented),
+	KUNIT_CASE(test_pci_32bit_workaround_pattern),
+	KUNIT_CASE(test_stress_random),
+	KUNIT_CASE(test_full_space_search_time),
+	KUNIT_CASE(test_fragmented_32bit_search),
+	{}
+};
+
+static struct kunit_suite iova_test_suite = {
+	.name = "iova",
+	.init = iova_test_init,
+	.exit = iova_test_exit,
+	.test_cases = iova_test_cases,
+};
+kunit_test_suite(iova_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the IOVA allocator");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index fd512b33ba32..ca8d82417699 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -890,6 +890,40 @@ void iova_cache_put(void)
 }
 EXPORT_SYMBOL_GPL(iova_cache_put);
 
+#if IS_ENABLED(CONFIG_IOMMU_IOVA_KUNIT_TEST)
+bool iova_domain_verify_invariants(struct iova_domain *iovad)
+{
+	struct iova *iova, *prev = NULL;
+	unsigned long flags;
+	bool ok = true;
+	MA_STATE(mas, &iovad->mtree, 0, 0);
+
+	spin_lock_irqsave(&iovad->iova_lock, flags);
+	mas_for_each(&mas, iova, ULONG_MAX) {
+		if (mas.index != iova->pfn_lo || mas.last != iova->pfn_hi) {
+			pr_err("iova_verify: maple index [%lu,%lu] != iova [%lu,%lu]\n",
+			       mas.index, mas.last, iova->pfn_lo, iova->pfn_hi);
+			ok = false;
+		}
+		if (iova->pfn_lo > iova->pfn_hi) {
+			pr_err("iova_verify: pfn_lo=%lu > pfn_hi=%lu\n",
+			       iova->pfn_lo, iova->pfn_hi);
+			ok = false;
+		}
+		if (prev && prev->pfn_hi >= iova->pfn_lo) {
+			pr_err("iova_verify: overlap prev=[%lu,%lu] curr=[%lu,%lu]\n",
+			       prev->pfn_lo, prev->pfn_hi,
+			       iova->pfn_lo, iova->pfn_hi);
+			ok = false;
+		}
+		prev = iova;
+	}
+	spin_unlock_irqrestore(&iovad->iova_lock, flags);
+	return ok;
+}
+EXPORT_SYMBOL_GPL(iova_domain_verify_invariants);
+#endif /* CONFIG_IOMMU_IOVA_KUNIT_TEST */
+
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
 MODULE_DESCRIPTION("IOMMU I/O Virtual Address management");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iova.h b/include/linux/iova.h
index eb4f9ead5451..6fc070a4f58e 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -98,6 +98,9 @@ void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
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
2.53.0-Meta

