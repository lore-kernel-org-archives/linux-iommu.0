Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D93EA9B
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575277; cv=none; b=DKNsdNYw9pCUBIddbfi5QwY03Jkab1RzjlpXl3TbdaBPzEOGGinssAWzO2wZwIgJhFKsgrVjz9Gu3f3noe+cEx88ow8+I4doXgdtuQyOO326Z/PdKKYXlJb5hwMA9Z8LksCL+VLDvVUO+z9vEKRBZg7hQJ8lF9YK4wfoYti0p2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575277; c=relaxed/simple;
	bh=t6EOXzX5NBCieefJXhaqEj/EuhQeMzBIdGFGnmyqFc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lVAzbYbvwP0vRtW7kn+7Q0du6Nssr/5L8N2OrYZRKDpm8z8Do/f4KxSSQdY902ekMnQZldmv/T3vrLy/UI19hT8S2zHK7wHOJk8d10D0umOJtQU5TOmqSlccIyXVGVJeqe/eYoSSiMGQ/cBqRjuW4IsmdsovTtfYakikMyyibi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=sU3wK9R6; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="sU3wK9R6"
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-42016c8db2aso33480785e9.0
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575272; x=1717180072; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmjLsXIH2Amncxc11ehW4fWxMk13TiDZ+O44YXe6Wgk=;
        b=sU3wK9R6JbHu63XwXqarQdWEBBsli7c8XqFqJhS7I7kW6jUVfxIAE4MaJUwUUkYgiC
         SZOah+1c62UgGt490HpWHauru5I+v/JSrvcFuy7ciuie96ZhGLffHFC31h5qItLCXsZr
         ZECv9ZJThjZdn3VnxiJpSj2IRfz7dK9Qj2Y/eeRMD0kRy/Q1Dvy0BQ+CSlnkeHzTJRFO
         tlq+v931CNiBj33XMYhhmhCIz2YFNReBT+5fj/eOlxuuvZstI66r4IC/6xCk85VkMkx3
         MIN/hEiAugiIS5mrnAhjrrXzDP5UBo+zMH8Kx8p56D/MepvJOIxLB94Vng/9zjOK7gCo
         i7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575272; x=1717180072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmjLsXIH2Amncxc11ehW4fWxMk13TiDZ+O44YXe6Wgk=;
        b=lrdNoAmrDnQTqZ9D0Jb9MS2Fjnd1Lm+vxy+/qFkdHsY6e9Z6YNO6ijxB8nTcxEeA3U
         cYxULz4+NZBVYriTnR9ycp+x15TS+Img7C7BZ/EK4ET5xjfG37Hm9vcnjrqa52MhI1dt
         W6hubdE2OApYGd+hPfJwdqKcNlZVpebATAo7tjVROAc1rIrBC/hzPeOrTshyxhyjPkrH
         EiOxC9TUmvzYi59g48fN7R81vkAruj9PCC5MrVtJ9A/Hp45pIteAOnFAuUohUjgPIklf
         FJqmLKSS+rBGOyqSDtzFA9tiKgCg//bTW980CYbBRL68ps4Lpaf/ZPMJG8K6nPASWtP4
         U/rA==
X-Forwarded-Encrypted: i=1; AJvYcCUog/SLM43orDnsGJDw/Y3bEBdM39w+dzCvL8mNSJIzB7nXtqzuOzG6DkFjmgnAQg1TeSW0Be9VWJ/7AZIl401lSF1aEEk=
X-Gm-Message-State: AOJu0Yx+Az4pIgE3zp88O4S6oAGsS/sGNI29n5yYIVxWHbubnaI8w4K3
	xJyKcic1KqKj5R6SNBrrmH4C8/DW1VVSzQRsWwKriplyCZ7M06ZzL/P8ILwcWj1oEk5kRYUVKwM
	eoX09QDaF7fsA46bx/xxqbGVjLFxycZm5
X-Google-Smtp-Source: AGHT+IGfOa5XBgeYIs/cH5TAMCHbRBfIruDizHffdZ+UPyoZ3jK796PR+KziATsAgtd+BnPEgr+Se5nRlYpt
X-Received: by 2002:a05:600c:3114:b0:420:2cbe:7ee8 with SMTP id 5b1f17b1804b1-421089f1394mr28435685e9.6.1716575272442;
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-3557a1cd354sm56646f8f.101.2024.05.24.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
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
Subject: [PATCH 02/18] dmaengine: bcm2835: Support common dma-channel-mask
Date: Fri, 24 May 2024 19:26:46 +0100
Message-Id: <20240524182702.1317935-3-dave.stevenson@raspberrypi.com>
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

Nowadays there is a generic property for dma-channel-mask in the DMA
controller binding. So prefer this one instead of the old vendor specific
one. Print a warning in case the old one is used. Btw use the result of
of_property_read_u32() as return code in error case.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9d74fe97452e..528c4593b45a 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -941,12 +941,19 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Request DMA channel mask from device tree */
-	if (of_property_read_u32(pdev->dev.of_node,
-			"brcm,dma-channel-mask",
-			&chans_available)) {
-		dev_err(&pdev->dev, "Failed to get channel mask\n");
-		rc = -EINVAL;
-		goto err_no_dma;
+	rc = of_property_read_u32(pdev->dev.of_node, "dma-channel-mask",
+				  &chans_available);
+
+	if (rc) {
+		/* Try deprecated property */
+		if (of_property_read_u32(pdev->dev.of_node,
+					 "brcm,dma-channel-mask",
+					 &chans_available)) {
+			dev_err(&pdev->dev, "Failed to get channel mask\n");
+			goto err_no_dma;
+		}
+
+		dev_warn(&pdev->dev, "brcm,dma-channel-mask deprecated - please update DT\n");
 	}
 
 	/* get irqs for each channel that we support */
-- 
2.34.1

