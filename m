Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339047F4B
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575283; cv=none; b=ogL6jSOtQkowNBFgNt1obeyw59+iHN/3sRZSlSYTPmp0yRhRNmvYruV6503Qe30rYiEkEgXbJZaLz5+wdkYdRhSsbQ4z01bSnnNDGBUSkyMJPzeqxvmRkjHOwJyD8wXPNLmWzcNSp/AbyI8Ed0qspHTpKE3ToWIaFrhlGlaPw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575283; c=relaxed/simple;
	bh=HeQH+726CyNd6SDwiRedJyMRoX6cs3MUOfByWaM6V4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPCOxmrRmhzwTeaqXLqypysi982/oSaVIQrvN7zixAf9IZZjFFIe1VUM5tw28TdS1mlxeYPVEb07MVce3ywZwKr3MVou4TH6pnxd/bhVGROC8CH+0Gf04ccruZZS//uJvrAacT5kldPK0qQdtOw+llGR7i7/1pWnRWW+bzvj47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ansthHLT; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ansthHLT"
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so23931831fa.0
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575277; x=1717180077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5/0PmDw861toPHKUvcW29ls0QVOfTRw5AjJ+CnPD2s=;
        b=ansthHLTOVA0oIhWq7r7ylXnFURnMMq8vOCLembyyNAXRa8cXqC/F0xWuQFJeEA7CA
         f7SSP4teEVhaR6zB3WUeBnyWSCoC+9Hsxdxb8ZAEmcmeHGvTxvBPGFJ/FiNAsDqzAkSZ
         6xamoFJGgDpa7fqbht6u9kUBafhe+ciL461RBg8yGIfD0nlzVUtorxLQbi5FHskKUyU2
         WmcNO4AkuwdNRfGo0JtBDxV4CbIm5ogeaSWMsJ6m/YWyeJipytGpgRSQ/HxasYhQe5UQ
         rRTKw8ZJvpxLpD/wTWiREN8ANuAnS+XiuqnCVltf+8T/Zpf9Jo4xVmLQp26qESIGq6TX
         /ARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575277; x=1717180077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5/0PmDw861toPHKUvcW29ls0QVOfTRw5AjJ+CnPD2s=;
        b=CzpeNsd2IKFlORdtem5hpUo+pnIx+AUc9Y5mNhWqknMWNobSmg9ToveN0Ic7a880g8
         V4XFoKu8Ei8yQcz2VeWp9C568SGooqOGInXKbAMZtcYiLr+oZYleY5MjZST29zh0pvr+
         erMpOAwRDS840zpL77Bx6+AzQCKZt58PBhcoPEtYk9iaZLPxgNFXLR9BLU+gi5kUBAhf
         BJIs1tSQf/0Jm9ASRnICyF87q7YBUSeuull7TP+DX+ClQNduNe8Jf8YQi7lwiE5hPS1a
         tCeLQkFr6zVIprlfcY7ZcWMaEam9v4hVP3grpY6gGRLSz1vqVxhwvAKtEwpIvk3IfO5b
         4k7A==
X-Forwarded-Encrypted: i=1; AJvYcCV3Typle2Q684AEz7fK52hOpvtep5VaZYdpcIO+wdloccfBOjyObatOSTC4d+oMr1t/qJs6z/yVP0jPQePu3nUdBuB5qKU=
X-Gm-Message-State: AOJu0YyvA1++Wa8XAsWQQEhZdMPMro9krHoBwdFgc98fhkcwFUBONiyR
	9QZ+qtBJiPIWp1Ej4JxQoROmO3buQtz9lPlG6922yzjMyuEutKzOnxpfolj5ARCucWYW05UyoFl
	nK8QfhqkTlRifsa2bfSvhclYmMtdTIBWT
X-Google-Smtp-Source: AGHT+IEHAWM6BIO0Edq+CWHOn6Y+ZIrJttwNlxlncG6HGF/KksFdkfl8n2+vvBn5hfO9zRO5ovw/15yBiAgP
X-Received: by 2002:a05:651c:4d4:b0:2e9:61c7:cad3 with SMTP id 38308e7fff4ca-2e961c7cceemr12892461fa.25.1716575276717;
        Fri, 24 May 2024 11:27:56 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 38308e7fff4ca-2e95bcedd3dsm330901fa.19.2024.05.24.11.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:56 -0700 (PDT)
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
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 09/18] dmaengine: bcm2835: Add function to handle DMA mapping
Date: Fri, 24 May 2024 19:26:53 +0100
Message-Id: <20240524182702.1317935-10-dave.stevenson@raspberrypi.com>
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

The code handling DMA mapping is currently incorrect and
needs a sequence of fixups.
Move the mapping out into a separate function and structure
to allow for those fixes to be applied more cleanly.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 46 ++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index aefaa1f01d7f..ef1d95bae84e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -65,6 +65,10 @@ struct bcm2835_cb_entry {
 	dma_addr_t paddr;
 };
 
+struct bcm2835_dma_chan_map {
+	dma_addr_t addr;
+};
+
 struct bcm2835_chan {
 	struct virt_dma_chan vc;
 
@@ -74,6 +78,7 @@ struct bcm2835_chan {
 	int ch;
 	struct bcm2835_desc *desc;
 	struct dma_pool *cb_pool;
+	struct bcm2835_dma_chan_map map;
 
 	void __iomem *chan_base;
 	int irq_number;
@@ -268,6 +273,19 @@ static inline bool need_dst_incr(enum dma_transfer_direction direction)
 	}
 
 	return false;
+};
+
+static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
+				      phys_addr_t dev_addr,
+				      size_t dev_size,
+				      enum dma_data_direction dev_dir)
+{
+	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+	struct bcm2835_dma_chan_map *map = &c->map;
+
+	map->addr = dev_addr;
+
+	return 0;
 }
 
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
@@ -734,13 +752,19 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	}
 
 	if (direction == DMA_DEV_TO_MEM) {
-		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (bcm2835_dma_map_slave_addr(chan, c->cfg.src_addr,
+					       c->cfg.src_addr_width,
+					       DMA_TO_DEVICE))
 			return NULL;
-		src = c->cfg.src_addr;
+
+		src = c->map.addr;
 	} else {
-		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (bcm2835_dma_map_slave_addr(chan, c->cfg.dst_addr,
+					       c->cfg.dst_addr_width,
+					       DMA_FROM_DEVICE))
 			return NULL;
-		dst = c->cfg.dst_addr;
+
+		dst = c->map.addr;
 	}
 
 	/* count frames in sg list */
@@ -795,14 +819,20 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 			      __func__, buf_len, period_len);
 
 	if (direction == DMA_DEV_TO_MEM) {
-		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (bcm2835_dma_map_slave_addr(chan, c->cfg.src_addr,
+					       c->cfg.src_addr_width,
+					       DMA_TO_DEVICE))
 			return NULL;
-		src = c->cfg.src_addr;
+
+		src = c->map.addr;
 		dst = buf_addr;
 	} else {
-		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		if (bcm2835_dma_map_slave_addr(chan, c->cfg.dst_addr,
+					       c->cfg.dst_addr_width,
+					       DMA_FROM_DEVICE))
 			return NULL;
-		dst = c->cfg.dst_addr;
+
+		dst = c->map.addr;
 		src = buf_addr;
 	}
 
-- 
2.34.1

