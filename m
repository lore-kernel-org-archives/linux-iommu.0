Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E2E573
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 21:41:00 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ac8c0fbb16so10644571fa.2
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683322858; x=1685914858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uz91t5CPsz6QMWtRIYuzaeaGaQUSJIZo7OKNOwA96Nw=;
        b=weVZ9XSheAWAx86sFBUBaYDmWZDr7XwLsgPb3yY85630NbN7B8LXtIAJRu3F5iM6GL
         0AEoE3Qs3D6S5p8YKFJU6lkE9fIXEdatXjvE5rH8O3PUELYG8aFIsnHfBK/M7FX8GfgG
         7qPZ1ilOLxKeVBim/hcYhMZl+nwYrEzX2bvwBCrBBtt7hcLouotE+AbEbQD2spbGxQNX
         yF9eMD/2i5UTR7QmyYoF2ZOfLq2WicVVIQCK+WJScvGcBX0Kcpu4THOk9NRqy2ledc2N
         9wfU0CaGNNkg1TTB7E58pUl+12MMbjIRzYXlvH9HG+1Gyl+DAqsG/9vjxeCvUnaMxB+M
         2hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322858; x=1685914858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uz91t5CPsz6QMWtRIYuzaeaGaQUSJIZo7OKNOwA96Nw=;
        b=g6KNYAVPlFdfsfhiSnd6Or6PehHFApeSUB5qp0Mqur6Kc9tivXRi+0zz17tciolXSc
         jG8xFKwTrTHupzESs6rcJfPIfiIJFY+1jGRZ1rxhmpWRi3+kBuOyx9E0vmqyLrTFR64A
         yb6puR1C06O3lFfCL8zScF2NLH0y3XLcFKa4y9mcnlO45ebd1crCVMARQfBwepfx0HUa
         8/hFOeLHekfiORLoDoKIW0rWIIYvXOsqTJsZTIQZpfcSfMMFA4PZjrMfWVuX54ndstTF
         vPkxuFxwI0EGuNpuiSR2a9/aqCzQI6fEgnFdUSUCKPW1XVRi2SK1Ovb2v241kL4vh27D
         9+nA==
X-Gm-Message-State: AC+VfDxKFBT5DLkiF13aROlzcLI/jaQ+NyIw0BhNhYnZ5tPeikW4sAm7
	eK1sxKkLbrcxofE2SaFSPSW2AgEHSwFF4Rehhzg=
X-Google-Smtp-Source: ACHHUZ685M+oS4sLNbr0o8CrcgD7T/uhRvfZPsp8jTmgRv/JWy/90Mt1IQ5Ya8hAWscihJimv/qvUw==
X-Received: by 2002:a2e:9290:0:b0:2a9:f94f:d304 with SMTP id d16-20020a2e9290000000b002a9f94fd304mr850372ljh.19.1683322858251;
        Fri, 05 May 2023 14:40:58 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e720c000000b002a776dbc277sm126453ljc.124.2023.05.05.14.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:40:57 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 05 May 2023 23:40:35 +0200
Subject: [PATCH v3 09/12] drm/msm: mdss: Add SM6375 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v3-9-9837d6b3516d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683322839; l=1022;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Nh6zuYJI8gb14gxje6MmS/hbQSaIA3Eeoi75EfztoC0=;
 b=O0R9IBwQx83wZaZ+iCkksyDGMEr66jfhQEuaLMyd93w2BZzeP2bgaTdASpHY1oirCrmn/JcOn
 3G+pjZFuHTiCBujAXjqW5hc8QDl1jLHFkxGYeQ8CzvHk3Ju4aJllTVX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add support for MDSS on SM6375.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 4e3a5f0c303c..05648c910c68 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -580,6 +580,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sc8280xp-mdss", .data = &sc8280xp_data },
 	{ .compatible = "qcom,sm6115-mdss", .data = &sm6115_data },
 	{ .compatible = "qcom,sm6350-mdss", .data = &sm6350_data },
+	{ .compatible = "qcom,sm6375-mdss", .data = &sm6350_data },
 	{ .compatible = "qcom,sm8150-mdss", .data = &sm8150_data },
 	{ .compatible = "qcom,sm8250-mdss", .data = &sm8250_data },
 	{ .compatible = "qcom,sm8350-mdss", .data = &sm8250_data },

-- 
2.40.1

