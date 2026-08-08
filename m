Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF73191CA
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156050; cv=none; b=Z+r3ZUC4oyV2gH1U3tLr1s0+aAuFAaQQNZDv6AavzyiyNfD+akcvGe2IF06J3OYbXL8mLCbVEHMwkJcRLk/UkT5FimOkSTk/9I0WuM+cxrJp4kr1iYPv1Q1ffdkl7t3sGG6vACcN7xPNo1I64Swh9NHDrezGweTAMiV+Vwu4nHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156050; c=relaxed/simple;
	bh=EFjxKJUxQYzZRWsLlkwmBTEAO97a0P5F2PM+9vBDxio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pmB9+C4KMERkLt05WRb5ATj5Ie8EohSbhDI/DIPNLjz9RuVt949O8oFbFMe3qoGdu5w05CRneCgn3+3jLHaKO9uNG9GIUbCOHg8MYv6VEiZwOcDTyO0cAnEG+dpnvLe6u7j5HgKm5oSI0Pb3IU4LWOkAKXxQZVePZINX90tRVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TuSOAFjL; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TuSOAFjL"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso195374b3a.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156048; x=1786760848; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALJ8iF55j4WmZdioPQlqqdbkDv0ZTARtOYRdtytwxLw=;
        b=TuSOAFjLLdr0nHb2e6rLbO0oI62rFa9jU1VVfFASjq4OXYb0DPx4Bvi6cO1F93ZGf4
         AGcV4/d0JsJ8fhiV9Nfmz9Hr6+i9dhUwkP5s0Ws3nNDGk8po8++Vp9tRzIgcQXTPngfp
         lKwdyh+yTdIrz/SO/l8pTgVqI1IN0XDW236zVKJb+nZRlZxIBdityIg+qksrFVc5xtOW
         qtl3qMAFmMHzyRch7JZb3jsEfGvhWrpabuo87/XSlqyo5bbqPCX4apJio3D7rkIac9MA
         2UuihuXSZR7hJtFxRlkE8XXruvRFJr3E2ktG+xCW813s+HMJcGxYTW2Ev68AI3stTHx9
         e8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156048; x=1786760848;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALJ8iF55j4WmZdioPQlqqdbkDv0ZTARtOYRdtytwxLw=;
        b=BNrhxHvvYmyY6SZ5XQf89Iw6ChMj2XwUHzgNYUWUuDpeXGyN3mBH7iIZp78KHkcLeR
         4H2+H76ozmwqqv+FroOGqhWWNYQJ7M35ZDQQReCCGUyxwyLIXK1fJD9spqBilM+KhIvE
         mZ3+2jlr99y6gJu3oPxx/fr2a1tLSfmB5QZOlqcsWW2r/pbfSp0K3RZuOPEleAurgIZP
         WZBIxYE0+U+1yRaBJLWX5r+ibMwULj0dWN1sI5PGP0PbQdKXG35orPnriaKKL9j4zaeN
         C2bWCA4shaNo3fEHiutsZVT8MqysBv2OEo2JcSnQE0qnLWCpOHjjAiLHUZ+jbiZu5gef
         EVQw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9RrQP5H2UnK6sngNJwDVxBO3neJh3AM9boQrHRRh7Pe0KjReqODPcALtqbZ9gi4AH54qhZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRq7QEKcEGUvAT4VSDOgXg2KSjbV792OSnyxHFMqUPQ2whj4ZC
	BXtVxJMjGcl3XoeQoKWOKtk7gtMNfsTUgGtmfBedu6QSjfsDorpAsLjBsu0S/td67mdXz4Nlo0H
	dNxOOwCSUWYHB5A==
