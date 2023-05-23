Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3825393
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 07:47:05 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f3b9755961so3073392e87.0
        for <iommu@lists.linux.dev>; Tue, 23 May 2023 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684828023; x=1687420023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfoMnvnUW9JxHFNrsE+j3PaFEyoaLfNhlabOCKS4wNc=;
        b=oiXMqvz4tlkgl7WCYmeHCUOXABJyn4rczzgyNxIeNDQWawiDhlD42soCU3JzgI6t64
         eGsSN8nuqnay0HDQV6QJXr1JiWwUMCBT0ia4ak/jO3+psA/JLRcjsUy1U1BhGHMFhCmd
         7sa4k5LMTGBLkhIf1Js1aZow8JbI/84gWD5mlxu3XnK5WXothsmOH0fr11itkhQkAmLq
         nLrnedXbeU2ySwu/XAeKPqG2fGo6rVlTIRk9uJR45tyFsejPhStMsol/Mch/+cAoBByQ
         ZHsExKjW/Brn8JamgY1S4cjncz6tx4a/a65X60qHHM/kWW3YL017mmt+S3EizFECxfS5
         VoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828023; x=1687420023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfoMnvnUW9JxHFNrsE+j3PaFEyoaLfNhlabOCKS4wNc=;
        b=aqynbGOorBjBZVdZDvxwuzpglWv64oM+QqsBTzyfXB3KbBcc72R0RHogvqR2/0q3fC
         1mLjhsVZL1EjrXQVqGqhEooji1sFNAMRyUmLWM1iUD6Tu3wSf8L1SpH9h/b0kGONbztn
         JfpmG0fV9eBtOXjQYw0mYjJqoZ0xoT6+umNi0udY29m3hUa+42eirrTxg6xlIdrnN3UF
         GWNSvoyIZQbGa6lz8qEFv+6kcKHM+Q2anu6YoCOhfPFGiOP+/aFH7eo1JDFsGXxcdHWL
         aYAjpA5VjycQ2ChwK/RKZG9cc1TNhJJZGYtWReDL8QLrYebdbtEtufr4gHLNy9dMvlu4
         xG+g==
X-Gm-Message-State: AC+VfDx5lHD/1JIHz4usAsvxA8W4FFtGnr0ClvXm/odAYzg4eGWmvrs2
	pVssb5jIKC2tuGTKPeZiYsKxug==
X-Google-Smtp-Source: ACHHUZ7vQpCMD8z+tXopWFPnkqXpWLOyK1g9oM8UkYcSzlJeaWh7JT+2ofWynI9x1gg11eZm6ERCiw==
X-Received: by 2002:ac2:4e4c:0:b0:4f3:aa29:b663 with SMTP id f12-20020ac24e4c000000b004f3aa29b663mr4324951lfr.35.1684828023618;
        Tue, 23 May 2023 00:47:03 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id t9-20020ac25489000000b004eb0c51780bsm1257070lfk.29.2023.05.23.00.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:47:03 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 23 May 2023 09:46:22 +0200
Subject: [PATCH v5 11/12] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v5-11-998b4d2f7dd1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684828003; l=919;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=U7GrazUMOESVisMUp1R2X/i2E38+ra43yVyDZTsdMko=;
 b=694+VJyXCZBUKckTCLQ5CsRJG+wJkbWuXCzZ6sGhBmhOWdEFH75k2SBgXqgbcBhvOwywQuLyK
 PilQQ3EaWw+A7wV3sA9YtDy/qbCmXblyVWuNqJmC+1aZwMqKT08ZrDA
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
index 3800ab478216..cc574928c707 100644
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

