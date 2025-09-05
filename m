Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DBF224234
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 05:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051596; cv=none; b=lIWJCkxcypI6b9Igg1Ix57CHz7jhN5jPb/ZJ82J/4YIevDVQtzmlIw9MgWkeRL3N59wcwW3H7tS0GStBeq/5XwvoupTsgOvK2NBNOXCLNd2QUykGaDCSRS6NhRWjnvSIlH36Oz7N9dnIOOFBDnzOzDHbG0dRZAlBV+7Z8dYzDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051596; c=relaxed/simple;
	bh=9X/VX16NUlQeewe3ualj/gGyuhaQHxuHokasCga+Tys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvU0pwWAJv38OxxwKgCmKQaI26lnoCVSDHuEcuYMxjkO0xIqnwndPryd8E0Zm4hX+lCA6aG1ok3fOyKMC7nmBlyNVpvIcF5gcnR/ph8UFpg/E1stJZ4VBAWBvRGP5FGc3IoDV8SYsgm7dA6LfukavzPBm5N2I7Pr9UFWSld0QAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CR14ebOC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CR14ebOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757051595; x=1788587595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9X/VX16NUlQeewe3ualj/gGyuhaQHxuHokasCga+Tys=;
  b=CR14ebOCPj+BG0aXyTVlN6xRSCgczNYhFlz+62G5zcvBdlqdQJaj5dEF
   ywSYyNoP43UbE4OEjdO/AhPlj9uIybjK/mt/S+WsaHSsdYtnxvbdjJSz6
   bU3KVE4ulAfdFZlaFB6IIJhb0rne1alcG6Kar0aZunbY+qk3cRkS4QSse
   lXwD7zC5zFwjYcxrQOd+QCzbWv6E1p+jvSH+U4XrfoLo4FXcaEd44ZS/9
   MKd9XPSceh1uasfrem3uHGtwIXu1+sfYYsqubWq0DSqaZtNNza6R5lXPj
   uR5TK8kJUFMmumlHyyJFpS6DN8miIpDq8ybSI7uE7GK/R3M0lU8lh4+35
   A==;
X-CSE-ConnectionGUID: Pxe6r3O5Rve8qK5xZZQaWQ==
X-CSE-MsgGUID: BX2qQMkFQ968shCMgvQStQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70015060"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70015060"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:53:14 -0700
X-CSE-ConnectionGUID: dIZP8Y3qSj20voM5FXjE9g==
X-CSE-MsgGUID: DeqDxicIQ7mXrTqE9YIMuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="209257663"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 22:53:09 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 0/8] Fix stale IOTLB entries for kernel address space
Date: Fri,  5 Sep 2025 13:50:55 +0800
Message-ID: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
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
v4:
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

Dave Hansen (6):
  mm: Add a ptdesc flag to mark kernel page tables
  mm: Actually mark kernel page table pages
  x86/mm: Use 'ptdesc' when freeing PMD pages
  mm: Introduce pure page table freeing function
  mm: Introduce deferred freeing for kernel page tables
  mm: Hook up Kconfig options for async page table freeing

Lu Baolu (2):
  x86/mm: Use pagetable_free()
  iommu/sva: Invalidate stale IOTLB entries for kernel address space

 arch/x86/Kconfig              |  1 +
 arch/x86/mm/init_64.c         |  2 +-
 arch/x86/mm/pat/set_memory.c  |  2 +-
 arch/x86/mm/pgtable.c         | 12 ++++-----
 drivers/iommu/iommu-sva.c     | 29 +++++++++++++++++++-
 include/asm-generic/pgalloc.h | 18 +++++++++++++
 include/linux/iommu.h         |  4 +++
 include/linux/mm.h            | 24 ++++++++++++++---
 include/linux/page-flags.h    | 51 +++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  3 +++
 mm/pgtable-generic.c          | 41 ++++++++++++++++++++++++++++
 11 files changed, 175 insertions(+), 12 deletions(-)

-- 
2.43.0

