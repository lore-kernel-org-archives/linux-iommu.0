Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com [209.85.221.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B13D552
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575275; cv=none; b=YqcNvzkuDaOcUQI9nAP+Z8pTnGvySWXTfkaa+VND3320qorrsOcDWQNCQUFfzmAqwATozTX6Hr8vfzElewedzlrU7rGbXb2tSVGrJgSPJba0zX1ChNrS44hji8r+Z2ffcZXrHa5ldQxcrQWhOYj9e+vwOx3nWw9hebC7Us0KJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575275; c=relaxed/simple;
	bh=td/Vk7YkZYHrVt/nOdJ0BOQkIAcpR2c/B2eHAhBjQLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sTHaWWKhE2XGgDSxlchHbluA51OqTKVwzyJj5kNrRedhHx2qASpgBh1y74JNroNZ2YBWBtvkJR48uZW2AwHypGcffv/4BYZScJ4DOq+uSmX03T1X//OcmxG4Huj9Ipcaehx2bOIhKsL0uy3PZiRTBj2meCkQpV2UeWegcp0I53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=QP9CG5AF; arc=none smtp.client-ip=209.85.221.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="QP9CG5AF"
Received: by mail-wr1-f99.google.com with SMTP id ffacd0b85a97d-354de3c5d00so1698879f8f.1
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575271; x=1717180071; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xql1CWOkqvawpbosdHCKSvgqjnwNVKxpQqZxh7tM+T4=;
        b=QP9CG5AFmOsRZaUJ0jvDAcgWAMYT1MreoGdRfuWIk1h7aXZa105IxmXH/xqrk2p0/l
         RXI2CIazasxcnFHNWHMRVzLJBtLtYyJt/7NnUZvMvizwsM1GGE8hHY0wttiBAyNfgErP
         EvELix+PV9QdPlBlJG972sKWZPI1tv3835vEI5bPdAczNV2LrjQikHFKMLFyeQIBO58b
         WRxeNMrYdrIrp1dzS6nLhPP8e1hOj+xLYHp4ssKPw0d+9poL3WLY5FNyOvN6SmJHPK+n
         2gYiMurXQYYb43vmlzTuTF32cw12WfpHmQWj0VhN4pBrDcxaQuzesx58Ib/t8Rt4dlbR
         DzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575271; x=1717180071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xql1CWOkqvawpbosdHCKSvgqjnwNVKxpQqZxh7tM+T4=;
        b=mwLDHz/NlWT6nWWjuccuuMe6nu3xRi09zl4p4auU9dSU9508C2U7YFKp5pJGJ6FqVZ
         OkPd0iv+CzUcC4o57ETBm4hGbrHOk9C3iBUm77+EkMEjQh6eJoFCu+02tUEXzydItJvz
         t8oB7B3cmacVLSdAyfMeJCXlr1zYRJq+DH62Ufy5SWGzKn+ivmwhpu/lFEKd7gliVmBr
         vl2n549ByxyK39l3EBTEPs4//ycys2nD1oKaO+IQImLEhd9OTAIC+WhYgL0WaKNdKE4g
         7LEqgRUnNZ2BS6ktxOTH1Oxx4mFoNPYLiAQYVY+wykIgxcSZwfXINRSoBA+uOW7HTdjC
         UaIA==
X-Forwarded-Encrypted: i=1; AJvYcCVKWRYBCd+IBVCBTLuWWeIQiU9ynBuWgf3fw1lCPYDB32z9Fx+31fh5IxGy3YTnIFHbRuUdar9qEg6eJ7bVJ6XbSCnWA4M=
X-Gm-Message-State: AOJu0Yw2nZPPvDYBywiX7bfOn5MhJffQ7K1aEx9iyZ4mUKH2osz647fx
	B407dGkS8r+nsWe0S4HTZZ+lyEE6S1JHWMbCCE2+VlMWvoFe5iCWNOOXuO1DQpHf/k93wQ/YUeT
	Af4d682Qt3tMHI0XwlrTxLN2Z2lkeUamt
X-Google-Smtp-Source: AGHT+IEv4pOsw1zoXJUhXCDnkIg536hPcEoYyVLGKEBIg1WFslqr8Kj1DBgMYFhuBxYsZGvlD4sKieE6j1gT
X-Received: by 2002:a05:6000:1753:b0:354:fce5:4cc3 with SMTP id ffacd0b85a97d-354fce54d2dmr4599736f8f.19.1716575271168;
        Fri, 24 May 2024 11:27:51 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-35579d7b436sm63138f8f.14.2024.05.24.11.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:51 -0700 (PDT)
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
Subject: [PATCH 00/18] BCM2835 DMA mapping cleanups and fixes
Date: Fri, 24 May 2024 19:26:44 +0100
Message-Id: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All

This series initially cleans up the BCM2835 DMA driver in preparation for
supporting the 40bit version. It then fixes up the incorrect mapping behaviour
we've had to date.

The cleanups are based on Stefan Wahren's RFC [1], with a couple of minor bugs
fixed, but stopping before actually adding the 40bit support. If we can sort
the mapping issue, it avoids having to have workarounds in the 40bit support.

The mapping issues were discussed in [2].
Up until this point all DMA users have been passing in dma addresses rather than
CPU physical addresses, and the DMA driver has been using those directly rather
than using dma_map_resource() to map them.
The DT has also been missing some of the required mappings in "dma-ranges", but
they have been present in "ranges". I've therefore duplicated the minimum amount
of of_dma_get_range and translate_phys_to_dma to be able to use "ranges" as 
discussed in that thread. I'm assuming that sort of code is not desirable in the
core code as it shouldn't be necessary, so keeping it contained within a driver
is the better solution.

When Andrea posted our downstream patches in [3], Robin Murphy stated that
dma_map_resource is the correct API, but as it currently doesn't check the
dma_range_map we need Sergey Semin's patch [4].
There seemed to be no follow up over the implications of it. I've therefore
included it in the series at least for discussion. If it's not acceptable then
I'm not sure of the route forward in fixing this mapping issue.

I'm expecting there to be some discussion, but also acknowledge that merging this
will need to be phased with the patches 1-13 needing to be merged before any of
14-17, and then 18 merged last to remove the workaround. I suspect that's the
least of my worries though.


I will apologise in advance if I don't respond immediately to comments - I'm
out of the office for the next week, but do appreciate any feedback.

Thanks
  Dave

[1] https://lore.kernel.org/linux-arm-kernel/13ec386b-2305-27da-9765-8fa3ad71146c@i2se.com/T/
[2] https://lore.kernel.org/linux-arm-kernel/CAPY8ntBua=wPVUj+SM0WGcUL0fT56uEHo8YZUTMB8Z54X_aPRw@mail.gmail.com/T/
[3] https://lore.kernel.org/lkml/cover.1706948717.git.andrea.porta@suse.com/T/
[4] https://lore.kernel.org/linux-iommu/20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru/

Dave Stevenson (7):
  ARM: dts: bcm283x: Update to use dma-channel-mask
  dmaengine: bcm2835: Add function to handle DMA mapping
  dmaengine: bcm2835: Add backwards compatible handling until clients
    updated
  dmaengine: bcm2835: Use dma_map_resource to map addresses
  dmaengine: bcm2835: Read ranges if dma-ranges aren't mapped
  arm: dt: Add dma-ranges to the bcm283x platforms
  dmaengine: bcm2835: Revert the workaround for DMA addresses

Phil Elwell (4):
  mmc: bcm2835: Use phys addresses for slave DMA config
  spi: bcm2835: Use phys addresses for slave DMA config
  drm/vc4: Use phys addresses for slave DMA config
  ASoC: bcm2835-i2s: Use phys addresses for DAI DMA

Serge Semin (1):
  dma-direct: take dma-ranges/offsets into account in resource mapping

Stefan Wahren (6):
  dmaengine: bcm2835: Support common dma-channel-mask
  dmaengine: bcm2835: move CB info generation into separate function
  dmaengine: bcm2835: move CB final extra info generation into function
  dmaengine: bcm2835: make address increment platform independent
  dmaengine: bcm2385: drop info parameters
  dmaengine: bcm2835: pass dma_chan to generic functions

 arch/arm/boot/dts/broadcom/bcm2711.dtsi       |  14 +-
 .../arm/boot/dts/broadcom/bcm2835-common.dtsi |   2 +-
 arch/arm/boot/dts/broadcom/bcm2835.dtsi       |   3 +-
 arch/arm/boot/dts/broadcom/bcm2836.dtsi       |   3 +-
 arch/arm/boot/dts/broadcom/bcm2837.dtsi       |   3 +-
 drivers/dma/bcm2835-dma.c                     | 432 ++++++++++++++----
 drivers/gpu/drm/vc4/vc4_hdmi.c                |  15 +-
 drivers/mmc/host/bcm2835.c                    |  17 +-
 drivers/spi/spi-bcm2835.c                     |  23 +-
 kernel/dma/direct.c                           |   2 +-
 sound/soc/bcm/bcm2835-i2s.c                   |  18 +-
 11 files changed, 383 insertions(+), 149 deletions(-)

-- 
2.34.1

