Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990696;
	b=Owg7Txr9OdOmQVE5WKVKPWMVvRp6+t1csqcideBXTrIQziMxbVK1xJ6vX8NvYsIDBapa
	 hCw6/drsBYZw/GkSxwZwIsE5dJNGPj7WBdbeXmYqCRbd7qPoAuBIGlsdnHCnKuxigCPKO
	 g9kL0AcpTcZPKV11AzBMtX5i+jQdVpXbn2jqQpCwfuyr7niragP42A1Wc14yLlcz0jDgi
	 mtKdwh4vRznORxtTGRseU0bZPk5Zfg/oa0IFT4S2O47mC47iUaZDCb3+f5Ak6kdTZ7aqw
	 6xkolYIZ5k0Y7fA7eKs+Oem4o9S8B087P2g3w+a+UveLbuo1Z52B4SnLPhjDJD6x6jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990696;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=voQ8eDq7PtlgscQlafu8xekB1CYB9Jf7yYYsTQMGEaE=;
	b=BKikl5oXUBJVVekyTIyS56zbTCI3GCwCzcxcI6v2FVH2R/Hpi/XKcgSmGJQTyfbf28+g
	 jWFUNGEZUXwRUYdzTavEMQ/6K663Mcqai4dVioIg7TbFiSBk4Hqbta0k0MHg+8w61luID
	 BJF2h3BR72PrjEr33ZeACS1rrA5WXmU34+q+KttBERvYyZayL2LV+7NvjwGAw7d6ZYRRU
	 44IyiB2k4xn5/k2HwC5jX2uHaSoeXeF3AuZ1j9Je+UTTICIzY9veTv75xap+uGAtDovH5
	 KA/J9KEXXcd8zAgWWkmKkmq/aj8v91h+5t6NHDVc7i7ox3famE3R7tsiyLh7XyhGhUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zw4FEYC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CA9606D804;
	Fri,  6 Nov 2026 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zw4FEYC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DC31F008A3;
	Fri,  6 Nov 2026 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990695;
	bh=voQ8eDq7PtlgscQlafu8xekB1CYB9Jf7yYYsTQMGEaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zw4FEYC/0rgJaBn4sEIgs+RqXJzKPS2Qt6gggFC6zBvLWNex7w+6pk4vaowqcXv7f
	 u1YhNYDzQZTU1TdQ2cmRCM9JmynVx6geXSg0nWGTA2XCAr5LgXrKkkmM3aJZrFd27c
	 Ku3/IC9uH7dC70+tEHRFJgPq4s1jHM087bbpgEuykuuz6Rd4eVR94s6qqpBbV/YSZ3
	 7Xh+JWzpQ6cPEBk0cuGIM4QwnEGQ1S+hqIFrMcfI9cNHrUc3jLNT6jvG9ACXZjppM6
	 Xd0T6pWWslpCICmUKkQfJwT4vD6em8TzoqANHKpo8snpYv75Y5Q/9IeAQcNDZTc+jO
	 1Qxzj9P6p8r7w==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 07/11] eth: ixgbe: use dma_alloc_coherent_node()
Date: Fri,  6 Nov 2026 10:44:29 -0800
Message-ID: <20261106184433.761422-8-kuba@kernel.org>
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
rfc: https://lore.kernel.org/20261027022528.633359-8-kuba@kernel.org
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index b9496f0bee13..6458cb2e511e 100644
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

