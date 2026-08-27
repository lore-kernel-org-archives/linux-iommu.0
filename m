Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6512E8DE3
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842756; cv=none; b=MHDe3BTv8JIde7S4Ql/f6W339uiWYiXc53EhINvEo8jMXRYfxu5XeC++6mVGN6mlX7K8dudu3sFNK88ei9grCIE469GrECP8d+A2TEG1jPPwe3XBPZZwM2Ztc2lxztxWOOMJ8uJg2kxJkG2bb1AMNTLWWL38MqfJOelEHj6FbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842756; c=relaxed/simple;
	bh=dWc2LBW7tnbzd8aYpAR6curDlQuV3nqCzpnmJ7AjROQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0Ol1R0LvyXLLOYzMD8wPCIrvENLvxE4N6BZpNcGpwJ3bLkOM5O7JWuxHTZS5uWG5ZedU7Eog6b3fPPMufkhYR96oT4g6woU+C5FH4bT8t6jtdUkd9eVf/I/HE4ai0lxE7SY1BWBcVHNtf9bPYAJh38578ZrnnoluF6nOC/8tME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lBorrZyG; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lBorrZyG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787842750; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aP3yTfYoCLgwuuWPChjMO7/4qA/BZGkazKY2jAbx8uY=;
	b=lBorrZyGMiCoykuwpMj1YkpLAc9ErhA27VDZbs74cVbkA64siDfbSNEnVXytQhC+BgtmrpU6x0oOr/UJUs+BoRBcLlqf1T+9WEcogtmKQ7IesTLdwCWtIBEGn9G8tbPFu3bOusOeE3gEPC3JorcO25IJp9dqreMMmupe3WA8csE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X9jzaBc_1787842739;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9jzaBc_1787842739 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Aug 2026 22:59:10 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: joro@8bytes.org,
	will@kernel.org,
	jgg@ziepe.ca
Cc: robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	smostafa@google.com,
	praan@google.com,
	skhawaja@google.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH 0/2] iommu: Drop IOMMU_DEBUG_PAGEALLOC refs on iommupt domain teardown
Date: Thu, 27 Aug 2026 22:58:53 +0800
Message-ID: <20260827145855.1616223-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit b948a8722848 ("iommu: Fix up map/unmap debugging for
iommupt domains") iommu_map() takes an IOMMU_DEBUG_PAGEALLOC reference
for every page it maps into a domain, and the only path that drops
those references is the IOVA based unmap.  When a generic_pt domain is
freed while mappings are still installed, pt_iommu_deinit() releases
the page table memory without going through that path, so every mapped
page keeps its reference forever and each later allocation or free of
it trips:

    WARNING: drivers/iommu/iommu-debug-pagealloc.c:91 at __iommu_debug_check_unmapped+0x4e/0x70, CPU#0: init/1
    iommu: Detected page leak!

Freeing a domain with mappings still installed is not driver misuse:
the deinit contract in include/linux/generic_pt/iommu.h only requires
the table to be removed from HW access and caches, with no requirement
to unmap first.  iommu_setup_default_domain() frees the old domain with
its IOMMU_RESV_DIRECT mappings still installed (those pages normally
never return to the page allocator, so it does not WARN today), and the
generic_pt kunit suite (CONFIG_IOMMU_PT_KUNIT_TEST) does the same in
pt_kunit_iommu_exit().

Patch 1 adds __iommu_debug_unmap_phys(), the physical address based
counterpart of __iommu_debug_map().  Patch 2 wires it into the deinit
walk: a debug_unmap flag makes __collect_tables() drop the reference of
every OA leaf it destroys, symmetric to how iommu_map() created them.

io-pgtable has the same gap in __arm_lpae_free_pgtable(), but its
cookies cannot reach the struct iommu_domain, so that fix needs an ABI
change or per-driver handling and is left as a follow-up.

The kunit suite doubles as an in-tree reproducer: with
CONFIG_IOMMU_DEBUG_PAGEALLOC=y and CONFIG_IOMMU_PT_KUNIT_TEST=y, boot
with iommu.debug_pagealloc=1
kunit.filter_glob=x86_64_iommu_test.test_pgsize_boundary, then
allocate and free most of memory (the case maps 128K at the hard-coded
OA 0x208b95d000 and never unmaps it, so the machine needs enough RAM
for that address to be online memory - a 150G guest was used here, and
the sweep was a tmpfs filled to 95% of RAM):

    unpatched:          64 page leak WARNINGs
    with this series:   0

The 64 is one WARNING for each of the 32 mapped pages on both its
allocation and free.  On unpatched mainline the suite already fails
test_random_map's NR_SECONDARY_PAGETABLE assertion, which aborts its
cleanup and cascades into the following cases, hence the isolation.  An
out-of-tree module mapping a page into an amdv1 domain and freeing the
domain without unmapping shows the same behaviour, 384 WARNINGs over
64 iterations unpatched and none with the series; each leaked page is
reported again on every later allocation and free, so the count
exceeds the 64 leaked pages.  The control case that unmaps first stays
silent.

The generic_pt format code can be built as a module (e.g.
CONFIG_IOMMU_PT_AMDV1=m), so the new helper and the
iommu_debug_initialized static key are exported GPL.

Yuanhe Shu (2):
  iommu: Add __iommu_debug_unmap_phys() to drop refs by physical address
  iommupt: Drop pagealloc references during domain deinit

 drivers/iommu/generic_pt/iommu_pt.h   | 22 +++++++++++++++++---
 drivers/iommu/iommu-debug-pagealloc.c | 30 ++++++++++++++++++++++++---
 drivers/iommu/iommu-priv.h            | 24 +++++++++++++++++++++
 3 files changed, 70 insertions(+), 6 deletions(-)

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.43.5
