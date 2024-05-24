Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770E3FB81
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575277; cv=none; b=A89Zge7lbo0oMooJ/Cdrkd020llBp4m8OzaqzPw52izXtnpCr/Rl6aBw8t9IJ+s9NR3dLviNRwHoTsMkxHVHSn4MaV+z6xeaBrmzibBLqJjUQ0tHgkwLA2iez85RLqrVuuNlsPSUW7S02/ORE2Lx8dsQ+VO8xSqrASgrAyhgE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575277; c=relaxed/simple;
	bh=KzZ2/ILylgxy50sk/StCVlBR9s2jedRDn061bSZ6QRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxceezYc5DIUnZ9Z9DGCqoKdRchQexUPjm2x38j5MhcXH4PzycTFkXVxGoJjb/1WWDc9pjUcYGRm5x7jRuNyu4t5DhC2Yd3tO+lsEGwgnOWfIpHPeGezjHHdUxFOfp9KGQPL3QrwRulYZrW3wJON6cUCv8VFnB+HNnqM36gECvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=jpp0izhZ; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="jpp0izhZ"
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so64558385e9.2
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575273; x=1717180073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MV7QZf2fhH+OEhBA38QGxT92fUaASU1Nxo1nxUSVd8=;
        b=jpp0izhZANx20CNmXwUn8PZS1MWp4AZHSRTKk/9WotfHMIyxaJ05ddUgEfi+VIAwjT
         yCF/vpf/VlxDKTM6LgyZWB7viTLhxGfB+l64cHtQV+CJxjd1z4TQActX+6ESGJ8sDNwq
         78qF2Wytg/yoSUVDhdmFWxPGb8Ij9qJZ8ChDHoguuHhrd1wiu+RwFuuNe3sZIY1nhIp1
         1Z4nLzSRSloqEbduBhf1ZFW9hVmxFw25ms+XcXU88Hq4Gw2zUV8tedUUQLQU4srdJJJ9
         DF9eVIXD+X9SiAMO9hg+Yah3Wl9wDnzn0kyBhGpPxNUIBf/rkqp9oQnW9uk8LyI+r/0G
         AyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575273; x=1717180073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MV7QZf2fhH+OEhBA38QGxT92fUaASU1Nxo1nxUSVd8=;
        b=HaPe2HhVHPh6zzoPZMwxaeHIv9juL7xSpn10iJQR8Jg32RCrJJBllYE/EUhadJ6tHd
         B8PVbCTRH3h/LKFEKCerHKm7nALB3vE5SoZe/tkV2BVNPo9nNdtig7c06Yi5U110qp7e
         8s0KkNahH4rSUt0vdngqBd/LK4WmfMz4B4I7DEw20g0EirPRG0LJAArmttUNjQrTBjv2
         /6ZExYNvNrOO9XTyNkkIyqQrjkXof5ODo12AhThPc6rsuWZE/S5PTJPlj3DYrweVe+8g
         aOiwG99uXWkmtSYBNi+vf0CpwcbOE4AYxdXPFdw1Ibz+pJVgFFp4OhVHi39KqE/zjkmH
         fquA==
X-Forwarded-Encrypted: i=1; AJvYcCUkCQp4iDbCpwpikrM4EQFRAo+QWOaKAVjd2HTSVtvAnjVjqimNYdOfvnz7Dn+SxT/7GYkUrESc5dG4Mqo6eGZCk6FHid8=
X-Gm-Message-State: AOJu0YzEmshSbqkixAGtoLwsjlPioxdY5TUqVDwWnlnlSBFvyEraxW5U
	lDV2a4yB6d39g+79x/RZRTI3gYqN2c4eB0m0b7xiZCFk1EhpwMiHvNhRBtoCXbjms86osxjvmgX
	dLNuiGNdPYzu/SU4VBucPyyj5rp+0QXbX
X-Google-Smtp-Source: AGHT+IHWZ0JTRBQwe/XochchvTJaAoc7r7/ijNNUJ35CDCjZA7ALjlPQSMAk7tENe+DW/f85sGYNAcbTrrfr
X-Received: by 2002:a05:600c:5799:b0:41b:f2ca:19cc with SMTP id 5b1f17b1804b1-421089f93b7mr26088945e9.34.1716575272958;
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4210891c6edsm1217615e9.20.2024.05.24.11.27.52
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
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 03/18] ARM: dts: bcm283x: Update to use dma-channel-mask
Date: Fri, 24 May 2024 19:26:47 +0100
Message-Id: <20240524182702.1317935-4-dave.stevenson@raspberrypi.com>
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

Now the driver looks for the common dma-channel-mask property
rather than the vendor-specific brcm,dma-channel-mask, update
the dt files to follow suit.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi        | 2 +-
 arch/arm/boot/dts/broadcom/bcm2835-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index e4e42af21ef3..d64bf098b697 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -103,7 +103,7 @@ dma: dma-controller@7e007000 {
 					  "dma9",
 					  "dma10";
 			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x07f5>;
+			dma-channel-mask = <0x07f5>;
 		};
 
 		pm: watchdog@7e100000 {
diff --git a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
index 9261b67dbee1..3ba8db8eed0f 100644
--- a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
@@ -46,7 +46,7 @@ dma: dma-controller@7e007000 {
 					  "dma14",
 					  "dma-shared-all";
 			#dma-cells = <1>;
-			brcm,dma-channel-mask = <0x7f35>;
+			dma-channel-mask = <0x7f35>;
 		};
 
 		intc: interrupt-controller@7e00b200 {
-- 
2.34.1

