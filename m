Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6323A3E9C
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211480; cv=none; b=THz8NMtCL3Jg8MpSUj23VbBNjlZQt7rwB747reYMYGHJYW+YzHBPUHv6ZqhRtPY2eVx10LBJ6qKkJNlk4sMh6rwwSW5LVGqzvndhH+M6SpptwR06EqlHBDfl130xTH8UCaFwdQ85iEFCNBjtPFB3LhM3Yzvpz0BHEXsUMJE5i+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211480; c=relaxed/simple;
	bh=1KXny064JMbTKdMn35Ss31JthCSlYjxPv4E4M/PQvm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=KY3oHTIkYz49tvbWkRcHp/oen6wjeEyxPglwnJ6o6Bk1fo0TQyWeOyC9w38M9B5hV/F+RfJBXb5e/E/d8XWYu0ckDSyiXaZSp7gjKqkg54qrYphGhagoTrcLGArpnb8J5OAYJWy8+XZnXDD+fw/h3GAeaan4GJ9jODbyK24O35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HIr45SoA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HIr45SoA"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260611205756euoutp02426894b1b3a045491083ae8149a6ea82~4ImaXFv2O0479504795euoutp02E
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 20:57:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260611205756euoutp02426894b1b3a045491083ae8149a6ea82~4ImaXFv2O0479504795euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781211476;
	bh=dEj+Su9/O0o9wMdUznySdnSbHcj9VmwjMYgGBWcbvSg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HIr45SoAg/PuorUp1Sj/mJ9cBzbOhjMIz+y1n2gDHkbV66lU1ftizkdnlvgt2f9BR
	 7FIv7e9XSyn35wDbHSGPJvUQodTp4XoJTJF3wG/7q8Xnm5EGLwsyptaVcJJOoTlLHC
	 Aj0CG/nCthTN4hOcy6jTaGi5AzOQC0NSTJa4taMo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260611205755eucas1p2a4d68c135aab6b232fa3ce6ac7d8a369~4ImZXrxSg0357603576eucas1p2H;
	Thu, 11 Jun 2026 20:57:55 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260611205755eusmtip20d1d527a5a0cc1c37b844f1884a525a4~4ImZBOy-X1324713247eusmtip2D;
	Thu, 11 Jun 2026 20:57:55 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, Li RongQing <lirongqing@baidu.com>
Subject: [GIT PULL] dma-mapping fixes for Linux 7.1
Date: Thu, 11 Jun 2026 22:57:51 +0200
Message-Id: <20260611205751.1255411-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260611205755eucas1p2a4d68c135aab6b232fa3ce6ac7d8a369
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260611205755eucas1p2a4d68c135aab6b232fa3ce6ac7d8a369
X-EPHeader: CA
X-CMS-RootMailID: 20260611205755eucas1p2a4d68c135aab6b232fa3ce6ac7d8a369
References: <CGME20260611205755eucas1p2a4d68c135aab6b232fa3ce6ac7d8a369@eucas1p2.samsung.com>

The following changes since commit af0c3f05866237f7592219bfe05387bc3bfc99b5:

  dma-mapping: move dma_map_resource() sanity check into debug code (2026-05-18 09:04:59 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.1-2026-06-11

for you to fetch changes up to 6ec91df8aff77e2e8fe3179c1f3fc15b43a40ba3:

  iommu/dma: Do not try to iommu_map a 0 length region in swiotlb (2026-06-09 22:23:42 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 7.1

Three more fixes for the DMA-mapping code, related to PCI P2PDMA, DMA
debug and DMA link ranges API (Li RongQing and Jason Gunthorpe).

----------------------------------------------------------------
Jason Gunthorpe (1):
      iommu/dma: Do not try to iommu_map a 0 length region in swiotlb

Li RongQing (2):
      dma-mapping: direct: fix missing mapping for THRU_HOST_BRIDGE segments
      dma-debug: fix physical address retrieval in debug_dma_sync_sg_for_device

 drivers/iommu/dma-iommu.c | 19 +++++++++++++------
 kernel/dma/debug.c        |  2 +-
 kernel/dma/direct.c       |  2 +-
 3 files changed, 15 insertions(+), 8 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

