Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304134;
	b=W+I4/v55J7znymdJK1AU4QpMZ1/2EJ61fWPh0J6AxcmDAgI6QOIOjmGMVRP7x/+QJfeV
	 C8VzH3pDnqMoOaCI3L+N69CXh1GNlyO1RvB4lv7NGuJBKNxJawqp2kg9ZnacvkUrzYr9B
	 l5PZA2R8goAs7Ne/S9G1ybBo5GIRPHslVwRHJnMI6rRH1vFTh9cgnvm4rDJ6JciHLU6mX
	 YgXFDK145b0H3mxPlW3nXmtU8oA55GTtDths6pQTkk8WkyAfFqSKCQEvPBND/wFs6mCmV
	 +XBcAddcyjCntRs1R9UqmpwyRoLusH7n9xF9/YHybhyg5pOkMQn2AxcyCxvyYNUGPUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304134;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=sqRiL704sMluKdRvVQ4zewuJOHUjmkrlRuUBPJbDhvE=;
	b=UMV1pgBpY9BKvn2xUX3K9ulNzdR52JJS8IjRG7mKceN54+wEATghlJcrAiiwmWTkCZnD
	 VQDpqA+CF40R6sKzd30ZRqYlvP4Hkg+8/AzQ821BRSsmMfqpEDyA7Ib69zjG8N7JZNw52
	 h1EvHGSJInwXsTD/CkCkPCylXjblEdKQeZmjysLk5N1YH2+2NZ2e0526na/I8SO+gqp/g
	 lPsszbFIQRO1Rm8QKHP/4VEWImwVO8lSIbNf8gqQmzHJqRN9yDr0Abl0wgzYoDm+5+95F
	 I3MHTmDzdMvs2tzYjZtErsT19NVsb5flkq52U+oFHU9kduFmpwL05mbAZTQFb65w37Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=FpXtBNyr;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60D606B178
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A60D606B178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=FpXtBNyr
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094850euoutp02bae11d5aaee9eba4435a8c9a70490e54~mphmyDlNK2814928149euoutp02h
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261110094850euoutp02bae11d5aaee9eba4435a8c9a70490e54~mphmyDlNK2814928149euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304130;
	bh=sqRiL704sMluKdRvVQ4zewuJOHUjmkrlRuUBPJbDhvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FpXtBNyrezZfF6oyue5zAawp4jLDjRTwygkCkHhIeszh8AzNM/iMTfzWnEbB5DifT
	 EAuzg89QUt/XAnUY50J7crsp+Sh9nh6y1UXoD71jumZtYusAy5g1/L2AVTNNkEOhXk
	 AaJGJ3ssB2mp/U1px80mNer7D/JHQmBDyjsKBPSU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094850eucas1p1f10fa1473aca341473077f60a088b490~mphmWzE0-1105411054eucas1p1h;
	Tue, 10 Nov 2026 09:48:50 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094849eusmtip17ea40665ecac93b7743c35f7f2f57ae7~mphlniUmo0320503205eusmtip1a;
	Tue, 10 Nov 2026 09:48:49 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas
	Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
	Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 4/7] powerpc/mm: handle highmem pages in
 arch_dma_prep_coherent()
Date: Tue, 10 Nov 2026 10:48:24 +0100
Message-ID: <20261110094830.2081847-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110094830.2081847-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094850eucas1p1f10fa1473aca341473077f60a088b490
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094850eucas1p1f10fa1473aca341473077f60a088b490
X-EPHeader: CA
X-CMS-RootMailID: 20261110094850eucas1p1f10fa1473aca341473077f60a088b490
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094850eucas1p1f10fa1473aca341473077f60a088b490@eucas1p1.samsung.com>

arch_dma_prep_coherent() performs the cache maintenance on the address
returned by page_address(). On 32-bit powerpc with CONFIG_HIGHMEM that
is NULL for a highmem page which is not kmapped, so the flush would
operate on the wrong virtual range and leave the dirty lines of the
buffer in place.

The generic DMA code may pass highmem pages to this hook:
dma_direct_alloc() handles a highmem page returned by
dma_alloc_contiguous() by forcing the remap path, which calls
arch_dma_prep_coherent() on that page before creating the uncached
mapping. This cannot happen on powerpc today only because it does not
select HAVE_DMA_CONTIGUOUS, so dma-direct never gets a highmem page
there, but nothing in the hook's contract rules it out.

Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
one at a time. Without CONFIG_HIGHMEM it does the same
flush_dcache_range() on the linear mapping as before.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/powerpc/mm/dma-noncoherent.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 30260b5d146d..e646256365d5 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -118,7 +118,5 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	unsigned long kaddr = (unsigned long)page_address(page);
-
-	flush_dcache_range(kaddr, kaddr + size);
+	__dma_sync_page(page_to_phys(page), size, DMA_BIDIRECTIONAL);
 }
-- 
2.43.0

