Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067971;
	b=0UJQUkl39MVjenGzluGxdPwO+p8ygitpJ9I/itScmCjhC843I+rc5/OaTG7JbyW2DGxu
	 d8ogI8p5O9LQLzTvsNb5OSqTQH4GoY09iuaZ66TNaSvNNyNA8xAc58Y1e1kuGHdcuFNJi
	 GFtERfRTV7oq0FupVMy8t8IHUlNFgyeHWjLACaOlF2wECjPttlSsReful2/f95GtvS+UW
	 S8UGGgQFGuf8vYzebvNh6YPXaCVfxML42DIKUM+K6yg7bs6j3PHd3q5TQDwtXwJo4DDS3
	 itAGiL1JLkeWZ7Qi/z8XNjmXDGh1b8H0gCCRtFgfO6Cke3R9oSSYq+mG/0fj/OGtBEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rErQTo2Nunqq6i62Mdon6M+XdYGNQOYXujl7TnxQuV8=;
	b=a10yBfPeDNiFJDaMxSLCq5u5kj1F4aj1Ip1mn6x5DzuLrehGXAqEBTQn0egBGfWKvCY2
	 IeScRl/cBrkpQPDGVvItxsRlOSfjTI6nIjHyBowQoOkqbtYPDdLXwIl1wuVYIb9ZGq8VJ
	 rpAE55cy06dH0mJC/ciOvqg/wXW/N1MdxnsypCh582Qv9Kc1MYHausaHyCxsBLHAD7fbo
	 lPp9A5XZ2IAOwdniHIVAJ2R892GPFH7FJzFphZWpaYdBusaOH3zPgDa2UQojnpKVukWx+
	 ZUWzIwkyQf12Se7w0p8U7adqrQuFATCItjnp8jYByWae3MnUwT4Jo6t1hRtu176A7BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqhgXJdK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7E606A32E;
	Tue, 27 Oct 2026 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqhgXJdK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F85F1F031EE;
	Tue, 27 Oct 2026 02:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067970;
	bh=rErQTo2Nunqq6i62Mdon6M+XdYGNQOYXujl7TnxQuV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fqhgXJdKQ4PaG8z5B2zknj9MDC77/TbEOI3aoYkxcw2dWSBXHTKmhxeuraa1bUwaW
	 AjXrSd60/JTJLrz6PCSDl2tLT4CfmKeTVgTaxKvlTZY59IUgXHy95YQ88nhk+IUKmE
	 0eCQWwyInq95RPDzdY3KS6I8/OYZWr6cTExvgXHsgJzK+WyZ4LcHOT1Djhwa1gBDeh
	 mv/sKskiACauRUN2MnQlrqTO9fVBFe01vMTZq/uu/PrP/2B6M+pwXdPDmcHiwUUEa/
	 +/4RSpMTbD7B91dwStLkuLiMGXIWYMQmb1KG/DVfxXGREUFs4zH8Thv8KvfmCs4We8
	 SlULTZQ+T1KPA==
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
Subject: [RFC 07/11] eth: ixgbe: use dma_alloc_coherent_node()
Date: Mon, 26 Oct 2026 19:25:24 -0700
Message-ID: <20261027022528.633359-8-kuba@kernel.org>
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

Use dma_alloc_coherent_node() to place the descriptor rings on the
node of the ring's q_vector, instead of temporarily changing the node
of the device. NUMA_NO_NODE (ring without a q_vector) means no
preference, same as what set_dev_node(dev, NUMA_NO_NODE) resulted in.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2..770648f8ab89 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7083,7 +7083,6 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
 {
 	struct device *dev = tx_ring->dev;
-	int orig_node = dev_to_node(dev);
 	int ring_node = NUMA_NO_NODE;
 	int size;
 
@@ -7102,12 +7101,9 @@ int ixgbe_setup_tx_resources(struct ixgbe_ring *tx_ring)
 	tx_ring->size = tx_ring->count * sizeof(union ixgbe_adv_tx_desc);
 	tx_ring->size = ALIGN(tx_ring->size, 4096);
 
-	set_dev_node(dev, ring_node);
-	tx_ring->desc = dma_alloc_coherent(dev,
-					   tx_ring->size,
-					   &tx_ring->dma,
-					   GFP_KERNEL);
-	set_dev_node(dev, orig_node);
+	tx_ring->desc = dma_alloc_coherent_node(dev, tx_ring->size,
+						&tx_ring->dma, GFP_KERNEL,
+						ring_node);
 	if (!tx_ring->desc)
 		tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
 						   &tx_ring->dma, GFP_KERNEL);
@@ -7184,7 +7180,6 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 			     struct ixgbe_ring *rx_ring)
 {
 	struct device *dev = rx_ring->dev;
-	int orig_node = dev_to_node(dev);
 	int ring_node = NUMA_NO_NODE;
 	int size;
 
@@ -7203,12 +7198,9 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 	rx_ring->size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
 	rx_ring->size = ALIGN(rx_ring->size, 4096);
 
-	set_dev_node(dev, ring_node);
-	rx_ring->desc = dma_alloc_coherent(dev,
-					   rx_ring->size,
-					   &rx_ring->dma,
-					   GFP_KERNEL);
-	set_dev_node(dev, orig_node);
+	rx_ring->desc = dma_alloc_coherent_node(dev, rx_ring->size,
+						&rx_ring->dma, GFP_KERNEL,
+						ring_node);
 	if (!rx_ring->desc)
 		rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
 						   &rx_ring->dma, GFP_KERNEL);
-- 
2.56.0

