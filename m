Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D83DF71
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 21:41:05 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f139de8cefso17557530e87.0
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683322864; x=1685914864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKTw5Zfw+dKxxnY8fd/tof/aQPft5PObVsbIBwm4nOE=;
        b=ukT0/Gbl014hMNt6POWBZru46jjtyO67bCDOzbZQZOMZh/Xs1H+L8K6mDJGk6hCggf
         hP8OvDws58qepr8kd9WeIEaA83Rd6PluO+iUO5+29SlGxYywQWhIQE8qIa4GBG418mt8
         c5l3uHkpi/5r7sB13IdmqPFrrHzj/BxFMY0JaZPSq0RF8ukN/qvrdcvLllwn9NNL5paG
         xQMSTWDqos2eRlNGrdkBtaReQd/VjqO7SYfT15338L6qPFxVkRTh6Q6AfSncogyQyH45
         fZbyB/xTGzrtQcYxtMwV24Pyo+2bBYQzas5NnRA2v+FQniqofEXyRf8f/6JQ4+lNTg6F
         2clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322864; x=1685914864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKTw5Zfw+dKxxnY8fd/tof/aQPft5PObVsbIBwm4nOE=;
        b=NrmQft3iKg7JLe9T7mbuYoyIzxW474XqbWX56HntP/GIZl5vFUg8fD4gTkpvev8EtE
         MNSqbj7+soXAXaGWT67ufCu6gIAPMc37a9WFyNgmxMxPe6prv4lq9K8NSagAnr8HyfX/
         W5RVt1loI0UtT3CzCWKzDXWMNUDamoWfBYpsfGsUqCsZtlz0e1ZR2vwkUEXpRYoKWV+1
         PFy9UdOTq/LV+bFfk24mxse5O3yOw5T1CasifOXK25K+1YJn7GGu9EaVny/974Z0jjs8
         ZSyE5fmU5bu1iJE1cbcYuYh5itBPtJFNa8KiuiE1JvOIOyRgJPKGVIhD2kTyUnwSARF0
         drCg==
X-Gm-Message-State: AC+VfDw374dznV2PRIubH2exD3958JDXK8qMAT2MBJyKEStNLYmTe6Hs
	31lxmRg7RP/w/ZiTu0IGWNIm/DN1O643sDv0/KA=
X-Google-Smtp-Source: ACHHUZ6ZtEMdLb5DxiTNnLAorcEKFTUditPxbDFGZDHqLOLxFtWNDnrraKKGdt84CJWoao5/f5ySSg==
X-Received: by 2002:a2e:994c:0:b0:295:d7a8:559b with SMTP id r12-20020a2e994c000000b00295d7a8559bmr880720ljj.10.1683322863863;
        Fri, 05 May 2023 14:41:03 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e720c000000b002a776dbc277sm126453ljc.124.2023.05.05.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:41:03 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 05 May 2023 23:40:38 +0200
Subject: [PATCH v3 12/12] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v3-12-9837d6b3516d@linaro.org>
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
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683322839; l=1014;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=d3S3xhOuliIdaa9KoHmUn1yxgnvenr1zId8Sw3Pr4Gg=;
 b=u3I52rgeZRIPJW2hyj/d+O+JrD0lLVAtextnz9mrc5yCQjY92j+5ZQdr3tADqPYJVA4RutRv3
 92CfHxICo1ADBe7zjWqCKUtgraxwFrHDFKvLO1TZbLhn+tvZjWcQpLU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the SM6350 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d7d5d1dbee17..e64c737724c4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc8280xp-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },

-- 
2.40.1

