Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837E32E131
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792822; cv=none; b=ZRz6Ifb3J2VAtJrLdFvwxyNcgFa/GHs5CU2AB4yk70tkmuG3Mf/cTvaN3DFOk9Ivw35lPY/MgxY3ZvJFGvk+CYIQLf108GSiS+tH72do9C8LPfwcpiYzwN1RCzh7iBfS6FbisDAgbsM4WF6Xh4hfT9I7FWt+FwkjClgUtiXteHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792822; c=relaxed/simple;
	bh=LNBgIzkBqsqfEpWJzwTTcgD/um5V3p8naLGClkQuias=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfHKQbQSqXNsvsuTn81MUvFgyjru+hPZSFb7b9q4cYDeXC3dH6JTksuiAmdWBZqVKxluEYMgeeCGzpbMDLnWHyEmyh+E+O1hKJRxDgmTYdYb0y7JfHHTMxo+9cfF3ZJwcp6qoEgVPMbSklrDZzq45DfnGvvQ6+dcRG9A0c7oroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LDyVu4U4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DNPaX7wB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LDyVu4U4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DNPaX7wB"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAGP7gG2868103
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nVwNgHskrk/J1QB8XLyxKsyxPDVAl6g84xIBLcijALA=; b=LDyVu4U4U23qcm5w
	FXqny6gDZhL2QVqETPkqez060RWmXNWbDqC5fB/wrmkHdwTKP9hBXMOx/bV+cnQX
	R/fkgi1TUDgejop2dxuUQcZ4C+rkj5PyncFNwqR+S2SwREjI6BbCWrhuf8M7tNVm
	WP+oBarVCmY8FWpV1oay1YQ0HUhuFGEDeXL0NbN6RFzZM6XhYtc06uNzZ0hKIa5x
	ofih62wKPsNUwJ8D/m/Dncm1PJUHCy56v0oN2+eQWs5lcU8nEFZf8cD7F/CXcNrb
	4tIGGbPgvhYH1/2RsXrXVZirt71+LH8H+ZeiCZIiJe1DWBX459zh1cYh+L7EnU+l
	ZsRoXw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd761bf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3418ada9e6cso3948269a91.1
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792819; x=1763397619; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVwNgHskrk/J1QB8XLyxKsyxPDVAl6g84xIBLcijALA=;
        b=DNPaX7wB4oyqoBXhC1ANwGNM2xLvqu1IGJr2QfK/F0WzD3SMKciMuP4bqjDcIkWf7u
         sU2TJmXoBZaffdrNmI3MdSEnsiF47+h0RoAtFRj5C/isGAcpmpHez048GUippJX6mq8J
         l06BO5pbJa1+6J1i67QfGIPHeaY5rAr9u/atlQY06s8cmiD8bOV2NK8dZcKTEVEf/Mgi
         PD9JFG3kGX+MtBnG1KigbAJLWOHc2e4HndgDXCKiTqyZx6IgxCd9d/Z7hVdAZhghhXKi
         x5AqWsI6xkEiWZwE+VhlmKc2hud3w8X21lmZ+fRFfYpFBs//IRraXVlAUs/VZEldMYvq
         Al2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792819; x=1763397619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nVwNgHskrk/J1QB8XLyxKsyxPDVAl6g84xIBLcijALA=;
        b=mPVdV/4MwLzb0d8XEuOrHDOzAaYW1Yfqab6atcC2M6R/pULPdmoPQmrMVt709BgZcI
         oY08MCtsdLFt5JKjIBOyCyL1cDv57baqMt3ZMk6GEZ/pllEmk8NHYm0oyiJO8S7Yn+EO
         26Qekw7hTsAKuUvtXIbA99Sn2Cx4aM3mU3j0mlxCBoM2IrUO0R6D6+xJlmn/OcvynZx0
         /0QJqeZHsDCfjZHrWhIt9kWobpdZ8rGxW2ZYFyaZCvbdb6xzIwiFKmh6PsanNuGGR6Kg
         +AIQkRJH5Rxvr5oOhAQpF+wJEDlNlB6x4rzj2ePyaSa3d2K8z3D/Ed45gGSbT/KeCN8A
         oz2g==
X-Forwarded-Encrypted: i=1; AJvYcCXb0FJDeNcedl3Dx/Ydaf9DpukQ35tbEfRkiQAflgkYEQBCm99o7ipyCtF2RHcENEB+ENZifQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yza0Ll1ee3UV6nHU5eujgUJFReBKKDNknXS/J8Hh8ekxpY/iXlJ
	1FXxE/hZjAQVt+v7d+/IXUorGD+2uw+9lVJ2GTHB+1ubudk+4JLhWcvFDIDJV636gYKMb42MkL2
	2ST6mvwI33S6IoqJc3My21cdeIBDP6DSmH5bonbaqMTL6gHpUvkCneXfWwg==
