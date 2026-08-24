Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21292261B71
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581152; cv=none; b=g4mE4ZwoOQnSjQ+f+bnwtrQQCjOnDWbr9iM0bf5sWKqkJzciaO4/I644ZuHiSBh80DPauU6Gcsyviawwx0t/U2xN7KybhQbiIAKMLT06Mb56Lz931MCZi6djj1W5FyecW68JoqzaC4ywvQF4fAkzwX+onsxAR9lsUZMLYtfGHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581152; c=relaxed/simple;
	bh=QMNm8/A/Z6sZWBfwHSjRTcP7wsIy38D5cWmCwIQjXmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=Q0Jiy1Y8fgpvTtyD/4qpG85U/0k8kw4Y9IV8seR78RMcwpoJUrxqI8LnO+JhOshbh0NImVaoiopRUghnkxpnaYKyIPWp6hANqH61epq3JwH3rTgkskOsrRs30/d6O26oNLslnKQY2U8Wh+zY4xz4lKGfa94rlxtgro8ZPIqrPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VSQW1mA+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VSQW1mA+"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260824141907euoutp01c77109dcdf43552ca529636495fb2a2a~Ow5UWCpoH0481704817euoutp01V
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 14:19:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260824141907euoutp01c77109dcdf43552ca529636495fb2a2a~Ow5UWCpoH0481704817euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787581147;
	bh=wit1dPUHDdBZyOsSK462Olt/XajjHjcXV4j3Fq5DmdU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=VSQW1mA+g/97UTM08jD10FKORFAQLPHxTWc5Y+6ropB93C4h9McwgQwovGiautwil
	 XJMpc180u84uuP7Xoz6BAyvZ+52wUj/3/655r2FwJIIjL8mTvJpGO72YIhOhyMQfjr
	 ALz6yCOBH+G8aVAVtwQwYkAqABFLpfvTABCaTzMw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260824141906eucas1p205a270ef4435dbc65fca7b45937dad41~Ow5UEIW0f1720117201eucas1p2b;
	Mon, 24 Aug 2026 14:19:06 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260824141906eusmtip250dbd4628c26b0f201c1180072ba8f27~Ow5Tnk6d02131421314eusmtip2M;
	Mon, 24 Aug 2026 14:19:06 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
	chenhuguanshen <chenhgs@chinatelecom.cn>, Jagadeesh Pagadala
	<jpagadal@qti.qualcomm.com>, Honglei Huang <honghuan@amd.com>, Vova
	Sharaienko <sharaienko@google.com>
Subject: [GIT PULL] dma-mapping updates for Linux 7.3
Date: Mon, 24 Aug 2026 16:18:59 +0200
Message-ID: <20260824141901.1739207-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260824141906eucas1p205a270ef4435dbc65fca7b45937dad41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260824141906eucas1p205a270ef4435dbc65fca7b45937dad41
X-EPHeader: CA
X-CMS-RootMailID: 20260824141906eucas1p205a270ef4435dbc65fca7b45937dad41
References: <CGME20260824141906eucas1p205a270ef4435dbc65fca7b45937dad41@eucas1p2.samsung.com>

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-08-24

for you to fetch changes up to 121f9fd1c3083312055126205f3e40b8ee999fe6:

  dma/swiotlb: decouple high watermark tracking from CONFIG_DEBUG_FS (2026-08-13 08:02:35 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 7.3:

- swiotlb: added new configuration option for the default pool size
(Jagadeesh Pagadala) and reduced overhead for high watermark tracking
(chenhuguanshen)

- minor code cleanups and improvements (Vova Sharaienko, Honglei Huang
and Marek Szyprowski)

----------------------------------------------------------------
Honglei Huang (1):
      iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper

Jagadeesh Pagadala (1):
      dma/swiotlb: introduce Kconfig option for compile-time default pool size

Marek Szyprowski (2):
      dma-direct: Improve readability of the dma_direct_map_sg() for P2PDMA case
      MAINTAINERS: update tree for DMA MAPPING HELPERS

Vova Sharaienko (2):
      dma-coherent: fix spacing coding style issue
      dma-coherent: use KiB in DMA allocation logs

chenhuguanshen (1):
      dma/swiotlb: decouple high watermark tracking from CONFIG_DEBUG_FS

 Documentation/admin-guide/kernel-parameters.txt |   4 +-
 Documentation/core-api/swiotlb.rst              |   7 +-
 MAINTAINERS                                     |   3 +-
 drivers/iommu/dma-iommu.c                       |  57 ++++-----
 include/linux/swiotlb.h                         |  16 ++-
 kernel/dma/Kconfig                              |  22 ++++
 kernel/dma/coherent.c                           |  10 +-
 kernel/dma/direct.c                             |   3 +-
 kernel/dma/swiotlb.c                            | 153 +++++++++++++++---------
 9 files changed, 163 insertions(+), 112 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

