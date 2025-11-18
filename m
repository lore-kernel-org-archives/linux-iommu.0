Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CB3126C8
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455999; cv=none; b=XAID7BgVEdaE8G/1L142INkGyD+WwY4qEUgjH7KY4z8gS+51jceM02TN3+6/QV5mDYeraacwiDQWAabo+S1tmEvtkyKGAWsoVD8xvaqJ+wlkY7sRGH56FwH5t4EVE/TL3MXprXBM6evskvUdtBJFOxie5SfSB7kv16EEo6Egjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455999; c=relaxed/simple;
	bh=2qp5AoAo/qQVsE3tG8Ep9+XuoxJnnHFPRYeeaqd6Nqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6hrqX0UHeAbE5gtSe9oS3Bd/gRKlJRTpyCjbUGrFE8c8iF8SsZa76IPuWdMC3xJ/x19K9WphLW8gDwDc3Gv8xBn/RMKCXW0Qzp32vbp8422d575O0mpBYPIxAIp0YnrQ/fS9xUdtYOXo3qjqcHU9nq3gaX1kiLXGFH2c6n76h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f/+a2tYa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LioJWTtB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f/+a2tYa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LioJWTtB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI64Zgs4107441
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TMp7HNJ/zmdg927vlU51I3Qx46lV/WtDLm/uWh7mI/8=; b=f/+a2tYaAlPmGDBQ
	3dzwibIQY+tUEYHZoY+WC4YuaO+r2P+oNELQgHGt1v0Q7A5GOykbNg68VAsBGJIK
	3CtVihFmJiL9s3XTzHMwvn78cDeUlyNE7SvMuoD+PwNtpR/ZJ/WWT/nYPAosWuZA
	betmw56hEufcJYABmTntbL0RWFXxdryouVIfucvEUMDwmqAFwxuYBmZCFU0bAdde
	O/46oxGTPjXd3WjkZ9mVlFRqdiIxmqi1m+8bTKZcodqmJZkcZ2eB0ru9+fc5FiuR
	GMO+6w/Rqbp45CzCnEAh0l1iPWxOwZbgO4qVrlm5RHhDllxyy0HUN7ImE26a7eUF
	GT4c7g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2hpbd8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:53:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29809acd049so90945635ad.3
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763455994; x=1764060794; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMp7HNJ/zmdg927vlU51I3Qx46lV/WtDLm/uWh7mI/8=;
        b=LioJWTtB7dec7sDB6tsZRymnREkKcp17wUNzuFltak6udHivhN57oFb+e0lrBqnH/S
         PNiaA92QaAB1cB3CYStdQLBRY2LJoaG5kbllVlGEEfnxVLdFLSHvmdMu3uMmfOgGc95M
         8LIVpkOVXGnatrkLWnbeTH6h3ccKksgnAZzpkDTBql6braiKicywcnjn3HXDoLSDTMGj
         WHofl3brEjI9PA/QTFYuaPiEi93hereBed3cyuFeK3qT6utS5RDsFBL/8DgzktmqmGo+
         zxwbG/DgGiflgsyKN99K2yNyq7KxF4j4xG9QkkDE6ozOf20DMgicBZBDpApDcZXJH/+4
         UXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455994; x=1764060794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TMp7HNJ/zmdg927vlU51I3Qx46lV/WtDLm/uWh7mI/8=;
        b=qyPlj54++JQRY+Ep1pXAzNWJw3lHvN1PcdtjM9IkoEi3s9KTn7EoJsx//8KyMwl2Ua
         tBcVVVirKrty7l3lKcI6/aW/gWb+7oHdI2G96a86RWvYW86+C0BBix8LOX/ktHx4WhY1
         5NzwAd1+ffuCtXUNz7ZEDBENf6V4GUqicKvG9cdiGMb7zzzCgFGnJucHpczKl2zqTC3R
         0pRuyXzNw51LfTFq6DoOznZ58MFEweKSZoAgvdlqZVBZ9LScSPWuKDH2TCeG3nTZF2qK
         bV7ojF7saLlQD8IaSzUxlCfpGOkE8rCrGPSUoDokOYOnJvqXjFQiHNrS2le/xI0zao0O
         BhCA==
