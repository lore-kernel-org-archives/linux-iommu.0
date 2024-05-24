Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B45BAC3
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575290; cv=none; b=AhVj5bwPsZPS+Xmgo5wd4bZ7kINs0raznQ4S0wMEVCqpL9kBz4p2QGrJ7ZhoHg+x4qYL43NdY1Tx1laN4Zr708w4ginUytaFuA+//2fdhXAMry3Zbkyh2ySdZTxrVOBOD8Faa/So9YjmBQczWrh6lh5QADHWK2kIdNFnc1RAk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575290; c=relaxed/simple;
	bh=+sLcs4QOO6S6PmRZbmAwV/bGLEFVH4urRpzSl6qADg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUpj6IA2RzINEpQZtxE/7Wryd8POrL7CbmZ/+9DnyeXRq8fVmH72900EnH4eIVTDK9XCJrZwcFQQSsHnqAmuOjANeYH1iOtoa9KEW59yYCVHWFDWL8PUrNVdOmivkNY6HlqD31r4lDSzaD64+bRP5j/X0/K/6Z/Jp8mUSXyU5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ZNKiVZJd; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ZNKiVZJd"
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-42101a2ac2cso20613715e9.0
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575282; x=1717180082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaJ2/2ZC9xmhH/6MleK2a1l8XHvCRgt0iv2l1bIIm7k=;
        b=ZNKiVZJdq5clktvtk9u+mLGaL3RfMZd4b+DD6FTiz1GixEOSh0/qXYMpMILeYTpbxu
         vsg8PBQwJSlyPGrR9MEyclRBltJA16TDH1q3RDuUTtx2n6XzCWXVvdrbOZ0B/eQ8kMRz
         hI9C1s97JA+OSIUEQnsyNv8dTM5KjJ9Sm9XVUzYkQSrJ6otndaHM/ZxBXu7FMY20OR+Y
         /Pipn55MBAUl9vpEz6EJy9+pi+oVPOj0Ii6txdIpIngbFTbrKuKhHXKrPS6a9v2b/BZf
         HG18Jm438Qqabw22TanWLVXvvem6eDriinxZNgI4uQQguOjkVDeKuKGkrBo14AdJraJB
         l8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575282; x=1717180082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaJ2/2ZC9xmhH/6MleK2a1l8XHvCRgt0iv2l1bIIm7k=;
        b=K5RiXmMgjYDLiZpv69T48yc9vf6TSoz9sd0Kw2RIEZ8I0qbpPL92Y1Hx62ks+tBuW0
         CauKfZkifHugLPUPLdPB+d8+MzY06yuvlEn0HgpekjySbcW+PRt2g9q2IjbqVEeWd0UX
         9o5uHez9gnSrs9tbemmtSpnjrWuNpd6ROehytqAHHy6VnXeUVACNmbAuA5OEDwc2ndlZ
         0LXEeaUnOzfQ7mAWd+TGMXaXIhk/morv/F8d5ff5AXij39eNRgm3KV247W2YK3HxSRDb
         yWxao+00XMheygE5+9+RKn37IRlLPdo1Tbzi1J9xTkoLQTIWEFqusRr9HMss1YrQM0fE
         8i2g==
X-Forwarded-Encrypted: i=1; AJvYcCXILOSTwEebVfgGQxJFGwMq+GsZRYDa2CtaKRAqvXahch4Q/IJ5MWJ/BfA49br1CVVRcPejcTUkCUlYy+4Whc9xdaheAck=
X-Gm-Message-State: AOJu0Yy1KROXotYm0sBBmP3WU2i5etufMUVoUSJdXdoo4JKs0mDFeFkl
	cpjE3GEtFibeVOGQoaGU13pZ8t19hcH09vwFLJPSp0XcV+Gm/2FKv8QXlTHd1EV8UEs/emkMsgj
	R82CAFf4j/b2Ilbw+I97qhCWnfr8xeefZ
X-Google-Smtp-Source: AGHT+IGW0tEBfx8ikBiBvNc7paeaC57bk88c6mQfl/2RM8CdfU5tVZ5vx+/JsN/a6nuR9BJ11cex+eTG9kUv
X-Received: by 2002:a7b:cb8e:0:b0:420:2b5e:1808 with SMTP id 5b1f17b1804b1-421089d8182mr27055785e9.16.1716575282092;
        Fri, 24 May 2024 11:28:02 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100fbb0ffsm5433375e9.53.2024.05.24.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:28:02 -0700 (PDT)
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
Subject: [PATCH 18/18] dmaengine: bcm2835: Revert the workaround for DMA addresses
Date: Fri, 24 May 2024 19:27:02 +0100
Message-Id: <20240524182702.1317935-19-dave.stevenson@raspberrypi.com>
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

Now that all DMA clients are passing in CPU addresses, drop
the workaround that would accept those and not try mapping
them.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 06407691ef28..181f2c291109 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -405,17 +405,6 @@ static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_dma_chan_map *map = &c->map;
 
-	if ((dev_addr & 0xfe000000ULL) == 0x7e000000ULL) {
-		/*
-		 * Address is already in the 0x7e... peripherals range.
-		 * Assume this is an old client that hasn't been updated to
-		 * correctly pass a cpu phys_addr to the DMA subsystem.
-		 */
-		map->addr = dev_addr;
-
-		return 0;
-	}
-
 	if (dev_size != DMA_SLAVE_BUSWIDTH_4_BYTES)
 		return -EIO;
 
-- 
2.34.1

