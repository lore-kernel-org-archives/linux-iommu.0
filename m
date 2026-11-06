Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990693;
	b=pI1MMS6PxFAnJ8pw8bwE+KPBSXxkbEx7rOUL7steUahaCfP2sJB/GXBxx/QQOFmH9SFz
	 hg2V0ltooodGjpW9mkvsDthY9gnMi6Vwyr53oAs2+/3iK7rWNNaVslgAvubx7Q4Setl8O
	 X+JGvNyeGsrHAMBlRWceOyMeGPXatUO6jEY8uOWLW7R88h6i/OZVlpHdiV2PkuG49kQJ7
	 ctFxXr/2tW7n4huWFYTGoK+EeZxetBZOyRPRxZbm9ZvlTe+s3yYR9CiNkIER3CQICuar3
	 sfHGts/I4m6dogIAeifiA2I76qqdW+rEMWXYKTp1Dkks1bL3iZu5C7L5hOFPg6DNcEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KzPIPqv+L8Qbay8vKeI7OsWGsnKBxMyBpUg1hJCIjeI=;
	b=Dk6uZ5xDJlBo30IDzOTuAgu6dshYcWCBOplJS6y3vntTBSsAkFDDmeztM1EuZXNz8siX
	 dcrIUrO3gBPr05c2kdVueiQvKGzhMwWprOOEwauvXmRNVzO8fP9Org0DKOqzgghEwEWZn
	 0JIaW19TfAJsra3CMHgYFGtgsdCahOWgNTaApqhitjfla9dJnahxR6a2Gdg4ioul04jy6
	 MNO3PlQLYrq/ntwcDYMd1FSf2VwFTRzdMDyjT2+Ozz1k7t8kaP92wiXfXL7wWEhm3zTlH
	 X0NzweVMcC7jNQlVRdgKcwXVj51CS/IpuXehVV0oESMS0tq7o3UXdQHwLO5r/NxNBNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ShsF3yFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EE606A32C;
	Fri,  6 Nov 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ShsF3yFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05921F0089F;
	Fri,  6 Nov 2026 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990692;
	bh=KzPIPqv+L8Qbay8vKeI7OsWGsnKBxMyBpUg1hJCIjeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShsF3yFC724WJqQlVNWbRMWQvaII0YtMRIJDpUaHdFZ2Y6XTz+jsRXImNp/Io9bym
	 +JSzFK7roiU6JeQoi9D4CGgmIB6idMa2+rqqVF2d6BMvPK0aTyjNNjIB3tQTrYDV0D
	 Ugk9zb5pHvoNZ1oUxeQ79cZk13DA8LGXhYBo64gtLL1MUQgPx1s0j++yIK1156DBoM
	 TEojPP6A6LmZZ2cDMDLm9tyLs4ZHCyv3Qll0AKNGPgE8zP0mLRNmm/zDING3m4fhoo
	 uJOLYr9npY/9ygco1BMaL4teffISyPi5Z4SRTski5UVe/KhESrs8bXgNi7nCLKWPF3
	 cJqITl2YlcsDw==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 05/11] eth: libwx: restore the device's NUMA node after ring allocation
Date: Fri,  6 Nov 2026 10:44:27 -0800
Message-ID: <20261106184433.761422-6-kuba@kernel.org>
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

wx_setup_{rx,tx}_resources() temporarily switch the device to the node
of the ring's q_vector to allocate the descriptor ring there. The
original node is only restored if the allocation fails. When it
succeeds the device is left on the node of the last ring allocated,
or on NUMA_NO_NODE for rings without a q_vector. Everything allocated
for the device afterwards, and anything else consulting the device's
node, sees the wrong node.

Restore the node right after the allocation, regardless of the result.

Fixes: 850b971110b2 ("net: libwx: Allocate Rx and Tx resources")
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1: no change
rfc: https://lore.kernel.org/20261027022528.633359-6-kuba@kernel.org
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

