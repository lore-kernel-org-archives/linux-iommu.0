Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CB7C
	for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 09:44:35 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id j16so1886144lfe.12
        for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 01:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07jxP8RcYFdE+SSC8KiN//xkr0d7SR0+oxWGO499peQ=;
        b=LSZF9vPxP9SRCCRRlugy9ekXBT9pLaqSLEk4FXkTueoXWwiDMw19beV0kmm08vw7kR
         bwFK8Thq5hj8JJOUhxvARAOmaBPC6M5adxr3RPiQOQi080uZYk36NZ1j/Jl8dfD+DKDz
         qVYcDwazmdvFKb9sJjUuc/krbW8lWq61lMD6YxBmDTs7nO1eOzkJiWBJLgkzeJMfZDt0
         7ll36P26rnm5q86x2O0TU67grttZJ1H1jkd71HOkir4oQq+tdXaNz6mfVIzmv3hVWKtB
         I+Giz3NUME+0SGNGMPx3WM/1Gez/T1gup38sDDvLb2Gt6HWiIOkjlzvAOUiLZMbxPno5
         6JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07jxP8RcYFdE+SSC8KiN//xkr0d7SR0+oxWGO499peQ=;
        b=1xYzZeIyYPKcQMW1ioyENYtk54SJtp07WHhk9bRxx9f17+wXDP5s+HlYIVH3EJINsb
         luFMUNeNOs1oG4LSykjE2ofD1bfD6jiz4TCQy7H+lK8pgVa6CB9UdDTYzYgZVyKGJ/Eu
         OnxV1UTIYQUfhO7lkzLNeOK6ikXIS70ZjcEwXi1j9dYRNxsTm5PDsuk57hkNtuVBzvTj
         3aj36bdbC+y5foscROCz+rXUfgkg1Pj5YsvTxleeaJ8MNZF4Vx9+2TudLsNCCcOzUoCB
         NsFtL/Vu99qSmq3Iy0YovSQMZ5yX8d9TOSLpMZYWFuml2GXbqXiSp5rvbfi7DjipgZmK
         wThg==
X-Gm-Message-State: ANoB5plxahM7ho1/iIKxSyd+UkbzJd96O6in59Ky4xxNAMm/JBtk+Ipe
	7W39+jvnF6VNZZwO53gZy7r0+g==
X-Google-Smtp-Source: AA0mqf7sxxHmLU3xjf1JZJdrXwApfX2dW3Xq6Qp0TygXefNSEF471QrQQDVzmNSY/KnTae89FV4c5Q==
X-Received: by 2002:a19:e048:0:b0:499:af06:a77b with SMTP id g8-20020a19e048000000b00499af06a77bmr581604lfj.202.1668678273353;
        Thu, 17 Nov 2022 01:44:33 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id a23-20020a2eb557000000b002770f0a742bsm105312ljn.41.2022.11.17.01.44.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Nov 2022 01:44:32 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: patches@linaro.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@chromium.org>,
	Emma Anholt <emma@anholt.net>,
	Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/arm-smmu-qcom: Add SM6350 SMMUv2
Date: Thu, 17 Nov 2022 10:44:22 +0100
Message-Id: <20221117094422.11000-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221117094422.11000-1-konrad.dybcio@linaro.org>
References: <20221117094422.11000-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SM6350 uses a qcom,smmu-v2-style SMMU just for Adreno and friends.
Add a compatible for it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index fd97db178696..fa84a69b9439 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -513,6 +513,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8150-smmu-500", .data = &qcom_smmu_500_impl0_data },
-- 
2.38.1

