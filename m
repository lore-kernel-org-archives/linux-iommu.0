Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446831373
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372311; cv=none; b=YbsZDr1h+hkCKyPp3sMQYIJPNofTiLtuRfJxbL9sCPR8w2K4/UP2FuVX0fJHady75YGRJzuE6OVyiOQY+Te5O4/3qD+87ycsAf+16kwkBM3HJxzOCIx3jmdVF01S/KVgx+g+wbpSETd89Jb/9lKY6AG+NQffttp7AUgFoL8EY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372311; c=relaxed/simple;
	bh=F49ckCOpg5fyZ690fawsGzAm+z7CFS7kUt4DM6zbfIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=phsinzClQwRb/ERXRJ3XPO7Xg+rHbvwVZLQacCo+Ac4dzUEoAEyLoiiuz9wRN7ZUVNnLYpjukvk/kR/2CQUCmg18li2oh2j5edrsUKZW8myX9DPKU9pDGIEI7yzTckx5eOHw/Bg2vYD8uRQa8yfo4iJ+QgjUXKs+G52zu84c6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pVcS55NV; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pVcS55NV"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250828091146euoutp028b840e7b4e5dff325489ee9ce599d952~f406SgCZn2964829648euoutp02g
	for <iommu@lists.linux.dev>; Thu, 28 Aug 2025 09:11:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250828091146euoutp028b840e7b4e5dff325489ee9ce599d952~f406SgCZn2964829648euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756372306;
	bh=SQsf9ZDYvefHFj0I2V0CVwlzMn4B1xGONEr2tsW/hSM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=pVcS55NVqCenJLn4CdGLewjI2ey3p//h6fnYseupia+kJu9gcyG3bsSysw7ZAhzi6
	 KPHNcxwRiT2FXqiojfjFaXmHMjv6kPk6blbKwg8SGTDsBW1iZAX44WAj7mA+1CMC3N
	 iCkijRsMALNqhmX10q/jzmLt0wMU6Gb27n4otXTc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250828091145eucas1p2293261860e89a33ae54ce1c908ef8619~f405um4Gx1728417284eucas1p2N;
	Thu, 28 Aug 2025 09:11:45 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250828091145eusmtip2056ad537927b2eb250b5ebf770da3f1a~f405VunUS2470224702eusmtip2r;
	Thu, 28 Aug 2025 09:11:45 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Subject: [GIT PULL] dma-mapping fix for Linux 6.17
Date: Thu, 28 Aug 2025 11:11:32 +0200
Message-Id: <20250828091132.860125-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250828091145eucas1p2293261860e89a33ae54ce1c908ef8619
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250828091145eucas1p2293261860e89a33ae54ce1c908ef8619
X-EPHeader: CA
X-CMS-RootMailID: 20250828091145eucas1p2293261860e89a33ae54ce1c908ef8619
References: <CGME20250828091145eucas1p2293261860e89a33ae54ce1c908ef8619@eucas1p2.samsung.com>

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.17-2025-08-28

for you to fetch changes up to 89a2d212bdb4bc29bed8e7077abe054b801137ea:

  dma/pool: Ensure DMA_DIRECT_REMAP allocations are decrypted (2025-08-13 11:02:10 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.17

- another small fix relevant to arm64 systems with memory encryption
(Shanker Donthineni)
- fix relevant to arm32 systems with non-standard CMA configuration
(Oreoluwa Babatunde)

----------------------------------------------------------------
Oreoluwa Babatunde (1):
      of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()

Shanker Donthineni (1):
      dma/pool: Ensure DMA_DIRECT_REMAP allocations are decrypted

 drivers/of/of_reserved_mem.c | 16 ++++++++++++----
 include/linux/dma-map-ops.h  |  3 +++
 kernel/dma/contiguous.c      |  2 --
 kernel/dma/pool.c            |  4 ++--
 4 files changed, 17 insertions(+), 8 deletions(-)
