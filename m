Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDC4A2631
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062598; cv=none; b=ZK0eZZE4w/yWbMGelwaP+jmoPLEojUCgsAKOGyHSB8P7nE6lZPArOGxD6l5Y3u53hly1t2E/7EG2vhqR+oSXcj3KXZNK7uxCPdb4+v2DofxOi0HgVBGKW0vU3/5foxaoTE6J0f4z1BcehdHQpnEXLu60TK4SRHNpOVq/ACTgdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062598; c=relaxed/simple;
	bh=EgAxeOjDc3nvKbooFebIjz9Kp87TEB8CgostF/3vXXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WhY1YmLgYfRgD70eQKbsWmO83QUl+R4hyRrLKaYdddj5+semsAP0x9AkUgMjvMge+ocSDsmTF5bA4GTmFtWrfr26H6Ii5x2HIbzwGyipLebYZWsMHM7i4WaqNCZYS442T35ojK7lkZ2tPlwH35ce3/mlOZFIWaF7aQdKrftcDWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYT9+eJY; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYT9+eJY"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c293e604f0eso70787566b.3
        for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062589; x=1791667389; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7zE5K72n+KulUAR4TVMzQ2qmXtrugcAg+vwkNaLgqTo=;
        b=jYT9+eJY4+1qF4WzjTZqCDaIOasOKP/wHQm2DZg19P8mk6E0rMSiwZ3wvzLtiLEKDN
         fR2pn1W1Mxip/a/ltQ+1kbvAJ7imkZNxOQNWqASgBz02GM/eaS/UJfmDuLTcBO6pOHgo
         yXSrPYKg+d+9v7FHYxHrwTvNh6C3BqTw7MWsXqXEd1i0b4cp+YOzbRH0da4z4Cq4o30g
         9ERcD23QJkJ+vYJZ6urfZBK+GR4nd4HKKVjnfPuGizGO8+CiIR6xyYXfBNJi98N3USut
         SOVUU3ie0GPlsz32PoJQvXSjqnMdcb/EMIBBLrCHFuxjk4mJqTDXjJkTrK6t5CNgjMel
         tyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062589; x=1791667389;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7zE5K72n+KulUAR4TVMzQ2qmXtrugcAg+vwkNaLgqTo=;
        b=G9xtXT7alWg1Za9gwcsQNsrlWKvOkXLr63OCr4OAPzQFWFHgKclr/6SYh2xjXTDqZk
         uUQNG1fqAeaV8McVjDHFxXsPJ7EQSUoZf++o1eM31eLaZwAD2VgPFMtEsWQso8wV6WjI
         0aRH3lL6GS9TsY5zq7J42MsJaBZxvcE5nqPPMVlGvyq8cUN14E25HfzbT8XwNoIDjegP
         Vsm+I9udEHLR+4VgQ0PHdSXeLhS4vxyugY86BKXa66f/xj1bsC0VsxWYpRWBU/9gkB/M
         xLquFY3JeMrEvP6TP2uk9mJVoUz/18qUxE7Arhpx6m0rIZt4GRIJD5N4yGGFLA2K6YFN
         BoCQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3vUk/CTy8fbfq1bTSRvgqvVII2jcTr3Z4QnM6Y10K46s8nV2kWYzlxnx+notswGGEWzaAxQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ndpP10mCl+z84mrAMwjzwXVO/Ymq/iNEc3znF/FQuxmpeYM9wE
	Nv3AWJMKrABp8XrvefspOkie/S7wPERD4/MEys/WZytQ5iy6rmshdVyVumim9a5T9iORbasFOUz
	Q2Ky1IQ==
X-Received: from ejiu17.prod.google.com ([2002:a17:906:ed1:b0:c2e:4ce4:b30])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:94cf:b0:c27:420b:7c90
 with SMTP id a640c23a62f3a-c2e6f278111mr294082166b.48.1791062588878; Sat, 03
 Oct 2026 14:23:08 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:36 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-18-lrizzo@google.com>
