Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618FDF6B
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 21:40:56 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ac80da3443so25997491fa.0
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683322854; x=1685914854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=DsaeYxBU9g9ForTdiZgFVwa6RUI3toWnWlz96/jahjNzwSbmn/2HQNYROEFyAwIMO8
         NnUj5lJqrseuci7k8O7sOSJ5XG8Xd9e3URRFhsX396dPJQ+R5Txpg6tzKxsw/8hKciNE
         okodG+YCb0JdaL1ahWKzBYp0foaKHNB0welhxglGvuE1K5ah+tFcYLGawM+3Xn4KqgM0
         HuIrnt3DyPHKhEj8arOj1q7ztJxrdHMVhK9RAMeqFxiAfSyDvi6EJTKZHazRq2U6F6qI
         5lV/gD5B2FhzKeDOtd6pk2wbtNOK+H70FwrMVAFPcmuYeZXDu/W24gHMt+VFgrC6c++I
         ZUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322854; x=1685914854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=aC5vRrrm0FXSfWfN3vXUcKY90+itkqIHi4bOfyTQ9Dx7X6Cx+4Y9fj5xdoj+7PUv2i
         puFTH3q0t2XlAdo+8lgB+vuMeSLTPu5PmTxE0coTVTdb7Pa/T6IR4gxvxI++fxFch2/F
         umry07VKdEQGOj+FFKVlNSqaFocZsBoYNBRqHU1CKF7iHKi5zpkvvpVdnnVH7f0XTQzV
         IXYWRZ9MFXn6FVsTJeMdeZhV8jLy1oaKSxIgz7rnR3Fx2Bprte+GIsn7/gfrW4ZSB9f9
         jilykYguVt8lgc3kFhIgNOLiAckZOOr/EYV6JuuP32OwNa6LtGrDORHoOadzwXuvgL+U
         EpBQ==
X-Gm-Message-State: AC+VfDxU5OnypAGTkxsLOg87DB/RNu/k+zsGLuRtge9CLP4sCEGi5gsM
	rfPOIgFDUyolSkdrh/ylTdZqYQE7DtXq3lmJ4o8=
X-Google-Smtp-Source: ACHHUZ65Q2M3eywt4gCCW5xrW/hUx4DubH+77FjkC11leG51pxPBtoPmHzltCvFUlKN7HuVg1GQ3jQ==
X-Received: by 2002:a2e:9f4f:0:b0:2a8:bf74:61cc with SMTP id v15-20020a2e9f4f000000b002a8bf7461ccmr850139ljk.26.1683322854648;
        Fri, 05 May 2023 14:40:54 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e720c000000b002a776dbc277sm126453ljc.124.2023.05.05.14.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:40:54 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 05 May 2023 23:40:33 +0200
Subject: [PATCH v3 07/12] drm/msm: mdss: Add SM6350 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v3-7-9837d6b3516d@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683322839; l=1447;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0D7OZJvsI1VqBAldTbVtRFbwuC+jJW8mAUrMe9Ykcbs=;
 b=tJk+hp42JEbVFdnnUZXF6Ww9u3ITN3Ny597c6lPUsEhtqF5AmZGzbMxXnXmKA+XitE4rGDxrE
 jwtK6aBm5J9CLs9cD8i/4dS0CLFRzKzJ+bKuJZvxO64kE4i46eeWmGk
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

