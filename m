Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233C42376F
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895759; cv=none; b=ht5STV+g11KiXrr3jTjxXik9FF4ewA/8dom4ne23JRc9y9zEYwkqkM2VseWa06Ht0qs+6FYqdS+EnItAyEByygwpte4+xPeBqHJYt5m3cJY9sbp2NSz2nXH6NaFK7vqqF1/Es3MPgDpZR9vhRD99+umIYrZCM82XCb49Z0zkh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895759; c=relaxed/simple;
	bh=Ha2pfn1El0S8X4GbofKW/w55jh0hwLA01gcxtKY8ZoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pPaVTxLlqIxImvBVcKTFoAnS94E/Gj0Rbr2ArqMr60tmia1qbdhZIX8LKZRxTBGcLfiTW76Vor/xsG650D2+nU/l0KzTf1g5p07LSi7zasI9fML5AqrHEOvDWHxeXFw00k8dT/JWuhGEFk7fliuoXK+w2Zh9glNNVr729G3pnkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9HjKLYn; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9HjKLYn"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so4369304a12.1
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 16:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790895753; x=1791500553; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJrWGhIUCMZjcOgrTph+7DK2V9sLKYTEdoJCIvpwPr0=;
        b=i9HjKLYnyh9G6zmCrV8UoiYKAc2c+eUWuYtLTn9fA340w0hCYnqamAObEZYSoG4duT
         ifTIM5BsJ/8zp45bwlkKcexYMw3QM3FoTXURXfOtwESGpA8q+eQY+WFpq+jOKl2UcFhW
         Q9XfyEwtQVJZIihM+k5Sz4Ll3+vhEt4G2LRlXKja9cQYjZ6Vz9ssytHcVW2csXeT2wYC
         NZgRb2UTncQ2XBO21jYGNyVFloxx/7EoXw2Ze3nGkvt8m2jxtrSwczDR0s987534WmL8
         6TcmEGPG4TEn8pAd2GraBbx3pNmm4KLyPy1xjMrnmC+VBVGr9lpGNw3nDuM8Fpb2EW7s
         jbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790895753; x=1791500553;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJrWGhIUCMZjcOgrTph+7DK2V9sLKYTEdoJCIvpwPr0=;
        b=qeJcwur9E4ALTjfe+CmI4gSLvi1lN7T7q73q94VVw1IOE/DevYVGAvyqVP/Cfi0IEx
         5LyJ0woyjMArDVBGZXFIW6DTYCBE5Kr1GlQOC5Fh8GKkLmkS+iBNtTIn6RKT6sBVp+kA
         /29ICV52cBItGQGEdj4JeDEkwjmJJpory42y7eFPaYC3bHf/tly1jBi+x5S0cKgNm3Xc
         QkZpNKgwMNjvzP4UVUNkIcM7nCuQVsQbO29OerPk2uqIh8NMzYO8pYeCDAnVwx6W6/sc
         ebtK1VL3dcjMPBMJpRdUJbfbg1Mn5u8dNBHk2XlzPzBEmvNC4f2YYch15hEuQrNVA37q
         Nj2g==
X-Forwarded-Encrypted: i=1; AKwUvBwRJa9pX0XxeJaTKyOqlvEV82ijCFSpNt4PF2RDt4vNSJQn5hRdcJ/IrgSA3+HI3dMRZeE7Zg==@lists.linux.dev
X-Gm-Message-State: AFuF++lorGlAgyrx3lK+0y3AydVIwdUCIlNVSMz4Re4NLW1ByEaFqIlV
	uiODawWZOHi3HAlz7An7NhtlsTjjalwE6HDd5Eo19jYTAP9VKC1VR1I/nWe1NT5SnKJe9UITEX5
	74Q==
