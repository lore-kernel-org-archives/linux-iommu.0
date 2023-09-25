Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1216266A8
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 23:43:03 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4194c3cf04aso3369481cf.3
        for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 16:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695685382; x=1696290182; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kE+gJD3NfvOq+ONMMPxSos0Sh0hveSGbfmOAPzArSWo=;
        b=WubpFKYunlDyvh0H3yuG8LctDuZkw6t1PHeNqCtPzqEdFX+VkJ3jxTY1Oc8dBiCrAV
         rNcrxUro93uDJaiDIjdfjtX0lJZOiuqpPCYtCQoc/fiKOTOmUL25JnA5Fw8E8hu7nwB2
         GiaMJ6kyjwvhDXlU7nWUGLIejKMb86kNB0ZDFlkPpnl63pNGi19vkrjiYVqkiY+y7aUt
         xct01ntpISWtiY7F3eOIYwLFXJgAoStl6occ+ththj2NAeibwx09JOmvFrxrFzdPqx5K
         WLoTWcL+zyZJI52x2Z9dPe7HJr/9CfH1AuzwzY+awDSuV2lXf/hF4urWlvevOJBQHmyZ
         SlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695685382; x=1696290182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kE+gJD3NfvOq+ONMMPxSos0Sh0hveSGbfmOAPzArSWo=;
        b=HMydLjrEGxyptcMvy7LWvq2JVSViYGiC5Zei1MYbKHdGgJSywWwCqrZ0FgGxXcHBs3
         3en323ZgNZSBx01cKLgVjYOZ9K10F6Cpn7MoAjhJ0jndWUVoyXr5W6MmuLumCUcSap36
         DL53eR3SVATVYOcJiXk19F9o/tbShu2rCiNafWkYZVBow/u+c1cNVm5bG2TccE157HnN
         toiXGJ8wdX+LzHU7+kZeKDgiNFfcku0x/fW6+OO6qi+50ukHV2hNuGYVzTGTWAGtus2N
         G8FM8+LTomZs92eZH3eKFdXZ4EVfWrrbCGGqeYARTVTYkBVUjuJFwIBjOC4JHajX9cYQ
         LUsA==
X-Gm-Message-State: AOJu0YxZRGrdv+pxC9+FAhxOz2W8OEIuk4y4xs1N/VEEBDokU3NI02C6
	AFwxzVB7ZJizOCa2KmLF520=
X-Google-Smtp-Source: AGHT+IExFo1O6zL/2eNvYMAA3umVnfog9PiztuNE0qXDXfqI+CHgnoabN1/VSvWlt00VPB2ALccbjA==
X-Received: by 2002:a05:622a:188f:b0:417:bdd5:fd10 with SMTP id v15-20020a05622a188f00b00417bdd5fd10mr11095461qtc.51.1695685382667;
        Mon, 25 Sep 2023 16:43:02 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::efbe])
        by smtp.gmail.com with ESMTPSA id h10-20020ac8568a000000b004181138e0c0sm1845614qta.31.2023.09.25.16.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 16:43:02 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH] iommu/arm-smmu-qcom: Add SDM670 MDSS compatible
Date: Mon, 25 Sep 2023 19:42:48 -0400
Message-ID: <20230925234246.900351-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the MDSS client on the Snapdragon 670 so it can
be properly configured by the IOMMU driver.

Otherwise, there is an unhandled context fault.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7f52ac67495f..8290494bc7ea 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -251,6 +251,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sc8280xp-mdss" },
+	{ .compatible = "qcom,sdm670-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
 	{ .compatible = "qcom,sm6350-mdss" },
-- 
2.42.0

