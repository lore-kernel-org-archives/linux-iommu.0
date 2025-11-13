Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E0329E69
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076666; cv=none; b=BRGnlCLnDVhfAR1kaWIh7r0aiX5c1LosMV8VxjXFWAXxEZzRYm+ymtNUEkY2u+IqyEC1+pmdpThNg/66W9fyBzMgnyamytW4FcBaTdTgiq0hlqzYSI2NbQX8RFS3t7LAGppMO4t0i4x6geovQ/KsHbcEWYYdPs0DXyDC6u/9wMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076666; c=relaxed/simple;
	bh=LmTQ4+xDC9B28giqo/zBM4nUmBfK/nteJCrG82WwkZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kuJavdXKwFqzBfYTtuXgo/lJ77APTmIHKsgdYnituAx2pL3J+3F768spB0UxA4U0dL0uSxikt/XmqBmP1ZWt9JgOi9mJ1Vb+VdU6LIK623nyWFVJl9rBdZu0KnLNx7OghRJE8Qe7NnQ9btFrtoHdiGYAWRBA8YTVgeXgVyn9YLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mWnge/BI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G1v8Otc5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mWnge/BI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G1v8Otc5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMavJq1613139
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FLsirGP3CG3tM2mJ8jxgH5Xo99gAN80a30QteswCvs4=; b=mWnge/BINXTgpVop
	QmY3oETGJgsBKVvToy/EFLvftYXdGGwkd8srY+A3vcE1bbGGhStEL4ebDCZoSg0x
	sfz1JuHux0DaHFApyOo3ItUsToFgB71pim+czKNHdjXniSHiJoYX5p04c2gfky+B
	C6kTzQFzoF6vMmw73BXxkpSzDRBGvkYg0lTOq8Ujze2Rhy1nsWJg/iDlUh0/6h2o
	oqr38Frd7EgTgcOhPyw1PvECtC1ZS4wy6pX8nlf1mMZgLwU79uyO3umMLUC/STZ5
	uWFj/hth6gIv/uXYzAD3reXZyqeSzTF2ThqbgwmKjaYEjbp5LKNA+IC0etkoLLsF
	SJ/oSw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9h042h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:31:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bbcf3bd4c8fso1254622a12.0
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076662; x=1763681462; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLsirGP3CG3tM2mJ8jxgH5Xo99gAN80a30QteswCvs4=;
        b=G1v8Otc5tpL6RKw4R6J2autrRmMoZuBt1liJAsU184I36areUCyT9ywP0Evqpa6hTc
         YSSwd992rMOIMUba7GQVMMVJFH5iKPbKdz/f2JvDx7D57nOZMKE6ztnIMjeRmvNS9HPt
         Imqrc9IwBfjU9ZnFnt0l4Me+baldzdZU7JQVl/XTMHd6DeSgh9iMhBMFQTSIfG87z7O7
         FistbfO588tmNwxlMChq/HqHelXZz5L4jMJ7jU8//J/1dAjj42Rx7fCeaHzx/RX76UKK
         Tnk1XxSB/A/r0IGR3fDi+ES4QisHcPSES9/dWdDD/Mw0aF9q1Z7NuEAH9uWnDT96NWq1
         4pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076662; x=1763681462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLsirGP3CG3tM2mJ8jxgH5Xo99gAN80a30QteswCvs4=;
        b=xPjGjnRMPx8OVHxIqgQwb6zxu2p8i3ce1b7QgIy1Fxzc4ILrI5SsDaCHdpSnSKYEZx
         8k5jMvc7PjrhBNLDl0x5fuKDw/FL4CTdBqn/676sG0SwjpsGZLXGseR+DOmnBf7QPv2E
         NEnV+V4dUpZwlCACDe8mf4C4c4XB0nhCB/nf0TosyApsVwfWVQasjxwJ+ylT2y4VzLkx
         mYjSI+vdmv/jpEdCV8Vvt0aqtNDsqD36cF7cDNd/8aMaCY5L9byJ/3G8RJ3ChRDbgTkd
         tcbKD/sHG7k1mfDQu1hupSIcVsFZc9HsHKuuHYZHy01GIbnb/v11uNAr0oMZVH8ADtTG
         XOlA==
