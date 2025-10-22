Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0A309EF6
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121754; cv=none; b=rIwkYDp+r7Sm2NAFpXNZtESxbBvruXM5L2dRXHxENUSN5bVA93rLyYhtyDSmj6m0Wmf6IpdvxbTM+TwLswEMKxxdT7Z9bcMThMYlhes6HhFCphQsRayrswKWtoIcj9tSa60c5tm4K7WeUZHLr1IuICjn9bQpWgs9jVTcfHnZxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121754; c=relaxed/simple;
	bh=DQWIuIaP4G7L2QkOxVyAjoDdXex0u4FBjhfXyNZJ/DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDgAYuYQzaIu4LW6Yrwi0ngOs7wR2ZexOXNFkAPYVBSR4l549Dqi+8hXTFu41b04JKdiWcUaZh7ZKJLrMmm0cW7mbZLDd5akm47EnK7wzOQRCUEiIlPbYvH4frM+qzkwD8IqeTmQPfgYWkYDd3R5egmNV5seO4XfoyjxIQaxbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuXHoBBI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuXHoBBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761121751; x=1792657751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DQWIuIaP4G7L2QkOxVyAjoDdXex0u4FBjhfXyNZJ/DA=;
  b=BuXHoBBI667kQS9+XFB05k1LKWTYaLIY0aS4xFQJ6psmcZo2c46eVONc
   Joyc8c69HCovgiOdSbtudOuxRXthI+Iec6b7L55UI//57X//JYNd3xHD8
   yI2tcnBIjoyISrvZx4N1WfI3E3P7NUU/a+54U31tv+4Q9UNie53DEX07e
   EMA7sLLOOVXSsTqDy8L/uG7k1Tvn/TykMa2aUpRj9xXxMctCMJMUGBNN+
   OHMKaxwrQZglv/rEEw5EpXaCB7h6kWuz41F5ZgakLv+m83oOn1oznVsJ0
   NdsMmz7lt+Oo9hC/dEvCyPo6QBwywKZmYgSN7ZoHJrPARShTWRhTD7joY
   g==;
X-CSE-ConnectionGUID: 1SFSbdLzQb63+NuD3kmtSw==
X-CSE-MsgGUID: NkFcK0hUSAapUj89+kHMCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74700840"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="74700840"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:29:10 -0700
X-CSE-ConnectionGUID: 40GuBpibRF6wTTdn6B50PQ==
X-CSE-MsgGUID: zG1sKX4NTcOFJ+1kV6INVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183516208"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 22 Oct 2025 01:29:04 -0700
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
Subject: [PATCH v7 0/8] Fix stale IOTLB entries for kernel address space
Date: Wed, 22 Oct 2025 16:26:26 +0800
Message-ID: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This proposes a fix for a security vulnerability related to IOMMU Shared
Virtual Addressing (SVA). In an SVA context, an IOMMU can cache kernel
page table entries. When a kernel page table page is freed and
reallocated for another purpose, the IOMMU might still hold stale,
incorrect entries. This can be exploited to cause a use-after-free or
write-after-free condition, potentially leading to privilege escalation
or data corruption.

This solution introduces a deferred freeing mechanism for kernel page
table pages, which provides a safe window to notify the IOMMU to
invalidate its caches before the page is reused.

Change log:
v7:
 - The use of pmd_ptdesc() introduced a bug reported at
   https://lore.kernel.org/linux-iommu/68eeb99e.050a0220.91a22.0220.GAE@google.com/.
   Fix this by replacing it with page_ptdesc().
 - Discussed the approach of backporting and reached a consensus that we
   need an extra patch to disable SVA for x86 arch and re-enable it after
   the kernel page table free callback is done.
 - Use "const struct ptdesc *ptdesc" as the parameter for
   ptdesc_test_kernel().
 - Move "select ASYNC_KERNEL_PGTABLE_FREE" to the last patch.

v6:
 - https://lore.kernel.org/linux-iommu/20251014130437.1090448-1-baolu.lu@linux.intel.com/
 - Follow commit 522abd92279a to set/clear/test a flag of struct
   ptdesc.
 - User pmd_ptdesc() helper.
 - Squash previous PATCH 6 and 7.
 - Rename CONFIG_ASYNC_PGTABLE_FREE to CONFIG_ASYNC_KERNEL_PGTABLE_FREE.
 - Refine commit message.
 - Rebase on top of v6.18-rc1.

v5:
 - https://lore.kernel.org/linux-iommu/20250919054007.472493-1-baolu.lu@linux.intel.com/
 - Renamed pagetable_free_async() to pagetable_free_kernel() to avoid
   confusion.
 - Removed list_del() when the list is on the stack, as it will be freed
   when the function returns.
 - Discussed a corner case related to memory unplug of memory that was
   present as reserved memory at boot. Given that it's extremely rare
   and cannot be triggered by unprivileged users. We decided to focus
   our efforts on the common vfree() case and noted that corner case in
   the commit message.
 - Some cleanups.

v4:
 - https://lore.kernel.org/linux-iommu/20250905055103.3821518-1-baolu.lu@linux.intel.com/
 - Introduce a mechanism to defer the freeing of page-table pages for
   KVA mappings. Call iommu_sva_invalidate_kva_range() in the deferred
   work thread before freeing the pages.

v3:
 - https://lore.kernel.org/linux-iommu/20250806052505.3113108-1-baolu.lu@linux.intel.com/
 - iommu_sva_mms is an unbound list; iterating it in an atomic context
   could introduce significant latency issues. Schedule it in a kernel
   thread and replace the spinlock with a mutex.
 - Replace the static key with a normal bool; it can be brought back if
   data shows the benefit.
 - Invalidate KVA range in the flush_tlb_all() paths.
 - All previous reviewed-bys are preserved. Please let me know if there
   are any objections.

v2:
 - https://lore.kernel.org/linux-iommu/20250709062800.651521-1-baolu.lu@linux.intel.com/
 - Remove EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
 - Replace the mutex with a spinlock to make the interface usable in the
   critical regions.

v1: https://lore.kernel.org/linux-iommu/20250704133056.4023816-1-baolu.lu@linux.intel.com/

Dave Hansen (5):
  mm: Add a ptdesc flag to mark kernel page tables
  mm: Actually mark kernel page table pages
  x86/mm: Use 'ptdesc' when freeing PMD pages
  mm: Introduce pure page table freeing function
  mm: Introduce deferred freeing for kernel page tables

Lu Baolu (3):
  iommu: Disable SVA when CONFIG_X86 is set
  x86/mm: Use pagetable_free()
  iommu/sva: Invalidate stale IOTLB entries for kernel address space

 arch/x86/Kconfig              |  1 +
 mm/Kconfig                    |  3 ++
 include/asm-generic/pgalloc.h | 18 ++++++++++
 include/linux/iommu.h         |  4 +++
 include/linux/mm.h            | 65 +++++++++++++++++++++++++++++++++--
 arch/x86/mm/init_64.c         |  2 +-
 arch/x86/mm/pat/set_memory.c  |  2 +-
 arch/x86/mm/pgtable.c         | 12 +++----
 drivers/iommu/iommu-sva.c     | 29 +++++++++++++++-
 mm/pgtable-generic.c          | 39 +++++++++++++++++++++
 10 files changed, 163 insertions(+), 12 deletions(-)

-- 
2.43.0

