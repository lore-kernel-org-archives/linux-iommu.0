Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0192DEA9B
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372254; cv=none; b=CJvMY9fjpXMfnCg30UhhzwGl/2DzHUN/qw4W48rErH9shDxJ3U8E804Bmup0BFKUl+LON1DMcammHloS+BGAo85faTih68KLohTyD9R8ht+Ao3JVoJTjnX95+7UZ/n6aJro7v9mxouW0u+LKZ1+8V9Lxd198Js7wuOI4C/soEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372254; c=relaxed/simple;
	bh=TyoseHGmSTD5tP+xnWFmibp/t+Pc9emQUq7Fahgmb24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=U8PUfF5zop2luEKw+sgs9TIIpixJZgwM+riO2FtwkMZVd4A/yeCNiFnBp3O2VE6+ur9OWJk4j1fanb0lVQGgZMxHxmjsBOm/wdgGtxk1Vo9e70Zr+JrDourXrUFX5noLtFH+5zZRN0J3CqkL6sg3AlsTipo5mc4myBgdBdcsWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WspTQUFK; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WspTQUFK"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260416204409euoutp02780ae9f8afbca98ba0f389a08de293a5~m8SZB52th1299212992euoutp02F
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 20:44:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260416204409euoutp02780ae9f8afbca98ba0f389a08de293a5~m8SZB52th1299212992euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776372249;
	bh=VZJ6W06i5LDR2f3jir/iDTzQE38GCIMoEYbZYfGERD0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=WspTQUFKMn2tIj+I5lj/Eu01DmI3+IWAMKUGmBYVSswXMdIuALedxQJ8iTBIoAJHM
	 VWkVGj9chpiR/Fh7W9CCIb5FvnijW2MzKE/HyPHcE6h8TR7Zw3OI7DhMiyr6d9SJIA
	 D9MnqjcvwJzLuZmaSMatpJ8kHyMqD2Usv426uV/I=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260416204408eucas1p28659d11a64b12e1d26ee341afca0b897~m8SX7ubVk1247212472eucas1p22;
	Thu, 16 Apr 2026 20:44:08 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260416204407eusmtip23299ad1d429077d07eb489df8759a4fe~m8SXdD1Ni2294022940eusmtip2L;
	Thu, 16 Apr 2026 20:44:07 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Barry Song
	<baohua@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Rob Herring
	<robh@kernel.org>, Maxime Ripard <mripard@kernel.org>, Qinxin Xia
	<xiaqinxin@huawei.com>
Subject: [GIT PULL] dma-mapping updates for Linux 7.1
Date: Thu, 16 Apr 2026 22:43:59 +0200
Message-Id: <20260416204359.3030425-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260416204408eucas1p28659d11a64b12e1d26ee341afca0b897
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260416204408eucas1p28659d11a64b12e1d26ee341afca0b897
X-EPHeader: CA
X-CMS-RootMailID: 20260416204408eucas1p28659d11a64b12e1d26ee341afca0b897
References: <CGME20260416204408eucas1p28659d11a64b12e1d26ee341afca0b897@eucas1p2.samsung.com>