Subject: [RFC: DMA_PMD 17/22] net/gve: Use DMA_PMD memory for RX buffers
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

When dev->dma_pmd_rxbuf is enabled, back GQI-RDA RX packet buffers with
a per-queue DMA_PMD page pool (rx->dma_pmd_pool); DQO-RDA uses page_pool,
which checks dev->dma_pmd_rxbuf directly.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      |  2 +
 drivers/net/ethernet/google/gve/gve_main.c |  5 ++
 drivers/net/ethernet/google/gve/gve_rx.c   | 61 ++++++++++++++++------
 3 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c280ff35ee771..11330404f681b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/ethtool_netlink.h>
+#include <linux/dma-pmd.h>
 #include <linux/netdevice.h>
 #include <linux/net_tstamp.h>
 #include <linux/pci.h>
@@ -258,6 +259,7 @@ struct gve_rx_ring {
 			u32 qpl_copy_pool_mask;
 			u32 qpl_copy_pool_head;
 			struct gve_rx_slot_page_info *qpl_copy_pool;
+			struct dma_pmd_pool *dma_pmd_pool;
 		};
 
 		/* DQO fields. */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 9cc343a162712..e5631987b050f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1055,6 +1055,11 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
 	if (err)
 		goto free_tx;
 
+	if (rx_alloc_cfg->raw_addressing && priv->pdev->dev.dma_pmd_rxbuf)
+		dev_info(&priv->pdev->dev,
+			 "DMA_PMD rx_bufs pool: enabled on %u RX queue(s)\n",
+			 rx_alloc_cfg->qcfg_rx->num_queues);
+
 	return 0;
 
 free_tx:
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 81ea800e66e94..45b5e841efcd3 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -121,6 +121,7 @@ void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
 	}
 
 	gve_rx_unfill_pages(priv, rx, cfg);
+	rx->dma_pmd_pool = dma_pmd_pool_destroy(rx->dma_pmd_pool);
 
 	if (rx->data.data_ring) {
 		bytes = sizeof(*rx->data.data_ring) * slots;
@@ -159,14 +160,29 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
 static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
 			       struct gve_rx_slot_page_info *page_info,
 			       union gve_rx_data_slot *data_slot,
-			       struct gve_rx_ring *rx)
+			       struct gve_rx_ring *rx, gfp_t gfp)
 {
-	struct page *page;
+	struct page *page = NULL;
 	dma_addr_t dma;
-	int err;
+	int err = 0;
 
-	err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE,
-			     GFP_ATOMIC);
+	if (rx->dma_pmd_pool) {
+		page = dma_pmd_pool_alloc_node(rx->dma_pmd_pool,
+					       gfp | __GFP_NOWARN, priv->numa_node);
+		if (page) {
+			dma = dma_map_page(dev, page, 0, PAGE_SIZE,
+					   DMA_FROM_DEVICE);
+			if (dma_mapping_error(dev, dma)) {
+				priv->dma_mapping_error++;
+				put_page(page);
+				page = NULL;
+				err = -ENOMEM;
+			}
+		}
+	}
+	if (!page && !err)
+		err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE,
+				     gfp);
 	if (err) {
 		u64_stats_update_begin(&rx->statss);
 		rx->rx_buf_alloc_fail++;
@@ -209,7 +225,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 		}
 		err = gve_rx_alloc_buffer(priv, &priv->pdev->dev,
 					  &rx->data.page_info[i],
-					  &rx->data.data_ring[i], rx);
+					  &rx->data.data_ring[i], rx,
+					  GFP_KERNEL);
 		if (err)
 			goto alloc_err_rda;
 	}
@@ -319,6 +336,8 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 			err = -ENOMEM;
 			goto abort_with_copy_pool;
 		}
+	} else if (hdev->dma_pmd_rxbuf) {
+		rx->dma_pmd_pool = dma_pmd_pool_create(0, 8);
 	}
 
 	filled_pages = gve_rx_prefill_pages(rx, cfg);
