Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1631137B7D
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:44:28 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso7516119e87.3
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055467; x=1688647467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71R2q19ZXsGZnOPocAOTBJ3+IZ1FZhz4Wl6PP95R9qE=;
        b=I8bal3u2MbL5N2wtAHwu70IeyshjqDHEG6e07z9uY66vw9fstpsDTVU/yXP/+3pU7s
         wO0H6Q+rw12fnt8EaLmOJiC95oWyxw3WB3DdPnoaCxwZWA/80UushCnOXdZX+VqSxYXX
         OuysNYXfN3SP2qfmickHoD56ST0CxDc9VFuq9IKwvkixzpZgdJPU+BINxK1jTrYsGHiM
         hPl4koRIiwslemS3vQy0NDzvKEPYK8bkv5BPj10GWB/rIsFl2a7RvoJvgrBUTmqebxHI
         NL413CB37yFJbklwP95xy+Jl2Zj3FHnlS+YYv2UI62cirRTab1rRUArQdwQo1+AeE8bW
         Ntjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055467; x=1688647467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71R2q19ZXsGZnOPocAOTBJ3+IZ1FZhz4Wl6PP95R9qE=;
        b=lrauuGpLanwOnnQthI+6ljmGgfScz872LN7IJ+OGdzxHUUTCrsWFcn0Tnxp+JHgFp0
         7zn0LBxMXhHXZNBpOqKyRDmxvQBT77Nazs0OpweOZBWjQcn+rsgJ7J54S2QMnFZMgwfu
         OXSNu0GOmV2yPgFwbdyZtINqpcApTwFuNJy5lgv5bKTPse/pIjf9TdilKQaAKGyPH6N2
         eSwPK6eB4N83IaUjnkuE+9Q7hodgooykvxndCtIBuX9w1b5whE5emEadhyWfQeUtEZgt
         99ireDNWXh+WETluFmwgQBbFvfAN05Fd8Fp3Ygaf4RLQD2kTjpJqW4+HnjwxKs5wwFT/
         t7LA==
X-Gm-Message-State: AC+VfDxhH2PsTaYdYwYBQ3168DeiEnBnAJhXZSAnJsxo7CbF4G/teQCH
	tRq3xJEAhQcLaeVbvnjHQWAnsw==
X-Google-Smtp-Source: ACHHUZ4c+yMvlAIdZkCiNRfIWyTpQZD41YEWXcpVJkwRTIOU6+57/WT/SEZI/YDq4XG3X0FHRp1KAw==
X-Received: by 2002:a2e:86c8:0:b0:2b1:bd11:a71a with SMTP id n8-20020a2e86c8000000b002b1bd11a71amr1161537ljj.17.1686055467141;
        Tue, 06 Jun 2023 05:44:27 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:26 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Jun 2023 14:44:03 +0200
Subject: [PATCH v6 12/12] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-12-dee6a882571b@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
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
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=1014;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CPO6pRkqp9OH9BXcQBO5PamnhFLC+q+SwQwF41wCtLY=;
 b=EpXSpLvNfkNwN2LETbMboB402kF8n6aEw8/3XRGdYE/p0jqbAcEhn9jwTJy9yIh5JXIvC2O2n
 Qgs41nBrZ/NBuK4rPGepMA17UT/akizQC5SR5/YqACBatIfFVMeJDPK
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
index cc574928c707..bdeb587552c0 100644
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

