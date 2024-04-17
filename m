Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275B3D0A3
	for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384430; cv=none; b=DDtVLrVjcYbMYN6ekalbqsC2mPut6C16nqPaBE7aG8KXBzT8aYUproc+Q3oYqnP6/Jt8gC+7vequopkTHQJ5mM5H3bjxj0LDCBXCwRCc9gjoQpuxdv8TJrlReY1pvv2ma0miQZyxFZDfMA64NyluLYtwmNG53MS3eOzsBsTwu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384430; c=relaxed/simple;
	bh=3mbMg2ivwWNTK3xsS4wYTiDYZ0KlaU3IbtBCWSlfYEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SaEZoRehCpyMyMz8+wlRvTx87hiCaXGs7DMfl6+FHDosoWO9h33KKTStOFVZlUfeuOplZnNA2yhFy9kEjTVvRIOkucWDX08pnIkU56BG+5uzM/zthz4JTzPb0iHrZP+DrlIJpnRFsp2tR7VodQzIPsu/ldUYQpMwHi9GGc2dvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qk4FiiaE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qk4FiiaE"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5568bef315so45660666b.1
        for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384428; x=1713989228; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9Kjw76bMPVOsbjzjb0d38GfEfCd3+VQVKqEmN50hoY=;
        b=qk4FiiaEU/fZmTK94b7hNCDRtEuBJBOmLDGyxEc5guT1gsz5SdDwvIudTfF9Q487vW
         +baWp1aWuhwhl8a+MGzt6ToC9zofP8PkSmY8AEqqAzyqCDjehYJKOAlpp9tGLlPfyGII
         s4gz3/WOhvdkocyBoK4LRSQPLYSgJhtTIpqMSaSNPtcDethmc/JdJqj80NiC5zWsN8PY
         QfBE1BxHz/dgsgp8V4DtWElZ8zMviJLa9Gvpm8cSc/Gd6l/T/QUUiaaQy62JRdp74Lel
         fXeGVX0bYjvyDlXeYbOvmc1lroqIFlrcYKONWvlscAOe9I+4Zfj7SYsSW9C2Ycp5Tu1X
         6uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384428; x=1713989228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9Kjw76bMPVOsbjzjb0d38GfEfCd3+VQVKqEmN50hoY=;
        b=DtfX+vtBM/8qNXNtOcfOIVoHl1OjWRtnFBCj++GC3LL1MHYQ6TFHlWXZC36jBQM1FJ
         c+LWYnyOslokxanXPEkPQnysgyIJubgEkEY5hJhsG6lVe0BXZmr8UFteTboGKPbnz5T7
         c4oWkbVmS7Itb4TDbz/ZGdbuu85F3fnLJu3vFJuPK2wjpH+dJTuk0KOgrKis5aDY2CLd
         XcNI9RK0l6ORmwV13Vi+ko/vTjV8LZXJlIasLouSd06XwVkgtz6PeE9yp4pjaHvr6DnV
         b/xSKRMEljNcEocvkQwjfVklCmi1BkVFvyPF6fYUyrq5KcxX1RsEk5twqPHKMYVPYE9F
         UeUA==
X-Gm-Message-State: AOJu0YwlkBVwyvqQDxL7Fd/PrriDYDytusdfKW4X8VlnRXG+aHj8PccO
	YEBlHoRJsqnFRMZ+9U2DLRtjvIvVoVpa2m/KTfAjJWY7oEs5mAmR2Q/1b6Sj14w=
X-Google-Smtp-Source: AGHT+IF6lNe7FJxy2kYSpHWMMUEGZhhuFhiDyuheXUBZhHBVpx+1Ckk0HCLalQKp09AtJ/CUpiDCaw==
X-Received: by 2002:a17:906:c812:b0:a52:a25:2077 with SMTP id cx18-20020a170906c81200b00a520a252077mr148120ejb.14.1713384427698;
        Wed, 17 Apr 2024 13:07:07 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b00a524e3f2f9esm6128057ejd.98.2024.04.17.13.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:07:06 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 17 Apr 2024 22:07:00 +0200
