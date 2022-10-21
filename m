Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0313FFB
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 16:55:50 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id m23so4561972lji.2
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT9p+O8jS1617W9ayV/G2VKwq2HucMY9DBAQPNerHK4=;
        b=rJ0DwSGCkEIE25pd95phrfcMNfbybXvcvh4bDPLhBClsVFB1kJpdbY9ZXdeqI79FaF
         Mji8bX6GF893adMySxKCv20TEpdIH+G1UbtWU48em/BNNZ/GZAZoT5QG72X6+zIDo8lY
         sdc4jWx06elCJfG/o6UMB4Dyk+1+5i2QTvWx4L4j58QEDHZU3ExKddPnXhoJigwHkSpK
         wPSVgBpj8Dp2pZutXokdwh7d5VCOoiSWCOjIZmUR4pnfKTkI0JOACnpeuF/frwI1vveG
         Po6ZGlFKoSKU7CMLJgqZTMjUawtVPzcgMD4lBOr5G9gWBpZUjrVZqNQWwlRaxlWyVssW
         PRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT9p+O8jS1617W9ayV/G2VKwq2HucMY9DBAQPNerHK4=;
        b=yMsGeJWrCTTBKysn7HxIwgEs3tFDri1Xf5EzX1uuGCzq+hCdbgqw9w33m+Bbcv/qtt
         yIHIyitY7yZfy8kaPPjBJJI3ba8LfIs0lQ2hJlU/0s5Uhmgz0CJi8rncIGWPL/Ed4ZEa
         XRl2DoeMXpZHckSXr+7QssqxPwZkTSE8tcXHy0GNrbc2d8F7lI/JXmXGIiQA6u/T7/eN
         hwL6t3bv+1QukVYJswNOdmFPEEQER2UzJ+blwMJRnMXbGSUO6qoZKEwDwjw01GoPua+E
         /YO5rqkHQemY4tmZsTuuWiEczjO6a3iaEar4XeyIOV2Auh1x6uEgu3X9ZohhmBtocasF
         /2CQ==
X-Gm-Message-State: ACrzQf0K4gtX1n87FlcOE22jscopmCw4sZ1lzkFV7wI7rktYGM7bcjpL
	HdFtyEWWzLapvDXRSMsFiF5G5g==
X-Google-Smtp-Source: AMsMyM5DmLJ5rXTRgNdC7K58SnCb2aZlbYqY0kpaUJgU2Dzp2Oflwl8kkPrI4UQ6QWTOn0THOh0ktg==
X-Received: by 2002:a2e:549:0:b0:26d:ff5f:53c1 with SMTP id 70-20020a2e0549000000b0026dff5f53c1mr7415424ljf.450.1666371349092;
        Fri, 21 Oct 2022 09:55:49 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b004946e72711bsm3218532lfr.76.2022.10.21.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:55:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [RFC PATCH 9/9] iommu/arm-smmu-qcom: Add generic qcom,smmu-500 match entry
Date: Fri, 21 Oct 2022 19:55:34 +0300
Message-Id: <20221021165534.2334329-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org>
References: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic qcom,smmu-500 compatibility string. Newer platforms should
use this generic entry rather than declaring per-SoC entries.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 9abc40c00f3e..3be81338a25b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -493,6 +493,10 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 	.cfg = &qcom_smmu_impl0_cfg,
 };
 
+/*
+ * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
+ * special handling and can not be covered by the qcom,smmu-500 entry.
+ */
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
 	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
@@ -511,6 +515,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ }
 };
 
-- 
2.35.1

