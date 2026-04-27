Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9F366563;
	Mon, 27 Apr 2026 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269323; cv=none; b=F2koh/933J7NtHcA/OindgQTLovY59e9xvh7MtI8Nsa0ZF5PSnIy2A5d/B9tUBdYeXlvOKADmQufJE5j6NBoNvSAdrluqmdgmBUp540z+QbaBRq2N9XhKn/SS+fKQXzgwFz0xKtUkOL/+d5Jamuas7/4Bw4Z+maB6v5IKU4zw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269323; c=relaxed/simple;
	bh=6ZjxOpU68srlH3qry9A0v7Th0kxY8yaBOyYCtR4Ku2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGijvsYnwcmQgtUlva8aD2glr9rogu3otulNnc27h4TrnAMQ1LAZnlx31PMDtOJcRnGORIQla48By81aEf/+fsKrW5kqGv60yv4cMzYmiSHl9iYZcsygA+qmA4wc130+LaGdO0Di48ysmZUBAq2cCVh+nUTUzHHxpdqxO59PlRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a91uPiwT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a91uPiwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4065C19425;
	Mon, 27 Apr 2026 05:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777269322;
	bh=6ZjxOpU68srlH3qry9A0v7Th0kxY8yaBOyYCtR4Ku2o=;
	h=From:To:Cc:Subject:Date:From;
	b=a91uPiwTgoduDRliXTq1Qc6Ts1j0KVr/JxNT2CI+aO0PRIy2V58/OJxFY+wDgIEMV
	 lqAjjWUryGT1QJSV3wHctJ3n/AU3sPy6+05aiK84fsYVaYiTdtviEaPN+sHAB9/xuV
	 5ufA5wWH8oJKmCZoNL8S1HqziXDAfVJ6zcdfS5Cmtq9s31N2gZgfPU3q81YC5SXwIQ
	 /Ql7hxJW3MACjewVAeVAF63P68UxbRd3nepK5kXFN27ibyWeEyGJ5TuM7iO1LU+dJ6
	 CBS7/NR5lOmURfhMMNn/c6baMZBhmjliiBk9ngZItdLgfAFuMqCZi77vIudxBUjvv5
	 3fesTp+wm3iUw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v3 0/9] dma-mapping: Use DMA_ATTR_CC_SHARED through direct, pool and swiotlb paths
Date: Mon, 27 Apr 2026 11:25:00 +0530
Message-ID: <20260427055509.898190-1-aneesh.kumar@kernel.org>
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
  paths
- teaches the atomic DMA pools to track encrypted versus decrypted
  state
- tracks swiotlb pool encryption state and enforces strict pool
  selection
- centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
  DMA attributes
- passes DMA attributes down to dma_capable() so capability checks can
  validate whether the selected DMA address encoding matches
  DMA_ATTR_CC_SHARED
- makes dma_direct_map_phys() choose the DMA address encoding from
  DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
  cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
  relying on SWIOTLB_FORCE for DMA mappings
- use the selected swiotlb pool state to derive the returned DMA
  address.

Changes from v2:
https://lore.kernel.org/all/20260420061415.3650870-1-aneesh.kumar@kernel.org
* pass attrs to dma_capable() and update direct, swiotlb, Xen swiotlb, and
  x86 GART paths so the capability checks see the DMA address attr value
  DMA_ATTR_CC_SHARED.
* rework dma_direct_map_phys() so DMA_ATTR_CC_SHARED selects
  phys_to_dma_unencrypted() while the default path uses
  phys_to_dma_encrypted(), with swiotlb fallback when the requested
  shared/private state cannot be satisfied by a direct DMA address.
* stop relying on SWIOTLB_FORCE for arm64 and x86 CC guest DMA mappings;
  swiotlb is still enabled there, but shared mappings is now selected
  through the generic dma_direct_map_phys()/dma_capable() decision instead
  of a global force-bounce flag.

Changes from v1:
https://lore.kernel.org/all/20260417085900.3062416-1-aneesh.kumar@kernel.org
* rebased to latest kernel (change from DMA_ATTR_CC_DECRYPTED -> DMA_ATTR_CC_SHARED)
* update the alloc path so DMA_ATTR_CC_SHARED is not a caller-visible attribute.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jiri Pirko <jiri@resnulli.us> 
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>
Cc: Petr Tesarik <ptesarik@suse.com> 
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>

Aneesh Kumar K.V (Arm) (9):
  dma-direct: swiotlb: handle swiotlb alloc/free outside
    __dma_direct_alloc_pages
  dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
  dma-pool: track decrypted atomic pools and select them via attrs
  dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
  dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
  dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
  dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
  dma-direct: set decrypted flag for remapped DMA allocations
  dma-direct: select DMA address encoding from DMA_ATTR_CC_SHARED

 arch/arm64/mm/init.c          |   4 +-
 arch/x86/kernel/amd_gart_64.c |  30 +++---
 arch/x86/kernel/pci-dma.c     |   4 +-
 drivers/iommu/dma-iommu.c     |   2 +-
 drivers/xen/swiotlb-xen.c     |   9 +-
 include/linux/dma-direct.h    |  19 +++-
 include/linux/dma-map-ops.h   |   2 +-
 include/linux/swiotlb.h       |   7 +-
 kernel/dma/direct.c           | 189 ++++++++++++++++++++++++++--------
 kernel/dma/direct.h           |  32 +++---
 kernel/dma/mapping.c          |  16 ++-
 kernel/dma/pool.c             | 154 +++++++++++++++++----------
 kernel/dma/swiotlb.c          |  93 +++++++++++++----
 13 files changed, 393 insertions(+), 168 deletions(-)


base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.43.0

