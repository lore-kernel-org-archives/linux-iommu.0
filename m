Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067973;
	b=wHoERo90KPbdOuA4Zyr8Ssc2WwnQg8XSEPkQ5FK+Z0b/O5v1pcdEuhb7mLy4G/ybvg2G
	 eA+I0qlY+527KG2/9f9YTt6sN3j31v4ZGrfYliUiTd45lGvDH5Wwu/cCXmQoGyqtSC/4X
	 OIXUkuWZMcfrmTMvf9Idn1iCk1lB1na1HqYVuwWnoT4Qfm70qm+BpT4ZH0Oou8rWrv7Gg
	 1qELDUuDlxfvimo6eh+fIxEfsLPXkoVBY7e8B3gzEjYHQkkY4hBOAQOSAPqN4aVlPugrq
	 tWJ9e44PQZBSOjF4WzUvqUqIaH9JreBO+DMMIJ/u9NhKNmhOKT+hZXOtU4qLMC1C3dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067973;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+fhQ87zw1kfozXsBG6wYTMDs1/rHV55pF74dX6fAbLw=;
	b=wcJPKjgHJOUKqs0noNWbLWonDIz0xNtDIxQC7DvxhBGc9KT66tFcHHyvQ/1V45kaA47o
	 mRWk4+CDIwQJZLICtKlLUyFsElyyY3N56kwm2slOUIGOpgtKmjWkQt80artyp2KRRqveT
	 ei5fQuCblnGV8YZqg6Jv/RuneHUdEJ6akliJenYaYy9QGKETP8DbHnbeY3NQkBhzNpAcM
	 vcGIoNZIeykk/vubRNiFvIBD9gRdHint8m2B1PlFMta+hPMuptIyoXTdBHmpZmz8FEIxa
	 H+b/J72z7XtbQmLpji4elK2W9QrP2+apZIfZgIjwEW99rD7B+AKCOsRwcJr3qWU/rAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RECmm0Bf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DB606A33F;
	Tue, 27 Oct 2026 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RECmm0Bf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661B11F01828;
	Tue, 27 Oct 2026 02:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067972;
	bh=+fhQ87zw1kfozXsBG6wYTMDs1/rHV55pF74dX6fAbLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RECmm0BfvtLsnubDzRMS2u/UQdIeTgeBTuxaap6qQ5q+9vbeEn2nT7LRTDOGZ9CRH
	 1NluXLnFQCdTNKY7/978t2et4Uubr39cxdkt2lNcm3lQJi3wotbdfLqUGZlylyRURd
	 83ku6NqjZZz30Z4iwnRcRl9DIgenb/fCoPsRBWBE+s0/N25p1CuvsEyGChKgCF/fIy
	 aq8G3uKiDPQsSKjJYsWwrOsKhBNVfqiz/gyJ77he/HEXJxdJSAPwO1MTAUS/HYSAv6
	 +GR5HvS8K/UnNOEFeD6WRfEdgyytAUd13kjtM1wItzMeuIuVPZmo/fP3EoZTat/P1M
	 IldTbBZuoEUIQ==
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
Subject: [RFC 11/11] eth: mlx4: use dma_alloc_coherent_node()
Date: Mon, 26 Oct 2026 19:25:28 -0700
Message-ID: <20261027022528.633359-12-kuba@kernel.org>
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

mlx4_en temporarily changes the node of the device around
mlx4_alloc_hwq_res() to place the queue buffers on the queue's node.
This is racy against other users of the device's node, e.g. mlx4_ib
allocating its own buffers at the same time.

Add a node argument to mlx4_alloc_hwq_res() and use
dma_alloc_coherent_node() for the queue buffer. mlx4_buf_alloc()
and the en_netdev page keep using the device's node.

The comment about the MTT allocation was stale, the MTT ICM is not
coherent and uses mlx4_dev->numa_node, which set_dev_node() did not
affect.

The doorbell record pages, which mlx4_db_alloc() allocates on demand
and shares between all queues, now always come from the device's node.
So far they ended up on the node of whichever queue happened to need
a new page.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/mlx4/device.h                    |  2 +-
 drivers/net/ethernet/mellanox/mlx4/alloc.c     | 12 ++++++------
 drivers/net/ethernet/mellanox/mlx4/en_cq.c     |  9 ++-------
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c     |  5 ++---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c     |  5 ++---
 6 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index f016263e1fcf..0d34e0e18580 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1139,7 +1139,7 @@ int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order);
 void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
 
 int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