X-Received: from pffm18-n2.prod.google.com ([2002:a05:6a00:c312:20b0:84f:2e04:4b8e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:440e:b0:847:99bb:b6d0 with SMTP id d2e1a72fcca58-84f6947ffefmr5294418b3a.15.1786156047477;
 Fri, 07 Aug 2026 19:27:27 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:09 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-5-skhawaja@google.com>
Subject: [PATCH v4 04/18] iommupt: Implement preserve/unpreserve/restore callbacks
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add iommupt ops for presevation, unpresevation and restoration of iommu
page tables for liveupdate. Use the existing page walker to preserve the
ioptdesc of the top_table and the lower tables.

Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
the next kernel. On restore, the domain has only the preserved features
enabled and all the other features are zeroed. This is ok since the
restored domain is made immutable and can only be freed. A kunit test is
added to verify that the IOMMU domain free can be done with trimmed
features.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/generic_pt/iommu_pt.h       | 152 ++++++++++++++++++++++
 drivers/iommu/generic_pt/kunit_iommu_pt.h |  30 +++++
 include/linux/generic_pt/iommu.h          |  30 +++++
 3 files changed, 212 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index c2752151c80a..bc8b5a1425b8 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -16,6 +16,7 @@
 #include "../iommu-pages.h"
 #include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu-liveupdate.h>
 
 enum {
 	SW_BIT_CACHE_FLUSH_DONE = 0,
@@ -1005,6 +1006,152 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
 	return ret;
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+static void NS(unpreserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.pending.free_list = IOMMU_PAGES_LIST_INIT(
+			collect.pending.free_list),
+	};
+
+	iommu_pages_list_add(&collect.pending.free_list, range.top_table);
+
+	/*
+	 * pt_walk_range() will never fail as check_mapped is not set in the
+	 * collect args.
+	 */
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	iommu_unpreserve_pages_list(&collect.pending.free_list);
+}
+
+static int NS(preserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.pending.free_list = IOMMU_PAGES_LIST_INIT(
+			collect.pending.free_list),
+	};
+	int ret;
+
+	iommu_pages_list_add(&collect.pending.free_list, range.top_table);
+
+	/*
+	 * pt_walk_range() will never fail as check_mapped is not set in the
+	 * collect args.
+	 */
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	ret = iommu_preserve_pages_list(&collect.pending.free_list);
+	if (ret)
+		return ret;
+
+	ser->top_table_phys = virt_to_phys(range.top_table);
+	ser->top_level = range.top_level;
+
+	/*
+	 * VASZ and SIGN_EXTEND will be needed in next kernel for collector page
+	 * table walk to restore and free pages.
+	 *
+	 * Use the max_vasz_lg2 from range, as that is the current one if
+	 * DYNAMIC_TOP is supported.
+	 */
+	ser->vasz = range.max_vasz_lg2;
+	ser->sign_extend = pt_feature(common, PT_FEAT_SIGN_EXTEND);
+
+	return 0;
+}
+
+static int __restore_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	int ret;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_restore_pages(virt_to_phys(pts.table_lower));
+
+			/*
+			 * pt_descend can only fail if pts.table_lower is not
+			 * init. So the if statement below is dead code.
+			 */
+			ret = pt_descend(&pts, arg, __restore_tables);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void NS(deinit)(struct pt_iommu *iommu_table);
+static const struct pt_iommu_ops NS(ops_immutable) = {
+	.deinit = NS(deinit),
+};
+
+static int NS(restore)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range;
+
+	if (ser->vasz > common->max_vasz_lg2 ||
+	    ser->top_level > PT_MAX_TOP_LEVEL)
+		return -EINVAL;
+
+	/*
+	 * Override the max_vasz_lg2 here to the one calculated using top_range
+	 * in previous kernel. This makes sure that any later page walks use the
+	 * clamped max_vasz_lg2 instead of using the full hardware maximum
+	 * max_vasz_lg2.
+	 */
+	common->max_vasz_lg2 = ser->vasz;
+
+	/*
+	 * Restored page tables are strictly transient and only permitted to be
+	 * destroyed via deinit() op. Because we only preserve user-assigned
+	 * devices utilizing pass-through frameworks (VFIO / IOMMUFD), any
+	 * concurrent or subsequent map/unmap operations on a restored domain
+	 * are explicitly blocked at the subsystem boundary (e.g., via IOAS
+	 * immutability).
+	 */
+	iommu_table->ops = &NS(ops_immutable);
+
+	/*
+	 * It is safe to override this here since this domain is immutable and
+	 * can only be freed. This also means that for non-coherent pages DMA
+	 * mappings will not be created using the DMA API.
+	 *
+	 * Note that the FMT specific bits are not cleared as they might be
+	 * set/preserved/restored by the driver to handle special cases that are
+	 * required for page walks.
+	 */
+	common->features &= ~GENMASK(PT_FEAT_FMT_START - 1, 0);
+	if (ser->sign_extend)
+		common->features |= BIT(PT_FEAT_SIGN_EXTEND);
+
+	range = pt_all_range(common);
+	iommu_restore_pages(ser->top_table_phys);
+
+	/*
+	 * The old top_table can be freed here as it is not used for any IOMMU
+	 * mappings yet, because the restore happens during device probe.
+	 */
+	iommu_pages_free_incoherent(range.top_table,
+				    iommu_table->iommu_device);
+
+	/* Set the restored top table */
+	pt_top_set(common, phys_to_virt(ser->top_table_phys), ser->top_level);
+
+	/* Restore all pages*/
+	range = pt_all_range(common);
+	return pt_walk_range(&range, __restore_tables, NULL);
+}
+#endif
+
 struct pt_unmap_args {
 	struct iommupt_pending_gather pending;
 	pt_vaddr_t unmapped;
@@ -1188,6 +1335,11 @@ static const struct pt_iommu_ops NS(ops) = {
 #endif
 	.get_info = NS(get_info),
 	.deinit = NS(deinit),
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	.preserve = NS(preserve),
+	.unpreserve = NS(unpreserve),
+	.restore = NS(restore),
+#endif
 };
 
 static int pt_init_common(struct pt_common *common)
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
index ece1c9b8c55d..83bf18be8c1e 100644
--- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -427,6 +427,35 @@ static void test_mixed(struct kunit *test)
 	check_iova(test, start, oa, len);
 }
 
