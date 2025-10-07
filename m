Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7229A30A
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848366; cv=none; b=goRNcPs/2oJb2oA5Sj0d/bCTpcdr8M91MoiSdlH4TDvPTRBHL9hgkJaJdF8RfOeAJQ3tiZ5nffMR+A98Ivct07H0b/QLRhYw1uvWgD9eLGdUJzvDCyXsNVJaRnS5AGInYOAMalrERxrEGjs3Wx+XW3U4FOJ2najsW1OzueGondQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848366; c=relaxed/simple;
	bh=WT64jMbxboNxF1xklb8UQhlFPb4NaVD0os9H5GA0bI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=k9m6S93WixEJrc0U1/Sh4I8jeDkTec4JKmQ8r0s4f2uu9g3o8dYzYHQCo2FjQ7FQNsrvjIgq9+P2nlRbzISArzNstaT85Q2gWQ6z4zZou017FuFXUaQKexQce6ppM5GGjnrbFOlNBkrhKzDMDgU+heZYJnvWKpwJcxyWxdiibfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eYNujc6t; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eYNujc6t"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251007144600euoutp02e3e6fad85c6af0f18671ceb1da59b929~sPMKKFLMP0797407974euoutp02e
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 14:46:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251007144600euoutp02e3e6fad85c6af0f18671ceb1da59b929~sPMKKFLMP0797407974euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759848360;
	bh=1HZe7Sqk0ec7oEcOx8zABBkFNcLSTrCaMp8zzpZHjLE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=eYNujc6taIeEv5sqOaHK/JqAUqPsKYjlhy5ydsDiBfvY9ZQbZ7JH7TFp+5aOu0p0e
	 QNM3WeYanHpYD8BPIYRnWNo1NIWnieVRDqC1gDjmRNAmig16M92SPXLFxx2g/KK+0j
	 lVy05dL01IGUxgdLcWBH4dISB03N2hnhh+9aK2Do=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251007144600eucas1p245415d2578628bca535155cf94679cc6~sPMJsp8mE1148311483eucas1p2f;
	Tue,  7 Oct 2025 14:46:00 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251007144559eusmtip17208b5ff74f14525c83800f11e2b3ed3~sPMJNKhpD2554025540eusmtip1j;
	Tue,  7 Oct 2025 14:45:59 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Petr Tesarik <ptesarik@suse.com>, Shigeru Yoshida
	<syoshida@redhat.com>
Subject: [GIT PULL] more dma-mapping updates for Linux 6.18
Date: Tue,  7 Oct 2025 16:45:45 +0200
Message-Id: <20251007144545.2208636-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251007144600eucas1p245415d2578628bca535155cf94679cc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251007144600eucas1p245415d2578628bca535155cf94679cc6
X-EPHeader: CA
X-CMS-RootMailID: 20251007144600eucas1p245415d2578628bca535155cf94679cc6
References: <CGME20251007144600eucas1p245415d2578628bca535155cf94679cc6@eucas1p2.samsung.com>

The following changes since commit ef3d979b3e270b6a41b6f306bfc442253c41a4cd:

  kmsan: fix missed kmsan_handle_dma() signature conversion (2025-09-17 14:42:36 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-10-07

for you to fetch changes up to 16abbabc004bedeeaa702e11913da9d4fa70e63a:

  dma-mapping: fix direction in dma_alloc direction traces (2025-10-03 08:45:09 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.18:

- two small fixes for the recently performed code refactoring (Shigeru
Yoshida) and missing handling of direction parameter in DMA debug code
(Petr Tesarik)

----------------------------------------------------------------
Petr Tesarik (1):
      dma-mapping: fix direction in dma_alloc direction traces

Shigeru Yoshida (1):
      kmsan: fix kmsan_handle_dma() to avoid false positives

 include/trace/events/dma.h | 1 +
 mm/kmsan/hooks.c           | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
