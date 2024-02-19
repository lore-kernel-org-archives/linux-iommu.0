Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6F376E5
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349773; cv=none; b=Sw8p1UyM/b7hTievSV1VjWzE8t1rUV+y8BXmpmnQnHLXT6wgJN60oNmDb07en8WDHbYcqFLz6VQSqETN65xOuECQzmv4/VvSKD5yH2C0HEtRKmSu+gsfUR/eTNErhUVyrDwDuA1RjCmw7vCJIKNLVxNqgWxaWsM1Lg45/QTUJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349773; c=relaxed/simple;
	bh=79Y0MxxohdGitgftXN/Ssqm4c/Qk+6TMe7Z4Gt+3Bxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bPWI2h+nFMLlUUQmHDWMXaXSvZzsA0aU8aY7KRl4O3SU7xw92zu+v6OQgwcfTHbYz7jcAU3C8nzbTg/gOUh32VOHmUI6se1m9GZAh1iy3dl3WgVQagoZ8TB6AQMozoxoZmGSnFqNYoujCuFzEoj4/AMtvOzTvZ5/UI6dA40sNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=txVUxAfJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txVUxAfJ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so5872831a12.3
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708349770; x=1708954570; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7M1e7EmpHdXumiDD0LMXKq+SIP28LzfgFkNX1b4YVQE=;
        b=txVUxAfJSDIBT0unbKWIYW4yOqdE6IFrDhAYNRS7ZMn/Ft8+KAtE+Y9vxC/zinZ8xs
         JQz4jLQoXPBzlP8YUPdviUbJEc1GzojWP5dO13C1vp247h+dQg15Z2tERNV1PUQiKmMO
         TPE54D7IgL12jHOKVLal+ObWPS2VK1eBrO2UBL7e8Dl2C2QWJpuETuMfE/OpgDT/NM4Q
         fj521eGHz3gb8j7EeQbvqfxRtqL4Ru/nVy8IHhUeT2GEkk4y7rHw15pAA1uZ8u5rPFoq
         1jSaIs/ld+jHC9qvX/bZxr8OhcphXGqRzFNA4ji/oFtlnlXyzJyPOCw5o5nT+FSH9Qme
         sIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708349770; x=1708954570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M1e7EmpHdXumiDD0LMXKq+SIP28LzfgFkNX1b4YVQE=;
        b=aPME//oNOuWkbAg2CPl1ZdwN0+xiMh0voVWrZC6OZvn+N0bBRLAOcaowIR1OZAHxC5
         9NmzICu2y91hN8qpNNbEiqugWNAdawxQoKROO0G+FQO4Zz0G51aPVZsptuofQSrb67j0
         Rzs36lGIx4wfK+mqAhaB4M74CTRrN7G2qEjlSNrAPwC8TQ8pGYAe9S44uTAVpxAdw2yZ
         Ruh4G4YWZiHm2Rey0vn7SF56IE/dROVl81i2oSl0X+xqFXP4Kw534CSq/XmSM7neaaYb
         FXgF810J/GD3Jbd8z5WYZ/mMC8pg03x/wEbWkMxzW59gK2QxelE6ExWqMugaHkPCdxxU
         6dUA==
X-Forwarded-Encrypted: i=1; AJvYcCW+MFIc+5xFQnZwvgqbH1Oz7P2bCz73fWy3TrWN5x4izR1cAbT8EVov2IFl2nIKnPOq5Bb/sldyKgCwAoEBqPcVj6ggFS4=
X-Gm-Message-State: AOJu0YzjFPfcG6Wugnx8vy5xklMpufsnlr1W9sILeDrROCkom3zUlpkQ
	KaD81EV/5WNqm0mQVhhhRVNwbcDjt+qRt+7VvjnpE83KmGhVgp8lvne98Ye5mis=
X-Google-Smtp-Source: AGHT+IGYYROFmdLbUMjFpP9qsW46pO/QmXTyHrKREDj8fB5na2NFI5XZWqwX4q89xnCXQ4xvRWeBEg==
X-Received: by 2002:a05:6402:1844:b0:564:3830:b9a5 with SMTP id v4-20020a056402184400b005643830b9a5mr3243810edy.21.1708349769992;
        Mon, 19 Feb 2024 05:36:09 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm2900168edi.59.2024.02.19.05.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:36:09 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 19 Feb 2024 14:35:48 +0100
Subject: [PATCH 3/8] clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v1-3-d260fa854707@linaro.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708349759; l=4133;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=79Y0MxxohdGitgftXN/Ssqm4c/Qk+6TMe7Z4Gt+3Bxg=;
 b=4nQYbPVeI8Be4nvkpxVfXN4FtQYQuTUrRB6I4LVYY/kCkQW6/OyzfiXXuRABMb+6jrO9nZF9u
 NlAaZfORH/nBJ6Eq1c667ga2Qun9siLGQF88pnu9nhecTmr3DokAeBS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Commit 134b55b7e19f ("clk: qcom: support Huayra type Alpha PLL")
introduced an entry to the alpha offsets array, but diving into QCM2290
downstream and some documentation, it turned out that the name Huayra
apparently has been used quite liberally across many chips, even with
noticeably different hardware.

Introduce another set of offsets and a new configure function for the
Huayra PLL found on QCM2290. This is required e.g. for the consumers
of GPUCC_PLL0 to properly start.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 45 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 8a412ef47e16..61b5abd13782 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -244,6 +244,19 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_OPMODE] = 0x30,
 		[PLL_OFF_STATUS] = 0x3c,
 	},
+	[CLK_ALPHA_PLL_TYPE_HUAYRA_2290] =  {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_USER_CTL] = 0x0c,
+		[PLL_OFF_CONFIG_CTL] = 0x10,
+		[PLL_OFF_CONFIG_CTL_U] = 0x14,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x18,
+		[PLL_OFF_TEST_CTL] = 0x1c,
+		[PLL_OFF_TEST_CTL_U] = 0x20,
+		[PLL_OFF_TEST_CTL_U1] = 0x24,
+		[PLL_OFF_OPMODE] = 0x28,
+		[PLL_OFF_STATUS] = 0x38,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
@@ -779,6 +792,38 @@ static long clk_alpha_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	return clamp(rate, min_freq, max_freq);
 }
 
+void clk_huayra_2290_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				   const struct alpha_pll_config *config)
+{
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll), config->user_ctl_val);
+
+	/* Set PLL_BYPASSNL */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_BYPASSNL, PLL_BYPASSNL);
+
+	/* Wait 5 us between setting BYPASS and deasserting reset */
+	mb();
+	udelay(5);
+
+	/* Take PLL out from reset state */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+
+	/* Wait 50us for PLL_LOCK_DET bit to go high */
+	mb();
+	usleep_range(50, 55);
+
+	/* Enable PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
+}
+EXPORT_SYMBOL(clk_huayra_2290_pll_configure);
+
 static unsigned long
 alpha_huayra_pll_calc_rate(u64 prate, u32 l, u32 a)
 {
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index fb6d50263bb9..91d3d6f19eae 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -29,6 +29,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
 	CLK_ALPHA_PLL_TYPE_STROMER,
 	CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
+	CLK_ALPHA_PLL_TYPE_HUAYRA_2290,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
@@ -191,6 +192,8 @@ extern const struct clk_ops clk_alpha_pll_rivian_evo_ops;
 
 void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config);
+void clk_huayra_2290_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				   const struct alpha_pll_config *config);
 void clk_fabia_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 				const struct alpha_pll_config *config);
 void clk_trion_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,

-- 
2.43.2

