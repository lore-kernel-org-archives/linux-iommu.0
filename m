Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304132;
	b=kXRFajjY01695avFWrIEEEnch697R+8RM3qpOAhDccm7LBe+y2v9QExJ3kRf/tMWP3O8
	 U1ACqgP876VUseZgG7rxrkUO5FomD90vFRUCRPs7HULhOCQSsBlk9QFEQLJ2+RnaYSvqP
	 EQUwOK45HrJCMfujkjLGAKyaYGChWJxnkyvXTxYFfaxaCKyHjgi2WZrXwWYhC6XYypU13
	 H4I//tuvda4TNb5QxpW7MN2JDQHv7lWyeNHwWbIaIdElv/tgEGmSA257wCetTpUPDWuI/
	 MrUBF+yXqB6eShdW3sZH/GdDF03HGA9c4aE3IF/bqpGuGwNzVbHVXAuF1LjAx0/sE9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304132;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=lTLmtK31hw/UKLvDWxom2CDHYzIzwP+MZGBxJv6sbMg=;
	b=07SmdWUMJcHjTpxOth4GEIZEEOsfrZqo3p/fSXUkyoC2RedrSQVaiPamnpVCHBwM2omv
	 0KlWGK2M8WLX5Vj44+lXR1ZRkmlJps3F7/FC0c3h6K63SV5yxElEzBFHIqssLIDgV21cE
	 Ib6UlCQ1Msb+ERzy7pxq3/L8CpBtHIKbhOLj9IeuPJtr5ahUFqoXKIspwsUdUoR0JnCb5
	 LJ28MNAg9+Ua397TR00NBLliGjOAKVisIW+zLTXuScgtETH/r4rfSSxdnI+HAhN8NJt8s
	 1UJDbzzIls/YcJL6f0Oz+Qk3b///jKnTYPVfGkqD0jFdwo+mlJm1hNxDef4Ct0QmVnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rBvgoobj;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F38606B16B
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F38606B16B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rBvgoobj
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094849euoutp028e58c2b872c53078d81ed8a990b64ef1~mphl1MpUe2814928149euoutp02g
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261110094849euoutp028e58c2b872c53078d81ed8a990b64ef1~mphl1MpUe2814928149euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304129;
	bh=lTLmtK31hw/UKLvDWxom2CDHYzIzwP+MZGBxJv6sbMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBvgoobjlJlSBCWbgyIn+0BHY3I5ZjRZ4jeQHB4eksmAQ90VrUq0QYbP/5c4xEzds
	 TqefGzLHCZLJ58dgN8NQ1oy4aGRC4qLk4xRCEmM7zf9LDNBOhoiv/9Sor1CglY6New
	 6xLOyiOYuWtnm9DarBCavT/aiczJ5k9FsBAUYiJU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be~mphliOKVy2669326693eucas1p2b;
	Tue, 10 Nov 2026 09:48:49 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094848eusmtip19361ff8ec94d0397d58e26e0d22b3e37~mphkzEaCR3235732357eusmtip1c;
	Tue, 10 Nov 2026 09:48:48 +0000 (GMT)
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
Subject: [PATCH v2 3/7] MIPS: mm: handle highmem pages in
 arch_dma_prep_coherent()
Date: Tue, 10 Nov 2026 10:48:23 +0100
Message-ID: <20261110094830.2081847-4-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be
X-EPHeader: CA
X-CMS-RootMailID: 20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be@eucas1p2.samsung.com>

arch_dma_prep_coherent() performs the cache maintenance on the address
returned by page_address(). On 32-bit MIPS with CONFIG_HIGHMEM the kernel
uses HASHED_PAGE_VIRTUAL, so page_address() returns NULL for a highmem
page that is not kmapped, and dma_cache_wback_inv() then operates on
the virtual range starting at 0 instead of the buffer, leaving any dirty
cache lines of the buffer in place.

Highmem pages do reach this function: dma_alloc_contiguous() can return
a highmem CMA page, which dma_direct_alloc() handles by forcing the remap
path and calling arch_dma_prep_coherent() on that page before creating
the uncached mapping. Since commit f5ff79fddf0e ("dma-mapping: remove
CONFIG_DMA_REMAP") this path is available on all MMU architectures,
including MIPS, which previously rejected highmem CMA pages.

Fix this by reusing dma_sync_phys(), which already handles highmem pages
by mapping them one page at a time with kmap_atomic(). For lowmem pages
it does a single dma_cache_wback_inv() over the whole range, so the
behaviour is unchanged there.

Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/mips/mm/dma-noncoherent.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 30ef3e247eb7..d8e5bc85bb3b 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -44,11 +44,6 @@ static inline bool cpu_needs_post_dma_flush(void)
 	}
 }
 
-void arch_dma_prep_coherent(struct page *page, size_t size)
-{
-	dma_cache_wback_inv((unsigned long)page_address(page), size);
-}
-
 void *arch_dma_set_uncached(void *addr, size_t size)
 {
 	return (void *)(__pa(addr) + UNCAC_BASE);
@@ -127,6 +122,11 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 	dma_sync_phys(paddr, size, dir, true);
 }
 
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	dma_sync_phys(page_to_phys(page), size, DMA_BIDIRECTIONAL, true);
+}
+
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
-- 
2.43.0