X-Forwarded-Encrypted: i=1; AJvYcCXOnLwsbthRUQ01yqGRe0bdIdSZJIpheFwl3NS9zod3a50i0D9UfalcXLuKAC0JXspaZPj/Zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuuP9rJ+1qTsDKlHzTxE4HlJntu9gx2vqfhT23uXqb0vhMEmaK
	zvglhcrYqbvLgpkxsof9shLXJAb61ei5okGey0fMyqCZFnC1DYl4SUSCWphCcJH9oCvgeaC/uVU
	GhGjxyqi6eEr9LsR5OPjfUdocS6wglUAhhEMAK3NRZojkahu5juqmlytP/w==
X-Gm-Gg: ASbGncvXy5l5Py4Pdk3fmwhP05Lvc+MsneYDTAEPy22osG3PxAnfm58dnENeErLjNH3
	ZY00C2ptXN/lNoFyCWojFCDtksb42tuOg1FbZMvszQIyz8Oxw6Pfs9HnfkOxjGmKBYCh8DyspV7
	0c4Bo11lxpE/2Gg3bltukzsdQah9J/7KGeJoaspzpDCNNzoa4U+aLraDJMI3/yoFL/AQyEcwTFv
	ogQRODVCsIckOcGEGSnKldyFVp3Hsh5XALFAJcQTTL3WxSCS16CvFTuvMBZUeftX2Jfm/lbu4R+
	y4gRoew7feS53ZMuqrC7nl9XLp043fvQ2/Q6KTcrtw2vNgwTrYEMmpWxu+ObDGr7suLe3eW3uTC
	V+xuEQaOes36GDBRufqrBnlw=
X-Received: by 2002:a05:6a21:6d83:b0:2b9:5bdc:8e28 with SMTP id adf61e73a8af0-35a516a9ffbmr6950646637.15.1763076661762;
        Thu, 13 Nov 2025 15:31:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeOO6Mo5faga/S1m7glc5wMiLxTxA7e6gRSTm1a1Cl3AJPoE7UBwKpjy+sOUCIyO1b2xfgcQ==
X-Received: by 2002:a05:6a21:6d83:b0:2b9:5bdc:8e28 with SMTP id adf61e73a8af0-35a516a9ffbmr6950577637.15.1763076660960;
        Thu, 13 Nov 2025 15:31:00 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:31:00 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 04:59:07 +0530
Subject: [PATCH v3 10/20] drm/msm/a8xx: Add support for A8x GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kaana-gpu-support-v3-10-92300c7ec8ff@oss.qualcomm.com>
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076574; l=18689;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=LmTQ4+xDC9B28giqo/zBM4nUmBfK/nteJCrG82WwkZU=;
 b=OtdVlDwjSXDIYKhWSNasxFR64vmFx69uYtZV7UL4mM4XKwVvZMQ6nMt+6w7zTEti5nyLYYR/K
 xkRnuOcv+b8BWZJwwVYgC+7nYNQL5kb6qGKzCfLZpHjst/5uXvkeV6x
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: nvWg1D43fq3nVzXy4j3hSYdG_vaQ6xFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX2P7VNdR88xXU
 TO3y2ZNvpAPQm102hKSyTwWw8mEKm2PNywOVM5HrXbPfoNnZXBR9XUu15M3siiCei16KfDG38cz
 DeW8cY/K0r4Hx3SP4mIfO2C5U/U2q9woq9LLLNOogeBzm31FAtEK2XsuAdqrM40vXc2qR/s9P/o
 ux4e8GyBjG+hkL3mMDlpMe/vQEHlzqiBmXX5mHEdP02qZ086QMxH04b5l88exO8GFFZJXUH0ZFI
 84YvT9qp4/8dop9m0MrB09t/8CgG4riVPTXufwz5j+1wNUrjJiljfjTmk2zi+ANgwbypo1FOVbU
 /7CcpTXLNpXLUnfJWP114iOVs+b/JIn8Mi5j4zUC5bDJ16QBlSEx8EbgbDM72Yzcs4ds90QmbxM
 nZuReApQvJvhoQCKZ1zAKYIzyz7mow==
