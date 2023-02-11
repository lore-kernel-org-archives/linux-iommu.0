Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB91C10
	for <iommu@lists.linux.dev>; Sat, 11 Feb 2023 12:27:29 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id dr8so21790459ejc.12
        for <iommu@lists.linux.dev>; Sat, 11 Feb 2023 04:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFp89ec0Gr3RlKfBxRJjtE1gTMumSINkw7PnkXnimnY=;
        b=xk2doebZQk6auFDtj5Y099pDIP8MRfOdDuETsAZCKXxbAFDrNHqvoWJKumQkRcWmVo
         scg59xqSLqN4MBxnrDUvGLzHEBBZE67AhYwwOopbRpF+U/UWJvHrWIcSCRA2DyAuyAGH
         D9rjVKAdhGPLozHkdhPLfFQ+6XU8KapCeY7nOV6iLo560OmwQ08bXsthRvt6q7oCc/is
         rxy0K83qK0+aBLXe742rYNoK36PFOQLnKg3TLgktJJvbjfgplkb/G29rwCuHQyUGQcfC
         9MIMDH9mBYfUBgIxrGld0ZQMsseOnb9IwCpGq7RwmZoHgSmcH8z07CirveHCbWdwFS8H
         5bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFp89ec0Gr3RlKfBxRJjtE1gTMumSINkw7PnkXnimnY=;
        b=qIqgk3ZbUnkFsdEDDv1dH0ZVLcWvnnIOhjBiwvzNzUHXiVW18N9LL9MCPIvAfHjXm0
         3cgYVUfF6Jl8zZXlQRYeNbYAgazGhV7WzFNY24TOlin8CsXINlZqa34wcOKa+B1fFpVt
         LX9l1R4EUMTuJSuPL26j5DIH+Mc3oukhCA6KTzg15qn5QGGUREiupCoY4a125vOaVzwh
         UwxXuyGbjWVYQ4s1TaiAnsJJFQ1dXU9yL7x1jsqvBrRRLKXh9MEFfQKKyXmBaurhvbTE
         XDizPcTqBHMV4aqs1//SP0/1wI54TJlqQPoHTMfKk/HSnJLNU0L5NunRwHoUQqII5VHF
         aXZQ==
X-Gm-Message-State: AO0yUKWs8+RsBVp1kxGLdXLmPu6HfpwKkhZfabPSpMDRe0re+bdpbYoU
	zj42BSOSAprPVsNvGz5RwJc7lQ==
X-Google-Smtp-Source: AK7set9p+k1epdfPMeJFIaVVZ7jZqPY7vKLLqQRPkBgc/mL3tFJSTXK5kqJUzyLMwwkvBXzWQas3DA==
X-Received: by 2002:a17:906:7c07:b0:880:2870:7849 with SMTP id t7-20020a1709067c0700b0088028707849mr20575594ejo.74.1676118447566;
        Sat, 11 Feb 2023 04:27:27 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id mv9-20020a170907838900b0087bd2ebe474sm3767941ejc.208.2023.02.11.04.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 04:27:27 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: marijn.suijten@somainline.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] iommu/arm-smmu-qcom: Sort the compatible list alphabetically
Date: Sat, 11 Feb 2023 13:26:56 +0100
Message-Id: <20230211122656.1479141-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It got broken at some point, fix it up.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 959516bbfe65..d49cf7e0a777 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -251,10 +251,10 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sc8280xp-mdss" },
-	{ .compatible = "qcom,sm8150-mdss" },
-	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm8150-mdss" },
+	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ }
-- 
2.39.1

