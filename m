Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375DB3FE55
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575280; cv=none; b=PYvyTLQie3Ta97R7+vmbC8vERcDjnoJjCafjHLJ5YatZ5nSpSF1CNBa0wPAH9y3oJ0Et9s8htOb+tg6hM1pd0o91Oo1A/OoN1ffwy3W2MnQLbZMqZ53xsEH9aYdjDHl4qEnCDb1UuH8EWkP3bqKg7wTwFEHtxOBe7EUSDIJiOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575280; c=relaxed/simple;
	bh=z+GE4dD4yPnc63WvqBNiPDl9b7TaZQb9Yc7IQzit1Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SzfpDh5wi6DViZ3HMiW3AIotyOhbkcjwkBWqucko+bsfxgVuQ+q5vee/tUJ3OtOMeceJpBB+/4LJqNivBhvN5iwh39dOWP0OgGpGhpi1Yz1Ek9E4h2pLwpXMvn0FT8gkbpJ721CV86vsB/OSbHrEwLjDvBSgpUzpM7ON36fTkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=QTSNxGOd; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="QTSNxGOd"
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-4210c9d1df6so3468285e9.2
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575273; x=1717180073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKd9X1LOVt1ChaX4vRXT/Yfb21vDTf36hviq/MF6+cg=;
        b=QTSNxGOd8puPE0XzLAx4JApTo5Oryx3Oqb2r0aJE2SCcQ/Jx7E1oXKFtfk96+AJqjL
         fgG0/7xAGkOOsg77dsVhWs+vVUs5zEyZUyTtn0Gw7grkG6yov7RLq8OPmS2bYFkLTf/Y
         vv3eqRuX1aqBR79MzhW4f84C3HNtp/bySBSFfR7EmNJJiYMF1U4hNVSH0FiUOhEa6sEq
         M8l1KJAdp4GTuCTbByr2dZ208wBK9Glutz9k0WnXTsQzOOCY22fNFuPtTEdW5Z5wNfhQ
         CVUGZDAlhS3c0upSf7HJVRn8uwwl7kh9ZNX8E43ZAhbJgsaOhWof0OScTpQAcw4rv74g
         nc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575273; x=1717180073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKd9X1LOVt1ChaX4vRXT/Yfb21vDTf36hviq/MF6+cg=;
        b=Izc1mOb4uS978t+06lc7YqPL9LNlA3r2cb3tvU5qVoSUq2FfVzRYWzI1UzoGSFy0nf
         M5XHoNO7Pbxe0YVm+s8iyLPR7+5gtwqxldEvl+j4yU0Uv+TRQizZV8J7mB9JrctwzZcj
         bc3zuyenJOrn++UxRUze+/WBJhLQGWuBAZGWulXdeTGECs4wHNC+Lv2aQRaXoF7fIJMx
         6fiaEV9Xy5IOIYauY2vfh4YIi4UVw9T3X+fkDSjTH6nlXzvResLq3xLIAxNGxXLfhluO
         KRdS5w6C1cEEmNzq+EFM30KvBa9RlELhGd3L88TtaY68t2lQUuz62Vv7LTnxmZNu0uo6
         rfcg==
X-Forwarded-Encrypted: i=1; AJvYcCWtAMgwRhh1iglQRE8NMvGWUBgPYwL0Z/bl/xqsP4xoIo7mZVnqSxexDI6Eb4QmBu0/Xx4wOgVDIzw7sTemxTToaECpW1g=
X-Gm-Message-State: AOJu0YxQfXRBA5L3b53hgDEUTM5+76K8X2sglptz8zmi57BImh89tXUN
	AC1pHdrS3Yq91415U5XW3Jvirr0UargZWxdS1rRXn5fyj90DYVRh9KgMQnhCzFKtwHWVbYWErcJ
	2hC1LHJhFGL8TB4Q5nBiGImK8RBxSCx/J
