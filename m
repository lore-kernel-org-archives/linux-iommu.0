Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067970;
	b=dRdCBuOAsTPlgdWUmu6LmBmyyVkkAZ/IoS73ZLA8xVZ7LxbCHkbuKLdHDOPlMxRQG32G
	 T7pN9AKN2wVbIG4Jc4PQc+zduJFdzD6Q+EmA5O6SxwIi11131yk2KmvRmOZ8fWy6RTAid
	 tJog+umhM/cKqDotyaKtjhbuVvERg7KuvVprZgebzGYYM2+ma8uPbdsXl8VrKNtiQBxea
	 n8wSNm5/JDKyOpJfrtiNr6lOL2Bm3kkxc9o+KLBc3e8T4pK/lWjzpff1R1oRXABABskUI
	 NLXg3vUqT533kNknqd8pNeWGDVFMnATy2b77HHPWucYfXqxmnnCUQGGVrW6KXStl6mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zZPsKrFfEctSjGRD/c9mT+Zv8pHiy2uqQqaVeOX5304=;
	b=ousnCCfJWM9+/wA7taLl8iFQMKGkbEpdrdkQnRuLRz4zxaM6EN6FtZ/0oH1JnQN5ped7
	 lF1sJ9xR75HDzyUvCERA1uLCX0aAmFJI8SJFtQ1vS1AXtj0nRcrhm9d8OgF+3TuVJHthN
	 qIZmKcbyo13y1oMQzsqj/6CVE+ApDH73BUxjZf3SrG6y4OVvukFM0CukUNUIUL9PBuZqk
	 EVDXE5qhu8q5q7fBdx+i+iFbMJ04nm/lc0lTfFFzWNJB4Ly1jVNLCg6tE6I0b3BeX0nB0
	 exgAHeqnYJwxoOU4X3HfRBWGAUJqdCOgzksCsgI0dk1DqqPzavoIrT7m9wQPXZp+CcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABJtJM3j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395F606A329;
	Tue, 27 Oct 2026 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABJtJM3j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5DF1F01825;
	Tue, 27 Oct 2026 02:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067970;
	bh=zZPsKrFfEctSjGRD/c9mT+Zv8pHiy2uqQqaVeOX5304=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ABJtJM3jXhugu5T2f3YkPSUZncLRq7Dm1NtdJxFxnjvbMq+BnMHQ60bMW+lF1mXCT
	 ZmTfAHT4PJF9UoRP65w0RM5wFgG0BGlpNdaV8MQnxQnmwNNPC8ywpqkd8pnaVBfRpf
	 hCxWsQwom7eIF9O+q0/koIJ7Z2sl6zDYO1crSgLLf8xVdzzSi1GiKCckA7KOPO27Uy
	 yaqiU2Oi/w8gCfW47bwHdE0eWITOdT/8ptzIvZWo2f/Dp+b2Ln+fScBDsSPdoneIpY
	 236VZ02k5UmSRR7f4E42Ez2CZkkGvq0G4vhKM/LDww3z2j7kS4j6rT32oFg3791/UI
	 KjEnWmq52IdjQ==
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
Subject: [RFC 06/11] eth: libwx: use dma_alloc_coherent_node()
Date: Mon, 26 Oct 2026 19:25:23 -0700
Message-ID: <20261027022528.633359-7-kuba@kernel.org>
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
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index dc31e3bc15aa..e6ef7b9f2358 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2888,7 +2888,6 @@ static int wx_alloc_page_pool(struct wx_ring *rx_ring)
 static int wx_setup_rx_resources(struct wx_ring *rx_ring)
 {
 	struct device *dev = rx_ring->dev;
-	int orig_node = dev_to_node(dev);
 	int numa_node = NUMA_NO_NODE;
 	int size, ret;
 
@@ -2907,10 +2906,9 @@ static int wx_setup_rx_resources(struct wx_ring *rx_ring)
 	rx_ring->size = rx_ring->count * sizeof(union wx_rx_desc);
 	rx_ring->size = ALIGN(rx_ring->size, 4096);
 
-	set_dev_node(dev, numa_node);
-	rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
-					   &rx_ring->dma, GFP_KERNEL);
-	set_dev_node(dev, orig_node);
+	rx_ring->desc = dma_alloc_coherent_node(dev, rx_ring->size,
+						&rx_ring->dma, GFP_KERNEL,
+						numa_node);
 	if (!rx_ring->desc)
 		rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
 						   &rx_ring->dma, GFP_KERNEL);
@@ -2996,7 +2994,6 @@ static void wx_setup_headwb_resources(struct wx_ring *tx_ring)
 static int wx_setup_tx_resources(struct wx_ring *tx_ring)
 {
 	struct device *dev = tx_ring->dev;
-	int orig_node = dev_to_node(dev);
 	int numa_node = NUMA_NO_NODE;
 	int size;
 
@@ -3015,10 +3012,9 @@ static int wx_setup_tx_resources(struct wx_ring *tx_ring)
 	tx_ring->size = tx_ring->count * sizeof(union wx_tx_desc);
 	tx_ring->size = ALIGN(tx_ring->size, 4096);
 
-	set_dev_node(dev, numa_node);
-	tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
-					   &tx_ring->dma, GFP_KERNEL);
-	set_dev_node(dev, orig_node);
+	tx_ring->desc = dma_alloc_coherent_node(dev, tx_ring->size,
+						&tx_ring->dma, GFP_KERNEL,
+						numa_node);
 	if (!tx_ring->desc)
 		tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
 						   &tx_ring->dma, GFP_KERNEL);
-- 
2.56.0

