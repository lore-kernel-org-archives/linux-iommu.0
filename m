Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12643CEEC
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918808; cv=none; b=FZgeKG12RBwkLYnO56X6bFzBYkyQ1HRunS7QbuqcWYUezmy1tusekXQbcMhQ3osetCLMYa8/hSBpNM4w+99w1u/cEIuWZm1tk7eojWJqvrbBf9mw4aC2BhAm7mA6YN3LTadwu+kZ5SeBRUqcUEXrcT7JzPOqSt/C8MVhILTWRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918808; c=relaxed/simple;
	bh=TA9JEi4f3YsWqh8mdfIO9MAxZOiBqwLRRep26TGn32g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ktCb9KG0vW22dbPYQ7tfIGJt6M4gD1chyKTtaXIJ/l0luJONK5l3RV8T4d1+KGlEPf908RkUkY7JkkMBI/HRS0ocov2sj7CRRxLf7cFiceOocbaPXsIaVgaALzqwmVKdquICHwo0UYqkODXzDXevoYmaQjUgIE4O38/CgPemvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=f6P/1OAy; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f6P/1OAy"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260120141959euoutp018bcecffd068111d81740c85fcacd6628~MdkaMG_PZ1653616536euoutp01o
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 14:19:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260120141959euoutp018bcecffd068111d81740c85fcacd6628~MdkaMG_PZ1653616536euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768918799;
	bh=KEeMjSbFKXoGipD43mJPm0kjFlNrOXsA37q7S3lVtrU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=f6P/1OAyaQsRqPSKO+EJ9njBGBK9AIjX8sy/MbUcbC5C2LmyBG59hejjoCSNyfV0z
	 zRuHamDNbvJiBCh0+RDS6QLW6fVG8nYbVaTLDyf206cSgHi4yosXPUNRhAdn+UCkCs
	 rJx0k1nT8DQiwwz+Fd1bNirdP1c6OvsPj0LKktzM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260120141958eucas1p152c74f446ca0a743d0c97201bab52ac7~MdkaAnE1i1228112281eucas1p1y;
	Tue, 20 Jan 2026 14:19:58 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260120141958eusmtip1fe1b1758fad5b1441ac5c7c30506c48f~MdkZtClf90169201692eusmtip1y;
	Tue, 20 Jan 2026 14:19:58 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>
Subject: [GIT PULL] more dma-mapping fixes for Linux 6.19
Date: Tue, 20 Jan 2026 15:19:42 +0100
Message-Id: <20260120141942.3674759-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260120141958eucas1p152c74f446ca0a743d0c97201bab52ac7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260120141958eucas1p152c74f446ca0a743d0c97201bab52ac7
X-EPHeader: CA
X-CMS-RootMailID: 20260120141958eucas1p152c74f446ca0a743d0c97201bab52ac7
References: <CGME20260120141958eucas1p152c74f446ca0a743d0c97201bab52ac7@eucas1p1.samsung.com>

The following changes since commit 7f2e8e1d22f6e28edff3782535c16cfbace30902:

  parisc: Set valid bit in high byte of 64‑bit physical address (2025-12-19 13:56:17 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2026-01-20

for you to fetch changes up to c6ccd098807483762ccd726e1498bac5a71d0005:

  dma/pool: Avoid allocating redundant pools (2026-01-14 11:00:00 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.19

- minor fixes for the corner cases of the SWIOTLB pool management (Robin Murphy)

----------------------------------------------------------------
Robin Murphy (3):
      dma/pool: Improve pool lookup
      mm_zone: Generalise has_managed_dma()
      dma/pool: Avoid allocating redundant pools

 include/linux/mmzone.h |  9 +++++----
 kernel/dma/pool.c      | 27 ++++++++++++++++++---------
 mm/page_alloc.c        |  8 ++------
 3 files changed, 25 insertions(+), 19 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


