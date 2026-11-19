Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101336;
	b=XrUFOAAYokxRAgYj7eqsK3T2PyL4a8m54EJWbgaqzfKN8RGuu3w9+/LNPc29bTQ58ow5
	 3zPjeIPPGx3KVMBjpM/fYfXxHidfJqJ+9ORx1urZyZnhUYvwbdhJYBuevpKpI+I4Z/5b3
	 X1xxeSQflz8iIn18suPQtBPa2hg8exqCE+1XwOo3iaQ7rxqFxbuRKrJ05/KA78N2ABkD2
	 HdxmI5ktly2fH6fBBcy3EH6wVPvRflrsAUy7ao0sli1vTKuOJ+PQgLV3lDFKvC50bgfG3
	 MKLsOwlqFUAcrGlXnIlO7pgs49kpeAPPiVxIft/hdt0DA50mC9zvH5DiiorrdKaedog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101336;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=PAOoyIXuxloMyFzXEbyj4BFenlPEGjvo8fDerrpcXPw=;
	b=oBPt0zVG96RyuR1OW6vp3I7qxqsp8YarFR3q9VDWrOXPUCcxHDARjhYjdNamisUQaCqb
	 htL8Q4vj29yBzKu6NiwSh66OSOxGMGPzkVlgWuvm+jnwxqGvOXBi9D32BYiFQisj32iCH
	 TBYZBQfVwpHgTpxv23PBeqUPCDGWrQf5KIKDnPI5tQRjE4+3mpC2f7bbhlOyZVLenD76F
	 ZrzITq0HLNbxkZZLSzPj3mOexwgtzEqOsXsNaTiIuGMNDGA2MR6m4ljgZQRC869ykrOSc
	 H1fKZdHQk8tRUlrqxhKtAWLbmUHxvHNJFiFSRMxCnBCvEj5Ds2ifamWPZXu/ZkOzyuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=GGwysuCM;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696560A2620
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8696560A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=GGwysuCM
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151534euoutp010c9c702af6f362375b7f213c7941f58f~peycNlWJa2728527285euoutp01H
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261119151534euoutp010c9c702af6f362375b7f213c7941f58f~peycNlWJa2728527285euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101334;
	bh=PAOoyIXuxloMyFzXEbyj4BFenlPEGjvo8fDerrpcXPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGwysuCMXPEPYjVeusWJL4cnqdklOJrdDsEMbcw/j3NnvHZMPeqlUcr4E/oDluULx
	 4BwDs44vQQGvR0Z6rAM3EckKj6w3zfKtvxLpq5/xho3Zacs13TyFMxW0SYJahcYFYj
	 3IyjED6THoWPLR7KO/NTPgI9Xu+NcX+iHjPMbsr0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e~peybucct00881508815eucas1p2E;
	Thu, 19 Nov 2026 15:15:33 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151532eusmtip1c3870825822d25974aa0874a95107a8d~peya_J3Vx2049720497eusmtip15;
	Thu, 19 Nov 2026 15:15:32 +0000 (GMT)
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
Subject: [PATCH v3 7/8] dma-direct: do not skip cache maintenance for
 highmem pages in no-mapping allocations
Date: Thu, 19 Nov 2026 16:15:15 +0100
Message-ID: <20261119151520.2383226-8-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e
X-EPHeader: CA
X-CMS-RootMailID: 20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e@eucas1p2.samsung.com>

dma_direct_alloc_no_mapping() calls arch_dma_prep_coherent() only for
lowmem pages. The check was added when the DMA_ATTR_NO_KERNEL_MAPPING
handling was moved to dma-direct, because some implementations of the
hook used page_address() and could not handle highmem pages.

As a result, a buffer backed by a highmem CMA page is handed to the
device without removing the dirty cache lines covering it, which may
still be present from the previous user of the page. These lines can be
evicted later and corrupt data written by a non-coherent device.

All implementations of arch_dma_prep_coherent() now handle highmem
pages, and the hook is documented to do so; dma_direct_alloc() already
calls it on highmem pages in its remap path. Drop the check so that
highmem pages get the same cache maintenance as lowmem pages.

Fixes: d98849aff879 ("dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in common code")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/direct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25e9a86835fd..fea0dd36dd25 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -207,8 +207,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 		return NULL;
 
 	/* remove any dirty cache lines on the kernel alias */
-	if (!PageHighMem(page))
-		arch_dma_prep_coherent(page, size);
+	arch_dma_prep_coherent(page, size);
 	/*
 	 * return the page pointer as the opaque cookie.
 	 * Never used for unencrypted allocation
-- 
2.43.0

