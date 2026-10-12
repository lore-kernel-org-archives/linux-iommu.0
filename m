Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82945D93E
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796778; cv=none; b=eaUfMFmMNnQk77OoeZ/dPc/Q2otTUIO0aJYGx9E2x8HnaRRcHRF6q2MKaHRMeteZeR5+8GxH+5rVCax4NUjoEoYqHCMXXy5YnOT6mR+SlgSJ6o/keH6nHkNS9KolC5AT1HZA/B8tgX4UZtbzlaR8H86ODLtgIA23nOMSXCxmcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796778; c=relaxed/simple;
	bh=obaIpo3eOgezpEsPsap9TUAWD5nd9vcz+dt7ueXrN/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PhiIIaSp1KHrAil0uF1WYErc/5b4HHhdIjmbSP+UMqxJEJin8zJqS/3xillhFn5X3N3saR7eNi9WQxk323EEsm+yX8O5KXDvjqnjSWlrMMiaI32MH1r26bdspzPpItVtV2UmygaW0JydabwikX6hzZqYNLK2YWW/hfbumfnZAOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dIxz4dSI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dIxz4dSI"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ac9d666d4eso10279397b3.3
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791796770; x=1792401570; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KS04G9QI6SDGM7QnaFeP1XMtTamEXej+qIjwKiZ4vWM=;
        b=dIxz4dSI2C5pciPfmmGLPzKOKGbdD5YHfBFHMcPoxbnFlchO68DoW43ZDgNgDvtvR/
         /nbe0M+lhSKOT998U9aDgrnw1LtT+M1WBBwV650RdlsT6dndQHpNW7Yt4eBM3PYc+8M4
         WHhNfqg3q/dG/jJxs9pzVV/TaIIwVJ6jznswjuZlKTdgJIftA4WaZNqD122FY4IYhRg6
         AX/4eEQ4TiNICxWr8jSClyUH32XREeECSV3c3x3V+hs/CRoPhrPhNQAgwJzmFmC6LNwz
         G0vuSJpYZ036P9T0VjF0K85xkcsKxiQIGTrqUb+YX0lfnlcWpKflLVm3kahSGT3PAdYN
         FVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791796770; x=1792401570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KS04G9QI6SDGM7QnaFeP1XMtTamEXej+qIjwKiZ4vWM=;
        b=2w4pvxOD8hrT9Zp4X7XWIJR+V8hB7DBWEu/XAKt1/xfDSd0ZNm7eb1FWn/DiaIOPq0
         ZKQrIC/m7TmormQ89MnxGrhSXp1r9DVxdFnu/WmJ/1OXt0QA8siE7Ob3NgvwFO1eT5X6
         MHv0sQPgfCD1uHzrArRXTAjJb0kCxvLVHesElZO4+AcF1sPtFY0t9oYaziwcwKoncNaV
         523KV7q8tMQ2XK5BGhbkl557NCZXHoCsk+uMuzSBL8yPM/lStyQwtzx4q2qIN8N2kJvk
         XHCL+QJUR6cjWhN/npAJ+Q4MTponti+vLDEInsjPfqHkq2b/Y+YKvin4dTJkWCrVdeBI
         UBHA==
X-Forwarded-Encrypted: i=1; AKwUvBwsufy6Lz590LOcuEa+Gm/z/2QC6E37LXmxOA7aQOriULRbj4mC9dWIiXArG9RmvjHq/g6zYQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLQrS2hzdiAWBws/AekBlFF4rbtcba11URX6EjiDqibixo6+gzc
	wMPkya8LSxn5by7133+dnQBpoSigDA71TWdzfA2jBXlqB4B4j3H2+qNajUCz4Jtb/lYhmzaKT/m
	XZwMqUEsimQ==
X-Gm-Gg: AYBFou0ha2G3M4bI98lzt/LYfpImxvS2CfSRe4ziGqNzbMsuznktNjtV/bsnqKQKBI/
	+E9aRGNMbziMeSbdAGlvmeDTNkXf5203PQN972ldbSYRvHq0wPatI4naS0/IJgcGLKMp9sp+fSU
	RnJZSe+zcRMztr5wKy94o+m3WctRyRGX6flEP57vd4JWN/E3Bn/o1vWdeQvGYIwAeQd6R8k8nVs
	H6TB5MKiPYtakr2WZVC+JrMVGXbWudxFjOaFYBGuUGMM9T9eSAR52AHp6x/+eAX9RreCo0yL7XS
	PeCLDV+/QALN0QsgXMT2gKtuMS5bmeV8qLhxjkWVB+nrMGnihzTCyYm3ZknQftFsvvpqLAN6vCR
	B56Nm5fAGQ3wpy8DiiD2yCLw1Ubp2KrxbiT8enGNtk3xLQSEJfk9E49itKePc+mHSBu61sSWPal
	+2+eROHmpnQoKtvhK0MiSn4dvb75QlVpMxnJZXcrPZdZKV9ies9wJ4i1HwJFblTv0L/F5VuWsKd
	BnKEMYyF9lvuxe1wZ7hgTBSnacR19M=
X-Received: by 2002:a05:690c:d88:b0:8a8:7fda:15f9 with SMTP id 00721157ae682-8b07ee2d25emr24516707b3.61.1791796770459;
        Mon, 12 Oct 2026 02:19:30 -0700 (PDT)
