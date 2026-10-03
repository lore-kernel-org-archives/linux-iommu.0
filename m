Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FEB4908D7
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062575; cv=none; b=Z7k70qc2zPwXSnLmww4JJ1k+rHnUivcZaLC0aGR07z7fMy9Zng6LjwVATkF7lcwc8EfIItqv2LFGtVZ5ifJ6lxM9UuueRNu7DeWj+8prqUC/QMyoNwCUPKfaK02cboFvbghu8bppo7DmkWpj+083AN8tVvpGQEb8qLv8vRUGaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062575; c=relaxed/simple;
	bh=C7ufT8KVq72MWzFJIoRk0UJZVOPIfdSL5MWcPH3Ufkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=egZDxnH15SsegehgLU3mC6Iz+oGPNMaYvhj624lfnPYrIxF7AAysozXHpNVp+Mg/E/7f5/ifAf+Z7sNzhRPqNLrp0BKOzcCBz5xon3PaDs8s+XRAlXu2kh4nYcXIMY1Q9nX7Nu0kqJIo4m4MoEhlR8R4IcCB3XlZ8n5B8ynaFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIm+NPFe; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIm+NPFe"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2e385c2586so88386166b.2
        for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062571; x=1791667371; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxA7oyLrSoVNihu+TTEed7Cv84XwkDi44oXKTt9irD0=;
        b=SIm+NPFeciaHtuOJlNLg43TiGV82mKqbBr53IAbQQt88HBIVzwXidY+ETxvwxW7BwK
         0Zc33qDuxE2rHx8UaGixHlMtOe1S1v27MzOvzfTssPwRoGc/3uR5UAKDRll3AJy1LNuf
         Srz+se/mY2AILeJgdHD9dkY52M/Yy908gPakJQLDU5rHB53ld+ik5J37DhJtC3lj5mcd
         ZwZuJ6dUic0N5UhN4ts8aRZATRAr1u1prkLN/dEaFtOz+r8V3ZS5ehcGhpyjF34s7OUo
         gkdwe1MHNzGr4QYQLjTfe2qWZyR1qFGgEZMf651ytulooXLQGFeKslFqEWrzYwFVw25m
         naSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062571; x=1791667371;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxA7oyLrSoVNihu+TTEed7Cv84XwkDi44oXKTt9irD0=;
        b=GModo99TOtJJILCCuO8bFqkTcP7AA5IrNVNEkL5SozdRxJEkHhdCOKfDwYGLzZ0Dty
         zi31ykR7xcoDuDAnLewem2/VgcCjAG0GSsjM2fswXFWwwj8LFSQkvcfjHBu/O6JrY8VP
         NSGiQgWpwUJ8dxhblVQUpiowi6UpORV+AkkDyM4iTg30N19qcz6kDAbgHYEXo7zR+gQW
         o1tOFL6/nh7kCTTowfFJ/PTvlrhWPIAO8A5qWEs+kyMD6s8mxu/DL0aNtcsvWbIdZOIW
         QWCmOYvPS2IsSDxI8jUfVZg44yZNNArCe8YXkSvBBN7HVtyNiwpPXJLFuUUnU+sG0dI8
         EKXA==
X-Forwarded-Encrypted: i=1; AKwUvBw5eep768V+pEm/XxEt1oBTsiJ4Xb+neDp5dmwCA0vzpFhkPXCQwC9liZcfE6VdHVct3jjHOA==@lists.linux.dev
X-Gm-Message-State: AFuF++kvLcL1YNfEI6OfrhUhGQ0t7fkOz2L874VHqkhoxiji9p7oRkoE
	j7QHcVqffEjoQkVzABZhW54+E2dcbyMsj3uciwQnX3QpmAP2FlyNxhlDdOJRnpObGN40e4W3MIQ
	Af3CdOg==
X-Received: from ejcay23.prod.google.com ([2002:a17:907:9017:b0:c2d:d3a7:21fe])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:97d3:b0:c2e:3ed7:7db4
 with SMTP id a640c23a62f3a-c2e6ed3f0fcmr244265366b.23.1791062569971; Sat, 03
 Oct 2026 14:22:49 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:22 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-4-lrizzo@google.com>
Subject: [RFC: DMA_PMD 03/22] mm: Add split_page_compound()
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add split_page_compound(), which splits an order-@old_order page into
independently refcounted order-@new_order compound pages (or order-0
pages when @new_order == 0). This is the high-order counterpart of
split_page(), used by DMA_PMD pools to carve PMD pages into smaller
compound blocks.

All resulting pieces are returned frozen (refcount 0) so the caller can
park them in a pool and publish each piece with page_ref_unfreeze(piece, 1)
when handed out.

