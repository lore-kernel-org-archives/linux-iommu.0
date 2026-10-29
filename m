Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282012;
	b=b9lJ30FZPmcQ7FZOslX24U7BrBI4t9TQVSXW7FEUcPfdpawSWen5kO8RU9dkBNe0m/0z
	 kcWlXXT0NPysQGO9G64oLUoZqA20kAON8BkVfahubVxhlE8NaqIXaJfglzvBBJvqZqy6H
	 K8vIzHKITdm6+kbYqJ0cwg5OIatWMiiK2nSeJ3SHG12yKshAfq4SrRmkQEoOvbDPYXIwQ
	 vHMCBaNTsiYHxAtlVd4+ViYlx9Sfwd5zqxBJpa7s73ZL5Rn09hUNoeNSSYO6ME027c391
	 E0mTEMjMV7yxxXwE3yaFPiXPXug1fCL7QuUrEeIQpJsfXlC3g+IcPbjAAT3AxvjMONw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=oLv91LE6Hr8ep188oveO3sPSclyk8z8F6MAQFei+jPI=;
	b=YgJ4AQVvwIYmPrCxzRFU6y+AC7CNFarjZ0zwYo6Hu8kg31iq/viQ6TUn0PSeWHHbh6iI
	 R7XxyCb6dXplpvHdWzziPHoWyOaVRlsHbLHjmbv0zuFzkmTPo9ZTsUSsT1Z9xRAdssgui
	 K2E2MNmdrzIcQ+PaLPstv+Q8duKqjSIYlfhsfbilg74w+b0sQlxCPfQlQ4EmWXbyyZqKt
	 PjJ5JR2F7ez+EItXfoVxdlJuR3fK+tHIi0nUPF7tIR7lYXjtB/TYNGJvCff/zzUTCStJV
	 j7Q4r1CdjbqkwqoRigB73pfCWpAm/25BR7PUOKS6IUnidTNKdGKQQeRR/2s6hW9gS5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJ2l3jPm;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C4560A6F60
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C4560A6F60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJ2l3jPm
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e4831c028so1779517f8f.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793282010; x=1793886810; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLv91LE6Hr8ep188oveO3sPSclyk8z8F6MAQFei+jPI=;
        b=cJ2l3jPm/VmhvoSGeA6Igicio820Jn3RQ3/cVh/qZq9+EUdeZaTKQJhpREiG3Vg+/g
         bQMKwL9j/K4PNWDJf04kFDxHqwBY4yXF2Fk+WqXb5ydKEQhco/HH17OTlQbc/WXxpp9E
         ijgPDMP619Uhmf36domGJEtTB8XJC+BTYa2oHFFmollXRmaL65gcSrB/oVpJ5KGtF8+T
         LG5ILPrE1576tFCKfTTIDF/RWUxtSE7UIIsFYr3gGQpMANzct6OjbuPl0oB8+ty6RMOx
         UJw2wEzC5Vgt5eZR8A4MR04l2Pk04qxU/bcPHGeb1QM7ZUG2WiV1Zrq8+22eeSwWC0TO
         MA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282010; x=1793886810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLv91LE6Hr8ep188oveO3sPSclyk8z8F6MAQFei+jPI=;
        b=xpQBgkYWWrO7f6NidCD+KcAIkKOPq8LuEKpyAxvQIh2aSIjkPCCAxIUMquChJWr1F8
         GH0bKzvFWSX9xvpyhMNfMGRrpp+IAhmgOIgJYlVsYsoG13J28S/uV/avAVyG/uKMYmB2
         L5IXPDGNdjCQB44tSIsGO+CmSxOxa/CQCdWBOks7ukicstzL/RbxdKxrZXTBI6M8XxjQ
         hBOyvsZSB8Bu0G39p0heI6rzV/6Vq+vCTRDQAtMDxa4jEBSiWZ+kG7JZMI9olGdaOkjK
         SI6jMGPz+JtmDd4i4eqTbZe0a5RkkJnDC/ngPqPCHRyRmjHdjl0kX4Z8sX2RIUmi0BRM
         A45g==
