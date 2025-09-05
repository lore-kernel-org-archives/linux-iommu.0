Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E812798FD
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 05:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051624; cv=none; b=P/ecKDSWUmg34VgGfuFYQiNkpbFcz+lZaxLtRGnOEyLNdV6O+mKGTZGrya8YmzL4YfuR+53P822zerQhWXbZo11t93UilBU+D0miue0tOgXPxWYccY/xAoV0/NFNfNkpI4/e3nULM3nSJBy+zcO8aOeMnI7rzC6MAAmL583EgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051624; c=relaxed/simple;
	bh=P5JIGWb9iyY68T6yIl818j1UQ6wwXyHZGcqrfTEb9vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjjMZFpk1uB9wtMkzpGYvxNW8nHUr4lTEj4GHc1V9a8g3z7sy++FROAuEk9+a7EbNvdoriZgbvdi4PuCG4Qu85PDASaNECtbVyFZ2ByKXKkIDcD+rfHe0AKPThxTm/wLoNr47b4W56jdzLrBQiCzVsRcYgDBfi/CPI636e2MTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbYQttwt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbYQttwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757051621; x=1788587621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P5JIGWb9iyY68T6yIl818j1UQ6wwXyHZGcqrfTEb9vQ=;
  b=VbYQttwt1WC9GTVfGl3rarb0pzuzWLyZRze8Wycr5dtK/e+RzgcMR7Jn
   9JZtjHMw3pLK/5wy9CLLWrfd1pbVEaSPX3YDVy8nK1H8gysSO6PDSTsxB
   /mTl0fI1TSawOwaIgCzavsVz+anqPZnB/zWRBcUVi/YUx/zk4yyIUmdNP
   meMD4U+nmKjeJmkw314V1Q/Sh+tYvWNKymkNU9QCAeK8Xca3la8ecDVIy
   WBKQ+Jrhu7sLbDQC+5CpvBGZMtA561oOPoHcSduMcd819Zg5BVHrx5Os2
   bjWQVcnOsGLYTq3Fz6wQdNO5tI9z+X6uoKoiBcPvT8f3+JCUaxhvrmmhH
   w==;
X-CSE-ConnectionGUID: ibjGYVAoTxy73l22YqVcRw==
X-CSE-MsgGUID: l39vttL3QQKnk18MYpr8CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70015146"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70015146"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:53:40 -0700
X-CSE-ConnectionGUID: wOiXTeePT1eXARJ/B23wag==
X-CSE-MsgGUID: WvaM95+WTbCD7Ulx+jogRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="209257761"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 22:53:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page tables
Date: Fri,  5 Sep 2025 13:51:01 +0800
Message-ID: <20250905055103.3821518-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

On x86 and other architectures that map the kernel's virtual address space
into the upper portion of every process's page table, the IOMMU's paging
structure caches can become stale when the CPU page table is shared with
IOMMU in the Shared Virtual Address (SVA) context. This occurs when a page
used for the kernel's page tables is freed and reused without the IOMMU
being notified.

While the IOMMU driver is notified of changes to user virtual address
mappings, there is no similar notification mechanism for kernel page
table changes. This can lead to data corruption or system instability
when Shared Virtual Address (SVA) is enabled, as the IOMMU's internal
caches may retain stale entries for kernel virtual addresses.

This introduces a conditional asynchronous mechanism, enabled by
CONFIG_ASYNC_PGTABLE_FREE. When enabled, this mechanism defers the freeing
of pages that are used as page tables for kernel address mappings. These
pages are now queued to a work struct instead of being freed immediately.

This deferred freeing provides a safe context for a future patch to add
an IOMMU-specific callback, which might be expensive on large-scale
systems. This ensures the necessary IOMMU cache invalidation is performed
before the page is finally returned to the page allocator outside of any
critical, non-sleepable path.

In the current kernel, some page table pages are allocated with an
associated struct ptdesc, while others are not. Those without a ptdesc are
freed using free_pages() and its variants, which bypasses the destructor
that pagetable_dtor_free() would run. While the long-term plan is to
convert all page table pages to use struct ptdesc, this uses a temporary
flag within ptdesc to indicate whether a page needs a destructor,
considering that this aims to fix a potential security issue in IOMMU SVA.
The flag and its associated logic can be removed once the conversion is
complete.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/mm.h   | 16 +++++++++++++---
 mm/pgtable-generic.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 668d519edc0f..6d10715ecbb0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2891,6 +2891,14 @@ static inline void __pagetable_free(struct ptdesc *pt)
 	__free_pages(page, compound_order(page));
 }
 
+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+void pagetable_free_async(struct ptdesc *pt);
+#else
+static inline void pagetable_free_async(struct ptdesc *pt)
+{
+	__pagetable_free(pt);
+}
+#endif
 /**
  * pagetable_free - Free pagetables
  * @pt:	The page table descriptor
@@ -2900,10 +2908,12 @@ static inline void __pagetable_free(struct ptdesc *pt)
  */
 static inline void pagetable_free(struct ptdesc *pt)
 {
-	if (ptdesc_test_kernel(pt))
+	if (ptdesc_test_kernel(pt)) {
 		ptdesc_clear_kernel(pt);
-
-	__pagetable_free(pt);
+		pagetable_free_async(pt);
+	} else {
+		__pagetable_free(pt);
+	}
 }
 
 #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 567e2d084071..cf884e8300ca 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -406,3 +406,42 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	pte_unmap_unlock(pte, ptl);
 	goto again;
 }
+
+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+static void kernel_pgtable_work_func(struct work_struct *work);
+
+static struct {
+	struct list_head list;
+	/* protect above ptdesc lists */
+	spinlock_t lock;
+	struct work_struct work;
+} kernel_pgtable_work = {
+	.list = LIST_HEAD_INIT(kernel_pgtable_work.list),
+	.lock = __SPIN_LOCK_UNLOCKED(kernel_pgtable_work.lock),
+	.work = __WORK_INITIALIZER(kernel_pgtable_work.work, kernel_pgtable_work_func),
+};
+
+static void kernel_pgtable_work_func(struct work_struct *work)
+{
+	struct ptdesc *pt, *next;
+	LIST_HEAD(page_list);
+
+	spin_lock(&kernel_pgtable_work.lock);
+	list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+	list_for_each_entry_safe(pt, next, &page_list, pt_list) {
+		list_del(&pt->pt_list);
+		__pagetable_free(pt);
+	}
+}
+
+void pagetable_free_async(struct ptdesc *pt)
+{
+	spin_lock(&kernel_pgtable_work.lock);
+	list_add(&pt->pt_list, &kernel_pgtable_work.list);
+	spin_unlock(&kernel_pgtable_work.lock);
+
+	schedule_work(&kernel_pgtable_work.work);
+}
+#endif
-- 
2.43.0