X-Proofpoint-GUID: nvWg1D43fq3nVzXy4j3hSYdG_vaQ6xFK
X-Authority-Analysis: v=2.4 cv=V+1wEOni c=1 sm=1 tr=0 ts=69166a37 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=BnPpZdVtioYmAKrWMJ8A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130185

A8x GMU configuration are very similar to A7x. Unfortunately, there are
minor shuffling in the register offsets in the GMU CX register region.
Apart from that, there is a new HFI message support to pass table like
data. This patch adds support for  perf table using this new HFI
message.

Apart from that, there is a minor rework in a6xx_gmu_rpmh_arc_votes_init()
to simplify handling of MxG to MxA fallback along with the additional
calculations for the new dependency vote.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 77 +++++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h           |  7 +++
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 48 ++++++++++----
 4 files changed, 102 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1495f874e30e..53461be14dc3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -224,14 +224,19 @@ unsigned long a6xx_gmu_get_freq(struct msm_gpu *gpu)
 
 static bool a6xx_gmu_check_idle_level(struct a6xx_gmu *gmu)
 {
-	u32 val;
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	int local = gmu->idle_level;
+	u32 val;
 
 	/* SPTP and IFPC both report as IFPC */
 	if (gmu->idle_level == GMU_IDLE_STATE_SPTP)
 		local = GMU_IDLE_STATE_IFPC;
 
-	val = gmu_read(gmu, REG_A6XX_GPU_GMU_CX_GMU_RPMH_POWER_STATE);
+	if (adreno_is_a8xx(adreno_gpu))
+		val = gmu_read(gmu, REG_A8XX_GPU_GMU_CX_GMU_RPMH_POWER_STATE);
+	else
+		val = gmu_read(gmu, REG_A6XX_GPU_GMU_CX_GMU_RPMH_POWER_STATE);
 
 	if (val == local) {
 		if (gmu->idle_level != GMU_IDLE_STATE_IFPC ||
@@ -269,7 +274,9 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
 	/* Set the log wptr index
 	 * note: downstream saves the value in poweroff and restores it here
 	 */
-	if (adreno_is_a7xx(adreno_gpu))
+	if (adreno_is_a8xx(adreno_gpu))
+		gmu_write(gmu, REG_A8XX_GMU_GENERAL_9, 0);
+	else if (adreno_is_a7xx(adreno_gpu))
 		gmu_write(gmu, REG_A7XX_GMU_GENERAL_9, 0);
 	else
 		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_PWR_COL_CP_RESP, 0);
@@ -485,7 +492,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
 	 * in the power down sequence not being fully executed. That in turn can
 	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
 	 */
-	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
+	if (adreno_is_a8xx(adreno_gpu))
+		gmu_write(gmu, REG_A8XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));
+	else if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
 				adreno_is_7c3(adreno_gpu)))
 		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));
 }
@@ -493,10 +502,15 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
 /* Let the GMU know that we are about to go into slumber */
 static int a6xx_gmu_notify_slumber(struct a6xx_gmu *gmu)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	int ret;
 
 	/* Disable the power counter so the GMU isn't busy */
-	gmu_write(gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_ENABLE, 0);
+	if (adreno_is_a8xx(adreno_gpu))
+		gmu_write(gmu, REG_A8XX_GMU_CX_GMU_POWER_COUNTER_ENABLE, 0);
+	else
+		gmu_write(gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_ENABLE, 0);
 
 	/* Disable SPTP_PC if the CPU is responsible for it */
 	if (gmu->idle_level < GMU_IDLE_STATE_SPTP)
