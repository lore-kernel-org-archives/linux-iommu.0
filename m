Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8CB2C2372
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447295; cv=none; b=mhcqJ+VPFbUQJpIwlEIj9rReoM0e6Xi2ef2dYK2SdZ+3mE+rsgavPqQ3VBBLGerynmk3b1zz6SsPRH5fUUXeZOA80/7nmRyz/i4yYZbk5OdMeCHtGN6gzOpGmZzUt0axrSnKSdj3wu/i1xHGMNmmY9lJ4nIvD47KjjSWJWy9OF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447295; c=relaxed/simple;
	bh=F4I8Kvtwn3jusskaFJsgVirsMtZJ1VpejkaxbIoXrsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrdvHy7i07rpdFOI6/Ipab9B3tuSfpwyL7IyWFcQwTCxcCgONoxwVkJXov5MEddhmTdkJghM6qcz0IrZPFXvOQ4zZ3HggKnwbbbELU8RF+pqbrt7zAjYo6RCvexMgq0XAKdWR6tz4UnbY/wEy5XUN5EAldr+syOslb8SwvkPlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3iKYpzs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3iKYpzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760447294; x=1791983294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F4I8Kvtwn3jusskaFJsgVirsMtZJ1VpejkaxbIoXrsI=;
  b=c3iKYpzsurDhqR+MNcDxeR3YwywD69nhK5FAb8uXZOLSkoSU0bP0+u+6
   ela9jE2rO7vw8JZtUKjdIav6xbLcagP1dQZpTO7JVup7HA9b5k+hGt7WM
   GJg+mbsXBL3LzH7rBloBTuHqGodJJYaw4pxdBKcqjU9co3z/KFE7gqoDl
   2va85mEjvyrJ7FEelOUGr7h1+w6YXdLgySVETUYZO5v4uIPg41YEnt5lX
   gW+C3hCtUR9IYBX837QbcmLJmEXHkfXs22Of53cmn7U/yLK6I3IfU/WCV
   SEMA+uWZfeMgB6URFrZiIUWGoAhhktdzQ+zd/0cHidFD7m5sKnyS8A2ue
   A==;
X-CSE-ConnectionGUID: DYBPUmicTi+N0sC5vzSpSw==
X-CSE-MsgGUID: ggLBTvRLS/27xsaPPQ62rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62515469"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62515469"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:08:14 -0700
X-CSE-ConnectionGUID: tSK9WVeGSxqGkNXKwf99Kg==
X-CSE-MsgGUID: OTzctZkDTmCiQhcd/KV4OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182675699"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2025 06:08:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 6/7] mm: Introduce deferred freeing for kernel page tables
Date: Tue, 14 Oct 2025 21:04:36 +0800
Message-ID: <20251014130437.1090448-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

This introduces a conditional asynchronous mechanism, enabled by
CONFIG_ASYNC_KERNEL_PGTABLE_FREE. When enabled, this mechanism defers the
freeing of pages that are used as page tables for kernel address mappings.
These pages are now queued to a work struct instead of being freed
immediately.

This deferred freeing allows for batch-freeing of page tables, providing
a safe context for performing a single expensive operation (TLB flush)
for a batch of kernel page tables instead of performing that expensive
operation for each page table.

On x86, CONFIG_ASYNC_KERNEL_PGTABLE_FREE is selected if CONFIG_IOMMU_SVA
is enabled, because both Intel and AMD IOMMU architectures could
potentially cache kernel page table entries in their paging structure
cache, regardless of the permission.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 arch/x86/Kconfig     |  1 +
 mm/Kconfig           |  3 +++
 include/linux/mm.h   | 16 +++++++++++++---
 mm/pgtable-generic.c | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..ded29ee848fd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -279,6 +279,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select ASYNC_KERNEL_PGTABLE_FREE 	if IOMMU_SVA
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/mm/Kconfig b/mm/Kconfig
index 0e26f4fc8717..a83df9934acd 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -908,6 +908,9 @@ config PAGE_MAPCOUNT
 config PGTABLE_HAS_HUGE_LEAVES
 	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
 
+config ASYNC_KERNEL_PGTABLE_FREE
+	def_bool n
+
 # TODO: Allow to be enabled without THP
 config ARCH_SUPPORTS_HUGE_PFNMAP
 	def_bool n
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bb235a9f991e..fe5515725c46 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3031,6 +3031,14 @@ static inline void __pagetable_free(struct ptdesc *pt)
 	__free_pages(page, compound_order(page));
 }
 
+#ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
+void pagetable_free_kernel(struct ptdesc *pt);
+#else
+static inline void pagetable_free_kernel(struct ptdesc *pt)
+{
+	__pagetable_free(pt);
+}
+#endif
 /**
  * pagetable_free - Free pagetables
  * @pt:	The page table descriptor
@@ -3040,10 +3048,12 @@ static inline void __pagetable_free(struct ptdesc *pt)
  */
 static inline void pagetable_free(struct ptdesc *pt)
 {
-	if (ptdesc_test_kernel(pt))
+	if (ptdesc_test_kernel(pt)) {
 		ptdesc_clear_kernel(pt);
-
-	__pagetable_free(pt);
+		pagetable_free_kernel(pt);
+	} else {
+		__pagetable_free(pt);
+	}
 }
 
 #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 567e2d084071..1c7caa8ef164 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -406,3 +406,40 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	pte_unmap_unlock(pte, ptl);
 	goto again;
 }
+
+#ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
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
+	list_for_each_entry_safe(pt, next, &page_list, pt_list)
+		__pagetable_free(pt);
+}
+
+void pagetable_free_kernel(struct ptdesc *pt)
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