Also add a KUnit test suite (CONFIG_SPLIT_PAGE_COMPOUND_KUNIT_TEST) in
mm/split_page_compound_kunit.c.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/mm.h             |   2 +
 mm/Kconfig.debug               |  11 ++++
 mm/Makefile                    |   1 +
 mm/page_alloc.c                |  85 +++++++++++++++++++++++++
 mm/split_page_compound_kunit.c | 113 +++++++++++++++++++++++++++++++++
 5 files changed, 212 insertions(+)
 create mode 100644 mm/split_page_compound_kunit.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23e..799a42005627f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1985,6 +1985,8 @@ static inline struct folio *virt_to_folio(const void *x)
 void __folio_put(struct folio *folio);
 
 void split_page(struct page *page, unsigned int order);
+int split_page_compound(struct page *page, unsigned int old_order,
+			unsigned int new_order);
 void folio_copy(struct folio *dst, struct folio *src);
 int folio_mc_copy(struct folio *dst, struct folio *src);
 
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 15dca19dd07da..e1a04671c3b0d 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -347,3 +347,14 @@ config MEM_ALLOC_PROFILING_DEBUG
 	help
 	  Adds warnings with helpful error messages for memory allocation
 	  profiling.
+
+config SPLIT_PAGE_COMPOUND_KUNIT_TEST
+	bool "KUnit test for split_page_compound() (built-in)" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Builds KUnit unit tests for split_page_compound() in mm/page_alloc.c,
+	  verifying compound splitting, sub-block freezing, and speculative
+	  reference handling.
+
+	  If unsure, say N.
diff --git a/mm/Makefile b/mm/Makefile
index e7245cb88c665..448c0f5f783f3 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -148,3 +148,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_LAZY_MMU_MODE_KUNIT_TEST) += tests/lazy_mmu_mode_kunit.o
 obj-$(CONFIG_MEM_ALLOC_PROFILING) += alloc_tag.o