@@ -365,6 +384,7 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 abort_filled:
 	gve_rx_unfill_pages(priv, rx, cfg);
 abort_with_qpl:
+	rx->dma_pmd_pool = dma_pmd_pool_destroy(rx->dma_pmd_pool);
 	if (!rx->data.raw_addressing) {
 		gve_free_queue_page_list(priv, rx->data.qpl, qpl_id);
 		rx->data.qpl = NULL;
@@ -495,13 +515,19 @@ static void gve_rx_flip_buff(struct gve_rx_slot_page_info *page_info, __be64 *sl
 	*(slot_addr) ^= offset;
 }
 
-static int gve_rx_can_recycle_buffer(struct gve_rx_slot_page_info *page_info)
+static int gve_rx_can_recycle_buffer(struct gve_rx_ring *rx,
+				     struct gve_rx_slot_page_info *page_info)
 {
 	int pagecount = page_count(page_info->page);
 
 	/* This page is not being used by any SKBs - reuse */
-	if (pagecount == page_info->pagecnt_bias)
+	if (pagecount == page_info->pagecnt_bias) {
+		if (rx && rx->dma_pmd_pool &&
+		    !dma_is_pmd_page(page_to_pfn(page_info->page)) &&
+		    dma_pmd_pool_has_free(rx->dma_pmd_pool))
+			return 0;
 		return 1;
+	}
 	/* This page is still being used by an SKB - we can't reuse */
 	else if (pagecount > page_info->pagecnt_bias)
 		return 0;
@@ -545,7 +571,7 @@ static struct sk_buff *gve_rx_copy_to_pool(struct gve_rx_ring *rx,
 
 	copy_page_info = &rx->qpl_copy_pool[pool_idx];
 	if (!copy_page_info->can_flip) {
-		int recycle = gve_rx_can_recycle_buffer(copy_page_info);
+		int recycle = gve_rx_can_recycle_buffer(NULL, copy_page_info);
 
 		if (unlikely(recycle < 0)) {
 			gve_schedule_reset(rx->gve);
@@ -665,7 +691,7 @@ static struct sk_buff *gve_rx_skb(struct gve_priv *priv, struct gve_rx_ring *rx,
 			u64_stats_update_end(&rx->statss);
 		}
 	} else {
-		int recycle = gve_rx_can_recycle_buffer(page_info);
+		int recycle = gve_rx_can_recycle_buffer(rx, page_info);
 
 		if (unlikely(recycle < 0)) {
 			gve_schedule_reset(priv);
@@ -971,7 +997,7 @@ static bool gve_rx_refill_buffers(struct gve_priv *priv, struct gve_rx_ring *rx)
 			 * owns half the page it is impossible to tell which half. Either
 			 * the whole page is free or it needs to be replaced.
 			 */
-			int recycle = gve_rx_can_recycle_buffer(page_info);
+			int recycle = gve_rx_can_recycle_buffer(rx, page_info);
 
 			if (recycle < 0) {
 				if (!rx->data.raw_addressing)
@@ -983,11 +1009,16 @@ static bool gve_rx_refill_buffers(struct gve_priv *priv, struct gve_rx_ring *rx)
 				union gve_rx_data_slot *data_slot =
 						&rx->data.data_ring[idx];
 				struct device *dev = &priv->pdev->dev;
-				gve_rx_free_buffer(dev, page_info, data_slot);
-				page_info->page = NULL;
+				struct gve_rx_slot_page_info old_info = *page_info;
+				union gve_rx_data_slot old_slot = *data_slot;
+
 				if (gve_rx_alloc_buffer(priv, dev, page_info,
-							data_slot, rx)) {
-					break;
+							data_slot, rx, GFP_ATOMIC)) {
+					if (page_count(page_info->page) >
+					    page_info->pagecnt_bias)
+						break;
+				} else {
+					gve_rx_free_buffer(dev, &old_info, &old_slot);
 				}
 			}
 		}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

