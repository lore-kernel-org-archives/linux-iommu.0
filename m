Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439137B78
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:44:20 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f6148f9679so5387182e87.3
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055458; x=1688647458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=qNeCawTHroCgl5fcdtDUaxX0eIF9Ix5dn++5hN82QtOf2y1D6NARDHgCS4YAMwVEyt
         cXMjmQJJdO0FpxZoVSrFuYnupsUNWa00Phx6h/n71YXz28DLQoX8XnZNdBh9q6zer+uI
         RmtEHM/KwaGjQXeNDqiwQze61NsMdcsZOi2IyB97j9GDivnFFDYbKHda7QUBgWIi9nvo
         KZYKnUNfNrjxm2HOq6NIGDLQEjKe/HIYkyU1Ld1sl1cn7flPbRIoQiqrdB4+mKD4dZZq
         KY4rStX/hCNUV9KEXxYXh8IdFbWMRplsoFRSO5kszeLVO2KKWY7/m4krspqXllErzpTF
         8ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055458; x=1688647458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=W0bn4AxoOCeLEnsWQ+lb646AlNDV2EOp0CIwVBDcwHOx+tpH0ic/CV7TZmKRhuAeuA
         mdQUQdftzdM2cVcpu/195F/oZpreXB7zhDYfiXGJg1IoSWEVaDgORolQujH/gyAWyumT
         xTKnns+LHJ/0/I5HMzG8nrRvoSQRGjIiSbF10FfSbrt/DN7n4KusEdy3MO4PuK7ioZgg
         xGpuZVxgqMgNh25a9S8SIusmgZTgk6DvDgnxFNPvZmpOBEbz2F/OVtCpOjGZnV9xmyTR
         Q5gxV1k+1I6F+MiV0a2KA+WcWuAQaUSwwK/qp/WWzmd7VIsJOFjyX603WCWYITb2Ltzi
         3/ZA==
X-Gm-Message-State: AC+VfDwGTPmnfoPnCs3NllWYMNIf41Xvb5xVXVgsaKE45EzCOyyjpiXa
	Hqx/HSe9/NzYZXEmdbpxjowHrg==
X-Google-Smtp-Source: ACHHUZ72I/+mf+dvF/26dRGOmhr3s9AFAVcw4zjBgnlCUcVuS7LeBNmKYkK9ZWeWqnaLe66LYSA6Cg==
X-Received: by 2002:a19:f806:0:b0:4ee:dafa:cb00 with SMTP id a6-20020a19f806000000b004eedafacb00mr962101lff.60.1686055458477;
        Tue, 06 Jun 2023 05:44:18 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:18 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Jun 2023 14:43:58 +0200
Subject: [PATCH v6 07/12] drm/msm: mdss: Add SM6350 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-7-dee6a882571b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=1447;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0D7OZJvsI1VqBAldTbVtRFbwuC+jJW8mAUrMe9Ykcbs=;
 b=//U5sESzjAZLdCHYZ7ycan2Fus4ZSVv4WamSuLI1t4OMIDaUAydO06CalgWdDLxiEiIJLw4g7
 vol9S9AHLtNAi9CDM5pCBm7aNTBzNvC2KfEyDdpgGh2KQkJ3GUhh/aq
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