+obj-$(CONFIG_SPLIT_PAGE_COMPOUND_KUNIT_TEST) += split_page_compound_kunit.o
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e8e9905cdea5b..a663ec81a588b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3133,6 +3133,91 @@ void split_page(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(split_page);
 
+/*
+ * split_page_compound() - split an order-@old_order page into compound pages
+ *			   of order @new_order
+ * @page: the page to split
+ * @old_order: the current order of @page
+ * @new_order: the order of the resulting pages
+ *
+ * Unlike split_page(), which produces order-0 pages, this produces
+ * 1 << (@old_order - @new_order) compound pages, each with its own head.
+ * @page must not be compound, and the caller must hold the only reference to
+ * it: the block is frozen while the new heads are built.
+ *
+ * All pieces (including @page at index 0) are returned frozen, with a zero
+ * refcount. Publish each piece with
+ * page_ref_unfreeze(piece, 1) before handing it out: its release store orders
+ * the compound layout built here against anyone who then observes the
+ * refcount. A relaxed set_page_count() would not, and on a weakly ordered
+ * machine a PFN walker could see a live refcount on a head whose layout is
+ * not visible yet.
+ *
+ * Memcg-charged pages are rejected: the accounting helpers assume a split
+ * produces order-0 pages and would mis-attribute the new compound heads.
+ *
+ * Return: 0 on success, -EINVAL if @page cannot be split or if @new_order is
+ * larger than @old_order, -EBUSY if anyone but the caller holds a reference
+ * to it.
+ */
+int split_page_compound(struct page *page, unsigned int old_order,
+			unsigned int new_order)
+{
+	unsigned int i, step = 1U << new_order, nr = 1U << old_order;
+
+	if (WARN_ON_ONCE(PageCompound(page) || !page_count(page)))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(new_order > old_order))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(memcg_kmem_online() && PageMemcgKmem(page)))
+		return -EINVAL;
+
+	/*
+	 * Shape the new compound pages while the block is frozen, which is
+	 * the order __alloc_pages_noprof() itself uses: prep_new_page()
+	 * builds the page with a zero refcount and the set_page_refcounted()
+	 * that follows is what makes it visible.
+	 *
+	 * Freezing stops a speculative PFN walker from resolving a compound
+	 * page that is only half built: get_page_unless_zero() fails for as
+	 * long as the layout below is being written. It does not order
+	 * against memory_failure(), which sets PG_hwpoison before taking any
+	 * reference, so the non-atomic __SetPageHead() below can still lose a
+	 * concurrent poison bit - exactly as it can for every other
+	 * prep_compound_page() caller, the page allocator included.
+	 *
+	 * A failed freeze is not a bug, it means someone holds a speculative
+	 * reference. Every PFN walker in the tree gates
+	 * get_page_unless_zero() on PageLRU, which a freshly allocated block
+	 * is not, so in practice only the hwpoison machinery gets here. Let
+	 * the caller fall back rather than warn: a machine running
+	 * panic_on_warn should not die of a condition the caller handles.
+	 */
+	if (!page_ref_freeze(page, 1))
+		return -EBUSY;
+
+	if (!new_order) {
+		/*
+		 * The subpages of a non-compound block are already
+		 * independent frozen pages, so only the bookkeeping applies.
+		 */
+		split_page_owner(page, old_order, 0);
+		pgalloc_tag_split(page_folio(page), old_order, 0);
+		split_page_memcg(page, old_order);
+		return 0;
+	}
+
+	split_page_owner(page, old_order, new_order);
+	pgalloc_tag_split(page_folio(page), old_order, new_order);
+
+	for (i = 0; i < nr; i += step)
+		prep_compound_page(page + i, new_order);
+
+	return 0;
+}
+
 int __isolate_free_page(struct page *page, unsigned int order)
 {
 	struct zone *zone = page_zone(page);
diff --git a/mm/split_page_compound_kunit.c b/mm/split_page_compound_kunit.c
new file mode 100644
index 0000000000000..bb0ac908bbc1e
--- /dev/null
+++ b/mm/split_page_compound_kunit.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for split_page_compound().
+ */
+#include <kunit/test.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+
+static void test_split_compound_pieces(struct kunit *test)
+{
+	const unsigned int old_order = 5, new_order = 2;
+	const unsigned int step = 1U << new_order;
+	const unsigned int nr = 1U << old_order;
+	struct page *page;
+	unsigned int i, j;
+	int ret;
+
+	page = alloc_pages(GFP_KERNEL, old_order);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	KUNIT_EXPECT_FALSE(test, PageCompound(page));
+
+	ret = split_page_compound(page, old_order, new_order);
+	if (ret)
+		__free_pages(page, old_order);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	for (i = 0; i < nr; i += step) {
+		struct page *sub = page + i;
+
+		/* All heads 0..N-1 are returned frozen (refcount 0). */
+		KUNIT_EXPECT_EQ(test, page_count(sub), 0);
+		KUNIT_EXPECT_TRUE(test, PageHead(sub));
+		KUNIT_EXPECT_EQ(test, compound_order(sub), new_order);
+
+		for (j = 1; j < step; j++) {
+			KUNIT_EXPECT_TRUE(test, PageTail(sub + j));
+			KUNIT_EXPECT_PTR_EQ(test, compound_head(sub + j), sub);
+		}
+
+		page_ref_unfreeze(sub, 1);
+
+		/* Tail get_page()/put_page() must operate on this piece's head. */
+		get_page(sub + 1);
+		KUNIT_EXPECT_EQ(test, page_count(sub), 2);
+		put_page(sub + 1);
+		KUNIT_EXPECT_EQ(test, page_count(sub), 1);
+	}
+
+	/* Each compound piece frees independently at new_order. */
+	for (i = 0; i < nr; i += step)
+		__free_pages(page + i, new_order);
+}
+
+static void test_split_order0_pieces(struct kunit *test)
+{
+	const unsigned int old_order = 3, nr = 1U << old_order;
+	struct page *page;
+	unsigned int i;
+	int ret;
+
+	page = alloc_pages(GFP_KERNEL, old_order);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+
+	ret = split_page_compound(page, old_order, 0);
+	if (ret)
+		__free_pages(page, old_order);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	for (i = 0; i < nr; i++) {
+		struct page *sub = page + i;
+
+		KUNIT_EXPECT_FALSE(test, PageCompound(sub));
+		KUNIT_EXPECT_EQ(test, page_count(sub), 0);
+		page_ref_unfreeze(sub, 1);
+		__free_pages(sub, 0);
+	}
+}
+
+static void test_split_ebusy_extra_ref(struct kunit *test)
+{
+	const unsigned int old_order = 4;
+	const unsigned int new_order = 2;
+	struct page *page;
+	int ret;
+
+	page = alloc_pages(GFP_KERNEL, old_order);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+
+	/* Simulate a concurrent speculative reference. */
+	get_page(page);
+	ret = split_page_compound(page, old_order, new_order);
+	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+	KUNIT_EXPECT_FALSE(test, PageCompound(page));
+
+	put_page(page);
+	__free_pages(page, old_order);
+}
+
+static struct kunit_case split_page_compound_test_cases[] = {
+	KUNIT_CASE(test_split_compound_pieces),
+	KUNIT_CASE(test_split_order0_pieces),
+	KUNIT_CASE(test_split_ebusy_extra_ref),
+	{}
+};
+
+static struct kunit_suite split_page_compound_test_suite = {
+	.name = "split_page_compound",
+	.test_cases = split_page_compound_test_cases,
+};
+
+kunit_test_suite(split_page_compound_test_suite);
+MODULE_DESCRIPTION("KUnit tests for split_page_compound()");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

