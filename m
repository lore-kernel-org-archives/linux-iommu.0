Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479D274B44
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121804; cv=none; b=Ywauc9Lde6xg2HeK1gTw+xqZ0zir6lWiOISG/JjxlzeZ6AhYJxQxxcyXVoNoOoOAQWuXIfqyOGuqtuV6txN7gEZfauC0hEdWmZdu2d9K5hxNO2oCbXVL+0LtXF0WOlcNATufZcaIl63CW8oMIKa9pE60wXxdKZMbqIOrNIw/2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121804; c=relaxed/simple;
	bh=MfPys1H3mTkc2x7BxXNZ3i5yT93gXL3B3ELjd678Yt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEXz4LtKeMnqKYekMyE/dBmsdj5wynIzbM1cXzg+ZtS4rEc2epX1MYGDY7LU5G0pxHbEm65JAFmxTNrAze9QDLmPNuX8UE3o+ek4vOk28L1xJXQ8xkehM1BTgmf9U3YQRavz9hYPjIHHDFSwzBQ8sxr3SiRayF17XMjR2HonGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuA0KNGS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuA0KNGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761121802; x=1792657802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MfPys1H3mTkc2x7BxXNZ3i5yT93gXL3B3ELjd678Yt8=;
  b=FuA0KNGSL+Ge4z14XF6CFTvE9pyG/QjA+8EzBuqUUFI8MeA6ENWQCLiX
   znNEQeqVB8316nELXqwH744VtuCIzvr1OfoCz6uPoyjPL4esj2kkUx07C
   iXT0u52LzIgQzgfHotEXII/UBKjUQ48Wv+6DuA5RomgDLUtnI9nT9JJOG
   vLQz6iamBTwfD5AwG8su0uK0fDqlQxUgHOAWfcHkM44oJoMD3d/By5B+7
   a86VLQ1+xZXh5DNRLtCzK7pk3L2qFZKrAqWvpg32xEZ0xfeCrFltsg10I
   j3KPtIraHv2V0fYet5A3WpwW5IAmcLPFcL4bBbp9esii6jJLuGocZf492
   Q==;
X-CSE-ConnectionGUID: A9d3/OVQQlmzHrFAR6vN+A==
X-CSE-MsgGUID: 2qHke5PvR4KIs1ZVj8IUuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63185016"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63185016"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:30:01 -0700
X-CSE-ConnectionGUID: lunhTNnjRASOL1ioYgr5fQ==
X-CSE-MsgGUID: 3cO1hRCkTtuGzHJHtyXxUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183516435"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 22 Oct 2025 01:29:54 -0700
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
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 7/8] mm: Introduce deferred freeing for kernel page tables
Date: Wed, 22 Oct 2025 16:26:33 +0800
Message-ID: <20251022082635.2462433-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
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

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 mm/Kconfig           |  3 +++
 include/linux/mm.h   | 16 +++++++++++++---
 mm/pgtable-generic.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 3 deletions(-)

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
index 52ae551d0eb4..d521abd33164 100644
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

