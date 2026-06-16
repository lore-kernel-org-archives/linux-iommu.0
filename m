Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D703271FD
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601414; cv=none; b=n5vgYIML9wWnhzGNPR6shUzqGA95PSfqb5Eg3edjeJ1IKHFk11ZGmajkHLr6tdw7MllKDiRNsrsB+UgxKNxSFEgETqEluBbvChteuUKqPgp9wFELpelrSs9f9lx4iwURXg7DRbEmTWcu78eGhXLAgl0woVhaqfI+E1juwt7mpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601414; c=relaxed/simple;
	bh=63rm0mBZGYwR2UFVL+QYsHYDnRBFGfQ0BEmLJhEDchM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=YnvGUNqUHG4SBk/1/lFeytiMLXGIuARk0JELwTtfQH3U4ogsp6j2WeG1Cx+CD8rcCbjew4SUl5hxOhbk/UAddzuJtqIi4UMg4C7CS1Ai/++GgRIE2PFkB0pYThvZR3NaAJ2Q7fIIkgnuuDMrdIPKvf7GNs6a+xuRLdZzt0XjFEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hyyVvWLf; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hyyVvWLf"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260616091643euoutp02ae5e01ab8965f4796e6361d632cd1f90~5hQmOjy882331023310euoutp02p
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 09:16:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260616091643euoutp02ae5e01ab8965f4796e6361d632cd1f90~5hQmOjy882331023310euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781601403;
	bh=DjoQEyarF9JrLCbyzCNw8e2dKPdDYwYziR1t+5QKSP4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hyyVvWLftmhe71/o5jI8spEqTGeZkbHsgCiuNBKcchH1w2ZbjdNSI79pkKd5Ft0Ba
	 DstY/mylSqlL1cvAtLcRPajqxZSgIoYxFtqYe+Az9QIZdDeqVUxyaN8MdkOXh9IJis
	 0XTSeQ0XVds/lvW/af4amq/O2NgBkZxUDA4ky0u4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260616091643eucas1p2a8cbfd992db37b6863c2ce7e30a5b9f5~5hQl52H7c1281012810eucas1p26;
	Tue, 16 Jun 2026 09:16:43 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260616091642eusmtip27eb540c879b3db32ad0ae69185f95655~5hQlgehB12518025180eusmtip2a;
	Tue, 16 Jun 2026 09:16:42 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Leon
	Romanovsky <leon@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, Rosen
	Penev <rosenp@gmail.com>
Subject: [GIT PULL] dma-mapping updates for Linux 7.2
Date: Tue, 16 Jun 2026 11:16:30 +0200
Message-Id: <20260616091630.3261096-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260616091643eucas1p2a8cbfd992db37b6863c2ce7e30a5b9f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260616091643eucas1p2a8cbfd992db37b6863c2ce7e30a5b9f5
X-EPHeader: CA
X-CMS-RootMailID: 20260616091643eucas1p2a8cbfd992db37b6863c2ce7e30a5b9f5
References: <CGME20260616091643eucas1p2a8cbfd992db37b6863c2ce7e30a5b9f5@eucas1p2.samsung.com>

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.2-2026-06-16

for you to fetch changes up to 7318301e060e3f1207a34f2fca6cd86770dd9160:

  dma: map_benchmark: turn dma_sg_map_param buf into a flexible array (2026-06-03 08:20:02 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 7.2:

- added more checks for DMA attributes in the debug code, especially
  to ensure that mappings are created and released with matching
  attributes (Leon Romanovsky)

- better default configuration for CMA on NUMA machines (Feng Tang)

- little code cleanup in dma benchmark tool (Rosen Penev)

----------------------------------------------------------------
Feng Tang (2):
      dma-contiguous: add kconfig option to setup numa cma area if not configured explicitly
      dma-contiguous: simplify numa cma area handling

Leon Romanovsky (6):
      ntb: Store original DMA address for future release
      ntb: Use consistent DMA attributes when freeing DMA mappings
      dma-debug: Remove unused DMA attribute parameter
      dma-debug: Record DMA attributes in debug entry
      dma-debug: Feed DMA attribute for unmapping flows too
      dma-debug: Ensure mappings are created and released with matching attributes

Rosen Penev (1):
      dma: map_benchmark: turn dma_sg_map_param buf into a flexible array

 Documentation/admin-guide/kernel-parameters.txt |  4 ++
 drivers/ntb/ntb_transport.c                     | 10 +--
 kernel/dma/Kconfig                              | 14 +++-
 kernel/dma/contiguous.c                         | 58 +++++++----------
 kernel/dma/debug.c                              | 87 +++++++++++++++++--------
 kernel/dma/debug.h                              | 25 +++----
 kernel/dma/map_benchmark.c                      | 27 ++++----
 kernel/dma/mapping.c                            | 10 +--
 8 files changed, 136 insertions(+), 99 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

