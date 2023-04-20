Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B92F26
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 22:31:36 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4edc114c716so962496e87.1
        for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029895; x=1684621895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzW0EyxEnLgGTr4kvlR1jpwpJYgRpLH7LzUuysQn5LU=;
        b=Ma+NvWDMWecNjRhGTfS//RRzl2qjKfBRdeBNrSRoygMzT+qFjy6e5EiGGczTSb5dJQ
         QUpRkTZYWPqvbYclf4czjUwFg8Jc+x1ddtNq2+acsgMYXfHTBp2An6xaef3DGNB47MFA
         RItS3E7jplMvc58KP3pYAAOfwyBvOtLZjWlFqcMuj/Ux2o9WmBOgjiGs7xsE4Ei+Dk6U
         TNCxGR6mx3jphy5h9te+oQcrunggUVSUZJKM2n7ODWlAh8AIAZGwK6dO7T+zaciZ5iMB
         hTgdZvo1iVvmavJ6rfpl0cxgkICr9PYdMBmHUAXnkQY9/os5RPiZxbZIFmxdEN+nwDHz
         QZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029895; x=1684621895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzW0EyxEnLgGTr4kvlR1jpwpJYgRpLH7LzUuysQn5LU=;
        b=HFz8XqSoJPUiN0KvrqV1BcrPd0tg9xjm5l/gh1VdlfogFB5ttIbaPFyt8ucPUoOW/Q
         X3RpO04tvI/bf6N92OW/37HWINby5seQ+70XUasvpBAE0VvBQg+ySZmcQVgVApDP5srx
         zdGPifhMPClN4nrRNCVS4OqhxBbN9Fsg9+JIwLydQ9CVoBwb4gSzdHsObqHSSgvMziZh
         HXnZWlyqQT6auzN8egfLeYhWk41FfMmICs5ivHQog+2DNXEuZOx5ACgKN4YEDBZFcIo9
         QjwgIhoJ7ZTGzWO3+zs5NejUuSeo9T2GW3xva3ejbEgg6PMJbilJiGNmeOUXe/2H8WM5
         fqDA==
X-Gm-Message-State: AAQBX9fVTEdKaqy1bO8CaX1VXtIkmhdn+uR0xpo11xuGsFyDxxlAwMN+
	4WFmnR2lbWaovFAm6LnzXLxKjw==
X-Google-Smtp-Source: AKy350YZCctAZ8o+9QesV16tsV96ubVi/ClzN4jAIauRdQ6iFbOb2/iQX4NOlAez5gusI19gaCZ1/A==
X-Received: by 2002:a05:6512:3c9:b0:4ec:857d:9c94 with SMTP id w9-20020a05651203c900b004ec857d9c94mr705379lfp.15.1682029894970;
        Thu, 20 Apr 2023 15:31:34 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w8-20020ac25d48000000b004eedb66983csm324256lfd.273.2023.04.20.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:31:34 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 21 Apr 2023 00:31:17 +0200
Subject: [PATCH v2 08/13] drm/msm: mdss: Add SM6350 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v2-8-5def73f50980@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682029879; l=1325;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YJnhuotbycPo0Lxuk2IRtdOzqse8Z1bIU0CErB+UTrw=;
 b=d5k6WYZUd1XbcPs5nVQlXqkJtEycVrXqJI6R1+zGm9QHV1JuWYVoLyI0UBWtYcyZeJB+Ge8Enm6E
 pWe8cxtkBAoI/eYMad7nfABBlIGkHpu+c6+M/fst+9zWU45spktu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add support for MDSS on SM6350.

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
2.40.0

