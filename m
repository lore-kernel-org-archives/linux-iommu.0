Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DF4A68AD
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543861; cv=none; b=RT1v/EHcVSjD6NpRDS+gDxEMdbxrCqt0dIIev+vYhP9Fgh7GYusb9Tv+C6Xp/Qdr9Gqz+Jn4u80kIRyJ0QClNjcsJbDNSazb+HEZzyuXlSu4U3n7qUbhGr5/k+xzb5bs8vrx7SEuXw7uAEpiUFVHXvWTgkKZl4/zC0HXYupwl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543861; c=relaxed/simple;
	bh=PyGpHovG2GVwa9YAK09Xz2EUqL/+PMGU2xO2YXv5xH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=DvCc4MZNVFoZYWmRq3jW+6wlqxXXcGjRdTkmfU3k4jEC1h57VQ7w/aENqqE01lkoAgHcl02kaD7TF2rmn+2mnYJbzni0fTQPtKAGWYpOIi7Yh+gGuiHSo38xZBGCXh8J7vNf6qvZdYdYMH1tJRgOWDmSXsCsJHfNSqzCGegZbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gzYWUVlx; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gzYWUVlx"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261009110401euoutp01500c55e172b69af1bb43350ee44517c3~c16HIfGoV0072500725euoutp01G
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 11:04:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261009110401euoutp01500c55e172b69af1bb43350ee44517c3~c16HIfGoV0072500725euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791543841;
	bh=IOJmWjKAq0AWIt2/KFdzBAY525uiSoVkQwuNEs5hc2Q=;
	h=From:To:Cc:Subject:Date:References:From;
	b=gzYWUVlxxBsbNbEGUQeRAl2vmrecXtOc39gyKfvPQdDy2axEbyhw/TFRSuE+b5j7i
	 3fbZsobAy8rHG8EakjvEaZjNn4G0zFFB2VchEjW5UAc7Mg5zTgIUrMsbyJBeiP9Ek+
	 owdJeXl8DKdZDQO/MHnivwOE92FWKqJXvaX8t4Nw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261009110401eucas1p18f48109c4922503c4a371dee94aac268~c16G35TCe2428424284eucas1p1-;
	Fri,  9 Oct 2026 11:04:01 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261009110401eusmtip2dd49c0c16c77c93239428917d8e7a295~c16GkDdSe0698206982eusmtip2d;
	Fri,  9 Oct 2026 11:04:00 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Peng Fan
	<peng.fan@nxp.com>
Subject: [GIT PULL] 2nd dma-mapping fixes for Linux 7.3
Date: Fri,  9 Oct 2026 13:03:46 +0200
Message-ID: <20261009110348.43841-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261009110401eucas1p18f48109c4922503c4a371dee94aac268
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261009110401eucas1p18f48109c4922503c4a371dee94aac268
X-EPHeader: CA
X-CMS-RootMailID: 20261009110401eucas1p18f48109c4922503c4a371dee94aac268
References: <CGME20261009110401eucas1p18f48109c4922503c4a371dee94aac268@eucas1p1.samsung.com>

The following changes since commit 55a8e1451869233db837a97e8f3cbf9983bc8678:

  x86/mm: Don't force unencrypted DMA for IOMMU-backed devices (2026-09-11 10:30:50 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-10-09

for you to fetch changes up to 911655ab1dfb9d526978a75df3b210132620d30a:

  swiotlb: fix default_swiotlb_limit() for non-growable default pool (2026-10-08 12:13:28 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 7.3

Two more fixes for the corner cases in the DMA-mapping SWIOTLB code
(Peng Fan and Marek Szyprowski).

----------------------------------------------------------------
Marek Szyprowski (1):
      swiotlb: fix default_swiotlb_limit() for non-growable default pool

Peng Fan (1):
      iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO in iommu_dma_map_phys

 drivers/iommu/dma-iommu.c | 4 ++--
 kernel/dma/swiotlb.c      | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

