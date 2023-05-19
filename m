Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDEA125D1
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 17:04:51 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so3984972e87.2
        for <iommu@lists.linux.dev>; Fri, 19 May 2023 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684515890; x=1687107890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppRfvpEzKntx7DzSp5zW1I4Fc3JFfOMmEmtjxYhv2RE=;
        b=yZnkjyb5A5MRZrT7msho2TdEwx8Dqmdl0B1+Qt4i0PJCAiv4bnobpVDzlvnIruQItB
         XoCu4xG7Nfjv6Z6peYj61vwsgk6ofiR9alcV2/ycEaRC7ad5mDya5hHfrppcyWByinZq
         Tdr8+/XFuoSzn9gqR9msSt/y4LV3NbvRxhkEvBMmBmVh0nxee1rmWW0A3KIXeJxHPwrI
         bw0Ekg4Kmpz+N51bdOzZ7fYK+WcSAU3TgkiZ9tYYOmRI373nTnzP9VTNRR3HD0e+ZIIC
         jj2phM+S8mpheHMTyL1u1iyLkmRmZrD45qSRacNHX0C3wVdiqRc8YlvGpvxf0i6TZFT1
         DKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515890; x=1687107890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppRfvpEzKntx7DzSp5zW1I4Fc3JFfOMmEmtjxYhv2RE=;
        b=SpkuDYomhr39w+q7fZvS2ECEagZXTzyWzxWevttZUUFBYfL4/Uy0jMnNGL3c2mabHy
         zRTMpO9O6OH1MV6VMWjuv1D3LTpMprKqCDJJLVstAIU3Tq/RR9haVml0TgwN23Ffs/TX
         ItJGeh6qnCJHNu3BNPwkP9r/cbKBaxAvZfS8kxC1fAf/w9a+PaOqUeTLfZWS15jOqJgt
         evbme9ueQWzMxhyqJV1POPJKoSPleEG3RdJENcgMQ5P7G80SuAjXj86FCGtHoE410DXg
         /jcLbtM4HkWKz+Es0Dxo3W1BoOCCSJ0V8Mt+/UocXlOnhth5aihVeCm3obkBsihovrhK
         p9iA==
X-Gm-Message-State: AC+VfDzHvT5ZVnAVr7x6wWCH+uOCElb67F1w4S90Z1Lch93CCQZr8QZ4
	dewxtqzVVydZUP0+TbPt7xveCw==
X-Google-Smtp-Source: ACHHUZ4SdkxsWCzkHrPg/XhlGeB08jcKZiy+JJ8XYc5WTrd/LY7hhcZRCk5LoKthWwvQR4nh+Dy3Ww==
X-Received: by 2002:a19:f002:0:b0:4ea:fa07:1182 with SMTP id p2-20020a19f002000000b004eafa071182mr945077lfc.14.1684515889909;
        Fri, 19 May 2023 10:04:49 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a6-20020a19f806000000b004f38260f196sm654478lff.218.2023.05.19.10.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:04:49 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 19 May 2023 19:04:31 +0200
Subject: [PATCH v4 10/12] iommu/arm-smmu-qcom: Sort the compatible list
 alphabetically
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v4-10-68e7e25d70e1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684515870; l=965;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9/++xt/utIOxLufVN9PZF2yMVmu78Xo8NRamuKy95SI=;
 b=IFT0R7GXWdOBF7o2llf/YR7q+v6c4wSJLLLXlQkT78L1b6w2wlyTtawVoAyaEvOvNO+cpgEI2
 iipx+WNKFSmADcnC6AgQgDR56IjlTcRn+t3vjytXV8Fupw7JEsRLp4i
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

It got broken at some point, fix it up.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ae09c627bc84..f945ae3d9d06 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -251,10 +251,10 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sc8280xp-mdss" },
-	{ .compatible = "qcom,sm8150-mdss" },
-	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm8150-mdss" },
+	{ .compatible = "qcom,sm8250-mdss" },
 	{ }
 };
 

-- 
2.40.1

