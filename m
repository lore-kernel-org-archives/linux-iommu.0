Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207979D5
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 17:06:45 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id k19so14068725lji.2
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJsRikfnRLu3deSYcn++faXtckS1l23BHpGOU9UhFWw=;
        b=GWHy4EgGCogdO6+XalHTr/JlYtU9YsfE78OjNxgdyVFNklPvYOa9xhjg/8ENMkX5zf
         R3DPxdSr4KOgY9pUaG9OoJTVw9CgmcQggYSb6E5p2Tqo9WI4ab9xHynS+5bCmI40Zgdh
         RwYUTBAad/OfjXusjtPzfkAz4t0JSqdKb3OoIJVI/hG8rqPl5Dwdq1QAkJAXZlq27wBS
         Lo7/aUvFG2gWSpYbCgRhAEFZ4+++fU7uc+5tlWM2oa3xbY4yQv25d9fQus1MXyyF6VwX
         lKqOm0Kqjw8QOtaaacZuAxevF11gWo4xeTxNrf3mNu0OMAWR2rTFC7si203wYDiJ4x91
         X8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJsRikfnRLu3deSYcn++faXtckS1l23BHpGOU9UhFWw=;
        b=n6Y2aNfR8f+Vce4av0nB1n/aWjtra7EZMZUS5Ic7jr7jE3DEUFFfEW2cJz/q7v4gnK
         GGCMAj5X2wP+2yAwInMFkefiO5oCHL1+8uufJgcW2qurNy1O6juwTnZW5B79kv+m13Al
         4BuISAgXCtncnnW8bf7+SJdDMXXQWHO2BNOg61djQMfko2HHgkgawH23zNL4cQlKbXyz
         h76kyEQ4PFVFrK1sD3GQJhTbT4MgN7o7ZRi3vyG3iDXKoC1Iu9FbS3vsZvXuy3JGQzHb
         xUX7622O+p1ushH8tbwZI/0MKdMccGk5mfVK+pOp447sYncCvNsLPFjcHnddE9QqTxWa
         bdkw==
X-Gm-Message-State: ANoB5pm1N0dUaLmKncLcmL7Tzle7/oUcZGjp7h8sVVehvO31OAwsVzWh
	RYgA3b6Ky2fEz+KSrh4lH82YYa3aLmr74g==
X-Google-Smtp-Source: AA0mqf7nacmK4UzsEft4cZKZK7CgZH40eDj+79SSh03+6+cCBR1tlhnS1LACye67NZhI7TD6We5EtQ==
X-Received: by 2002:a2e:54f:0:b0:26f:a90a:fd82 with SMTP id 76-20020a2e054f000000b0026fa90afd82mr4813022ljf.248.1668445603674;
        Mon, 14 Nov 2022 09:06:43 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q7-20020a056512210700b004a2ae643b99sm1896344lfr.170.2022.11.14.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:06:43 -0800 (PST)
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
Subject: [PATCH v1 09/10] iommu/arm-smmu-qcom: Stop using mmu500 reset for v2 MMUs
Date: Mon, 14 Nov 2022 20:06:34 +0300
Message-Id: <20221114170635.1406534-10-dmitry.baryshkov@linaro.org>
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

The arm_mmu500_reset() writes into registers specific for MMU500. For
the generic ARM SMMU v2 these registers (sACR) are defined as
'implementation defined'. Downstream Qualcomm driver for SMMUv2 doesn't
touch them.

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Tested-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 41 ++++++++++++++++------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 1843bcd81402..b93aaa0594d3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -376,7 +376,15 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static const struct arm_smmu_impl qcom_smmu_impl = {
+static const struct arm_smmu_impl qcom_smmu_v2_impl = {
+	.init_context = qcom_smmu_init_context,
+	.cfg_probe = qcom_smmu_cfg_probe,
+	.def_domain_type = qcom_smmu_def_domain_type,
+	.write_s2cr = qcom_smmu_write_s2cr,
+	.tlb_sync = qcom_smmu_tlb_sync,
+};
+
+static const struct arm_smmu_impl qcom_smmu_500_impl = {
 	.init_context = qcom_smmu_init_context,
 	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
@@ -394,7 +402,15 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
 	.tlb_sync = qcom_smmu_tlb_sync,
 };
 
-static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
+static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
+	.init_context = qcom_adreno_smmu_init_context,
+	.def_domain_type = qcom_smmu_def_domain_type,
+	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
+	.write_sctlr = qcom_adreno_smmu_write_sctlr,
+	.tlb_sync = qcom_smmu_tlb_sync,
+};
+
+static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = arm_mmu500_reset,
@@ -452,12 +468,17 @@ static const struct qcom_smmu_config qcom_smmu_impl0_cfg = {
  */
 static const struct qcom_smmu_match_data msm8996_smmu_data = {
 	.impl = NULL,
-	.adreno_impl = &qcom_adreno_smmu_impl,
+	.adreno_impl = &qcom_adreno_smmu_v2_impl,
+};
+
+static const struct qcom_smmu_match_data qcom_smmu_v2_data = {
+	.impl = &qcom_smmu_v2_impl,
+	.adreno_impl = &qcom_adreno_smmu_v2_impl,
 };
 
 static const struct qcom_smmu_match_data qcom_smmu_data = {
-	.impl = &qcom_smmu_impl,
-	.adreno_impl = &qcom_adreno_smmu_impl,
+	.impl = &qcom_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
 };
 
 static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
@@ -470,22 +491,22 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
 };
 
 static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
-	.impl = &qcom_smmu_impl,
-	.adreno_impl = &qcom_adreno_smmu_impl,
+	.impl = &qcom_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
 	.cfg = &qcom_smmu_impl0_cfg,
 };
 
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
-	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
 	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
-	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_data },
-	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
+	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
-- 
2.35.1

