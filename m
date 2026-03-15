Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F834DB78
	for <iommu@lists.linux.dev>; Sun, 15 Mar 2026 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773594615; cv=none; b=gJzYxtS5ACH1IwTMFV3Dun8EUGWX0X6LifZSYIp75Qe3m2KQXCuRVTd1MBTd+rfm1UXpu5qBF+42B/N2H/utdiS9JGrgNhR2zc3zaYVvdMj+vvWuLYz0f+0/uQZXlkACws/LallZiZeuLrYnP0rcxK0swoxzevxl1HlH2Kx2SCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773594615; c=relaxed/simple;
	bh=X2kUz5nHL5XiAs/ZDNCCv1RvapPVxMGz0DObMZa9Gr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSdPC2wZeaAUTQO/TpoS0NXZdLeVY07Tkneazip8p6e5J+gxD0J2dYv7ngKeR0FuPriDA4qxTjLCeCcX3J6hK9C7R2L9oc5Rt6L7rk4sahjx+mgB1k18RwGDzNn6r0wHc5SMu3WiBllniOk/UA4N/n4nI7jH0PPI1gId9UPL9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpS8Wnpz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpS8Wnpz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48529c325f0so26993665e9.0
        for <iommu@lists.linux.dev>; Sun, 15 Mar 2026 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773594612; x=1774199412; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xV6Txy3YwZU1/EL+wdEo3NK0bX74rLLA/17VTSLTvI=;
        b=NpS8Wnpz2FxEf59w1VikKdkazxJwt6x6hZ5gpGEkC/jdmjJT0rhdwQpj/U8frxIPKR
         sZ56krIbOxbrAxyzGpGWv+lIuDwozMli1gvBEYuxAXmDRB6LhZRXMGaFRuDDwY9OecrH
         GRNW7Kz7GNpw3dDl1Eh+tuZJoWia3QbrWw5KruwtA0Yc21ZX92T/R7uHnA6UwQSakwYu
         LJ2H9/9ZkwhIM2SjaNuSAy38y5KaXrsVYMyYIL+LBWTXHPnFaR78dIrR/K0R/KLiQt2f
         JxogyC7ilgbY9WSL2UiR3lYQeHO40r0F2tRmIFxus2+rVx82xozbnyUyFnvZcXzY+Prx
         67VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773594612; x=1774199412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xV6Txy3YwZU1/EL+wdEo3NK0bX74rLLA/17VTSLTvI=;
        b=TbZ5aneAlto/tXUzGtKBdVmxMUMiaPY81qH6qWzm3fHwCfbQQIyHCocO06FcVd2fCm
         dTLaEPUfVaV0/y32OIfiDNkh0PBl4jq0xasK5xHEHWNPrCLA7GcxZey21kFRSeo0xjSU
         wEYcpIJiaiMvDbFXJ+OXQ1opUyQVXcJoG7p0zYePCTPFOUMzUCmTCngGpAxFYaFUBo1C
         JnkAogS9U9MhX8LL3Hk9GOIe+bH/8TzjuWJgjUqr25zSdtuLTdlCi7CqpQexOOxSD9pO
         ktTsbuJfpaMNQlVI8CSt2oDEaiCwAz3a4+moY1G4iMzGUjnkz/E99TD5cChW9HUJz92w
         w4CQ==
X-Gm-Message-State: AOJu0YyZOFolPk8LDVyFwoc4qntE5v+OMmrRkwby6ZrW8x/dkZbtrpS3
	P7HuKz0BqDvtOIZPTxUcnnbBm37qtAwhHXOnJllS1bjTc19skKex/VH971xllQJ4JKY=
X-Gm-Gg: ATEYQzxeCWiBToB5wQYx+BR3DDVtbK5YwPcrTxP1cxvc/6rt4ZvucVEFRIBR480PhgN
	MeEBmrfxQvBiWOiUsBkh3oAIWr3Ayzf8m9qz3jIJF71SYQLKNIKo6jFigoYQa3wVsplU1iNjGWa
	/Ene6mgI4uVqftfJGQhqN13rt0im5zaI4c5gNntCGHLR3oXanQiNnIWwlM1PseZa49Xb0HMdfpQ
	G9Q9VVpryudziMkSlbaM/xjAi4zIlh3umyjcfke+IXA9e32UAWSpIuw9zCU1o5asOFZ6mMLOUwI
	zkmXr+rC1q8Uy9/rLROLwnv9ixNvhA+83mvksHiGdH4t7eYurhEhz+2zoZ3DR+QPSzJhJrS9yLE
	K1A1/iH3eZAtLND9Vbr7t4LOmub9clTelAACbf0PGgWNpJp5trpP/1TgizECz3EdGvoiivBwoqG
	qDv5juuMkB5RvgA2UDc3dInwb0zr1Ob58ipencwSI0rfHc6vnUAHijDEwYv6SMmxneJq2Dak7Ms
	vBk/sXCOcZZajm2D6nnsSEYy7c4cEhAvApMyezR
X-Received: by 2002:a05:600c:c049:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-485566f7a35mr135679855e9.20.1773594612196;
        Sun, 15 Mar 2026 10:10:12 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19ac5fsm36698700f8f.1.2026.03.15.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:10:11 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dma-mapping: fix false kernel-doc comment marker
Date: Sun, 15 Mar 2026 18:10:01 +0100
Message-ID: <20260315171001.66010-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change /** to /* for the DMA attributes list comment in dma-mapping.h.
The comment is not a kernel-doc structured comment and should not use
the kernel-doc opening marker.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 29973baa0581..0c2807e50bdf 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -9,7 +9,7 @@
 #include <linux/bug.h>
 #include <linux/cache.h>
 
-/**
+/*
  * List of possible attributes associated with a DMA mapping. The semantics
  * of each attribute should be defined in Documentation/core-api/dma-attributes.rst.
  */
-- 
2.53.0