Received: from numbers.baylibre (82-67-228-18.subs.proxad.net. [82.67.228.18])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f263bc8sm31327387b3.45.2026.10.12.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:19:30 -0700 (PDT)
From: Daniel Drake <ddrake@baylibre.com>
To: jgg@ziepe.ca
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	Daniel Drake <ddrake@baylibre.com>
Subject: [RFC] Subpage allocations for IOMMU tables
Date: Mon, 12 Oct 2026 11:18:23 +0200
Message-ID: <20261012091823.114480-1-ddrake@baylibre.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason & co,

I have been experimenting for how we might support allocations smaller
than PAGE_SIZE from iommu_alloc_pages_sz(). Are there any existing
ideas or plans for how this could be done?

This would be particularly beneficial for ARM platforms where the
tendency of using 16KB or 64KB system page sizes is growing, but the
IOMMU is fixed at 4KB page size, leading to wasted memory.

One possible/draft approach is below. When a small allocation is
requested, a per-node per-size folio is created. A section of this is
used to satisfy the allocation, and the folio is added to a pool so that
it can be used to satisfy later allocations too.

The main challenge is handling the iommu_pages_list used for freeing
allocations. In the whole-page case, this is nicely handled by using the
list_head in in struct ioptdesc. But now we may have up to 16
allocations per page, where each one can be placed on a different list.

So, in this approach, I have made iommu_pages_list manage both a list
of regular full-page ioptdesc allocations, and also a list of subpage
allocations that live within these subpage folios. The subpage
list heads are stored in a dynamically allocated struct
iommu_subpage_meta.

I don't love the approach but it at least seems to be working and I
figured it would be good to get some opinions before I go further.

Other options:
 - Replace the list_head with a pointer to the virt address of the next
   page in the list. We can detect whether we're working with a full
   page or subpage based on virt address, which means we only need one
   pointer in iommu_pages_list.
 - Bump allocator with per-CPU pools of partial subpage folios, along
   the lines of the networking subsystem's page_frag_cache. A little
   simpler than the approach here, but we'd have to evict and abandon
   filling the folio if the next request is for a different NUMA node,
   and handle CPU hotplug.
 - Allocate the subpage-tracking data in the unmap path? Falling back to
   immediate flush and free if allocation fails, along the lines of
   tlb_remove_table(). Would need more thought.
 - Implement generation-based deferred freeing in iommu core,
   eliminating the need for iommu_pages_list?
---
 drivers/iommu/Kconfig               |   9 +
 drivers/iommu/Makefile              |   1 +
 drivers/iommu/generic_pt/iommu_pt.h |   2 +-
 drivers/iommu/iommu-pages-kunit.c   | 240 ++++++++++++++++++
 drivers/iommu/iommu-pages.c         | 368 +++++++++++++++++++++++-----
 drivers/iommu/iommu-pages.h         |  50 ++--
 include/linux/iommu.h               |  10 +-
 7 files changed, 603 insertions(+), 77 deletions(-)
 create mode 100644 drivers/iommu/iommu-pages-kunit.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index de85fba9c0a7..b2f85bdad7ae 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -419,6 +419,15 @@ config IOMMU_DEBUG_PAGEALLOC
 	  You must enable "iommu.debug_pagealloc" from the kernel command
 	  line to activate the runtime checks.
 
+	  If unsure, say N.
+
+config IOMMU_PAGES_KUNIT_TEST
+	tristate "KUnit tests for IOMMU page and subpage allocator"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for the IOMMU page and subpage allocator.
+
 	  If unsure, say N.
 endif # IOMMU_SUPPORT
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 29a26d2a3af1..55324633d583 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_APPLE_DART) += apple-dart.o
 obj-$(CONFIG_VSI_IOMMU) += vsi-iommu.o
 obj-$(CONFIG_BCM2712_IOMMU) += bcm2712-iommu.o bcm2712-iommu-cache.o
 obj-$(CONFIG_IOMMU_DEBUG_PAGEALLOC) += iommu-debug-pagealloc.o
+obj-$(CONFIG_IOMMU_PAGES_KUNIT_TEST) += iommu-pages-kunit.o
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 07ec2b3ab986..b14c17daca7b 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -98,7 +98,7 @@ static void gather_range_pending(struct iommupt_pending_gather *pending,
 	}
 
 	iommu_pages_list_splice(&pending->free_list, &iotlb_gather->freelist);