Subject: [PATCH 2/2] iommu/qcom: Always consume all clocks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-topic-qcom_iommu-v1-2-fabe55b3b7b3@linaro.org>
References: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
In-Reply-To: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713384421; l=3042;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3mbMg2ivwWNTK3xsS4wYTiDYZ0KlaU3IbtBCWSlfYEw=;
 b=vMKT1TBfwDN6a7yS7Xa9gR7+R8/09NZEgAT7cVeFCam7yhXFkvI+O3+YWOJ91TNYJjTsArd92
 T3eW7mR8qIWCZp6oPYrDTvlNFLA5FPFMjMh/2H2oX1NZ647vny1akj5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some platforms provide more clocks than others, we already have the DT
schema to ensure sanity here plus these clocks simply need to be on.

Use devm_clk_bulk_get_all and get rid of some boilerplate.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 38 +++++++--------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 3dca9293c509..ace69030a422 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -34,13 +34,6 @@
 
 #define SMMU_INTR_SEL_NS     0x2000
 
-enum qcom_iommu_clk {
-	CLK_IFACE,
-	CLK_BUS,
-	CLK_TBU,
-	CLK_NUM,
-};
-
 struct qcom_iommu_ctx {
 	struct device		*dev;
 	void __iomem		*base;
@@ -54,7 +47,8 @@ struct qcom_iommu_dev {
 	/* IOMMU core code handle */
 	struct iommu_device	 iommu;
 	struct device		*dev;
-	struct clk_bulk_data clks[CLK_NUM];
+	struct clk_bulk_data	*clks;
+	int			num_clks;
 	void __iomem		*local_base;
 	u32			 sec_id;
 	u8			 max_asid;
@@ -781,7 +775,6 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	struct qcom_iommu_dev *qcom_iommu;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	struct clk *clk;
 	int ret, max_asid = 0;
 
 	/* find the max asid (which is 1:1 to ctx bank idx), so we know how
@@ -804,26 +797,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 			return PTR_ERR(qcom_iommu->local_base);
 	}
 
-	clk = devm_clk_get(dev, "iface");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get iface clock\n");
-		return PTR_ERR(clk);
-	}
-	qcom_iommu->clks[CLK_IFACE].clk = clk;
-
-	clk = devm_clk_get(dev, "bus");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get bus clock\n");
-		return PTR_ERR(clk);
-	}
-	qcom_iommu->clks[CLK_BUS].clk = clk;
+	ret = devm_clk_bulk_get_all(dev, &qcom_iommu->clks);
+	if (ret <= 0)
+		return dev_err_probe(dev, ret, "Couldn't get clocks\n");
 
-	clk = devm_clk_get_optional(dev, "tbu");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get tbu clock\n");
-		return PTR_ERR(clk);
-	}
-	qcom_iommu->clks[CLK_TBU].clk = clk;
+	qcom_iommu->num_clks = ret;
 
 	if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
 				 &qcom_iommu->sec_id)) {
@@ -891,7 +869,7 @@ static int __maybe_unused qcom_iommu_resume(struct device *dev)
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_bulk_prepare_enable(CLK_NUM, qcom_iommu->clks);
+	ret = clk_bulk_prepare_enable(qcom_iommu->num_clks, qcom_iommu->clks);
 	if (ret < 0)
 		return ret;
 
@@ -905,7 +883,7 @@ static int __maybe_unused qcom_iommu_suspend(struct device *dev)
 {
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
 
-	clk_bulk_disable_unprepare(CLK_NUM, qcom_iommu->clks);
+	clk_bulk_disable_unprepare(qcom_iommu->num_clks, qcom_iommu->clks);
 
 	return 0;
 }

-- 
2.44.0

