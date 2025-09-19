Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BFC1F462C
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260555; cv=none; b=GHtJ8WhVHGSBHLN005doyVe3M2Ue/3K39CHitk/zB2nyEkscXRt+OS4rvE+OSBPnvSPCl7LccMDIgzIrgoOqGD5mMG7735AbyK2r1fqZ0cCrVNqGfREJb0Epho35eTMGQpMTJKD2mkQ8FI1TSaVOl9mkNMadYZ+eiEQWXzr9U84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260555; c=relaxed/simple;
	bh=xhVIzRvUhQ0G0bJbkpH6EEZgthb9WbtJ6bDS0JSPgGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fix7s7c9+qh3tndoDiKic67nCxIqeSUk9FUwIpnHfR5ikS8C923IFwj8QGLEnNH98GP/wEHKSlFtRm7HwTbNGPhcEpJQOA9R+WuGx5hlVsCMQObKJ9ZZp9LVLyUQZq2emX0XBMNi0gB5qYfALht7hLD/Pobmg1SnGr2OKcNT3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cERfEOpv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cERfEOpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758260554; x=1789796554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xhVIzRvUhQ0G0bJbkpH6EEZgthb9WbtJ6bDS0JSPgGg=;
  b=cERfEOpvxSGaPuJhsxxwiDfXQH/JQj3nToMMIzYYtimvMq5wgAl8KGnj
   QrSvF8zz8mGSzQFUZuxqtJ7+tDqgfkS8IoBSru1J8SHUTEzA98qJb8V1j
   XtMkgCI52HxJa7eRQsvxJIWdF+XyxMJeX5BoQqEhjuRYg5UxPlZs3Lakx
   Yqd+JiTikssGMegzjnMJXCeSAnc+qGUJDPqZXFH/WxEG6yQH5u1s0x+EO
   C9RQliRto0xUWUYwWu91gvt4THzthQtu6wsCzOFKkW2e7oGZzuHwaUCzq
   LmLdzOgWFxpwfZzHH1K86LGv/zLj/i4lcIujREfrHwK0ksLCfPks4HIr6
   A==;
X-CSE-ConnectionGUID: jUr1YNw6Rba9BTXdRpzoYA==
X-CSE-MsgGUID: rYyO8gszTpK/RCZ066VwOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63235706"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="63235706"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:42:33 -0700
X-CSE-ConnectionGUID: jWFFrS3tQ8i6m5NRhfM0kA==
X-CSE-MsgGUID: rUxpoxp/QxqqP1VMEDw7PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="180858539"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 22:42:27 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 0/8] Fix stale IOTLB entries for kernel address space
Date: Fri, 19 Sep 2025 13:39:58 +0800
Message-ID: <20250919054007.472493-1-baolu.lu@linux.intel.com>
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
v5:
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
 drivers/iommu/iommu-sva.c     | 29 +++++++++++++++++++++-
 include/asm-generic/pgalloc.h | 18 ++++++++++++++
 include/linux/iommu.h         |  4 +++
 include/linux/mm.h            | 24 +++++++++++++++---
 include/linux/page-flags.h    | 46 +++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  3 +++
 mm/pgtable-generic.c          | 39 +++++++++++++++++++++++++++++
 11 files changed, 168 insertions(+), 12 deletions(-)

-- 
2.43.0

