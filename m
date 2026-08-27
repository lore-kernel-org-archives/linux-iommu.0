Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AD3C5DA1
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826708; cv=none; b=F4ax68jrGboqc4KlkIC2CwAeqskPW29lLOCjfDL3Ihm2MRBxuaKQjLjP5v6oZrBsGZKDhAGVZHDQwq/8raO/L3a2WnmXrpicSTx1kaqXUNMYiepXaeGy9rViNUi850W9Xd6WZyHVS96/tRmNE3q6hx+Aj7yb6ntKDnGnIEyRulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826708; c=relaxed/simple;
	bh=vRUinhL8Kl69hQDB7Kmeani1hMmmG3jjlapkgspJ2Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=P9dnTSIw9yfZm55THBQp5ga6YOZ5f5kZx0Ci3IXYG4olI2+2WrI7fAVhSuPLIWOMl+q6H4/5dnqHuCMTxodDWi23gP9Oty5DC0LEC98mz8Fv6D6jIMnRSxRG6ggLNXrnkoSxpPSc83Fy9KaOQG/acc+Tdn9YOJYniScA7K/S66A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CUswHnJo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CUswHnJo"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260827103141euoutp02367e6a6b8518c47a07d39d7bf292bd30~Poumpc9Os1531715317euoutp02I
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 10:31:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260827103141euoutp02367e6a6b8518c47a07d39d7bf292bd30~Poumpc9Os1531715317euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787826701;
	bh=1tP05teUxVPqrtuviHpqptvcSsGiCr6FinH/7ktOWxo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=CUswHnJoH4Sbeo8XiNLebbc8rV2zuB6Qhf/yLmX8DQQ7ndTaITf5Tk1J6UzSPyGu1
	 ZtqBPBsfkn4b4xxJh9pR1Ei2rycmIvv1Mzjzt+X+Hz0lHiUYNUHHaYJ6O5I5KiyPOc
	 Ujd5tetLQEoUYKG2rvxeIOjpDmZz9gEYgHDM0OWA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260827103141eucas1p1a97fc08693ac663d8e8382e2ffb7f800~PoumMXccw2646726467eucas1p1S;
	Thu, 27 Aug 2026 10:31:41 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260827103140eusmtip157997614241f2b88e841c3c47ce8d6bb~Poul3U-fU0968509685eusmtip1y;
	Thu, 27 Aug 2026 10:31:40 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
	Graf <graf@amazon.com>
Subject: [GIT PULL] dma-mapping fix for Linux 7.3
Date: Thu, 27 Aug 2026 12:31:26 +0200
Message-ID: <20260827103127.4074178-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260827103141eucas1p1a97fc08693ac663d8e8382e2ffb7f800
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260827103141eucas1p1a97fc08693ac663d8e8382e2ffb7f800
X-EPHeader: CA
X-CMS-RootMailID: 20260827103141eucas1p1a97fc08693ac663d8e8382e2ffb7f800
References: <CGME20260827103141eucas1p1a97fc08693ac663d8e8382e2ffb7f800@eucas1p1.samsung.com>

The following changes since commit 121f9fd1c3083312055126205f3e40b8ee999fe6:

  dma/swiotlb: decouple high watermark tracking from CONFIG_DEBUG_FS (2026-08-13 08:02:35 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-08-27

for you to fetch changes up to 1476cca098f6d3a553fcec6fe9b7d86e15c00b59:

  dma-contiguous: fix truncation of numa_cma / cma_pernuma sizes >= 2G (2026-08-24 15:40:07 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 7.3

- integer overflow fix for kernel cmdline parser for DMA contiguous
initialization code (Alexander Graf)

----------------------------------------------------------------
Alexander Graf (1):
      dma-contiguous: fix truncation of numa_cma / cma_pernuma sizes >= 2G

 kernel/dma/contiguous.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

