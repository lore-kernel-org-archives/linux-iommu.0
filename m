Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067972;
	b=NkoUEWaa2+BFiy4tPy9/4gWBgkD/9zoOpli/dmlTQ4yUU2tJL1KmKQ6l9TjYqk9tEZYy
	 L7ffEV5cwYub7nj9qERCX66PGk7HKOxu4mhhbAenSTNwEMoK/fztOuMFRNgA0/rXvdY1q
	 czdranhfOLWzCr+ucpooPSv0HsariiphGadg51P5/KFwKMhfBORoUFv1Q5rDrw//IXpS0
	 A6GQ1S0HPlJqC3zYqBYUAe6IT5Sw0n3EYq4MlrtZYd8++iDVaCxwzJ8Sc7yNe5SOmk0lm
	 U4ibUJt7tW94djzYjUIdaJ2Bf3dRvzWKb/xhSBK9nvJJBqK/Obw4hAj/CS02AzYvLAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067972;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sFMJ9G+BCCkIGTPexs2eTVxqNd1RzrfJlfVrNTosRLA=;
	b=mF4k9iGF2Mha6uzPzUFQps3opLWjlZJbwcXMFq7bRLFrpIN5+HGCQxnHWteUdoMLQug9
	 lJnPXbiAdp4jUaMUz1N55pKp9Awc+cb8H6Hzb5ZO/IHCFr40QmP0ZRKspxVuYWTER5O55
	 71d4TzDJ0vYr2694IkqxnKDdBXSq+6sIRqN/JrXWQ3ybe99Uq0IsZPnN1UC97xhWSuL7h
	 3CEOK/4xE7fIfy2VVcFx19XM0XPj0S0BP6Iu5PTI+FvDE7lr+b8Ef1BS+LYmm++59mYpb
	 FJD1z7+WKplhA1TMDLAz0v2Hg7kEeGvlJ8QB8x6LCRufWbo0XRLUrlr1LWEcBCRhRhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tias2084;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CC606A32F;
	Tue, 27 Oct 2026 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tias2084
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A664F1F031E0;
	Tue, 27 Oct 2026 02:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067972;
	bh=sFMJ9G+BCCkIGTPexs2eTVxqNd1RzrfJlfVrNTosRLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tias2084e9gMkncSNqg5FbzbyN8PJTgblajFs43jPT7r6lNl99xyFDj+OHYAWIm/D
	 Op+oHB6dHaQabgTWZzyT7o4peOabLYIxeUXpWAcWRS8uYB/1w2D4mek/8G4pSgdGPb
	 EjRbG6xIEFtPGwbpMrli3sipBu/2xhMjIgsLAfA74lqEnf96tSTYKBdL4SAfLlgom3
	 5LD4dZbxqPgoEtL5eDvcT+zxLBj+bJIKYuRdyrzvGfh2hIwKjtOQRmjhFFQuvZ/Fru
	 vg4ReMs2pXsrCnZUkCcMdtXiwsrGp+EraOg2RTya0TLe2dqlKa44rn2vnbgEK5XQrw
	 g+n8c2g5Gkl8A==
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
Subject: [RFC 10/11] eth: mlx5: use dma_alloc_coherent_node()
Date: Mon, 26 Oct 2026 19:25:27 -0700
Message-ID: <20261027022528.633359-11-kuba@kernel.org>
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

Use dma_alloc_coherent_node() to allocate the DMA pool pages on the
pool's node, instead of temporarily changing the node of the device.
alloc_mutex only serialized those temporary changes, remove it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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

