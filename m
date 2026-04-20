Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C724503B;
	Mon, 20 Apr 2026 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665675; cv=none; b=EFZ4zi45oowb5XCZusm787UXjiphosjWUgP1W/LgDSDpq0GBNyZP2SyGngsdCN/y4DKm5X8GigjvdimFPIhLt5r2rVbmAxni6CudbkfM8HoMjI0JQOjTt5LfB6Q7lS09t/Y8QOxccNQ/dxD6Yh5Yr7ZX/J+WqVMxSqV0smjjPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665675; c=relaxed/simple;
	bh=dyW7WUTIjUwQBAPan1sXwN1Iz19oB/heU5r5a5bP3f0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/dTDltdjMxO08my18bAQVYLivLCrleDX1eyETwXgbzIQLI3+SbTvYGkfWVy6TiS6dgdWVxkRm/yg/TiHdGC7aTbRXvCFwgJpN4wSFvYn25c1HHI9CJzCTvyFbVLpOINe9uIww6yWLuMC73nbfuyHhfx9Dt7Zlf6f2RmhlMWDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKuWjeif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKuWjeif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DE4C19425;
	Mon, 20 Apr 2026 06:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776665674;
	bh=dyW7WUTIjUwQBAPan1sXwN1Iz19oB/heU5r5a5bP3f0=;
	h=From:To:Cc:Subject:Date:From;
	b=oKuWjeifLnCiDZ8sR/gQGZMUSmfO//fIHr2EEvNPv+2ZJzrW/w8Ivse/jXqO3EcwP
	 5tpT42ounQ6EqGdmDW3FKbFhycXMuLxkJwRRg0vpVy+fgADBdTOeVeoaZq04EQDvjv
	 homDkDqwFXo+ghJ3qGG6ZD48nr8ub00f81u+HBcuR4fjyiIzxCMOxQUIr/II2poMq6
	 +msv6ZnfjEIPRkUNW71kakfuh2NLQTTEtK5vsD4DOSokNLNJl0LDTJHulp/6z6KUSB
	 wtjVZ23QD8wCUC0dwcz82CDLY4kleFDTI7GrLry/E71ZFW+IkmA9eUAZRPNaWZjuuz
	 chr/GQW02TmQA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com,
	m.szyprowski@samsung.com,
	will@kernel.org,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	catalin.marinas@arm.com,
	jiri@resnulli.us,
	jgg@ziepe.ca,
	aneesh.kumar@kernel.org,
	Mostafa Saleh <smostafa@google.com>
Subject: [PATCH v2 0/8] dma-mapping: Use DMA_ATTR_CC_SHARED through direct, pool and swiotlb paths
Date: Mon, 20 Apr 2026 11:44:07 +0530
Message-ID: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
are handled consistently.

Today, the direct DMA path mostly relies on force_dma_unencrypted() for
shared/decrypted buffer handling. This series consolidates the
force_dma_unencrypted() checks in the top-level functions and ensures
that the remaining DMA interfaces use DMA attributes to make the correct
decisions.

The series:
- moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
- propagates DMA_ATTR_CC_SHARED through the dma-direct alloc/free
  paths,
- teaches the atomic DMA pools to track encrypted versus decrypted
  state,
- tracks swiotlb pool encryption state and enforces strict pool
  selection,
- centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
  DMA attributes,
- makes dma_direct_map_phys() choose the DMA address encoding from
  attrs, and
- uses the selected swiotlb pool state to derive the returned DMA
  address.

Changes from v1:
* rebased to latest kernel (change from DMA_ATTR_CC_DECRYPTED -> DMA_ATTR_CC_SHARED)
* Update alloc path such that DMA_ATTR_CC_SHARED s not a caller-visible attribute.

Aneesh Kumar K.V (Arm) (8):
  dma-direct: swiotlb: handle swiotlb alloc/free outside
    __dma_direct_alloc_pages
  dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
  dma-pool: track decrypted atomic pools and select them via attrs
  dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
  dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
  dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
  dma-direct: set decrypted flag for remapped DMA allocations
  dma-direct: select DMA address encoding from DMA_ATTR_CC_SHARED

 drivers/iommu/dma-iommu.c   |   2 +-
 include/linux/dma-direct.h  |  10 ++
 include/linux/dma-map-ops.h |   2 +-
 include/linux/swiotlb.h     |   7 +-
 kernel/dma/direct.c         | 185 ++++++++++++++++++++++++++++--------
 kernel/dma/direct.h         |  25 ++---
 kernel/dma/mapping.c        |  16 +++-
 kernel/dma/pool.c           | 154 +++++++++++++++++++-----------
 kernel/dma/swiotlb.c        |  89 +++++++++++++----
 9 files changed, 355 insertions(+), 135 deletions(-)


base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
-- 
2.43.0

