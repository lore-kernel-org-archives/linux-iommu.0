Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304131;
	b=YYRCi350c9NrKvFVnvt1Wx7gFfPgO85gsVi1+mV6gf+74vIYWn87lMoh8LsZKmj6dh4u
	 QYSsvFClPoeEtPetiiZVf/oVOV/UKPtz72Pa2apHr8reElmP9aQhsfAgpgxFQLIOL+cxp
	 /6HO+9JMr/BSQ5vlk+OWzif29mhMeAcb5O3IBQ1RfXNBQ8AVFOw4K9IvQB2o4E37TDJv5
	 nJj4NhyycnvjQdkSQGGE12YSWrhPt5C86/UzRn9FkqB346+F2z0BCYZQ2wkGgRGgfGeT8
	 xLiyZpWTO+nJEZ4Zlij6voVEs3Xd5cam9QXD1Ud71UGCwdrNiOP8KRD+udcoJF6TWAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304131;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=rEjQMrO5ewCoTXLRmyADdnQOxAz7KvPx22hj0G2OEWE=;
	b=VEt53tFnsl5kutfTo92PcBYrT52LpHTeXms6RWJtl7x31MSQK0d670AaUePbzLg2ECqV
	 GYl0pA0DTT8tQohPTpQPupkvRAxZRfGwCMyvn8CA73Q5wsaqjbwVZYtFpkSZwLkTQQ6ku
	 TZjgQv8RC89L1qk9NFti5zT2OmZih1lY7Qiqw9AYutxlDLuz+D70xR7QyNqlhU6h3bvUi
	 RecD/lXmxyt18j8sOJ6Bvjm5Fzbwg2mvnz8z7+KGuE2GD7arElWSlDBbsugfWCyv50iV1
	 xu1NELI1VSCeMIzu/8I8qJ9Di4ZkZ8bJc9lbt8n0R54gBIJwWbd5N4PLTM7RWv/CDTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=MDucNNo7;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757F606B165
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8757F606B165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=MDucNNo7
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094849euoutp01c9c8e138cfa63cbc2695408cd3cd9cae~mphlJh7qV1103211032euoutp01R
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261110094849euoutp01c9c8e138cfa63cbc2695408cd3cd9cae~mphlJh7qV1103211032euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304129;
	bh=rEjQMrO5ewCoTXLRmyADdnQOxAz7KvPx22hj0G2OEWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDucNNo71VMaNT7O/enXd9HnluaC/80BTpCOhfJ8K+Uagdw52U4RKdtIGbL4/liDG
	 ptFVqFkZL0i1mzLXp8DlUFon5C1GkYlliT+bYX8+yZlUY/Scn0nEcUJ3vPCd1yTBQs
	 p5Cp2NrvUEIKB4dXPwjULV+QtgwBpcqtZTFu6/oY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08~mphksavJM2794027940eucas1p2h;
	Tue, 10 Nov 2026 09:48:48 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094847eusmtip1a4cc499316373287c2b9575c277efdb8~mphj9NX-N0299202992eusmtip1c;
	Tue, 10 Nov 2026 09:48:47 +0000 (GMT)
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
Subject: [PATCH v2 2/7] xtensa: handle highmem pages in
 arch_dma_prep_coherent()
Date: Tue, 10 Nov 2026 10:48:22 +0100
Message-ID: <20261110094830.2081847-3-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08
X-EPHeader: CA
X-CMS-RootMailID: 20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08@eucas1p2.samsung.com>

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

