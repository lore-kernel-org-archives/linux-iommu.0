Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073D258EE9
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278875; cv=none; b=K0SkrRP5iGW9TaNaGJZWZpYYEm2E2LFQrP4QMdIBjTocNcKnPmw8x6UqeIzf7rUSSPvZN0Fyj02+e/x9ykwZfIpW/UosyK6Deh+rXi87IgjgAbqS8vgnMd63ChGdMnVjE3z5tUO9tNIN4Sms2jnqa4N1uEugX/d3NRML9BcgaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278875; c=relaxed/simple;
	bh=CTSVd/0edKxTFOAN7N2IneJxadcZY86l85ROlQLsf6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5tiC1AlwUo6G+QkrEm0dRXOP/crYAJIkhcInuwGpbrS218kNHZcWJpP9ZnhVigsSbWo8nb0SubNB69chn3dAUjbdUo751Us0PZBcRkDFmtYeJPwgN3DHppmlmbWgcJ0UIDgR5DmiuKLr4xuysQTBPz5fB4JvzFKyilxOGWqGQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx1g4CA6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx1g4CA6"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47d6c634f45so422145f8f.3
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278867; x=1783883667; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOJQZsuitJv3y9s8sz3fzgy77bgdsy3S43prspkqpPY=;
        b=Hx1g4CA67SjQYHzJgpuHh99p2IoBxUS/zSa6xLQLb/RHtFgTgx5EFmdEf5pDMzwXL7
         EYNWcQTIKWQbe6l3U1syrK9zl6SOpXG9vLUQGS4ksIjWimoPOQZKI1OFO+o0pF9s1nJ+
         NYYpSB3Og4nTISxzuANAaKL6VsVGM/5rDwBMmxuF+MVH/VmxZYBphpYNubvZXEp9UHlZ
         o1yNKOBaYdI2HSuzIigJEPYznwo+oSNXIoaPDqv3EUNnpB64uuZxWEMnU8D96pZBnD8w
         AJLuBHN039/5RYS4UxAyTdt7kCyBKqd8qvj2EjfTxP0XpHUjCAHz73rrYXIKRfLUTHJV
         y/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278867; x=1783883667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FOJQZsuitJv3y9s8sz3fzgy77bgdsy3S43prspkqpPY=;
        b=QcLab7MrfP0yorTDPQ1OUqE7sBlQb1ifa1oZ1qXbYVPv9EqtxFkBk1F8ggfNaP3Y0I
         no5P81rMOP43C+66Rq7ntKv4MxwxDHY53aNqjme+vJ5ysoSlw+rC07zYBLqd7nTvwu8a
         w3P9LSOp5AHpiyFuy8Km2OmPOwReU/dMHc0ADzCsBec78nUWtcXo8zfZJrH1wpeosXPO
         jfOx4HF3m0NOE20ofB6kr0f0v15/oHn/o4kzm/MQOKcyeknap+Of4vPYmBLqG49xCMPg
         X4JcvvJHW5Ostp2Dbgeww7e2pbpoRPlcL1ycsgccZe+mavw22F4s8lJaGfxVAdf4IPGi
         jclQ==
X-Gm-Message-State: AOJu0YwDWlxPj7DA7yztcNVKmeqebJFXhW+VqPNdcs6SYpjr2aVUKU1f
	5s8ow0xBpzJrzrDxM9CKqp88Anm6HG1jEaMJZYYEx0+oJ81Rt4lGz1w=
X-Gm-Gg: AfdE7cmbAwNTTOJBpW6OakqY3gd9j/jRogDX+BhGryUaYU2Bqjc5qNx0XFTvUAZqNJf
	QC5AVdXw5MM1xRl53h0wVQO/G+DOLm0t4ATaER8azWMU8pdcqC4OaSYIF1Lmxo2gUjZ8URQQEKe
	WkA2R/um88+lWAafif0XGt+KFp+EisaUFaY9JaQ6YD0yWXw2l67RxlORHHQZTD4QbXyD0sKqxif
	BCg/ViaqCTRFjPGkq2B5glR/2xhH8a1E5rXkhh28QsVpuleLt6Xp8pRiX/GHbPTaIG+VWvECMeH
	uynQ77QR6KMgBvFATOtQHFFKUESRqnItatkcqhKW6BM2/RSKjbzSWLJ7sbd46D2pRwA7ENb1k92
	0Ap+0gQEifbxNE4lJB8xXxWsfIyrSCFVVblffSwTgDnybxvPw5wkHGjE/YLlL9AiV+zdaBzlIWJ
	vbjRmyQBRYY2dLvvOcI+sjWiYCtBOWbQ==
X-Received: by 2002:a05:6000:2689:b0:477:6874:542c with SMTP id ffacd0b85a97d-47aab487abdmr8336510f8f.22.1783278867370;
        Sun, 05 Jul 2026 12:14:27 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:27 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:41 +0200
Subject: [PATCH RFC 07/13] iommu: arm-smmu-qcom: Fixed mapping between sid
 and cb for gpu and lpac
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-7-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=1792;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=CTSVd/0edKxTFOAN7N2IneJxadcZY86l85ROlQLsf6k=;
 b=N1CzOkGooWs0D7hEFfO64qs+XczQExJuyhhzPJnlf0WwJlRgmpU6QS/Q3PibSJHKmN1K6WJPv
 WALfNWTwDnSBfYHo0sDNPhrc2jlfRyjKisM+ctCA7C/dwWocYLjvP6b
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

We want to map context bank 0 to SID 0 and context bank 1 to SID 1 as it
makes it simpler to deal with.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ae6152bddf8f..e605a535f328 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -225,6 +225,25 @@ static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_addr_t page_a
 #define QCOM_ADRENO_SMMU_GPU_SID 0
 #define QCOM_ADRENO_SMMU_LPAC_SID 1
 
+static bool qcom_adreno_smmu_is_lpac_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	int i;
+
+	/*
+	 * The GPU will always use SID 0 so that is a handy way to uniquely
+	 * identify it and configure it for per-instance pagetables
+	 */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
+
+		if (sid == QCOM_ADRENO_SMMU_LPAC_SID)
+			return true;
+	}
+
+	return false;
+}
+
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -312,13 +331,12 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 	 * switch pagetables
 	 */
 	if (qcom_adreno_smmu_is_gpu_device(dev)) {
-		start = 0;
-		count = 2;
+		start = !!qcom_adreno_smmu_is_lpac_device(dev);
+		count = start + 1;
 	} else {
 		start = 2;
 		count = smmu->num_context_banks;
 	}
-
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
 }
 

-- 
2.54.0

