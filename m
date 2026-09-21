Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB7288505
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951727; cv=none; b=Ul44Z7t3GWVPsFKtqREu3O+hbZ7OKXM7InLITVltYqV32o9e44DR11P0MRnd6I+tHlXZ+7UcKRaAIpzJASR2KLVitbBP8L5P1JQNXunaHIL9FU5JaPNlitnLoxDfCHZ3dt2mNO4NM5M5PBkWT/czZyYh92JlRaxH4M+AdGwie4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951727; c=relaxed/simple;
	bh=iOp397Tg1uyFDkJ+PjIYFgFLwFOnJQaPRudOX/K8Wi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=maeM9p/ZoDMeMpTsQJ/NTMnrJ6z6IszaZEQrtui+5fFoQcO2wHuRCBCop2CoMxklvkPJbs+rytyq0UvgmnnednluoTdDqYM+RSazji+qxQDher4tl8dU1i6JbjLUu1QbTGYxTlq17+ITBiRrGK886/D6Uj3MoFNO3/iMxtg76DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNvDIs/B; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNvDIs/B"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63bad3d09so35784275ad.3
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 17:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951724; x=1790556524; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2C1NA4Y2gkk+MrlRvGBVzGfZjWst0By6u+UYLSUEdKI=;
        b=RNvDIs/BfNicVKl2jsqDMq+/mTT4/41W7bYfvvs8UYF/L2zds3N7b/BJuXbiCz1o/2
         dCG+pxtHcELDLJRTfMYDO9acOnFYDK4At9ylXWD9XK5CRQGf4PWN4+Y6mfFdH0q2egG7
         jWW1Fhwkaah5K2imZG8T+rgd0yfkVnIlj+kpcFi2fyVCFEwgoKk6GkG463ZvtdJwqm3X
         7E2M2PO3oLmS4CLuYOxa+/2RZBgZxU9HyfH7ihknAGS/zidu2kFkBP8KCpBQGqUk+A6W
         ZG0OtrAYD7/thQTjPJfnk8flbp5RkL/hcs1R7it6BdEAqzI/JiM6Cm7UBgId5cB+DCaA
         1uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951724; x=1790556524;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2C1NA4Y2gkk+MrlRvGBVzGfZjWst0By6u+UYLSUEdKI=;
        b=QsL3jgGeavasmy6R6Ug9I+AayppvXHAdj/LS45xrvc6dek5fNAR8zdQCfFbtIbWYbn
         e7ogup+6abMKE9Ll/hcBKQlAyGKpJriCHqGb1aKCPNLelbgzTOGLLocJHVZO6GjeCAMS
         iek1i/uS1OAksVaZboXUyrEX8NtLAO9ByhjufxWlOQ5g1mV+HzjQanlmmZJ/Jmz/vX8g
         34WO0os1Ff+fEwuV2pvn32jNK1PuIq/DfywvHZ/oYJS3bprHnV819E+hCSV6oKk4Mri/
         KJB6etKzx0m1mL+GGsRvafMSNSPBqghGiUDnAiSok52HnlxqDF7JsfwibNUs6ulDjg+R
         rggA==
X-Forwarded-Encrypted: i=1; AKwUvBzksNCmIwvtqMlXTacpcBlIeiDqKSJCXbt/ogdim66gE4eawLNLV4ouD/pe1XbAkymT07504A==@lists.linux.dev
X-Gm-Message-State: AFuF++lCjTPfaWcozN2BY3ljcL6sZwfGQ0FgQQpP4AP5S9RZYiToownx
	MpJhxJIT33+WTJP5/GpIiWfB6IP68VzzSSF+Ib4U1eNF9VOiwehBj8i6BEdNKMWvS4tWHhojZFJ
	dzSSdq/aU7xD6Dg==
X-Received: from plmg19.prod.google.com ([2002:a17:903:3cd3:b0:2dd:b156:5a6e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:b106:b0:2dd:c053:d73d with SMTP id d9443c01a7336-2ddc053d7camr58889585ad.36.1789951724292;
 Sun, 20 Sep 2026 17:48:44 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:20 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-5-skhawaja@google.com>
Subject: [PATCH v5 04/18] iommupt: Implement preserve/unpreserve/restore callbacks
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
index 07ec2b3ab986..2945ddb771d1 100644
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
2.55.0.1082.g2b9226bbc0-goog

