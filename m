Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B304A261B
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062598; cv=none; b=SDZD/2fTQivKC5QT8f4mOYD8BBdwHMyiAMid8BZ59cGwF7G0gexIhsial0XTZv/A5msn1rrapc2XzHIQqVwmZro3jOvzuAYkxKZ5L9Z2OwSCye6+5iCynkqFksP0mGP2iTny0Va/SLJaxLeJt/LDeIvaRO4Np2SBkv4ro2pGqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062598; c=relaxed/simple;
	bh=3FnAcNdQeBpwauuPUEv8Hb+n/TAjxKWq99qHjkzEXiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UuAbBSFFifFKK0zSVjCViZucxO1G0YeXAhOB97GWp/nOHWhq0iDtlv6sbvrN2zYJYqjS63sK5wSnrHFS0pG17JVbtcrrazZC8SIH1zdVF0r8jgMbBHhxmWx6JZvBXNgHHDvW2H4MMpnI6CaOstX5NsfQukRcgyudd9/vyM/cWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAVgUD6t; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAVgUD6t"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2e77b7738cso46259166b.0
        for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062591; x=1791667391; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekKJz+HTYRvtVEqBBOEAxTGImVFcYe3lcvJJhW15OKU=;
        b=wAVgUD6tAHQiEw+/g2tPhiK3nmp88LZu9T9NMnNlv8pZFr1KeUB49u8i23Fz/bwcBk
         1OygIebY7wTDEAyFxBCvHR64JXe4k8OLKyCsoNxjavY/cQKN05kuYoGMlAubs8yg4Hhq
         5CBUB2f4hfZf/ET40Ii4DNtaM61rb4Q7ddDAOlgRUXy83iX+GtuK9vWHYri1rnBH8Gtz
         pHtyTi6yr34ENxKLyyBE23vukBKdYOLW9uv3EqjRpZJ05QJ+udQ/82L/0z5mNev+sdKG
         wWG1lsa30VFty0/1J3jDt1HQuLx1y9TtirOww5S09745DaendAemIk3e6Tt4ZHS0bKpM
         Ov4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062591; x=1791667391;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekKJz+HTYRvtVEqBBOEAxTGImVFcYe3lcvJJhW15OKU=;
        b=Qkmtb4EDx000ANaZ7gLausdKMpnm1Ylxy6VMH6czXx6BqzDwXR+NEoxBQEUvwRnaqi
         wZkTo10j6wrLtL9Dr5zTWv0M0HJ4nqgdqTzIJDlHelk0MuEAwLSYIg7brPR0fVsDgCiE
         bTaFXHIVReHTpx/tbD4A9fnFczNutubMRcQoZ53Q3YC3O8Jxz3OwX8/SC4k1DF806gQj
         h2jvB35QiI+QNmem7DLxqeNgWDfJN0YpQFG3VG1hU4xIaSzimB7+AcAD4K9kEMP2kyZG
         Ek+jvFvAGR5VPxnatBU6vtVLRQHJuCYyRwVDq1Tz9IhjFWT8p34BEMqbUVVDlfACIxhL
         2kYA==
X-Forwarded-Encrypted: i=1; AKwUvBz6NLK3ON+gVFj62xd8TfQdQcFy0EPkX/UlH/WfO23MtdsekaETv9meks9BQhabaWMmMPEySg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLsun6rJJkVYXY2lPuX4tsh5uV0nlgOXzBhY0oUqfnsfrAuc8JC
	aGbIRpoBNQQh5TuDCXF+S0BzTaJk4AFHt1nVXBoNQ8VP8OU4pMsI+LGoEyX3z3HoQJXPHlwodZF
	4iDiMqA==
X-Received: from ejbhk6.prod.google.com ([2002:a17:906:c9c6:b0:c2d:efb7:91a3])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:4fc9:b0:c2e:3307:b922
 with SMTP id a640c23a62f3a-c2e4ade0f4emr633013566b.28.1791062590162; Sat, 03
 Oct 2026 14:23:10 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:37 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-19-lrizzo@google.com>