X-Forwarded-Encrypted: i=1; AJvYcCWBa9xgU4rz+E7ODp6MPZ1YyTQwHiNjjN++6R3tcP7ikE+WceHObnnS6AuRXFE9zzjdTGGyXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw0dCOaf0/x9W3zpGap7gxw/nTWE8jNMu8qX2N6KZl8SLEnSzI
	WTPs/BkSshpWAvEbEdGDtoS45qH8Aum1r/R/szhizpOLBLXkXr+midO5luu659OtyumcI+VheTH
	q8Cu3wQGhf0gKAQqwqOEFYg9Dk2eLJmvcIZaOBJNxUwbCK3sJJvFsSnAaHA==
X-Gm-Gg: ASbGnctOl2B33CeCzOrj/lo9JttEGGlBKKq1x3XOvlF9mL4qdw/eXN1wSDxOeuijPG3
	1Ry4aAXiibEYLCWK6dlsZrrrjrbYRW8lxwApn3/TdJ3l8NhDH9wUzU/NWymh4KpXa1UGnPMHNM/
	3uRFxV1ry6XaKas02DpiH84HXQWLBbnTKSbPL5aFpeOKLwzRoGSQI0wxY6QFfnXUqwDKw0SB9mh
	ptEC4qfoWEr6lW4Z/KCdnnDsYEjuzKR7lU3bQcOqIsRPV+IyIQLTcsoW7eGJjSkII2StUf1tMpT
	VJVxzn798OIHdcuAztM6kgAOKOXsT+Ywr9zxjFi/e3EwRfl+Dix/5xFoY/x4Fo34sPuX50NLkfs
	D6jiGSw74nSHXQ1f/61pSZos=
X-Received: by 2002:a17:902:f641:b0:295:9383:543 with SMTP id d9443c01a7336-2986a6f263fmr177242675ad.27.1763455994447;
        Tue, 18 Nov 2025 00:53:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUkzxk34yLBaUiwOncHo2aD71jLBaEEhzYr/v3YEhhdmJO40Uy+Hz/k4WFRUhKYfUH+Zvrzg==
X-Received: by 2002:a17:902:f641:b0:295:9383:543 with SMTP id d9443c01a7336-2986a6f263fmr177242265ad.27.1763455993887;
        Tue, 18 Nov 2025 00:53:13 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:53:13 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:42 +0530
Subject: [PATCH v4 15/22] drm/msm/adreno: Support AQE engine
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-15-86eeb8e93fb6@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=3403;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2qp5AoAo/qQVsE3tG8Ep9+XuoxJnnHFPRYeeaqd6Nqw=;
 b=pITi3Rkt3UiF+9XwRl45qofQch1DIPinzsKbn6E7GtKqqlpYXha4M9LbQiAib7Jj/UqLM0eJ3
 1HVGec8z5ImAEZ3+mtrH8YeYQrN6lFRF39+iy8ewiQ1oUFPO2bhFvCr
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: YDYUJuOzVAGk8ZsmGHxw1jiQdfBMhZWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX9zARCA6nsH5Y
 Fyc3z3sFpLI6ML7AKMyPzsDpenw4tnNpZkSgwJj8ti7tBdtINWH7g7lp05qdc4+nrZVq05siIP9
 KZedljRVUB+YHGe2xsAVwQyOq6EtG6mi6nq2XZ98LzDArF3sx2/9mBhtt3o1bgL1pPBXNOhGy6V
 5OLXqF4FPqFXZ6gGHJoWusWFzjZP+8b4v+ty9DzBWskXKyVBZerFPQDlV6b5yZEhF4C2U6J1gVZ
 pPYuj7HxVrlPKnd5/chJzyjC1ziRJqOw2llhRaWrIxFeF/7qUgAl2BP/U+sLwfqZxbz1qy+Evon
 jMtx4k5Uq0VIR8cO9w+07gtWJrMpQLrbOJEPBKgRsvHYHbfkgU5CZgPzeX/YeItzAkZ20QvboyG
 2gF6uJg/rvxj8mTHW+anmsg+lCoyhA==
