Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101336;
	b=RibrkG/JjUMEJgi8A0Gj6NUNBmi4U8/JQK8bHZBvP+NbhsaucUO1HPWANblccMydM3rO
	 vjNuSxWXFFRNpEJtoLh4LGKAJ4VRiMXqN1dYUeMeYVZwi4Lg+zwhh0oB7m8Or8PY6fmC6
	 LbiLaZaKwrjvOQikVlT9VsK9exgzokH8jlwHpt1ujOtsD+vzSoF8/J28umhswr8nmE1yd
	 oJRNIshU+t9eAcNp/e4fKU13f4oBm9LvuKMkekDhJd/+mG1Z2BB0dz4Hxi+rc28mEZ1ed
	 I9k5P06+byE4EFuCEypB1mZ3Tv1gJF8ru16SM3ThffLxBw0mqwthzZAcjLUxadNTAqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101336;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=Nc1YEcw0cuZI+ZNt+M3puu2lLT6GGNnfXJngXlOIKwg=;
	b=HMe8vVSUHUm7VyfoW15knWtDQ2cbrcRrBlbUOeQNOx6awCfsCicGHgjsgrlXS7nfZu95
	 QI77R2JjHL/7AWhj4q/dVa9+iAqguXWetOkRyP3Cleg+AXuoQhQBwfxAdlZqUR9l11Psn
	 l0lhV1jSKZXQDhXVH0IdOT+hdVClMvwa/BRVEDKMShUDDJHT6Ubew2swfACUcT978yotZ
	 S2l1ywWNa0mpMKaLHtWp20IyObmaIfd3P1TeS08EhnY0Hu7lwA22VR8wUP871HcLcaoCr
	 f8ixD9SsVgvF+PynwOdhbVvzOuuzOp0jVdsiGDgpn28zRYURS3jhYARaN0muL9DQA0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W0dBpksl;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D060A262C
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A8D060A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W0dBpksl
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151529euoutp0260d11c166a13628e0101df2ed90c74a0~peyXzPmYs1497214972euoutp02T
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119151529euoutp0260d11c166a13628e0101df2ed90c74a0~peyXzPmYs1497214972euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101329;
	bh=Nc1YEcw0cuZI+ZNt+M3puu2lLT6GGNnfXJngXlOIKwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0dBpksl5wKzOmAKJI5IO7VYsp+Q7+CUMcYAO0GIvvs/NCKmSOjmzXyrtpsulwoXd
	 mi3TKx5gkgyqVy+wQWacBrSyoboy+L6vfVDT1DJ52WuDENbVMgmaRpaejFeFPR14U+
	 2evJ+MkOlGzBUr/kngIiJPI6KIlo/tieZedGLOKM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098~peyXhUBRl3199131991eucas1p1c;
	Thu, 19 Nov 2026 15:15:29 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151528eusmtip1d6e9a0583fa34b4c7775053c77fb38b5~peyWx_5_O2388823888eusmtip1H;
	Thu, 19 Nov 2026 15:15:28 +0000 (GMT)
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
Subject: [PATCH v3 2/8] xtensa: handle highmem pages in
 arch_dma_prep_coherent()
Date: Thu, 19 Nov 2026 16:15:10 +0100
Message-ID: <20261119151520.2383226-3-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098
X-EPHeader: CA
X-CMS-RootMailID: 20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098@eucas1p1.samsung.com>

arch_dma_prep_coherent() performs the cache maintenance on the address
returned by page_address(). xtensa with CONFIG_HIGHMEM uses
HASHED_PAGE_VIRTUAL, so page_address() returns NULL for a highmem page
that is not kmapped, and the cache operation then works on the virtual
range starting at 0 instead of the buffer, leaving any dirty cache lines
of the buffer in place.

Highmem pages do reach this function: dma_alloc_contiguous() can return
a highmem CMA page, which dma_direct_alloc() handles by forcing the remap
path and calling arch_dma_prep_coherent() on that page before creating
the uncached mapping.

Fix this by reusing do_cache_op(), which the arch_sync_dma_for_*() hooks
already use and which maps highmem pages one page at a time with
kmap_atomic(). For lowmem pages it does a single cache operation over
the whole range, so the behaviour is unchanged there. A small wrapper
is needed because __flush_invalidate_dcache_range() is a macro on cores
with a write-through data cache.

Fixes: 0f665b9e2a6d ("xtensa: use the generic uncached segment support")
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/xtensa/kernel/pci-dma.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index e1c00ec37eed..41467a1ba068 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -80,9 +80,19 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 	}
 }
 
+/*
+ * __flush_invalidate_dcache_range() may be a macro on cores with a
+ * write-through data cache, so it cannot be passed to do_cache_op().
+ */
+static void flush_invalidate_dcache_range(unsigned long start,
+					  unsigned long size)
+{
+	__flush_invalidate_dcache_range(start, size);
+}
+
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	__flush_invalidate_dcache_range((unsigned long)page_address(page), size);
+	do_cache_op(page_to_phys(page), size, flush_invalidate_dcache_range);
 }
 
 /*
-- 
2.43.0

