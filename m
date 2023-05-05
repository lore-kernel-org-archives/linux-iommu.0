Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06160DF71
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 21:41:03 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ac8d9399d5so7756521fa.1
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683322862; x=1685914862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Cgx0VgjSWF36kTiyIdxe2LPUi4kT2lQKkyyJC5x69s=;
        b=Gccfie7GMOugjyiUVru/AmbzWeTgn3lIDnsiRORE1BLhhAhDo2q5OeGjUTPqdrkPBV
         42ByFze8DoBI5q1FCMCT3Iqs+bmFU9i+JGnGLiFcDLLR+U6BR/AlJJoHqfO5asrH7mPH
         tUCk2VtfCESPRGvyE+inqnMfl0UcEkoyWEGYVTdWp4vxAJonCDVB+us6Iw92/tmXMKch
         lHBlg/1zA/bh25rGZ61FMJcGz6CSwAPlGrSppo1mdMsb5EsYAZ3p1Ep7bEJedfnQfzJW
         ihCWZ0yivoUcwJphIuwej6UOCSM9grvNt6HRpYB4LNcg3PISN324cVw3HYfU0OzB2t6h
         AIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322862; x=1685914862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Cgx0VgjSWF36kTiyIdxe2LPUi4kT2lQKkyyJC5x69s=;
        b=kXZphfHDJs/PPKE7D3V9WOI9q24GR+Qc0Be80HKE5tgl6+VmRyWfw6MUrhWgu9UW5x
         Qd4rx34rG2qy1Ay0YoGnAy2TkzHK9wT0NYJpsDh+xb+QFqUWmDNEpZ5qKgLIgJkSPZWf
         ZYCvOiqFyEhKtRUdU5Zsrr0jfTYdr2L9ezW6Lr2alvpdtxACVwbZ46/wdowGUXbLo3Mg
         3CZ4+Ec7DUgK7MIlP5GNYxOuinlscvcmLTIJsr9ceN8f1/gsn4rJxckOqpgubTmL/bds
         RgfHvqIRV8wycR7OYl7411yv6i87rfnGqJiMqSwKyZSqbPIaZwmfdNuqpD6cAjdQKDsJ
         Pzmw==
X-Gm-Message-State: AC+VfDxFOSew1Q4cmLbYhARZzJ2BFWfaVicyX7moj2dQReSbm/uyH58F
	oLcR2wjPWyAN46mZWcEyCR3rBQDs0OE9EhY0EW8=
X-Google-Smtp-Source: ACHHUZ4+K+GhXhvLSXj3jdIBiVBVY1fOjuTIzZpxArJ+LOicJ5uIxrApQrg8YtPi+bMU1mnhxFICzg==
X-Received: by 2002:a2e:9056:0:b0:2a7:9a7a:f864 with SMTP id n22-20020a2e9056000000b002a79a7af864mr953234ljg.5.1683322861925;
        Fri, 05 May 2023 14:41:01 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e720c000000b002a776dbc277sm126453ljc.124.2023.05.05.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:41:01 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 05 May 2023 23:40:37 +0200
Subject: [PATCH v3 11/12] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v3-11-9837d6b3516d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683322839; l=919;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hMmDD+SgonZLP46KBM866xQojXqpPqEZ25ow2fxLp/E=;
 b=zckkfPprq0LAaufGJdyd08HwqQ+DvDuj3pjCVufSbw/R95EDd1/WxZUQAiuD3r3x7v5RBq0Ea
 rvoL+U9hlerCFPzxbe1MTtGhJLaUTYkcG44IEB3EaL4dsVNizhDuuO+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the SM6375 DPU compatible to clients compatible list, as it also
needs the workarounds.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index f945ae3d9d06..d7d5d1dbee17 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc8280xp-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ }

-- 
2.40.1

