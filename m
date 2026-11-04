Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807739;
	b=VrrGBQ/cbbNDzysq6kl888kn9aBZm7Y5wj9SH16VzopgR7S0Mj29/4GTCon43gfm+toG
	 nDTxn9FbX06r4DF3l50mN0BLgvS+PkeSQhlEmzUJLlOKJtcfb8E3Ha9DIab2shnTJZTcN
	 GLVRIVbypc18uFdEloHdS6Meni0WcUBkoTWhXMlzf6t36noum05mwaX7sqHHlh0iGE8OO
	 iZ4BuuctRbqptb8M1vkkQaBLOVL9ee2PAZDU6y0uND0MBUIds/CEmzTXx1lftz6SIrx+f
	 uKPsufqrYI4rscr/IHCPxcRcy5ndxd6o+09VKX4YogfPj+zIbHKfpmuRqRAtPYOqk+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807739;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=zOSM4S0j7JxWRoGxJGQTebxA0vWT3vagSHWkip5Jwnw=;
	b=ZoU/MIjAXklTNogXTTPUeRrpUqUUcDYFwa3j8dPUIb8BGXx2aZcrCh0pyE9wUubeskkK
	 kwB4A/LT5C5R3m57V1GGA0wj/euvSCBTCyKn/7fPQHda5mrjsR2qu1s8ftx5K6QBdVWCb
	 IBpJXxPvFUS7GM7GOa7lc6zRcxwD5SEfVIDm+PM34wSZpqzsNipNOjU/WSUS1fsxDvagn
	 mYmfinyBNrPCxI4p9R0o1gS9uBAAtyXoDAqRKHrBqiwSR0RnedqzUJfVYUc0WIwQIDcWl
	 tGmd/vxcfoJrc81dGgvrATsYWgWzTL9VPm+Tp28AX+Plli2hMLKuUvJV6o/Md6AkdDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdNUhNRo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D25606A335;
	Wed,  4 Nov 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdNUhNRo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0151F00A02;
	Wed,  4 Nov 2026 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807738;
	bh=zOSM4S0j7JxWRoGxJGQTebxA0vWT3vagSHWkip5Jwnw=;
	h=From:To:Cc:Subject:Date;
	b=jdNUhNRozhYwFhyOJhZ+Jpr2A4URVxaUOlKbAoZwqojkoV2BYO+PBzBHhE412kiVP
	 3cWQw0nSAHwSENRH5yQSP19yYKMQxHshojImcIWY3f9O3P6j9mVBe/gsdKqa9P3dQF
	 SgtFq74f5FFSrWGXDfymxL3zLMiXexhl748HjUnoakQqJ64+hnaBGGwI1nnt754A5m
	 dnnj2IjgcxpyrC8hwcThS68Y8vsHf05ycIbxMuPicW+IJ+u/5wzSy77srtMNvJ2+Ko
	 bfxMADvlDZ1MPtkEZeintQSkryMo3Jg/XsV/CltGJ48/e52b1ioolV7eZWVYS9ZrgH
	 1ZnyPaOcd54aw==
From: Thorsten Blum <blum@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Will Deacon <will@kernel.org>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Cc: Thorsten Blum <blum@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma: Remove redundant 0x prefixes
Date: Wed,  4 Nov 2026 16:54:16 +0100
Message-ID: <20261104155414.126812-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=blum@kernel.org; h=from:subject; bh=E7f1zycy6qTlzep/1YJoHaDq24W0GDJTU1FDGEmYXN4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmvQ9U46mM+GlaXnFjm2Gxg3cP1Q+J31MH1u7tOh20s5 lbyO6PfUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABP5to+R4e4jC4eYDcIieSdv yL0NDJas1rm6Y84vxsPPT7Fdm5LXX8DI0LuibJvQpIwk/0UMV/eJTv/2oeaXZl/0N55/53SFX/y 5xA4A
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

The %pa format specifier already includes the 0x prefix. Remove the
redundant prefixes to avoid printing 0x0x.

Fixes: 9d4f645a1fd4 ("dma-debug: store a phys_addr_t in struct dma_debug_entry")
Fixes: 823353b7cf0e ("swiotlb: Enforce page alignment in swiotlb_alloc()")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 kernel/dma/debug.c   | 4 ++--
 kernel/dma/swiotlb.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 36c1f7cbb2ae..4cb5f86a7228 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1034,8 +1034,8 @@ static void check_unmap(struct dma_debug_entry *ref)
 		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with different CPU address "
 			   "[device address=0x%016llx] [size=%llu bytes] "
-			   "[cpu alloc address=0x%pa] "
-			   "[cpu free address=0x%pa]",
+			   "[cpu alloc address=%pa] "
+			   "[cpu free address=%pa]",
 			   ref->dev_addr, ref->size,
 			   &entry->paddr,
 			   &ref->paddr);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2c57b49ac7c0..9f143a3361fc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1957,7 +1957,7 @@ struct page *swiotlb_alloc(struct device *dev, size_t size, unsigned long attrs)
 
 	tlb_addr = slot_addr(pool->start, index);
 	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
-		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n",
+		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swiotlb addr %pa.\n",
 			      &tlb_addr);
 		swiotlb_release_slots(dev, tlb_addr, pool);
 		return NULL;
