Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101334;
	b=xnYZYFt/KyCJ1yOAaCk3IZpftEKeRtIUunplBB2j1mD5SB0+BwMWe7edKZPEh0m6534m
	 NAAbM99CnYGog8mX9yIbSJpQlWTT3kbh/c6OEvhoil8jehQ6iR0mkEIkMmkRT1jrlV7v3
	 md0WkM9EldWKrMmPuTtAuu0LU4ijz+ztEdjKrSP3vLfojvIxtyqIPDQ1eJrjkB/ipkjYs
	 5tipN+e+9u2ClrzuXDhfmg/gBQ9dA8bFCTV4uJrmy/FFVHfo+2wHPY2mPMF5h5fDoNoIm
	 PDeWoQ+luOG2/yx9DJvowaZOaXcS1zrFrdH0WV690AT9vHYHOHWngOUusGuN3Zc05Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101334;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=0/rZ8eFNR0SkR4KBoqJwpR6CsQYqYW0/WWAATt7aV9o=;
	b=oXvcODQRCR47a/gQ79jkokFzY+W8t8o+z0KryCByOYC2Q6ldOU6V+2+H6z5BhSfMcoix
	 /nbjRZLGIxzYVTFAfAKP1BzQ86SXTGIkY7KNwVtTutINxBItHnn1TniuXMk8GGd2IbME9
	 BhRoA/AKbaseWMCjp9O23WMYICR2bwn2/jiNM0DhiuuFhERyT8Pt5Y3k7Rid1183kN4vn
	 MOZizHWusHMuok/OAeXlkc7Kn9BUtV5vAY0I4f5NZCEzpLsyjTSfPNIzVNmERFDGGhJk1
	 ccdc1QrsVEVeNSyUJnHrGCj7eLCT//ZhpBhkTtFa0j+73C0opeqsHbJ9B36CYDN7NNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=AmzMUIjW;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829960A2600
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7829960A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=AmzMUIjW
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151532euoutp017326622c624df9acf0eab05d5b1483d8~peyaZ_fTM2662526625euoutp01Y
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261119151532euoutp017326622c624df9acf0eab05d5b1483d8~peyaZ_fTM2662526625euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101332;
	bh=0/rZ8eFNR0SkR4KBoqJwpR6CsQYqYW0/WWAATt7aV9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmzMUIjWkV7nFz2jgYxfJbOo4ayHi+MSjAXaPuA4nYUBmiWAYz/SJMGbK70mxfJjN
	 zpTbUrn4+ZLBuUcofDr5FMV6hTyZztdVvXfrHKu26sgLRZDCq8roNnYoHebRze8mFt
	 din6qHpP1x+AiR4sC/dFNFQ34TKGTsq4FAGigSzA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c~peyaDJkwh1566215662eucas1p24;
	Thu, 19 Nov 2026 15:15:31 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151531eusmtip15acd40c96d905159080b77d155c3b04e~peyZSMbLo1418314183eusmtip1N;
	Thu, 19 Nov 2026 15:15:30 +0000 (GMT)
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
Subject: [PATCH v3 5/8] powerpc/mm: handle highmem pages in
 arch_dma_prep_coherent()
Date: Thu, 19 Nov 2026 16:15:13 +0100
Message-ID: <20261119151520.2383226-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119151520.2383226-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c
X-EPHeader: CA
X-CMS-RootMailID: 20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c@eucas1p2.samsung.com>

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

Fixes: f2902a2fb40c ("powerpc: use the generic dma coherent remap allocator")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/powerpc/mm/dma-noncoherent.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 3ce7dfc213d9..af2a42e47016 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -122,7 +122,5 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	unsigned long kaddr = (unsigned long)page_address(page);
-
-	flush_dcache_range(kaddr, kaddr + size);
+	__dma_sync_page(page_to_phys(page), size, DMA_BIDIRECTIONAL);
 }
-- 
2.43.0

