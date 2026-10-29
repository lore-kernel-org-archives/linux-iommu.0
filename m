Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281984;
	b=ySOUjYzEQWZQ3UY02WD/5E/2SRUXuxn/Vzk0Z7AjZLRUbO6/Sbg3plSF410fdlaZmZ8C
	 lprX/gHGRsS/HauM5b8kKJ1zF7DnXW6tCr9k+WxUTIzZSte2e2ai0RFCM9OwI3zCUDpl9
	 b0V0HuZmKbvVwogdrMbD/igSJriz7mozqOqrDfy1kphMEcATIHz+aXmy12ODuhN0yFvsZ
	 xt0JXg7d0Y/ia71mgc7x+CY57gDZyCjKtiqITK38J0GYsKuqN4S+B3lkkHJGpk3Ju5XGU
	 EjF8VOhDMQAUQqiYqygQjrp2IDj0nPsFDtaAtLjpdBSkaNHPoriab1+BvuVP2bFi4mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Rr4i7xRJAxgPG+93hBg/VQGAgwo9yxXU9tfEwt3+0E8=;
	b=q/PyLMUiQWMUW/4+7BbvFvk2yPP0cMbfvUREyTXOvDM8rloZAsSzsi96585CQkrhUHMB
	 FVQ4914KrtDrrKTlDhB4fi3NTHyhxylBt/yunZNvWEGKulf+g6rlBA66QjcgEQbfOn9ny
	 7NCDugwlvIaOBn3UsoKDrlFx5+6e9LYniF41mOXzKW67hilgCpwFuA1zKfwUET/OKtu/X
	 PcPoG7/hW9KZRrPiM9oQFhgF0kwfyn7VYngHn/80P6t30f8bAuG8jVSYesk5g76bzzotI
	 fLTtClgN0DlYP4KE0CTTQ/Ni7FDsPLokbfm7TyBB3OCht2/hLdk0i4mRXCkAcs2YSfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EoGU9dgi;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8F606A338
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF8F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EoGU9dgi
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so16840285e9.3
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793281982; x=1793886782; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rr4i7xRJAxgPG+93hBg/VQGAgwo9yxXU9tfEwt3+0E8=;
        b=EoGU9dgi30xHRda2MOVwEalAF7ye0Z3X3+tLT8x22V7ml2sKMejR/aQh26n5+Bl9cH
         VFbUZpQVS/mULHwdXAEprBdmXNURblIWUbVA+81Z4bH6MAJngpcKJOHEhua2d3pkneUf
         toLWTAG390zqGBmDX3k+r3lo3J3CvPGzaKd9AoaPN1WaN0Db9N7ydCm+u6IpVAU/EREh
         TSkYcLDuAM4tYnR/MO4EAiVeFEE4KobHfX8HsxlC/paI8K4daPOH3f2wn8e9vWKQZRJL
         TryZ07QQno1ex9Lm58KTj+jfazqNrom58hSweAdjqL1TpzlIqRFc/hOZfyEE4RcMxU/6
         lezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281982; x=1793886782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rr4i7xRJAxgPG+93hBg/VQGAgwo9yxXU9tfEwt3+0E8=;
        b=It7s92KRukdaX1vLfEUaj6Tbscm6awpfbPbk8wvVuvnODe68KFd/Eny7H8zcGNCq4N
         hdX84OiN/CecedejBFrtVgQsGZ+m1lUTyj0Kt4sDdvKqv+cWiHiT8nTyMV8kes2qjzKT
         pzPNPpd0f/PWKwOrep018KfkAAAzzDjPAsdFJHbZoYtvl0QuGv30BZb9qt0fgKEVToIN
         JwqYEMevU07oWuS0kyNSCAOxbWiTk5N5Ldy8qPAEafvD+vIPEnbCAzB5JaXdnzhHnoqC
         GF9t10+ghH6YehX9I3/LA9C1//dnAkigS+yyBePIDfP1faWM/bwKwdY+r1oeV8mP+0H8
         v+CQ==
X-Gm-Message-State: AFq9FYIuCNNnnauSA/KpLluYcN932aHzy6VUSCXSWJHuAZHQqsOOANte
	spbvYab4w4SEvpn20Q1+sBerE755YqwRKSaoFQoebwf5u2S7HPU/2tc=
X-Gm-Gg: AYBFou1zFOfFpuwaLh3N4pWgTyCdt4YCMl3peeg1uRdTXOxJ64qDxpGAjwohJKSVpeO
	VzVRaGnxy1f/p9p5szRdSZzIaRCRjqEV1Yv6GG9EK1I4HjjhuaT5Q5Xg1Q8YXpQCgMoqwUh+NuT
	wve+iKT2YOAte4RtOeIGvng7PgP0bsmmh0hZIhFUxvliYowKUCGuCm7JvLuN9BokX1QTu5vSFx2
	7frUaZW0QBnjFmgglPoWXhZCYu7Rabo4JF689LAfco/dr1GvoSxHD0YP+LC9rOMLV3roj74qtPS
	tlMsg0JAC8aMRePzSALWXyrA3BtDlt0ROfXvVPrETFu2J1Gdhe2xvNCWRnVzHdFSTOs4JE5smVE
	SvbryUzIBy6VVh3BMnFdIAg3EzE9HDgnLN42rRlS2ZaQgCe1VWdf/oMT2rPZVi/2zS9SQMNHEXU
	mWiw0VTGlc4d4/XpTXMcaW/fEOcWUdtqAIwU5oLbsOpbTANo3B0Oe0UkA/9LNyhKgxodQoQATHW
	39+7gOwkjP5G5yAT0xt1r+gYF9D3/zBCuSucV9dwMP5c46RO6jz/2AlCjuXCXNkJw1KscnjKccs
	8Df8P2+0JoLOMCb9xFu0WFrcqPn+NIYukeZdOSaiID9nHA==
X-Received: by 2002:a05:600d:8496:20b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a96677324cmr86595655e9.16.1793281981611;
        Thu, 29 Oct 2026 06:53:01 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:01 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:38 +0100
Subject: [PATCH RFC v2 01/14] iommu: arm-smmu-qcom: Configure lpac device
 with split address space
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-1-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=2309;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=NJ73RVOWEiPlPH9Z7PnLGwHMRejJoPZBM69o25lxk5E=;
 b=gj8sBR9N8QG04JyrcmUt5R2oXuziVAr6kQLdSMm6i0TlFKl87Gop8V8EHKny6NTxmbotiGmJc
 fs65LYDtGd6Dd5piBIpN6ZzqbLECs9zGbUWlcBT96BceUkWcOkEDLhv
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

We want the context bank used by LPAC (Low Priority Async Compute) to
use split address space just like GFX in order to be able to handle
userspace submissions with per context page tables.

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
2.56.0

