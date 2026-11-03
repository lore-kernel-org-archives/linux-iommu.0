Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721041;
	b=zptBLQQPP2XFhuErYYB6Aee2yU0M07eOc6n23/uRnX2F6Hdz8rVDuf0Kyx+4XrkMuPM7
	 UQBbBz1dajD1f9f74Z85+xZraTUIMRx4HLcAD02STtvQ3p+9CzcHZS04MSK24HtC33P1G
	 6YDQMRjdVW5FZiv6lEsafdWbjMBikxCmhkRdSeX9RS9uYtda4Abc3ojPX1T52caoXOlpy
	 MgojqzFMCK3LmvsjeslOuCsabGT7fKcQ3Lg+4bdLPq4X+saMPUVP6nQAo0ZJ4xLG0DbZo
	 bTKs+z3/PfFOWtKKuOrmPszsAoZhNaQwTI6NxZMJR6a6yxavuD0NwvCeN9L63DkDfUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721041;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=jUuh6/lKK6xw8cS+kh/8Cmw6Ho/ruTgSGsuvxXQIYO8=;
	b=SmeB6CvchNTxqTeeNbK1smKuyesKdkwXGgArLTNVYb2OyBznojW5mN5nDFv+Ka2PYldo
	 gbVc9FzcCNFcLSmgkApPML1+Au9IXQQE3UFEHSr1X1VQ67VEmE2UrxnzWqKj8Wv0SctT1
	 sRwa4FGGRgO7mTUMykG4HI5dAxC4CBxiy4/wRuvHSn0WplGBnn7Y28ufmVSLbY0MnteCw
	 uyQ2oSi3YPLmyf4tM9Soi3d2S7QHsJsvt7kmtxnvykxaU/xC0I3amO+fSaQWTsq7VW/0Y
	 x5gwfGVdf8jhP36Ry9vNyxIsU/UPhswfsibHsG3uloWVBk1kXlnAUHmWHLC1JwGmJ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Y4X99kLo;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A279606A327
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 15:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A279606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Y4X99kLo
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261103155032euoutp019967bf5782167f9f45cd8bd8e17c9ff9~kk8aZ_yVG2111621116euoutp01e
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 15:50:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261103155032euoutp019967bf5782167f9f45cd8bd8e17c9ff9~kk8aZ_yVG2111621116euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793721032;
	bh=jUuh6/lKK6xw8cS+kh/8Cmw6Ho/ruTgSGsuvxXQIYO8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Y4X99kLobsyhQQc72bZN6GGWortvk3vdo9DBZoftuF5RFBNpQxCmCagZOLKawFJtz
	 a5NkKdzx18Gg2yJNSHPbW0/diNAmKTA51VJuE8JXhxB38OAy2IFJkiOtdeUDShhji1
	 6/9umFtZBTLDWQFheFJyeWTFVTMzSm6rohN7XvN4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862~kk8aFg2gt2502125021eucas1p1S;
	Tue,  3 Nov 2026 15:50:32 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261103155031eusmtip2766ca655008c9ad0bf3b91d2b60bdbd5~kk8ZpZzNZ2102621026eusmtip2L;
	Tue,  3 Nov 2026 15:50:31 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Claire Chang <tientzu@chromium.org>, Konrad
	Rzeszutek Wilk <konrad@kernel.org>, Giorgi Kobakhia <gkobakhi@asu.edu>,
	Michael Kelley <mhklinux@outlook.com>, stable@vger.kernel.org
Subject: [PATCH] dma: swiotlb: Round restricted DMA pool size down to
 IO_TLB_SEGSIZE
Date: Tue,  3 Nov 2026 16:50:15 +0100
Message-ID: <20261103155016.1107958-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
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
X-CMS-MailID: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
X-EPHeader: CA
X-CMS-RootMailID: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
References: <CGME20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862@eucas1p1.samsung.com>

All other paths creating a swiotlb pool ensure that nslabs is a multiple
of IO_TLB_SEGSIZE, and the swiotlb code relies on that. Since commit
0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization") a
restricted pool can have an arbitrary size taken from the device tree.

If the pool size is not a multiple of IO_TLB_SEGSIZE, the last segment is
partial and swiotlb_release_slots() reads mem->slots[index + nslabs],
which is one past the end of the slots array when the freed buffer ends
at the end of the pool:

 BUG: KASAN: slab-out-of-bounds in swiotlb_release_slots
 Read of size 2

Round the pool size down to a multiple of IO_TLB_SEGSIZE, wasting a bit
of memory, and warn about it.

Reported-by: Giorgi Kobakhia <gkobakhi@asu.edu>
Closes: https://lore.kernel.org/all/20261026032007.1957949-1-gkobakhi@asu.edu/
Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
CC: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/swiotlb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2c57b49ac7c0..a68f35192582 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -2007,6 +2007,19 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	 */
 	if (!mem) {
 		struct io_tlb_pool *pool;
+		unsigned long aligned_nslabs = ALIGN_DOWN(nslabs, IO_TLB_SEGSIZE);
+
+		if (aligned_nslabs != nslabs) {
+			dev_warn(dev, "Restricted DMA pool size %zu is not a multiple of %lu, rounding down to %lu bytes\n",
+				 (size_t)rmem->size,
+				 (unsigned long)IO_TLB_SEGSIZE << IO_TLB_SHIFT,
+				 aligned_nslabs << IO_TLB_SHIFT);
+			nslabs = aligned_nslabs;
+		}
+		if (!nslabs) {
+			dev_err(dev, "Restricted DMA pool is too small\n");
+			return -EINVAL;
+		}
 
 		mem = kzalloc_obj(*mem);
 		if (!mem)
@@ -2034,7 +2047,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 			mem->cc_shared = true;
 			ret = set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-						   rmem->size >> PAGE_SHIFT);
+						   (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
 			if (ret) {
 				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
 				kfree(pool->areas);
-- 
2.43.0

