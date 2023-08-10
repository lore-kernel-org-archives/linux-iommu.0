Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F3214E8
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 17:45:14 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so1811884e87.2
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691689513; x=1692294313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0GKjPDyvoAuP+M91ApLudBjH9CMGM8uGu6N/SkZfpM=;
        b=nzOkxJGTHk3Y/1sv/1gGEQXInYDnS0JfvQH0NpK/YttN7ATaXNU9tEhBJyXNI4Ha18
         XVWVZoURO07TIGzyeE1Yf5L6a4qgUZ5Y3Pz66w+aD/yrC9VuCwsUvF4hCnPYHtrUIo9x
         HyZkDOrGV3NSW/0AQWvjW98Rw+UBrGnY1rZpfsvbadJeAupaOtPjpLMlfg4mB7N8bH+g
         XQSHc5/ogAA7Rv0ekm7rzVUGU8NK19RgjSFi4HJioOgufEnSbJ4rYpAHk8fSRcdVrPlg
         3heYqMDYneo6/jQxc8Iya04yY/u1IDgsmShHAC0eNyYM/ysMAuRiEQb7/GFcaX5q0e7Y
         m7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689513; x=1692294313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0GKjPDyvoAuP+M91ApLudBjH9CMGM8uGu6N/SkZfpM=;
        b=kFHNSJFKKLVEtUtEqUhUK2+CPUHIlxDg58PfiYMqATL3nP3M/Tw4rvVrVZN84yoUvL
         wUtR57As40BXc06AEt7R32uLkNd/1osGHZo+/12fmNIcUdKjH++6BqX/1Y4WLZ6zawLZ
         pGS3ZkvPokCSm51TYWXiU1EvWPrHwuePd1Rfmt8aVvONjYwIToURdHMmTA72Z10gvGtQ
         NwGwz4BALxz1+5hKmWTMdNP5FHsfr8dCyFxyf+H6w3/bu0PDlbKu9zFWeFWO7HD/hoJE
         WcxfTifUdlYWXByeiNHCFW9jc9T12R+AZKWa40u2f3Q/SaIQLLBE9382gJ5WsjjiZvvr
         bKGQ==
X-Gm-Message-State: AOJu0Yx+Vfkf+Kii+lmRrsnBFWjYz9hCn6Kv7Y+CkjcWoMF6xu6rGiCU
	7dSexIefy/2TK90Qd1iWQ3n7OQ==
X-Google-Smtp-Source: AGHT+IHrHDWWRhuLgKu7ea/IPjMYC4fPCs9kEh7OU2MUv8A2V7V0dAKGD/apDzrAfbANT74bxmxZtA==
X-Received: by 2002:a05:6512:69:b0:4fe:1e69:c37b with SMTP id i9-20020a056512006900b004fe1e69c37bmr2437514lfo.10.1691689512948;
        Thu, 10 Aug 2023 10:45:12 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm364173lfg.39.2023.08.10.10.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:45:12 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 10 Aug 2023 19:45:06 +0200
Subject: [PATCH 3/4] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-topic-lost_smmu_compats-v1-3-64a0d8749404@linaro.org>
References: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
In-Reply-To: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691689508; l=1014;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Y7bYhGu0ASVzGb9G7odf3tduVcYO2D8/4BIOQJwrqcE=;
 b=MIYsLRtU5HUGW0mAHSXrQis/HcCiBkog6h0S8MKq2Hv2tnYu1kMBKBExmI2pRXUMnEH6dzl9q
 XaqJsyk3FKuA/WHQOlr53QrCjzqHmM77KKbrkBzp9gwUCLK5lpcugQw
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the SM6350 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index cc574928c707..bdeb587552c0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc8280xp-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },

-- 
2.41.0

