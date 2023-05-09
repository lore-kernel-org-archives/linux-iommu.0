Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A318005
	for <iommu@lists.linux.dev>; Tue,  9 May 2023 16:37:18 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6436e004954so6312818b3a.0
        for <iommu@lists.linux.dev>; Tue, 09 May 2023 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683650238; x=1686242238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TaDF8zy4btueLBSrY9dwMuQHd4N85rvewa4k8qv4+LA=;
        b=j14RYjsAZP/vRadBipwj+/IsyNXcsgsIAhyw919XbStBA4kce3hQvKJ+cfxL4B2Fyk
         xDslF7jbK8TYBzo3nv3M5tNKeJjYsIhGrvrv0UPaY8Lqtwx8ww8oFWZxQ5STMCvjOzoo
         FdS2t9RdlZKcaR+m5JNWNFHI3+/DXPWurM/sx0TXEvdgNiU7+V1XnZ3pLh50ogSibyKq
         OP+GfeN+rwBzfoUUSKlt5Frrt2rm4uGh7guDSGSq/qLjrguJp2+RNuCGEYuoQXZQ+t2q
         im4ETpEyj3JKyhI6ChXApXKixbt+M5tce/JMfZdqk/T60jKy6V59XI1JaDR0WK9eW9N0
         UtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683650238; x=1686242238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaDF8zy4btueLBSrY9dwMuQHd4N85rvewa4k8qv4+LA=;
        b=fFwnmo/PbFdee12vLqVmmubwCnAbfJgc5OllHHq1mSEG33XiYP6obM6uB2RIRahO7L
         thoA5QDeDp1QI61f+IjvTjxnIMHBg5Qe7O+u+zLIPZgC/yhKnvD2AdpD1TyjbKBG8Hul
         ETUf4naP9iB3q/INOna2A4B1gfezYGbbuCcISAhkZGwuGNtI6uimQoZsbZLLaGWRa87C
         HHgt6UhzUTaq2gBBBoaEskfbSOf4gDGsZDA3ECAiFdY6d+EOvob0fARsVd/iaJsAmxKb
         pfZu9HoYtowQ0ozk26lgKVWZtZ5BuTzKwaMnw2KqotLkpFoa7fEuuAAHKxbooir7AjUT
         YDGw==
X-Gm-Message-State: AC+VfDxN0L1+8V1SCSJlcXrUHt3hEot8jyaZ2VauOwZxiu5ylaC4WZji
	xSLm8G7vbobzxVWGje0lCVk=
X-Google-Smtp-Source: ACHHUZ4Fw2eEX9sgR3Z4fMrQfqI4ebENqvBJull5h+TO+c/ePom2r4665yNHkpO6ibZvUcr5PA5kEQ==
X-Received: by 2002:a05:6a21:6d88:b0:f2:fd1e:efc9 with SMTP id wl8-20020a056a216d8800b000f2fd1eefc9mr19258556pzb.5.1683650237508;
        Tue, 09 May 2023 09:37:17 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id y9-20020a63de49000000b0051b7bcb6162sm1547873pgi.81.2023.05.09.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:37:17 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Lepton Wu <lepton@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Emma Anholt <emma@anholt.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
Date: Tue,  9 May 2023 09:37:10 -0700
Message-Id: <20230509163712.376117-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

When the special handling of qcom,adreno-smmu was moved into
qcom_smmu_create(), it was overlooked that we didn't have all the
required entries in qcom_smmu_impl_of_match.  So we stopped getting
adreno_smmu_priv on sc7180, breaking per-process pgtables.

Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create")
Suggested-by: Lepton Wu <lepton@chromium.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..760d9c43dbd2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -496,20 +496,21 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 /*
  * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
  * special handling and can not be covered by the qcom,smmu-500 entry.
  */
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
 	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
 	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sc7180-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
@@ -540,12 +541,14 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 		/* Match platform for ACPI boot */
 		if (acpi_match_platform_list(qcom_acpi_platlist) >= 0)
 			return qcom_smmu_create(smmu, &qcom_smmu_500_impl0_data);
 	}
 #endif
 
 	match = of_match_node(qcom_smmu_impl_of_match, np);
 	if (match)
 		return qcom_smmu_create(smmu, match->data);
 
+	WARN_ON(of_device_is_compatible(np, "qcom,adreno-smmu"));
+
 	return smmu;
 }
-- 
2.40.1

