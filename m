Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433FB632;
	Tue, 23 Jul 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693168; cv=none; b=eR0D1g852OQ6JKGNpxQyPgSAO11PnvCzG7cHroBy+dKFIqjw983W0+PiOiwrOMkCHN/8HYQyzKmS/BYZqd3SfbnRVRY1vql+R9hqm6063PNjAD6NMHal61lJYAlJSL/i3O70aOSgsU6Ctz/IbLYExK//nVTShIAgSK4R3PQfIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693168; c=relaxed/simple;
	bh=2znBMi6/ukb7RDHyUBj2FrddjBERfQbtAx5PuL+CWP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzQtdP9JCN3XBRfNdjRlZyI6AF1ztkREA5acCELFBiF1hyWY5+zfBisQ5D2VuIWysBJQ8cYzMdhxCFFcQGh1X2ckJEtlUam6X9t/qwjETfPrHYQtYe9Nwn3CCTQFp1YwgM/wZTuHS3/XKBQ8lKJHdC2kMI6wiOSQZzLTHFVuJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K51V2oQz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K51V2oQz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8WBmee4K4GiP7s0S+0yIczKiisb8UemVXcb28N5tDPo=; b=K51V2oQzZrzLpIiTr/fXEY2mR2
	4SV/i87UocwIzrSc6W0y69UOV0tRf6JCn+vzviIVbhf9m0AwlVqEi6EHnLQLdZX1C44bCC1yEstEu
	QU265KjEbiU4Q6BYY5HRZRNzp+3FVmfIdGXK/siINy7ewOtTKwcNojKRQDOuZ0sCds0VZYHEj4v8N
	L70bW50/pp5BSLsMbyNKmdmF39uDvFN+IKY521j9ocMDlQUccymA8xPWMVH4Egs09bOTdXTYJdiIh
	SNpM27/cX+F3gCxD1H+3iPOUHyTpOCNeIHW63OejQVHBYa6NVxw+qAcJxmbTyPfU2yuflzHJ6FeeU
	fFRFTJbQ==;
Received: from [64.141.80.140] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW32c-0000000AvOz-2m9q;
	Tue, 23 Jul 2024 00:06:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dma-mapping: don't return errors from dma_set_seg_boundary
Date: Mon, 22 Jul 2024 17:05:56 -0700
Message-ID: <20240723000604.241443-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723000604.241443-1-hch@lst.de>
References: <20240723000604.241443-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

If dev->dma_parms is not allocate that indicates a grave bug in the
implementation of a DMA-capable bus.  There isn't much the driver can
do in terms of error handling, so just warn and continue as DMA
operations will fail anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index cfd6bafec3f944..6bd1333dbacb9b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -559,13 +559,11 @@ static inline unsigned long dma_get_seg_boundary_nr_pages(struct device *dev,
 	return (dma_get_seg_boundary(dev) >> page_shift) + 1;
 }
 
-static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
+static inline void dma_set_seg_boundary(struct device *dev, unsigned long mask)
 {
-	if (dev->dma_parms) {
-		dev->dma_parms->segment_boundary_mask = mask;
-		return 0;
-	}
-	return -EIO;
+	if (WARN_ON_ONCE(!dev->dma_parms))
+		return;
+	dev->dma_parms->segment_boundary_mask = mask;
 }
 
 static inline unsigned int dma_get_min_align_mask(struct device *dev)
-- 
2.43.0

