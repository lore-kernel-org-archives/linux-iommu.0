Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF339EF0C
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278858; cv=none; b=U8ZnrinfPVP8Y7lwbtdWQP8DnFkR5GLzOkRk0a77NxZIV3+H7DGJpvPMLAKVmZv7U4A+2bPtItKCAgUquKQPy2j/WSbU3uyjNQ+mUpfYdtFn03BEdApH3GJYd9VDKRpnnzo+5q9/2taZCnaxdHqON+9Jdbw/aq9U/wwddU2WbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278858; c=relaxed/simple;
	bh=TOpopsFtZ1PPnGuz7Qdse1Rb2dSOsjvazts1+j2Qsuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZ7Lsq4upsC6XSCd5e4CERwlm5YToDOKb7xgWREAJVXuwMsI72k0ELYHkGMhzSEUbG8ZrrTmcWzmSoiT6iiX+EH3hQvJN3Lzkpgvb5FTuTUMIwD1dtWP2wDfGmd725AsWEuoNmHqhQjCpW6OHUdRt6Rpd/pHcarQk6BZbOpPL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBJ0jYdH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBJ0jYdH"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so4502505e9.2
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278855; x=1783883655; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3eyPuG/7N0ePFJ/qBb/yJdx1/OQTbqvhMmqlXZb7jM=;
        b=FBJ0jYdHArR2Ow+FMwN6UsrG/aCZiwRogagudNmz0uppzXIUjXugSRYk5V35+JEHLQ
         oS1opdtlqWiSJ4z2hIMZnA01k7MAQSwjAZdz3FsjZrky4x1G6tXWITQHDksEI3mXp8d1
         mDp/oeYYIOXBeRQkncNC7YWNMsuvaU0T+C9CR39pKHldad/wlAIYbmHT5COW9pvitARB
         NRNr6zIE+KEWEhl1FlACbYzW4iwWRPMysBuO315S6NU4kPMN3Drg+tufJc2LGMAxpjoo
         HTmYcj8SiGRbRfmzkevVe0L+oCBj6qlQSncI0JcgkEADfOAnzrfWgYCaovpGZ6NjTDPC
         Y1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278855; x=1783883655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G3eyPuG/7N0ePFJ/qBb/yJdx1/OQTbqvhMmqlXZb7jM=;
        b=poNxb3aQM+wMirTIWVJRkuaDMHlu/xKvF732PfGT9jIDTS/rRpVvGcleJ4dsSXWnCC
         DowiVCm+P2lmLaTSrUX//yPS7CqRp2p49bTYE3Ij8eivuAHWAFjYV+ABMxbTrfaAz4j2
         8wmvGzkM46QjnqOT8NP/1OhKl2X6FPTvK/g5NptKYYIlv60Za8WhIc5kw+XrLIKqWfgg
         ovkLk26baSTyu20nhSI4Rs01tFv3b2M+j+0BXtznlbdkVeXRKrInjigBU2xFm+mi/Y+5
         fVYVmgaZ+21bWaBMaLYV2b/THpbZwNNjjhVPd26ApbuUvEr48dV68eL8NuhNDZAPQne0
         eD7g==
X-Gm-Message-State: AOJu0YwQ47je8bjnT6W8VZNvBHML9y4U7vnE/BE33ih7RTLVS7Mm7YmL
	MHX3GvDXGCvy/iGwhnVbUQWXZl2n5/d6htMcXWhSPKzyXznGEfCXt5Q=
X-Gm-Gg: AfdE7clKFzqzJnTXptOKBNTIUktpyjzdZpjWM5cU2YXpmmK8T4g93cC5VXE0F/1sMiW
	wa8HjZjNYKAOod8FQVi027RkfGD6I//CS0m+MWMyQj6xtcw/tnAxajE/XTAEL6wZ+y9kG7h9CEa
	p25qqkFDOyzoiduCh1y/HF7d3FA6yFyRzUay4dhXPx16Yteqv/ZvjaiHOTu8/Va9B6iPN9rgs+k
	yPOeLI2E8SkCz77jxz9GeNsySLcCd/2xrTI7XTlbXK+UM5YVuUvFU/6S8PP85SKdLveUY35ORS9
	fyWYD1wCEXKUZQI4SHhaSJssV625OgLccQxJocfwA3sfjRhJ4l8BQQcBnmOW3sdstkJb1sBy2n5
	zZvv+vPBc2xgt713aWK+skRZaNHwcWirFfYQi5zfNcssK3CQ/eCgy72APjkPATnkwIhVamVBKz7
	z3wYFJII3VgwuCM2pGTKp1hYql7U0TO1ZILcrFzVZG
X-Received: by 2002:a05:600c:628f:b0:493:bf84:53d8 with SMTP id 5b1f17b1804b1-493d11d7d55mr92320425e9.9.1783278855325;
        Sun, 05 Jul 2026 12:14:15 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:14 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:35 +0200
Subject: [PATCH RFC 01/13] iommu: arm-smmu-qcom: Configure lpac device with
 split address space
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-1-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=2198;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=TOpopsFtZ1PPnGuz7Qdse1Rb2dSOsjvazts1+j2Qsuk=;
 b=swnPSg6jJwnfwPpO2lUtsliGm7jHo9gqL51QEmCML+oAIm1zPDuCFHYdt3TNVGcjeXVx38cVC
 13fGjbA8BMDAB0TZwyRx8GCJenaSAUzrSU2r89a5X2KYaRbtynBvrSe
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

We want the context bank used by LPAC to use split address space just
like GFX.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index edd41b5a3b6a..48a590aaeb5e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -35,6 +35,8 @@
 static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
 	{ .compatible = "qcom,adreno",
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
+	{ .compatible = "qcom,lpac",
+			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,adreno-gmu",
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,adreno-smmu",
@@ -217,6 +219,7 @@ static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_addr_t page_a
 }
 
 #define QCOM_ADRENO_SMMU_GPU_SID 0
+#define QCOM_ADRENO_SMMU_LPAC_SID 1
 
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 {
@@ -230,7 +233,8 @@ static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 	for (i = 0; i < fwspec->num_ids; i++) {
 		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
 
-		if (sid == QCOM_ADRENO_SMMU_GPU_SID)
+		if (sid == QCOM_ADRENO_SMMU_GPU_SID ||
+		    sid == QCOM_ADRENO_SMMU_LPAC_SID)
 			return true;
 	}
 
@@ -305,9 +309,9 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 	 */
 	if (qcom_adreno_smmu_is_gpu_device(dev)) {
 		start = 0;
-		count = 1;
+		count = 2;
 	} else {
-		start = 1;
+		start = 2;
 		count = smmu->num_context_banks;
 	}
 
@@ -394,6 +398,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,lpac" },
 	{ .compatible = "qcom,adreno-gmu" },
 	{ .compatible = "qcom,glymur-mdss" },
 	{ .compatible = "qcom,mdp4" },

-- 
2.54.0