@@ -589,12 +603,17 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct platform_device *pdev = to_platform_device(gmu->dev);
-	void __iomem *pdcptr = devm_platform_ioremap_resource_byname(pdev, "gmu_pdc");
 	u32 seqmem0_drv0_reg = REG_A6XX_RSCC_SEQ_MEM_0_DRV0;
 	void __iomem *seqptr = NULL;
 	uint32_t pdc_address_offset;
+	void __iomem *pdcptr;
 	bool pdc_in_aop = false;
 
+	/* On A8x and above, RPMH/PDC configurations are entirely configured in AOP */
+	if (adreno_is_a8xx(adreno_gpu))
+		return;
+
+	pdcptr = devm_platform_ioremap_resource_byname(pdev, "gmu_pdc");
 	if (IS_ERR(pdcptr))
 		return;
 
@@ -723,7 +742,7 @@ static void a6xx_gmu_power_config(struct a6xx_gmu *gmu)
 	gmu_write(gmu, REG_A6XX_GMU_DCACHE_CONFIG, 0x1);
 
 	/* A7xx knows better by default! */
-	if (adreno_is_a7xx(adreno_gpu))
+	if (adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno_gpu))
 		return;
 
 	gmu_write(gmu, REG_A6XX_GMU_PWR_COL_INTER_FRAME_CTRL, 0x9c40400);
@@ -786,7 +805,9 @@ static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
 	u32 itcm_base = 0x00000000;
 	u32 dtcm_base = 0x00040000;
 
-	if (adreno_is_a650_family(adreno_gpu) || adreno_is_a7xx(adreno_gpu))
+	if (adreno_is_a650_family(adreno_gpu) ||
+	    adreno_is_a7xx(adreno_gpu) ||
+	    adreno_is_a8xx(adreno_gpu))
 		dtcm_base = 0x10004000;
 
 	if (gmu->legacy) {
@@ -850,12 +871,15 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	if (adreno_is_a650_family(adreno_gpu) || adreno_is_a7xx(adreno_gpu)) {
 		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, 1);
 		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FAL_INTF, 1);
+	} else if (adreno_is_a8xx(adreno_gpu)) {
+		gmu_write(gmu, REG_A8XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, 1);
+		gmu_write(gmu, REG_A8XX_GPU_GMU_CX_GMU_CX_FAL_INTF, 1);
 	}
 
 	/* Turn on TCM (Tightly Coupled Memory) retention */
 	if (adreno_is_a7xx(adreno_gpu))
 		a6xx_llc_write(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL, 1);
-	else
+	else if (!adreno_is_a8xx(adreno_gpu))
 		gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
 
 	ret = a6xx_rpmh_start(gmu);
@@ -880,7 +904,10 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	gmu_write(gmu, REG_A6XX_GMU_HFI_QTBL_ADDR, gmu->hfi.iova);
 	gmu_write(gmu, REG_A6XX_GMU_HFI_QTBL_INFO, 1);
 
