Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990694;
	b=r+36X9SMHLdikiTY8wVXOyyckMNqOyitOtfIODqE51VJQXSefzM07nBRBy/nswvXk6pq
	 f1yQGuBKXyWj9ZKbmqB70owSi0BYRlQdC4R9uyw5QuAtbkEjevxFaYBZRA75vbNTpv953
	 TixGKb4HBJBvdgN/imK0Zk1ZlYEVrhTAX2e+Lm1r55h2dt0XldZPlCJZo/9NSv59Fr1hj
	 Z9kMuecFkwCQwnFrOfGjWMRSYmrnNvkwPsie5lvseeAqJLgUTzhGYr0+th8bhgQc9GXsO
	 unPl9yZD/I41/M6LUEDqpuWlslMQrJzUxb7WR93dR8cgDIC/YI0gRPic52HquMY30uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990694;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=n8nHJF/jbMp6f3P78D3d25VjwkSiSLaYMcmotYK3tpg=;
	b=twRo8lilIcFXE467vEyjOqxtlKtrPRbeNKk6+y4K6iJ77QKCOkcLAGQFdwsmi6WVc35/
	 vTJMITughRlhZETkMc6t/qA6gr9HqpK+B20dCdbbOuyk86duasgGzZdtGR6xp208YzVWR
	 +9x0z6I8TwHP1mWo2X0Zpyo9QqwBgxxr0u/wZs7O+nO1J3ZPo1dVp5Ow9c1iUQeOVQUoU
	 t9rn+dCUy4SFnijqt7/4G23uzkT3vEW8JBeOTqWqAzqX8DTuMEnq22WejFZoGHwa49o+9
	 DzN1BjJv6CzlI5+ipPUJMJP6SnJGY1oyvug/W6A2dysYvv6VFkw636zmRJgR+1DplGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvMBZa4h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062B606D809;
	Fri,  6 Nov 2026 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvMBZa4h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF51F008A6;
	Fri,  6 Nov 2026 18:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990694;
	bh=n8nHJF/jbMp6f3P78D3d25VjwkSiSLaYMcmotYK3tpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvMBZa4ha5EhfL7af2X33IYlDFYSH/t0qgXoGjmvUDzP0CA7A7bGxtLdtek2T//l+
	 qcOw7wxE1W2znLIC3s++GEJc8FyeTZ6ttbeowrzIhp96Z/ckaIHXRE+6Lv1Kyyf4tT
	 7e+EW2TtpbOXha3RyD6Vcxo3yS1Hswe6mGTpP8UlL0z9aZV+kmZlii9HPaizIBFMbZ
	 G/B1yt2iq0E+2JmNkmpV86WH3FO74+PrFHSbH8S1JEC4BtEobagIp12bI7BeHACCvl
	 n7d7V2bg9QgUKZpAQpdS0q1K7ZnY+S3d4m/8FDKYVM4/bj3ZcYiEtKOpfSFfQcjKFR
	 6KA80+EUSHWhA==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 06/11] eth: libwx: use dma_alloc_coherent_node()
Date: Fri,  6 Nov 2026 10:44:28 -0800
Message-ID: <20261106184433.761422-7-kuba@kernel.org>
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

Use dma_alloc_coherent_node() to place the descriptor rings on the
node of the ring's q_vector, instead of temporarily changing the node
of the device. NUMA_NO_NODE (ring without a q_vector) means no
preference, same as what set_dev_node(dev, NUMA_NO_NODE) resulted in.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1: no change
rfc: https://lore.kernel.org/20261027022528.633359-7-kuba@kernel.org
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

