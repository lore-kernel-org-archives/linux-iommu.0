Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA6125B1
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 17:04:46 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f1411e8111so3885175e87.1
        for <iommu@lists.linux.dev>; Fri, 19 May 2023 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684515885; x=1687107885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=DhEMrgtGP0vgeRzORAYwcS1LHk1+VVzq0wdk3vDvU+9UDl+x6H46N6nrKd3UqXHpau
         0xbCXfjM9Hetqz5uW9BOLOiA6QMPBMgs0670gSz2rK5Q+gjh925J+MJVXi0Xzn3FJ2Kk
         gozzArqqZP4rt69aoC4NREHecjlPe6+Bv+vJLJQYPF9sFmHLoqJgHTaACiCJacJ/lToP
         zFYh96H4EQqDjJ7mhYv8D7Uhm+7XpuRdDjPoZfG1e0IvNwOHg18MnqMzzG44U7dHj+el
         +IckTWEeCDAqnbm3YisSz0joVdMZpW3GyfshRWctsuIf4wXxc8dgVAeGSl27Ay7SIsni
         k7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515885; x=1687107885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfCYGehx8jvC84gEQScBvdgxh6j6XnKzcug3iY2u1OA=;
        b=V6Nus0Vcl1WIprzRe4o4OaBuJlpJAGka0zoVxymclbs242Dbm2rfSFN13m1cv0uGBG
         rIjNH54MTFT5B5Tkq56OC4DnQibs2P6L7RId1rqFPTK/GQmYHs7mr4s49x5GUUzqH7GD
         dIIe3/AgXzRzYUqbRwK6DMLMFlorWI9WbbMGJO8u/ojI2ThJ6g/1+T2A0/BauzFse3UC
         jUXzYkcBQX2Crj+hOvkupgpYg5Gzuxj7OBP/qL8F82+I5+c8GmVh08T8SLSPom1g6kUo
         WfMI7J0iDgx9T+uqINnAh4ycrj1xvIW8GJrdUz+I6w9efm3Vtgs6rizDnPkUCytRO8sC
         IUbg==
X-Gm-Message-State: AC+VfDxiLY2/jIEgCwtQi/Oero2tYnnubH8Qu9I87M54m7S/f50jyvia
	6npGfDHq617/MBLtcOVwZmIqig==
X-Google-Smtp-Source: ACHHUZ55A1QFwepkx5qw9LXs5vkNRGGwEd+BWIfhSzDIUBNAeDNPTRGr1uq3wETefabj2H9yBtRK2g==
X-Received: by 2002:ac2:5478:0:b0:4d6:d0a0:8313 with SMTP id e24-20020ac25478000000b004d6d0a08313mr958151lfn.10.1684515884856;
        Fri, 19 May 2023 10:04:44 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a6-20020a19f806000000b004f38260f196sm654478lff.218.2023.05.19.10.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:04:44 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 19 May 2023 19:04:28 +0200
Subject: [PATCH v4 07/12] drm/msm: mdss: Add SM6350 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v4-7-68e7e25d70e1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684515870; l=1447;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0D7OZJvsI1VqBAldTbVtRFbwuC+jJW8mAUrMe9Ykcbs=;
 b=Edt5Xp7SRZ1iyE6ATl12eLjiI68MOV5UFLYk5uc9AM+XQhlc49NQrmgGc+pauw70ZN7LE9jmC
 sInJIunnVu4D75xYNDmff5gnzX1l3X69wNQARv0fp25ztkR8GTmD7Nt
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

