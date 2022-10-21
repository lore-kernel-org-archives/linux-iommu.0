Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A246102
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 16:55:48 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id m23so4561841lji.2
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxwJcXo520aplQLccqDc/GixqgYRIkInc92XxQN/vkQ=;
        b=KVx9M8kD4AZU77/op6ENn+npcgnimQUGJQdI0dnC/QPizss3/bUXS+1+eOpsvoabCn
         n9eLO5ip7MaId/Z3L4sMuMaeE8CY7CWQeCm4Pws2xmxQcxGmySWg5MDuSu/zObm+t/Xt
         4+n89H4eNQs0Yak8+hKrzl6RwZ5VhRoVD2LgBqyEHa+ExWuCHxD8xucqrquKLgCyrl4Y
         hWoTAYrJ4LorBwiXyWiWq2CDnsyivtTcN9wFWYg/MqoGCLfxVk8AFK6FOd2DFRgjG795
         eX4V97/xE6JbtLNfUGU0XPBu/D1LNUd+Y4JTIiCA34u5caYndLz37mACIwlQ4PRlKhQe
         vUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxwJcXo520aplQLccqDc/GixqgYRIkInc92XxQN/vkQ=;
        b=1Z76UO1ydNigjxDEjcjNuXo7LVcZNElbijhMZEP4NzCb6LHHh9FciMciX6ffFXvgqU
         t6+8BITduvmzHpoBwa5gRLFS8jxLdSjj3MxvHJlQ6IsYxdBw3yWP/YG7Oxf3GUXMiSTW
         0JCTT7oSnJDoodrLnhq15PbZTU8W0+gsTnDDXBYWM+TjztSx0/EL/3FcbNVjGmu2RMJ1
         BqmYAriLjlNMo2H4NxOPg4Zfu6uRYHvgVvOdKhJTFTklwHMovk8UIxw1FlcpkqafuiIL
         qnJY7pFmcWPh+XtrFav1p5DH8Z5Tm3+0NLnOrzweZ5ElgFsjTfzaQg05vol1ncA1a2Jc
         QEtQ==
X-Gm-Message-State: ACrzQf3f7mSwMaFbjq88KioAQxZr4DlCOk6uiGpEkz6gnYgW9mh+Q7Q6
	k0DSQp6caolQiPOxncdDE56Ut2ahKL+H+YVs
X-Google-Smtp-Source: AMsMyM4k8l3vqoT4/gUiy442sb0fpO1CA0RxN3NT1AX7pF5qcTK7/Q8pqXGinz+UgERwG0gsTdSO/Q==
X-Received: by 2002:a2e:8697:0:b0:26f:b795:8b39 with SMTP id l23-20020a2e8697000000b0026fb7958b39mr7378616lji.218.1666371346997;
        Fri, 21 Oct 2022 09:55:46 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b004946e72711bsm3218532lfr.76.2022.10.21.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:55:46 -0700 (PDT)
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
Subject: [RFC PATCH 6/9] iommu/arm-smmu-qcom: provide separate implementation for SDM845-smmu-500
Date: Fri, 21 Oct 2022 19:55:31 +0300
Message-Id: <20221021165534.2334329-7-dmitry.baryshkov@linaro.org>
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

There is only one platform, which needs special care in the reset
function, the SDM845. Add special handler for sdm845 and drop the
qcom_smmu500_reset() function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 34 ++++++++++++----------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index c3bcd6eb2f42..75bc770ccf8c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -361,6 +361,8 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	arm_mmu500_reset(smmu);
+
 	/*
 	 * To address performance degradation in non-real time clients,
 	 * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
@@ -374,23 +376,20 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
-{
-	const struct device_node *np = smmu->dev->of_node;
-
-	arm_mmu500_reset(smmu);
-
-	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500"))
-		return qcom_sdm845_smmu500_reset(smmu);
-
-	return 0;
-}
-
 static const struct arm_smmu_impl qcom_smmu_impl = {
 	.init_context = qcom_smmu_init_context,
 	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
-	.reset = qcom_smmu500_reset,
+	.reset = arm_mmu500_reset,
+	.write_s2cr = qcom_smmu_write_s2cr,
+	.tlb_sync = qcom_smmu_tlb_sync,
+};
+
+static const struct arm_smmu_impl sdm845_smmu_500_impl = {
+	.init_context = qcom_smmu_init_context,
+	.cfg_probe = qcom_smmu_cfg_probe,
+	.def_domain_type = qcom_smmu_def_domain_type,
+	.reset = qcom_sdm845_smmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
 	.tlb_sync = qcom_smmu_tlb_sync,
 };
@@ -398,7 +397,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
 static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
 	.def_domain_type = qcom_smmu_def_domain_type,
-	.reset = qcom_smmu500_reset,
+	.reset = arm_mmu500_reset,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
@@ -450,6 +449,11 @@ static const struct qcom_smmu_match_data qcom_smmu_data = {
 	.adreno_impl = &qcom_adreno_smmu_impl,
 };
 
+static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
+	.impl = &sdm845_smmu_500_impl,
+	/* No adreno impl, on sdm845 it is handled by separete sdm845-smmu-v2. */
+};
+
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
 	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_data },
@@ -460,7 +464,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_data },
-	{ .compatible = "qcom,sdm845-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_data },
-- 
2.35.1