X-Gm-Message-State: AFq9FYIEaPaZksJ9BrLnYqih7Kbc54rE8s3bYKsLkwfRD0aFHaYc5ogA
	q7rT55ZE/zKvBbjvoFtPr86aPZjCA4VYnk8+NmfUSm/YrCSOIm65TS4=
X-Gm-Gg: AYBFou19iEQTgMD8EelVYpeo261VmB2mFIEpKPlmM0Zz2S0CcXo7QlXCu47cv/AAMEd
	cZJwOAWXfay5DngIYOVsZhemNh40WTKe5cpOFMJQwdUtl5vAq+qo4opjJWM8KsHQ/ZypfHaA78G
	1Yd9PKEkg/JngqIAkiazVXuC4OGyYBvFM7t6tAc7200wr3pC8pAsg34sQEMS6iN/WoSAHoGg/2q
	8TCUqzOgWrgyxfR8LOo8h3TdINCXhsMHqdAYYDsgRR63/PuPlFmIw4u36mFHZ/bSWM4f6a3/En0
	JHJC7Su/6kpH5arnSxlWhi5fAYzipz5sMYd5Bl7XjN13H71pHm1DK1AenLvkN6TEX/Qi/mSAgC6
	cGL9G3wDv0A3eDj+XRzIsJo/Tdb4m3y6x88JwmmpVTwWTPwmBDjC9giJKkxqbxBM2pqZ/9NHnAZ
	hj28xEbtP1du0KyGJi1Zf3psWccaUleyxgPj/Lj5sa5Wq4GfvtshXo7ylkCRTX36XVBB+cnB3kd
	EUYT6Ns617HlY86nxogCaLmTFAzLBt81UQSMQdLvooMP3jjxj+3P6ASqTww5zTifP9OUcc1hO+z
	tFbnSh7vBuo59m9w6B0R9hb0zELAvm70LIAGXTlvytIOsw==
X-Received: by 2002:a5d:5e03:0:b0:48a:f354:aefe with SMTP id ffacd0b85a97d-48e5d468159mr13722390f8f.39.1793282010340;
        Thu, 29 Oct 2026 06:53:30 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:29 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:48 +0100
Subject: [PATCH RFC v2 11/14] drm/msm: set ctxbank and asid based on ring
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
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-11-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=1658;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=JeZ/oDOWBrzzXnhSTsaX5dWsSADptm5HwF/DPV1Xv4k=;
 b=4M7VMbDwjOepIjZPrdycOsvEBkNuot2Ltb1yMKAeV6IZ8onsZj759zJ8VBrGw6EwZ2ETpsOXr
 1DglU23L6d5AIGkk239c64rud6FZXnrAbBlSSiEjCojZ/rkF2k76XQ0
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

qcom-arm-smmu always maps asid and ctxbank 1:1 and lpac is always 1

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e82d0c0bc10f..57fc4035a753 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -247,7 +247,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	phys_addr_t ttbr;
 	bool is_lpac = ring == a6xx_gpu->base.base.lpac_rb;
-	u32 asid;
+	u32 asid, ctxbank;
 	u64 memptr = rbmemptr(ring, ttbr0);
 
 	if (ctx->seqno == ring->cur_ctx_seqno)
@@ -256,6 +256,9 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	if (msm_iommu_pagetable_params(to_msm_vm(vm)->mmu, &ttbr, &asid))
 		return;
 
+	/* qcom-arm-smmu always maps asid and ctxbank 1:1 */
+	ctxbank = asid = is_lpac;
+
 	if (adreno_gpu->info->family >= ADRENO_7XX_GEN1) {
 		/* Wait for previous submit to complete before continuing: */
 		OUT_PKT7(ring, CP_WAIT_TIMESTAMP, 4);
@@ -313,7 +316,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		CP_SMMU_TABLE_UPDATE_1_TTBR0_HI(upper_32_bits(ttbr)) |
 		CP_SMMU_TABLE_UPDATE_1_ASID(asid));
 	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_2_CONTEXTIDR(0));
-	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_3_CONTEXTBANK(0));
+	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_3_CONTEXTBANK(ctxbank));
 
 	/*
 	 * Write the new TTBR0 to the memstore. This is good for debugging.

-- 
2.56.0

