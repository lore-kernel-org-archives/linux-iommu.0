Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248760;
	b=fNdMQiUXMsYvTJNRTBYl6bsDQf+lw/zaeIg/tpk6KS/w9JXN/IRm/fWhpt6l8hqzQ0GU
	 hvz4Pe+4jT8vsXB+gxGpYCSfGtjEP2CW5vOOeQCWtpo3KIUD6bCLHFuzwT863mkpEZbu6
	 571M2sFKghrITL1405BJvC6sHJWmm/osB+b3JyYzsRp0HHvkd7fybrLk+LQ9yE5287WtL
	 2GcsJSAZZnjyQnaJHUlEsun8SXW3pk7fcwKcVM1DI3nY+NGLvnxarIYlhuc2FGcgPnBAI
	 dKCbKQKYBUbsLZwV3u23BWlbiRLeKGiWhvJzb+3MUV+vSqqqz/YgkZ4VUwC+pxCeZ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QwEhXQGhncgxAenLKf9FgZtSttnofeN4/QkcfEPx9jk=;
	b=3rEh7jLPcParyIOW9YFmZdiZiwtDyV9ukN1tdu5ap0iWX6kbUMnuVDHitNYQaGav6MgO
	 IvuZgdanAYB2mn+tnJHOO2btn/0ZFMQy+CWxmxavpTfJ+hTMyYxpD7Sbkn3t9d3pTXMIW
	 /fzuSG8Fog2d5UVbR/0ZSOg93GPDKtl5W0HemgVYM17M3QbW4KW60kYMgFORdgbCVre59
	 0JQoVIO0I7cFS7C0EDtWGu3fSnqMc/QrNIVO2k++nR/SKmowy/4jiyE3O4jA4nkhGOUXO
	 jkHFHZnlaoWk2TKAf9RzS3oXom1QrLhYEoxokJowhmF6Dn+xHopF0uXoo/wh4M7k4hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=niWpkhU0;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B942606F3A2
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 18:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B942606F3A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=niWpkhU0
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c4048584447so102635266b.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248759; x=1794853559; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwEhXQGhncgxAenLKf9FgZtSttnofeN4/QkcfEPx9jk=;
        b=niWpkhU01Yp3w1unxldpHTOteD0AWaYtWTAhWE7D5DuH+v0LUcGaEfty34Ns1DfXRf
         r6bXUhflZUooCspmEi8gUhh3VPjsVg5oUM0GTHHrojSAX7OAeFXtpcwwU4JgL1+fZbd9
         ssQ/ylVyNn9tH2OXEVQHmoIYPNDSQ231I+Az9PdwF5ri9i8K+Gp8q4DpP6vJNP/tsOys
         SG1nNRjPmK2tddbZXJmHeL9++G2dmb/PbxQ7BinvViTffKaE7wRSSON6Ko7zWIDxuU3t
         Oawvo1YH5rJv/ExQKScnT1mK0CORCHMuKJN7000LlAuLiv4SwUilYMJM6rIxX/KhEAK3
         +cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248759; x=1794853559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwEhXQGhncgxAenLKf9FgZtSttnofeN4/QkcfEPx9jk=;
        b=EZ4Is/j8FhSA92SudDhM0AdIChzOGCIzelfUgKB5m6wN+ll9qDQ0GAvMeo1B7c8pqf
         o+IBQdGqV+JjDDdj25Bz4zFDnjJAYEmdSZjWgKSExEDA86xSy55r4/b3g8Oo7EfW0OLZ
         qWlcc5oqcqy6Mt85skQPxltyJ9K7XKv37AjPgEW96+EEj8xLmGOf7tYGfKPdugLwl/a5
         k7RVz9SFbq2c7JMDdCwN7L82wkMM1WPDR2lHOoyC2xZXzleI+E7+gzzzdtISr30PgVnO
         MO8Py0EJT/LU8BvUr8gc6WvIe4D9j7jtQjoIiUZDHpBEG3Vt2RMvoe/rnDvVTmYc34vV
         eAlA==
X-Forwarded-Encrypted: i=1; AL+hErGXS4DUFaoTr8DJdiikUhXkk/8cM3XHuZiPClMuPmbwzFrl9LUeyzbZC5JcJDgzg2/2FwG5sA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Ud1tnXaAwRRnp5KqTxpXqCWN0FdK+kZ8CesPinPqG0/ctoiSb
	rh7Ge6xqaSSMpK033QhDfSVoEDXlN7hBJy+YzhKcikkegdpCHs/4AqDyVSdMWbLGAsrGyXJCQZ3
	i8dr8yg==
X-Received: from ejcxk8.prod.google.com ([2002:a17:907:d808:b0:c4d:1c8b:9299])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:2f06:b0:c41:5e31:5184
 with SMTP id a640c23a62f3a-c504951eb65mr12737766b.13.1794248758596; Mon, 09
 Nov 2026 10:25:58 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:29 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-22-lrizzo@google.com>
Subject: [RFC PATCH v2 21/25] net/gve: Use GFP_KERNEL when pre-filling RX rings
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

When pre-filling DQO and GQI RX rings in process context before NAPI is
enabled (e.g. gve_open), use GFP_KERNEL instead of GFP_ATOMIC so page
allocation (and CoCo page decryption) can sleep instead of dipping into
atomic reserves.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c | 7 ++++++-
 drivers/net/ethernet/google/gve/gve_rx.c              | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 6880d1531ba5e..3b13aa4999ae5 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -223,13 +223,18 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
 static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
 				    struct gve_rx_buf_state_dqo *buf_state)
 {
+	/*
+	 * Use GFP_KERNEL when pre-filling RX rings in process context (e.g.
+	 * gve_open) so PISA metadata init and CoCo page decryption can sleep.
+	 */
+	gfp_t gfp = gve_get_napi_enabled(rx->gve) ? GFP_ATOMIC : GFP_KERNEL;
 	netmem_ref netmem;
 
 	buf_state->page_info.buf_size = rx->packet_buffer_truesize;
 	netmem = page_pool_alloc_netmem(rx->dqo.page_pool,
 					&buf_state->page_info.page_offset,
 					&buf_state->page_info.buf_size,
-					GFP_ATOMIC);
+					gfp);
 
 	if (!netmem)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 81ea800e66e94..89f287b678bf0 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -161,12 +161,16 @@ static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
 			       union gve_rx_data_slot *data_slot,
 			       struct gve_rx_ring *rx)
 {
+	/*
+	 * Use GFP_KERNEL when pre-filling RX rings in process context (e.g.
+	 * gve_open) so PISA metadata init and CoCo page decryption can sleep.
+	 */
+	gfp_t gfp = gve_get_napi_enabled(priv) ? GFP_ATOMIC : GFP_KERNEL;
 	struct page *page;
 	dma_addr_t dma;
 	int err;
 
-	err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE,
-			     GFP_ATOMIC);
+	err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE, gfp);
 	if (err) {
 		u64_stats_update_begin(&rx->statss);
 		rx->rx_buf_alloc_fail++;
-- 
2.56.0.542.g3ef89b7020-goog

