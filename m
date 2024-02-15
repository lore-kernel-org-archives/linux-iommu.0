Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DF17591
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988838; cv=none; b=HZ25XiVzQelVDVCg8TMqPrq+bQOjPZxMUKswOndV+C56K2uet0SjKw1+UxvcsZTGXt7UOxe4+3DBUKXA/kXXqE694y0F1sYIjXAV3ndS3V4nUBV3S3izYlPVtk4D/zvNf8QxuL362VhzULxorFgGeWDbdIf6VQCkP9W3movcdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988838; c=relaxed/simple;
	bh=B2VkxjrRCyr4kbi/Ih6iBNEXikEKFqg0faRJON0SE+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbXvXkxDpRTPntgqaAbpXjwrZHcIxA7IgRGGJhLvKzZ77lSl7nW1Pdq7D7k4fldtq5z3zLsOf3XOycAUa2PfZcr5yJ4r8wIKJ3k5ijbEFaFG5t3QYkh0GXzt2EW/wxfYQhawEPF8mzP7fCkD0fOyChT/OCbqeKdUjyEbJziDDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gWFzceZl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWFzceZl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-411d76c9ce3so5257935e9.3
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 01:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707988834; x=1708593634; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ygFt5WEvBpqUpx/ZfEWpp/27W6mJ4fXmmus9YC0aao=;
        b=gWFzceZlAxElJmgEAWfMGLfiaabfyMhMFZlzakYeB5twXb8ttlxPc7EfEq5rGiYCvx
         Dy+BzGHbglpb2oqOvTgekBuA0uRX8xGPgQjMnAOrWStqARk8d8L3uoSSybP/6KuywsSD
         dB4VMWP9yYKspJNETt9GUICggVvyH6WRG5PeDKm9ma4DwzE+vGNcFD3zYPL9d04U0JuK
         cJSSoSo9JDwpP1+uyls9uQXtRxPPcPKqReAXiVwT9w1JJJxC6XZZwdAjzkMTpYNMfCJW
         B/W4jYkM7O3oEB28OoMuptz2sl1OFFm93TEGtCz6+EDa9aJfg08Wuea/YauGKydKVHaD
         QhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707988834; x=1708593634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ygFt5WEvBpqUpx/ZfEWpp/27W6mJ4fXmmus9YC0aao=;
        b=g5J6KWC/NTA6mpNzpLpvRlbdQCQ+hWWDKQpxfKotfpfz/Qys72gVMIUQPCP+2HGj34
         l2a4KjiN52MXEK7exF6vvAp+DiqpD9nzXXJUb8FFnmQz3Dkn032IQxkRkS/ViJpO8KtR
         FRBItkmwlqRltHXEcfv1IMFCpsrX/xBtrh6oshK6vJxbEOHUw23TTHxyNC4IBbvbpSE2
         qR4GF2JQ8CXYeQwEBufNCIduEwDhkDkujM1SaXytppUgzW2Wnw9E+yCUQQyIg8SXC7lC
         lbPhHtxc1FSb3RJGmR2zmciLLRwdWIJyYdnVjcG0mdGOD1uCt1gA2xTCzWdz+5rgSvqX
         VmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv3LH5Jkzvm4sDBIPc+W5+m/CVxwRJJ0V7ZcZ1DFl1NlRZgmjOcIAuI2LdnRTD+g0pMEpzjmGcsW7vxw9kA9jt9nLFfaU=
X-Gm-Message-State: AOJu0Yw6go2F389Rzike6GcFhBISDksmvRw+WcIeFm80QkxzYo/e4ybH
	pFFVpNRZHH16NSasiiZoI5BtL6SrysqAhi5bLPSs6eGCz3sAVHVb4h6lawd/L515sVw9tL0YSTM
	cBQPZqQ==
X-Google-Smtp-Source: AGHT+IHr6EIY5IaqJsX6nTJIJL95gxp6F5b/cqLuuSuiPNhGAbkKg8Oqmhr9/MhVWmYu+JmkeXZw2A==
X-Received: by 2002:a5d:6205:0:b0:33b:131b:d8c1 with SMTP id y5-20020a5d6205000000b0033b131bd8c1mr830193wru.66.1707988834512;
        Thu, 15 Feb 2024 01:20:34 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b0033b66c2d61esm1156435wrb.48.2024.02.15.01.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:20:34 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 15 Feb 2024 10:20:25 +0100