X-Received: from pgbeu25.prod.google.com ([2002:a05:6a02:4799:b0:cc7:d5c2:b58a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:938e:b0:3da:421e:40f3
 with SMTP id adf61e73a8af0-3e0bd195e56mr906637637.17.1790895752940; Thu, 01
 Oct 2026 16:02:32 -0700 (PDT)
Date: Thu,  1 Oct 2026 23:02:18 +0000
In-Reply-To: <20261001230219.818128-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261001230219.818128-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001230219.818128-5-praan@google.com>
Subject: [RFC PATCH 4/5] iommupt: Introduce lockless page table shrinker
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Logan Odell <loganodell@google.com>, iommu@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Under system memory pressure, intermediate IOMMU page table directories
that were left stranded by sparse unmaps consume valuable RAM. Introduce
an IO Page Table Shrinker to reclaim such memory.

The shrinker locklessly harvests empty directories from the per-domain
Xarrays, severs them from the page table tree using the format-agnostic
sever_branch helper. It employs a single, global synchronize_srcu grace
period before freeing the memory to protect against concurrent maps.
SRCU is an appropriate choice because the allocation during map may sleep

After severing, flush the domain's IOTLB so the IOMMU drops any cached
pointers to the severed tables before they are freed.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/Makefile              |   2 +-
 drivers/iommu/generic_pt/iommu_pt.h |  16 +++-
 drivers/iommu/generic_pt/shrinker.c | 136 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  10 ++
 4 files changed, 160 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/shrinker.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 2f05725eaab1..ad30c4b7566e 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -3,7 +3,7 @@ obj-y += arm/ iommufd/
 obj-$(CONFIG_AMD_IOMMU) += amd/
 obj-$(CONFIG_INTEL_IOMMU) += intel/
 obj-$(CONFIG_RISCV_IOMMU) += riscv/
-obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
+obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/ generic_pt/shrinker.o
 obj-$(CONFIG_HYPERV) += hyperv/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 868242eb2d55..e5ee419f2f0b 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -916,7 +916,7 @@ static int check_map_range(struct pt_iommu *iommu_table, struct pt_range *range,
 static int do_map(struct pt_range *range, struct pt_common *common,
 		  bool single_page, struct pt_iommu_map_args *map)
 {
-	int ret;
+	int ret, idx;
 
 	/*
 	 * The __map_single_page() fast path does not support DMA_INCOHERENT
@@ -924,17 +924,21 @@ static int do_map(struct pt_range *range, struct pt_common *common,
 	 */
 	if (single_page && !pt_feature(common, PT_FEAT_DMA_INCOHERENT)) {
 
+		idx = srcu_read_lock(&generic_pt_srcu);
 		ret = pt_walk_range(range, __map_single_page, map);
+		srcu_read_unlock(&generic_pt_srcu, idx);
 		if (ret != -EAGAIN)
 			return ret;
 		/* EAGAIN falls through to the full path */
 	}
 
 	do {
+		idx = srcu_read_lock(&generic_pt_srcu);
 		if (map->leaf_level == range->top_level)
 			ret = pt_walk_range(range, __map_range_leaf, map);
 		else
 			ret = pt_walk_range(range, __map_range, map);
+		srcu_read_unlock(&generic_pt_srcu, idx);
 	} while (ret == -EAGAIN);
 	return ret;
 }
@@ -1142,13 +1146,15 @@ static size_t NS(unmap_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
 			unmap.pending.free_list),
 	};
 	struct pt_range range;
-	int ret;
+	int ret, idx;
 
 	ret = make_range(common_from_iommu(iommu_table), &range, iova, len);
 	if (ret)
 		return 0;
 
+	idx = srcu_read_lock(&generic_pt_srcu);
 	pt_walk_range(&range, __unmap_range, &unmap);
+	srcu_read_unlock(&generic_pt_srcu, idx);
 
 	gather_range_pending(&unmap.pending, iommu_table, iova, unmap.unmapped);
 
@@ -1170,7 +1176,8 @@ static int __sever_branch(struct pt_range *range, void *arg,
 	case PT_ENTRY_TABLE:
 		if (virt_to_phys(pt_table_ptr(&pts)) == sever->expected_phys) {
 			sever->success = pt_table_install64(&pts, 0x0);
-			return 1; /* Stop walking */
+			/* Stop walking */
+			return 1;
 		}
 		return pt_descend(&pts, arg, __sever_branch);
 	default:
@@ -1231,6 +1238,8 @@ static void NS(deinit)(struct pt_iommu *iommu_table)
 			collect.pending.free_list),
 	};
 
+	generic_pt_shrinker_remove(iommu_table);
+
 	iommu_pages_list_add(&collect.pending.free_list, range.top_table);
 	pt_walk_range(&range, __collect_tables, &collect);
 
@@ -1407,6 +1416,7 @@ int pt_iommu_init(struct pt_iommu_table *fmt_table,
 
 	/* Must be last, see pt_iommu_deinit() */
 	iommu_table->ops = &NS(ops);
+	generic_pt_shrinker_add(iommu_table);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(pt_iommu_init, "GENERIC_PT_IOMMU");
diff --git a/drivers/iommu/generic_pt/shrinker.c b/drivers/iommu/generic_pt/shrinker.c
new file mode 100644
index 000000000000..66169fb5db71
--- /dev/null
+++ b/drivers/iommu/generic_pt/shrinker.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Author: Pranjal Shrivastava <praan@google.com>
+ * IO Page table reclamation (Shrinker) for generic_pt.
+ */
+
+#include <linux/iommu.h>
+#include <linux/shrinker.h>
+#include <linux/srcu.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include "../iommu-pages.h"
+#include <linux/generic_pt/iommu.h>
+
+DEFINE_SRCU(generic_pt_srcu);
+EXPORT_SYMBOL_GPL(generic_pt_srcu);
+
+static LIST_HEAD(generic_pt_domains_list);
+static DEFINE_MUTEX(generic_pt_domains_list_lock);
+
+void generic_pt_shrinker_add(struct pt_iommu *iommu)
+{
+	mutex_lock(&generic_pt_domains_list_lock);
+	list_add_tail(&iommu->shrinker_list, &generic_pt_domains_list);
+	mutex_unlock(&generic_pt_domains_list_lock);
+}
+EXPORT_SYMBOL_GPL(generic_pt_shrinker_add);
+
+void generic_pt_shrinker_remove(struct pt_iommu *iommu)
+{
+	mutex_lock(&generic_pt_domains_list_lock);
+	list_del(&iommu->shrinker_list);
+	mutex_unlock(&generic_pt_domains_list_lock);
+}
+EXPORT_SYMBOL_GPL(generic_pt_shrinker_remove);
+
+static unsigned long generic_pt_shrinker_count(struct shrinker *shrink,
+					       struct shrink_control *sc)
+{
+	struct pt_iommu *iommu;
+	unsigned long count = 0;
+
+	mutex_lock(&generic_pt_domains_list_lock);
+	list_for_each_entry(iommu, &generic_pt_domains_list, shrinker_list) {
+		struct iommu_domain *domain = &iommu->domain;
+
+		/* TODO: Return real nr_pages here! */
+		if (!xa_empty(&domain->reclaim_list))
+			count += 1;
+	}
+	mutex_unlock(&generic_pt_domains_list_lock);
+
+	return count;
+}
+
+static unsigned long generic_pt_shrinker_scan(struct shrinker *shrink,
+					      struct shrink_control *sc)
+{
+	struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
+	struct pt_iommu *iommu;
+	struct ioptdesc *ioptdesc;
+	unsigned long iova;
+	unsigned long freed_count = 0;
+
+	mutex_lock(&generic_pt_domains_list_lock);
+	list_for_each_entry(iommu, &generic_pt_domains_list, shrinker_list) {
+		struct iommu_domain *domain = &iommu->domain;
+		unsigned long prev_freed = freed_count;
+
+		xa_for_each(&domain->reclaim_list, iova, ioptdesc) {
+			if (freed_count >= sc->nr_to_scan)
+				break;
+
+			if (atomic_cmpxchg(&ioptdesc->__page_refcount, 1, 0) == 1) {
+				void *virt = folio_address(ioptdesc_folio(ioptdesc));
+
+				if (iommu->ops->sever_branch(iommu, iova, virt_to_phys(virt))) {
+					/* Successfully severed, queue for freeing */
+					xa_erase(&domain->reclaim_list, iova);
+					iommu_pages_list_add(&free_list, virt);
+					freed_count++;
+				} else {
+					/* We raced with map, abort pruning */
+					xa_erase(&domain->reclaim_list, iova);
+				}
+			} else {
+				/* Not empty anymore, remove from list */
+				xa_erase(&domain->reclaim_list, iova);
+			}
+		}
+
+		/*
+		 * The IOMMU may still cache pointers to the severed tables in its
+		 * paging-structure caches, flush them before the tables are freed.
+		 */
+		if (freed_count != prev_freed)
+			iommu_flush_iotlb_all(domain);
+	}
+	mutex_unlock(&generic_pt_domains_list_lock);
+
+	/* If we didn't sever anything, just return */
+	if (list_empty(&free_list.pages))
+		return freed_count;
+
+	/* Wait ONE time for the entire system */
+	synchronize_srcu(&generic_pt_srcu);
+
+	/* Free pages from all domains */
+	struct page *page, *next;
+
+	list_for_each_entry_safe(page, next, &free_list.pages, lru) {
+		/* We must restore the refcount to 1 before freeing */
+		set_page_count(page, 1);
+	}
+
+	iommu_put_pages_list(&free_list);
+
+	return freed_count;
+}
+
+static int __init generic_pt_shrinker_init(void)
+{
+	struct shrinker *shrinker;
+
+	shrinker = shrinker_alloc(0, "iommu-generic-pt");
+	if (!shrinker)
+		return -ENOMEM;
+
+	shrinker->count_objects = generic_pt_shrinker_count;
+	shrinker->scan_objects = generic_pt_shrinker_scan;
+
+	shrinker_register(shrinker);
+	return 0;
+}
+subsys_initcall(generic_pt_shrinker_init);
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index d1ade1767a9a..95bf9d4f0b6e 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -64,8 +64,18 @@ struct pt_iommu {
 	 * page table which must have dma ops that perform cache flushing.
 	 */
 	struct device *iommu_device;
+
+	/**
+	 * @shrinker_list: Node for the generic_pt global shrinker list
+	 */
+	struct list_head shrinker_list;
 };
 
+extern struct srcu_struct generic_pt_srcu;
+
+void generic_pt_shrinker_add(struct pt_iommu *iommu);
+void generic_pt_shrinker_remove(struct pt_iommu *iommu);
+
 static inline struct pt_iommu *iommupt_from_domain(struct iommu_domain *domain)
 {
 	if (!IS_ENABLED(CONFIG_IOMMU_PT) || !domain->is_iommupt)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

