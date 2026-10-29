Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281997;
	b=Bg42calFKPhHWwz2fqEY4JrwlJrTD3j0x3Sa9t2MZXTkScei8zd8s1gqd283aS3yGac2
	 6U41/DxetCam6F6JRILYe32AfcM1MJ2iPG8Hrt2ewRRfhl9lluy5qg7c9MvESUhtixoxn
	 q1v43wSVWI6EXYm/QAZGsvrxwY8EZMm/sxZienaSAq+dpdqB5S0byNwEbP6cZLt/QTswL
	 KDL4Xxkf6rTvUV9rrdtO9IzSI8f9aDrBkL++rhl2LoTCwzD8s07g5uU1sm/gw4Hf628LL
	 ODfZqahiy2kERFKb55+IT6U/xxISLIf6Rtisfu/82ewr1s6O2dJgFacpHCUaCbPbCKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=WpY7be90G/SGk1dVlALZpqn7ki65kr0ccX4qFPemUo8=;
	b=KntjaZukBwzpcCHujOLNYhBoe/fQUPVHs+gQCi9EUMxmwSWWxN8wcnoPAcl11Ar9+YDR
	 U1pSljivkvVZzcKFkLsGS2UXlj4/ofuwnKtdsiQ8h554vzhK8bt/BC2ru5McO1BBbmegM
	 tGIM4HIZMozUugg9z81tJ2xl0tpFMVKZjoX+f/5ZHCoqFt8hNDEq3tDQqGmSAs01EkiZZ
	 222EsBvkG/ls74JqNUrP+MoDwKL2h3RwyzZGaJx3eYCyI3GLrqplCedgOVmSjuF+acmro
	 amNUrM1ce/FJ7cJjd7ZJnQGJ5KoMhKAU/hJ1cyKfH2fdljZ03eBSJRa5nR7IwvuuIWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYHaqXR6;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24719606A33C
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24719606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYHaqXR6
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df54150dfso1214098f8f.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793281994; x=1793886794; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WpY7be90G/SGk1dVlALZpqn7ki65kr0ccX4qFPemUo8=;
        b=eYHaqXR6Rl5s1zb1/bpOsj02IhCqTxh7HSyy0ii92UHqA+O+XPqCTfE61ChlMaqfpQ
         N5flaC8W2yli72c/UOCiYOqpR5wKhvbQ9cr2YbTaIaG9cWIOn5MwRioiMvPHch1Ssgop
         E9y1k7jCHhLOXOdLuQwU9GEiCBySglS7epQ+NnVmB5TxtP45UpgPRZCf1G84xwBRDXnl
         0wPTU//M11a4WlT32VBNRvyS7wblHUYKLaWoKpm11UiNH4HKi740r++7yn3B3MxhNLkQ
         0mRwdLZEYCK10e3qKNLyIBOtdZyvsK1rVosIyINO5MJV3ndSj30oX4hkstJCiOitNb4w
         G9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281994; x=1793886794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpY7be90G/SGk1dVlALZpqn7ki65kr0ccX4qFPemUo8=;
        b=DF1isPA95P4MLXRDhg1Ff5TBxutkh4cdLe8E2uV7PlO8VIaBt3BYqyjXD8TEptfHmj
         oYun2rW02JZH4XeNwEu6C2+iH4aY8nfaN85FaQK6tU8sot3/BmByrcLDDMqqSBHNbR7A
         rWxahEOl2iiwldyKMLGcfV0UFRDUiwRTvk1GBwJFbwHGVKqsHqm/c71Ze2MNF0OWEvCX
         Q+qnOqS1lytkv7gKLrmhMKkIlFEpm+7ww8nVx+9tRhgcvQpJU1EdV6jQSgn6mLfYTVko
         awHCwuoBV1pZ6ZUGEUU5TKwop3p2b2i6+eoMo6PVbPE925DIkmJMTgu6rAoT9SR+r0AK
         FNMA==
X-Gm-Message-State: AFq9FYIim06RuMWrCDUncDz1ktsRY/5ae580fuCKa5Q3qHi5Y6KTH9qe
	r8TnUcBTwCH2Ki1gh/WoVEK2l9kucduTDXHUMVbQGnsbvNfNpIWPSeE=