Subject: [PATCH v2 3/6] drm/msm/a6xx: Add missing regs for A750
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-topic-sm8650-gpu-v2-3-6be0b4bf2e09@linaro.org>
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
In-Reply-To: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=B2VkxjrRCyr4kbi/Ih6iBNEXikEKFqg0faRJON0SE+g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlzddb1o2L2JxYU4dBpeU0HKoP1vroEL7LdMCezqtZ
 gfjwvXCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZc3XWwAKCRB33NvayMhJ0YUkD/
 9qLaDOjrM6piXhQRYK/i3fQkR18QxDH9oUXsgK71P1WL7T/sD8NNMAoo703snTLkzqTlmnf4CXu1qd
 7lC7wxhiKxpQXO3B5GdZ/RKiesscwFJn44lVY1ybLECyxTldEu7k4RpkeZ+tslnzVw/D990cKWHViI
 2QbZ1/KogldxveyiRY8iPVTjJI/YB/JiKrDJlIKE9dKcwpurOIt9ezL05fCs4lejcvcKcgOup46guY
 wfSsjHyFzWkeiBAtuk0XPAuo3gGFrXIvWobHrEhfvArLoPVihzapOipOwP4LI5HMONmcQKIlyoWfFT
 OqOmbrHNHR9Zt7pUS589p/9EZIIARfbX7pXxHkd85yDxt05Xx2CBdAeN+R5ntmxOjthtvpyPpivqfV
 SRp8exyNiJo5PskG49xEhVPNK0lCuLMie/tA3EGzz65+7mHUDG4mHDUS1iFwIvi+ueq0k+gLOWj1pD
 NkmRfvclMXK7tW/tEEsdiRq9J0V7ff07QWwOo6Aht6u8nXT4PTl4QLU4HUL5l74RB37Y8u/VCe/xWc
 leZE6NwHMngwOo4np7EQUu2AeCyKefiFsCErQEs4CPecO2H6rRhfoZkBvc3g6hauQ45kln3lEoggnr
 6eog8DskhoUC+fXUOhab9hmCAba/BIQdkfLJuDMcrgJ5/2Mygit3ECp9JPiA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Sync missing regs for A750 clock gating control related registers
from Mesa a6xx.xml.h generated file.

Those registers were added in the !27576 merge request [1].

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27576

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx.xml.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx.xml.h b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
index 863b5e3b0e67..58877464692a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
@@ -1725,6 +1725,8 @@ static inline uint32_t REG_A6XX_RBBM_PERFCTR_RBBM_SEL(uint32_t i0) { return 0x00
 
 #define REG_A6XX_RBBM_BLOCK_SW_RESET_CMD2			0x00000046
 
+#define REG_A7XX_RBBM_CLOCK_CNTL_GLOBAL				0x000000ad
+
 #define REG_A6XX_RBBM_CLOCK_CNTL				0x000000ae
 
 #define REG_A6XX_RBBM_CLOCK_CNTL_SP0				0x000000b0
@@ -1939,12 +1941,19 @@ static inline uint32_t REG_A6XX_RBBM_PERFCTR_RBBM_SEL(uint32_t i0) { return 0x00
 
 #define REG_A6XX_RBBM_CLOCK_HYST_HLSQ				0x0000011d
 
+#define REG_A7XX_RBBM_CGC_GLOBAL_LOAD_CMD			0x0000011e
+
+#define REG_A7XX_RBBM_CGC_P2S_TRIG_CMD				0x0000011f
+
 #define REG_A6XX_RBBM_CLOCK_CNTL_TEX_FCHE			0x00000120
 
 #define REG_A6XX_RBBM_CLOCK_DELAY_TEX_FCHE			0x00000121
 
 #define REG_A6XX_RBBM_CLOCK_HYST_TEX_FCHE			0x00000122
 
+#define REG_A7XX_RBBM_CGC_P2S_STATUS				0x00000122
+#define A7XX_RBBM_CGC_P2S_STATUS_TXDONE				0x00000001
+
 #define REG_A7XX_RBBM_CLOCK_HYST2_VFD				0x0000012f
 
 #define REG_A6XX_RBBM_LPAC_GBIF_CLIENT_QOS_CNTL			0x000005ff

-- 
2.34.1

