Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82D73187
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0ONlRWj"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso1147468a12.0
        for <iommu@lists.linux.dev>; Thu, 07 Dec 2023 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701984427; x=1702589227; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Px2TdaotpIYQ6sIN9yY8qaT1+HH5T+pH93w2l1LXKbY=;
        b=C0ONlRWjuTZh81csEFgOzBRmtgAvRFzIIxby3Cw5FDejG5r6eZQX9n11ls2gEwTpqc
         Ju6eVfMEJrEU1wJLuPUZm94IdfTZhXY493ruOO4MKxJ3jGIjJzEpvAeVyWUx2G9LP1B6
         6FSVor1Ior54AnaFilb4FaXNSL2DO4MgG7y9X3PWnAFhW14iv4R7CVjsUF6FqNJMHyit
         psiGeaLYpf1SaWVyF20mjxR9/zCy1rU9T+i/YA9FXhcLT5e2pgQNTHc4BQ+pvuW74EZK
         N2AnSz2AXM9vV0N7hIfehJjjm+Z7+Ot8DKK/jy9cXW+75OWTqBB8b/9bNUnl/9gSl1N/
         AgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701984427; x=1702589227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px2TdaotpIYQ6sIN9yY8qaT1+HH5T+pH93w2l1LXKbY=;
        b=xCdWPyWvf7eE8STc6X51SNOCSxt7EivlXs1BLcT47dT84fZ7fhe0YBidDMirvYWD45
         s0rDh2Uoc9d761i5Y2GO+S/RzcAK/RXmzSH+ykt7RvGRBSVTfsjFlDj+Lt2rISXYYShS
         CFpPOsRg+bmvP/1N+xdXH5smgyWYYGf8IwrmiFxmi5RO5SZYuidO2G/3bWZK4u+tCMa4
         24LVI+FynsvC+J+k5Gsb+M8qhftQfjULeXYYp0uV1u3iZ0dxDulkCppz7w57U7BE5ZBk
         rzFoRVaXuGUyRLLml2dzz32OGugQHaWP9k3Y5SM2lLXJti37S0N2TPpGQtJZBl/CRDbQ
         CWmA==
X-Gm-Message-State: AOJu0YxPgDwl3INsOLN2E1Uvf9B70n4vIkltHuK1q3aaZU2+4ePbSEeJ
	nFUwtLt+gYa3lqQAGvhGWSo=
X-Google-Smtp-Source: AGHT+IHmgFAdaNpu9/4tm5vsxNdq2+tiP4Ccd9SFpbqI/bLYNy2EA7+7YCXFBASFrF7Nf+u/eTyJbg==
X-Received: by 2002:a05:6a20:12ca:b0:187:df72:48ef with SMTP id v10-20020a056a2012ca00b00187df7248efmr3188889pzg.0.1701984426614;
        Thu, 07 Dec 2023 13:27:06 -0800 (PST)
Received: from localhost ([100.84.200.15])
        by smtp.gmail.com with ESMTPSA id q19-20020a056a00151300b006cdcfd814e9sm241008pfu.147.2023.12.07.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:27:05 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Richard Acayan <mailingradian@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/arm-smmu-qcom: Add missing GMU entry to match table
Date: Thu,  7 Dec 2023 13:24:39 -0800
Message-ID: <20231207212441.6199-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

We also want the default domain for the GMU to be an identy domain,
so it does not get a context bank assigned.  Without this, both
of_dma_configure() and drm/msm's iommu_domain_attach() will trigger
allocating and configuring a context bank.  So GMU ends up attached
to both cbndx 1 and cbndx 2.  This arrangement seemingly confounds
and surprises the firmware if the GPU later triggers a translation
fault, resulting (on sc8280xp / lenovo x13s, at least) in the SMMU
getting wedged and the GPU stuck without memory access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..d326fa230b96 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -243,6 +243,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,adreno-gmu" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
-- 
2.43.0

