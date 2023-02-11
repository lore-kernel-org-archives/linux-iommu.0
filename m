Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21111C10
	for <iommu@lists.linux.dev>; Sat, 11 Feb 2023 12:27:26 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id sa10so21830837ejc.9
        for <iommu@lists.linux.dev>; Sat, 11 Feb 2023 04:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxv3eKTtA5e9aZgQHY+jlwZt6H2vd/82rQZm7n3Xcpk=;
        b=NQIH6K9SlVrupUFRfjmSUqrEmHxFxsMW2+wyo0+MRR2O4BS/ozIvVLHbmTA6FFYSSQ
         rrY+UtU4pDfccwJ1NvuGV3zBM+ya0k+vbB7DturJaLcFp5wj76xTG8gsuNsxR0Oxi8jc
         Q1Ne7eQKCst883bTFnkZ30xbZMDhCUgId1g2p1qyjcxSMMIJsxCeIBwA4FvXSTbNi8hk
         6fCcCuJ0Lhd3TS4d6bk5nRbiokwY4VoFpt6b4peOX6DIB+rZhPlSVIuBEE441cbGzUUz
         uaaQm6FbrYaq29Tn69T6Qyqpued72pxn6owdUSM9b5Nh3TNOCKON1+FzWAvefvZAjIjl
         avaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxv3eKTtA5e9aZgQHY+jlwZt6H2vd/82rQZm7n3Xcpk=;
        b=GRBkO+d/xhCyj1LTxnx/xCiGAAvYHfakXjE4KuUV/BwlMdqGazg5MfcoKGO/8z01Og
         QPafWeBAo6SaVmJ2YPk1r/S9WyStoN1D6iKw6lwLQ0LX2d6pdB6q/eVi+FD1UL03Yb7U
         nwmxvHj2uFZu5Q4o1Iq9NttlShnob0IdEE4X4zk4FlsA7O1w/bibhoyjynVmd9eFTz4m
         4Z0x1ynoG59ZxrgNkCqKBLyi2j+Bpzbz8Nm7lB1jeocoAp5YatfHc82yK7wdJrg68Bbn
         ckZJEKsHVLoKgQnzeRItmf2bwxhYtN1t6WbzGxGgaiACcGlrmqALPJ5cw2nUdQDDDJyj
         9x6Q==
X-Gm-Message-State: AO0yUKXSsDUc5m4Em6LgzQB+XJmXdu7p/j/qnxzH2v1bqgwEhZ2c7HxY
	GGN2ldUnAVhCqz5hAS51Cyn2Hw==
X-Google-Smtp-Source: AK7set9T/kjhLcsuN3ieSGb5mjaV3UzHEzK0GKmB8WFftBur+QhwrE4VGV1Hc1Yw1Cv+PX+Y4G/wSQ==
X-Received: by 2002:a17:906:ad4:b0:88d:ba89:1838 with SMTP id z20-20020a1709060ad400b0088dba891838mr12444413ejf.9.1676118445267;
        Sat, 11 Feb 2023 04:27:25 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id mv9-20020a170907838900b0087bd2ebe474sm3767941ejc.208.2023.02.11.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 04:27:25 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: marijn.suijten@somainline.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
Date: Sat, 11 Feb 2023 13:26:55 +0100
Message-Id: <20230211122656.1479141-10-konrad.dybcio@linaro.org>
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

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the SM6350 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7425424da974..959516bbfe65 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ }
 };
-- 
2.39.1