+static void test_restore_free(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+	u64 start = 0x3fe400ULL << 12;
+	u64 end = 0x4c0600ULL << 12;
+	pt_vaddr_t len = end - start;
+
+	if (top_range.last_va <= start || sizeof(unsigned long) == 4)
+		kunit_skip(test, "range is too small");
+	if ((priv->safe_pgsize_bitmap & GENMASK(30, 21)) != (BIT(30) | BIT(21)))
+		kunit_skip(test, "incompatible psize");
+
+	/* Map a large mixed range to populate multiple levels of page tables */
+	do_map(test, start, start, len);
+
+	/*
+	 * Simulate a restored state by clearing all features except SIGN_EXTEND
+	 * and DMA_INCOHERENT. This verifies that the generic page table free
+	 * walker can correctly tear down a populated domain when other features
+	 * are zeroed. Also set max_vasz_lg2 as done by the actual restore()
+	 * function.
+	 */
+	priv->common->features &= (BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_DMA_INCOHERENT));
+	priv->common->max_vasz_lg2 = top_range.max_vasz_lg2;
+
+	/* The domain will be freed when the test exits. */
+}
+
 static struct kunit_case iommu_test_cases[] = {
 	KUNIT_CASE_FMT(test_increase_level),
 	KUNIT_CASE_FMT(test_map_simple),
@@ -435,6 +464,7 @@ static struct kunit_case iommu_test_cases[] = {
 	KUNIT_CASE_FMT(test_random_map),
 	KUNIT_CASE_FMT(test_pgsize_boundary),
 	KUNIT_CASE_FMT(test_mixed),
+	KUNIT_CASE_FMT(test_restore_free),
 	{},
 };
 
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..faa41d8032fe 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -13,6 +13,7 @@ struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 struct pt_iommu_driver_ops;
 struct iommu_dirty_bitmap;
+struct iommu_domain_ser;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -166,6 +167,35 @@ struct pt_iommu_ops {
 	 * table from all HW access and all caches.
 	 */
 	void (*deinit)(struct pt_iommu *iommu_table);
+
+	/**
+	 * @preserve: Preserve the iommu page table for liveupdate
+	 * @iommu_table: Table to preserve
+	 * @ser: Serialization struct to fill with preserved state
+	 *
+	 * Preserve iommu page table and the relevant state for liveupdate. The
+	 * caller must make sure that the page table is not updated during and
+	 * after preservation.
+	 */
+	int (*preserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser);
+
+	/**
+	 * @unpreserve: Unpreserve the iommu page table
+	 * @iommu_table: Table to unpreserve
+	 * @ser: Serialization struct that contains preserved state
+	 */
+	void (*unpreserve)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser);
+
+	/**
+	 * @restore: Restore the iommu page table after liveupdate
+	 * @iommu_table: Table to restore the state into
+	 * @ser: Serialization struct that contains preserved state
+	 *
+	 * The iommu_table is back filled with the restored state that was
+	 * preserved in the serialization struct.
+	 */
+	int (*restore)(struct pt_iommu *iommu_table, struct iommu_domain_ser *ser);
+
 };
 
 /**
-- 
2.55.0.679.g6767b8d81c-goog