The following changes since commit 2cdaff22ed26f1e619aa2b43f27bb84f2c6ef8f8:

  dma-mapping: add missing `inline` for `dma_free_attrs` (2026-03-25 08:01:21 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.1-2026-04-16

for you to fetch changes up to 15818b2cd42df3cc886f4cc46acfab4d072dcacc:

  dma-buf: heaps: system: document system_cc_shared heap (2026-04-10 14:20:01 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 7.0:

- added support for batched cache sync, what improves performance of
  dma_map/unmap_sg() operations on ARM64 architecture (Barry Song)

- introduced DMA_ATTR_CC_SHARED attribute for explicitly shared memory
  used in confidential computing (Jiri Pirko)

- refactored spaghetti-like code in drivers/of/of_reserved_mem.c and its
  clients (Marek Szyprowski, shared branch with device-tree updates to
  avoid merge conflicts)

- prepared Contiguous Memory Allocator related code for making dma-buf
  drivers modularized (Maxime Ripard)

- added support for benchmarking dma_map_sg() calls to tools/dma utility
  (Qinxin Xia)

----------------------------------------------------------------
Barry Song (5):
      arm64: Provide dcache_by_myline_op_nosync helper
      arm64: Provide dcache_clean_poc_nosync helper
      arm64: Provide dcache_inval_poc_nosync helper
      dma-mapping: Separate DMA sync issuing and completion waiting
      dma-mapping: Support batch mode for dma_direct_{map,unmap}_sg

Jiri Pirko (3):
      dma-mapping: introduce DMA_ATTR_CC_SHARED for shared memory
      dma-buf: heaps: system: add system_cc_shared heap for explicitly shared memory
      dma-buf: heaps: system: document system_cc_shared heap

Kit Dallege (1):
      dma-mapping: fix false kernel-doc comment marker

Marek Szyprowski (10):
      Merge tag 'dma-mapping-7.0-2026-03-25' into dma-mapping-for-next
      of: reserved_mem: remove fdt node from the structure
      of: reserved_mem: use -ENODEV instead of -ENOENT
      of: reserved_mem: switch to ops based OF_DECLARE()
      of: reserved_mem: replace CMA quirks by generic methods
      of: reserved_mem: rearrange code a bit
      of: reserved_mem: clarify fdt_scan_reserved_mem*() functions
      of: reserved_mem: rework fdt_init_reserved_mem_node()
      Merge branch 'dt-reserved-mem-cleanups' into dma-mapping-for-next
      Merge branch 'dma-contig-for-7.1-modules-prep-v4' into dma-mapping-for-next

Maxime Ripard (5):
      dma: contiguous: Turn heap registration logic around
      dma: contiguous: Make dev_get_cma_area() a proper function
      dma: contiguous: Make dma_contiguous_default_area static
      dma: contiguous: Export dev_get_cma_area()
      mm: cma: Export cma_alloc(), cma_release() and cma_get_name()

Qinxin Xia (3):
      dma-mapping: benchmark: modify the framework to adapt to more map modes
      dma-mapping: benchmark: add support for dma_map_sg
      tools/dma: Add dma_map_sg support

 Documentation/userspace-api/dma-buf-heaps.rst |   7 +
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/assembler.h            |  25 +-
 arch/arm64/include/asm/cache.h                |   5 +
 arch/arm64/include/asm/cacheflush.h           |   2 +
 arch/arm64/kernel/relocate_kernel.S           |   3 +-
 arch/arm64/mm/cache.S                         |  57 ++++-
 arch/arm64/mm/dma-mapping.c                   |   4 +-
 drivers/dma-buf/heaps/cma_heap.c              |  19 +-
 drivers/dma-buf/heaps/system_heap.c           | 103 ++++++++-
 drivers/iommu/dma-iommu.c                     |  35 ++-
 drivers/memory/tegra/tegra210-emc-table.c     |  19 +-
 drivers/of/fdt.c                              |   2 +-
 drivers/of/of_private.h                       |   2 +-
 drivers/of/of_reserved_mem.c                  | 320 +++++++++++++++-----------
 drivers/xen/swiotlb-xen.c                     |  24 +-
 include/linux/cma.h                           |  10 -
 include/linux/dma-buf/heaps/cma.h             |  16 --
 include/linux/dma-map-ops.h                   |  23 +-
 include/linux/dma-mapping.h                   |  12 +-
 include/linux/of_reserved_mem.h               |  16 +-
 include/trace/events/dma.h                    |   3 +-
 include/uapi/linux/map_benchmark.h            |  13 +-
 kernel/dma/Kconfig                            |   3 +
 kernel/dma/coherent.c                         |  19 +-
 kernel/dma/contiguous.c                       | 144 +++++++++---
 kernel/dma/direct.c                           |  23 +-
 kernel/dma/direct.h                           |  35 ++-
 kernel/dma/map_benchmark.c                    | 246 ++++++++++++++++++--
 kernel/dma/mapping.c                          |  19 +-
 kernel/dma/swiotlb.c                          |  26 ++-
 mm/cma.c                                      |   3 +
 tools/dma/dma_map_benchmark.c                 |  23 +-
 33 files changed, 917 insertions(+), 345 deletions(-)
 delete mode 100644 include/linux/dma-buf/heaps/cma.h

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


