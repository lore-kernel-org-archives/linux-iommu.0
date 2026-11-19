Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101336;
	b=QAhjf9MuisDrZDMdETW+xUHX4AZChqzIEGrzY1b8oAyndj6nyB9FQ56LX8C/quCSlRQN
	 nDOKOyeOc2u4ZAufP2vJws9G3aezR26tfUU8Af4r0/nba+9XNdul5r9vDujeIui+gr241
	 dTFev7DKScNOEhoswGZUOmv4DkZ/vNs4PxI5ayljKb0zdtOBx2bgM9Cx9STchXSCCgn83
	 cLszMAeFMoOqjQBqhNiIobK3OcHySsW52a/VO7w3SDSRY1TxTrqWPEFfV7g4QbGMQgddc
	 Qap6SQ33HxYTbcVlzBEwNl2kXZXOpZ+7ozDTp5aGnpT6ja7gebJrZ164zBsppfDvBLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101336;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=lk76tC7IRw8G2FlFrQK7QuoBU9z+K90N8pTbYK1Qz7A=;
	b=wf9TJrl6565BwuCaYf3m9sgdN13HURZb6zABqduRWcRVnZQn1cMtA+gi0Ne8LlU8oqIE
	 dmSkBw1wWHWm7Wy9tve5nLKt1eKOlUsClk2rf/dPEyt98vb5NTcNuv5ux5wrXVFDdm6so
	 n1blS9Hdl2EFUhnvVoxyVVczld+86BY2DLqyYEPFHysNgd5zFgfXuI1KFE9aW/98cTH5u
	 FlkI4bnJ/L/XjoOzpw7e6eeJuuAZ69puZYMbPG5xvIo4XAKX53kNCeEiHOHF+6Ml/mEy5
	 P9ZxCAqYjIQc1vZ+ZDVLDPc/kb0i1OfL+VjvU6E/awr0xNyjGsTVcAWgLDIzVrtchRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NumuFMSP;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBD60A261A
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FFBD60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NumuFMSP
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151528euoutp027670ddd4a3ea0f29fc37e2fdc42f586b~peyW9shH41497314973euoutp02O
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119151528euoutp027670ddd4a3ea0f29fc37e2fdc42f586b~peyW9shH41497314973euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101328;
	bh=lk76tC7IRw8G2FlFrQK7QuoBU9z+K90N8pTbYK1Qz7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NumuFMSPByZ5+Yut0WRgxfNhSko/XQKMoeqT9BE/yz24jAwDaNiWhEso/zRjdOnY6
	 Cw9dmXs1FSkJQVtfo/iiS+15BXZTl4ff0aTALnHxK2/H9JR91kVqq03fb/by33nnbn
	 /G02+PMLAETIQqCtRs4U/9taA9cg5STSmpDPAVnc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69~peyWsVDFm3051330513eucas1p1O;
	Thu, 19 Nov 2026 15:15:28 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151527eusmtip1fcc6a501e576876aab9549d86cc48193~peyV87Obe1418314183eusmtip1L;
	Thu, 19 Nov 2026 15:15:27 +0000 (GMT)
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
Subject: [PATCH v3 1/8] xtensa: write back dirty lines in
 arch_dma_prep_coherent()
Date: Thu, 19 Nov 2026 16:15:09 +0100
Message-ID: <20261119151520.2383226-2-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69
X-EPHeader: CA
X-CMS-RootMailID: 20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69@eucas1p1.samsung.com>

arch_dma_prep_coherent() is expected to remove any dirty cache lines
covering the buffer, so that they are neither lost nor evicted later on
top of data written through the uncached alias or by the device.
xtensa implements it with __invalidate_dcache_range(), which uses the
DHI instruction and discards dirty lines without writing them back.

This loses data written through the cached kernel mapping right before
the call. dma_direct_alloc() zeroes the buffer with memset() on the
cached linear mapping and only then calls arch_dma_prep_coherent() and
switches to the KSEG bypass alias via arch_dma_set_uncached(). On cores
with a write-back data cache the zeroes still sitting in the cache are
dropped, and dma_alloc_coherent() returns a buffer with stale content.

Use __flush_invalidate_dcache_range() (DHWBI) instead, which writes the
dirty lines back before invalidating them. On cores with a write-through
data cache it maps to __invalidate_dcache_range(), so nothing changes
there.

Fixes: 0f665b9e2a6d ("xtensa: use the generic uncached segment support")
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/xtensa/kernel/pci-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 94955caa4488..e1c00ec37eed 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -82,7 +82,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	__invalidate_dcache_range((unsigned long)page_address(page), size);
+	__flush_invalidate_dcache_range((unsigned long)page_address(page), size);
 }
 
 /*
-- 
2.43.0

