Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4B18638
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336047; cv=none; b=oI27otymo8RafiykYOe8Wil0Jfz8rjS5AGz2yincNTAgea6sMxea6AOONCaoHpCZdI3h2Xp5O1Kiff5le1IeEgvRpkAk9sfHvU13RV3nwLg+iDVVXSIoX96od1Zhn0tdzDEB38Gv7lsDrh0+r40efloIUn+3d626AwC8ci7J5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336047; c=relaxed/simple;
	bh=orX6ly2z6wNGyHOE3fvFCWfugK1XaM8ViEHRB/U+dIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I5Ydj5U4qEjBOEPjnK2DYetE0gag6eQSCp7z1QBzhJ2Aw59wHyXzNb43OVlwLEw9fCs41slZAq4syXNWCpjYAMgnOY33gbncsHorP3i6aVfsmZ+JP3l6zQ/yHN07ujhuDZFWLz16aOL1dtZcFMwOoUl42kNWheguaKBCpjKhwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yIwXHdv6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yIwXHdv6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HI97ey3OeTExzj4hVshcjUOrQBHIazT4LIRQzuRP0iU=; b=yIwXHdv6t93Ej62kg0MOL9zicO
	5cAUo1QxN2rIVTxOFhZYlVr9X/19pNwm7KNjNcdqT+ptxiIENGeFSa6+nMbFJFuSK4O9HVkll1Kwh
	NgDDGCWfDDUvaun3ZYkrqwRXNX7c7QMvog5W6e63zidzdob/UWCEXJgwzCCjn7tKGTtoPXbQnUhDF
	rKftdIPzG6sICdNHjKU3RYlxIJzapAebRQgLhJ5u7udh/h8s2PES3qY09kZr29+cbXlZf4Fc00UjS
	yFT64eo8Oq6TrBFQ77heW83EQUXS8A3GRpdMkPq/eB1DWcFWccnmfdjti4Kypxd/B3/evh5im9gRZ
	LxNcK6KA==;
Received: from 046075014122.atmpu0009.highway.a1.net ([46.75.14.122] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1stj0a-00000007WrT-1i4A;
	Thu, 26 Sep 2024 07:33:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: sean.anderson@linux.dev
Cc: m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com
Subject: [PATCH] dma-mapping: fix DMA API tracing for chained scatterlists
Date: Thu, 26 Sep 2024 09:33:48 +0200
Message-ID: <20240926073348.1839850-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

scatterlist allocations can be chained, and thus all iterations need to
use the chain-aware iterators.  Switch the newly added tracing to use the
proper iterators so that they work with chained scatterlists.

Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
Reported-by: syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com
---
 include/trace/events/dma.h | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index f57f05331d7385..569f86a44aaaf4 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -176,9 +176,9 @@ TRACE_EVENT(dma_free,
 );
 
 TRACE_EVENT(dma_map_sg,
-	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 int ents, enum dma_data_direction dir, unsigned long attrs),
-	TP_ARGS(dev, sg, nents, ents, dir, attrs),
+	TP_ARGS(dev, sgl, nents, ents, dir, attrs),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
@@ -190,17 +190,17 @@ TRACE_EVENT(dma_map_sg,
 	),
 
 	TP_fast_assign(
+		struct scatterlist *sg;
 		int i;
 
 		__assign_str(device);
-		for (i = 0; i < nents; i++)
-			((u64 *)__get_dynamic_array(phys_addrs))[i] =
-				sg_phys(sg + i);
-		for (i = 0; i < ents; i++) {
+		for_each_sg(sgl, sg, nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		for_each_sg(sgl, sg, ents, i) {
 			((u64 *)__get_dynamic_array(dma_addrs))[i] =
-				sg_dma_address(sg + i);
+				sg_dma_address(sg);
 			((unsigned int *)__get_dynamic_array(lengths))[i] =
-				sg_dma_len(sg + i);
+				sg_dma_len(sg);
 		}
 		__entry->dir = dir;
 		__entry->attrs = attrs;
@@ -222,9 +222,9 @@ TRACE_EVENT(dma_map_sg,
 );
 
 TRACE_EVENT(dma_unmap_sg,
-	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 enum dma_data_direction dir, unsigned long attrs),
-	TP_ARGS(dev, sg, nents, dir, attrs),
+	TP_ARGS(dev, sgl, nents, dir, attrs),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
@@ -234,12 +234,12 @@ TRACE_EVENT(dma_unmap_sg,
 	),
 
 	TP_fast_assign(
+		struct scatterlist *sg;
 		int i;
 
 		__assign_str(device);
-		for (i = 0; i < nents; i++)
-			((u64 *)__get_dynamic_array(addrs))[i] =
-				sg_phys(sg + i);
+		for_each_sg(sgl, sg, nents, i)
+			((u64 *)__get_dynamic_array(addrs))[i] = sg_phys(sg);
 		__entry->dir = dir;
 		__entry->attrs = attrs;
 	),
@@ -290,9 +290,9 @@ DEFINE_EVENT(dma_sync_single, dma_sync_single_for_device,
 	TP_ARGS(dev, dma_addr, size, dir));
 
 DECLARE_EVENT_CLASS(dma_sync_sg,
-	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 enum dma_data_direction dir),
-	TP_ARGS(dev, sg, nents, dir),
+	TP_ARGS(dev, sgl, nents, dir),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
@@ -302,14 +302,15 @@ DECLARE_EVENT_CLASS(dma_sync_sg,
 	),
 
 	TP_fast_assign(
+		struct scatterlist *sg;
 		int i;
 
 		__assign_str(device);
-		for (i = 0; i < nents; i++) {
+		for_each_sg(sgl, sg, nents, i) {
 			((u64 *)__get_dynamic_array(dma_addrs))[i] =
-				sg_dma_address(sg + i);
+				sg_dma_address(sg);
 			((unsigned int *)__get_dynamic_array(lengths))[i] =
-				sg_dma_len(sg + i);
+				sg_dma_len(sg);
 		}
 		__entry->dir = dir;
 	),
-- 
2.45.2

