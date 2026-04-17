Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389793502AA;
	Fri, 17 Apr 2026 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416385; cv=none; b=q20bHl3l/DZBj7ui5+5FmpCWZFoErHvlU0rVMeO1hmX3P13KnHhJ4Sc0Sm45cDGpAq+5LpwYFSNnlR0oRoimtRf7lxF5MkVSJzmwaoIybR9Xz6ziqN5snM/u7E8fc+ZYUExyMWyIDtH2GHG1L9t9JcY5p18EKRWY4nb2+yLx/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416385; c=relaxed/simple;
	bh=HyuQZEEeU8tY9KHAc9EyEh9GiRXTZ/f8wwHr7CbqQhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7oZmcDS7isQL8vZgQ73S9/JRDDca0Ux5mJtsJldY/q6+VI0dBFhbP0B3+e4lYAKltnGy2tSfYkeBQ+4NteFOJ/63gPHpmwXarwxu5Sm+O1r3OHW8buEZdzwKJbFu//p7F8T2vcXMqZZHtJSnqJUdrzPlfwVSGNzUegDg1XQ2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL6sXlGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL6sXlGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEC9C2BCB4;
	Fri, 17 Apr 2026 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776416384;
	bh=HyuQZEEeU8tY9KHAc9EyEh9GiRXTZ/f8wwHr7CbqQhk=;
	h=From:To:Cc:Subject:Date:From;
	b=HL6sXlGgU/p/AIzH1s9eZ7NvmWeBf9iR2FbJptlHKeIvnBipnv6FsumavDVii1pqj
	 IfsX2nIImctJ990QbCW8AsIyQH/Qn/3//f6F5Hh9ENq//UytR9/axRGJGLg5Z9Dwvk
	 fcQyb8MgZmA4MdhmYNIS6DxFsqGCnKJEztxDH/cDOsqn7VaGwnDRr8meP+N9kurV4y
	 92QJVCyRK0sLrUXqMvGK/LHUgxkb2Ck6CM8vAuuMUj9avRsQK4LGaR6Y3JdDu203Bx
	 P4UJCOaCpC9++0yAXxkM1ex8UsjvptSRg7tEKIECW4MMoQLjyqmggehUtSnTs8fHeN
	 yC2OCHTmTXMtA==
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
Subject: [RFC PATCH 0/7] dma-mapping: Use DMA_ATTR_CC_DECRYPTED through direct, pool and swiotlb paths
Date: Fri, 17 Apr 2026 14:28:53 +0530
Message-ID: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series propagates DMA_ATTR_CC_DECRYPTED through the dma-direct,
dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
are handled consistently.

Today, the direct DMA path mostly relies on force_dma_unencrypted() for
shared/decrypted buffer handling. This series consolidates the
force_dma_unencrypted() checks in the top-level functions and ensures
that the remaining DMA interfaces use DMA attributes to make the correct
decisions.

The series:
- moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
- propagates DMA_ATTR_CC_DECRYPTED through the dma-direct alloc/free
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

Aneesh Kumar K.V (Arm) (7):
  dma-direct: swiotlb: handle swiotlb alloc/free outside
    __dma_direct_alloc_pages
  dma-direct: use DMA_ATTR_CC_DECRYPTED in alloc/free paths
  dma-pool: track decrypted atomic pools and select them via attrs
  dma: swiotlb: track pool encryption state and honor
    DMA_ATTR_CC_DECRYPTED
  dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_DECRYPTED
  dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_DECRYPTED
  dma-direct: set decrypted flag for remapped DMA allocations

 drivers/iommu/dma-iommu.c   |   2 +-
 include/linux/dma-direct.h  |  10 +++
 include/linux/dma-map-ops.h |   2 +-
 include/linux/swiotlb.h     |   7 +-
 kernel/dma/direct.c         | 129 ++++++++++++++++++++++++------
 kernel/dma/direct.h         |  25 +++---
 kernel/dma/mapping.c        |  16 +++-
 kernel/dma/pool.c           | 154 +++++++++++++++++++++++-------------
 kernel/dma/swiotlb.c        |  89 ++++++++++++++++-----
 9 files changed, 318 insertions(+), 116 deletions(-)

-- 
2.43.0