-		       int size);
+		       int size, int node);
 void mlx4_free_hwq_res(struct mlx4_dev *mdev, struct mlx4_hwq_resources *wqres,
 		       int size);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index 7ed4452e20a9..0621347112df 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -553,7 +553,7 @@ u32 mlx4_zone_free_entries_unique(struct mlx4_zone_allocator *zones, u32 obj, u3
 }
 
 static int mlx4_buf_direct_alloc(struct mlx4_dev *dev, int size,
-				 struct mlx4_buf *buf)
+				 struct mlx4_buf *buf, int node)
 {
 	dma_addr_t t;
 
@@ -561,8 +561,8 @@ static int mlx4_buf_direct_alloc(struct mlx4_dev *dev, int size,
 	buf->npages       = 1;
 	buf->page_shift   = get_order(size) + PAGE_SHIFT;
 	buf->direct.buf   =
-		dma_alloc_coherent(&dev->persist->pdev->dev, size, &t,
-				   GFP_KERNEL);
+		dma_alloc_coherent_node(&dev->persist->pdev->dev, size, &t,
+					GFP_KERNEL, node);
 	if (!buf->direct.buf)
 		return -ENOMEM;
 
@@ -585,7 +585,7 @@ int mlx4_buf_alloc(struct mlx4_dev *dev, int size, int max_direct,
 		   struct mlx4_buf *buf)
 {
 	if (size <= max_direct) {
-		return mlx4_buf_direct_alloc(dev, size, buf);
+		return mlx4_buf_direct_alloc(dev, size, buf, dev->numa_node);
 	} else {
 		dma_addr_t t;
 		int i;
@@ -749,7 +749,7 @@ void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db)
 EXPORT_SYMBOL_GPL(mlx4_db_free);
 
 int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
-		       int size)
+		       int size, int node)
 {
 	int err;
 
@@ -759,7 +759,7 @@ int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
 
 	*wqres->db.db = 0;
 
-	err = mlx4_buf_direct_alloc(dev, size, &wqres->buf);
+	err = mlx4_buf_direct_alloc(dev, size, &wqres->buf, node);
 	if (err)
 		goto err_db;
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 0e92956e84cf..6c47509422f6 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -65,13 +65,8 @@ int mlx4_en_create_cq(struct mlx4_en_priv *priv,
 	cq->type = mode;
 	cq->vector = mdev->dev->caps.num_comp_vectors;
 
-	/* Allocate HW buffers on provided NUMA node.
-	 * dev->numa_node is used in mtt range allocation flow.
-	 */
-	set_dev_node(&mdev->dev->persist->pdev->dev, node);
-	err = mlx4_alloc_hwq_res(mdev->dev, &cq->wqres,
-				cq->buf_size);
-	set_dev_node(&mdev->dev->persist->pdev->dev, mdev->dev->numa_node);
+	/* Allocate HW buffers on provided NUMA node */
+	err = mlx4_alloc_hwq_res(mdev->dev, &cq->wqres, cq->buf_size, node);
 	if (err)
 		goto err_cq;
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 071564c54522..68f1eb57c32a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3299,7 +3299,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 
 	/* Allocate page for receive rings */
 	err = mlx4_alloc_hwq_res(mdev->dev, &priv->res,
-				MLX4_EN_PAGE_SIZE);
+				 MLX4_EN_PAGE_SIZE, mdev->dev->numa_node);
 	if (err) {
 		en_err(priv, "Failed to allocate page for rx qps\n");
 		goto out;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index fe18606c2ab5..e2d97ecbafd2 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -292,9 +292,8 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
 		 ring->rx_info, tmp);
 
 	/* Allocate HW buffers on provided NUMA node */
-	set_dev_node(&mdev->dev->persist->pdev->dev, node);
-	err = mlx4_alloc_hwq_res(mdev->dev, &ring->wqres, ring->buf_size);
-	set_dev_node(&mdev->dev->persist->pdev->dev, mdev->dev->numa_node);
+	err = mlx4_alloc_hwq_res(mdev->dev, &ring->wqres, ring->buf_size,
+				 node);
 	if (err)
 		goto err_info;
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index c5d564e5a581..9865ccd8d6e9 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -91,9 +91,8 @@ int mlx4_en_create_tx_ring(struct mlx4_en_priv *priv,
 	ring->buf_size = ALIGN(size * ring->sp_stride, MLX4_EN_PAGE_SIZE);
 
 	/* Allocate HW buffers on provided NUMA node */
-	set_dev_node(&mdev->dev->persist->pdev->dev, node);
-	err = mlx4_alloc_hwq_res(mdev->dev, &ring->sp_wqres, ring->buf_size);
-	set_dev_node(&mdev->dev->persist->pdev->dev, mdev->dev->numa_node);
+	err = mlx4_alloc_hwq_res(mdev->dev, &ring->sp_wqres, ring->buf_size,
+				 node);
 	if (err) {
 		en_err(priv, "Failed allocating hwq resources\n");
 		goto err_bounce;
-- 
2.56.0

