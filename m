Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1D32C33C
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792782; cv=none; b=gzBGNJrguNraRn8YZJShkB3X9i/n285k6gwpn/wkAQpF9CM6w0yCfBiIn2ufyayRD3bCJeHo2qDCKjsVephJlbIE8C/CpwimAJTTY3RMx03Lb8BWXuLmp7hk9ciR9yZQGfKo5kcjwq4OhyvytrjF4hHSIMAs/y+MxpqQyfm6DDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792782; c=relaxed/simple;
	bh=LWOc612J9bhiyGK31kvlUfk/uc8PZDAIZt+/ViUR8y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q49TCDXBPqptZym40HmCJwe5NJPIsbI41Ebguk1C7hROuX0U3KP/shxQ86Etpw/EOilFfn2a9le02WbFTppoR1Ek7w6x8FLniBeDwsjSE6LgquOi3qZahubnC62dX1AfDKj9LPM4iZYsysvz0kijp1PpchMJLEDSFKO2GAF4iJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NfloY2Uc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BNHuOWpp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NfloY2Uc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BNHuOWpp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFhn4m3985676
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qhWAU4GwkZc/7vJbgqlZua/hMbE+FKAm5HguK+Q4/xI=; b=NfloY2UcabBEHbGh
	fl9Eps4ZBX7fNEkkBh8BEYS+32vOxrIK2m6yXUnyWDwM+rERBerTUbwIy0uBH/SL
	u/3DOWkDZeUjVkRKjme4f50ly78gXxUsNDnxiJV+ILo/qTdHLAmqpVtQ0P87xvIc
	ZFH9bvL+B39iKMvKb4P0QavNQ2z/VPkJSrxjl/EZq92g2HwjDzSWFkmwDpxDZSzo
	ZZLF+B6RrkPZLbAZgLbUssgeTb+j8BWwv3up7KXy/9GrwZPlU8z0twkUmiExaCpV
	8RjBZJYAZtzr3kDYlgmwAZDngc/mHntvaZ4GGSo5eIOo2vKfCzjvu/0JD2CBbaAw
	Cunn5Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjxqg6u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:39:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34176460924so3140510a91.3
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 08:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792778; x=1763397578; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhWAU4GwkZc/7vJbgqlZua/hMbE+FKAm5HguK+Q4/xI=;
        b=BNHuOWppCW3r786TKftNAneW5AW0KmHXhKEIldGXrnag0XDZG/MwqUdIi7giNc7bQy
         yxI8ziSYgc4NiIFFf0PRrtuMrvcfGgCpvMyDkQ5/aQPxm8XEhyAkLjcZ25nGVEoanqhy
         QYhwqHF8mPviVzX5NFrdHSTyQAokO4gu5ZAnQvfbIGViMn/3DfpkX5c8fhqh6mHg6jZU
         SunuOsSckauDikK9DKhjf+BKJ/iIOBrFA2be4NIeRrpAuj42HUmMWLz8oVDKcD4lzy3x
         1brt+02jp5DMutRIeR4oYgB4CryJ8BDkfgNvyipjul6mUdnywjPooMS9KKN4QHXphVig
         MYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792778; x=1763397578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qhWAU4GwkZc/7vJbgqlZua/hMbE+FKAm5HguK+Q4/xI=;
        b=HR9Gx/HxNrXxPpkBen3x4QwUGPLBapmSA8aL4AtqqijgSlUqRQfsRO9y2mE00KU0xx
         HL39j37wJB1nLhuDz5OsoOGaBpdWvt3XPnZ8o+fYrCFKm4qhdCNFLDyxAMfRx967c5ki
         NE8RJquHsF1HaRIqh8/JPX+5LLGzaJgbx8e2hAR5v6GBzpkq/gDGc5TVAV11YZhWcZtw
         GQVVS5d7YAsTVSyp9gHKIzvquj6ZrPbE0sz3+9MpMv0gObYcbH56K2auql6xL2NQHvxi
         OSXkgzufphFHyAGl9BQQUfylxvZesqPyr4A2A5MpWXuJxPz8BTCRFR+XOnX2kRV/2eMH
         lLjw==
X-Forwarded-Encrypted: i=1; AJvYcCVckGwtMIQanWfB/Ofl5+yYR/NbCJ1Wz33rilpYP3xgWiFkmkuRmKTYnNMMaXObIQpTRcS0aA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPNT8RVzqSrPvM4/ou4A0rGm9pll1Ut66cysJDwxe/8WTqeVZb
	0miY1YmVYLk3JKwFaYArV4EQk2qJZGEfcfyRukAs+AkoLEbMnTM79b6g6wKgWDmEmO/lAf2sFl5
	LvfCQDRGb7n55ngdFN/6cHQe1g1oPuQvdSvEbiRBkv7JbdysGbPYtfJCXLQ==
X-Gm-Gg: ASbGncu7EIRYWzm+C5pyidEl0Czt2vhZHavSvJY6yfEnJ61kt1vigK5HPmLe+hBxyNL
	csQewfa+Rb/NEsByicaNc2yoGnIWf1N0y0iO5eskzaEXzbML7BQMHwXYsLEGVJosQ8IVzKmIAEv
	u2LEUiFwquareuxviOY6NJjhizIhLwhbiYyaJcsNwmkMdyzbVXz3jgRGj2xaO3e/yMdP3VfkcON
	DMbjcQdW0ErMWTAImByzde2a+StikcIZ7MbhOZxe4ZKk6QIjnyA5iu4oEH2pYcXGuFWY5o+mXqV
	+/ceTC03Ipt6eeqPLLD1yBmvT5bRru0SvqOanfYiQaLzL5G9AV/y3qOAvQN934mHczwVwec4CNv
	hj7olMvOs5sT1HkMf+9h7It8=
