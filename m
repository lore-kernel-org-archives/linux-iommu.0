Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6D17CA1D
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200388; cv=none; b=dtR/LwPnzJ/c3NZ6mb8FnZrHCXbXbA6bv5Uft5luPOKTmRMWbuXZf+ldEA7ydDNIktiLCIDz37EeS1AbWuUyUuYbIJli0d4jYLhOc60umVhJlpLiTf+BRKxgrhplA/aD66Wc2OqQ/qNnxQcDS1i9HkQin89BLmQQEchE/XRYlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200388; c=relaxed/simple;
	bh=VwTo+mvW090vyc3G2pODaN13478wwyTxNG0+WDia1OE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KW0fuU2z0FOxLu2/BB0XoBhLpcP+2o+ifGXJX2wNaIuK5O7bUZCM214ZSTHZWiwDIY5NCCa8RUzg7CPE65BL7IVUP71kKSP6auaNwxMBBIJHuHFQOKNF+ekj4l6LanUfHuzAYDA8tSAXPp5spRZB7M4wzTPrWC/y0pU8hYx7cUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so42888185e9.0
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200383; x=1718805183;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGBcr2RK+U/upO1TBgkbMQlKphC74REv/dCO0ULM5Bc=;
        b=I4gMp+N6K8UGOxobOAEUHb4+WIzs0Csl8onTn+BqC8Znu+bYba2hEaprlRemvXyI7D
         Cs3uLNCn68SPYqU7pVv5cHzX2sQ0ykvIoXqlBmrzL/Fv277vMrT1RQL+uAmetxwrIn54
         fRb5dPHs6B0hRmGRPK8GSo9J5C0XzgKMwF9fyGzjqFRMTwLmZhAy/soUInwt8BNcKQfJ
         NZkKWbTY8tc4Pmze1b/01gnRno3d5r+DOXxghwDTpkDEN3sKJM5c47cS7OsXkdYjmaVI
         AyXw7SVnxa9rXp+5Dr9+uy+P2Hy846E4qIcCDqhu5zD7ix4ENzykqGF3LBSm9Ig/KpNF
         5SbQ==
X-Gm-Message-State: AOJu0Yw5KF/ieFNnu/D/kkI3qo7EiVHZ4KfQjSzIGHU53b91Ewo1BNB0
	eYd9LBPgnL15qHZh+bK95jllbW2KeH2H12NEIVAJPkpLYwG2EI8S
X-Google-Smtp-Source: AGHT+IFpLlhCxjJHPHBYfibghuC2LyUOVhxW9VizojTuoZbWMakCG+/4bvOBPIPTBmnYXt2VZXwpnA==
X-Received: by 2002:a5d:45c7:0:b0:35f:2161:1fc0 with SMTP id ffacd0b85a97d-35fe892bddamr1198669f8f.70.1718200382941;
        Wed, 12 Jun 2024 06:53:02 -0700 (PDT)
Received: from ramallet.home (cst-prg-45-36.cust.vodafone.cz. [46.135.45.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871ec9e6sm28201695e9.38.2024.06.12.06.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:53:02 -0700 (PDT)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: [PATCH 0/9] New DRM accel driver for Rockchip's RKNN NPU
Date: Wed, 12 Jun 2024 15:52:53 +0200
Message-Id: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADaoaWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MjXTNdQwPdovzk7NQSXUtjQ7OU1LRkQ5NkcyWgjoKi1LTMCrBp0bG
 1tQDVw8QnXQAAAA==
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
X-Mailer: b4 0.13.0

This series adds a new driver for the NPU that Rockchip includes in its
newer SoCs, developed by them on the NVDLA base.

In its current form, it supports the specific NPU in the RK3588 SoC.

The userspace driver is part of Mesa and an initial draft can be found at:

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29698

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
Tomeu Vizoso (9):
      iommu/rockchip: Add compatible for rockchip,rk3588-iommu
      iommu/rockchip: Attach multiple power domains
      dt-bindings: mailbox: rockchip,rknn: Add bindings
      arm64: dts: rockchip: Add nodes for NPU and its MMU to rk3588s
      arm64: dts: rockchip: Enable the NPU on quartzpro64
      accel/rocket: Add a new driver for Rockchip's NPU
      accel/rocket: Add IOCTL for BO creation
      accel/rocket: Add job submission IOCTL
      accel/rocket: Add IOCTLs for synchronizing memory accesses

 .../devicetree/bindings/npu/rockchip,rknn.yaml     |  123 +
 MAINTAINERS                                        |    8 +
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |    8 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi          |   53 +
 drivers/accel/Kconfig                              |    1 +
 drivers/accel/Makefile                             |    1 +
 drivers/accel/rocket/Kconfig                       |   13 +
 drivers/accel/rocket/Makefile                      |   10 +
 drivers/accel/rocket/rocket_core.c                 |  155 +
 drivers/accel/rocket/rocket_core.h                 |   48 +
 drivers/accel/rocket/rocket_device.c               |   39 +
 drivers/accel/rocket/rocket_device.h               |   40 +
 drivers/accel/rocket/rocket_drv.c                  |  243 ++
 drivers/accel/rocket/rocket_drv.h                  |   16 +
 drivers/accel/rocket/rocket_gem.c                  |  136 +
 drivers/accel/rocket/rocket_gem.h                  |   33 +
 drivers/accel/rocket/rocket_job.c                  |  708 ++++
 drivers/accel/rocket/rocket_job.h                  |   49 +
 drivers/accel/rocket/rocket_registers.h            | 4449 ++++++++++++++++++++
 drivers/iommu/rockchip-iommu.c                     |   39 +
 include/uapi/drm/rocket_accel.h                    |  116 +
 21 files changed, 6288 insertions(+)
---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-6-10-rocket-9316defc14c7

Best regards,
-- 
Tomeu Vizoso <tomeu@tomeuvizoso.net>

