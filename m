Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211F21501
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 17:45:15 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so1851727e87.2
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691689514; x=1692294314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0L/Og6SjPo7hch9m1P0xrOeWP0OpTof8BKpwKVvYwAo=;
        b=Sm30q7YXaMhuBhN+ZvZE3EGftImSvNDB6NoDq9EDFCnvEixqQeqWQpkNUXE8WhZgin
         y5+cSEvVQ6PFb0N4Iad9bHj/ROhjsoiPCrSffoMFPxgf7PEbP07a3a6zYBk6rkJQu9GC
         3V1VJpdezTGe+HfbRqQ6Ev7NnJvOmlndgAmj21rmv85m4+88PCcF1yZ8H8IOSAxw1wFe
         yN6l2rSkIZQXibPGX74K6Zg4or8i3r0RLKZk7eMVtxmFBhhVb6Ew68uBg2GAHLtQro4c
         oBxkJSD5KuAkL8rIlsI67JB/8hjpEGThninCf+gVYYphC2SRcq8Z1yNpz6BeHvoFn1xP
         YCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689514; x=1692294314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L/Og6SjPo7hch9m1P0xrOeWP0OpTof8BKpwKVvYwAo=;
        b=elZm4c6QUWGsAzbc/t3vNtnm//I5klw6APKCdwYYLttnScbaGR+GIOUvxRfwHV7Ge/
         Q89U+ch5eKsK0Gi+uRWDf5W+K5dYzbW4TdGDDDL3ztEXt1Uca+PDp10/wRIBJG/DpKEe
         XPxKQowlhgYOewwj+xN6TIHAG2lmisYJDu49xQdSZ7RdUReIs3Z8U1J6HInekP5TuVEG
         cyFusfwRfVICWx7THcU8ZzyJW0CzrxJmyb5YXW3/9U4sR0ZZVn33Rb1jkbnA4dxBidLo
         uC2uMvS63n3KihslDrbuV8fZDmatbfQxJzw/iwpklvnbmpDdl2wHC28GO20ws8XOsJwU
         ryuA==
X-Gm-Message-State: AOJu0YzyIkiPn06TP/2B9Dp13phvRVNArdEaJBjYzEnKroBZgFtn0C9j
	TxZtsdRcPffSg3MT4VS8eGyaRoHmiH9XWjCIPLc=
X-Google-Smtp-Source: AGHT+IH+1Gbo/TDmIW3eblhDt09LUR928LMZ8o1dvucQgGBtoFZYRUvUsK4ADgxOeMn5fDbqlgYP3g==
X-Received: by 2002:ac2:4e90:0:b0:4f6:6b:a43b with SMTP id o16-20020ac24e90000000b004f6006ba43bmr1988158lfr.52.1691689514159;
        Thu, 10 Aug 2023 10:45:14 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm364173lfg.39.2023.08.10.10.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:45:13 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 10 Aug 2023 19:45:07 +0200
Subject: [PATCH 4/4] iommu/arm-smmu-qcom: Add SM6375 SMMUv2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-topic-lost_smmu_compats-v1-4-64a0d8749404@linaro.org>
References: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
In-Reply-To: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691689508; l=1145;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CNJ4mh92G6GMEZSc82T6C+uor7teKMPMhLG+CGjqQnk=;
 b=odug6g7eeZl/NyqzcER9avooNnc6ZKseMyv0ZesSFlplkwxRhXbbwdafjamBXVk6h26D1mKVw
 ORagvM5INz7D+Z1/wxg1iZJzadTT59UWAgmqIIKjglYmJyDFj9qlr12
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

SM6375 uses a qcom,smmu-v2-style SMMU just for Adreno and friends.
Add a compatible for it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index bdeb587552c0..7f52ac67495f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -530,6 +530,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sm6375-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8150-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },

-- 
2.41.0

