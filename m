Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F079C9
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 17:06:44 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id j4so20395052lfk.0
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 09:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ/MfRbWk57/TlYjqOkdCZzo+bH2efQi2zy0dipg9Lk=;
        b=Ybm3icAEX/zMCgQ96gcuMRHqFMY1zbO/o9KF4SClXRDcH1S2JPnFHAPvA/Z5CYln5B
         h6Nvc5dU4SLrW/s1zWPfliHpIifnJhRCmwpENHhMWSvBnZqXC91vIUl3CFloaFrQHVza
         LPZ8jR49+l5efLnmOVa5EuYGeBLKUCqjHrh9Kg4fV5d7xIx4vXfwgdjNLTqrhyRZrtLd
         gGS7JL3cqW3ZCEVcURJ0ocXbXTAVZ2YkiR0zCxSWi0f8ss0UrpwKoSXvBj8t1Vx7K70d
         93m92seMkRhDoP19I/caurwPU/+GJ0VSasElNhl1RJRiCWrNEgIkVOBiR9TLZniTlh3N
         kYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQ/MfRbWk57/TlYjqOkdCZzo+bH2efQi2zy0dipg9Lk=;
        b=76nGp5gJAJW5f5DTFTsYHEJdjpC6PpbsZ00HR0vxs3RyYbGui1CuO7Lmd7hLe9bLtb
         vu74ic3gZ8IgotibPqj8fa6hshmbq20hWoxWYHMjbo/i3KF9jKA6P0nCyLYuufG32f3w
         ficPhxEbYn8FcnK5A8F8/LD387K0IwJmbW3AO+gaBcaq+9aA4VKBeAAR5FWmWXO2eFwg
         vsPgUD+kZylGUPCT7Rc5brO1M+fIiigukVgjkP0UXMXqzslNn4dX0pEfzCtPQ7cJhLvD
         cixP+E5+68GvwK24T/3oPa4eAU3AN2LBwQ0cx15IvvF/XggmuSQlhOrHDL5NnRGlcWxQ
         /Ghg==
X-Gm-Message-State: ANoB5plNt8REQYtvm7i5Z3xbo+ihS+hP4p449WqQi/i8tjUhfgEjrCP7
	TSkKfQX7RCttZppIMVQ5RF85fA==
X-Google-Smtp-Source: AA0mqf4khZfwph7q3arr7F4lnxZ6eYoGK0PnPggZFqIpo12pvDxhIQKh5Umxfrue2P5ctwRC9Rp7/w==
X-Received: by 2002:ac2:5f1a:0:b0:4b1:be16:4a4a with SMTP id 26-20020ac25f1a000000b004b1be164a4amr5035274lfq.0.1668445602169;
        Mon, 14 Nov 2022 09:06:42 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q7-20020a056512210700b004a2ae643b99sm1896344lfr.170.2022.11.14.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:06:41 -0800 (PST)
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
Subject: [PATCH v1 07/10] iommu/arm-smmu-qcom: provide separate implementation for SDM845-smmu-500
Date: Mon, 14 Nov 2022 20:06:32 +0300
Message-Id: <20221114170635.1406534-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
References: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
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

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Tested-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 37 +++++++++++++---------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index e61194127772..6dc7fa918799 100644
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
@@ -450,6 +449,14 @@ static const struct qcom_smmu_match_data qcom_smmu_data = {
 	.adreno_impl = &qcom_adreno_smmu_impl,
 };
 
+static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
+	.impl = &sdm845_smmu_500_impl,
+	/*
+	 * No need for adreno impl here. On sdm845 the Adreno SMMU is handled
+	 * by the separate sdm845-smmu-v2 device.
+	 */
+};
+
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
 	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_data },
@@ -461,7 +468,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_data },
-	{ .compatible = "qcom,sdm845-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_data },
-- 
2.35.1

