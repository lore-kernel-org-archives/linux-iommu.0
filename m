Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431022FE0A
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385959; cv=none; b=s2CBMije1FVJpVJGVOw59AFAGMKQqqwOPhuLt/q5SwCoR+0/HLjWtVFhd/msxIISL54D9VCaHsTGoNZRqMxIVZBb0KR/nLVAL3j9kKGJUwsSHIs1VhjXvryGlgPGBQvmTuYJO2J/cYYbjJX6WF0DsnwjPpteSOydDk22Atr0kaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385959; c=relaxed/simple;
	bh=ZM2oZFmiGf6ztXCKiNzfvY4bLPorUb8ngmfgqhkLeuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=rWEzKahE1VEf0KYTjKIblgtNO6MxLj5ewD6sqeU1U94j7OcW/mqOLb4IGDzFgNj3IOOiMDyJcSLEFDn1dZwkN/T0D9/zkv13OS1lc8PAPLBzo8L/k3raEffm3n9D4BJWc13O4MdBattDFRaAHj72Q5tr9vZsJna/lw2XIYckXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hdzYAwSy; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hdzYAwSy"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251210165908euoutp02539125912412b2767f5d7ad5e24f3bce~-6SrE8i9D2365123651euoutp02C
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 16:59:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251210165908euoutp02539125912412b2767f5d7ad5e24f3bce~-6SrE8i9D2365123651euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765385948;
	bh=0yFDSygk/6NcvcfNSsJiPrOJrsoJS8XfVTBtzVNWKhU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hdzYAwSy/AYjrH/1y6wrbM1KVea39M9NZlw6ikwOfFhLmYpXdY76p4jRhDr01Yf2t
	 AwSicIlcNGNbj7titn1r97d1BKfuWe9drNZdfsb7bPIRTTgYw28DQlrWfOExsMDtT1
	 f56dT+ZYeMVHaWWJVKWPWImVugU0GUvalpoEFWlU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251210165908eucas1p192490cfd679fc4ae5e7b99bea7b4e81c~-6Sq0Br_i1023910239eucas1p1_;
	Wed, 10 Dec 2025 16:59:08 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251210165908eusmtip14c94c1cf39a0d3dcc44e0dacca5f8647~-6SqauPge2102821028eusmtip1a;
	Wed, 10 Dec 2025 16:59:08 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [GIT PULL] dma-mapping fixes for Linux 6.19
Date: Wed, 10 Dec 2025 17:58:54 +0100
Message-Id: <20251210165854.2568046-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251210165908eucas1p192490cfd679fc4ae5e7b99bea7b4e81c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251210165908eucas1p192490cfd679fc4ae5e7b99bea7b4e81c
X-EPHeader: CA
X-CMS-RootMailID: 20251210165908eucas1p192490cfd679fc4ae5e7b99bea7b4e81c
References: <CGME20251210165908eucas1p192490cfd679fc4ae5e7b99bea7b4e81c@eucas1p1.samsung.com>

The following changes since commit d0d08f4bd7f667dc7a65cd7133c0a94a6f02aca3:

  dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings (2025-11-26 21:47:13 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2025-12-10

for you to fetch changes up to 31b931bebd11a0f00967114f62c8c38952f483e5:

  dma-mapping: Fix DMA_BIT_MASK() macro being broken (2025-12-08 09:40:57 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.19:

- last minute fix for missing parenthesis in the recently merged code
(Hans de Goede) and removal of the excessive, non-fatal warnings (Dave
Kleikamp)

----------------------------------------------------------------
Dave Kleikamp (1):
      dma/pool: eliminate alloc_pages warning in atomic_pool_expand

Hans de Goede (1):
      dma-mapping: Fix DMA_BIT_MASK() macro being broken

 include/linux/dma-mapping.h | 2 +-
 kernel/dma/pool.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
