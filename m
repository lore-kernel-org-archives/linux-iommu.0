Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281999;
	b=NlN6GAWXnmeAwUaD3IprNFCC/l+iusnCBkkGUHzBW1wK0dTJRlDL6elxf6ygfqrNxs38
	 FHSTagptkbssLRi2T1IxNBE+woy5rFV/kzCTIMmuy9fyTpFPqZGiiIm9B9b2q017OV58k
	 6OmbQgxEUc6Mz6MsPmfD3xMwCbZesHJ/ZjUUK2OqNKi15aZb0X/4wpftGW1LFL5n9LhfV
	 O8syEQ/i8Vau7iA7v2QVTupG7lJZnptecTbEzvYOjemcBV35unYxtpHraecM1QCXjuQMm
	 HWDkoyDRBdOL8/tOfepoi+O65hjE/FWGXP4YSo6xZvlIYh+q4WWi1QwQk/Gx2f1WRkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=rFW0YNxgIXO3yK9W7NnNeF63YsxO45UeDwCNLoLZDXE=;
	b=hk/vUmm0tH5sSeAf6O7vEFUQfjl3z7pngYGXzmZyHOeGiaFPkJ91B+Pgg0FEKpsQva82
	 3ADz3WvKkcS5cGe58IllrU5UtMqC0bctwy4d2YScXZ1k8gaVN2tMRF6O+6eZF8bw3+Bl/
	 D2LT35R5s9F5EL8W5SEG/ZEtB0tfl+lMAyOJLoLhklXhlF0Nwk+2bVyXTlc+UOcZrvdw1
	 nAJsAYbRYU0kR7V3/CjxxcfzjkgKuSF7BxNllSSr98JIVTKTe/QZTprnENY3vx4KPxv4X
	 D2FBPq6lyrRIUq9g9wP1W030RkrKslsqG4Bxi9xoTRRF8Ig/K4nKzLAUQO4CUQBfizQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aksoyN1K;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FAB60A3836
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6FAB60A3836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aksoyN1K
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e0d1da913so523149f8f.1
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793281997; x=1793886797; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFW0YNxgIXO3yK9W7NnNeF63YsxO45UeDwCNLoLZDXE=;
        b=aksoyN1KICBwhiRYsSGGQnT7tIqY53eRKBrD8aukdJRK67i7/KQMIyLYF9zFDnwRGb
         TbWI7hk9acQ8ETthqSGyOvt5W96OWK9HLg8i9cuRd7+i2t+kHyy9zD0A16u6tsmF9Bxr
         0xtZRaQM8Ox/+Z7WPAEZ6NS4/2tkOzaIP5eUG7Pm78bBKf9caZW95k6NM8AAkJ6PCLZg
         2WORt8WV8BJ9ePqbueIVUVDXdeygI09HZ97+3/hAwTrzTtNXQvodbQ8ycrKfEjE12xV1
         Y8KiFZ6KmOxQ/bRkaP5BmNtJAisb/crvTJupoDUdBJ0+zIZoPwsV1a/dSVGJXJemawwX
         Rq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281997; x=1793886797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFW0YNxgIXO3yK9W7NnNeF63YsxO45UeDwCNLoLZDXE=;
        b=EmcpZwE9NNINSm6scKwUm5WOmtMJRytzV78hx4vI6x7YS1rpobOwTws3nP556sG9nd
         hmZUawg4jg2zEcxnTHtn3YyxwxFLY0cl0BAsfu7CTsuKWKUQmA3rJaRfduPBbsg2KMGX
         ypaAu1uoLsRKA9CFekjGV0w52D3DIKwYPZKwGe3S+/j35b7V19sIqu8JsOIHefjoFaMr
         lD1E0dp56OA9X9rRh9cy2O2EVawUPr/Fcm0zdLoXG0ZgBXeLLuXR5dIKMxmKGbZAG1WJ
         qK6+UYs3tfoLmksBr5GKcw1VD/wKa430eyKoWoooBDLXlTEjRLw5fzHo4//jzqJwycyD
         qPOw==
X-Gm-Message-State: AFq9FYI9c4Y3kvYKLx9BDS+6TvEsnU+llFJJOmJHHdoGjkpnjx2chvpn
	AfCYTev12KfCXIUoDi+ILnfq5uWepStCcAq0i2eX6kS+TaKfzDPcQok=