-	if (adreno_is_a7xx(adreno_gpu)) {
+	if (adreno_is_a8xx(adreno_gpu)) {
+		fence_range_upper = 0x32;
+		fence_range_lower = 0x8c0;
+	} else if (adreno_is_a7xx(adreno_gpu)) {
 		fence_range_upper = 0x32;
 		fence_range_lower = 0x8a0;
 	} else {
@@ -914,7 +941,12 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 		chipid |= (adreno_gpu->chip_id << 8) & 0x0f00; /* patchid */
 	}
 
-	if (adreno_is_a7xx(adreno_gpu)) {
+	if (adreno_is_a8xx(adreno_gpu)) {
+		gmu_write(gmu, REG_A8XX_GMU_GENERAL_10, chipid);
+		gmu_write(gmu, REG_A8XX_GMU_GENERAL_8,
+			  (gmu->log.iova & GENMASK(31, 12)) |
+			  ((gmu->log.size / SZ_4K - 1) & GENMASK(7, 0)));
+	} else if (adreno_is_a7xx(adreno_gpu)) {
 		gmu_write(gmu, REG_A7XX_GMU_GENERAL_10, chipid);
 		gmu_write(gmu, REG_A7XX_GMU_GENERAL_8,
 			  (gmu->log.iova & GENMASK(31, 12)) |
@@ -977,7 +1009,7 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
 	u32 val, seqmem_off = 0;
 
 	/* The second spin of A7xx GPUs messed with some register offsets.. */
-	if (adreno_is_a740_family(adreno_gpu))
+	if (adreno_is_a740_family(adreno_gpu) || adreno_is_a8xx(adreno_gpu))
 		seqmem_off = 4;
 
 	/* Make sure there are no outstanding RPMh votes */
@@ -990,7 +1022,7 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
 	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
 		val, (val & 1), 100, 1000);
 
-	if (!adreno_is_a740_family(adreno_gpu))
+	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a8xx(adreno_gpu))
 		return;
 
 	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS4_DRV0_STATUS + seqmem_off,
@@ -1018,7 +1050,10 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 	 * Turn off keep alive that might have been enabled by the hang
 	 * interrupt
 	 */
-	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
+	if (adreno_is_a8xx(adreno_gpu))
+		gmu_write(&a6xx_gpu->gmu, REG_A8XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
+	else
+		gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
 
 	/* Flush all the queues */
 	a6xx_hfi_stop(gmu);
@@ -1122,7 +1157,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	enable_irq(gmu->gmu_irq);
 
 	/* Check to see if we are doing a cold or warm boot */
-	if (adreno_is_a7xx(adreno_gpu)) {
+	if (adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
 		status = a6xx_llc_read(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL) == 1 ?
 			GMU_WARM_BOOT : GMU_COLD_BOOT;
 	} else if (gmu->legacy) {
@@ -1451,7 +1486,7 @@ static int a6xx_gmu_rpmh_bw_votes_init(struct adreno_gpu *adreno_gpu,
 			vote = clamp(peak, 1, BCM_TCS_CMD_VOTE_MASK);
 
 			/* GMUs on A7xx votes on both x & y */
-			if (adreno_is_a7xx(adreno_gpu))
+			if (adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno_gpu))
 				data[bcm_index] = BCM_TCS_CMD(commit, true, vote, vote);
 			else
 				data[bcm_index] = BCM_TCS_CMD(commit, true, 0, vote);
@@ -2035,13 +2070,14 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	 */
 	gmu->dummy.size = SZ_4K;
 	if (adreno_is_a660_family(adreno_gpu) ||
-	    adreno_is_a7xx(adreno_gpu)) {
+	    adreno_is_a7xx(adreno_gpu) ||
+	    adreno_is_a8xx(adreno_gpu)) {
 		ret = a6xx_gmu_memory_alloc(gmu, &gmu->debug, SZ_4K * 7,
 					    0x60400000, "debug");
 		if (ret)
 			goto err_memory;
 
-		gmu->dummy.size = SZ_8K;
+		gmu->dummy.size = SZ_16K;
 	}
 
 	/* Allocate memory for the GMU dummy page */
@@ -2052,7 +2088,8 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	/* Note that a650 family also includes a660 family: */
 	if (adreno_is_a650_family(adreno_gpu) ||
-	    adreno_is_a7xx(adreno_gpu)) {
+	    adreno_is_a7xx(adreno_gpu) ||
+	    adreno_is_a8xx(adreno_gpu)) {
 		ret = a6xx_gmu_memory_alloc(gmu, &gmu->icache,
 			SZ_16M - SZ_16K, 0x04000, "icache");
 		if (ret)
@@ -2116,6 +2153,8 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 			ret = -ENODEV;
 			goto err_mmio;
 		}
+	} else if (adreno_is_a8xx(adreno_gpu)) {
+		gmu->rscc = gmu->mmio + 0x19000;
 	} else {
 		gmu->rscc = gmu->mmio + 0x23000;
 	}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 55b1c78daa8b..edf6c282cd76 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -19,8 +19,8 @@ struct a6xx_gmu_bo {
 	u64 iova;
 };
 
-#define GMU_MAX_GX_FREQS	16
-#define GMU_MAX_CX_FREQS	4
+#define GMU_MAX_GX_FREQS	32
+#define GMU_MAX_CX_FREQS	6
 #define GMU_MAX_BCMS		3
 
 struct a6xx_bcm {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 34b09cb127ed..99334deda522 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -50,6 +50,8 @@ enum adreno_family {
 	ADRENO_7XX_GEN1,  /* a730 family */
 	ADRENO_7XX_GEN2,  /* a740 family */
 	ADRENO_7XX_GEN3,  /* a750 family */
+	ADRENO_8XX_GEN1,  /* a830 family */
+	ADRENO_8XX_GEN2,  /* a840 family */
 };
 
 #define ADRENO_QUIRK_TWO_PASS_USE_WFI		BIT(0)
@@ -553,6 +555,11 @@ static inline int adreno_is_a7xx(struct adreno_gpu *gpu)
 	       adreno_is_a740_family(gpu);
 }
 
+static inline int adreno_is_a8xx(struct adreno_gpu *gpu)
+{
+	return gpu->info->family >= ADRENO_8XX_GEN1;
+}
+
 /* Put vm_start above 32b to catch issues with not setting xyz_BASE_HI */
 #define ADRENO_VM_START 0x100000000ULL
 u64 adreno_private_vm_size(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index 09b8a0b9c0de..5dce7934056d 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -66,10 +66,15 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x1f81c" name="GMU_CM3_FW_INIT_RESULT"/>
 	<reg32 offset="0x1f82d" name="GMU_CM3_CFG"/>
 	<reg32 offset="0x1f840" name="GMU_CX_GMU_POWER_COUNTER_ENABLE"/>
+	<reg32 offset="0x1fc10" name="GMU_CX_GMU_POWER_COUNTER_ENABLE" variants="A8XX"/>
 	<reg32 offset="0x1f841" name="GMU_CX_GMU_POWER_COUNTER_SELECT_0"/>
 	<reg32 offset="0x1f842" name="GMU_CX_GMU_POWER_COUNTER_SELECT_1"/>
+	<reg32 offset="0x1fc40" name="GMU_CX_GMU_POWER_COUNTER_SELECT_XOCLK_0" variants="A8XX-"/>
+	<reg32 offset="0x1fc41" name="GMU_CX_GMU_POWER_COUNTER_SELECT_XOCLK_1" variants="A8XX-"/>
 	<reg32 offset="0x1f844" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L"/>
+	<reg32 offset="0x1fca0" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L" variants="A8XX-"/>
 	<reg32 offset="0x1f845" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H"/>
+	<reg32 offset="0x1fca1" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H" variants="A8XX-"/>
 	<reg32 offset="0x1f846" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_1_L"/>
 	<reg32 offset="0x1f847" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_1_H"/>
 	<reg32 offset="0x1f848" name="GMU_CX_GMU_POWER_COUNTER_XOCLK_2_L"/>
@@ -89,7 +94,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	</reg32>
 	<reg32 offset="0x1f8c1" name="GMU_PWR_COL_INTER_FRAME_HYST"/>
 	<reg32 offset="0x1f8c2" name="GMU_PWR_COL_SPTPRAC_HYST"/>
-	<reg32 offset="0x1f8d0" name="GMU_SPTPRAC_PWR_CLK_STATUS">
+	<reg32 offset="0x1f8d0" name="GMU_SPTPRAC_PWR_CLK_STATUS" variants="A6XX">
 		<bitfield name="SPTPRAC_GDSC_POWERING_OFF" pos="0" type="boolean"/>
 		<bitfield name="SPTPRAC_GDSC_POWERING_ON" pos="1" type="boolean"/>
 		<bitfield name="SPTPRAC_GDSC_POWER_OFF" pos="2" type="boolean"/>
@@ -99,7 +104,11 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		<bitfield name="GX_HM_GDSC_POWER_OFF" pos="6" type="boolean"/>
 		<bitfield name="GX_HM_CLK_OFF" pos="7" type="boolean"/>
 	</reg32>
-	<reg32 offset="0x1f8d0" name="GMU_SPTPRAC_PWR_CLK_STATUS" variants="A7XX-">
+	<reg32 offset="0x1f8d0" name="GMU_SPTPRAC_PWR_CLK_STATUS" variants="A7XX">
+		<bitfield name="GX_HM_GDSC_POWER_OFF" pos="0" type="boolean"/>
+		<bitfield name="GX_HM_CLK_OFF" pos="1" type="boolean"/>
+	</reg32>
+	<reg32 offset="0x1f7e8" name="GMU_PWR_CLK_STATUS" variants="A8XX-">
 		<bitfield name="GX_HM_GDSC_POWER_OFF" pos="0" type="boolean"/>
 		<bitfield name="GX_HM_CLK_OFF" pos="1" type="boolean"/>
 	</reg32>
@@ -120,9 +129,12 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		<bitfield name="GFX_MIN_VOTE_ENABLE" pos="15" type="boolean"/>
 	</reg32>
 	<reg32 offset="0x1f8e9" name="GMU_RPMH_HYST_CTRL"/>
-	<reg32 offset="0x1f8ec" name="GPU_GMU_CX_GMU_RPMH_POWER_STATE"/>
-	<reg32 offset="0x1f8f0" name="GPU_GMU_CX_GMU_CX_FAL_INTF"/>
-	<reg32 offset="0x1f8f1" name="GPU_GMU_CX_GMU_CX_FALNEXT_INTF"/>
+	<reg32 offset="0x1f8ec" name="GPU_GMU_CX_GMU_RPMH_POWER_STATE" variants="A6XX"/>
+	<reg32 offset="0x1f7e9" name="GPU_GMU_CX_GMU_RPMH_POWER_STATE" variants="A8XX-"/>
+	<reg32 offset="0x1f8f0" name="GPU_GMU_CX_GMU_CX_FAL_INTF" variants="A6XX"/>
+	<reg32 offset="0x1f7ec" name="GPU_GMU_CX_GMU_CX_FAL_INTF" variants="A8XX-"/>
+	<reg32 offset="0x1f8f1" name="GPU_GMU_CX_GMU_CX_FALNEXT_INTF" variants="A6XX"/>
+	<reg32 offset="0x1f7ed" name="GPU_GMU_CX_GMU_CX_FALNEXT_INTF" variants="A8XX-"/>
 	<reg32 offset="0x1f900" name="GPU_GMU_CX_GMU_PWR_COL_CP_MSG"/>
 	<reg32 offset="0x1f901" name="GPU_GMU_CX_GMU_PWR_COL_CP_RESP"/>
 	<reg32 offset="0x1f9f0" name="GMU_BOOT_KMD_LM_HANDSHAKE"/>
@@ -130,8 +142,10 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x1f958" name="GMU_LLM_GLM_SLEEP_STATUS"/>
 	<reg32 offset="0x1f888" name="GMU_ALWAYS_ON_COUNTER_L"/>
 	<reg32 offset="0x1f889" name="GMU_ALWAYS_ON_COUNTER_H"/>
-	<reg32 offset="0x1f8c3" name="GMU_GMU_PWR_COL_KEEPALIVE"/>
-	<reg32 offset="0x1f8c4" name="GMU_PWR_COL_PREEMPT_KEEPALIVE"/>
+	<reg32 offset="0x1f8c3" name="GMU_GMU_PWR_COL_KEEPALIVE" variants="A6XX-A7XX"/>
+	<reg32 offset="0x1f7e4" name="GMU_GMU_PWR_COL_KEEPALIVE" variants="A8XX-"/>
+	<reg32 offset="0x1f8c4" name="GMU_PWR_COL_PREEMPT_KEEPALIVE" variants="A6XX-A7XX"/>
+	<reg32 offset="0x1f7e5" name="GMU_PWR_COL_PREEMPT_KEEPALIVE" variants="A8XX-"/>
 	<reg32 offset="0x1f980" name="GMU_HFI_CTRL_STATUS"/>
 	<reg32 offset="0x1f981" name="GMU_HFI_VERSION_INFO"/>
 	<reg32 offset="0x1f982" name="GMU_HFI_SFR_ADDR"/>
@@ -164,6 +178,14 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x1f9cd" name="GMU_GENERAL_8" variants="A7XX"/>
 	<reg32 offset="0x1f9ce" name="GMU_GENERAL_9" variants="A7XX"/>
 	<reg32 offset="0x1f9cf" name="GMU_GENERAL_10" variants="A7XX"/>
+	<reg32 offset="0x1f9c0" name="GMU_GENERAL_0" variants="A8XX"/>
+	<reg32 offset="0x1f9c1" name="GMU_GENERAL_1" variants="A8XX"/>
+	<reg32 offset="0x1f9c6" name="GMU_GENERAL_6" variants="A8XX"/>
+	<reg32 offset="0x1f9c7" name="GMU_GENERAL_7" variants="A8XX"/>
+	<reg32 offset="0x1f9c8" name="GMU_GENERAL_8" variants="A8XX"/>
+	<reg32 offset="0x1f9c9" name="GMU_GENERAL_9" variants="A8XX"/>
+	<reg32 offset="0x1f9ca" name="GMU_GENERAL_10" variants="A8XX"/>
+	<reg32 offset="0x1f9cb" name="GMU_GENERAL_11" variants="A8XX"/>
 	<reg32 offset="0x1f95d" name="GMU_ISENSE_CTRL"/>
 	<reg32 offset="0x23120" name="GPU_CS_ENABLE_REG"/>
 	<reg32 offset="0x1f95d" name="GPU_GMU_CX_GMU_ISENSE_CTRL"/>
@@ -233,12 +255,12 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x03ee" name="RSCC_TCS1_DRV0_STATUS"/>
 	<reg32 offset="0x0496" name="RSCC_TCS2_DRV0_STATUS"/>
 	<reg32 offset="0x053e" name="RSCC_TCS3_DRV0_STATUS"/>
-	<reg32 offset="0x05e6" name="RSCC_TCS4_DRV0_STATUS" variants="A7XX"/>
-	<reg32 offset="0x068e" name="RSCC_TCS5_DRV0_STATUS" variants="A7XX"/>
-	<reg32 offset="0x0736" name="RSCC_TCS6_DRV0_STATUS" variants="A7XX"/>
-	<reg32 offset="0x07de" name="RSCC_TCS7_DRV0_STATUS" variants="A7XX"/>
-	<reg32 offset="0x0886" name="RSCC_TCS8_DRV0_STATUS" variants="A7XX"/>
-	<reg32 offset="0x092e" name="RSCC_TCS9_DRV0_STATUS" variants="A7XX"/>
+	<reg32 offset="0x05e6" name="RSCC_TCS4_DRV0_STATUS" variants="A7XX-"/>
+	<reg32 offset="0x068e" name="RSCC_TCS5_DRV0_STATUS" variants="A7XX-"/>
+	<reg32 offset="0x0736" name="RSCC_TCS6_DRV0_STATUS" variants="A7XX-"/>
+	<reg32 offset="0x07de" name="RSCC_TCS7_DRV0_STATUS" variants="A7XX-"/>
+	<reg32 offset="0x0886" name="RSCC_TCS8_DRV0_STATUS" variants="A7XX-"/>
+	<reg32 offset="0x092e" name="RSCC_TCS9_DRV0_STATUS" variants="A7XX-"/>
 </domain>
 
 </database>

-- 
2.51.0

