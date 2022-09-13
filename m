Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC266E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:14 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id w4so10114260qvp.2
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ivekPqFwDTKnplQubqOcOnwSj5SwqgEqKMLIx8G0mTA=;
        b=kvUC28iyEDcMoby9xrnJHhocivoBZj9gqY+ui6eXHvBbq0tXS2dzYAAmqBdXCNT1wy
         Q0fTtOM1kwBq1neZJJDtv8OVb2E4WTXaookEyrn9UWfnw0gFlPMPSsLKdxzfJXEQRdps
         TBY/dxDfKDXG5nzytFERu/dU7OZ7FBxZvIzoh4dkW/QYs2YW41IfiKdkkwlFW8nnTbi2
         RA0eP5SekM1KC2ny0+Tc+vzS7nujN6k/2bx9b8Rj/IE1ke6REKO17fe0+no3v3V+6DPQ
         hTcXXufvBklDdoPK3SevxPEu7k9onHuyK1D6iBkExepS0BnC5h2ewbJv8V7xNvAFJRmS
         S5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ivekPqFwDTKnplQubqOcOnwSj5SwqgEqKMLIx8G0mTA=;
        b=P0ecknKqPv0oo6+2ggqfFNbMLHzIQmWDvVfjAtmpGXkaNOgT5lJ/8mz8mK3Sc9+hXN
         TapzenCdhkmlg9L1qpsZ4WCgu1jDgBYPufXR9v0SBw7M67zEY1YmWi94pE9ag8fxtiau
         8j0zEb1RohQV0EacobZGiRBhLU6ayf3o3LE5S15wu8emOmr6iXg7YbH17V3Lg/PclJNq
         0eNo2vuGPcq+foZoDT/cIuG276EPvYXakjVIgw1GBxRqp/QhFcGrBqa4tzbViKYHFxze
         6wxQ1dZ+SMJSKY7/Xe+5wtN/NG2BGcLqVFJSIe9S1SaLWYwrykGw+0u1XjkeihPWdggs
         I36g==
X-Gm-Message-State: ACgBeo2TB3PgyK/wMS+cVlq3ZtbwbTl+wRZevYYqOVlGVYCf8AdJUx2n
	YPHvS4aNVcVu8n1Fgs/WIzM=
X-Google-Smtp-Source: AA6agR5Uplm7zgaGZn1afr+syf2bXEr/tRhasRhXystutC9gt9duBJzLy1nlXABisQhehw9c0OtbIg==
X-Received: by 2002:a05:6214:1c09:b0:4ac:9160:7484 with SMTP id u9-20020a0562141c0900b004ac91607484mr17181443qvc.13.1663099092959;
        Tue, 13 Sep 2022 12:58:12 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:12 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	- <devicetree-spec@vger.kernel.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH 05/21] mm/hugetlb: allow migrated hugepage to dissolve when freed
Date: Tue, 13 Sep 2022 12:54:52 -0700
Message-Id: <20220913195508.3511038-6-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no isolation mechanism for hugepages so a hugepage that
is migrated is returned to its hugepage freelist. This creates
problems for alloc_contig_range() because migrated hugepages can
be allocated as migrate targets for subsequent hugepage migration
attempts.

Even if the migration succeeds the alloc_contig_range() attempt
will fail because test_pages_isolated() will find the now free
hugepages haven't been dissolved.

A subsequent attempt by alloc_contig_range() is necessary for the
isolate_migratepages_range() function to find the freed hugepage
and dissolve it (assuming it has not been reallocated).

A workqueue is introduced to perform the equivalent functionality
of alloc_and_dissolve_huge_page() for a migrated hugepage when it
is freed so that the pages can be released to the isolated page
lists of the buddy allocator allowing the alloc_contig_range()
attempt to succeed.

The HPG_dissolve hugepage flag is introduced to allow tagging
migratable hugepages that should be dissolved when freed.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/hugetlb.h |  5 +++
 mm/hugetlb.c            | 72 ++++++++++++++++++++++++++++++++++++++---
 mm/migrate.c            |  1 +
 mm/page_alloc.c         |  1 +
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3ec981a0d8b3..0e6e21805e51 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -222,6 +222,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void sync_hugetlb_dissolve(void);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -430,6 +431,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void sync_hugetlb_dissolve(void) { }
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
@@ -574,6 +577,7 @@ enum hugetlb_page_flags {
 	HPG_freed,
 	HPG_vmemmap_optimized,
 	HPG_raw_hwp_unreliable,
+	HPG_dissolve,
 	__NR_HPAGEFLAGS,
 };
 
@@ -621,6 +625,7 @@ HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
 HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
 HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
+HPAGEFLAG(Dissolve, dissolve)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f232a37df4b6..da80889e1436 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1582,6 +1582,10 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	}
 }
 
