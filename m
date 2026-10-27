Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067970;
	b=zO868NlXv4Hng1F+Vl+O+RkDtpEpkv2RBLa5FWA6UCVieeLViUntQSi7YisOk0N89PpW
	 UHfwZIqp/ay9tCuFuHK0qhZR6TqFs97dCVGyHkpxTWkSFDmRVjAY4p4ps0bN2ymPm6nZl
	 tsf+/DJ+dg+wWzx3wJ8tuVz5yOGvecC96lwwBSJ62jRulomYTDuWpWflXMNQ77n3ycZcJ
	 0Caig1/SqNZGUsvXWkczrP+OLoLXAw04g1YrBT3xRRa5G7Wl8X7zhFoTNvv5b2Hmv59U7
	 ZWB5a3Dn4o5W1Q7Wg5h4kbikg8wKXjRWRqBi1mQOs8dr3igFRVG41o8O7jSHTrvjSPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FRi7a53vSaUstI4lBZCZ5kGYojGuHTb3PT4gnA7kik0=;
	b=kdY0nYcrA+cTCT/c7bDJdoKOSdEZrDjEk6hnrd/BK8WGClmOJNMILt0xDd7lSdhtYfao
	 3dPPsTG0/e52iaBMiqNGnCOYVX41hPW02ZLyTKQfPZPIgIueQA5RvUpqxUJbwK6NSFLC6
	 TPdc9QBbpec3KVkn4wq0ObC/+VHAP3a1c5QuQCMhsFH1GOpPyoFiA5z3JVshMpUuty06+
	 PhC6KptWcd7kk4QqR3uCFE00tXP+3JK8BkkeOnyHVVu8fK2j8fPwgKYYlmKozQEvKGNb9
	 KAlmYQLdtX+tnQyhSnm89vCjxeDoB+erpMaGJwaaKqqRVjKdlFSOcX0An/AZ3fGbwzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CB+oOqUf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB277606A33D;
	Tue, 27 Oct 2026 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CB+oOqUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276361F01828;
	Tue, 27 Oct 2026 02:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067969;
	bh=FRi7a53vSaUstI4lBZCZ5kGYojGuHTb3PT4gnA7kik0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CB+oOqUfQcdBlBk/zZOKUmENcRO35PO9xw+/Y2uoeigvEtSLJyC5gvDWvHOAQCSgU
	 iezxiTQHc9ykZnb/Gd0pqaFKdN4kNk30rzR3syTqI8UdbSoTXcgecIl7GfGImy0zSh
	 57hgNVEzGVLFjPiO69UiaT5DF8GX++Y3dFIW4OKmZTjeZNDMI60lNVrwcD0/t3nmsu
	 T67fyAGG+itp5sYU7yS4/SOpkzCkjmWcs1LnjuTbIDCxjOT0uYD/URYVNqvsfGwOfi
	 kSv5PY1dk63MJS1RO4PMyf8E1SXz4ID8Pdg+3AkJLT3zMAOpMAxjARBjPMphwMg3gA
	 TVJ0zN0I7+Rcg==
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
Subject: [RFC 05/11] eth: libwx: restore the device's NUMA node after ring allocation
Date: Mon, 26 Oct 2026 19:25:22 -0700
Message-ID: <20261027022528.633359-6-kuba@kernel.org>
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

wx_setup_{rx,tx}_resources() temporarily switch the device to the node
of the ring's q_vector to allocate the descriptor ring there. The
original node is only restored if the allocation fails. When it
succeeds the device is left on the node of the last ring allocated,
or on NUMA_NO_NODE for rings without a q_vector. Everything allocated
for the device afterwards, and anything else consulting the device's
node, sees the wrong node.

Restore the node right after the allocation, regardless of the result.

Fixes: 850b971110b2 ("net: libwx: Allocate Rx and Tx resources")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index dcbf5811046e..dc31e3bc15aa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2910,11 +2910,10 @@ static int wx_setup_rx_resources(struct wx_ring *rx_ring)
 	set_dev_node(dev, numa_node);
 	rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
 					   &rx_ring->dma, GFP_KERNEL);
-	if (!rx_ring->desc) {
-		set_dev_node(dev, orig_node);
+	set_dev_node(dev, orig_node);
+	if (!rx_ring->desc)
 		rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
 						   &rx_ring->dma, GFP_KERNEL);
-	}
 
 	if (!rx_ring->desc)
 		goto err;
@@ -3019,11 +3018,10 @@ static int wx_setup_tx_resources(struct wx_ring *tx_ring)
 	set_dev_node(dev, numa_node);
 	tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
 					   &tx_ring->dma, GFP_KERNEL);
-	if (!tx_ring->desc) {
-		set_dev_node(dev, orig_node);
+	set_dev_node(dev, orig_node);
+	if (!tx_ring->desc)
 		tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
 						   &tx_ring->dma, GFP_KERNEL);
-	}
 
 	if (!tx_ring->desc)
 		goto err;
-- 
2.56.0