X-Gm-Gg: AYBFou03LFNANal5Q6Pm/DwvUXv6DgUlo59jecVS8xVmDWZqBlhVaPTxYfkmxjeVeCP
	j/QXOhNs+n3EvI5f+niCs0XtH5LjOSaiF/M6BvQzW42gu6JxQuMaFnWaOH3bmB8MDQPuMhOb1SF
	8H0VpSYe6TOcg6Kmuhy6GaKxEJWKSRbNbRAfizCb9xjMl1SpMQk8X3KVtGA98ReAj0MD/6uaqHx
	oXW7BQf5sxNzqPBq6WnrXKwdet/BYe+izQxlp91NYQt8JYew9NceQxk/E1OKmcTKYuYoPYXh1in
	SZ7j3T584Mr/94By6V0Wg7HkOQQZwvGYQDC2HsT2WC0frB5mKKN8TSiQXMyHFmYTLHm5w0jYJp5
	45KLCvnSuuZu9ws/meOCwutfnrFl5veNyf7+9lAPHI87NG0FF3iDWVTTmajgsFD8YtkTrk6Qv0i
	rOcGeMnnBa/KQISHnhLN+hgLrqzmqc29AJn8IvMJdnyTpOwJ9WuwzlGsRNpXuL24e8iznFdTeJK
	LCY0+GjlhGIWxDxMkXFfrVTOfNNt1g3JuAOq8mHjCvwzom+XOD0GZmJutohusMK0aC3nMWeHQsf
	o3uNRTpZOTyhEOqNSxubO0jZ0ep8KFrjjozFUJhSZG4RXw==
X-Received: by 2002:a5d:5b91:0:b0:48e:60a7:e0bd with SMTP id ffacd0b85a97d-48e649933c7mr5094994f8f.17.1793281997067;
        Thu, 29 Oct 2026 06:53:17 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:15 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:44 +0100
Subject: [PATCH RFC v2 07/14] iommu: arm-smmu-qcom: Fixed mapping between
 sid and cb for gpu and lpac
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
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-7-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=2537;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=ddmhwqAVzi4UvZ7es6VT6qKlZqL0nH2dFG7G9BUrboU=;
 b=bSLxcYA1Hg7TlJKZ47oBfv1YRksocS8fOUT+GDiqsMJuS2PEP6fGuu8UQ7sr0kvqrRp2ErWZv
 hi5jOvHNIWgDaeJxu8pdrMCwt9FmVwlER2SJfgdk1R9+hQIkj2UjR5Z
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

We want to map context bank 0 to SID 0 and context bank 1 to SID 1 as it
makes it simpler to deal with.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 31 ++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ae6152bddf8f..9413b748e79d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -225,6 +225,24 @@ static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_addr_t page_a
 #define QCOM_ADRENO_SMMU_GPU_SID 0
 #define QCOM_ADRENO_SMMU_LPAC_SID 1
 
+static bool qcom_adreno_smmu_is_lpac_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	int i;
+
+	/*
+	 * LPAC will always use SID 1
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
@@ -237,8 +255,7 @@ static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 	for (i = 0; i < fwspec->num_ids; i++) {
 		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
 
-		if (sid == QCOM_ADRENO_SMMU_GPU_SID ||
-		    sid == QCOM_ADRENO_SMMU_LPAC_SID)
+		if (sid == QCOM_ADRENO_SMMU_GPU_SID)
 			return true;
 	}
 
@@ -313,12 +330,14 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 	 */
 	if (qcom_adreno_smmu_is_gpu_device(dev)) {
 		start = 0;
-		count = 2;
+		count = start + 1;
+	} else if (qcom_adreno_smmu_is_lpac_device(dev)) {
+		start = 1;
+		count = start + 1;
 	} else {
 		start = 2;
 		count = smmu->num_context_banks;
 	}
-
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
 }
 
@@ -363,8 +382,8 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	if (client_match)
 		qcom_smmu_set_actlr_dev(dev, smmu, cbndx, client_match);
 
-	/* Only enable split pagetables for the GPU device (SID 0) */
-	if (!qcom_adreno_smmu_is_gpu_device(dev))
+	/* Only enable split pagetables for the GPU and LPAC devices (SID 0 and 1) */
+	if (!qcom_adreno_smmu_is_gpu_device(dev) && !qcom_adreno_smmu_is_lpac_device(dev))
 		return 0;
 
 	/*

-- 
2.56.0

