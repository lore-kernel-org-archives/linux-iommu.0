Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FF262A6
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766419429; cv=none; b=AMprjqtk+Bf1ovVDc+8KqfWHR4nZeqBXCi/HeWWVHA/h0XM2r+X/+N81JSPf5c882dr6dqUmeTJjAYs2mmMnYQ/XkoYhoA4WfGKah8EjcD2KHO5WDaSmLvjJzoCRfGVUpV/lmM4K2zpKa+Np4yhoJe5FFQ02Ktfx4C4IFOByZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766419429; c=relaxed/simple;
	bh=do0oPOwp5PladKBNV5k5ut3y9+56iDVbMd4+qcZn1cY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=fhsnElXqPhEKFHrlwWjCA/vfALuyNBtCPOa8pX2tAijVyUhankhum3kAz8+tFKYARnq1LOsqgDb0vq2JuBd02JoCmb6RNRtJ4OsGnNHitghyQ4a5X1dBLjXqM/4TD6e2of1WyY0vr6BM0ymfackPxzbjBPk91mSSHx1xQuZUsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JDeGic0P; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JDeGic0P"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251222160344euoutp01db9a067e0865b01947ef2e75af7c025e~DlRumMCFV1734617346euoutp01P
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 16:03:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251222160344euoutp01db9a067e0865b01947ef2e75af7c025e~DlRumMCFV1734617346euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766419424;
	bh=o/8nGrsuewPWX4y/kKQOn2uLaTCVMj9zTfcF+w/NXlY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=JDeGic0PpXv0StuN55727gWWoB59fCGimzWkD8KlL7pY6PT3o111uykbvAuyKKDBh
	 /6f8JyOuj9jfOxLLMoxt5ypYmMEmK4HxtocTBNiY2RUCavJCyQcK7lC7CtEXyogPcW
	 naO72ULzGz2UFoweN1Qv3ltJKUMkHAtQQMXvbVgo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251222160344eucas1p12182e7b47456263b0b67309f6c674ac4~DlRub3Zv41361213612eucas1p1Z;
	Mon, 22 Dec 2025 16:03:44 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251222160344eusmtip13e22208aa6bd60477462cab85b50e907~DlRuE-8XZ2186121861eusmtip14;
	Mon, 22 Dec 2025 16:03:44 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: [GIT PULL] dma-mapping fix for Linux 6.19
Date: Mon, 22 Dec 2025 17:03:28 +0100
Message-Id: <20251222160328.2523773-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251222160344eucas1p12182e7b47456263b0b67309f6c674ac4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251222160344eucas1p12182e7b47456263b0b67309f6c674ac4
X-EPHeader: CA
X-CMS-RootMailID: 20251222160344eucas1p12182e7b47456263b0b67309f6c674ac4
References: <CGME20251222160344eucas1p12182e7b47456263b0b67309f6c674ac4@eucas1p1.samsung.com>

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2025-12-22

for you to fetch changes up to 7f2e8e1d22f6e28edff3782535c16cfbace30902:

  parisc: Set valid bit in high byte of 64‑bit physical address (2025-12-19 13:56:17 +0100)

----------------------------------------------------------------
dma-mapping fix for Linux 6.19

- important patch for recent rework of DMA API infrastructure, which
fixes boot failure of parisc systems (Leon Romanovsky)

----------------------------------------------------------------
Leon Romanovsky (1):
      parisc: Set valid bit in high byte of 64‑bit physical address

 drivers/parisc/sba_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


