Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005818;
	b=hbzC4eWpWGjdeVaIgv4latLWClKFEcDub4NjMjtiO42BCB1GSUJmdNtTs4uiPQ6efdaP
	 bVbwrlD57z/8raJQT8xRgYl+K8gEPt4FeiHyIKfHSQduJwV8DWgHExQY2oUgcXNNwBzEQ
	 K6OLIaPple1qiNaHDV4OdL2TdYu3vaQTlvGcgI6OGRHA64h53SoNpp6V/OQ1f7QYCtY16
	 Aeq9n6EStM9BX7pRvheXHuZ4euRs1+2u52qinkCn/dbCMOytGNcEaFTzKncaw7KFdP5Tz
	 SsQhqmx1CnrFv58RycFQB8kPZu9S1Z16SNro8guS3NaQNV9DJ5WRrgfPHQIzgJA4aqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005818;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=sqRiL704sMluKdRvVQ4zewuJOHUjmkrlRuUBPJbDhvE=;
	b=c/UkvTuybpdTJ1oNmNiSSagfINY92FFTn4Sw4FSnSojPrCDxbuQmzyZLaCfkkYud6nW2
	 NAXh01jWmPDrohIKOxAkTdTpBm5F4vfaJFGicAw4XXZw2YNE5Dt449RV6YEIZQMx5b5T2
	 8Kqgf2gWKrqiGMOoyfAcAxFRmGBnHFdmSHvh5v9CwPrOtomg1SdeCeJ3iwHjcTd1jvvDV
	 dzTFwvApnid5OPPLGSNHuwqj63KoYwdrsn0HNZEj4OkOh9RTEx2uiRi4Ai4BEehZpA3Oc
	 gAE7eXI+v3vbfF3lzzOnSR3KR8YWfUk9vB3foAknTj0mYoH1fckpWQ4s9ysqPkKoYRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="j/fgjsYG";
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F5606A338
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 22:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 837F5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=j/fgjsYG
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261106225652euoutp016238398a23bb9d9b501f54b18cde922c~llsgi4TwG1319313193euoutp01L
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 22:56:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261106225652euoutp016238398a23bb9d9b501f54b18cde922c~llsgi4TwG1319313193euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794005812;
	bh=sqRiL704sMluKdRvVQ4zewuJOHUjmkrlRuUBPJbDhvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/fgjsYG25Dr8LLRjgDua2IIhxtYzvZkR0LFi+LTfCvj5vAmxos71iwGw0kfjGqyE
	 e8UVGKPVyvvN2U6FKuxh3oJVx3lYKgnRIYgI5iQIj35Mz2EwcE71zQdxTaonViWWaD
	 S4BJ11hM+nDIiGdDfmzKXMblqF6kURWqVRsYXjkk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225651eucas1p2d038403b190875c1dd698da959eefbd3~llsfi4ujJ1972019720eucas1p21;
	Fri,  6 Nov 2026 22:56:51 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225651eusmtip2199876749caa2da8966a40ca82a8889d~llsezs8wl2228922289eusmtip2T;
	Fri,  6 Nov 2026 22:56:50 +0000 (GMT)
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
Subject: [PATCH/RFC 4/7] powerpc/mm: handle highmem pages in
 arch_dma_prep_coherent()
Date: Fri,  6 Nov 2026 23:56:24 +0100
Message-ID: <20261106225628.215319-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106225628.215319-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261106225651eucas1p2d038403b190875c1dd698da959eefbd3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106225651eucas1p2d038403b190875c1dd698da959eefbd3
X-EPHeader: CA
X-CMS-RootMailID: 20261106225651eucas1p2d038403b190875c1dd698da959eefbd3
References: <20261106225628.215319-1-m.szyprowski@samsung.com>
	<CGME20261106225651eucas1p2d038403b190875c1dd698da959eefbd3@eucas1p2.samsung.com>

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

