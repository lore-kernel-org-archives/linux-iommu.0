Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93D28DB54
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511545; cv=none; b=vApLZv0y/E4zJYNuZq420zpOCXn9ygtDSyedYbXhtaJ2tfRtxPZ/73ovKPYMjw0+Nd9PFIdE8laICigRM8TEyy+BJirQHl7ur1ToU+GV6N7aVrwMZXV0/kxYEsyjrTDDNRjDkHA2Cq+O0LL8rq1/oud62j6bo6ZnMfacm9vQ6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511545; c=relaxed/simple;
	bh=jPljd9vGfN/PjSLihMte3sbJ7nbgt+C4PQw0sgeZaKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=antYi9Gs01ue8nBNZAis/78iol6u6iDy4q+hIoYYN9I58uvJhniwAH9FrnvBHyI4DUVdFEc87wPxJ1N1a2+W3lYq7IZQuegiH9U7B9r+TV3MWHM3+BX1AHKHcIh97qJHdlq4DJgOsCOrefLWm2pj+zD3Oy/GYtGQ97CzOu6d8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N7H17eFx; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N7H17eFx"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260326075215euoutp016b9c68bd1aaae388ad2e2081dfb0baa3~gVNbdzUu_0858708587euoutp01V
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 07:52:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260326075215euoutp016b9c68bd1aaae388ad2e2081dfb0baa3~gVNbdzUu_0858708587euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774511535;
	bh=smOOrZwniGVWFMk0ruy3RJGZscV+5zAzKm+hTQEvUmY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=N7H17eFxozEytFmozG6cCsRwkgrLQSKpYRoFEU2y7ibnTC+6UQ6SQ2AzpbBh8YvuN
	 SuefJOedAi0dB9WMDMZRKEtbmT9HKFx9OHZuAtGF8Dxz8KyDcab0sHdOQA9TEsIBAF
	 SVT8FXsGUKCzySa7HNcziddfaAhDbwI1SuXGeubY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260326075214eucas1p192a7e540eed96bae33f17cdbd3745d9d~gVNbRdzMe2740027400eucas1p1e;
	Thu, 26 Mar 2026 07:52:14 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260326075214eusmtip2d69d2253b3bb8c30dac422b2ac374d57~gVNa4aN_T0633606336eusmtip2Y;
	Thu, 26 Mar 2026 07:52:14 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Shigeru
	Yoshida <syoshida@redhat.com>, Leon Romanovsky <leon@kernel.org>, Miguel
	Ojeda <ojeda@kernel.org>
Subject: [GIT PULL] second set of dma-mapping fixes for Linux 7.0
Date: Thu, 26 Mar 2026 08:52:00 +0100
Message-Id: <20260326075200.1751363-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260326075214eucas1p192a7e540eed96bae33f17cdbd3745d9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260326075214eucas1p192a7e540eed96bae33f17cdbd3745d9d
X-EPHeader: CA
X-CMS-RootMailID: 20260326075214eucas1p192a7e540eed96bae33f17cdbd3745d9d
References: <CGME20260326075214eucas1p192a7e540eed96bae33f17cdbd3745d9d@eucas1p1.samsung.com>

The following changes since commit d5b5e8149af0f5efed58653cbebf1cb3258ce49a:

  sparc: Fix page alignment in dma mapping (2026-02-23 08:33:51 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-03-25

for you to fetch changes up to 2cdaff22ed26f1e619aa2b43f27bb84f2c6ef8f8:

  dma-mapping: add missing `inline` for `dma_free_attrs` (2026-03-25 08:01:21 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 7.0

A set of fixes for DMA-mapping subsystem, which resolve false-positive
warnings from KMSAN and DMA-API debug (Shigeru Yoshida and Leon
Romanovsky) as well as a simple build fix (Miguel Ojeda).

----------------------------------------------------------------
Leon Romanovsky (8):
      dma-debug: Allow multiple invocations of overlapping entries
      dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output
      dma-mapping: Clarify valid conditions for CPU cache line overlap
      dma-mapping: Introduce DMA require coherency attribute
      dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is set
      iommu/dma: add support for DMA_ATTR_REQUIRE_COHERENT attribute
      RDMA/umem: Tell DMA mapping that UMEM requires coherency
      mm/hmm: Indicate that HMM requires DMA coherency

Miguel Ojeda (1):
      dma-mapping: add missing `inline` for `dma_free_attrs`

Shigeru Yoshida (1):
      dma: swiotlb: add KMSAN annotations to swiotlb_bounce()

 Documentation/core-api/dma-attributes.rst | 38 ++++++++++++++++++++++++-------
 drivers/infiniband/core/umem.c            |  5 ++--
 drivers/iommu/dma-iommu.c                 | 21 +++++++++++++----
 drivers/virtio/virtio_ring.c              | 10 ++++----
 include/linux/dma-mapping.h               | 19 +++++++++++-----
 include/trace/events/dma.h                |  4 +++-
 kernel/dma/debug.c                        |  9 ++++----
 kernel/dma/direct.h                       |  7 +++---
 kernel/dma/mapping.c                      |  6 +++++
 kernel/dma/swiotlb.c                      | 21 +++++++++++++++--
 mm/hmm.c                                  |  4 ++--
 11 files changed, 107 insertions(+), 37 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