X-Google-Smtp-Source: AGHT+IE1vodFu4VYv4ismPyHD4+ricu2iZqmWOTNKtTorabHI/piuhSxGYfbWmThDOKYJ4k1kIH/5D1hvWp9
X-Received: by 2002:a7b:c305:0:b0:41c:2313:d966 with SMTP id 5b1f17b1804b1-421089d3943mr28029795e9.1.1716575273524;
        Fri, 24 May 2024 11:27:53 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100fb4c8fsm5347505e9.49.2024.05.24.11.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:53 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 04/18] dmaengine: bcm2835: move CB info generation into separate function
Date: Fri, 24 May 2024 19:26:48 +0100
Message-Id: <20240524182702.1317935-5-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Wahren <stefan.wahren@i2se.com>

Actually the generation of the Control Block info follows some simple
rules. So handle this with a separate function to avoid open coding
for every DMA operation. Another advantage is that we can easier
introduce other platforms with different info bits.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 50 +++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 528c4593b45a..7cef7ff89575 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -201,6 +201,34 @@ static inline struct bcm2835_desc *to_bcm2835_dma_desc(
 	return container_of(t, struct bcm2835_desc, vd.tx);
 }
 
+static u32 bcm2835_dma_prepare_cb_info(struct bcm2835_chan *c,
+				       enum dma_transfer_direction direction,
+				       bool zero_page)
+{
+	u32 result;
+
+	if (direction == DMA_MEM_TO_MEM)
+		return BCM2835_DMA_D_INC | BCM2835_DMA_S_INC;
+
+	result = BCM2835_DMA_WAIT_RESP;
+
+	/* Setup DREQ channel */
+	if (c->dreq != 0)
+		result |= BCM2835_DMA_PER_MAP(c->dreq);
+
+	if (direction == DMA_DEV_TO_MEM) {
+		result |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
+	} else {
+		result |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
+
+		/* non-lite channels can write zeroes w/o accessing memory */
+		if (zero_page && !c->is_lite_channel)
+			result |= BCM2835_DMA_S_IGNORE;
+	}
+
+	return result;
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -615,7 +643,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
-	u32 info = BCM2835_DMA_D_INC | BCM2835_DMA_S_INC;
+	u32 info = bcm2835_dma_prepare_cb_info(c, DMA_MEM_TO_MEM, false);
 	u32 extra = BCM2835_DMA_INT_EN | BCM2835_DMA_WAIT_RESP;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
@@ -646,7 +674,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
-	u32 info = BCM2835_DMA_WAIT_RESP;
+	u32 info = bcm2835_dma_prepare_cb_info(c, direction, false);
 	u32 extra = BCM2835_DMA_INT_EN;
 	size_t frames;
 
@@ -656,19 +684,14 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 		return NULL;
 	}
 
-	if (c->dreq != 0)
-		info |= BCM2835_DMA_PER_MAP(c->dreq);
-
 	if (direction == DMA_DEV_TO_MEM) {
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		src = c->cfg.src_addr;
-		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		dst = c->cfg.dst_addr;
-		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
 	}
 
 	/* count frames in sg list */
@@ -698,7 +721,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
-	u32 info = BCM2835_DMA_WAIT_RESP;
+	u32 info = bcm2835_dma_prepare_cb_info(c, direction,
+					       buf_addr == od->zero_page);
 	u32 extra = 0;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
@@ -729,26 +753,16 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 			      "%s: buffer_length (%zd) is not a multiple of period_len (%zd)\n",
 			      __func__, buf_len, period_len);
 
-	/* Setup DREQ channel */
-	if (c->dreq != 0)
-		info |= BCM2835_DMA_PER_MAP(c->dreq);
-
 	if (direction == DMA_DEV_TO_MEM) {
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		src = c->cfg.src_addr;
 		dst = buf_addr;
-		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		dst = c->cfg.dst_addr;
 		src = buf_addr;
-		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
-
-		/* non-lite channels can write zeroes w/o accessing memory */
-		if (buf_addr == od->zero_page && !c->is_lite_channel)
-			info |= BCM2835_DMA_S_IGNORE;
 	}
 
 	/* calculate number of frames */
-- 
2.34.1

