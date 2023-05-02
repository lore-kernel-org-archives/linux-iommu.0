Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507F33EA
	for <iommu@lists.linux.dev>; Tue,  2 May 2023 16:09:56 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso3060487b3a.2
        for <iommu@lists.linux.dev>; Tue, 02 May 2023 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683043796; x=1685635796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptDvwkDRf8ObhvSOwyQg6eM98sWTyAdcBLxunDzT4/Q=;
        b=I6jeZ/ilRu61CJGPkewQd5ckji494RXSK4tjlfW3RUXCQ8fq2cPtxBUZ4IwVTiKp5u
         RcJe1BZ93BAbM5DeocsTP0z9dWVkl9adzMWVPRpP6nV75tiDGgx0hV3uDh+Qa+uIFP0n
         bujCL8XD94uXAfUoJztpdJpmQB62wgVAewun/uB/wvS7swiWMcerxg9zK9TTTcu1l11r
         ttYr7JDdhpY3BKEjFiikj2kLFkWliECUiWUliIG186N2p0bvp9dOwS01uL2R9sodve0U
         hL4CRQ60epCQfDo5saLCijjO5Tbw66zCc1E5I6itAYcqSOekRhB2+fSf5prqTGoxq4Qs
         d0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043796; x=1685635796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptDvwkDRf8ObhvSOwyQg6eM98sWTyAdcBLxunDzT4/Q=;
        b=Xo+OZdl+9HPdnmCYVrBb4kuJisZTQHzM2RfXtLYBTRcyxfLS7dc0bWIzzvNzhy0Qh5
         3p013AY2XYa67PGvIJ3bPmaNy5Wb9XLeanQRLqBwgoSdlJOPfRgqVWoPxO9LYhaw9xi1
         WV8QQuWJVfjbw3xRnKKxFABV6ScB/HsvLXNIW9zw5YLgAQk5NhrPzpDCeRGC2a44PA3n
         52nkWGvMw84y8cOwVcGS29dfK5oVklSiLIVN1IM3eSQVxciPvjWP9dq1VE+lP4DC90/7
         zuwO1EfWqwe2Q+0JKteO8oiwbXrhZbpbJDqVAckq/ruKOVJE4qobmq6sOe+k8KLiNrVy
         kh4g==
X-Gm-Message-State: AC+VfDzmbjd95mSmd2LdeU5ptVPJd6REQR9xU44H8DVC3YEqmPeF+u44
	xjw9v7o/+CB82aDWPy3oaMg=
X-Google-Smtp-Source: ACHHUZ7/SR/EIzNLSBaIwWXnGdWH+wPk46JqjklNVRkl5EW8iNrCmxqTVwJA1Knq91jeiLVCwsg4Bg==
X-Received: by 2002:a17:90a:3906:b0:24e:12f4:b74f with SMTP id y6-20020a17090a390600b0024e12f4b74fmr5249153pjb.20.1683043795714;
        Tue, 02 May 2023 09:09:55 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a0f0900b0024c1f1cdf98sm8120109pjy.13.2023.05.02.09.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:09:55 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
Date: Tue,  2 May 2023 09:09:47 -0700
Message-Id: <20230502160950.1758826-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
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
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..88c89424485b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -512,20 +512,25 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8150-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
+	/*
+	 * Should come after the qcom,smmu-500 fallback so smmu-500 variants of
+	 * adreno-smmu get qcom_adreno_smmu_500_impl:
+	 */
+	{ .compatible = "qcom,adreno-smmu", .data = &qcom_smmu_v2_data },
 	{ }
 };
 
 #ifdef CONFIG_ACPI
 static struct acpi_platform_list qcom_acpi_platlist[] = {
 	{ "LENOVO", "CB-01   ", 0x8180, ACPI_SIG_IORT, equal, "QCOM SMMU" },
 	{ "QCOM  ", "QCOMEDK2", 0x8180, ACPI_SIG_IORT, equal, "QCOM SMMU" },
 	{ }
 };
 #endif
-- 
2.39.2

