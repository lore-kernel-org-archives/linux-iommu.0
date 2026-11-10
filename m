Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304135;
	b=teFeXd8i0NRZVzsBFOl8cH1c9NZu4o6t1NHJOZiZ0sljTLnz3WxUZVtbD0eKW1HZNcRU
	 bqtKCmHJjemXC/i546grfviU6/KUt96u4s86LJgMOGrZZFeXhhrC0o/+vsAWeQQPG/PzX
	 /nKyZhpYvTwCV5rEpG7h8v+/FigX/as2vhuT5XV1tknwxVeG5plku1kyM+fBJKYIr8dby
	 tucBBJu3/0dZxv5Nvs0l9KvAHMUuvR+DcObLc+HtHUf88XxfmQMPn0IXsXjxHMoOtEUNG
	 iFGRwdkvFmFtBUc8dcVKGqQ2HzyTAz0QfIoVf1QBqypcxlVf0f3RsKsh+3LLFlZQYSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304135;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=PAOoyIXuxloMyFzXEbyj4BFenlPEGjvo8fDerrpcXPw=;
	b=PqiJE9ZLFhwzxMnr8BKqmajtjDY0YK8yRJHUblo1xN2R0O0je/U4l1U7cqF5SlRr+Bjq
	 cAJzZNCrg0WHi36bTMKTDB29ZLXrt7JR1HtaOLYKcM++70KT9wFKsNotMkWjdtAw5xVol
	 Cts21hj+aoCfwEXJRg1TsRmDm1k6USYniVoCsF9dLS7GvfTQNuF3FYaCOVmzWNIJwbewr
	 UGXxCROeo1INg01/4ftSdBxh6U4sJiFtAf4uYvWJIGQngO5ktW4en72xeQlhKWfbxSEWN
	 RzmKL7Kype7gGT/HvdtvSMzrZUBY57FmCIxBoB+fm7LWwC3zWebI2AyA9l8a3GNEL5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W8PyNThn;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C0E606B9E2
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C0E606B9E2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W8PyNThn
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094853euoutp01ab9815424671a881d7c4578267033225~mphoyxXRC1103111031euoutp01V
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261110094853euoutp01ab9815424671a881d7c4578267033225~mphoyxXRC1103111031euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304133;
	bh=PAOoyIXuxloMyFzXEbyj4BFenlPEGjvo8fDerrpcXPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8PyNThnlQcp7PmR1yN6Rrpv06MxIyDsVc/z+kwv/zaBP+/FtY2ea4Bk/RXQr7JSa
	 Kb2JCIowk/YNHX2jW8JKT+PouuJ7BzICax6XnFOiaATqw3tugUE9MGxqeZWkTFY0mE
	 jYL7muKoO9OMpJucPU8o4v4pfUNLhp6I2ewQKHJs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a~mphoBaH7z1404414044eucas1p2x;
	Tue, 10 Nov 2026 09:48:52 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094851eusmtip1e09b2c252063ce2db3a6fe60e6c01e19~mphnSDeWc0098400984eusmtip18;
	Tue, 10 Nov 2026 09:48:51 +0000 (GMT)
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
Subject: [PATCH v2 6/7] dma-direct: do not skip cache maintenance for
 highmem pages in no-mapping allocations
Date: Tue, 10 Nov 2026 10:48:26 +0100
Message-ID: <20261110094830.2081847-7-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a
X-EPHeader: CA
X-CMS-RootMailID: 20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a@eucas1p2.samsung.com>

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

