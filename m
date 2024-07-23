Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA418D;
	Tue, 23 Jul 2024 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693167; cv=none; b=UM5ZNCzDw/sfpL0tWM4tjJKKkNq2pzWxl0QqDMhP2kYelKmOOUkT0UbAYYZHehNFAsKYQFYvEEgAy2vDdwEJKtgudPxd1Uoi6l4H3XFG8kYKhrzCD3GKfNCiG7q7glWVmE5eBL/F830p+y8BnE47fVEO1b0tr4FAFpsFKo3PPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693167; c=relaxed/simple;
	bh=hUpRG9prcLEfrhKc4wk8Ca4OfC9JbHB9kXNoM+JLBuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5WH4Gm4FuhWN1YlKYFGPH/JoxCx5LY1zaO5Pee3/8B5tde/qXRj891+VrIikFaLPOWNY6xWZpZW+EFG/RZoSB02P9e+okYmH6RRdOWxvJn/ksmoso7Fh9KlyFsvd9+b0CncsF9okA6KBqIPMqTgbfzWzjYwNM6yszLHiMRrlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W7d3i5OX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W7d3i5OX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=say37rz6UwGJoLUcC3X9YMitxCVJthK2MXcYybyR37c=; b=W7d3i5OXRRRg2K/9y1UWSJzImZ
	77FLVMqNKtNUXSkUJSFhzxBT61EwuSYTbu1VkRlP0iitHhUxK1U9XbTDj1fnboNFaUnDhP4bC0qVD
	RBJle5Qz+AIWck0Vpr51XFBt7yrzCZevMUqeaeTxtCQEH2ubP9rJME/ySoUIBOOQUHWqKmlr6e4cn
	mcKn1heDnO1SHVpws+r6s+8pd1vlvwmZOA34U6DARSU/nt/hU4w0qdj0WD2lPiVmgkN16poAMkcX5
	pYttCbcEEN5BdAGs43X7s7SUM5w0egHQPzDaTIXE85p3+RKZeWV2hOOVtN3oqYhYeran2WvAzgi2F
	umGeYC9g==;
Received: from [64.141.80.140] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW32b-0000000AvOs-3xds;
	Tue, 23 Jul 2024 00:06:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dma-mapping: don't return errors from dma_set_min_align_mask
Date: Mon, 22 Jul 2024 17:05:55 -0700
Message-ID: <20240723000604.241443-2-hch@lst.de>
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
 include/linux/dma-mapping.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f693aafe221f2c..cfd6bafec3f944 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -575,13 +575,12 @@ static inline unsigned int dma_get_min_align_mask(struct device *dev)
 	return 0;
 }
 
-static inline int dma_set_min_align_mask(struct device *dev,
+static inline void dma_set_min_align_mask(struct device *dev,
 		unsigned int min_align_mask)
 {
 	if (WARN_ON_ONCE(!dev->dma_parms))
-		return -EIO;
+		return;
 	dev->dma_parms->min_align_mask = min_align_mask;
-	return 0;
 }
 
 #ifndef dma_get_cache_alignment
-- 
2.43.0

