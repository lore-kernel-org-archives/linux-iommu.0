Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF223C4F3
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226965; cv=none; b=o6TECw+D/VFt9STL11ba0dXud7mlYPedcUmxI4DXFnnIEDaL03xnSi9i1RT5lUtE4eVNsYy3AazjCBTozZNngobHOvwbqUxfNvfcKtnfON6q8mOpITJN6BMZWU7lY8VRU2DKfZy/iNe5P0AKz82XyvHruCwtLGeVBrra41S6iuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226965; c=relaxed/simple;
	bh=zx5KnZTpjWTHZDFPoEJU8NR+tRSkUEh1sgMf7q6lPd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=QNser7Cwh5Za5bCsucxRUwHshh8op8GVpRjBguypkOMlxOWGF4wgEroaLsgVJSp5kut0TL+yUWHmG5lIiHFzgdzbNRPrdHW1iNcshRO1p4b2weWulmHqiiokkt9e/EkU/KxUjBxPUmLXEt/YtqLz9f+ccRgaC2OoltJJYw2eg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vJ/rAULf; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vJ/rAULf"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250930100920euoutp02021d8c27153ba039b3e8977e841b936d~qB5mS_eaR2511625116euoutp02O
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 10:09:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250930100920euoutp02021d8c27153ba039b3e8977e841b936d~qB5mS_eaR2511625116euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759226960;
	bh=30mDfsKQ8iwvNVTRnzUy7p+ibLwenFZY6QI63dERqJA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=vJ/rAULfEh6ZbRvTKHSr8YZGNSbDsSVz8NigWKAxQHMeZrLj//DW6JBrofK2Hoy6R
	 w9D13TEKy5zvf1dvtA1auDFM/k5s3rEB068KDHrSGMN+Iv8vDLhDpeDsnXfm6JxjoQ
	 aHOWZKdHpowf3m6j0LQ3R6H5FCNn2DnJyVlxuPHg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250930100920eucas1p138d1f0aef1a43aea9f9d22073469847e~qB5l10E1z0082200822eucas1p1M;
	Tue, 30 Sep 2025 10:09:20 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250930100919eusmtip238742188fa87394ddec88319c933f202~qB5lWiOqw2531125311eusmtip2A;
	Tue, 30 Sep 2025 10:09:19 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Qianfeng Rong <rongqianfeng@vivo.com>, Petr Tesarik
	<ptesarik@suse.com>
Subject: [GIT PULL] dma-mapping updates for Linux 6.18
Date: Tue, 30 Sep 2025 12:08:18 +0200
Message-Id: <20250930100818.350934-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250930100920eucas1p138d1f0aef1a43aea9f9d22073469847e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250930100920eucas1p138d1f0aef1a43aea9f9d22073469847e
X-EPHeader: CA
X-CMS-RootMailID: 20250930100920eucas1p138d1f0aef1a43aea9f9d22073469847e
References: <CGME20250930100920eucas1p138d1f0aef1a43aea9f9d22073469847e@eucas1p1.samsung.com>

The following changes since commit 7e2368a21741e2db542330b32aa6fdd8908e7cff:

  dma-debug: don't enforce dma mapping check on noncoherent allocations (2025-09-02 10:18:16 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-09-30

for you to fetch changes up to ef3d979b3e270b6a41b6f306bfc442253c41a4cd:

  kmsan: fix missed kmsan_handle_dma() signature conversion (2025-09-17 14:42:36 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 6.18:

- refactoring of DMA mapping API to physical addresses as the primary
interface instead of page+offset parameters; this gets much closer to
Matthew Wilcox's long term wish for struct-pageless IO to cacheable DRAM and is
supporting memdesc project which seeks to substantially transform how
struct page works; an advantage of this approach is the possibility of
introducing DMA_ATTR_MMIO, which covers existing 'dma_map_resource' flow
in the common paths, what in turn lets to use recently introduced
dma_iova_link() API to map PCI P2P MMIO without creating struct page;
developped by Leon Romanovsky and Jason Gunthorpe
- minor clean-up by Petr Tesarik and Qianfeng Rong

----------------------------------------------------------------
Leon Romanovsky (14):
      dma-mapping: introduce new DMA attribute to indicate MMIO memory
      iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().
      dma-debug: refactor to use physical addresses for page mapping
      dma-mapping: rename trace_dma_*map_page to trace_dma_*map_phys
      iommu/dma: rename iommu_dma_*map_page to iommu_dma_*map_phys
      iommu/dma: implement DMA_ATTR_MMIO for iommu_dma_(un)map_phys()
      dma-mapping: convert dma_direct_*map_page to be phys_addr_t based
      kmsan: convert kmsan_handle_dma to use physical addresses
      dma-mapping: implement DMA_ATTR_MMIO for dma_(un)map_page_attrs()
      xen: swiotlb: Open code map_resource callback
      dma-mapping: export new dma_*map_phys() interface
      mm/hmm: migrate to physical address-based DMA mapping API
      mm/hmm: properly take MMIO path
      kmsan: fix missed kmsan_handle_dma() signature conversion

Marek Szyprowski (1):
      Merge tag 'dma-mapping-6.17-2025-09-09' into HEAD

Petr Tesarik (1):
      dma-direct: clean up the logic in __dma_direct_alloc_pages()

Qianfeng Rong (1):
      swiotlb: Remove redundant __GFP_NOWARN

 Documentation/core-api/dma-api.rst        |   4 +-
 Documentation/core-api/dma-attributes.rst |  18 +++++
 arch/powerpc/kernel/dma-iommu.c           |   4 +-
 drivers/iommu/dma-iommu.c                 |  61 ++++++++--------
 drivers/virtio/virtio_ring.c              |   4 +-
 drivers/xen/swiotlb-xen.c                 |  21 +++++-
 include/linux/dma-direct.h                |   2 -
 include/linux/dma-map-ops.h               |   8 +--
 include/linux/dma-mapping.h               |  33 +++++++++
 include/linux/iommu-dma.h                 |  11 +--
 include/linux/kmsan.h                     |   9 ++-
 include/linux/page-flags.h                |   1 +
 include/trace/events/dma.h                |   9 ++-
 kernel/dma/debug.c                        |  82 ++++++----------------
 kernel/dma/debug.h                        |  37 ++--------
 kernel/dma/direct.c                       |  53 +++++---------
 kernel/dma/direct.h                       |  57 +++++++++------
 kernel/dma/mapping.c                      | 112 ++++++++++++++++++------------
 kernel/dma/ops_helpers.c                  |   6 +-
 kernel/dma/swiotlb.c                      |   2 +-
 mm/hmm.c                                  |  19 ++---
 mm/kmsan/hooks.c                          |  13 ++--
 rust/kernel/dma.rs                        |   3 +
 tools/virtio/linux/kmsan.h                |   2 +-
 24 files changed, 295 insertions(+), 276 deletions(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
