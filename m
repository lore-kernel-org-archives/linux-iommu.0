Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304131;
	b=x8dvRUpiWAP/Km9bRWK+OOdVZlzDpAI8QwnU/SOw2Pfkvrg63iHXNQRkTHmLW9YA8Poy
	 XCdpQSrN7CN3GK3BWEp1RK2QtHmUduSVdcQ6LVeUSF+ddCmpFBJ21bUg9fUvL1J+fOl6T
	 +e5Z8uJBHULnZvvrrKgqokD3oyBwYwidYQOYWEZ32XphOkAV5w+VwMMRWKuq91ODXCCt4
	 yJmY699+iAdapO3tbKAkVmY8kpOQZGiTxkmdwlSDZxJFA3z6zPoIlcrQd0voyDKHgVmOo
	 Wr1soR2v6l2O/2/fbtpgbSCiAXhD+qaO0supaepjd/4C5GIyvod5Goyu/cI8gqn418g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304131;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=lUyguL9bYx4+tZtCreSlh0gHH/nSZpnT13+K+grz3Pg=;
	b=bMTNIbc9Oa/dCSkj1KUCL4stztpC35NW7X3Bso13jd8OQYeT7kz7qLUStppNqxLBBp3f
	 MtCW0dKvMm4BjpBgObrwNZGgKm0jv3pQIa7U8VarNLMTnGq4uiFsdFaIrW4M11mcQk0vI
	 YtboLH/oEFhMOcsDE4AHEiHwgyquLJ4NzAt1AgwPDZIBSP66jsDGh3k8XKVvKm3Rq2IBw
	 jh9jEnNyGe/nhGBM39++SXzwJ7P/0EZXUC/i+iekLA8XHfOPWndua8pn6eGwgwUSAJGSJ
	 yH5NqO17MQRyu9BfKQSAfvXCfRxtO0ftj5iue7drNTlxpqThYgcVX/t+S/7TuPuChYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="NRnh/w8u";
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B021606B161
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B021606B161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NRnh/w8u
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094848euoutp01f7037eb1e87ab43fa9a85897ec84e0d1~mphkaYTkI1103211032euoutp01Q
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261110094848euoutp01f7037eb1e87ab43fa9a85897ec84e0d1~mphkaYTkI1103211032euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304128;
	bh=lUyguL9bYx4+tZtCreSlh0gHH/nSZpnT13+K+grz3Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRnh/w8uguMSSFmuvaVJuWD8Xk/n2AJnJs6+LnBJa5lup6AB5mcUxfu7aQLDSba3a
	 IPrHYFgAZFnYhbpXQwe/7WQSyafetXWXAwM4PJoOnqLRVwRnHHvzg8Y1XEimRoZ+Qa
	 2kNtnobFkym8UW4l09HSZOrQPo/DSkLpbsexzdq0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094847eucas1p125691a852f3621482adae13de1205223~mphj31FOE0320103201eucas1p1f;
	Tue, 10 Nov 2026 09:48:47 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094846eusmtip19270dee01afe96afd138549c54066498~mphjJx1YD0051500515eusmtip1E;
	Tue, 10 Nov 2026 09:48:46 +0000 (GMT)
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
Subject: [PATCH v2 1/7] xtensa: write back dirty lines in
 arch_dma_prep_coherent()
Date: Tue, 10 Nov 2026 10:48:21 +0100
Message-ID: <20261110094830.2081847-2-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094847eucas1p125691a852f3621482adae13de1205223
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094847eucas1p125691a852f3621482adae13de1205223
X-EPHeader: CA
X-CMS-RootMailID: 20261110094847eucas1p125691a852f3621482adae13de1205223
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094847eucas1p125691a852f3621482adae13de1205223@eucas1p1.samsung.com>

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

