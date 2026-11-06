Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990700;
	b=W5VklRySyK0h97AtZEC73mJAGbIRfTgXMaGqNHfWmiInwytU+ZSyDQNxIhD38O/0zZYb
	 Rdpx+dUPi6mUcezCTOP83VX/tFRJMRy0y7HqZ4KeAzqBk4BFIv7uwWBwmTdskdB+4B6SJ
	 iXrXBPd4+Lvh6EUIcSOhpNQ+OKHfNqUIv1qCtmIxL0vMP0sjgjPMlMyimWOQ+W212Q9Dx
	 +d8g1TTpGHS95uQub/AGHbkTSiliMzoSLN+DeoTiG30B5+dGYbTsRGQLXUzgerMVPaFAo
	 Bp2u8iLsE9i3oQzfrAPqAhw8vythZdfn55p9domDOSTUE3eheakplYle0Vzxz8umRrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=07ghH05Us6krjsd82BhZyGP5udskN6Jkr1ft6N/Qp9w=;
	b=0XUyXZTrKMle8mEkUrjBBbQKE+GBBGe4ZOCjo0V6GGIpo/V9Pzer30Gh09lJLwkUy+5Z
	 iCSuYCTbuWHjkwlrrge+Z6/XBOyOPTutjR3WbyTwYo7bMDl9CBEhgVFzKdyZLQ1Q6eaku
	 I5lx+2x+SfF1saSxaxYYSPioscLyanAsYqltdMKdwT3P3LFDdPVgdejT08nz3skj/rjGg
	 RpWNPjrx56rMLNBDpt2q6Ijj5iwFa4BaXXVSfCfdqquhMj32XBE533V0jWWc5Zy1EsN+4
	 2kJcJOSR8U1JhBhnYrWixWfyVE9QVANKE9B9FJvT4vlskYdrtuYmg3yruQLUZLrD41Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cu3xPySm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B039606A333;
	Fri,  6 Nov 2026 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cu3xPySm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21A61F008A3;
	Fri,  6 Nov 2026 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990700;
	bh=07ghH05Us6krjsd82BhZyGP5udskN6Jkr1ft6N/Qp9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cu3xPySmXHUKmaJ2jY9W31WZYJkv49a12/LqGzND6S/W+0ndZBIenAsFIdybV88FI
	 btUeLRvGDhC4Ei+ayLtEwj0ykJAQkh1XyVjaWXnkT4z6B0ymaUEe9cAjFJBtdB0zA/
	 MzyHZFSCYSlEk8wS5AER4VtzuezWwuPZH2R4+gdm7WNHb5E14vdLt7yKINrzDz7+ae
	 6VIoDAN7l0DOhPww0zT1TOSG3y6LI+07c3rgWg+AJ1+HI6qD+CeCk9Wx9SDXEbOm7U
	 q6oeQl3zJdsXu54SYiROUSRZb+RZmrgeTnTzSqhZ9jXKWfn8ZBrsMWnIiyR4QHYRi4
	 gU2W1cusDxt6A==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 10/11] eth: mlx5: use dma_alloc_coherent_node()
Date: Fri,  6 Nov 2026 10:44:32 -0800
Message-ID: <20261106184433.761422-11-kuba@kernel.org>
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

Use dma_alloc_coherent_node() to allocate the DMA pool pages on the
pool's node, instead of temporarily changing the node of the device.
alloc_mutex only serialized those temporary changes, remove it.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1: no change
rfc: https://lore.kernel.org/20261027022528.633359-11-kuba@kernel.org
---
 include/linux/mlx5/driver.h                   |  2 --
 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 24 +++----------------
 .../net/ethernet/mellanox/mlx5/core/main.c    |  4 ----
 3 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index abb99371ff13..c58cc5a8f8df 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -596,8 +596,6 @@ struct mlx5_priv {
 	struct mlx5_debugfs_entries dbg;
 
 	/* start: alloc stuff */
-	/* protect buffer allocation according to numa node */
-	struct mutex            alloc_mutex;
 	int                     numa_node;
 
 	struct mlx5_frag_buf_node_pools **frag_buf_node_pools;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index dcd281c4691d..936ce07aaefb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
@@ -80,25 +80,6 @@ struct mlx5_dma_pool_stats {
  * register it in a memory region at HCA virtual address 0.
  */
 
-static void *mlx5_dma_zalloc_coherent_node(struct mlx5_core_dev *dev,
-					   size_t size, dma_addr_t *dma_handle,
-					   int node)
-{
-	struct device *device = mlx5_core_dma_dev(dev);
-	struct mlx5_priv *priv = &dev->priv;
-	int original_node;
-	void *cpu_handle;
-
-	mutex_lock(&priv->alloc_mutex);
-	original_node = dev_to_node(device);
-	set_dev_node(device, node);
-	cpu_handle = dma_alloc_coherent(device, size, dma_handle,
-					GFP_KERNEL);
-	set_dev_node(device, original_node);
-	mutex_unlock(&priv->alloc_mutex);
-	return cpu_handle;
-}
-
 static void mlx5_dma_pool_destroy(struct mlx5_dma_pool *pool)
 {
 	mutex_destroy(&pool->lock);
@@ -139,8 +120,9 @@ mlx5_dma_pool_page_alloc(struct mlx5_dma_pool *pool)
 		goto err_free_page;
 
 	bitmap_fill(page->bitmap, blocks_per_page);
-	page->buf = mlx5_dma_zalloc_coherent_node(pool->dev, PAGE_SIZE,
-						  &page->dma, node);
+	page->buf = dma_alloc_coherent_node(mlx5_core_dma_dev(pool->dev),
+					    PAGE_SIZE, &page->dma, GFP_KERNEL,
+					    node);
 	if (!page->buf)
 		goto err_free_bitmap;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 1a45474ce03d..b06e7c5c6110 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1822,8 +1822,6 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 	INIT_LIST_HEAD(&priv->bfregs.reg_head.list);
 	INIT_LIST_HEAD(&priv->bfregs.wc_head.list);
 
-	mutex_init(&priv->alloc_mutex);
-
 	priv->numa_node = dev_to_node(mlx5_core_dma_dev(dev));
 	priv->dbg.dbg_root = debugfs_create_dir(dev_name(dev->device),
 						mlx5_debugfs_root);
@@ -1902,7 +1900,6 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 	mlx5_frag_buf_pools_cleanup(dev);
 err_frag_buf_pools_init:
 	debugfs_remove(dev->priv.dbg.dbg_root);
-	mutex_destroy(&priv->alloc_mutex);
 	mutex_destroy(&priv->bfregs.wc_head.lock);
 	mutex_destroy(&priv->bfregs.reg_head.lock);
 	mutex_destroy(&dev->intf_state_mutex);
@@ -1927,7 +1924,6 @@ void mlx5_mdev_uninit(struct mlx5_core_dev *dev)
 	mlx5_db_pools_cleanup(dev);
 	mlx5_frag_buf_pools_cleanup(dev);
 	debugfs_remove_recursive(dev->priv.dbg.dbg_root);
-	mutex_destroy(&priv->alloc_mutex);
 	mutex_destroy(&priv->bfregs.wc_head.lock);
 	mutex_destroy(&priv->bfregs.reg_head.lock);
 	mutex_destroy(&dev->wc_state_lock);
-- 
2.56.0

