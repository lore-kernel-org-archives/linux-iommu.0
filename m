Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com [209.85.208.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722040858
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575287; cv=none; b=COfJJSc2V5YUj+Pg9IK54XeQX0Ab45WQUCEV8XViyfm4toPYsOZsuKLNA9s5NLk6+xoX32/2JDxpeOiEvnnZ/K6CDgXc7mx2uf+iynUs7q8pVIDoz4uMvdA+9FANBryLaPmq1TF4O/VKS8tRbLgocZdSbCUwEYU/yPIont+cP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575287; c=relaxed/simple;
	bh=HegCCdIEY4pR36AZ8QiWEFIcmksLTJsNsXIyFUq7yl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdaEHgWi/73D0bBlyOperaKqkHZroatxTttFFxKh4aCwNJ+rUq/jeJgC0kbtTWc3OYWgrrZBkbu97byR/SdoezkCM/KR0fPaeY7d5W4/u6Y7Q8bgPIKFYpR9tTzK5AO5oB+LhQews6DirRbFFitx8dzj0m1egycWcvg57aYWtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Z01rKZzR; arc=none smtp.client-ip=209.85.208.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Z01rKZzR"
Received: by mail-lj1-f225.google.com with SMTP id 38308e7fff4ca-2e964acff1aso888541fa.0
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575279; x=1717180079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtSsjB9R4+UVIqScRuc1I4bk33cfKERDT5iPQWCGPm4=;
        b=Z01rKZzRIZ4t+ugKyLR+a8mgD2r7oIGl4WvWC3U4DK9ZVAlqxN03cUULl6o4G2mw9K
         5IqmBuf3OkXSN1B60HAFoHQLbpjvRLBKnh9oxTGgtTMVdpx5xRLLKuE1x+7RczNH7Dmb
         cj6CZ5atp0gYwlH477nzKr2oIKhye1r357HJc1pup/SXHswzZalwExkfFe6oB7388wHH
         8k9yHCWbHtnJsnzlb84NWpc3ZdClujo2pTiFw5XwGkC1E/MwKuBJYQNhffm3JWKuGdCN
         lZ/CXpDv0RW7zjnW08xw2dRFqg3eaKLjMdKDKHlj0oTo2cuzYCCTjHwbDeQGaHtxHPDk
         Ff+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575279; x=1717180079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtSsjB9R4+UVIqScRuc1I4bk33cfKERDT5iPQWCGPm4=;
        b=F/qV6di5VkdcVGxLBT6/uXtwqYXfUvUOB+2mMmRZjKMsChzUhkkZbmgdt09R/3uXYm
         7JZJ3m5KiyeKwtS9imEmwVifgkgzGH66qcwYGGAtsNdfztbUcFFqDUEVf18YZEFNZ04e
         0pCYssdfJ+jXO/pp5hGwh4qsVwNyoTbpQAWfXEBqgan6j9Brjonm4oUGLNpDOZBFYmU1
         DNtvdq/Dha6TZOBdygFCSfVIE0OKV8zSJxO8XKMd2auBQQ2oL/a38/Lci3wfGHVHC/Au
         XtKoACAtAMmrXcr2nsMNdClRdKRCHJoA+mNLN3fW18MAUdTRTmpSUNJq923+THzZkNBX
         beAg==
X-Forwarded-Encrypted: i=1; AJvYcCUAU/KWem/3K/LVGScmGj6c9tq+pThOv4Nd+FUPKdwdbF8W3ENDXQdam0OAzVK6XYNjM15PmQmZ12hLfwvkZyn25bxb0LY=
X-Gm-Message-State: AOJu0YwaQqs+PJrKzYO7gGEMtFMGtX3etJvl7xomIGHrUJeX+8OyDliw
	sWQ4vxTd8+jtxdMa6l0r43xXoYrpsamfK8AvmWFJ8QkK/qGP9DZHakyGk0vlYFPunvci7+fymJl
	EbdaJBaSa5TkJpvO9OFLf8q2uiURd51Rh
X-Google-Smtp-Source: AGHT+IEUZDsi7SCR4IVByAOz4hmEEdc/AaRCJ/JoMT6C0FVxhy9anVd20JxEW5NHN8g2XEYbzyFyk0QQFB+O
X-Received: by 2002:a2e:9c8f:0:b0:2e6:f59e:226f with SMTP id 38308e7fff4ca-2e95b0bce90mr19539971fa.5.1716575279453;
        Fri, 24 May 2024 11:27:59 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 38308e7fff4ca-2e95be01800sm348091fa.53.2024.05.24.11.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:59 -0700 (PDT)
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
Subject: [PATCH 14/18] mmc: bcm2835: Use phys addresses for slave DMA config
Date: Fri, 24 May 2024 19:26:58 +0100
Message-Id: <20240524182702.1317935-15-dave.stevenson@raspberrypi.com>
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
 drivers/mmc/host/bcm2835.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 35d8fdea668b..746a60fac0f0 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -38,7 +38,6 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
@@ -1347,8 +1346,8 @@ static int bcm2835_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	struct bcm2835_host *host;
+	struct resource *iomem;
 	struct mmc_host *mmc;
-	const __be32 *regaddr_p;
 	int ret;
 
 	dev_dbg(dev, "%s\n", __func__);
@@ -1361,23 +1360,13 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->pdev = pdev;
 	spin_lock_init(&host->lock);
 
-	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
+	host->ioaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &iomem);
 	if (IS_ERR(host->ioaddr)) {
 		ret = PTR_ERR(host->ioaddr);
 		goto err;
 	}
 
-	/* Parse OF address directly to get the physical address for
-	 * DMA to our registers.
-	 */
-	regaddr_p = of_get_address(pdev->dev.of_node, 0, NULL, NULL);
-	if (!regaddr_p) {
-		dev_err(dev, "Can't get phys address\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	host->phys_addr = be32_to_cpup(regaddr_p);
+	host->phys_addr = iomem->start;
 
 	host->dma_chan = NULL;
 	host->dma_desc = NULL;
-- 
2.34.1