X-Gm-Gg: ASbGncuxALQH5uaxxiU4+4OIehavIkSJPLsBVRwfvjKuKtouy4E2GweHgdsa6a1kPgm
	ODRu0w4qlWrbyWvY2AhRtZRxiIg9WPhNId4NtHgt21Hz0/gVdOAovy9lviKN3KMWUX7IXGAR8Cp
	1BBLrgKcFzPOQhkmicTOyPoUSEtQHJwqprlQV6hLl2TWzzyyEArxQ693wZaa0iFnTbGoaP7ex4d
	NGXeIUzKPWsH970ww7I27eRYws1zLlDCPU6eywMmRWh3zNUQJuIp9wSuSwMT6CuXEz1GZq0qdR/
	zDRteYs1EQR+NYUkwhveBfo3R5eLtQRFJ8VDOQkGM8YOllJBhkxTliHslXq8Mg/SMg4YBtiMpQU
	E2Tzxyh0vspH+Ljcfp1JTESw=
X-Received: by 2002:a17:90b:1d0a:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-3436cb22a57mr12950703a91.11.1762792818800;
        Mon, 10 Nov 2025 08:40:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzdHoNic/6IFzqu4jl1tCbYh2rPj7vbAgvXHYulBRCa4QJH00zgqH38AHljN1+VXxujQ9dOQ==
X-Received: by 2002:a17:90b:1d0a:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-3436cb22a57mr12950659a91.11.1762792818119;
        Mon, 10 Nov 2025 08:40:18 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:40:17 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:22 +0530
Subject: [PATCH v2 16/21] drm/msm/adreno: Do CX GBIF config before GMU
 start
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-16-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=8336;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=LNBgIzkBqsqfEpWJzwTTcgD/um5V3p8naLGClkQuias=;
 b=Zzm37hB+BMAVa7JGIfy2qEzDAn4Yh3xcflkn3GYpt84o4E+iYsaXh/sd9wK6PYMy44T9Oj7Bh
 fMEvUTedm+5DgKyJ/B3MZIHfmWvN6WFelLy+b8O+xBiXorjDkRD5/6X
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: eE9RWIcFEBcS0YjXvv70vlnU6LP75cEG
X-Authority-Analysis: v=2.4 cv=OK4qHCaB c=1 sm=1 tr=0 ts=69121573 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=beDsvRS2jwLRuxpa4okA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfXxGuOX/JGhU7g
 jV1QFsSQpMyOtNNLOIwR6VytY7mzkY7l7lCsqDQGFDjlGcbBiw6GBwRsoxBrNfufdjxfov0UTA/
 4w7rKSqRzMINmQuB0Pb9xEHS0xwAEujffDCQ40oYkcUfRvNkSRIFMVXJVLayhV6FHUiDDtqKBQ/
 vatMzsDP0WqdYUW+haz87ecHss+ig8rQFqlEXr5kXEcU6iTN1P6OIbn5hpQO/lqGm7OckwpzcPS
 kA0uVLxyzLhrbbabZvRmLoX3BW7LTa9gdYRBuY5o6uwEODj3am7Zfq6U9SKvc1Iy3to2oP7KMRi
 /pafRdzDzVyX/P40MX1DExon7+lFY38uPehVlLMhxm8gHWMOJ6d092YoxqYH473I4BwM6CdWa8W
 i5rt60xND9BkWqMRDWEBtBG79nYISg==
X-Proofpoint-GUID: eE9RWIcFEBcS0YjXvv70vlnU6LP75cEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

GMU lies on the CX domain and accesses CX GBIF. So do CX GBIF
configurations before GMU wakes up. This was not a problem so far, but
A840 GPU is very sensitive to this requirement. Also, move these
registers to the catalog.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 12 ++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 17 ++++++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 10 +++-------
 5 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 7a5887b5ee47..fa3ae725f389 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1331,6 +1331,14 @@ static const u32 a730_protect_regs[] = {
 };
 DECLARE_ADRENO_PROTECT(a730_protect, 48);
 
+static const struct adreno_reglist a730_gbif[] = {
+	{ REG_A6XX_GBIF_QSB_SIDE0, 0x00071620 },
+	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071620 },
+	{ REG_A6XX_GBIF_QSB_SIDE2, 0x00071620 },
+	{ REG_A6XX_GBIF_QSB_SIDE3, 0x00071620 },
+	{ },
+};
+
 static const uint32_t a7xx_pwrup_reglist_regs[] = {
 	REG_A6XX_UCHE_TRAP_BASE,
 	REG_A6XX_UCHE_TRAP_BASE + 1,
@@ -1458,6 +1466,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a730_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_cgc_mode = 0x00020000,
 		},
 		.preempt_record_size = 2860 * SZ_1K,
