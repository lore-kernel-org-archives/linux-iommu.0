Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990699;
	b=Kd+Ryx3uPx0gN8L9I8skXto/o+kykX7k4PC5RT/C8qUrpKHuuE5BTeW6v+PiCqLwG7RA
	 o06WQ2Oo7dXYpwZB3umVIRGNWuOTD5gTTzkGEmkzO/yHu0ByDAuHnTRXxCwtB+yiqQbmb
	 dlwOnCw6cKGfqCywNJoTsf3i6cfynEhmUn/D7qoqnD9177Yexmdpsadz3r9lJ92vezSiz
	 4tsGsHMUaWbTlrdCBbpY9f2dFh35w16l5LV8CH5X01JiG7hUlpK0glG2gxPEugZmiz/xI
	 YZl6FTbNNwnWa2AmmXo1AGtqvPieQlr4nD7ZBo/C1y+ZxXhZEzQun0bf66ewAo1kBFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kPu9zlaOpsGhBCdiCw4x8hBWWTKqD97knAMD93CJnKk=;
	b=SgOMEKlBwXTXH34vx7twE9lfttVdEN0SRZfeTwotkI4bt/WXBsbE0UtTVDxAhQKSYWtP
	 bf0Ldn9olt2Lelrdlev8deMm9H3vAsSeK09WTYdmyB4j45aT161HQSSDIaDuTmf+oHLJx
	 eKvEOFZ6Y24fncWlx2h6bu0+xo826vAoRPsTYLRamIJ48gGbn8T3cDczTEmdjRW5Z4fvz
	 aRqwhsJaFnq8u+qQqkLZ/o9g51z2qQ3wElSm9BeKZi7SetAAqLhqGdAOTCJPA8SGAopUO
	 czSrECKSFj4NShyXvnJEYg1kh4UNVh0BesdXNZPeGUvMhJBBkzPvQrl/12Ymi8RFnHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evcRYVbI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00ED606A33C;
	Fri,  6 Nov 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evcRYVbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0F01F0089F;
	Fri,  6 Nov 2026 18:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990698;
	bh=kPu9zlaOpsGhBCdiCw4x8hBWWTKqD97knAMD93CJnKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evcRYVbIoiOGFsQLD/L4PvvpYFLdXNSFEq5eajYUYFLgRd69yOx5t01vWGlSOAIGw
	 560JIEKheggrDncLYFPwc55053EXla72rvB3fJjRKYgzIz2Uq9mSgnRQ5kUBQrFczl
	 vL+GjdO9QFY3Z5ZV0TV7T5BSnmwNbyPltoMRnh+z4T2KcuUJVm53/4qAsSC5DxUmoS
	 1OCN/R1iznfgbglpwqPTL3PfQ0r2odBk31hQZZqdhHc6uHqT3/prWayM2N3VOtPBh2
	 aA/8Zae0Qr28bO6IInpaskqlzg7ZGqc8uUdetpQy+M8ab2ZLV0Dn0zXmD1V4MZxOix
	 lsD9cFr9urPbw==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 09/11] eth: fungible: use dma_alloc_coherent_node()
Date: Fri,  6 Nov 2026 10:44:31 -0800
Message-ID: <20261106184433.761422-10-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106184433.761422-1-kuba@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use dma_alloc_coherent_node() in fun_alloc_ring_mem() to place the
rings on the requested node, instead of temporarily changing the node
of the device. NUMA_NO_NODE keeps meaning the device's node.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1: no change
rfc: https://lore.kernel.org/20261027022528.633359-10-kuba@kernel.org
---
 drivers/net/ethernet/fungible/funcore/fun_queue.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/fungible/funcore/fun_queue.c b/drivers/net/ethernet/fungible/funcore/fun_queue.c
index 0eca751a9534..17c8eba1bc34 100644
--- a/drivers/net/ethernet/fungible/funcore/fun_queue.c
+++ b/drivers/net/ethernet/fungible/funcore/fun_queue.c
@@ -21,21 +21,19 @@ void *fun_alloc_ring_mem(struct device *dma_dev, size_t depth,
 			 int numa_node, dma_addr_t *dma_addr, void **sw_va,
 			 volatile __be64 **wb_va)
 {
-	int dev_node = dev_to_node(dma_dev);
 	size_t dma_sz;
 	void *va;
 
 	if (numa_node == NUMA_NO_NODE)
-		numa_node = dev_node;
+		numa_node = dev_to_node(dma_dev);
 
 	/* Place optional write-back area at end of descriptor ring. */
 	dma_sz = hw_desc_sz * depth;
 	if (wb)
 		dma_sz += sizeof(u64);
 
-	set_dev_node(dma_dev, numa_node);
-	va = dma_alloc_coherent(dma_dev, dma_sz, dma_addr, GFP_KERNEL);
-	set_dev_node(dma_dev, dev_node);
+	va = dma_alloc_coherent_node(dma_dev, dma_sz, dma_addr, GFP_KERNEL,
+				     numa_node);
 	if (!va)
 		return NULL;
 
-- 
2.56.0

