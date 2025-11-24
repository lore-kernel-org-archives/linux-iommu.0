Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85AE2C21C4
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004224; cv=none; b=uJzJDAYqgIOHM9NBTBBxLGS4RQJ5pvwdheErR0ae9JXxfAUtd1sdgg+sz3QlFAcR5wxzp8oA5/peEfJ/gIq+VT/ykbNbqn67OEPB/re9LZZTmh3rEQkZU3kikfzX9GDNxPMi3Af9C3WEWn4d0+Tg5UV7P0GZJkj3l+VgBnIiB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004224; c=relaxed/simple;
	bh=TvGQEPehomkhpMiEMdWeXwbg9bARrQ64w7tg479QubU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=hbwWgO2Yrc8+BaCPZkCJSsUMwBbDbTzMMnHC7XZdVRC5ebKd23uaZwwX4GJ1iiOqEla63Zq18PbWl1gxzqYzaZFlIO1G6/UXgFYilPzgQpOpYvE0/Vr/qoHVv48K4gn5nLzRyZAk5LGFXTg6KzT366+2GauZ5stWF0FPW1bLUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bunUVwGO; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bunUVwGO"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251124171014euoutp01c8d2ae4d6e9f3c485fc5b42688f8ff2d~7AHyokrRa2284522845euoutp01C
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 17:10:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251124171014euoutp01c8d2ae4d6e9f3c485fc5b42688f8ff2d~7AHyokrRa2284522845euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764004214;
	bh=GuOlQwatLAHwLUXbJGT0mX7CgwjO6mRY7JNcewUFvkI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=bunUVwGOT+BuAD0GEkNQ5DGbhCero7md8fLrVskQdk6PNdht2i4noQhJi9U7W0+j4
	 gkURzblOqlK98TE260KtWx85uFVwsI2oT0z4skpW7bwb+qrNXsi2Ol5p2lUiFXhxc1
	 2Ja9Ake5qiUeTNZCHPiw6CKM/mQWzsTVp/Kn1qdk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951~7AHyYB02T0903309033eucas1p24;
	Mon, 24 Nov 2025 17:10:14 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251124171013eusmtip1c9e573668ca8a10d4f391c71b45692c7~7AHx_GDoU1613916139eusmtip1B;
	Mon, 24 Nov 2025 17:10:13 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>
Subject: [PATCH] iommu/dma: add missing support for DMA_ATTR_MMIO for
 dma_iova_unlink()
Date: Mon, 24 Nov 2025 18:09:55 +0100
Message-Id: <20251124170955.3884351-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951
X-EPHeader: CA
X-CMS-RootMailID: 20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951
References: <CGME20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951@eucas1p2.samsung.com>

Commit c288d657dd51 added support for DMA_ATTR_MMIO attribute in the
dma_iova_link() code path, but missed that the CPU cache is being also
touched in the dma_iova_unlink() path. Fix this.

Fixes: c288d657dd51 ("iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/dma-iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e52d19d2e833..c92088855450 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2008,7 +2008,7 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 			end - addr, iovad->granule - iova_start_pad);
 
 		if (!dev_is_dma_coherent(dev) &&
-		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
 			arch_sync_dma_for_cpu(phys, len, dir);
 
 		swiotlb_tbl_unmap_single(dev, phys, len, dir, attrs);
@@ -2032,7 +2032,8 @@ static void __iommu_dma_iova_unlink(struct device *dev,
 	size_t unmapped;
 
 	if ((state->__size & DMA_IOVA_USE_SWIOTLB) ||
-	    (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))
+	    (!dev_is_dma_coherent(dev) &&
+	     !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))))
 		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
 
 	iommu_iotlb_gather_init(&iotlb_gather);
-- 
2.34.1

