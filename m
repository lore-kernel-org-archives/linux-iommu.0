Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067972;
	b=QrpsdH+zPFbLZDt3w4zOvEGaGJYJh8fMJLn5Q/jODhKYSm49DPc/FUrIlbT5VKUW/NtD
	 bvKEcCR+m+KA1u8tb2nG3cKGpwnUSH+dgvI1K5oE0PIBWZPtyHACPcNbzm2nK52g38Jtb
	 j+gmvHJ4Y5rGY+m1asvqeg+1hFXdQwXApG3S6LZVnQOsUXb4o3EhU/f3mchNE6lhOTjfn
	 PMOkRSPje3HN72b7AwyknwjDRBSyWpoUqNdQWhvFpLeg+bsNCD8JxajUbKt59GtYgXI0X
	 Y+mgB0yRpvNL3VmDoZRgJGNLDC6IeYxMex7iVvAuaV9R2uvfOtarHVc+6OF+vAOyF/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067972;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uw8bSrMf+yNyn4EuN9Pn7ejViHydp6zqrNBPnIcc/qo=;
	b=r+Bm2v7uiKoax2WkMPM1m8qSAKp52GGFJqnJDlD7W8HOc2OwOzs/mMl1xk1lXtXjZAn8
	 UupZsfr6Mt3k23DIy5Z1wuf/GqxaUMVOf9K2tct+hNM/2wx68ZnjIvEvzNdkPb3OcbmQY
	 6If9v1daCes+9ZgcYIJpdv2JI2u7DiibNQkOcx6rmQyKtA79b9jn710wvXQG2lgc5n5Zi
	 VjNHJbcNNOwiYzJGDYgq5LoYmIW5eauB4ZYRCOM6yWLZ/GuAxiN8cK5WFaqXFyOnlpAD0
	 UKvR9LK7pQkJk1Rb1CVHr6z6Od4wzmTDfskaMRHwPgPV0FsuwAwgANPGWqSIXJYWeUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sx+vhh/H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487B606A31D;
	Tue, 27 Oct 2026 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sx+vhh/H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8BA1F031E9;
	Tue, 27 Oct 2026 02:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067971;
	bh=uw8bSrMf+yNyn4EuN9Pn7ejViHydp6zqrNBPnIcc/qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sx+vhh/H7XH3WAEAV9KHzplLl1b3/GFlUF4lT86BFhW36UmC29MztNL7pF0bqVYF+
	 e6E9rhG5+hiHpZYQaxzIp1OQCs9XTfRMvyaU30jYbl98Y/hJlJ6E5m/hxzsVM5ws6A
	 VAWdCmfklm/RMqxbMCuQ1sPU7o3QGyF8e26WZnzxVVndFh88KrcVN018cLrHSLVrTz
	 B4K9TfkRsFxPOfmGdYMILaIcWPaiZGCJxEP/bBznP0NNEqcqLRrircdE7TzXNyuzW0
	 wLtOU6vUYClvDEvgRa3BuBsSu0OmLN2Gkr8ySofE5h92ecAQX2wNDUFv6gD6L+r307
	 BjAT3VWDVPgDw==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: tglx@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 09/11] eth: fungible: use dma_alloc_coherent_node()
Date: Mon, 26 Oct 2026 19:25:26 -0700
Message-ID: <20261027022528.633359-10-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027022528.633359-1-kuba@kernel.org>
References: <20261027022528.633359-1-kuba@kernel.org>
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

Use dma_alloc_coherent_node() in fun_alloc_ring_mem() to place the
rings on the requested node, instead of temporarily changing the node
of the device. NUMA_NO_NODE keeps meaning the device's node.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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

