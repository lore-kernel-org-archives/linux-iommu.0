Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008484;
	b=L7zIYiAfcKwS6De9Dp3zXUXMxYdQL85cTS4j/+79UrdohMSSqWXx7BTcmRTl0/6Ko/H7
	 GkA5qDs3L4t/VKKbuqaLOwFgjM1C+ZVt1g07jmomxFNiYtZKwsWPvezAExNwopG2zNweD
	 pKJLfbAXJt6AQ1nook+N2p0fUIb2ykabqvP1w0Gz7HTW/MUT2hXmk8wFl4flvFC/pr1sI
	 77/MMmTVYNA/nDWROVt+Pcd5H+IzrPPgrIcDigSSibH8tgBccaolERiukGDXUX1q////a
	 nnNevz4ppLpDXziO78sr0icuesapMObHdA3h7nnHQmwsC34N2aHZwIYkQd0AJTtaGcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008484;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=oFSOqqmv4ObDkCg4ConnZ6gyRo7BgJ30zlOlybbBi8Q=;
	b=pq2QQB50mGFiRbvRiClheNos1ypOUasM5TDzggriFQrlL0rqTr689S3ZzvwxJOgwk7bO
	 sDyN1gdOPyepOkz2qv/of6YlF+lsa1ebEDtg0Q0oZGl2cMF4C8PQDtLxAuPs5+dRctCO4
	 pMHT4G5snTt23wI56YYVmZl5Iws9lCZOnTYmzRO1/0L/SRH0qV6+5oApUGSzsu6KINRU4
	 PRxixeEYhN5XEZeyEUMgjSuzA9L4z5ge1meJhGaS/kME9oM90dAnqC/+abkV9s8dLIbJj
	 R+PZTEMFUNvMMTPUyRkf161OjVJeAEBr1PTRmRmJYvczneuGSlWMiVaNdlqmaUS5uKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=q+UuW+m7;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969160A3803
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 09:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E969160A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=q+UuW+m7
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261026095435euoutp012cbf43e39a52ed210256cabda56ddd5d~iC7V2spgE0332303323euoutp01D
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 09:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261026095435euoutp012cbf43e39a52ed210256cabda56ddd5d~iC7V2spgE0332303323euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793008475;
	bh=oFSOqqmv4ObDkCg4ConnZ6gyRo7BgJ30zlOlybbBi8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+UuW+m7e+nYHj0spnYWoVX7TMef27suU6MuNu5kgzitBrE9g2xrP0qEloNVI1wWx
	 NgmhtVfcJUnQ8NXVdlVzP7esxhEZOrP3Fq/Rs4iXhutIvwEVtpWnoaIcV89wRT2oJl
	 DorwYArboUaIP+EkRw7DcFBHFv79cnk8Sh5wWppc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261026095435eucas1p1f2245a6982ef110340685dc66be53590~iC7Vo6vbO1648416484eucas1p1s;
	Mon, 26 Oct 2026 09:54:35 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261026095435eusmtip2e956c1473294e45f88e7231e70c47818~iC7VSL1Na1301813018eusmtip22;
	Mon, 26 Oct 2026 09:54:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Claire Chang <tientzu@chromium.org>, stable@vger.kernel.org
Subject: [PATCH 2/5] dma: swiotlb: Serialize restricted DMA pool
 initialization
Date: Mon, 26 Oct 2026 10:54:13 +0100
Message-ID: <20261026095423.966856-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026095423.966856-1-m.szyprowski@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261026095435eucas1p1f2245a6982ef110340685dc66be53590
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026095435eucas1p1f2245a6982ef110340685dc66be53590
X-EPHeader: CA
X-CMS-RootMailID: 20261026095435eucas1p1f2245a6982ef110340685dc66be53590
References: <20261026095423.966856-1-m.szyprowski@samsung.com>
	<CGME20261026095435eucas1p1f2245a6982ef110340685dc66be53590@eucas1p1.samsung.com>

Multiple devices can share the same restricted DMA pool, in which case
the io_tlb_mem structure is allocated and initialized by the first
device attached to it and stored in rmem->priv. To avoid the potential
race, serialize the check and initialization of rmem->priv with a mutex.

Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
Closes: https://sashiko.dev/#/bug/linux-6fda7589-591d-4a68-b6e1-b1561f867319
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/swiotlb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2c57b49ac7c0..db731f7891b7 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/pfn.h>
 #include <linux/rculist.h>
 #include <linux/scatterlist.h>
@@ -1986,10 +1987,12 @@ void swiotlb_free_from_pool(struct device *dev,
 	swiotlb_release_slots(dev, tlb_addr, pool);
 }
 
+static DEFINE_MUTEX(rmem_swiotlb_mutex);
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-	struct io_tlb_mem *mem = rmem->priv;
+	struct io_tlb_mem *mem;
 	unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
 
 	/* Set Per-device io tlb area to one */
@@ -2003,8 +2006,10 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	/*
 	 * Since multiple devices can share the same pool, the private data,
 	 * io_tlb_mem struct, will be initialized by the first device attached
-	 * to it.
+	 * to it. Serialize this, as devices may be probed concurrently.
 	 */
+	guard(mutex)(&rmem_swiotlb_mutex);
+	mem = rmem->priv;
 	if (!mem) {
 		struct io_tlb_pool *pool;
 
-- 
2.43.0

