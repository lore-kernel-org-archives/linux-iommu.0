Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE949AA4A
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062602; cv=none; b=ZDuwijCP4vZnnOspG0jaKqoFslMtlYf7pEFhPFy7UC8y9hYDzBNfJpklR2CJfcOU6LGhNWZXYpH5GpFY/DY/24WfxeQcTte83K4fMlkZAPKKFRzd1j71G4VbK1jJ71T1zXD/iccs4dKefSmx+DM2fQzw/AR+D7INOJXG3TndfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062602; c=relaxed/simple;
	bh=0UEzNPYoMtYU8V6tV9CGaZXf2SYy9Eg3sYnpmfOu5WA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dsdFEUqt1k9gY6SfuRHyY/EbJ/ruqR5nl7KA9zdJ1IIzTZdbxw8mO+5rhs2wn3MHLB1SBqCa2wQqqHgcnZlzu6KJ41HcHJ5XoKwiXM/57p8Cehaw3beXQGge0KOkvXaVDXqxNk3bpgiAPws2+IJIsOdjOBnDpzCkORubi6bEFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJMBKoPT; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJMBKoPT"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a98570af94so805471a12.1
        for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062592; x=1791667392; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aZwzLkeC5Zd1WFKT0DwnrS8SKkPjkbpjbdTgKohmOY=;
        b=fJMBKoPTGicH6r/VUyV+ojpQLrOF1KJlgqKYAxoaPNYBkLCL+RXkiem+vYrQQ1x2tI
         3hCUKDU8MAyK/1O1VhaOvqv5koRI+aocrAygWIYzayu94Cb70iw41uEjxUiFNZpT5uQT
         KLmPoR2vpOr3kK7mCtgTdn4Q94TrEFbYocRonMZMHJBpas0YueKi3TmbGWqCEC0SqRnz
         fR00A8HHI08aEjI2fzoBFR5ctTnJlB3j37+OFum7ThMcbpnTHVtRkkQRJBp4YY0BJzHM
         VuhfY/oCS9wuLNpJjgyLPK80wEVCE7Czy5qN7MBqbjt0tbdgCyjPBG/jaNnnh/Gw1xm3
         O7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062592; x=1791667392;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aZwzLkeC5Zd1WFKT0DwnrS8SKkPjkbpjbdTgKohmOY=;
        b=xzpUOhDLO4sjzIq062PKaiPPTTlCm/xRY0hDyIoHUxh4qMqFC3z0K+SCgkfN6Et4nj
         Y9Fl1hDbecwSbF4qi0TSfn85HfUGK79MMFXTU8303wsPWQXzXj6MfwZtBcA+gH6KiAY8
         MuJy3bCI5CFzKDSfvRKUm+r491gmkb1NQE59xgLWRzM7iMzPASHSOLQOgeRMIDqXHoMj
         dT8E8uyFkO3tmt+tLOlglwh30bnZ5Dm7Kod5OstHagmOGfNqbOLnpuLcJRZSfMrMRkWi
         7PJSkABg4M8p4AGkvcKkjuWbJ5wr45LSjtRREyCr+hAGoqnH7JKRiDyD+aUZlsU09Ox5
         zcAw==
X-Forwarded-Encrypted: i=1; AKwUvBwlqrsxi9KX1bBoft/eK+5F8vlXA9SKGVzfnFO+SiOhEE57BDQ8vQEJtvExV+3mR7Lgvsie0A==@lists.linux.dev
X-Gm-Message-State: AFuF++n1mEDHdct8ls5A2kW055dmM/J5FnJQVLyxTSSxJl7HqHybAOma
	Vr7WBACEXEBdqt7R8KdjHVl9UR13M0RR15SssJetCVTIQNgQFAycCAQg0cWfysZHf9pCNr+Ga6r
	kdR7Htg==
X-Received: from ejcfv45.prod.google.com ([2002:a17:907:50ad:b0:c2e:8121:1730])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9728:b0:c2e:7fe7:2898
 with SMTP id a640c23a62f3a-c2e7fe738bbmr76710966b.12.1791062591766; Sat, 03
 Oct 2026 14:23:11 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:38 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-20-lrizzo@google.com>
Subject: [RFC: DMA_PMD 19/22] net/mlx5e: Use DMA_PMD memory for tx header
 bounce buffers
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

