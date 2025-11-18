Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E33043DB
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455936; cv=none; b=Y05Yi3LCE5K9Kpl2Uk3zERapGX0EeKHiUhTbiXAFfeIjITtJYPa+MIbpweQNqu+7a6GsV62oE4z59A9btv+YvpzPr8XW3YCjPh9kaV47JDjT1UfrbTDiIL9GuHnjaNpNo7IZOrNQgsW9rxJqK5vSh54vAvOl75c8li50D02Bzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455936; c=relaxed/simple;
	bh=vVeIWVb6/O65xXMPCwHkJepVe1RNfzVF3KjNUn+Tu2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6weVzDK4TwzlYbRxIh2dPJKm4F8YU4TC/oUJ/Wy02CCjJPZ/IzcrPtzdwm16O2Z9lt+TmJlaJDynjzj/7ps0Evn1aKaApQb1FMZIFFYl2bBgru/7MjRhvNhCIV/yu3h6mhvot4Au2eF2lS/OXyJc/Yml9qP3ZVkhNzHn9KIlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i4kJqj7H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pg5QOrGJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i4kJqj7H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pg5QOrGJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI1M2v14166714
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eLaq0rEgvGtAfaQgBbzK+2z25S35G2xyAjIzDCq9mo8=; b=i4kJqj7HGJxBNHRd
	pTEmc03++M247mGtaHLvboxPV3bu9Cx4W7q9AzCFwldc6x6PFEwFQzlLT9olFPP6
	2F5xkVympvifrfPP/vdT0hCLa5elzwumkQ5poAPy/8MnxSpxRIziIjxzlIms8yKN
	R/aiXuF+BX5ORsP3dQ0xnf0QJccd8vVxxA7NYJVWNWM8nW/zEk2aSmMfEKqTYSNv
	5Tuh7izfesavFYjF8D7zHjqiIw8nvVZuvRHuDoNjaspnkdyhWR7JkOliPrFy3Yx/
	I6VcanGEQ4/4exxEZ9IAo8tBmPAamx+JagxHjp/S4KHGnDrl1G4MLd7XD8i9Hpba
	gYAZSg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag593tus0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:52:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295fbc7d4abso67826865ad.1
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763455932; x=1764060732; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLaq0rEgvGtAfaQgBbzK+2z25S35G2xyAjIzDCq9mo8=;
        b=Pg5QOrGJhXm0xBDjUMdKSh454wicC2snXTd4XnDysgBqWowsJJRyblT+Up09C3gj7R
         96vQwOTU6ooH9kuQyzmakuK+zn+LEOUSxz0viuDu2E4tSqWFo9WLdmLqmswewPC4BsZn
         6POgPGMI4A7wg5gT/RsJDQMsBWIisOmLI77mEuAWUEW/7xqvoNtL8LgtKoSpm8w4Bw2p
         2xYj/YvQqzRZbWHhr/mCxXGbKJc5bjoDz6XO5WWsU/AtqgM78A4vy0OXJEtkfu38nURy
         s5H98AfwpcHpLuJ5jPzfRRgtVrx8Cjl37brV6yZtOiC+8IrTESOeO58zwryun1RpmJJ5
         ckJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455932; x=1764060732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eLaq0rEgvGtAfaQgBbzK+2z25S35G2xyAjIzDCq9mo8=;
        b=bD0RZGkyPYxlW8bkZ1A8OS4BEjlsbeWwjyfFnDgUVorCr6tzi7bOeCtcIWegx8th6+
         dj1ZONA+lHwoHD4xTY/+D2LHgZKOcHsAWq9Jo1+MRVD8VGicT7IaR4u7ckFT2k+Yu67I
         SpNP8BEW1t/DyXklutLEjUu/m9LhGK9VPoW75GWuLu5uzJTMBQwgiDAaNLsTQueXczSK
         q1KPR59K/gqzgzStaYHxXJ4c2pu+4G8EJI9jNWqOj+KqN0S2grX237nxt4/Z0O+Qujlf
         BxNwyCCqHYTpW71jMtsZxloY2MwWHoBcQiolIaHCfZg/CG6+MF5SV56EhZiCAvYcRkhD
         qwmA==
X-Forwarded-Encrypted: i=1; AJvYcCX0s6Zq/FHR/WS6ZsXlkkIZnCMGXgUdfnTXInjlVdioAkt0Z5OYuPG0Brdje3uF3M+Mwu5KhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIgnqXy7mzXdsfnD+fTDnd5kGBOUvXo1R3RB/mWTFimJK/15WL
	F/IFX4mODp9JeoYmQnBhCy5RF6tWLR04U/IuRhD5X+YU6SgougZHVcSVFeY/zYy+k+dDOCP/hSi
	cVtHVknd30W49VQWbXy1SonBHcXOYuYTOiQPiUAc/weza4d9WEKAtOhhaLg==
X-Gm-Gg: ASbGnctELVFbdMrYgZciqi1ioHaMpzNJoVFgubJi+CZMZHJVAfFICDjdTQiCKPosHKx
	RfXODyKsHxwjEjSSYN8qe+tvUY0ijhTpDR3YL05JjpQQWOFKjZp68vZjgtuUmLTacYeZvhJqBGl
	d+xzFmbR1UenAXdUINC7oupQ9SKY94uvt9kumdJ+hq6Jb1EqEW0e54+QjxdfobF4z7mI8edQi4b
	jDlILGZQJsqNBAfrRPWFiDI83dF3to3FMO6kab6SxKMClJTfvo5afz9gRJ8CavTdTd2EcrwJxvw
	XLMXMx4qFIWKyTE0Qyl6sA//Jj/g0Eh4oJZDsPobzrT6rgrvxWfZbwiO+Sn7TeJ13k6zqK7DF8V
	maPIemRYyYbUujZJ9buAXaAE=
