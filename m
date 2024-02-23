Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FE14D43B
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723319; cv=none; b=HGjqTBtj2fSMJokMVJJLE69VpsT6M4wWR3UnoHUwbMPZ0Jookpuuu1tUPhQvxBEMLpoVIY1rotWQKkD4de61nGTAuoBJhXvJaFtu4b3wcU0mKxUhEbOupk402SBaox1o4QtHgPIVOEpxhadjx8+ex97R1ma+AZ3ktSvW/DRKtko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723319; c=relaxed/simple;
	bh=2VUaTHaFXwk9sVr7gsAachnQpNO5KMem0UoFA2HST7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHAgBJlOthDNSETcl7gNvfAIuDTWYCqHyN/6i+xI/B7sFK9dSNZr/R0deTS5Cq7IsWnAkRu213/M/N26ZDoEzpFrbbVZZz9ZbOfgtTpEN54mIXM96KzyxvvklL2LyIbgXbL5osrBtdJN5JDLvQUcrFTJT1C18n8yyLGBhziNkuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eJJT0q7V; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJJT0q7V"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3566c0309fso111627266b.1
        for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 13:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723316; x=1709328116; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjP12Zq06nby7HMeSJ/EUbYJ63ENO6BkYD8FuiAok6w=;
        b=eJJT0q7V25uYAGF0/7EjV1TLXZ5p3pzjdsyjSBc0WDH9LSq5vmPFvEGxf4pP65bYka
         aXvwKO9RYntCc1UyWgurgHS/wAZvQ5h7OOhVc8hJCBx+Vh2H/DTisfuGO28b5mPwoeL3
         KF0YUjFvwnMEM3bMqBnQ6SVETPTM167NLRr5YE4aqSWAjHQUH0V7GHzFeZNSU47QaL3v
         5CzSpIUha+WMpbYjPAzXa24O6qASlqm/V4SBdANcZsLR+qNBr6sFGUCrI+DNPUICHeAt
         zRvGZTG8ZxFPd2td//bE+hQmYX9gS9LeZvAvcJOl3Oy/hFIvq/goOUbepiI9X6TcjFye
         Yjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723316; x=1709328116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjP12Zq06nby7HMeSJ/EUbYJ63ENO6BkYD8FuiAok6w=;
        b=tA5MZGTUMiO9VVbB2814S9Z73UrrQtM9KmFOGKmKxOcXFMZMGyTQmfgLYSlCJKKTEs
         QE3+rEByVL+Vd8WCxmR8QEaxuqidrohl3Afe0J1meaafdNLDId5PIi4bTuaKC3OIrW2T
         mLQjox24yOM8SavsV/P1vQGfcEJnXNu2tuF4ChlsHTs33rVWguHn4WpY32u6Xe2zXk0y
         pcjCTkF9ZZ6ppubBpiHzHct8Lf4Ss4ArAVX6Pmou2r2lXvwDQk9lwXRFZYGSUp3+ECfe
         fDhf09DY8fW5zoUfaRgi7nS8UYMKCTGbliBFibi+Gmhjs7OP/G8siCt6vv3p3OSfu7uD
         zVug==
X-Forwarded-Encrypted: i=1; AJvYcCX5RCXPcT0aOruqJ6fTIp6CSICL4b1GxdKeMbcTSSK377ezFfWtIG8jppVysdk+KvHCLpHsHStWYiozPZj2XgUi1ElaJxU=
X-Gm-Message-State: AOJu0YzgrKRFsi/HzigtEbNlQqPt1H4AdO2MREYZCXFEW4yH4EGLzQAp
	ZLkPG3rY6P5dpTCmvHK9ciHI1DQGdVbH3Ze3HAm8YeHPFmhR9kpOP6GMLfxJEYo=
X-Google-Smtp-Source: AGHT+IElLGA1VQIlXAlt56rTNEpM3OmiudTre3s73PFHTGooTnhMqgF/0YDNxtDTUSbwvvaMjDFiOA==
X-Received: by 2002:a17:906:a38b:b0:a3f:721f:a7ac with SMTP id k11-20020a170906a38b00b00a3f721fa7acmr600921ejz.45.1708723315809;
        Fri, 23 Feb 2024 13:21:55 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id mj8-20020a170906af8800b00a3ee9305b02sm4091226ejb.20.2024.02.23.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:21:55 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 23 Feb 2024 22:21:40 +0100
Subject: [PATCH v2 4/7] drm/msm/adreno: Add missing defines for A702
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v2-4-2d3d6a0db040@linaro.org>
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708723303; l=1379;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2VUaTHaFXwk9sVr7gsAachnQpNO5KMem0UoFA2HST7g=;
 b=NXYDavFJ3TC/4KiU+OLYy06EnXZgFmyjLCFX7iZKoUTbin8UI3o1WKHxiAxISRJ/Lpa8whlgL
 OmvgcvRyQ93Bgd7cMUYUQkgAXoezpOmzuvOSNtRIQf2InPOAkx5rZ92
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add some defines required for A702. Can be substituted with a header
sync after merging mesa!27665 [1].

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27665
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx.xml.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx.xml.h b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
index 863b5e3b0e67..1ec4dbc0e746 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
@@ -1945,6 +1945,24 @@ static inline uint32_t REG_A6XX_RBBM_PERFCTR_RBBM_SEL(uint32_t i0) { return 0x00
 
 #define REG_A6XX_RBBM_CLOCK_HYST_TEX_FCHE			0x00000122
 
+#define REG_A6XX_RBBM_CLOCK_CNTL_FCHE				0x00000123
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_FCHE				0x00000124
+
+#define REG_A6XX_RBBM_CLOCK_HYST_FCHE				0x00000125
+
+#define REG_A6XX_RBBM_CLOCK_CNTL_MHUB				0x00000126
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_MHUB				0x00000127
+
+#define REG_A6XX_RBBM_CLOCK_HYST_MHUB				0x00000128
+
+#define REG_A6XX_RBBM_CLOCK_DELAY_GLC				0x00000129
+
+#define REG_A6XX_RBBM_CLOCK_HYST_GLC				0x0000012a
+
+#define REG_A6XX_RBBM_CLOCK_CNTL_GLC				0x0000012b
+
 #define REG_A7XX_RBBM_CLOCK_HYST2_VFD				0x0000012f
 
 #define REG_A6XX_RBBM_LPAC_GBIF_CLIENT_QOS_CNTL			0x000005ff

-- 
2.43.2