-	INIT_LIST_HEAD(&pending->free_list.pages);
+	pending->free_list = IOMMU_PAGES_LIST_INIT(pending->free_list);
 
 	if (pt_feature(common, PT_FEAT_DETAILED_GATHER)) {
 		iotlb_gather->pt.leaf_levels_bitmap |=
diff --git a/drivers/iommu/iommu-pages-kunit.c b/drivers/iommu/iommu-pages-kunit.c
new file mode 100644
index 000000000000..3811c64f07d5
--- /dev/null
+++ b/drivers/iommu/iommu-pages-kunit.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for the IOMMU page and subpage allocator.
+ */
+
+#include <kunit/test.h>
+#include <linux/cleanup.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include "iommu-pages.h"
+
+static unsigned int ioptdesc_free_subpages(struct ioptdesc *iopt)
+{
+	return ioptdesc_total_subpages(iopt) -
+	       hweight16(iommu_subpage_used_bitmap(iopt));
+}
+
+static void test_iommu_page_alloc_basic(struct kunit *test)
+{
+	struct ioptdesc *iopt;
+	void *p;
+
+	/* Allocate a single page */
+	p = iommu_alloc_pages_sz(GFP_KERNEL, PAGE_SIZE);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+
+	iopt = virt_to_ioptdesc(p);
+	KUNIT_EXPECT_FALSE(test, iopt->subpage);
+	KUNIT_EXPECT_EQ(test, ioptdesc_mem_size(iopt), (size_t)PAGE_SIZE);
+	KUNIT_EXPECT_TRUE(test, IS_ALIGNED((uintptr_t)p, PAGE_SIZE));
+	iommu_free_pages(p);
+
+	/* Allocate two pages (order 1) */
+	p = iommu_alloc_pages_sz(GFP_KERNEL, PAGE_SIZE * 2);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+
+	iopt = virt_to_ioptdesc(p);
+	KUNIT_EXPECT_FALSE(test, iopt->subpage);
+	KUNIT_EXPECT_EQ(test, ioptdesc_mem_size(iopt), (size_t)(PAGE_SIZE * 2));
+	KUNIT_EXPECT_TRUE(test, IS_ALIGNED((uintptr_t)p, PAGE_SIZE * 2));
+	iommu_free_pages(p);
+}
+
+/*
+ * Test the lifecycle, bitmap tracking, and recycling of subpages.
+ */
+static void test_iommu_subpage_alloc_lifecycle(struct kunit *test)
+{
+	struct ioptdesc *iopt1, *iopt2;
+	void *p1, *p2, *p3;
+
+	if (PAGE_SIZE == SZ_4K) {
+		kunit_skip(test, "Subpage allocation requires PAGE_SIZE > 4KB\n");
+		return;
+	}
+
+	guard(migrate)();
+
+	/* 1. First 4KB allocation: creates a new folio on the node pool */
+	p1 = iommu_alloc_pages_sz(GFP_KERNEL, SZ_4K);
+	KUNIT_ASSERT_NOT_NULL(test, p1);
+	memset(p1, 0xa5, SZ_4K);
+
+	iopt1 = virt_to_ioptdesc(p1);
+	KUNIT_EXPECT_TRUE(test, iopt1->subpage);
+	KUNIT_EXPECT_EQ(test, (unsigned int)iopt1->subpage_order, 0U);
+	KUNIT_EXPECT_EQ(test, ioptdesc_mem_size(iopt1), (size_t)SZ_4K);
+	KUNIT_EXPECT_TRUE(test, IS_ALIGNED((uintptr_t)p1, SZ_4K));
+	KUNIT_EXPECT_EQ(test, iommu_subpage_used_bitmap(iopt1), 1U);
+	KUNIT_EXPECT_EQ(test, ioptdesc_free_subpages(iopt1), ioptdesc_total_subpages(iopt1) - 1);
+
+	/* 2. Second 4KB allocation: comes from the same folio */
+	p2 = iommu_alloc_pages_sz(GFP_KERNEL, SZ_4K);
+	KUNIT_ASSERT_NOT_NULL(test, p2);
+
+	iopt2 = virt_to_ioptdesc(p2);
+	KUNIT_EXPECT_PTR_EQ(test, iopt1, iopt2);
+	KUNIT_EXPECT_PTR_EQ(test, p2, p1 + SZ_4K);
+	KUNIT_EXPECT_EQ(test, iommu_subpage_used_bitmap(iopt1), 3U);
+	KUNIT_EXPECT_EQ(test, ioptdesc_free_subpages(iopt1), ioptdesc_total_subpages(iopt1) - 2);
+
+	/* 3. Freeing p1 clears bit 0 */
+	iommu_free_pages(p1);
+	KUNIT_EXPECT_EQ(test, iommu_subpage_used_bitmap(iopt1), 2U);
+
+	/* 4. Allocating p3 reuses freed subpage p1 (which has been cleared) */
+	p3 = iommu_alloc_pages_sz(GFP_KERNEL, SZ_4K);
+	KUNIT_ASSERT_NOT_NULL(test, p3);
+	KUNIT_EXPECT_PTR_EQ(test, p3, p1);
+	KUNIT_EXPECT_NULL(test, memchr_inv(p3, 0, SZ_4K));
+	KUNIT_EXPECT_EQ(test, iommu_subpage_used_bitmap(iopt1), 3U);
+
+	iommu_free_pages(p2);
+	iommu_free_pages(p3);
+}
+
+/*
+ * Test filling an entire folio to verify partial list removal and rollover.
+ */
+static void test_iommu_subpage_exhaustion(struct kunit *test)
+{
+	size_t num_subpages = PAGE_SIZE / SZ_4K;
+	struct ioptdesc *first_iopt, *next_iopt;
+	void **subpages;
+	int i;
+
+	if (PAGE_SIZE == SZ_4K) {
+		kunit_skip(test, "Subpage allocation requires PAGE_SIZE > 4KB\n");
+		return;
+	}
+
+	guard(migrate)();
+
+	subpages = kunit_kcalloc(test, num_subpages + 1, sizeof(void *), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, subpages);
+
+	/* Allocate all subpages that fit in a single folio */
+	for (i = 0; i < num_subpages; i++) {
+		subpages[i] = iommu_alloc_pages_sz(GFP_KERNEL, SZ_4K);
+		KUNIT_ASSERT_NOT_NULL(test, subpages[i]);
+	}
+
+	first_iopt = virt_to_ioptdesc(subpages[0]);
+
+	/* Verify all subpages share the same folio and are contiguous */
+	for (i = 0; i < num_subpages; i++) {
+		KUNIT_EXPECT_PTR_EQ(test, virt_to_ioptdesc(subpages[i]), first_iopt);
+		KUNIT_EXPECT_PTR_EQ(test, subpages[i], subpages[0] + (i * SZ_4K));
+	}
+
+	/* Folio is completely full: 0 free subpages */
+	KUNIT_EXPECT_EQ(test, ioptdesc_free_subpages(first_iopt), 0U);
+
+	/* The next allocation must allocate a brand-new folio */
+	subpages[num_subpages] = iommu_alloc_pages_sz(GFP_KERNEL, SZ_4K);
+	KUNIT_ASSERT_NOT_NULL(test, subpages[num_subpages]);
+
+	next_iopt = virt_to_ioptdesc(subpages[num_subpages]);
+	KUNIT_EXPECT_PTR_NE(test, next_iopt, first_iopt);
+
+	/* Free all allocations */
+	for (i = 0; i <= num_subpages; i++)
+		iommu_free_pages(subpages[i]);
+}
+
+/*
+ * Test struct iommu_pages_list batch operations with both full pages and subpages.
+ */
+static void test_iommu_pages_list(struct kunit *test)
+{
+	struct iommu_pages_list list1 = IOMMU_PAGES_LIST_INIT(list1);
+	struct iommu_pages_list list2 = IOMMU_PAGES_LIST_INIT(list2);
+	void *p_full, *p_sub;
+
+	if (PAGE_SIZE == SZ_4K) {
+		kunit_skip(test, "Subpage allocation requires PAGE_SIZE > 4KB\n");
+		return;
+	}
+
+	KUNIT_EXPECT_TRUE(test, iommu_pages_list_empty(&list1));
+
+	/* Allocate and add a full page */
+	p_full = iommu_alloc_pages_sz(GFP_KERNEL, PAGE_SIZE);
+	KUNIT_ASSERT_NOT_NULL(test, p_full);
+	iommu_pages_list_add(&list1, p_full);
+	KUNIT_EXPECT_FALSE(test, iommu_pages_list_empty(&list1));
+
+	/* Allocate and add a subpage */
+	p_sub = iommu_alloc_pages_sz(GFP_KERNEL, SZ_4K);
+	KUNIT_ASSERT_NOT_NULL(test, p_sub);
+	iommu_pages_list_add(&list1, p_sub);
+
+	/* Splice list1 into list2 */
+	iommu_pages_list_splice(&list1, &list2);
+	KUNIT_EXPECT_FALSE(test, iommu_pages_list_empty(&list2));
+
+	/* list2 now holds exactly the full page and the subpage */
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&list2.pages), 1U);
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&list2.subpages), 1U);
+
+	iommu_put_pages_list(&list2);
+}
+
+/*
+ * Test subpages of the same folios spread across two lists, which then get
+ * spliced together and freed.
+ */
+static void test_iommu_pages_list_shared_folios(struct kunit *test)
+{
+	struct iommu_pages_list list1 = IOMMU_PAGES_LIST_INIT(list1);
+	struct iommu_pages_list list2 = IOMMU_PAGES_LIST_INIT(list2);
+	unsigned int count = 3 * (PAGE_SIZE / SZ_4K);
+	unsigned int i;
+
+	if (PAGE_SIZE == SZ_4K) {
+		kunit_skip(test, "Subpage allocation requires PAGE_SIZE > 4KB\n");
+		return;
+	}
+
+	for (i = 0; i < count; i++) {
+		void *p = iommu_alloc_pages_sz(GFP_KERNEL, SZ_4K);
+
+		KUNIT_ASSERT_NOT_NULL(test, p);
+		iommu_pages_list_add(i % 2 ? &list1 : &list2, p);
+	}
+
+	iommu_pages_list_splice(&list1, &list2);
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&list2.subpages), count);
+	KUNIT_EXPECT_TRUE(test, list_empty(&list2.pages));
+	iommu_put_pages_list(&list2);
+}
+
+static struct kunit_case iommu_pages_test_cases[] = {
+	KUNIT_CASE(test_iommu_page_alloc_basic),
+	KUNIT_CASE(test_iommu_subpage_alloc_lifecycle),
+	KUNIT_CASE(test_iommu_subpage_exhaustion),
+	KUNIT_CASE(test_iommu_pages_list),
+	KUNIT_CASE(test_iommu_pages_list_shared_folios),
+	{}
+};
+
+static void iommu_pages_test_exit(struct kunit *test)
+{
+	iommu_subpage_drain_all();
+}
+
+static struct kunit_suite iommu_pages_test_suite = {
+	.name = "iommu-pages",
+	.exit = iommu_pages_test_exit,
+	.test_cases = iommu_pages_test_cases,
+};
+
+kunit_test_suite(iommu_pages_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for IOMMU page and subpage allocator");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..debd801e9130 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -4,9 +4,15 @@
  * Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 #include "iommu-pages.h"
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
+#include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <kunit/visibility.h>
 
 #define IOPTDESC_MATCH(pg_elm, elm)                    \
 	static_assert(offsetof(struct page, pg_elm) == \
@@ -14,7 +20,7 @@
 IOPTDESC_MATCH(flags, __page_flags);
 IOPTDESC_MATCH(lru, iopt_freelist_elm); /* Ensure bit 0 is clear */
 IOPTDESC_MATCH(mapping, __page_mapping);
-IOPTDESC_MATCH(private, _private);
+IOPTDESC_MATCH(private, __page_private);
 IOPTDESC_MATCH(page_type, __page_type);
 IOPTDESC_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_MEMCG
@@ -23,52 +29,71 @@ IOPTDESC_MATCH(memcg_data, memcg_data);
 #undef IOPTDESC_MATCH
 static_assert(sizeof(struct ioptdesc) <= sizeof(struct page));
 
-static inline size_t ioptdesc_mem_size(struct ioptdesc *desc)
+/*
+ * When the system page size is larger, subpages are supported through
+ * maintaining a pool of designated partially occupied folios, each one used
+ * for a collection of subpages of a given size (4KB, 8KB, 16KB, 32KB).
+ * When one of these folios becomes full, it is removed from the pool.
+ */
+struct iommu_subpage_pool {
+	spinlock_t lock;
+	struct list_head partial_list;
+};
+
+static struct iommu_subpage_pool node_pools[MAX_NUMNODES][4];
+
+/* Links one subpage onto the subpages list of a struct iommu_pages_list */
+struct iommu_subpage_list_node {
+	struct list_head elm;
+	struct iommu_subpage_meta *meta;
+};
+
+struct iommu_subpage_meta {
+	struct iommu_subpage_pool *pool;
+	struct ioptdesc *iopt;
+
+	/* protected by owning pool's lock */
+	struct list_head partial_node;
+	u16 used_bitmap;
+
+	struct iommu_subpage_list_node list_nodes[PAGE_SIZE / SZ_4K];
+};
+
+/* Index of the subpage at @virt within its folio, 0 for a full page */
+static unsigned int ioptdesc_subpage_idx(struct ioptdesc *iopt, void *virt)
 {
-	return 1UL << (folio_order(ioptdesc_folio(desc)) + PAGE_SHIFT);
+	if (!iopt->subpage)
+		return 0;
+	return offset_in_page(virt) >> (ilog2(SZ_4K) + iopt->subpage_order);
 }
 
-/**
- * iommu_alloc_pages_node_sz - Allocate a zeroed page of a given size from
- *                             specific NUMA node
- * @nid: memory NUMA node id
- * @gfp: buddy allocator flags
- * @size: Memory size to allocate, rounded up to a power of 2
- *
- * Returns the virtual address of the allocated page. The page must be freed
- * either by calling iommu_free_pages() or via iommu_put_pages_list(). The
- * returned allocation is round_up_pow_two(size) big, and is physically aligned
- * to its size.
- */
-void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
+static int __init iommu_subpage_init(void)
 {
-	struct ioptdesc *iopt;
-	unsigned long pgcnt;
-	struct folio *folio;
-	unsigned int order;
-
-	/* This uses page_address() on the memory. */
-	if (WARN_ON(gfp & __GFP_HIGHMEM))
-		return NULL;
+	int nid, order;
 
-	/*
-	 * Currently sub page allocations result in a full page being returned.
-	 */
-	order = get_order(size);
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		for (order = 0; order < 4; order++) {
+			spin_lock_init(&node_pools[nid][order].lock);
+			INIT_LIST_HEAD(&node_pools[nid][order].partial_list);
+		}
+	}
+	return 0;
+}
+early_initcall(iommu_subpage_init);
 
-	/*
-	 * __folio_alloc_node() does not handle NUMA_NO_NODE like
-	 * alloc_pages_node() did.
-	 */
-	if (nid == NUMA_NO_NODE)
-		nid = numa_mem_id();
+static struct ioptdesc *__iommu_alloc_desc(int nid, gfp_t gfp, unsigned int order)
+{
+	struct folio *folio;
+	struct ioptdesc *iopt;
+	unsigned long pgcnt;
 
 	folio = __folio_alloc_node(gfp | __GFP_ZERO, order, nid);
 	if (unlikely(!folio))
 		return NULL;
 
 	iopt = folio_ioptdesc(folio);
-	iopt->incoherent = false;
+	iopt->subpage = 0;
+	atomic_set(&iopt->incoherent, 0);
 
 	/*
 	 * All page allocations that should be reported to as "iommu-pagetables"
@@ -83,9 +108,8 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
 	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
 	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
 
-	return folio_address(folio);
+	return iopt;
 }
-EXPORT_SYMBOL_GPL(iommu_alloc_pages_node_sz);
 
 static void __iommu_free_desc(struct ioptdesc *iopt)
 {
@@ -93,13 +117,188 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
 	const unsigned long pgcnt = folio_nr_pages(folio);
 
 	if (IOMMU_PAGES_USE_DMA_API)
-		WARN_ON_ONCE(iopt->incoherent);
+		WARN_ON_ONCE(atomic_read(&iopt->incoherent));
+
+	if (iopt->subpage)
+		kfree(iopt->subpage_meta);
 
 	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
 	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
 	folio_put(folio);
 }
 
+#if IS_ENABLED(CONFIG_KUNIT)
+void iommu_subpage_drain_all(void)
+{
+	int nid, order;
+
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		for (order = 0; order < 4; order++) {
+			struct iommu_subpage_pool *pool = &node_pools[nid][order];
+			struct iommu_subpage_meta *meta, *next;
+			LIST_HEAD(to_free);
+
+			scoped_guard(spinlock_irqsave, &pool->lock)
+				list_splice_init(&pool->partial_list, &to_free);
+
+			list_for_each_entry_safe(meta, next, &to_free, partial_node) {
+				list_del_init(&meta->partial_node);
+				WARN_ON(meta->used_bitmap != 0);
+				__iommu_free_desc(meta->iopt);
+			}
+		}
+	}
+}
+EXPORT_SYMBOL_IF_KUNIT(iommu_subpage_drain_all);
+
+unsigned int iommu_subpage_used_bitmap(struct ioptdesc *iopt)
+{
+	return iopt->subpage_meta->used_bitmap;
+}
+EXPORT_SYMBOL_IF_KUNIT(iommu_subpage_used_bitmap);
+#endif
+
+static void *iommu_alloc_subpage(int nid, gfp_t gfp, size_t size)
+{
+	unsigned int order = ilog2(size / SZ_4K);
+	struct iommu_subpage_meta *meta;
+	struct iommu_subpage_pool *pool;
+	struct ioptdesc *iopt;
+	struct folio *folio;
+	unsigned int idx;
+
+	if (WARN_ON_ONCE(order >= 4))
+		return NULL;
+
+	pool = &node_pools[nid][order];
+
+	/* Attempt to allocate from any existing partial subpage folio */
+	scoped_guard(spinlock_irqsave, &pool->lock) {
+		void *addr;
+
+		if (list_empty(&pool->partial_list))
+			break;
+
+		meta = list_first_entry(&pool->partial_list,
+					struct iommu_subpage_meta, partial_node);
+		iopt = meta->iopt;
+		folio = ioptdesc_folio(iopt);
+
+		idx = ffs(~meta->used_bitmap) - 1;
+		meta->used_bitmap |= (1U << idx);
+
+		/* If the folio is now full, remove it from the pool */
+		if (hweight16(meta->used_bitmap) ==
+		    ioptdesc_total_subpages(iopt))
+			list_del_init(&meta->partial_node);
+
+		addr = folio_address(folio) + (idx * size);
+		memset(addr, 0, size);
+		return addr;
+	}
+
+	/* Allocate a new subpage folio for this node */
+	meta = kzalloc_node(sizeof(*meta), gfp, nid);
+	if (unlikely(!meta))
+		return NULL;
+
+	iopt = __iommu_alloc_desc(nid, gfp, 0);
+	if (unlikely(!iopt)) {
+		kfree(meta);
+		return NULL;
+	}
+
+	folio = ioptdesc_folio(iopt);
+	iopt->subpage = 1;
+	iopt->subpage_order = order;
+	iopt->subpage_meta = meta;
+	meta->iopt = iopt;
+	for (idx = 0; idx < ARRAY_SIZE(meta->list_nodes); idx++)
+		meta->list_nodes[idx].meta = meta;
+	meta->used_bitmap = 1U; /* Subpage 0 allocated */
+
+	/*
+	 * The folio may have come from another node than requested, so
+	 * place it in the pool of the node it is actually on.
+	 */
+	meta->pool = &node_pools[folio_nid(folio)][order];
+	scoped_guard(spinlock_irqsave, &meta->pool->lock)
+		list_add(&meta->partial_node, &meta->pool->partial_list);
+
+	return folio_address(folio);
+}
+
+/**
+ * iommu_alloc_pages_node_sz - Allocate a zeroed page of a given size from
+ *                             specific NUMA node
+ * @nid: memory NUMA node id
+ * @gfp: buddy allocator flags
+ * @size: Memory size to allocate, rounded up to a power of 2
+ *
+ * Returns the virtual address of the allocated page. The page must be freed
+ * either by calling iommu_free_pages() or via iommu_put_pages_list(). The
+ * returned allocation is round_up_pow_two(size) big, with minimum size 4KB,
+ * and is physically aligned to its size.
+ */
+void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
+{
+	struct ioptdesc *iopt;
+
+	if (!size)
+		return NULL;
+
+	/* This uses page_address() on the memory. */
+	if (WARN_ON(gfp & __GFP_HIGHMEM))
+		return NULL;
+
+	/*
+	 * __folio_alloc_node() does not handle NUMA_NO_NODE like
+	 * alloc_pages_node() did.
+	 */
+	if (nid == NUMA_NO_NODE)
+		nid = numa_mem_id();
+
+	size = max_t(size_t, roundup_pow_of_two(size), SZ_4K);
+	if (size < PAGE_SIZE)
+		return iommu_alloc_subpage(nid, gfp, size);
+
+	iopt = __iommu_alloc_desc(nid, gfp, get_order(size));
+	if (!iopt)
+		return NULL;
+
+	return folio_address(ioptdesc_folio(iopt));
+}
+EXPORT_SYMBOL_GPL(iommu_alloc_pages_node_sz);
+
+static void iommu_free_subpage(struct ioptdesc *iopt, void *virt)
+{
+	struct iommu_subpage_meta *meta = iopt->subpage_meta;
+	unsigned int idx = ioptdesc_subpage_idx(iopt, virt);
+
+	if (IOMMU_PAGES_USE_DMA_API)
+		WARN_ON_ONCE(atomic_read(&iopt->incoherent) & BIT(idx));
+
+	scoped_guard(spinlock_irqsave, &meta->pool->lock) {
+		meta->used_bitmap &= ~(1U << idx);
+
+		if (meta->used_bitmap) {
+			/*
+			 * If the folio was full, it now has a space, so ensure
+			 * this folio is present in the pool.
+			 */
+			if (list_empty(&meta->partial_node))
+				list_add(&meta->partial_node,
+					 &meta->pool->partial_list);
+			return;
+		}
+
+		/* Folio is now empty, it can be freed. */
+		list_del_init(&meta->partial_node);
+	}
+
+	__iommu_free_desc(iopt);
+}
+
 /**
  * iommu_free_pages - free pages
  * @virt: virtual address of the page to be freed.
@@ -108,12 +307,48 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
  */
 void iommu_free_pages(void *virt)
 {
+	struct ioptdesc *iopt;
+
 	if (!virt)
 		return;
-	__iommu_free_desc(virt_to_ioptdesc(virt));
+
+	iopt = virt_to_ioptdesc(virt);
+	if (iopt->subpage)
+		iommu_free_subpage(iopt, virt);
+	else
+		__iommu_free_desc(iopt);
 }
 EXPORT_SYMBOL_GPL(iommu_free_pages);
 
+/**
+ * iommu_pages_list_add - add the page to a iommu_pages_list
+ * @list: List to add the page to
+ * @virt: Address returned from iommu_alloc_pages_node_sz()
+ */
+void iommu_pages_list_add(struct iommu_pages_list *list, void *virt)
+{
+	struct ioptdesc *iopt = virt_to_ioptdesc(virt);
+	unsigned int idx = ioptdesc_subpage_idx(iopt, virt);
+
+	if (!iopt->subpage) {
+		list_add_tail(&iopt->iopt_freelist_elm, &list->pages);
+		return;
+	}
+
+	list_add_tail(&iopt->subpage_meta->list_nodes[idx].elm, &list->subpages);
+}
+EXPORT_SYMBOL_GPL(iommu_pages_list_add);
+
+/* Return the virtual address of a subpage given its list node */
+static void *iommu_subpage_node_virt(struct iommu_subpage_list_node *node)
+{
+	struct iommu_subpage_meta *meta = node->meta;
+	unsigned int idx = node - meta->list_nodes;
+
+	return folio_address(ioptdesc_folio(meta->iopt)) +
+	       idx * ioptdesc_mem_size(meta->iopt);
+}
+
 /**
  * iommu_put_pages_list - free a list of pages.
  * @list: The list of pages to be freed
@@ -124,10 +359,14 @@ EXPORT_SYMBOL_GPL(iommu_free_pages);
  */
 void iommu_put_pages_list(struct iommu_pages_list *list)
 {
+	struct iommu_subpage_list_node *node, *next;
 	struct ioptdesc *iopt, *tmp;
 
 	list_for_each_entry_safe(iopt, tmp, &list->pages, iopt_freelist_elm)
 		__iommu_free_desc(iopt);
+
+	list_for_each_entry_safe(node, next, &list->subpages, elm)
+		iommu_free_pages(iommu_subpage_node_virt(node));
 }
 EXPORT_SYMBOL_GPL(iommu_put_pages_list);
 
@@ -146,9 +385,10 @@ EXPORT_SYMBOL_GPL(iommu_put_pages_list);
 int iommu_pages_start_incoherent(void *virt, struct device *dma_dev)
 {
 	struct ioptdesc *iopt = virt_to_ioptdesc(virt);
+	unsigned int idx = ioptdesc_subpage_idx(iopt, virt);
 	dma_addr_t dma;
 
-	if (WARN_ON(iopt->incoherent))
+	if (WARN_ON(atomic_read(&iopt->incoherent) & BIT(idx)))
 		return -EINVAL;
 
 	if (!IOMMU_PAGES_USE_DMA_API) {
@@ -172,7 +412,7 @@ int iommu_pages_start_incoherent(void *virt, struct device *dma_dev)
 		}
 	}
 
-	iopt->incoherent = 1;
+	atomic_or(BIT(idx), &iopt->incoherent);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_pages_start_incoherent);
@@ -189,11 +429,12 @@ EXPORT_SYMBOL_GPL(iommu_pages_start_incoherent);
 int iommu_pages_start_incoherent_list(struct iommu_pages_list *list,
 				      struct device *dma_dev)
 {
+	struct iommu_subpage_list_node *node;
 	struct ioptdesc *cur;
 	int ret;
 
 	list_for_each_entry(cur, &list->pages, iopt_freelist_elm) {
-		if (WARN_ON(cur->incoherent))
+		if (WARN_ON(atomic_read(&cur->incoherent)))
 			continue;
 
 		ret = iommu_pages_start_incoherent(
@@ -201,10 +442,28 @@ int iommu_pages_start_incoherent_list(struct iommu_pages_list *list,
 		if (ret)
 			return ret;
 	}
+
+	list_for_each_entry(node, &list->subpages, elm) {
+		ret = iommu_pages_start_incoherent(iommu_subpage_node_virt(node),
+						   dma_dev);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_pages_start_incoherent_list);
 
+#if IOMMU_PAGES_USE_DMA_API
+static void iommu_pages_stop_incoherent(void *virt, struct device *dma_dev)
+{
+	struct ioptdesc *iopt = virt_to_ioptdesc(virt);
+	unsigned int idx = ioptdesc_subpage_idx(iopt, virt);
+
+	if (atomic_fetch_andnot(BIT(idx), &iopt->incoherent) & BIT(idx))
+		dma_unmap_single(dma_dev, virt_to_phys(virt),
+				 ioptdesc_mem_size(iopt), DMA_TO_DEVICE);
+}
+
 /**
  * iommu_pages_stop_incoherent_list - Undo incoherence across a list
  * @list: The list of pages to release
@@ -213,21 +472,18 @@ EXPORT_SYMBOL_GPL(iommu_pages_start_incoherent_list);
  * Revert iommu_pages_start_incoherent() across all of the list. Pages that did
  * not call or succeed iommu_pages_start_incoherent() will be ignored.
  */
-#if IOMMU_PAGES_USE_DMA_API
 void iommu_pages_stop_incoherent_list(struct iommu_pages_list *list,
 				      struct device *dma_dev)
 {
+	struct iommu_subpage_list_node *node;
 	struct ioptdesc *cur;
 
-	list_for_each_entry(cur, &list->pages, iopt_freelist_elm) {
-		struct folio *folio = ioptdesc_folio(cur);
+	list_for_each_entry(cur, &list->pages, iopt_freelist_elm)
+		iommu_pages_stop_incoherent(folio_address(ioptdesc_folio(cur)),
+					    dma_dev);
 
-		if (!cur->incoherent)
-			continue;
-		dma_unmap_single(dma_dev, virt_to_phys(folio_address(folio)),
-				 ioptdesc_mem_size(cur), DMA_TO_DEVICE);
-		cur->incoherent = 0;
-	}
+	list_for_each_entry(node, &list->subpages, elm)
+		iommu_pages_stop_incoherent(iommu_subpage_node_virt(node), dma_dev);
 }
 EXPORT_SYMBOL_GPL(iommu_pages_stop_incoherent_list);
 
@@ -240,14 +496,8 @@ EXPORT_SYMBOL_GPL(iommu_pages_stop_incoherent_list);
  */
 void iommu_pages_free_incoherent(void *virt, struct device *dma_dev)
 {
-	struct ioptdesc *iopt = virt_to_ioptdesc(virt);
-
-	if (iopt->incoherent) {
-		dma_unmap_single(dma_dev, virt_to_phys(virt),
-				 ioptdesc_mem_size(iopt), DMA_TO_DEVICE);
-		iopt->incoherent = 0;
-	}
-	__iommu_free_desc(iopt);
+	iommu_pages_stop_incoherent(virt, dma_dev);
+	iommu_free_pages(virt);
 }
 EXPORT_SYMBOL_GPL(iommu_pages_free_incoherent);
 #endif
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index e9e605b5fa3a..20538551d813 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -8,10 +8,13 @@
 #define __IOMMU_PAGES_H
 
 #include <linux/iommu.h>
+#include <linux/mm.h>
+#include <linux/sizes.h>
 
 /**
  * struct ioptdesc - Memory descriptor for IOMMU page tables
  * @iopt_freelist_elm: List element for a struct iommu_pages_list
+ * @subpage_meta: Per-subpage metadata, for subpage folios
  *
  * This struct overlays struct page for now. Do not modify without a good
  * understanding of the issues.
@@ -19,13 +22,23 @@
 struct ioptdesc {
 	unsigned long __page_flags;
 
-	struct list_head iopt_freelist_elm;
+	union {
+		struct list_head iopt_freelist_elm;
+		struct iommu_subpage_meta *subpage_meta;
+	};
 	unsigned long __page_mapping;
 	union {
-		u8 incoherent;
+		struct {
+			u8 subpage:1;
+			u8 subpage_order:2;
+		};
 		pgoff_t __index;
 	};
-	void *_private;
+	union {
+		/* One bit per incoherent subpage, bit 0 for a full page */
+		atomic_t incoherent;
+		unsigned long __page_private;
+	};
 
 	unsigned int __page_type;
 	atomic_t __page_refcount;
@@ -49,21 +62,27 @@ static inline struct ioptdesc *virt_to_ioptdesc(void *virt)
 	return folio_ioptdesc(virt_to_folio(virt));
 }
 
-void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
-void iommu_free_pages(void *virt);
-void iommu_put_pages_list(struct iommu_pages_list *list);
+static inline unsigned int ioptdesc_total_subpages(struct ioptdesc *iopt)
+{
+	return PAGE_SIZE >> (ilog2(SZ_4K) + iopt->subpage_order);
+}
 
-/**
- * iommu_pages_list_add - add the page to a iommu_pages_list
- * @list: List to add the page to
- * @virt: Address returned from iommu_alloc_pages_node_sz()
- */
-static inline void iommu_pages_list_add(struct iommu_pages_list *list,
-					void *virt)
+static inline size_t ioptdesc_mem_size(struct ioptdesc *desc)
 {
-	list_add_tail(&virt_to_ioptdesc(virt)->iopt_freelist_elm, &list->pages);
+	if (desc->subpage)
+		return SZ_4K << desc->subpage_order;
+	return 1UL << (folio_order(ioptdesc_folio(desc)) + PAGE_SHIFT);
 }
 
+void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
+void iommu_free_pages(void *virt);
+void iommu_put_pages_list(struct iommu_pages_list *list);
+void iommu_pages_list_add(struct iommu_pages_list *list, void *virt);
+#if IS_ENABLED(CONFIG_KUNIT)
+void iommu_subpage_drain_all(void);
+unsigned int iommu_subpage_used_bitmap(struct ioptdesc *iopt);
+#endif
+
 /**
  * iommu_pages_list_splice - Put all the pages in list from into list to
  * @from: Source list of pages
@@ -76,6 +95,7 @@ static inline void iommu_pages_list_splice(struct iommu_pages_list *from,
 					   struct iommu_pages_list *to)
 {
 	list_splice(&from->pages, &to->pages);
+	list_splice(&from->subpages, &to->subpages);
 }
 
 /**
@@ -84,7 +104,7 @@ static inline void iommu_pages_list_splice(struct iommu_pages_list *from,
  */
 static inline bool iommu_pages_list_empty(struct iommu_pages_list *list)
 {
-	return list_empty(&list->pages);
+	return list_empty(&list->pages) && list_empty(&list->subpages);
 }
 
 /**
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..a5fc4db6ef7a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -334,11 +334,17 @@ typedef unsigned int ioasid_t;
  * iommu_alloc_pages_node_sz() can be used this way!
  */
 struct iommu_pages_list {
+	/* Full pages, linked through their ioptdesc */
 	struct list_head pages;
+	/* Sub-page allocations, linked through their folio's metadata */
+	struct list_head subpages;
 };
 
-#define IOMMU_PAGES_LIST_INIT(name) \
-	((struct iommu_pages_list){ .pages = LIST_HEAD_INIT(name.pages) })
+#define IOMMU_PAGES_LIST_INIT(name)					\
+	((struct iommu_pages_list){					\
+		.pages = LIST_HEAD_INIT(name.pages),			\
+		.subpages = LIST_HEAD_INIT(name.subpages),		\
+	})
 
 #ifdef CONFIG_IOMMU_API
 
-- 
2.55.0