@@ -1479,6 +1488,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_chipid = 0x7020100,
 			.gmu_cgc_mode = 0x00020202,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1513,6 +1523,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.ifpc_reglist = &a750_ifpc_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_chipid = 0x7050001,
 			.gmu_cgc_mode = 0x00020202,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1554,6 +1565,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.ifpc_reglist = &a750_ifpc_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_chipid = 0x7090100,
 			.gmu_cgc_mode = 0x00020202,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1586,6 +1598,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_chipid = 0x70f0000,
 			.gmu_cgc_mode = 0x00020222,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1785,6 +1798,15 @@ static const u32 a840_protect_regs[] = {
 };
 DECLARE_ADRENO_PROTECT(a840_protect, 15);
 
+static const struct adreno_reglist a840_gbif[] = {
+	{ REG_A6XX_GBIF_QSB_SIDE0, 0x00071e20 },
+	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071e20 },
+	{ REG_A6XX_GBIF_QSB_SIDE2, 0x00071e20 },
+	{ REG_A6XX_GBIF_QSB_SIDE3, 0x00071e20 },
+	{ REG_A8XX_GBIF_CX_CONFIG, 0x20023000 },
+	{ },
+};
+
 static const struct adreno_info a8xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x44050a31),
@@ -1803,6 +1825,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			.protect = &a840_protect,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.nonctxt_reglist = a840_nonctxt_regs,
+			.gbif_cx = a840_gbif,
 			.gmu_chipid = 0x8020100,
 			.bcms = (const struct a6xx_bcm[]) {
 				{ .name = "SH0", .buswidth = 16 },
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index cc969145f612..f9c0c82b5136 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -868,7 +868,9 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	const struct a6xx_info *a6xx_info = adreno_gpu->info->a6xx;
+	const struct adreno_reglist *gbif_cx = a6xx_info->gbif_cx;
 	u32 fence_range_lower, fence_range_upper;
 	u32 chipid = 0;
 	int ret;
@@ -964,6 +966,16 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 			  gmu->log.iova | (gmu->log.size / SZ_4K - 1));
 	}
 
+	/* For A7x and newer, do the CX GBIF configurations before GMU wake up */
+	for (int i = 0; (gbif_cx && gbif_cx[i].offset); i++)
+		gpu_write(gpu, gbif_cx[i].offset, gbif_cx[i].value);
+
+	/* For A7x and newer, do the CX GBIF configurations before GMU wake up */
+	if (adreno_is_a8xx(adreno_gpu)) {
+		gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
+		gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
+	}
+
 	/* Set up the lowest idle level on the GMU */
 	a6xx_gmu_power_config(gmu);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 029f7bd25baf..66771958edb2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1265,17 +1265,20 @@ static int hw_init(struct msm_gpu *gpu)
 	/* enable hardware clockgating */
 	a6xx_set_hwcg(gpu, true);
 
-	/* VBIF/GBIF start*/
-	if (adreno_is_a610_family(adreno_gpu) ||
-	    adreno_is_a640_family(adreno_gpu) ||
-	    adreno_is_a650_family(adreno_gpu) ||
-	    adreno_is_a7xx(adreno_gpu)) {
+	/* For gmuwrapper implementations, do the VBIF/GBIF CX configuration here */
+	if (adreno_is_a610_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
-		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL,
-			  adreno_is_a7xx(adreno_gpu) ? 0x2120212 : 0x3);
+	}
+
+	if (adreno_is_a610_family(adreno_gpu) ||
+	    adreno_is_a640_family(adreno_gpu) ||
+	    adreno_is_a650_family(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
+	} else if (adreno_is_a7xx(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x2120212);
 	} else {
 		gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);
 	}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 031ca0e4b689..cf700f7de09b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -46,6 +46,7 @@ struct a6xx_info {
 	const struct adreno_protect *protect;
 	const struct adreno_reglist_list *pwrup_reglist;
 	const struct adreno_reglist_list *ifpc_reglist;
+	const struct adreno_reglist *gbif_cx;
 	const struct adreno_reglist_pipe *nonctxt_reglist;
 	u32 gmu_chipid;
 	u32 gmu_cgc_mode;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 2ef69161f1d0..ad140b0d641d 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -500,6 +500,9 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
+	/* Increase priority of GMU traffic over GPU traffic */
+	gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
+
 	/*
 	 * Disable the trusted memory range - we don't actually supported secure
 	 * memory rendering at this point in time and we don't want to block off
@@ -508,13 +511,6 @@ static int hw_init(struct msm_gpu *gpu)
 	gpu_write64(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_BASE, 0x00000000);
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_SIZE, 0x00000000);
 
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
-	gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
-	gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
-
 	/* Make all blocks contribute to the GPU BUSY perf counter */
 	gpu_write(gpu, REG_A8XX_RBBM_PERFCTR_GPU_BUSY_MASKED, 0xffffffff);
 

-- 
2.51.0

