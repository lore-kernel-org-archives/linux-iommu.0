Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68C37B7E
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:44:24 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f6148f9679so5387266e87.3
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055463; x=1688647463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw6zfBHO0opEqODFwIHcb35ENxPJxB7I1/UM0FjZOR4=;
        b=XjD/DjeZ/zriufMZNJkno4oajcS2wFCxueANYtfQge+aQ4zJ6RTqg/5Dk9YqPm3dzC
         yohb/+gOvxKAmFhwQbC12W1bhZzDndCnS9QrJqu025jgOBEbjf/4Y56yUaKtm8XBQ0vh
         zsLazWcGSvFwzd5FE7/eCZh4LkiJku0pB7/HpJ9rWrccgiQ9XWBkG9HCLxoX3+GRN8jC
         46jGJ/s+yYObblgQUD5CadL8ubHP2aImZLNP2oUqHY87VHfB1tKX6lkBsB8wv4SAMABi
         ew77HJsQx0Ak2TWgjl6sV8eK01tAqVXBdYT1b9qybp6HQyTtYCx60uKYLltSDOiZE3cU
         Xj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055463; x=1688647463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw6zfBHO0opEqODFwIHcb35ENxPJxB7I1/UM0FjZOR4=;
        b=fvComZ0g28ux0A3qtwCoQ/1qlJV92JqCLdGaxEsth2aX0z5a1weu+yzzpQwR6Aabq9
         kwNXfT87JrzXgLjsbU4xB4Npc6I+cWzGogdW5Y8/TM80eoVCsOCFp4TUuUosXhQoBrYs
         B5qMhpRNOXrdnuhj/dh71K6wexdFEZItfghZfholxA73AGibEX+oOW7sv8Zfroh3qS5f
         GjsTW4vh+4G3+IaSu79v1Iqy+d8oXgItzuT0/n8TdyNPw6qkawN/rgK+HfpnUHjo8WqC
         W14xX90K8NniD5VBBLv/haO5Js1U3fDvqiqTnTEhLCG7N7N7jyJrYjBHJLUxOIO0zK3U
         pd4w==
X-Gm-Message-State: AC+VfDydhdUGlI6Tz/q8Pdgwc6Ok6a+hT1eOZaXezMk6V1vpe2Lf9HT2
	j6z7F0Oi5sAo6V0kvCREMMEHTA==
X-Google-Smtp-Source: ACHHUZ4JPdXVw4ik2GSg//oq+bn2TOmcvhfR+0lRQTmoDO7EADSvXTuoiqFFBHki+vQujl0wbMfFYw==
X-Received: by 2002:ac2:5314:0:b0:4f6:278b:713e with SMTP id c20-20020ac25314000000b004f6278b713emr793308lfh.42.1686055463610;
        Tue, 06 Jun 2023 05:44:23 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:23 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Jun 2023 14:44:01 +0200
Subject: [PATCH v6 10/12] iommu/arm-smmu-qcom: Sort the compatible list
 alphabetically
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-10-dee6a882571b@linaro.org>
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
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=1026;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Rc5Y2oI69X8xvGgWy74AqbUqZBcFJifSW/Zzw/OwQv0=;
 b=hKN4Zx/iFcuu7jgYtNyXm0RjgfAMa4iciB6rumy4y0uHYWEzi1kXRnJRbmxp0K/sRyxp0Md5f
 h/s1XX72W3ODTC4C3mimNm9lfOBhDT8PC2XGICQRnRP6A8xuQ1loAWs
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

It got broken at some point, fix it up.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index c71afda79d64..3800ab478216 100644
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