X-Gm-Gg: AYBFou1MJhafF5ie2hix9TGseU8Hm6PP9Nn0Y2cCX3VElMjiWRQmlrF6A6/j+2KaXww
	C7mkaja0N93MeiiOzSYgRvL6qr/QZdBm8sCTN+YzfcipdQZ8sB4sgFH1XflUqwTofCEm/3TniGh
	Ge/YfcNN7MM5+7LswW0QrHaw3MiIf2GSuRzqdIAWhHmHjgjm7eYeBkSlsw2nTXzx2CFUYs7bYQw
	R4NoGWBuIBQZdHPZsTLQOIG/hKJmlK1PQkdfTsjsrB8/AtWKvYP0CyP05fPcOgyZCuWYfGWx/2N
	i1QGqhtZx0oDHqLUlWRmXPyyeQ+Du8Vcc0KPqShOKYLsLSo4BivKYghN5NZATWNoTVtdmOWEuke
	QcceUAEFLz6eNIboEIyss//RKz5xVeiDMxxd67FsvJFDQPqUqonh3o7NDe4fr6Qi2CIxaAqkXuX
	ZdmDcKxhfyuLrADRT3DGCsu/pdM+/Wj0urOWOtFAmqEnFkjjKLdA98ZwCCR58eK4hcd+I0tHr52
	kqGS+xNMAtUS0lppFjZ+55vYIcWf5NNlCeJnw1ojqr3GOutzVFmn+/3MpiOdgdgd1Zw9MKn+EKp
	/wmr29euCEHk5p9nILoKHN1IrHQdRzy2S4/HFUV8ivMVdQ==
X-Received: by 2002:a05:6000:4715:b0:48d:f383:2356 with SMTP id ffacd0b85a97d-48e5d5d16afmr13493554f8f.53.1793281994421;
        Thu, 29 Oct 2026 06:53:14 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:13 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:43 +0100
Subject: [PATCH RFC v2 06/14] DEBUGGING: print contextbank and other ttbrs
 on fault
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
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-6-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=2450;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=dH+it9hPPDLJzOx0q/+eo2IfgBzUDyQPf1+n9ilF6yo=;
 b=rSQ/TIKRIiV2aSX7/+jAtk7J1jcL0JxB8zRWLfn1sl11ELATT02XD6e/9sRnBZS+9corw6Stl
 Oo1uS/fWy8LCZ5C5THVWfEq4MkKG8/9Q7VkA0Io7j8QvOp628/2VM06
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Faults can now come from different context banks so print that
information as well.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 4 ++--
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++++
 include/linux/adreno-smmu-priv.h           | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 65d34d0cfc38..4389559e1d17 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -329,8 +329,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 	else if (info->fsr & ARM_SMMU_FSR_EF)
 		type = "EXTERNAL";
 
-	pr_warn_ratelimited("*** gpu fault: ttbr0=%.16llx iova=%.16lx dir=%s type=%s source=%s (%u,%u,%u,%u)\n",
-			info->ttbr0, iova,
+	pr_warn_ratelimited("*** gpu fault: cb=%d ttbr0=%.16llx cb0_ttbr0=%.16llx cb1_ttbr0=%.16llx iova=%.16lx dir=%s type=%s source=%s (%u,%u,%u,%u)\n",
+			info->contextbank, info->ttbr0, info->cb0_ttbr0, info->cb1_ttbr0, iova,
 			flags & IOMMU_FAULT_WRITE ? "WRITE" : "READ",
 			type, block,
 			scratch[0], scratch[1], scratch[2], scratch[3]);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 48a590aaeb5e..ae6152bddf8f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -136,6 +136,10 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
 	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
 	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
 	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
+	info->contextbank = cfg->cbndx;
+
+	info->cb0_ttbr0 = arm_smmu_cb_readq(smmu, 0, ARM_SMMU_CB_TTBR0);
+	info->cb1_ttbr0 = arm_smmu_cb_readq(smmu, 1, ARM_SMMU_CB_TTBR0);
 }
 
 static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index d83c9175828f..5d6de4b4de06 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -32,6 +32,8 @@ struct adreno_smmu_fault_info {
 	u32 fsynr0;
 	u32 fsynr1;
 	u32 cbfrsynra;
+	u32 contextbank;
+	u64 cb0_ttbr0, cb1_ttbr0;
 };
 
 /**

-- 
2.56.0

