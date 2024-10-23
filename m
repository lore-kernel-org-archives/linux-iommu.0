Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91314375D
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661121; cv=none; b=t7VZ6NbQ//2fsAprHRXgAJZLRN1y7rPtgVXOckmd5RhWc+GOZq1cKrYLTtcd4Dg3iJvWNWhomiIdsPo6S2GSr7EmqEVV31+DTTWhv+X3p/txeSDgDqPhkuaUOWEPgqiFrfpZerFGNKNokL5o+/C8Uy4WM6vTlqwm0CLo2uDzF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661121; c=relaxed/simple;
	bh=cuyVeh03LYArk4l06oT2XxGoa7yUEjTHqxb3bATuWzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhDXglu+viBXOLVUC7AikawABzwBOTbaahQagsmvCXiFtD5agPXkbzvUCZX0Tz7fbZs6KjQGygR1Fh6X1vuzhIcgOJHszEAlULFOnBZdB8WUcW6owcu80pg149t1TC7N6hwwtErNeSJ0Ynwlui7chS/hLbNmbeMg/FJ0qMvYNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wtNU5Wyk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wtNU5Wyk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7T1Gxe3l689stTGbIhiABkTw4giJJkAErsUo+JKXDFs=; b=wtNU5WykYMVK38o8uW1mMYBktZ
	wfMXPDTbr4tSxLXoKLsvDAUdWmNHjvMBqIczGG50aswBrR4bb4IP8ZQmH+6hjDPwT4fUyBJPBDoZB
	E037fIG6bpCNa1jDxJuPwqTfBNSbGwcduCcfxGXKOjfSznEEV61vseq7yIVwnddN6ysl/hzp/UAgV
	1/9L08s0abMO2Ebl3fwaHwKU4hKsNsInNFnywK/+1E4dfO9lWvGvGEcuZayUalagLbiOsJm0JgfyT
	PLLSD5GjUdgVHLnEZxMCYUpWPmsgwLQuUvMvD3rVus125yySg+mJ5oGJ/iXNSrtKaOK3TqWGrGhDc
	dBYzMv7g==;
Received: from 2a02-8389-2341-5b80-8c6c-e123-fc47-94a5.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c6c:e123:fc47:94a5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Trz-0000000D2fb-2ovg;
	Wed, 23 Oct 2024 05:25:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/2] dma-debug: remove DMA_API_DEBUG_SG
Date: Wed, 23 Oct 2024 07:25:04 +0200
Message-ID: <20241023052511.309695-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023052511.309695-1-hch@lst.de>
References: <20241023052511.309695-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The scatterlist validity checks are pretty simple and cheap, perform them
unconditionally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/Kconfig | 17 -----------------
 kernel/dma/debug.c |  2 --
 2 files changed, 19 deletions(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4c0dcd909121..31cfdb6b4bc3 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -260,23 +260,6 @@ config DMA_API_DEBUG
 
 	  If unsure, say N.
 
-config DMA_API_DEBUG_SG
-	bool "Debug DMA scatter-gather usage"
-	default y
-	depends on DMA_API_DEBUG
-	help
-	  Perform extra checking that callers of dma_map_sg() have respected the
-	  appropriate segment length/boundary limits for the given device when
-	  preparing DMA scatterlists.
-
-	  This is particularly likely to have been overlooked in cases where the
-	  dma_map_sg() API is used for general bulk mapping of pages rather than
-	  preparing literal scatter-gather descriptors, where there is a risk of
-	  unexpected behaviour from DMA API implementations if the scatterlist
-	  is technically out-of-spec.
-
-	  If unsure, say N.
-
 config DMA_MAP_BENCHMARK
 	bool "Enable benchmarking of streaming DMA mapping"
 	depends on DEBUG_FS
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index e1da50a36bdc..2717f1c22510 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1159,7 +1159,6 @@ static void check_sync(struct device *dev,
 
 static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 {
-#ifdef CONFIG_DMA_API_DEBUG_SG
 	unsigned int max_seg = dma_get_max_seg_size(dev);
 	u64 start, end, boundary = dma_get_seg_boundary(dev);
 
@@ -1180,7 +1179,6 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 	if ((start ^ end) & ~boundary)
 		err_printk(dev, NULL, "mapping sg segment across boundary [start=0x%016llx] [end=0x%016llx] [boundary=0x%016llx]\n",
 			   start, end, boundary);
-#endif
 }
 
 void debug_dma_map_single(struct device *dev, const void *addr,
-- 
2.45.2

