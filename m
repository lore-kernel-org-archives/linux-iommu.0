Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE23D63
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 16:55:40 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id j14so4473881ljh.12
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swEbnkg16JzzdPkO3o6RjQHUGeEyRg5rGzCMEolyHdw=;
        b=HkR8YNN7zkfwR4bQHZNTSesmB9AFrAG9KhmXnjBBxFqTUi+iowSCAb9Xj9rS18adNQ
         D1X02hrKZ1fF7SaF2c/WGDAf/xvC6ARYbWPvgzH0xjtMo/ljWSts1VlsSbttdhWTEYIE
         7rA+d73GQw30rnOAVqP+bcxfopZbuUNZ9MJBKE+jETwnBfe0l3LcRZ9yyeaF92jfalLN
         vJfUYp19A3LIMtWCbPBQjnigBI2BiMGIrQHARzGIFCs0/yjz1RN9kmTo9zz6JN4dObOV
         2ydUPpqjLsVSlR+q3e2jqTFHZu71JCarWEhn0ukUMeDHCJ3veLNqgoOu3hStyRRI3f6n
         98EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swEbnkg16JzzdPkO3o6RjQHUGeEyRg5rGzCMEolyHdw=;
        b=dAYE/9Jxj4lJWMYAy9N/cWC+x1sWZaTL7ChaOwfdOqgBPGP52hFk8AXTaddvV/2/1+
         laZKeJ6pg3O/SLGZrG8W7n0OCiUJ+OfWTfRmjQHN0ah1bwskQNsT7lHGKiQQMcFMYB6M
         WKky1psqESOThDJBSYdBCNYeW4s3+eT3LURfmr4vV+qGQu2+7RBSyF/GkSXRP6Y2dZi5
         hxTT15aA7nqQoKi16waE3BcidJdhXMMKCtWwy9zGFtHlLleEasJnv/zBlisf39+mbdrG
         Aewfm8dqVK9ASU5PRivq99bWDG02SvW2aDgmPCnRbDIR2AZD5T29PvdrcyksUf89+v7Z
         sDlw==
X-Gm-Message-State: ACrzQf2UBn6bfpQ2+z631NppIuMrAAX2jfZZAtjScUOC1w9tGIA8hLrU
	z2mGWZGluIUgfGeA3gnc+ffzO81yLWPSWmOD
X-Google-Smtp-Source: AMsMyM72D25evGBxUYTZdeE4xtBjug0bsR2/qvu56ipW4kRLRSgqK5NdHKPs568C9UVsg5sutvZ7xw==
X-Received: by 2002:a2e:a9a9:0:b0:261:bf5a:8ff3 with SMTP id x41-20020a2ea9a9000000b00261bf5a8ff3mr7175563ljq.252.1666371338356;
        Fri, 21 Oct 2022 09:55:38 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b004946e72711bsm3218532lfr.76.2022.10.21.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:55:37 -0700 (PDT)
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
Subject: [RFC PATCH 4/9] iommu/arm-smmu-qcom: Move implementation data into match data
Date: Fri, 21 Oct 2022 19:55:29 +0300
Message-Id: <20221021165534.2334329-5-dmitry.baryshkov@linaro.org>
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

In preparation to rework of the implementation and configuration
details, make qcom_smmu_create() accept new qcom_smmu_match_data
structure pointer. Make implementation a field in this struct.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 58 ++++++++++++++--------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  4 ++
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b2708de25ea3..bd228b7d6817 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -405,10 +405,18 @@ static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
 };
 
 static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
-		const struct arm_smmu_impl *impl)
+		const struct qcom_smmu_match_data *data)
 {
+	const struct arm_smmu_impl *impl;
 	struct qcom_smmu *qsmmu;
 
+	if (!data)
+		return ERR_PTR(-EINVAL);
+
+	impl = data->impl;
+	if (!impl)
+		return smmu;
+
 	/* Check to make sure qcom_scm has finished probing */
 	if (!qcom_scm_is_available())
 		return ERR_PTR(-EPROBE_DEFER);
@@ -423,22 +431,30 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	return &qsmmu->smmu;
 }
 
+static const struct qcom_smmu_match_data qcom_smmu_data = {
+	.impl = &qcom_smmu_impl,
+};
+
+static const struct qcom_smmu_match_data qcom_adreno_smmu_data = {
+	.impl = &qcom_adreno_smmu_impl,
+};
+
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
-	{ .compatible = "qcom,msm8998-smmu-v2" },
-	{ .compatible = "qcom,qcm2290-smmu-500" },
-	{ .compatible = "qcom,sc7180-smmu-500" },
-	{ .compatible = "qcom,sc7280-smmu-500" },
-	{ .compatible = "qcom,sc8180x-smmu-500" },
-	{ .compatible = "qcom,sc8280xp-smmu-500" },
-	{ .compatible = "qcom,sdm630-smmu-v2" },
-	{ .compatible = "qcom,sdm845-smmu-500" },
-	{ .compatible = "qcom,sm6125-smmu-500" },
-	{ .compatible = "qcom,sm6350-smmu-500" },
-	{ .compatible = "qcom,sm6375-smmu-500" },
-	{ .compatible = "qcom,sm8150-smmu-500" },
-	{ .compatible = "qcom,sm8250-smmu-500" },
-	{ .compatible = "qcom,sm8350-smmu-500" },
-	{ .compatible = "qcom,sm8450-smmu-500" },
+	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sdm845-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sm8150-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_data },
 	{ }
 };
 
@@ -453,12 +469,13 @@ static struct acpi_platform_list qcom_acpi_platlist[] = {
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 {
 	const struct device_node *np = smmu->dev->of_node;
+	const struct of_device_id *match;
 
 #ifdef CONFIG_ACPI
 	if (np == NULL) {
 		/* Match platform for ACPI boot */
 		if (acpi_match_platform_list(qcom_acpi_platlist) >= 0)
-			return qcom_smmu_create(smmu, &qcom_smmu_impl);
+			return qcom_smmu_create(smmu, &qcom_smmu_data);
 	}
 #endif
 
@@ -469,10 +486,11 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 	 * features if the order is changed.
 	 */
 	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
-		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
+		return qcom_smmu_create(smmu, &qcom_adreno_smmu_data);
 
-	if (of_match_node(qcom_smmu_impl_of_match, np))
-		return qcom_smmu_create(smmu, &qcom_smmu_impl);
+	match = of_match_node(qcom_smmu_impl_of_match, np);
+	if (match)
+		return qcom_smmu_create(smmu, match->data);
 
 	return smmu;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index 99ec8f8629a0..2424f10b7110 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -14,6 +14,10 @@ struct qcom_smmu {
 	u32 stall_enabled;
 };
 
+struct qcom_smmu_match_data {
+	const struct arm_smmu_impl *impl;
+};
+
 #ifdef CONFIG_ARM_SMMU_QCOM_DEBUG
 void qcom_smmu_tlb_sync_debug(struct arm_smmu_device *smmu);
 const void *qcom_smmu_impl_data(struct arm_smmu_device *smmu);
-- 
2.35.1