X-Received: by 2002:a17:903:40c9:b0:295:98a1:7ddb with SMTP id d9443c01a7336-2986a76b80emr187942435ad.61.1763455932069;
        Tue, 18 Nov 2025 00:52:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuRmrBbc/dLnfpzW67vqiSzLvO2GCc3zw2G2+R4D6v4gByj5OD0N9KHMTWShzhMrZVfqzGpA==
X-Received: by 2002:a17:903:40c9:b0:295:98a1:7ddb with SMTP id d9443c01a7336-2986a76b80emr187942015ad.61.1763455931526;
        Tue, 18 Nov 2025 00:52:11 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:52:11 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:34 +0530
Subject: [PATCH v4 07/22] drm/msm/adreno: Move gbif_halt() to
 adreno_gpu_func
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-7-86eeb8e93fb6@oss.qualcomm.com>
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=3603;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vVeIWVb6/O65xXMPCwHkJepVe1RNfzVF3KjNUn+Tu2I=;
 b=mn64hAX+PZCwaGr9mtLhPoTUQxvBfGlWdpJjGyPWSsKD2Excv+y0rvk1aaeOYO1krY2o7l16G
 MVdWNEfEquICZqxHjf1KDyr3BVVz/H3kL63znYGY+Af/M1j6u9EoU4w
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=AKSYvs3t c=1 sm=1 tr=0 ts=691c33bc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=W_sW28Yvd0frASqVc48A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX8LeRZXx+/MQp
 3ooh59jbHpAUYQZ4yRwXZBPy1P6/3iIQVnXS70CHy8CdPIiRl9BnJ+6WIafeKuWkvcd020yd5mf
 8+Id4Sipgq+UH0/5EJ4FSakx4wZX4ZSb5hh6WbXXzxSsJOIJDozsBZ99MH6zi1JqIj1budUfFLa
 +oUmXTz4Egv+aBm6d/RCPrfYN2tRRe3GkIDkaDaPvwn7BB7e9LGdZ/gxotNVYRQymfLxGPZyG/4
 C9UHA5ZOP+s4IZ0NkDUKlQ7P/M3eLVU9eyMfrKOlMPs/9ED/pgqyqT7LTeTip+ib0MWRbOxDop9
 4LJpfYQhhd2U6gLj8EWG5xz3PusJLPrWV6LV4XQah9naG0xUPGoII7wPSwC/wohjkvTKCx/wQLw
 huwimIcT1Z6uY/ie1BblHZ+C4/g0Dw==
X-Proofpoint-ORIG-GUID: 5ujVijjaaJ92cTYqiftl1W4ufR_xJWCY
X-Proofpoint-GUID: 5ujVijjaaJ92cTYqiftl1W4ufR_xJWCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180069

Move the gbif halt fn to adreno_gpu_func so that we can call different
implementation from common code. This will come handy when we implement
A8x layer.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 4 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 7 +++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 52653ad376fc..b0be246b44ab 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1079,7 +1079,7 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 	/* Halt the gmu cm3 core */
 	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);
 
-	a6xx_bus_clear_pending_transactions(adreno_gpu, true);
+	adreno_gpu->funcs->bus_halt(adreno_gpu, true);
 
 	/* Reset GPU core blocks */
 	a6xx_gpu_sw_reset(gpu, true);
@@ -1251,7 +1251,7 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 	if (ret)
 		goto force_off;
 
-	a6xx_bus_clear_pending_transactions(adreno_gpu, a6xx_gpu->hung);
+	adreno_gpu->funcs->bus_halt(adreno_gpu, a6xx_gpu->hung);
 
 	/* tell the GMU we want to slumber */
 	ret = a6xx_gmu_notify_slumber(gmu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index ba95b29855a3..575f2f9d3b1d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1595,7 +1595,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
 	if (adreno_has_gmu_wrapper(adreno_gpu) || adreno_has_rgmu(adreno_gpu)) {
 		/* Drain the outstanding traffic on memory buses */
-		a6xx_bus_clear_pending_transactions(adreno_gpu, true);
+		adreno_gpu->funcs->bus_halt(adreno_gpu, true);
 
 		/* Reset the GPU to a clean state */
 		a6xx_gpu_sw_reset(gpu, true);
@@ -2316,7 +2316,7 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 	mutex_lock(&a6xx_gpu->gmu.lock);
 
 	/* Drain the outstanding traffic on memory buses */
-	a6xx_bus_clear_pending_transactions(adreno_gpu, true);
+	adreno_gpu->funcs->bus_halt(adreno_gpu, true);
 
 	if (adreno_is_a619_holi(adreno_gpu))
 		a6xx_sptprac_disable(gmu);
@@ -2685,6 +2685,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
+	.bus_halt = a6xx_bus_clear_pending_transactions,
 };
 
 const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
@@ -2715,6 +2716,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_get_timestamp,
+	.bus_halt = a6xx_bus_clear_pending_transactions,
 };
 
 const struct adreno_gpu_funcs a7xx_gpu_funcs = {
@@ -2747,4 +2749,5 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
+	.bus_halt = a6xx_bus_clear_pending_transactions,
 };
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 335acd5feb82..08bb601b3bd3 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -77,6 +77,7 @@ struct adreno_gpu_funcs {
 	struct msm_gpu_funcs base;
 	struct msm_gpu *(*init)(struct drm_device *dev);
 	int (*get_timestamp)(struct msm_gpu *gpu, uint64_t *value);
+	void (*bus_halt)(struct adreno_gpu *adreno_gpu, bool gx_off);
 };
 
 struct adreno_reglist {

-- 
2.51.0

