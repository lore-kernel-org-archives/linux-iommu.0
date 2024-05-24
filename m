Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821F40875
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575284; cv=none; b=tIcRVNXX7/q7IShpjugiwOxHsDs0+0qsVM3UG6Am1PHBYDX4a2cWUASmV8E06sM+6c9E3uOE9Lq47J9dnvMaB6/sEo+DJYyDJYQqANWVf74m9sEYtYMQhPhpsqWZJAwYlpuP5l2nR68SodeGvVsCpErJe9rwunYOX64P2iFecWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575284; c=relaxed/simple;
	bh=NmaIHsHw8WolTjTf8xLqs7ZWhcp53cyRuvb7LqWTrw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZEJf7VnxDUBGPdajQO5mJRj94/hPO+6LLQbN8pmYtvXG4MasfZViXnWkZGqgC6V1E3dA8kds9/U80O920YgmTOuuJXu1IDnqAPB6YOIQ6dzFdt7+TsZHoGuml3luyy86qjlQ6fsuznDCdgYCVinZSVFyoTLFf5NCf3YrV2Ki3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=i29ekcwD; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="i29ekcwD"
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so34494125e9.3
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575277; x=1717180077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLyqz2osfPGnGJK1wbt1y32SqdJNw076C0yH+gVvyYs=;
        b=i29ekcwDOYj6ikxcoxB+Vu3t7aC8MDUpUlIYNLKtcVff4irTlnv7lWDvDhqgGPOsMw
         YYizqSf6jtKZz+UA+zKcRLvDJWE0C5BFkIkenR8UdaGrxLAy6Q5U0Ttl5II7lqkwSk6z
         xckUH1e317XSukBiae4tYemdJqiOfizrskbNLQpv+B0mS7yZiVVRXizkCLl+rqfafY6L
         u/GuKOe4sby685oMsqIeSC1Uq/1OXzaG2IpNSTcaUhhRqtBwnwnG+mL+Lhg5HClD8nzU
         /l2UGj+teTHQZtsGE6b/JBM8zEkPtgawO5SuZUPriZrjditMPBIiMpWk36yq1U4peIpp
         RhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575277; x=1717180077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLyqz2osfPGnGJK1wbt1y32SqdJNw076C0yH+gVvyYs=;
        b=DqHpHeAJx0BjzhNHb9Fwu3IFRoGhjffKCZCM5ynsuip9mZEC7L+AaiK+XXyt2Wp9UO
         Ko3dnLZ9ANZFlb9vNSVg1bL3Mt/Sl99aHA4h0prEFSuUzzm+eLXVSvyFdbHmTLQ0rfri
         6CnI6i+YhneaMY/o75aa0aSQRAm7elUwmDo1W91cB9Bd2KhXUNZlL42h0hakuIpNB0wk
         J6PG5BuLWAUs3Xzmobq7LNbwATnUi2fIDsE3GhS3SZexJE6Hh0NdSyS2rVZbO8fB+0kY
         S/h8M+LwEzEUpR7GPQHGUEKgtjHPCnVcAnk0dtdUo6VTIkr4AxR2mXfiMZ7Mjp/+yIyJ
         xvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrsvsnMIswewXdUSNp0JrefU13ch95ev3cMVeQe3G3JBlZrC5xzTKVQFUE5nhK8KjdzmVSQuFaK0am3SBYkhdGg8xwgCk=
X-Gm-Message-State: AOJu0Ywr9DCPbHTpWHUOaMkaqIybD8C/soGIDiHj5fzT9SLZcIuXKeCg
	kYEWlbAzdMN0lRwiEZtBHKEWMfYUPyoTmUS2Koipotz9QxUtYm5q21WyE0Y1yVal+7TjSgMhEA1
	rmmKKBhmuglP+f7RE+ORb1i87A0DBQ0yk
X-Google-Smtp-Source: AGHT+IHZyoYiw+ZfDDIW+lJcq4U5OZo2v43Ubu3YaXBugY/8GE8OzbxogUWp09sQZEXs2xF6wDmcdkXhQP7U
X-Received: by 2002:a05:600c:548f:b0:418:c1a3:8521 with SMTP id 5b1f17b1804b1-42108aa8866mr22319455e9.26.1716575277729;
        Fri, 24 May 2024 11:27:57 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100fa9be9sm5432805e9.40.2024.05.24.11.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:57 -0700 (PDT)
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
Subject: [PATCH 11/18] dmaengine: bcm2835: Use dma_map_resource to map addresses
Date: Fri, 24 May 2024 19:26:55 +0100
Message-Id: <20240524182702.1317935-12-dave.stevenson@raspberrypi.com>
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

There is a need to account for dma-ranges and iommus in the
dma mapping process, and the public API for handling that is
dma_map_resource.

Add support for mapping addresses to the DMA driver.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 46 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9531c0b82071..e48008b06716 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -67,6 +67,10 @@ struct bcm2835_cb_entry {
 
 struct bcm2835_dma_chan_map {
 	dma_addr_t addr;
+	enum dma_data_direction dir;
+
+	phys_addr_t slave_addr;
+	unsigned int xfer_size;
 };
 
 struct bcm2835_chan {
@@ -294,12 +298,44 @@ static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
 		return 0;
 	}
 
-	/*
-	 * This path will be updated to handle new clients, but currently should
-	 * never be used.
-	 */
+	if (dev_size != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		return -EIO;
+
+	/* Reuse current map if possible. */
+	if (dev_addr == map->slave_addr &&
+	    dev_size == map->xfer_size &&
+	    dev_dir == map->dir)
+		return 0;
+
+	/* Remove old mapping if present. */
+	if (map->xfer_size) {
+		dev_dbg(chan->device->dev, "chan: unmap %zx@%pap to %pad dir: %s\n",
+			dev_size, &dev_addr, &map->addr,
+			dev_dir == DMA_TO_DEVICE ? "DMA_TO_DEVICE" : "DMA_FROM_DEVICE");
+		dma_unmap_resource(chan->device->dev, map->addr,
+				   map->xfer_size, map->dir, 0);
+	}
+	map->xfer_size = 0;
 
-	return -EINVAL;
+	/* Create new slave address map. */
+	map->addr = dma_map_resource(chan->device->dev, dev_addr, dev_size,
+				     dev_dir, 0);
+
+	if (dma_mapping_error(chan->device->dev, map->addr)) {
+		dev_err(chan->device->dev, "chan: failed to map %zx@%pap",
+			dev_size, &dev_addr);
+		return -EIO;
+	}
+
+	dev_dbg(chan->device->dev, "chan: map %zx@%pap to %pad dir: %s\n",
+		dev_size, &dev_addr, &map->addr,
+		dev_dir == DMA_TO_DEVICE ? "DMA_TO_DEVICE" : "DMA_FROM_DEVICE");
+
+	map->slave_addr = dev_addr;
+	map->xfer_size = dev_size;
+	map->dir = dev_dir;
+
+	return 0;
 }
 
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
-- 
2.34.1