X-Received: by 2002:a17:90b:3b52:b0:340:25f0:a9b with SMTP id 98e67ed59e1d1-3436cbc74d5mr10535204a91.33.1762792778285;
        Mon, 10 Nov 2025 08:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKuivtP5bPOxg4eqYPpqCiRonwpKyitk9efo7oMRmT6OqAejXcK+KdVc51LUlDkH4mfwy14w==
X-Received: by 2002:a17:90b:3b52:b0:340:25f0:a9b with SMTP id 98e67ed59e1d1-3436cbc74d5mr10535152a91.33.1762792777713;
        Mon, 10 Nov 2025 08:39:37 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:39:37 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:17 +0530
Subject: [PATCH v2 11/21] drm/msm/a6xx: Improve MX rail fallback in RPMH
 vote init
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-11-bef18acd5e94@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=2950;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=LWOc612J9bhiyGK31kvlUfk/uc8PZDAIZt+/ViUR8y4=;
 b=Dyz4d2Rpgtz4n2FITe1odQAEtosB0h0Bg9zoRd3AwbZUYYMJMDaf74l7QdElyyEqfnmryp4KJ
 0My+qrkFhbTAtvi+hF5ODj3d82ls447n7pfXlXg7IJLPvV878p2Eal8
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX8o4q6KFm6323
 NEAFwp+889pe56KiXghoMt2mrVPY5Ut/tWMMwUGK14O5heH22h1KSyTOb6F3c3vVTIV4XAZs+VD
 l7VkaqbHXmSMykEV/uZv9iOlG7xx1dQREnHhoqnW1qCPtzSHQUc7NM8zwj3t3WrK4IztkWW9kUx
 FwhS8LikoKmTxBY+aF9iIaSVAIBY7IcW/CN5WwTc3pMMnHf19oYDRSHmvXo4L3pUF2GLoCsfx3m
 gHlOjSWR+mUcmnGw7L0e9uKvOaRUH4GlkcdDkPS8H8TGxYa+i5Li30wF0F38LZwVCWd8fUcgjln
 9iY0ofSvDDPnv21CtXivQIRAOqGwgamKHHxE51VlZZkxJmeqVT+L2oC4a2D+IYpernZqyNMPT8s
 hbPNt5upZHrNlXwawUPhqLW7DGXNTA==
X-Authority-Analysis: v=2.4 cv=CsKys34D c=1 sm=1 tr=0 ts=6912154b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=feIks7WodE12ze-Om1wA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: R2YRC9xTIQdM8zwau-zBR-RUsmkkx0nK
X-Proofpoint-GUID: R2YRC9xTIQdM8zwau-zBR-RUsmkkx0nK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

Current logic assumes that the voltage corners in both MxG and MxA are
always same. This is not true for recent targets. So, rework the rpmh init
sequence to probe and calculate the votes with the respective rails, ie,
GX rails should use MxG as secondary rail and Cx rail should use MxA as
the secondary rail.

Fixes: d6225e0cd096 ("drm/msm/adreno: Add support for X185 GPU")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 112ef7ea320f..8597d7adf2f7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1519,13 +1519,14 @@ static unsigned int a6xx_gmu_get_arc_level(struct device *dev,
 }
 
 static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
-		unsigned long *freqs, int freqs_count, const char *id)
+		unsigned long *freqs, int freqs_count,
+		const char *pri_id, const char *sec_id)
 {
 	int i, j;
 	const u16 *pri, *sec;
 	size_t pri_count, sec_count;
 
-	pri = cmd_db_read_aux_data(id, &pri_count);
+	pri = cmd_db_read_aux_data(pri_id, &pri_count);
 	if (IS_ERR(pri))
 		return PTR_ERR(pri);
 	/*
@@ -1536,13 +1537,7 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 	if (!pri_count)
 		return -EINVAL;
 
-	/*
-	 * Some targets have a separate gfx mxc rail. So try to read that first and then fall back
-	 * to regular mx rail if it is missing
-	 */
-	sec = cmd_db_read_aux_data("gmxc.lvl", &sec_count);
-	if (IS_ERR(sec) && sec != ERR_PTR(-EPROBE_DEFER))
-		sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
+	sec = cmd_db_read_aux_data(sec_id, &sec_count);
 	if (IS_ERR(sec))
 		return PTR_ERR(sec);
 
@@ -1610,15 +1605,24 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	const char *sec_id;
+	const u16 *gmxc;
 	int ret;
 
+	gmxc = cmd_db_read_aux_data("gmxc.lvl", NULL);
+	if (gmxc == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+
+	/* If GMxC is present, prefer that as secondary rail for GX votes */
+	sec_id = IS_ERR_OR_NULL(gmxc) ? "mx.lvl" : "gmxc.lvl";
+
 	/* Build the GX votes */
 	ret = a6xx_gmu_rpmh_arc_votes_init(&gpu->pdev->dev, gmu->gx_arc_votes,
-		gmu->gpu_freqs, gmu->nr_gpu_freqs, "gfx.lvl");
+		gmu->gpu_freqs, gmu->nr_gpu_freqs, "gfx.lvl", sec_id);
 
 	/* Build the CX votes */
 	ret |= a6xx_gmu_rpmh_arc_votes_init(gmu->dev, gmu->cx_arc_votes,
-		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl");
+		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl", "mx.lvl");
 
 	/* Build the interconnect votes */
 	if (info->bcms && gmu->nr_gpu_bws > 1)

-- 
2.51.0

