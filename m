Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E221502
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 17:45:13 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe700f9bf7so1834746e87.0
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691689512; x=1692294312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8FWAEIAhA33W+8UDaX5UpHwiPnLkWYvv2NefiVeC38=;
        b=eHE0zrK0OPJWgmKqCGjViM7iMYsk9t5p/9IySjOWR/qIbxSC4ZY3aP4Cmvo2PYeqEl
         zwu5gJGNJ4pA07wPSvn5CCFNOre19RtP028icMlvXR4t3Vk1Rz6V9A/QgJZA+0q1q6js
         C0cKF21AkYE2dNplwzFoF5Y/mcOJLA/fawQ6NQRCygVe4TmaHDEspE/dUhRKhtyjYAcf
         +YEjDul7yiKlaaPyWAooxecpu9O43Sf07IsrJhTyHbjrpk5tlNxGhxyOGL4IeIhuGIjs
         MU2rWeuEgOZoOws0nk63lE2BFNGqcxZ8PtLjBX4FSODNsRUvDGzSzO9YPQQu4bopVswR
         58ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689512; x=1692294312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8FWAEIAhA33W+8UDaX5UpHwiPnLkWYvv2NefiVeC38=;
        b=kPWJJMo5eF4YqevaKHbPhEe+VBCUmK41qqplZCIT7aiJa3YHXArKr13ESwO0x0IEHR
         NUADA27PyH7dvWielTfkShYSTY9mTyHeIVYNKUKIknPIsMsd0loeK1I/3Z/08tQuzb5c
         2MN1EoKPFBkn/vbCXR7YIK+DRoBFdd/y82P5dLqmmLvQjynoMs0yj5EDNFi9mVA9R53v
         nEDQ/0Xw1xz80YAB2bf9cFOlPdy+oM261l6+CzK8APAmP/cbt7R6qDWnoFHDsXAdwH2F
         RpqqlE9HwF7WPC9Z+nt2HDEbYjdmOa8T2REMVnDeMndKjC7JZymulXy7mJLKFxKFNn/4
         3I7A==
X-Gm-Message-State: AOJu0YyAzg+oIdNmts5CQp8SJ2jxSDF3Qj1oYPvDvCzZTMvV2QJZgDAU
	jCeQi5qp9WkcsuW7jfUQZzmnpQ==
X-Google-Smtp-Source: AGHT+IHSeBWcISMVgzTRKoGQw0iSsqq2Vw1ek2suvWtK0JJkC0ikQlJHLhWl/Q4oHqLqR+AYzXxlig==
X-Received: by 2002:a05:6512:36d2:b0:4fc:df79:3781 with SMTP id e18-20020a05651236d200b004fcdf793781mr2214199lfs.66.1691689511821;
        Thu, 10 Aug 2023 10:45:11 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm364173lfg.39.2023.08.10.10.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:45:11 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 10 Aug 2023 19:45:05 +0200
Subject: [PATCH 2/4] iommu/arm-smmu-qcom: Add SM6375 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-topic-lost_smmu_compats-v1-2-64a0d8749404@linaro.org>
References: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
In-Reply-To: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691689508; l=919;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vqfPAR2SkzRz/y82PPSbW9MsnNV0xJ1HzwUE+LyK1W4=;
 b=c6VRAVsJRCu6e/R2rPJFuagGfCj4TLZnmDg/MfVZ5YywkJaBPan5ETJHaJIQV+caP748sJJh8
 7zGrgcnJdVPDtkZlIfuE3OJDziJxh+CM6ZazYMIhyiPGg7Rj9kcIwBo
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the SM6375 DPU compatible to clients compatible list, as it also
needs the workarounds.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 3800ab478216..cc574928c707 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc8280xp-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ }

-- 
2.41.0