When dev->dma_pmd_tx_hdrs is enabled, allocate a MAX_TCP_HEADER
bounce buffer per TX DMA FIFO slot out of the DMA_PMD arena. When the
linear portion of a transmitted packet is at most MAX_TCP_HEADER bytes,
copy it into the pre-mapped bounce buffer instead of calling
dma_map_single()/dma_unmap_single() on every packet.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 ++
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 28 +++++++++++++++----
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index a3945195f454e..d762ad1c1ffaf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -442,6 +442,8 @@ struct mlx5e_txqsq {
 		struct mlx5e_sq_dma       *dma_fifo;
 		struct mlx5e_skb_fifo      skb_fifo;
 		struct mlx5e_tx_wqe_info  *wqe_info;
+		void                      *tx_hdr_bufs;
+		dma_addr_t                 tx_hdr_bufs_dma;
 	} db;
 	void __iomem              *uar_map;
 	struct netdev_queue       *txq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index f2a8453d8dce0..6de7a2a430d72 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -365,7 +365,9 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
 {
 	switch (dma->type) {
 	case MLX5E_DMA_MAP_SINGLE:
-		dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
+		if (dma->size)
+			dma_unmap_single(pdev, dma->addr, dma->size,
+					 DMA_TO_DEVICE);
 		break;
 	case MLX5E_DMA_MAP_PAGE:
 		netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4c6060d54fbed..efd766aa43a02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1666,6 +1666,13 @@ static void mlx5e_free_icosq(struct mlx5e_icosq *sq)
 
 void mlx5e_free_txqsq_db(struct mlx5e_txqsq *sq)
 {
+	if (sq->db.tx_hdr_bufs) {
+		int wq_sz = mlx5_wq_cyc_get_size(&sq->wq);
+		int df_sz = wq_sz * MLX5_SEND_WQEBB_NUM_DS;
+
+		dma_free_coherent(sq->pdev, df_sz * MAX_TCP_HEADER,
+				  sq->db.tx_hdr_bufs, sq->db.tx_hdr_bufs_dma);
+	}
 	kvfree(sq->db.wqe_info);
 	kvfree(sq->db.skb_fifo.fifo);
 	kvfree(sq->db.dma_fifo);
@@ -1690,6 +1697,13 @@ int mlx5e_alloc_txqsq_db(struct mlx5e_txqsq *sq, int numa)
 		return -ENOMEM;
 	}
 
+	if (sq->pdev->dma_pmd_tx_hdrs)
+		sq->db.tx_hdr_bufs =
+			dma_alloc_coherent(sq->pdev,
+					   df_sz * MAX_TCP_HEADER,
+					   &sq->db.tx_hdr_bufs_dma,
+					   GFP_KERNEL | __GFP_NOWARN);
+
 	sq->dma_fifo_mask = df_sz - 1;
 
 	sq->db.skb_fifo.pc   = &sq->skb_fifo_pc;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 0b5e600e4a6a9..3b6a7a8b0128e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -177,6 +177,27 @@ mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb)
 	return ihs;
 }
 
+static inline dma_addr_t
+mlx5e_tx_map_hdr(struct mlx5e_txqsq *sq, unsigned char *data, u32 len)
+{
+	dma_addr_t dma_addr;
+
+	if (sq->db.tx_hdr_bufs && len <= MAX_TCP_HEADER) {
+		u32 off = (sq->dma_fifo_pc & sq->dma_fifo_mask) *
+			  MAX_TCP_HEADER;
+
+		memcpy(sq->db.tx_hdr_bufs + off, data, len);
+		dma_addr = sq->db.tx_hdr_bufs_dma + off;
+		mlx5e_dma_push_single(sq, dma_addr, 0);
+		return dma_addr;
+	}
+
+	dma_addr = dma_map_single(sq->pdev, data, len, DMA_TO_DEVICE);
+	if (likely(!dma_mapping_error(sq->pdev, dma_addr)))
+		mlx5e_dma_push_single(sq, dma_addr, len);
+	return dma_addr;
+}
+
 static inline int
 mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 			unsigned char *skb_data, u16 headlen,
@@ -187,8 +208,7 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	int i;
 
 	if (headlen) {
-		dma_addr = dma_map_single(sq->pdev, skb_data, headlen,
-					  DMA_TO_DEVICE);
+		dma_addr = mlx5e_tx_map_hdr(sq, skb_data, headlen);
 		if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
 			goto dma_unmap_wqe_err;
 
@@ -196,7 +216,6 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		dseg->lkey       = sq->mkey_be;
 		dseg->byte_count = cpu_to_be32(headlen);
 
-		mlx5e_dma_push_single(sq, dma_addr, headlen);
 		num_dma++;
 		dseg++;
 	}
@@ -578,7 +597,7 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	txd.data = skb->data;
 	txd.len = skb->len;
 
-	txd.dma_addr = dma_map_single(sq->pdev, txd.data, txd.len, DMA_TO_DEVICE);
+	txd.dma_addr = mlx5e_tx_map_hdr(sq, txd.data, txd.len);
 	if (unlikely(dma_mapping_error(sq->pdev, txd.dma_addr)))
 		goto err_unmap;
 
@@ -591,7 +610,6 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 	sq->stats->xmit_more += xmit_more;
 
-	mlx5e_dma_push_single(sq, txd.dma_addr, txd.len);
 	mlx5e_skb_fifo_push(&sq->db.skb_fifo, skb);
 	mlx5e_tx_mpwqe_add_dseg(sq, &txd);
 	mlx5e_tx_skb_update_ts_flags(skb);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

