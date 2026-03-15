Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83C369239
	for <iommu@lists.linux.dev>; Sun, 15 Mar 2026 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773588950; cv=none; b=EkNI5YJOM7bLA4c97rocKazjnTC4r2mdCnqOjSoQeI0mrkHpLumNCGmBaIm4rTcSW/ayQnOidJOKrpcqgvtKp4nujstfWTVxvL10521VqppQA9PjLjALeYX11BtMojGBksODBGyqLIGRRC08yXq2Tu/Gzd74zyMWHzEMXrjsE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773588950; c=relaxed/simple;
	bh=hncdcHcMdR5dQ4/FGK7HaYA59qPmyQtkdPx0Jg0y1MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kw/ehZjQySOJnIBBJmC5Uvio9SNDRpuaO+JqkoeI0omSp5rcmNeMuAXEEa75oRHP3uvPIVKgKejVxbw0vLt+Ln2klzAXkLI4Qh660vkioSs+tKH+d2p+4RqOn4FTWy2gCRW0ZK4Tsalr7f0S9i1g0eO4rVuTa3H8GPGRh0jgTHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/KUOKeB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/KUOKeB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48539d21b76so25957875e9.1
        for <iommu@lists.linux.dev>; Sun, 15 Mar 2026 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773588947; x=1774193747; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxbCErmmAg1CHRAafzuF+s1iFYBbfBDZ40VI/gZ4ZR0=;
        b=g/KUOKeBRLhXvZK5BcowDiTtX0bTW9Bl1BFGBfakPkgAhmAKIYmljWmmekX/zFrYjj
         U/oqdPaLP1SqhKGWnYx9e46ZW/06LSLBKktmpS53CB439V79hFPKgkQ08EtyPfRfUVzI
         2KI2QK+ScjMrIyWu/ajzzbLgXXPE3/pwwnaxKAh44+gZyMZaQljyAHeSGNKezdefG3iU
         /SFQoO5aHqPqzFSDxHTn0oPiowLIXgiBHBmerfnmkwuILN+yWpldB4KY3zW1uApY/6Rf
         ATVqx92DuIaXW+N/Y2jiahRRkhcSh++X8IWNQckUJebmbLCRDge2Qap3I3LJCw1HNMLQ
         FhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773588947; x=1774193747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxbCErmmAg1CHRAafzuF+s1iFYBbfBDZ40VI/gZ4ZR0=;
        b=f2AE/1MKTr7yZ1vRphVnzwikBwe8xJlBmspnlbfKwWUs+/OPcaXsSP4W6YPxDXNPE6
         4id6u/EarOwt0QZdMQX59e+8gUe5PfRDWTRd4WEu72UQjiS/s2+zLBG/CHW7u1YN07RR
         CIc+wwNBKKNWV498XYEMbRaCNtC8dX3DwZZdCgPro3IDv1HMwYzeJ6kbAT91CBTkc+u1
         oro71SpLHkPpmtkA2kittXKBVXA2RAy+Qx8PoCsxblAVB/ppiWSpBR4wXWNswjh1Jf1t
         42wzZllqep2jj8cNptHVzYrdXTVgIC6taH71dz+onYiJrCX3PfKbR5DtFzACc4AEG4Rw
         WwFA==
X-Gm-Message-State: AOJu0Yz1o6h+y2lUqNAr9Y0/w6N0qnmmQRkbFfpR0pnBGXU6pnMTlZK1
	ocVaLQ1OFuIhg/BjITWTpv8m6CYbjTZpZ0AtYNtj6rKWfES/0NOl5UgK35/UhnZFDOc=
X-Gm-Gg: ATEYQzxxmbC/GEdTIZF3UM3w7UsQetGhxkLMVCSrJRikJveN4vya4tGC2PgxZpbHedj
	zifeBxfrrMp+hM2v6cTln3FUHpGEBvnPImuzdstvMquA++fp7liQVcTRfZKB+ZZRVOgunSyO3jY
	I1OdUb3xkf7A2Cr9njU95dN1k6ytILmvKbPhf8GvmdYUcQE79I7TMq9GwHm7bQerV3BP3/SZ8+W
	ovMALdu2rvpqwm0nmOOOmeoByp2nWSu9fonLaGX0hZqp8ahKUZZKZkxJO1brnhRaEF1IvR/5oPO
	cQhImYzFPVn20qGHZWi+YaOD9nKaXj3vU3E0+UsUQwm/BeViY2SfDzLRIK7TzgAEkLNHuj1D/F7
	VM9yH4Co6Inxc8ymlsicuOvGrYl4k7lO+7NdTTWUCUeQ07cuMr1+VXjMSyorHZ0VktiS24+k+jI
	GRRgeWUfgTZptgYMEILomPs1GiOrXEKOVQhnJeip5RKhcwySu0PwNpxHLoc0+0awK8um/QEIjzx
	VTVXLGs1oaMgQx5n05uzXjsGIHz9g==
X-Received: by 2002:a05:600c:4f54:b0:485:3baa:af14 with SMTP id 5b1f17b1804b1-48556700c18mr166803335e9.18.1773588946551;
        Sun, 15 Mar 2026 08:35:46 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm451391865e9.3.2026.03.15.08.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:35:46 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kit Dallege <xaum.io@gmail.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 9/9] dma-mapping: fix false kernel-doc comment marker
Date: Sun, 15 Mar 2026 16:35:36 +0100
Message-ID: <20260315153536.48739-1-xaum.io@gmail.com>
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

Assisted-by: Claude <noreply@anthropic.com>
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

