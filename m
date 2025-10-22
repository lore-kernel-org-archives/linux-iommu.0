Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D430EF7C
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121811; cv=none; b=bvsnWRFR209eQBdV3qbtkWriMhYEtG2A3DVveEwDjbntS834bwG43NK5j262MOKa27A5e2NSMs+GnMIydbE2QCiLRzvjAuFGt7aO0vsqk0JF9FPwjGgYoFTWtr2qGYjBKSmDbknSDL7u8Spx8lIJHld7PtsA0zDt3UOM16F/hDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121811; c=relaxed/simple;
	bh=pYxXXEg2O9fWt+fbB3M4N2RdzAEstcUlrOLKKj3r6lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHtP6I+Gl/aCiIBRRcdQixHFIRfCbALPmibjic0iAvketqK9xayqhIviv2DCB30jRGAc0yyYSwJVpBoaHT1sJZWbWfYijAV+/nXSsH2ZJoXDcAWWq/zj0+fVKK68+TD46EsOCjkP03N1fDe2pIiCN/cc41wSHktKgFrWF+2pljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5iU8Z9k; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5iU8Z9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761121809; x=1792657809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pYxXXEg2O9fWt+fbB3M4N2RdzAEstcUlrOLKKj3r6lg=;
  b=B5iU8Z9kZvabwerNcmJ+KvNURGQfVJ0rAO8caNJD3Bd00bjmGUsHr0yt
   Yoin7ZLC7lzaNbJjeEkmMpHk9GfF5quUvd5uGGfbcfflfMEko5vrjkqqZ
   eKJIx2/RMKhLTrEwA/30PoeLHVeK2w2xXOujzQRq+6sjppZC6lmFchjOG
   FSSFJOgTNqE/sG0nSCd45cYP5NQ5AZdW7cz4aPbiGBHD7xkAla4QYZOy8
   2zURRtk6SFr2G9PM7RGoi7AOgrvr+SjDAKc2UZLile18MjDxEFSciHfw7
   pa6ktblF7YEzbHEMuKan9tY9ZXfXuzaZlweKjMBKgcD2Ss4JQtID1exVP
   A==;
X-CSE-ConnectionGUID: oSxrVC/4SMq4rQOgESAsLQ==
X-CSE-MsgGUID: mKfruRlPRzmGPJR952zRPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85885841"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="85885841"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:30:07 -0700
X-CSE-ConnectionGUID: Vd5TeOLTRfWrRlzhiL3YXg==
X-CSE-MsgGUID: il39B/P2R6OCMqQBbfev/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183516494"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 22 Oct 2025 01:30:01 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 8/8] iommu/sva: Invalidate stale IOTLB entries for kernel address space
Date: Wed, 22 Oct 2025 16:26:34 +0800
Message-ID: <20251022082635.2462433-9-baolu.lu@linux.intel.com>
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

Introduce a new IOMMU interface to flush IOTLB paging cache entries for
the CPU kernel address space. This interface is invoked from the
x86 architecture code that manages combined user and kernel page tables,
specifically before any kernel page table page is freed and reused.

This addresses the main issue with vfree() which is a common occurrence
and can be triggered by unprivileged users. While this resolves the
primary problem, it doesn't address some extremely rare case related to
memory unplug of memory that was present as reserved memory at boot,
which cannot be triggered by unprivileged users. The discussion can be
found at the link below.

Enable SVA on x86 architecture since the IOMMU can now receive
notification to flush the paging cache before freeing the CPU kernel
page table pages.

Suggested-by: Jann Horn <jannh@google.com>
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/linux-iommu/04983c62-3b1d-40d4-93ae-34ca04b827e5@intel.com/
---
 arch/x86/Kconfig          |  1 +
 include/linux/iommu.h     |  4 ++++
 drivers/iommu/iommu-sva.c | 32 ++++++++++++++++++++++++++++----
 mm/pgtable-generic.c      |  2 ++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..a3700766a8c0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -279,6 +279,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select ASYNC_KERNEL_PGTABLE_FREE	if IOMMU_SVA
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473..66e4abb2df0d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1134,7 +1134,9 @@ struct iommu_sva {
 
 struct iommu_mm_data {
 	u32			pasid;
+	struct mm_struct	*mm;
 	struct list_head	sva_domains;
+	struct list_head	mm_list_elm;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode);
@@ -1615,6 +1617,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end);
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1639,6 +1642,7 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 }
 
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
+static inline void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end) {}
 #endif /* CONFIG_IOMMU_SVA */
 
 #ifdef CONFIG_IOMMU_IOPF
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index a0442faad952..d236aef80a8d 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,6 +10,8 @@
 #include "iommu-priv.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
+static bool iommu_sva_present;
+static LIST_HEAD(iommu_sva_mms);
 static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 						   struct mm_struct *mm);
 
@@ -42,6 +44,7 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 		return ERR_PTR(-ENOSPC);
 	}
 	iommu_mm->pasid = pasid;
+	iommu_mm->mm = mm;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
 	/*
 	 * Make sure the write to mm->iommu_mm is not reordered in front of
@@ -77,9 +80,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
-	if (IS_ENABLED(CONFIG_X86))
-		return ERR_PTR(-EOPNOTSUPP);
-
 	mutex_lock(&iommu_sva_lock);
 
 	/* Allocate mm->pasid if necessary. */
@@ -135,8 +135,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
-	list_add(&domain->next, &mm->iommu_mm->sva_domains);
 
+	if (list_empty(&iommu_mm->sva_domains)) {
+		if (list_empty(&iommu_sva_mms))
+			iommu_sva_present = true;
+		list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
+	}
+	list_add(&domain->next, &iommu_mm->sva_domains);
 out:
 	refcount_set(&handle->users, 1);
 	mutex_unlock(&iommu_sva_lock);
@@ -178,6 +183,13 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
+
+	if (list_empty(&iommu_mm->sva_domains)) {
+		list_del(&iommu_mm->mm_list_elm);
+		if (list_empty(&iommu_sva_mms))
+			iommu_sva_present = false;
+	}
+
 	mutex_unlock(&iommu_sva_lock);
 	kfree(handle);
 }
@@ -315,3 +327,15 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 
 	return domain;
 }
+
+void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
+{
+	struct iommu_mm_data *iommu_mm;
+
+	guard(mutex)(&iommu_sva_lock);
+	if (!iommu_sva_present)
+		return;
+
+	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
+		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
+}
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 1c7caa8ef164..8c22be79b734 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -13,6 +13,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/mm_inline.h>
+#include <linux/iommu.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
@@ -430,6 +431,7 @@ static void kernel_pgtable_work_func(struct work_struct *work)
 	list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
 	spin_unlock(&kernel_pgtable_work.lock);
 
+	iommu_sva_invalidate_kva_range(PAGE_OFFSET, TLB_FLUSH_ALL);
 	list_for_each_entry_safe(pt, next, &page_list, pt_list)
 		__pagetable_free(pt);
 }
-- 
2.43.0