Subject: [RFC: DMA_PMD 18/22] net/gve: Use DMA_PMD memory for tx header bounce buffers
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
bounce buffer per TX slot/packet out of the DMA_PMD arena in raw-addressing
mode (both GQI and DQO). When skb_headlen(skb) <= MAX_TCP_HEADER, the
linear portion is copied into the pre-mapped bounce buffer instead of
calling dma_map_single()/dma_unmap_single() on every packet.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  3 ++
 drivers/net/ethernet/google/gve/gve_tx.c     | 38 ++++++++++++++---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 45 +++++++++++++++-----
 3 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 11330404f681b..00e438fe05a50 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -18,6 +18,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/u64_stats_sync.h>
 #include <net/page_pool/helpers.h>
+#include <net/tcp.h>
 #include <net/xdp.h>
 
 #include "gve_desc.h"
@@ -642,6 +643,8 @@ struct gve_tx_ring {
 			};
 		} dqo;
 	} ____cacheline_aligned;
+	void *tx_hdr_bufs;
+	dma_addr_t tx_hdr_bufs_dma;
 	struct netdev_queue *netdev_txq;
 	struct gve_queue_resources *q_resources; /* head and tail pointer idx */
 	struct device *dev;
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 79338fd9bf66e..9610b54ef4792 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -224,6 +224,11 @@ static void gve_tx_free_ring_gqi(struct gve_priv *priv, struct gve_tx_ring *tx,
 	u32 slots;
 
 	slots = tx->mask + 1;
+	if (tx->tx_hdr_bufs) {
+		dma_free_coherent(hdev, slots * MAX_TCP_HEADER,
+				  tx->tx_hdr_bufs, tx->tx_hdr_bufs_dma);
+		tx->tx_hdr_bufs = NULL;
+	}
 	dma_free_coherent(hdev, sizeof(*tx->q_resources),
 			  tx->q_resources, tx->q_resources_bus);
 	tx->q_resources = NULL;
@@ -298,6 +303,11 @@ static int gve_tx_alloc_ring_gqi(struct gve_priv *priv,
 		/* map Tx FIFO */
 		if (gve_tx_fifo_init(priv, &tx->tx_fifo))
 			goto abort_with_qpl;
+	} else if (hdev->dma_pmd_tx_hdrs) {
+		tx->tx_hdr_bufs = dma_alloc_coherent(hdev,
+						     cfg->ring_size * MAX_TCP_HEADER,
+						     &tx->tx_hdr_bufs_dma,
+						     GFP_KERNEL);
 	}
 
 	tx->q_resources =
@@ -311,6 +321,12 @@ static int gve_tx_alloc_ring_gqi(struct gve_priv *priv,
 	return 0;
 
 abort_with_fifo:
+	if (tx->tx_hdr_bufs) {
+		dma_free_coherent(hdev,
+				  cfg->ring_size * MAX_TCP_HEADER,
+				  tx->tx_hdr_bufs, tx->tx_hdr_bufs_dma);
+		tx->tx_hdr_bufs = NULL;
+	}
 	if (!tx->raw_addressing)
 		gve_tx_fifo_release(priv, &tx->tx_fifo);
 abort_with_qpl:
@@ -423,6 +439,8 @@ static inline int gve_skb_fifo_bytes_required(struct gve_tx_ring *tx,
 #define MAX_TX_DESC_NEEDED	(MAX_SKB_FRAGS + 4)
 static void gve_tx_unmap_buf(struct device *dev, struct gve_tx_buffer_state *info)
 {
+	if (!dma_unmap_len(info, len))
+		return;
 	if (info->skb) {
 		dma_unmap_single(dev, dma_unmap_addr(info, dma),
 				 dma_unmap_len(info, len),
@@ -657,13 +675,21 @@ static int gve_tx_add_skb_no_copy(struct gve_priv *priv, struct gve_tx_ring *tx,
 
 	info->skb =  skb;
 
-	addr = dma_map_single(tx->dev, skb->data, len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(tx->dev, addr))) {
-		tx->dma_mapping_error++;
-		goto drop;
+	if (tx->tx_hdr_bufs && len <= MAX_TCP_HEADER) {
+		u32 hdr_off = idx * MAX_TCP_HEADER;
+
+		memcpy(tx->tx_hdr_bufs + hdr_off, skb->data, len);
+		addr = tx->tx_hdr_bufs_dma + hdr_off;
+		dma_unmap_len_set(info, len, 0);
+	} else {
+		addr = dma_map_single(tx->dev, skb->data, len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx->dev, addr))) {
+			tx->dma_mapping_error++;
+			goto drop;
+		}
+		dma_unmap_len_set(info, len, len);
+		dma_unmap_addr_set(info, dma, addr);
 	}
-	dma_unmap_len_set(info, len, len);
-	dma_unmap_addr_set(info, dma, addr);
 
 	num_descriptors = 1 + shinfo->nr_frags;
 	if (hlen < len)
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index ad99cbb77e291..ac69793492c9f 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -176,8 +176,9 @@ static void gve_unmap_packet(struct device *dev,
 		return;
 
 	/* SKB linear portion is guaranteed to be mapped */
-	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
-			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
+	if (dma_unmap_len(pkt, len[0]))
+		dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
+				 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
 	for (i = 1; i < pkt->num_bufs; i++) {
 		netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[i]),
 					    dma_unmap_len(pkt, len[i]),
@@ -232,6 +233,13 @@ static void gve_tx_free_ring_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 	size_t bytes;
 	u32 qpl_id;
 
+	if (tx->tx_hdr_bufs) {
+		dma_free_coherent(hdev,
+				  tx->dqo.num_pending_packets * MAX_TCP_HEADER,
+				  tx->tx_hdr_bufs, tx->tx_hdr_bufs_dma);
+		tx->tx_hdr_bufs = NULL;
+	}
+
 	if (tx->q_resources) {
 		dma_free_coherent(hdev, sizeof(*tx->q_resources),
 				  tx->q_resources, tx->q_resources_bus);
@@ -399,6 +407,12 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 
 		if (gve_tx_qpl_buf_init(tx))
 			goto err;
+	} else if (hdev->dma_pmd_tx_hdrs) {
+		tx->tx_hdr_bufs =
+			dma_alloc_coherent(hdev,
+					   tx->dqo.num_pending_packets * MAX_TCP_HEADER,
+					   &tx->tx_hdr_bufs_dma,
+					   GFP_KERNEL);
 	}
 
 	return 0;
@@ -712,12 +726,20 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 		u32 len = skb_headlen(skb);
 		dma_addr_t addr;
 
-		addr = dma_map_single(tx->dev, skb->data, len, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(tx->dev, addr)))
-			goto err;
+		if (tx->tx_hdr_bufs && len <= MAX_TCP_HEADER) {
+			u32 hdr_off = (u32)completion_tag * MAX_TCP_HEADER;
 
-		dma_unmap_len_set(pkt, len[pkt->num_bufs], len);
-		dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
+			memcpy(tx->tx_hdr_bufs + hdr_off, skb->data, len);
+			addr = tx->tx_hdr_bufs_dma + hdr_off;
+			dma_unmap_len_set(pkt, len[pkt->num_bufs], 0);
+		} else {
+			addr = dma_map_single(tx->dev, skb->data, len,
+					      DMA_TO_DEVICE);
+			if (unlikely(dma_mapping_error(tx->dev, addr)))
+				goto err;
+			dma_unmap_len_set(pkt, len[pkt->num_bufs], len);
+			dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
+		}
 		++pkt->num_bufs;
 
 		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, enable_csum, len, addr,
@@ -748,10 +770,11 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 err:
 	for (i = 0; i < pkt->num_bufs; i++) {
 		if (i == 0) {
-			dma_unmap_single(tx->dev,
-					 dma_unmap_addr(pkt, dma[i]),
-					 dma_unmap_len(pkt, len[i]),
-					 DMA_TO_DEVICE);
+			if (dma_unmap_len(pkt, len[i]))
+				dma_unmap_single(tx->dev,
+						 dma_unmap_addr(pkt, dma[i]),
+						 dma_unmap_len(pkt, len[i]),
+						 DMA_TO_DEVICE);
 		} else {
 			dma_unmap_page(tx->dev,
 				       dma_unmap_addr(pkt, dma[i]),
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