+static LLIST_HEAD(hpage_dissolvelist);
+static void dissolve_hpage_workfn(struct work_struct *work);
+static DECLARE_WORK(dissolve_hpage_work, dissolve_hpage_workfn);
+
 /*
  * As update_and_free_page() can be called under any context, so we cannot
  * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
@@ -1628,6 +1632,8 @@ static inline void flush_free_hpage_work(struct hstate *h)
 {
 	if (hugetlb_vmemmap_optimizable(h))
 		flush_work(&free_hpage_work);
+	if (!hstate_is_gigantic(h))
+		flush_work(&dissolve_hpage_work);
 }
 
 static void update_and_free_page(struct hstate *h, struct page *page,
@@ -1679,7 +1685,7 @@ void free_huge_page(struct page *page)
 	struct hstate *h = page_hstate(page);
 	int nid = page_to_nid(page);
 	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
-	bool restore_reserve;
+	bool restore_reserve, dissolve;
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(page_count(page), page);
@@ -1691,6 +1697,8 @@ void free_huge_page(struct page *page)
 	page->mapping = NULL;
 	restore_reserve = HPageRestoreReserve(page);
 	ClearHPageRestoreReserve(page);
+	dissolve = HPageDissolve(page);
+	ClearHPageDissolve(page);
 
 	/*
 	 * If HPageRestoreReserve was set on page, page allocation consumed a
@@ -1729,6 +1737,11 @@ void free_huge_page(struct page *page)
 		remove_hugetlb_page(h, page, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page, true);
+	} else if (dissolve) {
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
+		if (llist_add((struct llist_node *)&page->mapping,
+			      &hpage_dissolvelist))
+			schedule_work(&dissolve_hpage_work);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
@@ -2771,6 +2784,49 @@ static void replace_hugepage(struct hstate *h, int nid, struct page *old_page,
 	enqueue_huge_page(h, new_page);
 }
 
+static void dissolve_hpage_workfn(struct work_struct *work)
+{
+	struct llist_node *node;
+
+	node = llist_del_all(&hpage_dissolvelist);
+
+	while (node) {
+		struct page *oldpage, *newpage;
+		struct hstate *h;
+		int nid;
+
+		oldpage = container_of((struct address_space **)node,
+				       struct page, mapping);
+		node = node->next;
+		oldpage->mapping = NULL;
+
+		h = page_hstate(oldpage);
+		nid = page_to_nid(oldpage);
+
+		newpage = alloc_replacement_page(h, nid);
+
+		spin_lock_irq(&hugetlb_lock);
+		/* finish freeing oldpage */
+		arch_clear_hugepage_flags(oldpage);
+		enqueue_huge_page(h, oldpage);
+		if (IS_ERR(newpage)) {
+			/* cannot dissolve so just leave free */
+			spin_unlock_irq(&hugetlb_lock);
+			goto next;
+		}
+
+		replace_hugepage(h, nid, oldpage, newpage);
+
+		/*
+		 * Pages have been replaced, we can safely free the old one.
+		 */
+		spin_unlock_irq(&hugetlb_lock);
+		__update_and_free_page(h, oldpage);
+next:
+		cond_resched();
+	}
+}
+
 /*
  * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
  * @h: struct hstate old page belongs to
@@ -2803,6 +2859,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 */
 		spin_unlock_irq(&hugetlb_lock);
 		ret = isolate_hugetlb(old_page, list);
+		SetHPageDissolve(old_page);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
 	} else if (!HPageFreed(old_page)) {
@@ -2864,14 +2921,21 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (page_count(head) && !isolate_hugetlb(head, list))
+	if (page_count(head) && !isolate_hugetlb(head, list)) {
+		SetHPageDissolve(head);
 		ret = 0;
-	else if (!page_count(head))
+	} else if (!page_count(head)) {
 		ret = alloc_and_dissolve_huge_page(h, head, list);
-
+	}
 	return ret;
 }
 
+void sync_hugetlb_dissolve(void)
+{
+	flush_work(&free_hpage_work);
+	flush_work(&dissolve_hpage_work);
+}
+
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
diff --git a/mm/migrate.c b/mm/migrate.c
index 6a1597c92261..b6c6123e614c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -141,6 +141,7 @@ void putback_movable_pages(struct list_head *l)
 
 	list_for_each_entry_safe(page, page2, l, lru) {
 		if (unlikely(PageHuge(page))) {
+			ClearHPageDissolve(page);
 			putback_active_hugepage(page);
 			continue;
 		}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..6bf76bbc0308 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9235,6 +9235,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	if (ret && ret != -EBUSY)
 		goto done;
 	ret = 0;
+	sync_hugetlb_dissolve();
 
 	/*
 	 * Pages from [start, end) are within a pageblock_nr_pages
-- 
2.25.1

