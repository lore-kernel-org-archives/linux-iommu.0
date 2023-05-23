Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9AE5393
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 07:46:59 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso1854139e87.3
        for <iommu@lists.linux.dev>; Tue, 23 May 2023 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684828017; x=1687420017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=onFfnqtR5yrpP3jRaY0W/Qga5bscYlUen7iTMOk0/JJ05+Z8CYqvI8fM0ToLopbAs6
         zZ0K/aZm09iP2yzXRio95pqz+AfMkRzCmJGYcT6jbdArrRUVAeD+lRI3/ifhcBwIKegP
         n/m6TaYD535pRNjLTWggrFFSrPsKiTFcT5+Dpmwjaw7MIP8RoSg2Hwj+nDCDyFwuZJRd
         JQZAaYi2LY5ZYj209ShmUV1lBM03XFQySjkHxtanl2vIKpK3QOSLhehWaRKmOPp1/3cN
         EdlctU+F9qezbhqwXbdWcvkF2BU9jo5t/XZ42eAA9LJJODzbqGLoOGvBCHb0B6UZTb46
         vwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828017; x=1687420017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=NRH9Dz+piU09pwFfCo/S6MTXHho5UIskqU2LWcbcji91soGumisUELNLLy9u5HClwM
         co9s5gikUfLs84kR+bdrHm0Y5uxBmvAvpNVqF9nkbqpZCdxHtvDJna2z04vl0ICyaKn0
         enJXoKfwb9zPFHRGtLf2X2OGRVmGCs2HSLz21Be8YTf21RnhWcRTX3SbMmvivvB6BSuO
         0rAzCBnax/KcVEyhkalt4S2AkVXPR+W/eioyj4n/xARPXfZ0Tzv5AL/KRrawqzJtdIIV
         pASI5Iar1HOKUhDpI09d3/atN5g+3LblyoCU2V3RRwZmHSmrh2lePn3jYMESlUh4q8re
         iqvA==
X-Gm-Message-State: AC+VfDwKKyHTrfTU65Str/OFTz3dKNpyyz/+HaejnXUHPEkapY/zsUIS
	IkEEqnYsfqa73w2OOTBWUv1HGA==
X-Google-Smtp-Source: ACHHUZ4GM3KI0MX70ojcXWHjh2BX5gdvh+2jKGNgOhivEDVOtDyjTmgQcXQe6u/dE+6ErgM8HF3U1w==
X-Received: by 2002:a05:6512:241:b0:4f3:bbfe:db4d with SMTP id b1-20020a056512024100b004f3bbfedb4dmr2235214lfo.21.1684828017373;
        Tue, 23 May 2023 00:46:57 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id t9-20020ac25489000000b004eb0c51780bsm1257070lfk.29.2023.05.23.00.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:46:56 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 23 May 2023 09:46:18 +0200
Subject: [PATCH v5 07/12] drm/msm: mdss: Add SM6350 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v5-7-998b4d2f7dd1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684828003; l=1447;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0D7OZJvsI1VqBAldTbVtRFbwuC+jJW8mAUrMe9Ykcbs=;
 b=TAr1B/J8Fw4CbqlqV0fqrm0JKRVpsmTK2l29sM7+FcIchk7aAujxMonXnRCxaIbdOAlYDXrPe
 hiCF/x7Su9pAxMo2i4IgdPK5fVh9jtF1gNJwi/4saYxWY5K1xE5t3X/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add support for MDSS on SM6350.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index e8c93731aaa1..4e3a5f0c303c 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -538,6 +538,14 @@ static const struct msm_mdss_data sdm845_data = {
 	.highest_bank_bit = 2,
 };
 
+static const struct msm_mdss_data sm6350_data = {
+	.ubwc_version = UBWC_2_0,
+	.ubwc_dec_version = UBWC_2_0,
+	.ubwc_swizzle = 6,
+	.ubwc_static = 0x1e,
+	.highest_bank_bit = 1,
+};
+
 static const struct msm_mdss_data sm8150_data = {
 	.ubwc_version = UBWC_3_0,
 	.ubwc_dec_version = UBWC_3_0,
@@ -571,6 +579,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sc8180x-mdss", .data = &sc8180x_data },
 	{ .compatible = "qcom,sc8280xp-mdss", .data = &sc8280xp_data },
 	{ .compatible = "qcom,sm6115-mdss", .data = &sm6115_data },
+	{ .compatible = "qcom,sm6350-mdss", .data = &sm6350_data },
 	{ .compatible = "qcom,sm8150-mdss", .data = &sm8150_data },
 	{ .compatible = "qcom,sm8250-mdss", .data = &sm8250_data },
 	{ .compatible = "qcom,sm8350-mdss", .data = &sm8250_data },

-- 
2.40.1