X-Proofpoint-ORIG-GUID: YDYUJuOzVAGk8ZsmGHxw1jiQdfBMhZWW
X-Authority-Analysis: v=2.4 cv=Y5L1cxeN c=1 sm=1 tr=0 ts=691c33fb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=qCSIj6eo76QuOecuVwMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180069

AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
in Raytracing related workloads. Add support for loading the AQE firmware
and initialize the necessary registers.

Since AQE engine has dependency on preemption context records, expose
Raytracing support to userspace only when preemption is enabled.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 ++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c   |  3 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
 4 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 810b64b909f5..9a643bcccdcf 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1118,6 +1118,23 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		}
 	}
 
+	if (!a6xx_gpu->aqe_bo && adreno_gpu->fw[ADRENO_FW_AQE]) {
+		a6xx_gpu->aqe_bo = adreno_fw_create_bo(gpu,
+			adreno_gpu->fw[ADRENO_FW_AQE], &a6xx_gpu->aqe_iova);
+
+		if (IS_ERR(a6xx_gpu->aqe_bo)) {
+			int ret = PTR_ERR(a6xx_gpu->aqe_bo);
+
+			a6xx_gpu->aqe_bo = NULL;
+			DRM_DEV_ERROR(&gpu->pdev->dev,
+				"Could not allocate AQE ucode: %d\n", ret);
+
+			return ret;
+		}
+
+		msm_gem_object_set_name(a6xx_gpu->aqe_bo, "aqefw");
+	}
+
 	/*
 	 * Expanded APRIV and targets that support WHERE_AM_I both need a
 	 * privileged buffer to store the RPTR shadow
@@ -2400,6 +2417,11 @@ static void a6xx_destroy(struct msm_gpu *gpu)
 		drm_gem_object_put(a6xx_gpu->sqe_bo);
 	}
 
+	if (a6xx_gpu->aqe_bo) {
+		msm_gem_unpin_iova(a6xx_gpu->aqe_bo, gpu->vm);
+		drm_gem_object_put(a6xx_gpu->aqe_bo);
+	}
+
 	if (a6xx_gpu->shadow_bo) {
 		msm_gem_unpin_iova(a6xx_gpu->shadow_bo, gpu->vm);
 		drm_gem_object_put(a6xx_gpu->shadow_bo);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index e6218b0b9732..3a054fcdeb4a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -59,6 +59,8 @@ struct a6xx_gpu {
 
 	struct drm_gem_object *sqe_bo;
 	uint64_t sqe_iova;
+	struct drm_gem_object *aqe_bo;
+	uint64_t aqe_iova;
 
 	struct msm_ringbuffer *cur_ring;
 	struct msm_ringbuffer *next_ring;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index c9cd7546024a..e011e80ceb50 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -627,6 +627,9 @@ static int hw_init(struct msm_gpu *gpu)
 		goto out;
 
 	gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
+	if (a6xx_gpu->aqe_iova)
+		gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->aqe_iova);
+
 	/* Set the ringbuffer address */
 	gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
 	gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index c496b63ffd41..0aca222c46bc 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -27,6 +27,7 @@ enum {
 	ADRENO_FW_PFP = 1,
 	ADRENO_FW_GMU = 1, /* a6xx */
 	ADRENO_FW_GPMU = 2,
+	ADRENO_FW_AQE = 3,
 	ADRENO_FW_MAX,
 };
 

-- 
2.51.0

