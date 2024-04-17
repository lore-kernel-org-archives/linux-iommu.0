Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5353AC10
	for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384429; cv=none; b=JrkRBAIBIxTE93JNK2V0zFH0E/nuALHcfC6tbvNBlhdWKDTHaV/X++9mY+LIHZeex2c/Qqc6RBdCuRmkPMUYcOf6E2aOGo47Ks3pAfbmZ8VsejqLszqdYxhzZew4tGMZF9lEoEBG0lRvuOMFV/NGp4kUe97RKv8xDRX19C80U2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384429; c=relaxed/simple;
	bh=K0ao8Vo7sPBfbnwTda3s2I9W96Cl7inckQMbp1qX6wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b216gee6/VcEf1qREQ10uRkFAeJhtZupc3LQzKBypqk8XHp7d2XWo76LUro65cSOFP9Qq2ju3WjRPo2ODfAFEBBIWMf/KTO/L1h8RoO62TYSBqgJ9+ZpYqYUWMMHe/m390AMHosvEt9Lh0hKctXo0hvSmXn2eaAB9qFwzCD0zkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SfcGdYeI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfcGdYeI"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso57374e87.3
        for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384425; x=1713989225; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/wLorb8s/wxRn0nx2P3JnCqrMElCXyUmbwHbfSHp1A=;
        b=SfcGdYeIqvGX3J2dqVEDcgs3KSM/K8wq4tiaaW9vhtmxQ1UDSZBGzdqJIu7c637Lr3
         35BFJ6rbCodXc64xY896sDGUR8mYZmgeDf/iNnD2N2SnKOMMZtA+yRdCokiLeIxM8iig
         EcE3stBCxTpz2dfW+g1ehG1BHzh1YGb3lvZl1sPNOJXnITapiFpsQy2OioEQqyzsAf2e
         n0yydHjQYNbmUy3tlG4WmbA8bXJqJ9O3zWhVznQah4AVDk0cbAE2mcgvGxs5VL+OVQ+z
         w5giYHCqQfNVqNBwiftOGRVT1fjf9TzxQ7Q6OwyTlCoJgPyriGqPtBqFrxz9KLpoyNVS
         yHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384425; x=1713989225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/wLorb8s/wxRn0nx2P3JnCqrMElCXyUmbwHbfSHp1A=;
        b=Yi5v9QOZ6l42vUj3DdnrSyDGrKaF9zF0CE38lH8fCN9vdgAgAofNoeJNfx73mb2xRr
         NbUWgwdlKAEhlINqy9mBT7qin/Q5dZ5lmph2ZXTCewt23kg0S5EHAmIDcUYJdnBXfQl3
         TEvk4NGG8MI8iuGJoLJpAB+s7JoEpp7QNT30vFtBF1Fp/6WCYpUCh+QtZ02VYI9/m0MB
         CM8iJokdfH5DgSHOaU0CL5FXW1xTIY2pt9W9J01q78yzJ7zcoPCwJ+lzki7eL/u09JIm
         RuJnSDn0bjcd0wjrVZUggyF2IfO96E16KYvmTpK1f6s/jOeZsGyabOhiuM/fJXcA0Pm0
         byxw==
X-Gm-Message-State: AOJu0YzGmkbb1wxzq2mRHxVWyFcPdOfq0zpasvGWGmLkblwWvI+OBEp7
	+nZCQ7tD5ctJpdL+yexa4CfJ3bqqQTJbbAM3CjJzo2aBPZL6Q9gyn1zVeIv0KMI=
X-Google-Smtp-Source: AGHT+IFhc+YiEEchmcEnwplLOB4LzpFRorv1csY8s/d98HoFZzUavjGEBrTgxsRrSSINY1ECFOPWKQ==
X-Received: by 2002:a19:770b:0:b0:518:9ce1:a5bb with SMTP id s11-20020a19770b000000b005189ce1a5bbmr221524lfc.54.1713384425537;
        Wed, 17 Apr 2024 13:07:05 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b00a524e3f2f9esm6128057ejd.98.2024.04.17.13.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:07:04 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 17 Apr 2024 22:06:59 +0200
Subject: [PATCH 1/2] iommu/qcom: Remove useless forward definition
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-topic-qcom_iommu-v1-1-fabe55b3b7b3@linaro.org>
References: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
In-Reply-To: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713384421; l=1236;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=K0ao8Vo7sPBfbnwTda3s2I9W96Cl7inckQMbp1qX6wI=;
 b=6cYUGa8Goag8a2aUNA1eqwMKeX2FK4TOEyCqJmO8C5udyr+6wz+22OMrZWc39n6z6JZ4MLaC1
 WxHuDRgmVY8DzAUtW9uZqmUkiiUQkzrtSPCIaYsmHLZi8HP7Tni0oxk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Simply move code around.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index e079bb7a993e..3dca9293c509 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -41,7 +41,14 @@ enum qcom_iommu_clk {
 	CLK_NUM,
 };
 
-struct qcom_iommu_ctx;
+struct qcom_iommu_ctx {
+	struct device		*dev;
+	void __iomem		*base;
+	bool			 secure_init;
+	bool			 secured_ctx;
+	u8			 asid;      /* asid and ctx bank # are 1:1 */
+	struct iommu_domain	*domain;
+};
 
 struct qcom_iommu_dev {
 	/* IOMMU core code handle */
@@ -54,15 +61,6 @@ struct qcom_iommu_dev {
 	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
 };
 
-struct qcom_iommu_ctx {
-	struct device		*dev;
-	void __iomem		*base;
-	bool			 secure_init;
-	bool			 secured_ctx;
-	u8			 asid;      /* asid and ctx bank # are 1:1 */
-	struct iommu_domain	*domain;
-};
-
 struct qcom_iommu_domain {
 	struct io_pgtable_ops	*pgtbl_ops;
 	spinlock_t		 pgtbl_lock;

-- 
2.44.0

