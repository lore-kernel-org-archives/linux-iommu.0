Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65A53361
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575287; cv=none; b=HL4L/7UNGuMPmjO13l8sRHsw6iJlT9W5LRjPMunezmxdIxw5KnTooohbDd2ULR05J1iZ99bZ28zzxmnDDzM3+yBl8MGvOV5nfBrVXCHK/7JW9GbCOeNItAZ04pUWCWp4n11+ls8KyOuqiQyG3EY5/SJivyKNVSWXCe4nBD7K3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575287; c=relaxed/simple;
	bh=N3Kfi5rjJxhjSAGsgu3nLGQYoSBKamIirsVfmPZi9nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RB+wVlx98Xkz9dSjNMZe4oOfEp6FQo/Gy51WU4rop8+QnUhsg9HriVthKSbqES/w+dT7w1NIRll+QAeOGlIHzTQ4vALVavtYBNxPrL03iH6DO/GQt2VXivM+W7sFHc6mw/2Eu7Gq09nl1HVCZLaeAxBC5HBNeFizpe4jXsR7oaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=kCXzEHbr; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="kCXzEHbr"
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so6627785e9.0
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575280; x=1717180080; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGCf1ir0ewKxnfYL+8Y6zr0drR+R4O1jhqT1oluTBL8=;
        b=kCXzEHbrgwI8RBlF8QZByJAam1vWyfsLNASF58p2qiGY/ZLanixJ3J3FjwzqWgUuc9
         qo2p2GDn9EoPbWXUFuHmGvrbgNe1k3oz5d34cCauPFn1G7IbnqsF2tTEOvuSmBo7Yzun
         6tJOup1Vf8Y70I2iyGpXh6DeV7KkRGA3YVpRsP91hiIqKLk2E315hb1dr/lubZOPxc5m
         i/XdhpxtikUMZ0YNd7e+cbzNeKHGXb7UDQYHfJQc8XlwgsVRNk3T5w5n5hsnispwzhHl
         11RA0p6tG12hkbprNFhO5iX37LzCYfLy5xeI6PikHkE2/4eYU7K+YEAV6r6t1R145p2Q
         sv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575280; x=1717180080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGCf1ir0ewKxnfYL+8Y6zr0drR+R4O1jhqT1oluTBL8=;
        b=vWmTDAe6InE5w8fyCifSPZ+9+jlCaFKcKyYpYMl/UFo95spW+asU8nvlBL97XbQhYf
         fEaO6c3ndRFAObwaDcSOAPyL89LsqIDubBPlIN5+EY+YRj7+I7MspWlwjsHtuqt0oQvW
         Il1VLXl6sX13PDBPGuPUAv/hHTjaxN0fVRpMf2C8IIPulqxWavs/FqAfp6PU7RC5TaTn
         xVNsXLFVW7hy2zDEK4JiFslJq4zebXGUXAGidEitPxWgDB/kGy9w7phlBMZuBeCdleoS
         xvHfhlsjH/zVddtdaElU3h+ObQhnozpEifJDMM1MvysXZIe1CMALu92RYpr8unh/EcKN
         Q++Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwJEPiPyB/1gvYMgtDt2oE0AAZR4KqhYLI9mYPh+r8nd0mcgKYs6AkQoeXrOnCOivKYJI9OKc1Urtz6jj6iBXEUc3cMvE=
X-Gm-Message-State: AOJu0YxjIBPARcQ5s2StZa3b/nmFcJ555g+0nvasjLM+e4vTGPPdQydU
	gckQfUlxNY5HM7RV2ZqmwqQNeSV7I97jU1Fe+gzm4sfqXWM2txDn7qZFZn9nhpArNaz6bJTD8iL
	BeFqijoxI3V2awUWOQbwRhqhSvx3qLh1I
X-Google-Smtp-Source: AGHT+IHAQFzXjWnTl+TwMEnEF3wypw9s7LeiM71e7MxN0zWKYR44rUnrOPV4U43jDFBiNTbbJuux8HJQ65dC
X-Received: by 2002:a05:600c:1381:b0:41f:b0e7:f299 with SMTP id 5b1f17b1804b1-42108a59292mr20514315e9.9.1716575280074;
        Fri, 24 May 2024 11:28:00 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100fa9eb7sm5393305e9.34.2024.05.24.11.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:28:00 -0700 (PDT)
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
Subject: [PATCH 15/18] spi: bcm2835: Use phys addresses for slave DMA config
Date: Fri, 24 May 2024 19:26:59 +0100
Message-Id: <20240524182702.1317935-16-dave.stevenson@raspberrypi.com>
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

From: Phil Elwell <phil@raspberrypi.com>

Contrary to what struct snd_dmaengine_dai_dma_data suggests, the
configuration of addresses of DMA slave interfaces should be done in
CPU physical addresses.

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/spi/spi-bcm2835.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e1b9b1235787..e8242e0c4246 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -119,6 +119,7 @@ MODULE_PARM_DESC(polling_limit_us,
  */
 struct bcm2835_spi {
 	void __iomem *regs;
+	phys_addr_t phys_addr;
 	struct clk *clk;
 	struct gpio_desc *cs_gpio;
 	unsigned long clk_hz;
@@ -891,19 +892,8 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 			    struct bcm2835_spi *bs)
 {
 	struct dma_slave_config slave_config;
-	const __be32 *addr;
-	dma_addr_t dma_reg_base;
 	int ret;
 
-	/* base address in dma-space */
-	addr = of_get_address(ctlr->dev.of_node, 0, NULL, NULL);
-	if (!addr) {
-		dev_err(dev, "could not get DMA-register address - not using dma mode\n");
-		/* Fall back to interrupt mode */
-		return 0;
-	}
-	dma_reg_base = be32_to_cpup(addr);
-
 	/* get tx/rx dma */
 	ctlr->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(ctlr->dma_tx)) {
@@ -925,7 +915,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	 * or, in case of an RX-only transfer, cyclically copies from the zero
 	 * page to the FIFO using a preallocated, reusable descriptor.
 	 */
-	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
+	slave_config.dst_addr = bs->phys_addr + BCM2835_SPI_FIFO;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	ret = dmaengine_slave_config(ctlr->dma_tx, &slave_config);
@@ -964,9 +954,9 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	 * RX FIFO or, in case of a TX-only transfer, cyclically writes a
 	 * precalculated value to the CS register to clear the RX FIFO.
 	 */
-	slave_config.src_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
+	slave_config.src_addr = bs->phys_addr + BCM2835_SPI_FIFO;
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_CS);
+	slave_config.dst_addr = bs->phys_addr + BCM2835_SPI_CS;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	ret = dmaengine_slave_config(ctlr->dma_rx, &slave_config);
@@ -1336,6 +1326,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
 	struct bcm2835_spi *bs;
+	struct resource *iomem;
 	int err;
 
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
@@ -1359,10 +1350,12 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bs = spi_controller_get_devdata(ctlr);
 	bs->ctlr = ctlr;
 
-	bs->regs = devm_platform_ioremap_resource(pdev, 0);
+	bs->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &iomem);
 	if (IS_ERR(bs->regs))
 		return PTR_ERR(bs->regs);
 
+	bs->phys_addr = iomem->start;
+
 	bs->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(bs->clk),
-- 
2.34.1

