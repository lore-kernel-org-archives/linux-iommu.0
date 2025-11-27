Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CF265623
	for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764281105; cv=none; b=q+yX31LoCfblZDHYH6SsbByfUBnEHhgUUIEwCs79v/Zveln+2F/9iesxvk9ahLXJc6kbh1nyCtY/m+8mFUbEgW4p9Hm3JVjvLZQ0FJvUoNN9QWxk9ON6hZoQmr/VkBY2aH27W60XvJzJ1CIqm731xc0auDw0cBQqN9L2N848kHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764281105; c=relaxed/simple;
	bh=GzkRCAtQ8+qxNm/vz/YuV08ZjiXsccbTG9sJEBZprrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=keXsAlXuRFTOmbCHlQp4nvLynEf2yV+n/ZkLWT1dlExKCaEeQxFT/WIzg8miRQnX2iw+H3Ld6A/Ne+LsxG63E5S7nBPkdZnJlVg2Kogz+6NAbyRTm8tPGHDsDaSocPE/5BOxGHrB06MvuLZzbEkzntkRjcadp9J6JOO1FC+g5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Us3nyEoq; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Us3nyEoq"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251127220500euoutp020def5ae0b237b87e9e8d3fffb6c99489~7-FAyF7W82679526795euoutp02b
	for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 22:05:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251127220500euoutp020def5ae0b237b87e9e8d3fffb6c99489~7-FAyF7W82679526795euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764281100;
	bh=CDqBtyciewMDhT0xG4pII9J25DEUr8JhsePC/5HkVno=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Us3nyEoqQXihhjTjKtuVNIT4ZEhNPih5zHpud86le9SoVVs3aBtc+/Ct+rHG9kJIA
	 aIA8LF9khRCWH+Q/EL9QePB9cOlWrTvIUcuHz1warMVtUgNLCdc6iHiCKSRlIJ9mfa
	 CzQGAcfgZkPNagTHTkXqbF6xeNkyH1VlNWvjwqu0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251127220500eucas1p2434659b2b064b09a5fc250f4ea1cc402~7-FAcFz8v1572615726eucas1p2d;
	Thu, 27 Nov 2025 22:05:00 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251127220459eusmtip13241c25605759c9db508e7e05cc06918~7-FAI3fzf0238502385eusmtip1q;
	Thu, 27 Nov 2025 22:04:59 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>
Subject: [GIT PULL] more dma-mapping fixes for Linux 6.18
Date: Thu, 27 Nov 2025 23:04:31 +0100
Message-Id: <20251127220431.1614800-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251127220500eucas1p2434659b2b064b09a5fc250f4ea1cc402
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251127220500eucas1p2434659b2b064b09a5fc250f4ea1cc402
X-EPHeader: CA
X-CMS-RootMailID: 20251127220500eucas1p2434659b2b064b09a5fc250f4ea1cc402
References: <CGME20251127220500eucas1p2434659b2b064b09a5fc250f4ea1cc402@eucas1p2.samsung.com>

The following changes since commit a50f7456f853ec3a6f07cbe1d16ad8a8b2501320:

  dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope (2025-11-05 13:43:41 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-11-27

for you to fetch changes up to d0d08f4bd7f667dc7a65cd7133c0a94a6f02aca3:

  dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings (2025-11-26 21:47:13 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.18

- two last minute fixes for the recently modified DMA API infrastructure:
a proper handling of DMA_ATTR_MMIO in dma_iova_unlink() function (me) and
a regression fix for the code refactoring related to P2PDMA (Pranjal
Shrivastava)

----------------------------------------------------------------
Marek Szyprowski (1):
      iommu/dma: add missing support for DMA_ATTR_MMIO for dma_iova_unlink()

Pranjal Shrivastava (1):
      dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings

 drivers/iommu/dma-iommu.c | 5 +++--
 kernel/dma/direct.c       | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
