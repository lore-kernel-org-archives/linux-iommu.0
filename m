Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DF6100
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 16:55:48 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id g1so6128034lfu.12
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHK2YnMn+PvfYswOSFncK4QS54g29samxTkRB76ABgU=;
        b=QhBDQ5kK1j897lvFrRw+svqzCraAat7SwGd6nZ5bUJsOOM15yQry1i8t4HINEftYdn
         CRcKGGE8vlKC3OUlPPySwl/t0pv3Rh8PigCRlkn0hU/SPQ6i0DtAs/zVMG++gandxo98
         54DfmclbE+zdcmqEYfieFfyKUz1zHEG2liSHfFfe4HJgi4+nkvDse1Bsu88oEWDTudWR
         vxzi6iGoszEU5cCuUHadXJYacqx3sm+O3eJ4F1aAHA2ij9P31bfQxFgQuDbgqToM9aTA
         PnSp8G00mc9IkM6ydU1vjU/l8FJMbVRplTNNGT9a8yc6WysG7KA0Slp0O5VcyZOgm69d
         VdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHK2YnMn+PvfYswOSFncK4QS54g29samxTkRB76ABgU=;
        b=eVht/wEdubUXCK9XfI0ImJQqowCohhhaJ5+Z5nAfrfEquMWSLAusq8QJgLbpgDvTmI
         fx9gl+B6XB2BduzKQ7QocR5gIpL5oSSLnlL3oEuhSiAecHl8cHC8Utov/jrNmKmRpznR
         rh8a0pGnEPTNm8iS7jDPJEJUdh5gPI3VvVbkDodsfRoP75i71ThW7LmlWQpS0cj78REu
         tkTJsP2cqmD6yFXTosCGEoeJbF8xTyz8+75fNIg9XxMJ54UFY0ZDzbkOYZnzBlSYqAIL
         voFRXndlwnNm575rskrFNj/NAYKJJo0sD8yY9rm3hS2KgBOXzfLssII8nkOyFd5TnaMU
         MG+w==
X-Gm-Message-State: ACrzQf3ro3X5APwBdcQQE+QdrpnciQ9gKI1vNI8leB/l/dACtIJSMyOh
	cUsuILzW4ZfYxRJf5ewjoH+3ng==
X-Google-Smtp-Source: AMsMyM6wHuY/ytAg/rjQO4U4UWUT0S893/0vkKSHnk2BTfoAuGoidZH8mtag8Fw8V2bqSjRtIqVSwg==
X-Received: by 2002:a05:6512:c29:b0:4a2:5c6c:8b50 with SMTP id z41-20020a0565120c2900b004a25c6c8b50mr7091025lfu.499.1666371346222;
        Fri, 21 Oct 2022 09:55:46 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b004946e72711bsm3218532lfr.76.2022.10.21.09.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:55:45 -0700 (PDT)
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
Subject: [RFC PATCH 5/9] iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create
Date: Fri, 21 Oct 2022 19:55:30 +0300
Message-Id: <20221021165534.2334329-6-dmitry.baryshkov@linaro.org>
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

Move special handling of qcom,adreno-smmu into qcom_smmu_create()
function. This allows us to further customize the Adreno SMMU
implementation.

Note, this also adds two entries to the qcom_smmu_impl_of_match table.
They were used with the qcom,adreno-smmu compat and were handled by the
removed clause.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 32 ++++++++++++----------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  1 +
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index bd228b7d6817..c3bcd6eb2f42 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -407,13 +407,18 @@ static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
 static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 		const struct qcom_smmu_match_data *data)
 {
+	const struct device_node *np = smmu->dev->of_node;
 	const struct arm_smmu_impl *impl;
 	struct qcom_smmu *qsmmu;
 
 	if (!data)
 		return ERR_PTR(-EINVAL);
 
-	impl = data->impl;
+	if (np && of_device_is_compatible(np, "qcom,adreno-smmu"))
+		impl = data->adreno_impl;
+	else
+		impl = data->impl;
+
 	if (!impl)
 		return smmu;
 
@@ -431,15 +436,22 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	return &qsmmu->smmu;
 }
 
-static const struct qcom_smmu_match_data qcom_smmu_data = {
-	.impl = &qcom_smmu_impl,
+/*
+ * It is not yet possible to use MDP SMMU with the bypass quirk on the msm8996,
+ * there are not enough context banks.
+ */
+static const struct qcom_smmu_match_data msm8996_smmu_data = {
+	.impl = NULL,
+	.adreno_impl = &qcom_adreno_smmu_impl,
 };
 
-static const struct qcom_smmu_match_data qcom_adreno_smmu_data = {
-	.impl = &qcom_adreno_smmu_impl,
+static const struct qcom_smmu_match_data qcom_smmu_data = {
+	.impl = &qcom_smmu_impl,
+	.adreno_impl = &qcom_adreno_smmu_impl,
 };
 
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
+	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
 	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_data },
@@ -447,6 +459,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_data },
+	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sdm845-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_data },
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_data },
@@ -479,15 +492,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 	}
 #endif
 
-	/*
-	 * Do not change this order of implementation, i.e., first adreno
-	 * smmu impl and then apss smmu since we can have both implementing
-	 * arm,mmu-500 in which case we will miss setting adreno smmu specific
-	 * features if the order is changed.
-	 */
-	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
-		return qcom_smmu_create(smmu, &qcom_adreno_smmu_data);
-
 	match = of_match_node(qcom_smmu_impl_of_match, np);
 	if (match)
 		return qcom_smmu_create(smmu, match->data);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index 2424f10b7110..424d8d342ce0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -16,6 +16,7 @@ struct qcom_smmu {
 
 struct qcom_smmu_match_data {
 	const struct arm_smmu_impl *impl;
+	const struct arm_smmu_impl *adreno_impl;
 };
 
 #ifdef CONFIG_ARM_SMMU_QCOM_DEBUG
-- 
2.35.1

