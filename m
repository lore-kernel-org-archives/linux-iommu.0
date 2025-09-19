Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF80269CE6
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260589; cv=none; b=Noe6vULB/72C1fGxHalhn372DMSPgR4XLnXbP4T4tDR4PPg2KyU0B026AdC0VEIn6J29dPjEFmOLoOaC4KLopZfgE9HQI4VRtaMHzsKrCOsp4/ylahU0YfXXvGZqwQxP8grbqofkYRNp0W+tmBjk6Gt434y/plBNNVk9rC9GXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260589; c=relaxed/simple;
	bh=XUszhuNZ389vB8JW9mMK3FCAh5uDSfA8sbiYQetS8U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtcXuz6fay1KvvmcGZR5TVE6TRmVTPOh3anEfAuqyHnD3cyV+79in/7JjIbaRm0DFezrwWMWdmBZS1vNer887mBPC2kyxS/XTxnYz8rjIDMlU7RyMcpMGQ9oj2Vyuss5eSNL9hxxfN6KJwkwaWF5K2LBsW4rAzLZiKQov/wxuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEIF1OsF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEIF1OsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758260588; x=1789796588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XUszhuNZ389vB8JW9mMK3FCAh5uDSfA8sbiYQetS8U0=;
  b=ZEIF1OsFtQdFiuX9PDBXFdWVpOKW31yi8UaqowLiPrXuuRk0O2EnKwSN
   BXw8Rd/oMAk4D0Q6ak8n6ssnUK7m7YQ9cTi46jDXM6UDtXJDzRLDFR2e/
   xSxFq43Ai5Lt1d0+WsnGzu3x7vPwD+y3SGrTynn9XnJ1QOrunl3kR2tVj
   xm6GoXlwkA4b11dkIJIFmsKnnalmZGa8QZAbmDDPyC60kZguNkV4xT4M6
   a7hUQpf30eySkW0RPRm43II+pdwqK/jSrOJbFs/8jEA18RzQkWThp3rJz
   4AbpOMt+gfTnwHAB2iHu9tK/2PohjpZX4Sb/xkJVQcEp3aYYHGXm1w0jL
   g==;
X-CSE-ConnectionGUID: 1Zjg9h4ERGiYtOILiNgVsw==
X-CSE-MsgGUID: Njnuk1ViRue2g102UhQwsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63235835"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="63235835"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:43:08 -0700
X-CSE-ConnectionGUID: bQxzzAHVRQKGYHmNzIp8gA==
X-CSE-MsgGUID: DXTduhSRRmiv7fQx7EjT8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="180858756"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 22:43:01 -0700
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
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 6/8] mm: Introduce deferred freeing for kernel page tables
Date: Fri, 19 Sep 2025 13:40:04 +0800
Message-ID: <20250919054007.472493-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919054007.472493-1-baolu.lu@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

This introduces a conditional asynchronous mechanism, enabled by
CONFIG_ASYNC_PGTABLE_FREE. When enabled, this mechanism defers the freeing
of pages that are used as page tables for kernel address mappings. These
pages are now queued to a work struct instead of being freed immediately.

This deferred freeing provides a safe context for a future patch to add
an IOMMU-specific callback, which might be expensive on large-scale
systems. This ensures the necessary IOMMU cache invalidation is performed
before the page is finally returned to the page allocator outside of any
critical, non-sleepable path.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/mm.h   | 16 +++++++++++++---
 mm/pgtable-generic.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 668d519edc0f..2d7b4af40442 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2891,6 +2891,14 @@ static inline void __pagetable_free(struct ptdesc *pt)
 	__free_pages(page, compound_order(page));
 }
 
+#ifdef CONFIG_ASYNC_PGTABLE_FREE
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
@@ -2900,10 +2908,12 @@ static inline void __pagetable_free(struct ptdesc *pt)
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
index 567e2d084071..0279399d4910 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -406,3 +406,40 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
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

