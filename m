Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A936AB77
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583185; cv=none; b=eK1a7Vwnj0b4+gX6BifjAjbq5O4godXpd8V91fsBcIxOJx8A3cD+f61S/LCYe5RTb6oB7qVoPC/GtdlU77NrNeonhnVt/cmJpf05bsMEArDJ6JSkHFVFMb46SSPkl6qArP9d4i2f3XlQd7Lgr3hR9FFpurYjeGJDhxoyA9ZrqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583185; c=relaxed/simple;
	bh=jAio+7+N0+CQgBMvemTRZMLl6jyxc58C3xD6BPVn/rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=kd92uT+jnt4khZq0sGxw/5g9b/Jlbc4YuOgteiJEb1tqph+kQgb42coInW3kHCnBE4W4apX2gc5RNKtDeW9GgNgJvKd+2BhQGpHPhilwXzjWO/tWiNeDRaqGMOj+IZu0g4J9///f79kDHXtb78M0GVMzvIIjG/eIcLtDZd65sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HDQgsBxx; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HDQgsBxx"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260824145300euoutp02558d38fae33eb6ad915e55c1ba5ec1e5~OxW5_TBlV2057820578euoutp024
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 14:53:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260824145300euoutp02558d38fae33eb6ad915e55c1ba5ec1e5~OxW5_TBlV2057820578euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787583180;
	bh=QPHti+tYcSVpO4hQcMTqKaG0wIX1o/VSV/ogYvDJO0k=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HDQgsBxxkb/myGYnYy+EIEuoNngRN1mPdX+/5mhxzgDWBUAZDFxY/VyCUyUI4kh3J
	 +l6k0NkL/rEbDqDhw3cF3ycdGjNe8esOBxgKzD2bw8F9lLR/DYi/4dOA5HlaIQBHt9
	 SQwrR9mrkK0L9t8OyrEDnJKhGUtZyZV+9q3Y8X5k=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260824145300eucas1p10b9c95dddfc11e7847607f9c473b6f38~OxW5s8MtT1924719247eucas1p1n;
	Mon, 24 Aug 2026 14:53:00 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260824145259eusmtip168e7593857659e7d1f65375fe2466874~OxW5SX3OE0313203132eusmtip1g;
	Mon, 24 Aug 2026 14:52:59 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, "Aneesh
 Kumar K . V" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] second dma-mapping update for Linux 7.3
Date: Mon, 24 Aug 2026 16:52:51 +0200
Message-ID: <20260824145253.1740671-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260824145300eucas1p10b9c95dddfc11e7847607f9c473b6f38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260824145300eucas1p10b9c95dddfc11e7847607f9c473b6f38
X-EPHeader: CA
X-CMS-RootMailID: 20260824145300eucas1p10b9c95dddfc11e7847607f9c473b6f38
References: <CGME20260824145300eucas1p10b9c95dddfc11e7847607f9c473b6f38@eucas1p1.samsung.com>

The following changes since commit 221049874b6a78c7d87bc826581b0695cd338e2b:

  arm64: RSI: fix field-spanning write warning in attestation token init (2026-07-26 14:22:46 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-08-24-2

for you to fetch changes up to 04a19b35dc05354445f0096befad63af885bb77e:

  swiotlb: remove unused SWIOTLB_FORCE flag (2026-07-31 08:44:52 +0200)

----------------------------------------------------------------
second dma-mapping update for Linux 7.3:

- important dma-mapping update for confidential-computing, which adds
proper tracking of the shared DMA state through direct, pool and swiotlb
paths (Aneesh Kumar K.V)

----------------------------------------------------------------
This pull-request is based on the already merged stable branch from
arm64 tree. The conflic in arch/s390/mm/init.c should be resolved to:

swiotlb_init(true, SWIOTLB_VERBOSE | SWIOTLB_ANY);

----------------------------------------------------------------
Aneesh Kumar K.V (Arm) (23):
      dma-direct: return struct page from dma_direct_alloc_from_pool()
      dma-pool: fix page leak in atomic_pool_expand() cleanup
      iommu/dma: Check atomic pool allocation result directly
      dma: free atomic pool pages by physical address
      swiotlb: Preserve allocation virtual address for dynamic pools
      s390: Expose protected virtualization through cc_platform_has()
      dma-direct: swiotlb: handle swiotlb alloc/free outside __dma_direct_alloc_pages
      coco: arm64: s390: powerpc: Mark secure guests with CC_ATTR_GUEST_MEM_ENCRYPT
      dma-mapping: Add internal shared allocation attribute
      dma-direct: use __DMA_ATTR_ALLOC_CC_SHARED in alloc/free paths
      dma-pool: track decrypted atomic pools and select them via attrs
      dma: swiotlb: pass mapping attributes by reference
      dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
      dma-mapping: make dma_pgprot() honor __DMA_ATTR_ALLOC_CC_SHARED
      dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
      dma-direct: Move dma_direct_map_phys() to dma/direct.c
      dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
      dma-direct: set decrypted flag for remapped DMA allocations
      dma-direct: select DMA address encoding from __DMA_ATTR_ALLOC_CC_SHARED
      dma-direct: rename ret to cpu_addr in alloc helpers
      dma: swiotlb: free dynamic pools from process context
      dma: swiotlb: handle set_memory_decrypted() failures
      swiotlb: remove unused SWIOTLB_FORCE flag

 Documentation/core-api/dma-attributes.rst    |  29 +++
 arch/arm64/mm/init.c                         |   5 +-
 arch/powerpc/platforms/pseries/cc_platform.c |   1 +
 arch/powerpc/platforms/pseries/svm.c         |   2 +-
 arch/s390/Kconfig                            |   1 +
 arch/s390/mm/init.c                          |  17 +-
 arch/x86/kernel/amd_gart_64.c                |  30 +--
 arch/x86/kernel/pci-dma.c                    |   4 +-
 drivers/iommu/dma-iommu.c                    |  20 +-
 drivers/xen/swiotlb-xen.c                    |   8 +-
 include/linux/dma-direct.h                   |  20 +-
 include/linux/dma-map-ops.h                  |   3 +-
 include/linux/dma-mapping.h                  |   8 +
 include/linux/swiotlb.h                      |  25 +-
 include/trace/events/dma.h                   |   3 +-
 kernel/dma/direct.c                          | 326 ++++++++++++++++++++-------
 kernel/dma/direct.h                          |  56 +----
 kernel/dma/mapping.c                         |  25 +-
 kernel/dma/pool.c                            | 237 ++++++++++++++-----
 kernel/dma/swiotlb.c                         | 292 ++++++++++++++++++------
 20 files changed, 810 insertions(+), 302 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

