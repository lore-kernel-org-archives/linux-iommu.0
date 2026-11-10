Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283717;
	b=gvT9eviYu4yksYZah816RfE3tX53JaoW15iX6Gl6Q/LpXhFa4GaDH730FCd8rp6egmTR
	 vx0vm6F4rq1XinrixvOvdEn0WEzzJYbQR0fQyFqnqeueVMm0R30EHPGFJO3xbznkWE8GH
	 11obnMq/ci2kPDmZjBqowJhyglXZqaCSMuwv4gvWg40zzgMy36U1sN6CKrNOrUW2GbIa+
	 l7pCncW7z6DL4iNB4Z9j5BjPI5+CcSBQlC8UtXUaLlT/wgIVzlS6ApfHGYJySvPnQBgX7
	 RTRHZd7OX42Cp4X2qXVYIy88xcwpJsWcE8KEVPuGMoF1qMTDtWPGs1xVMGKJunzzFtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=B9lAyV/x5/hfGaUSiw6mbDUfBF5DuSO6OL83gmt2yFA=;
	b=hQGmtOMHJnlUBoqk7146G78Ko6EKkcp+EhBjFU6uvFnkX4mi4UHxNAsxMkXQlueiuVhC
	 1VdX6XHU62zGaNi40UGl/7ITiKOb9sJYExXhm+EqrI3B5/NIDmQTQoUeGSO7/ebB2UmYq
	 uzIjw1C/AzIVvBKlQDPgotMNsBUzlLrXbgtgf1Ylc7lX1RQF6D/RsoJxOsRRkavWo8ORj
	 rG9Iw9QpW8OFPZcWohPdHKfVTKur8Bx1lnkrYU12Kc8DNQo9zJSyKJNX27+334fE925k9
	 rj78VSNsN/8Bl4HfuX0NB1vkyLMlZQKVpOHbnbaj0xbsG1IhNjbj+QyE3tEK/tCFv5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ig7lgi2J;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDC60A2624
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECCDC60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ig7lgi2J
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b26d8d2498so1923065b6e.2
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283716; x=1794888516; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B9lAyV/x5/hfGaUSiw6mbDUfBF5DuSO6OL83gmt2yFA=;
        b=ig7lgi2JINfkJetba2cG4DxkuGOUfLTFmKpn/oF5K5/OyfwbQbNlepe46kdmgPEbMG
         pHjXNBWjPajBpEulQykYWpyW18YEIvWRjQhB4BhOEJ/8gFYaSKCpncBtvaP+Qx3Y20fW
         fPb5Dq4LLd4/OhD1p/TJ4PnQKl3gLms1LMDvxqy9mDrOatQ292yDJIfQ4WUz49+ndCge
         A78rqQxA18n3tFiK4+bAuEs5OodyiU+cR96CmlvhT/6eolDwj4wd6iXl7nYMCwo8Qvmp
         R/D4Z3RA6VREc7s3DKpqN51wDnE1wLXqXEruirR08skYy2VnyLTo2O5moc0jdT9FXtYM
         WGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283716; x=1794888516;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9lAyV/x5/hfGaUSiw6mbDUfBF5DuSO6OL83gmt2yFA=;
        b=ADDvBZ8DaVqbSEIm48kMKBMAh/yELXYsjfmXspKuegD0cn2ZyOSbkhgrGPsDdc71iV
         s6WUgmIu/gyzXzuIfVWuV2PNPvlGVbLerGCszTTJo23Nv0GNWa/ILa4ppksHcZOxA2hA
         tdPPco3JnORhoId3TN/4fM7bNEHndhhJlhtjgUtiagB4mrW17WA+CIrR98DEtoFqUZli
         NNHtJFcYV6faxDE6Oumr4rqlKcCyIi6f58Z/KC7cRQUPY9Ht1fJArftxTJ5zsFPRWi9p
         t678Ly8NeP2Kj/WpklOiguvFkyZjkTzXpWOs6RztUcmau5wbCsYxyW5fwjdVyyYcX+Eg
         zMQA==
X-Forwarded-Encrypted: i=1; AL+hErHvZ23E8FwRQP06OJq5wgWyzWa2LLbCw7L/OTYw5GaJ3rvde4lLLxiPJn/S8zkNECKuWiD8Ig==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ZkfSQEGnhmeFRQ869gKLopHvS4UTIsvSETgJIMJeZxLjFGVai
	bnstIFYZwCsCLYID+khfEpCsy5QANfw4nJrrVE/daK9oeFQ4WVxwaE/JAdaW0BpyMFxdFhZeE4Y
	9dMYeXOUMfy+n5A==
X-Received: from ilpy14.prod.google.com ([2002:a92:c74e:0:b0:542:e9f4:1733])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:f12:b0:4ec:d521:9124 with SMTP id 5614622812f47-5683cc817ffmr1095684b6e.30.1794283715550;
 Mon, 09 Nov 2026 20:08:35 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:09 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-4-skhawaja@google.com>
Subject: [PATCH v7 03/18] iommupt: Implement preserve/unpreserve/restore callbacks
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Add iommupt ops for preservation, unpreservation and restoration of iommu
page tables for liveupdate. Use the existing page walker to preserve the
ioptdesc of the top_table and the lower tables.

Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
the next kernel. On restore, the domain has only the preserved features
enabled and all the other features are zeroed. This is ok since the
restored domain is made immutable and can only be freed. A kunit test is
added to verify that the IOMMU domain free can be done with trimmed
features.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/generic_pt/iommu_pt.h       | 155 ++++++++++++++++++++++
 drivers/iommu/generic_pt/kunit_iommu_pt.h |  30 +++++
 include/linux/generic_pt/iommu.h          |  30 +++++
 3 files changed, 215 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 837d835e4fad..b50dc94231f8 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -16,6 +16,7 @@
 #include "../iommu-pages.h"
 #include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu-liveupdate.h>
 
 enum {
 	SW_BIT_CACHE_FLUSH_DONE = 0,
@@ -991,6 +992,155 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
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
+	ser->max_vasz_lg2 = range.max_vasz_lg2;
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
+	if (!pt_can_have_table(&pts))
+		return 0;
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
+	if (ser->max_vasz_lg2 > common->max_vasz_lg2 ||
+	    ser->top_level > PT_MAX_TOP_LEVEL)
+		return -EINVAL;
+
+	/*
+	 * Override the max_vasz_lg2 here to the one calculated using top_range
+	 * in previous kernel. This makes sure that any later page walks use the
+	 * clamped max_vasz_lg2 instead of using the full hardware maximum
+	 * max_vasz_lg2.
+	 */
+	common->max_vasz_lg2 = ser->max_vasz_lg2;
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
@@ -1174,6 +1324,11 @@ static const struct pt_iommu_ops NS(ops) = {
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
index 9fc71db74234..7306de44eb00 100644
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
index 13ebb72a67de..617fb9af6bef 100644
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
2.56.0.506.g506a7eabc5-goog

