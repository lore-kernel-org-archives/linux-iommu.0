Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2D326D4A
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076629; cv=none; b=YHXZ139HUXMWjkTlpoNJzbNq5yssjM3RNdtN0k/W1X270GH6jFpMr+/KklI4Q4gieUix9zltB3ANJZi/uSjl0KP+4geOGkW3mHgvwLP4KUKWfMk8p8UXsJpt1nHu54BlXNVe3ZNAzpoRqAdjqOfUqG0muY5mb4s+mVhVi1VyE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076629; c=relaxed/simple;
	bh=f9UwdlxaJOvuqQXSOKd85498qqDA86VRMl/2w8HqR50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqY5pFJTza9+C/kH4ZUv1qZepmFA819/z2aL74g+tgz3Ahd3mfWtWiv8ublJsX9kJ2z7J7BPN2Bx3mei+GcwBKI6GnFJRFNE+ojMdoh6i8gWNsd0Vdpca63SDLd9jk2PMEpTS+5rPnerU0zOGOoSc2ri+BiYBQsjp1Sg/ugznA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WFZjgxxl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=itO1AhZU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WFZjgxxl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="itO1AhZU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMaWJW1611847
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s0/SUawhWtFQ1nVOih0dds5gvk9a699PIz28sJsNMdQ=; b=WFZjgxxltLePD7Uj
	fnRVPTqYdg9iy1XBEHCdo4ktt9c5kQ5LBsnyJHO+xbuaJJkWcNoymgYTevmPYg/f
	KYbjU8Tx+Kq4mv9cGzQJXVYZByNMcnGrXCelHyotqAcYUDecBmgZPGXJZQB20XPP
	BKTbaldxlEwQOjvsRG06T1CBTfbqPhJqjxrvnr2WYGTLc1mexEZbsnvaVoMvA+0/
	eNZGh+4zZtbAAbNbYhrO8jFUvD0GsLjtEnJJP3k30+EyRIk3u5TTbaJICxyrvFe7
	eU42zUjkX23haNfY8TkcbiKw7CgWETSi48yO/Cwbb/zna7nPfCpkYVvHRPuo7k4F
	yxJi0Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9bg40s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:30:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343806688cbso1975362a91.3
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076623; x=1763681423; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0/SUawhWtFQ1nVOih0dds5gvk9a699PIz28sJsNMdQ=;
        b=itO1AhZUkBF8Dnu6zdIPnWv3Ztx733KAJ8BmE2PWOc+5+zF2pbnmj/aymAHAv0TKg/
         VwtJ79UQH+XmllutGsCk3aVv99upq5GjF+hNH+F2QybQ4QmxGRZHpS4SRSiirFvG+r7t
         sGUjgJMB8UozFAQRE498V0voV6N/cGD8WDhK/oMZgF6/w0oiVp9ejR9ff9T9zgROoa8X
         +rASUPIecncCOR940f3NTobXVmrwhF1lvgb/g0/9YhbXt9vFVYZX4CavXa4btm+MlVwr
         nvOpsBpjwsMeQC6phpGpsEvOFxJX5ACuMb3+s8C2z790m/Gt/ufrvCY36UVp9GeKdliw
         DzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076623; x=1763681423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0/SUawhWtFQ1nVOih0dds5gvk9a699PIz28sJsNMdQ=;
        b=mQ+qjlExBI2bGr0skebQ0SeKcqU1LZkzI9GXMADTiUOv/VnnwQWvarSA2tejG0cuN5
         nvzRYkE927ojMa7aYlADw1yJK3pZflGwUNTQ4ZwZr1k6GZI/DxtY21ld/1hwRKJEfi1c
         lfCUhDmEc0ONsYHqs/ZKied7IF9VmdECObviy1wrtVD+JlXQmFEd3JAHyOHxTJhlHlly
         tjlEs3Ec16+vk/XRdwvzfNGh+CDvnY3kspU2I4GVzs/oQ+40et/WOz3hyRaEtf8UplHr
         ouMwD5EzmIe9vf2pd5hw2i19L9ZDshj54Wxa5znEhdOeZBYPmsx9BIw2sN+Lg/jqM7XB
         //Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWtfXS8T+qGnwsLDooxTTOvM2bInXqBf5RsrJz9LIHwArl+QB4DOht49L3FI7DoBB1lZZz09g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxt/rPEnbSiaiHUrvBIlw/efzaJucHQsjfHcDVAtRAFxtHeqUBm
	9c+tLQKTox8/ol4xbm7J2OM2ZzOl1GSEmJWm8wsga6o5FMStANNnVgZm7sR7IAg3ogfleyKWQdo
	uut40HDAdFxFCcnV1w5IaWl8E4akX7ettfs4yV7GmFBELc7mqJLhUjbG54g==
X-Gm-Gg: ASbGncvhabXdY8KaGUmnD0p3IfeHKrdwcEldLLGEFZ9GZG7LA2/ml83MiO7H0UQrGmm
	14LKq8IKIgCup7ejZQprWw0yvzt9JB/gp5LOOhaE0P2oJy9PG1ZPd/v1C9bFXxEW60Skwlr3kco
	3wYdJXeYVUo6WpO+gO1AKH9L/DulgP8IZm7x1bCDUGyf8VKi7y96jN/2dwASKe8fzYWqV+Mtok9
	egLx4yy259OnruYmQMTYw+C3zSVghj/QtpYtOTFrMOjWOU19q4lk7NPeSbS7Cg9K4M1czQNah3I
	Sxymy5Sa38V1rLpyrbl5smmpeezvF4DkByu2XXvIHwwnTzhiY+gLs1053u0W7JleISC7K0IbzA6
	bQrfez2HrClsY6ARhcxmMdY0=
X-Received: by 2002:a17:90b:5684:b0:340:c261:f9f3 with SMTP id 98e67ed59e1d1-343fa0ded74mr954120a91.14.1763076622824;
        Thu, 13 Nov 2025 15:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0hMRocQ7yBIQN7+okwdsB4P2HQf2hghDV2oPMvlwRJt8NtVRhxCQdOR3XmSpS2gqhkfw84Q==
X-Received: by 2002:a17:90b:5684:b0:340:c261:f9f3 with SMTP id 98e67ed59e1d1-343fa0ded74mr954079a91.14.1763076622167;
        Thu, 13 Nov 2025 15:30:22 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:30:21 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 04:59:02 +0530
Subject: [PATCH v3 05/20] drm/msm/adreno: Move adreno_gpu_func to catalogue
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kaana-gpu-support-v3-5-92300c7ec8ff@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076574; l=39388;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=f9UwdlxaJOvuqQXSOKd85498qqDA86VRMl/2w8HqR50=;
 b=CaGcwKg10Q6PIDDcCJ2mNOZj926oy2cxxvrENuR2HJK1BV/XAo1iE3WGGcgqyBuOIlgnkLH7a
 MpEAifQZpQqDU4Y2lz6DhCK/Ky+qXqj+IAByFO9h5cLkrA8wCszMihB
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=aJz9aL9m c=1 sm=1 tr=0 ts=69166a10 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ZW5s_5jsAU3U6Z_Cp8gA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: _Fd0QTBiY3EO5h5K3nv3YCEHrIJalN0x
X-Proofpoint-ORIG-GUID: _Fd0QTBiY3EO5h5K3nv3YCEHrIJalN0x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX5mX00WgNJHNH
 znYb9ECiQYgnd7VEfIy7uNSgLPcf0BlaE9iPRMCToDIVqeVp6/eEMAOJGYI6+wFWVf7aFnkm3d9
 N0dSzes9qbTOkeilJ/asF/27gwBhbWz7dirzw0vwAaOVP8C0PjVDn8Eb4tTIaEEeUAduD4a3isg
 ZaeFwb2SgVZqOn4X3w0iVc8Wu3P4f+IDzIdHxGqcYRhHOqCVKISqMYPAtIv/RfQzFKjS4XbJqYc
 rr0+yXSdaA8vbwm5m4t27ZMEZNaiMg/CiLIUdc4fry3z3YR8C9o9IKzGEzRNKhQUjoX73xW2QqA
 Kvp7Jg0e1baFo8EaMsv9MKwU/g5mQXdBI4w+X2PYJwSL5Z3RwnkfMARz53lwsKNaIsyvMPA2BKn
 YGdTZUnVbfg7+UMMa1GPLetbWpzwOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130185

In A6x family (which is a pretty big one), there are separate
adreno_func definitions for each sub-generations. To streamline the
identification of the correct struct for a gpu, move it to the
catalogue and move the gpu_init routine to struct adreno_gpu_funcs.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |   7 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c      |  50 +++----
 drivers/gpu/drm/msm/adreno/a2xx_gpu.h      |   2 +
 drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |  13 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c      |  52 ++++----
 drivers/gpu/drm/msm/adreno/a3xx_gpu.h      |   2 +
 drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |   7 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c      |  54 ++++----
 drivers/gpu/drm/msm/adreno/a4xx_gpu.h      |   2 +
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c  |  17 +--
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |  61 ++++-----
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h      |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  |  46 +++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 201 ++++++++++++++---------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   4 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  11 +-
 17 files changed, 274 insertions(+), 258 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
index 5ddd015f930d..e9dbf3ddf89e 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
@@ -7,6 +7,7 @@
  */
 
 #include "adreno_gpu.h"
+#include "a2xx_gpu.h"
 
 static const struct adreno_info a2xx_gpus[] = {
 	{
@@ -19,7 +20,7 @@ static const struct adreno_info a2xx_gpus[] = {
 		},
 		.gmem  = SZ_256K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a2xx_gpu_init,
+		.funcs = &a2xx_gpu_funcs,
 	}, { /* a200 on i.mx51 has only 128kib gmem */
 		.chip_ids = ADRENO_CHIP_IDS(0x02000001),
 		.family = ADRENO_2XX_GEN1,
@@ -30,7 +31,7 @@ static const struct adreno_info a2xx_gpus[] = {
 		},
 		.gmem  = SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a2xx_gpu_init,
+		.funcs = &a2xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x02020000),
 		.family = ADRENO_2XX_GEN2,
@@ -41,7 +42,7 @@ static const struct adreno_info a2xx_gpus[] = {
 		},
 		.gmem  = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a2xx_gpu_init,
+		.funcs = &a2xx_gpu_funcs,
 	}
 };
 DECLARE_ADRENO_GPULIST(a2xx);
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index ec38db45d8a3..7082052f715e 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -486,39 +486,18 @@ static u32 a2xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr;
 }
 
-static const struct adreno_gpu_funcs funcs = {
-	.base = {
-		.get_param = adreno_get_param,
-		.set_param = adreno_set_param,
-		.hw_init = a2xx_hw_init,
-		.pm_suspend = msm_gpu_pm_suspend,
-		.pm_resume = msm_gpu_pm_resume,
-		.recover = a2xx_recover,
-		.submit = a2xx_submit,
-		.active_ring = adreno_active_ring,
-		.irq = a2xx_irq,
-		.destroy = a2xx_destroy,
-#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
-		.show = adreno_show,
-#endif
-		.gpu_state_get = a2xx_gpu_state_get,
-		.gpu_state_put = adreno_gpu_state_put,
-		.create_vm = a2xx_create_vm,
-		.get_rptr = a2xx_get_rptr,
-	},
-};
-
 static const struct msm_gpu_perfcntr perfcntrs[] = {
 /* TODO */
 };
 
-struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
+static struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 {
 	struct a2xx_gpu *a2xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
+	struct adreno_platform_config *config = pdev->dev.platform_data;
 	int ret;
 
 	if (!pdev) {
@@ -539,7 +518,7 @@ struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 	gpu->perfcntrs = perfcntrs;
 	gpu->num_perfcntrs = ARRAY_SIZE(perfcntrs);
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, config->info->funcs, 1);
 	if (ret)
 		goto fail;
 
@@ -558,3 +537,26 @@ struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 
 	return ERR_PTR(ret);
 }
+
+const struct adreno_gpu_funcs a2xx_gpu_funcs = {
+	.base = {
+		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
+		.hw_init = a2xx_hw_init,
+		.pm_suspend = msm_gpu_pm_suspend,
+		.pm_resume = msm_gpu_pm_resume,
+		.recover = a2xx_recover,
+		.submit = a2xx_submit,
+		.active_ring = adreno_active_ring,
+		.irq = a2xx_irq,
+		.destroy = a2xx_destroy,
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
+		.show = adreno_show,
+#endif
+		.gpu_state_get = a2xx_gpu_state_get,
+		.gpu_state_put = adreno_gpu_state_put,
+		.create_vm = a2xx_create_vm,
+		.get_rptr = a2xx_get_rptr,
+	},
+	.init = a2xx_gpu_init,
+};
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.h b/drivers/gpu/drm/msm/adreno/a2xx_gpu.h
index 53702f19990f..162ef98951f5 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.h
@@ -19,6 +19,8 @@ struct a2xx_gpu {
 };
 #define to_a2xx_gpu(x) container_of(x, struct a2xx_gpu, base)
 
+extern const struct adreno_gpu_funcs a2xx_gpu_funcs;
+
 struct msm_mmu *a2xx_gpummu_new(struct device *dev, struct msm_gpu *gpu);
 void a2xx_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
 		dma_addr_t *tran_error);
diff --git a/drivers/gpu/drm/msm/adreno/a3xx_catalog.c b/drivers/gpu/drm/msm/adreno/a3xx_catalog.c
index 1498e6532f62..6ae8716fc08a 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_catalog.c
@@ -7,6 +7,7 @@
  */
 
 #include "adreno_gpu.h"
+#include "a3xx_gpu.h"
 
 static const struct adreno_info a3xx_gpus[] = {
 	{
@@ -18,7 +19,7 @@ static const struct adreno_info a3xx_gpus[] = {
 		},
 		.gmem  = SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
+		.funcs = &a3xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x03000520),
 		.family = ADRENO_3XX,
@@ -29,7 +30,7 @@ static const struct adreno_info a3xx_gpus[] = {
 		},
 		.gmem  = SZ_256K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
+		.funcs = &a3xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x03000600),
 		.family = ADRENO_3XX,
@@ -40,7 +41,7 @@ static const struct adreno_info a3xx_gpus[] = {
 		},
 		.gmem  = SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
+		.funcs = &a3xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x03000620),
 		.family = ADRENO_3XX,
@@ -51,7 +52,7 @@ static const struct adreno_info a3xx_gpus[] = {
 		},
 		.gmem = SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a3xx_gpu_init,
+		.funcs = &a3xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(
 			0x03020000,
@@ -66,7 +67,7 @@ static const struct adreno_info a3xx_gpus[] = {
 		},
 		.gmem  = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
+		.funcs = &a3xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(
 			0x03030000,
@@ -81,7 +82,7 @@ static const struct adreno_info a3xx_gpus[] = {
 		},
 		.gmem  = SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
+		.funcs = &a3xx_gpu_funcs,
 	}
 };
 DECLARE_ADRENO_GPULIST(a3xx);
diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index a956cd79195e..f22d33e99e81 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -508,29 +508,6 @@ static u32 a3xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr;
 }
 
-static const struct adreno_gpu_funcs funcs = {
-	.base = {
-		.get_param = adreno_get_param,
-		.set_param = adreno_set_param,
-		.hw_init = a3xx_hw_init,
-		.pm_suspend = msm_gpu_pm_suspend,
-		.pm_resume = msm_gpu_pm_resume,
-		.recover = a3xx_recover,
-		.submit = a3xx_submit,
-		.active_ring = adreno_active_ring,
-		.irq = a3xx_irq,
-		.destroy = a3xx_destroy,
-#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
-		.show = adreno_show,
-#endif
-		.gpu_busy = a3xx_gpu_busy,
-		.gpu_state_get = a3xx_gpu_state_get,
-		.gpu_state_put = adreno_gpu_state_put,
-		.create_vm = adreno_create_vm,
-		.get_rptr = a3xx_get_rptr,
-	},
-};
-
 static const struct msm_gpu_perfcntr perfcntrs[] = {
 	{ REG_A3XX_SP_PERFCOUNTER6_SELECT, REG_A3XX_RBBM_PERFCTR_SP_6_LO,
 			SP_ALU_ACTIVE_CYCLES, "ALUACTIVE" },
@@ -538,13 +515,14 @@ static const struct msm_gpu_perfcntr perfcntrs[] = {
 			SP_FS_FULL_ALU_INSTRUCTIONS, "ALUFULL" },
 };
 
-struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
+static struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
 {
 	struct a3xx_gpu *a3xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
+	struct adreno_platform_config *config = pdev->dev.platform_data;
 	struct icc_path *ocmem_icc_path;
 	struct icc_path *icc_path;
 	int ret;
@@ -569,7 +547,7 @@ struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
 
 	adreno_gpu->registers = a3xx_registers;
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, config->info->funcs, 1);
 	if (ret)
 		goto fail;
 
@@ -613,3 +591,27 @@ struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
 
 	return ERR_PTR(ret);
 }
+
+const struct adreno_gpu_funcs a3xx_gpu_funcs = {
+	.base = {
+		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
+		.hw_init = a3xx_hw_init,
+		.pm_suspend = msm_gpu_pm_suspend,
+		.pm_resume = msm_gpu_pm_resume,
+		.recover = a3xx_recover,
+		.submit = a3xx_submit,
+		.active_ring = adreno_active_ring,
+		.irq = a3xx_irq,
+		.destroy = a3xx_destroy,
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
+		.show = adreno_show,
+#endif
+		.gpu_busy = a3xx_gpu_busy,
+		.gpu_state_get = a3xx_gpu_state_get,
+		.gpu_state_put = adreno_gpu_state_put,
+		.create_vm = adreno_create_vm,
+		.get_rptr = a3xx_get_rptr,
+	},
+	.init = a3xx_gpu_init,
+};
diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.h b/drivers/gpu/drm/msm/adreno/a3xx_gpu.h
index c555fb13e0d7..3d4ec9dbd918 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.h
@@ -23,4 +23,6 @@ struct a3xx_gpu {
 };
 #define to_a3xx_gpu(x) container_of(x, struct a3xx_gpu, base)
 
+extern const struct adreno_gpu_funcs a3xx_gpu_funcs;
+
 #endif /* __A3XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_catalog.c b/drivers/gpu/drm/msm/adreno/a4xx_catalog.c
index 09f9f228b75e..9192586f7ef0 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_catalog.c
@@ -7,6 +7,7 @@
  */
 
 #include "adreno_gpu.h"
+#include "a4xx_gpu.h"
 
 static const struct adreno_info a4xx_gpus[] = {
 	{
@@ -19,7 +20,7 @@ static const struct adreno_info a4xx_gpus[] = {
 		},
 		.gmem  = SZ_256K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a4xx_gpu_init,
+		.funcs = &a4xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x04020000),
 		.family = ADRENO_4XX,
@@ -30,7 +31,7 @@ static const struct adreno_info a4xx_gpus[] = {
 		},
 		.gmem  = (SZ_1M + SZ_512K),
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a4xx_gpu_init,
+		.funcs = &a4xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x04030002),
 		.family = ADRENO_4XX,
@@ -41,7 +42,7 @@ static const struct adreno_info a4xx_gpus[] = {
 		},
 		.gmem  = (SZ_1M + SZ_512K),
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a4xx_gpu_init,
+		.funcs = &a4xx_gpu_funcs,
 	}
 };
 DECLARE_ADRENO_GPULIST(a4xx);
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index 83f6329accba..db06c06067ae 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -627,37 +627,14 @@ static u32 a4xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr;
 }
 
-static const struct adreno_gpu_funcs funcs = {
-	.base = {
-		.get_param = adreno_get_param,
-		.set_param = adreno_set_param,
-		.hw_init = a4xx_hw_init,
-		.pm_suspend = a4xx_pm_suspend,
-		.pm_resume = a4xx_pm_resume,
-		.recover = a4xx_recover,
-		.submit = a4xx_submit,
-		.active_ring = adreno_active_ring,
-		.irq = a4xx_irq,
-		.destroy = a4xx_destroy,
-#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
-		.show = adreno_show,
-#endif
-		.gpu_busy = a4xx_gpu_busy,
-		.gpu_state_get = a4xx_gpu_state_get,
-		.gpu_state_put = adreno_gpu_state_put,
-		.create_vm = adreno_create_vm,
-		.get_rptr = a4xx_get_rptr,
-	},
-	.get_timestamp = a4xx_get_timestamp,
-};
-
-struct msm_gpu *a4xx_gpu_init(struct drm_device *dev)
+static struct msm_gpu *a4xx_gpu_init(struct drm_device *dev)
 {
 	struct a4xx_gpu *a4xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
+	struct adreno_platform_config *config = pdev->dev.platform_data;
 	struct icc_path *ocmem_icc_path;
 	struct icc_path *icc_path;
 	int ret;
@@ -680,7 +657,7 @@ struct msm_gpu *a4xx_gpu_init(struct drm_device *dev)
 	gpu->perfcntrs = NULL;
 	gpu->num_perfcntrs = 0;
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, config->info->funcs, 1);
 	if (ret)
 		goto fail;
 
@@ -726,3 +703,28 @@ struct msm_gpu *a4xx_gpu_init(struct drm_device *dev)
 
 	return ERR_PTR(ret);
 }
+
+const struct adreno_gpu_funcs a4xx_gpu_funcs = {
+	.base = {
+		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
+		.hw_init = a4xx_hw_init,
+		.pm_suspend = a4xx_pm_suspend,
+		.pm_resume = a4xx_pm_resume,
+		.recover = a4xx_recover,
+		.submit = a4xx_submit,
+		.active_ring = adreno_active_ring,
+		.irq = a4xx_irq,
+		.destroy = a4xx_destroy,
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
+		.show = adreno_show,
+#endif
+		.gpu_busy = a4xx_gpu_busy,
+		.gpu_state_get = a4xx_gpu_state_get,
+		.gpu_state_put = adreno_gpu_state_put,
+		.create_vm = adreno_create_vm,
+		.get_rptr = a4xx_get_rptr,
+	},
+	.init = a4xx_gpu_init,
+	.get_timestamp = a4xx_get_timestamp,
+};
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.h b/drivers/gpu/drm/msm/adreno/a4xx_gpu.h
index a01448cba2ea..71b164439f62 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.h
@@ -20,4 +20,6 @@ struct a4xx_gpu {
 };
 #define to_a4xx_gpu(x) container_of(x, struct a4xx_gpu, base)
 
+extern const struct adreno_gpu_funcs a4xx_gpu_funcs;
+
 #endif /* __A4XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
index b48a636d8237..babd320f3b73 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
@@ -7,6 +7,7 @@
  */
 
 #include "adreno_gpu.h"
+#include "a5xx_gpu.h"
 
 static const struct adreno_info a5xx_gpus[] = {
 	{
@@ -21,7 +22,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
 			  ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
+		.funcs = &a5xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x05000600),
 		.family = ADRENO_5XX,
@@ -38,7 +39,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		.inactive_period = 250,
 		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
 			  ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
+		.funcs = &a5xx_gpu_funcs,
 		.zapfw = "a506_zap.mdt",
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x05000800),
@@ -55,7 +56,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		 */
 		.inactive_period = 250,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
+		.funcs = &a5xx_gpu_funcs,
 		.zapfw = "a508_zap.mdt",
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x05000900),
@@ -72,7 +73,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		 */
 		.inactive_period = 250,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
+		.funcs = &a5xx_gpu_funcs,
 		/* Adreno 509 uses the same ZAP as 512 */
 		.zapfw = "a512_zap.mdt",
 	}, {
@@ -89,7 +90,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		 * the GDSC which appears to make it grumpy
 		 */
 		.inactive_period = 250,
-		.init = a5xx_gpu_init,
+		.funcs = &a5xx_gpu_funcs,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x05010200),
 		.family = ADRENO_5XX,
@@ -105,7 +106,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		 */
 		.inactive_period = 250,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
+		.funcs = &a5xx_gpu_funcs,
 		.zapfw = "a512_zap.mdt",
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(
@@ -127,7 +128,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		.inactive_period = 250,
 		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
 			ADRENO_QUIRK_FAULT_DETECT_MASK,
-		.init = a5xx_gpu_init,
+		.funcs = &a5xx_gpu_funcs,
 		.zapfw = "a530_zap.mdt",
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x05040001),
@@ -145,7 +146,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		 */
 		.inactive_period = 250,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
+		.funcs = &a5xx_gpu_funcs,
 		.zapfw = "a540_zap.mdt",
 	}
 };
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 4a04dc43a8e6..56eaff2ee4e4 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1691,34 +1691,6 @@ static uint32_t a5xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr = gpu_read(gpu, REG_A5XX_CP_RB_RPTR);
 }
 
-static const struct adreno_gpu_funcs funcs = {
-	.base = {
-		.get_param = adreno_get_param,
-		.set_param = adreno_set_param,
-		.hw_init = a5xx_hw_init,
-		.ucode_load = a5xx_ucode_load,
-		.pm_suspend = a5xx_pm_suspend,
-		.pm_resume = a5xx_pm_resume,
-		.recover = a5xx_recover,
-		.submit = a5xx_submit,
-		.active_ring = a5xx_active_ring,
-		.irq = a5xx_irq,
-		.destroy = a5xx_destroy,
-#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
-		.show = a5xx_show,
-#endif
-#if defined(CONFIG_DEBUG_FS)
-		.debugfs_init = a5xx_debugfs_init,
-#endif
-		.gpu_busy = a5xx_gpu_busy,
-		.gpu_state_get = a5xx_gpu_state_get,
-		.gpu_state_put = a5xx_gpu_state_put,
-		.create_vm = adreno_create_vm,
-		.get_rptr = a5xx_get_rptr,
-	},
-	.get_timestamp = a5xx_get_timestamp,
-};
-
 static void check_speed_bin(struct device *dev)
 {
 	struct nvmem_cell *cell;
@@ -1751,7 +1723,7 @@ static void check_speed_bin(struct device *dev)
 	devm_pm_opp_set_supported_hw(dev, &val, 1);
 }
 
-struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
+static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
@@ -1781,7 +1753,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 	if (config->info->revn == 510)
 		nr_rings = 1;
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, nr_rings);
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, config->info->funcs, nr_rings);
 	if (ret) {
 		a5xx_destroy(&(a5xx_gpu->base.base));
 		return ERR_PTR(ret);
@@ -1806,3 +1778,32 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	return gpu;
 }
+
+const struct adreno_gpu_funcs a5xx_gpu_funcs = {
+	.base = {
+		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
+		.hw_init = a5xx_hw_init,
+		.ucode_load = a5xx_ucode_load,
+		.pm_suspend = a5xx_pm_suspend,
+		.pm_resume = a5xx_pm_resume,
+		.recover = a5xx_recover,
+		.submit = a5xx_submit,
+		.active_ring = a5xx_active_ring,
+		.irq = a5xx_irq,
+		.destroy = a5xx_destroy,
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
+		.show = a5xx_show,
+#endif
+#if defined(CONFIG_DEBUG_FS)
+		.debugfs_init = a5xx_debugfs_init,
+#endif
+		.gpu_busy = a5xx_gpu_busy,
+		.gpu_state_get = a5xx_gpu_state_get,
+		.gpu_state_put = a5xx_gpu_state_put,
+		.create_vm = adreno_create_vm,
+		.get_rptr = a5xx_get_rptr,
+	},
+	.init = a5xx_gpu_init,
+	.get_timestamp = a5xx_get_timestamp,
+};
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index 9c0d701fe4b8..407bb950d350 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -133,6 +133,7 @@ struct a5xx_preempt_record {
  */
 #define A5XX_PREEMPT_COUNTER_SIZE (16 * 4)
 
+extern const struct adreno_gpu_funcs a5xx_gpu_funcs;
 
 int a5xx_power_init(struct msm_gpu *gpu);
 void a5xx_gpmu_ucode_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 44df6410bce1..9007a0e82a59 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -683,7 +683,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = (SZ_128K + SZ_4K),
 		.quirks = ADRENO_QUIRK_4GB_VA,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gmuwrapper_funcs,
 		.zapfw = "a610_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a612_hwcg,
@@ -716,7 +716,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = SZ_512K,
 		.quirks = ADRENO_QUIRK_4GB_VA,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a615_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a615_hwcg,
@@ -747,7 +747,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_4GB_VA,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a615_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a615_hwcg,
@@ -774,7 +774,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_4GB_VA,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a630_protect,
 			.gmu_cgc_mode = 0x00000222,
@@ -797,7 +797,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = SZ_512K,
 		.quirks = ADRENO_QUIRK_4GB_VA,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a615_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a615_hwcg,
@@ -822,7 +822,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = SZ_512K,
 		.quirks = ADRENO_QUIRK_4GB_VA,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a615_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a615_hwcg,
@@ -847,7 +847,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_4GB_VA,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a615_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a615_hwcg,
@@ -873,7 +873,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a620_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a620_hwcg,
@@ -896,7 +896,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a690_hwcg,
 			.protect = &a650_protect,
@@ -933,7 +933,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_4GB_VA,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a630_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a630_hwcg,
@@ -953,7 +953,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_4GB_VA,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a640_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a640_hwcg,
@@ -977,7 +977,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a650_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a650_hwcg,
@@ -1003,7 +1003,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a660_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a660_hwcg,
@@ -1022,7 +1022,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a690_hwcg,
 			.protect = &a660_protect,
@@ -1045,7 +1045,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a660_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a660_hwcg,
@@ -1072,7 +1072,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_4GB_VA,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a640_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a640_hwcg,
@@ -1091,7 +1091,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a690_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a690_hwcg,
@@ -1426,7 +1426,7 @@ static const struct adreno_info a7xx_gpus[] = {
 		.gmem = SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
+		.funcs = &a6xx_gmuwrapper_funcs,
 		.zapfw = "a702_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a702_hwcg,
@@ -1452,7 +1452,7 @@ static const struct adreno_info a7xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
 			  ADRENO_QUIRK_PREEMPTION,
-		.init = a6xx_gpu_init,
+		.funcs = &a7xx_gpu_funcs,
 		.zapfw = "a730_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a730_hwcg,
@@ -1473,7 +1473,7 @@ static const struct adreno_info a7xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
 			  ADRENO_QUIRK_PREEMPTION,
-		.init = a6xx_gpu_init,
+		.funcs = &a7xx_gpu_funcs,
 		.zapfw = "a740_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a740_hwcg,
@@ -1507,7 +1507,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			  ADRENO_QUIRK_HAS_HW_APRIV |
 			  ADRENO_QUIRK_PREEMPTION |
 			  ADRENO_QUIRK_IFPC,
-		.init = a6xx_gpu_init,
+		.funcs = &a7xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
@@ -1548,7 +1548,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			  ADRENO_QUIRK_HAS_HW_APRIV |
 			  ADRENO_QUIRK_PREEMPTION |
 			  ADRENO_QUIRK_IFPC,
-		.init = a6xx_gpu_init,
+		.funcs = &a7xx_gpu_funcs,
 		.zapfw = "gen70900_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a730_protect,
@@ -1581,7 +1581,7 @@ static const struct adreno_info a7xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
 			  ADRENO_QUIRK_PREEMPTION,
-		.init = a6xx_gpu_init,
+		.funcs = &a7xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0995aa1f7286..e9a0ee1262cc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2529,100 +2529,7 @@ static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *i
 	return 0;
 }
 
-static const struct adreno_gpu_funcs funcs = {
-	.base = {
-		.get_param = adreno_get_param,
-		.set_param = adreno_set_param,
-		.hw_init = a6xx_hw_init,
-		.ucode_load = a6xx_ucode_load,
-		.pm_suspend = a6xx_gmu_pm_suspend,
-		.pm_resume = a6xx_gmu_pm_resume,
-		.recover = a6xx_recover,
-		.submit = a6xx_submit,
-		.active_ring = a6xx_active_ring,
-		.irq = a6xx_irq,
-		.destroy = a6xx_destroy,
-#if defined(CONFIG_DRM_MSM_GPU_STATE)
-		.show = a6xx_show,
-#endif
-		.gpu_busy = a6xx_gpu_busy,
-		.gpu_get_freq = a6xx_gmu_get_freq,
-		.gpu_set_freq = a6xx_gpu_set_freq,
-#if defined(CONFIG_DRM_MSM_GPU_STATE)
-		.gpu_state_get = a6xx_gpu_state_get,
-		.gpu_state_put = a6xx_gpu_state_put,
-#endif
-		.create_vm = a6xx_create_vm,
-		.create_private_vm = a6xx_create_private_vm,
-		.get_rptr = a6xx_get_rptr,
-		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
-	},
-	.get_timestamp = a6xx_gmu_get_timestamp,
-};
-
-static const struct adreno_gpu_funcs funcs_gmuwrapper = {
-	.base = {
-		.get_param = adreno_get_param,
-		.set_param = adreno_set_param,
-		.hw_init = a6xx_hw_init,
-		.ucode_load = a6xx_ucode_load,
-		.pm_suspend = a6xx_pm_suspend,
-		.pm_resume = a6xx_pm_resume,
-		.recover = a6xx_recover,
-		.submit = a6xx_submit,
-		.active_ring = a6xx_active_ring,
-		.irq = a6xx_irq,
-		.destroy = a6xx_destroy,
-#if defined(CONFIG_DRM_MSM_GPU_STATE)
-		.show = a6xx_show,
-#endif
-		.gpu_busy = a6xx_gpu_busy,
-#if defined(CONFIG_DRM_MSM_GPU_STATE)
-		.gpu_state_get = a6xx_gpu_state_get,
-		.gpu_state_put = a6xx_gpu_state_put,
-#endif
-		.create_vm = a6xx_create_vm,
-		.create_private_vm = a6xx_create_private_vm,
-		.get_rptr = a6xx_get_rptr,
-		.progress = a6xx_progress,
-	},
-	.get_timestamp = a6xx_get_timestamp,
-};
-
-static const struct adreno_gpu_funcs funcs_a7xx = {
-	.base = {
-		.get_param = adreno_get_param,
-		.set_param = adreno_set_param,
-		.hw_init = a6xx_hw_init,
-		.ucode_load = a6xx_ucode_load,
-		.pm_suspend = a6xx_gmu_pm_suspend,
-		.pm_resume = a6xx_gmu_pm_resume,
-		.recover = a6xx_recover,
-		.submit = a7xx_submit,
-		.active_ring = a6xx_active_ring,
-		.irq = a6xx_irq,
-		.destroy = a6xx_destroy,
-#if defined(CONFIG_DRM_MSM_GPU_STATE)
-		.show = a6xx_show,
-#endif
-		.gpu_busy = a6xx_gpu_busy,
-		.gpu_get_freq = a6xx_gmu_get_freq,
-		.gpu_set_freq = a6xx_gpu_set_freq,
-#if defined(CONFIG_DRM_MSM_GPU_STATE)
-		.gpu_state_get = a6xx_gpu_state_get,
-		.gpu_state_put = a6xx_gpu_state_put,
-#endif
-		.create_vm = a6xx_create_vm,
-		.create_private_vm = a6xx_create_private_vm,
-		.get_rptr = a6xx_get_rptr,
-		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
-	},
-	.get_timestamp = a6xx_gmu_get_timestamp,
-};
-
-struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
+static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
@@ -2633,7 +2540,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	struct msm_gpu *gpu;
 	extern int enable_preemption;
 	bool is_a7xx;
-	int ret;
+	int ret, nr_rings = 1;
 
 	a6xx_gpu = kzalloc(sizeof(*a6xx_gpu), GFP_KERNEL);
 	if (!a6xx_gpu)
@@ -2672,13 +2579,9 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 
 	if ((enable_preemption == 1) || (enable_preemption == -1 &&
 	    (config->info->quirks & ADRENO_QUIRK_PREEMPTION)))
-		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7xx, 4);
-	else if (is_a7xx)
-		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7xx, 1);
-	else if (adreno_has_gmu_wrapper(adreno_gpu))
-		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_gmuwrapper, 1);
-	else
-		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
+		nr_rings = 4;
+
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, config->info->funcs, nr_rings);
 	if (ret) {
 		a6xx_destroy(&(a6xx_gpu->base.base));
 		return ERR_PTR(ret);
@@ -2725,3 +2628,97 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 
 	return gpu;
 }
+
+const struct adreno_gpu_funcs a6xx_gpu_funcs = {
+	.base = {
+		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
+		.hw_init = a6xx_hw_init,
+		.ucode_load = a6xx_ucode_load,
+		.pm_suspend = a6xx_gmu_pm_suspend,
+		.pm_resume = a6xx_gmu_pm_resume,
+		.recover = a6xx_recover,
+		.submit = a6xx_submit,
+		.active_ring = a6xx_active_ring,
+		.irq = a6xx_irq,
+		.destroy = a6xx_destroy,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.show = a6xx_show,
+#endif
+		.gpu_busy = a6xx_gpu_busy,
+		.gpu_get_freq = a6xx_gmu_get_freq,
+		.gpu_set_freq = a6xx_gpu_set_freq,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.gpu_state_get = a6xx_gpu_state_get,
+		.gpu_state_put = a6xx_gpu_state_put,
+#endif
+		.create_vm = a6xx_create_vm,
+		.create_private_vm = a6xx_create_private_vm,
+		.get_rptr = a6xx_get_rptr,
+		.progress = a6xx_progress,
+	},
+	.init = a6xx_gpu_init,
+	.get_timestamp = a6xx_gmu_get_timestamp,
+};
+
+const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
+	.base = {
+		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
+		.hw_init = a6xx_hw_init,
+		.ucode_load = a6xx_ucode_load,
+		.pm_suspend = a6xx_pm_suspend,
+		.pm_resume = a6xx_pm_resume,
+		.recover = a6xx_recover,
+		.submit = a6xx_submit,
+		.active_ring = a6xx_active_ring,
+		.irq = a6xx_irq,
+		.destroy = a6xx_destroy,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.show = a6xx_show,
+#endif
+		.gpu_busy = a6xx_gpu_busy,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.gpu_state_get = a6xx_gpu_state_get,
+		.gpu_state_put = a6xx_gpu_state_put,
+#endif
+		.create_vm = a6xx_create_vm,
+		.create_private_vm = a6xx_create_private_vm,
+		.get_rptr = a6xx_get_rptr,
+		.progress = a6xx_progress,
+	},
+	.init = a6xx_gpu_init,
+	.get_timestamp = a6xx_get_timestamp,
+};
+
+const struct adreno_gpu_funcs a7xx_gpu_funcs = {
+	.base = {
+		.get_param = adreno_get_param,
+		.set_param = adreno_set_param,
+		.hw_init = a6xx_hw_init,
+		.ucode_load = a6xx_ucode_load,
+		.pm_suspend = a6xx_gmu_pm_suspend,
+		.pm_resume = a6xx_gmu_pm_resume,
+		.recover = a6xx_recover,
+		.submit = a7xx_submit,
+		.active_ring = a6xx_active_ring,
+		.irq = a6xx_irq,
+		.destroy = a6xx_destroy,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.show = a6xx_show,
+#endif
+		.gpu_busy = a6xx_gpu_busy,
+		.gpu_get_freq = a6xx_gmu_get_freq,
+		.gpu_set_freq = a6xx_gpu_set_freq,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.gpu_state_get = a6xx_gpu_state_get,
+		.gpu_state_put = a6xx_gpu_state_put,
+#endif
+		.create_vm = a6xx_create_vm,
+		.create_private_vm = a6xx_create_private_vm,
+		.get_rptr = a6xx_get_rptr,
+		.progress = a6xx_progress,
+	},
+	.init = a6xx_gpu_init,
+	.get_timestamp = a6xx_gmu_get_timestamp,
+};
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 0b17d36c36a9..ef66e1eb9152 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -216,6 +216,10 @@ struct a7xx_cp_smmu_info {
 #define A6XX_PROTECT_RDONLY(_reg, _len) \
 	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
 
+extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
+extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
+extern const struct adreno_gpu_funcs a7xx_gpu_funcs;
+
 static inline bool a6xx_has_gbif(struct adreno_gpu *gpu)
 {
 	if(adreno_is_a630(gpu))
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 28f744f3caf7..cb4113612b82 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -235,7 +235,7 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	priv->has_cached_coherent =
 		!!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT);
 
-	gpu = info->init(drm);
+	gpu = info->funcs->init(drm);
 	if (IS_ERR(gpu)) {
 		dev_warn(drm->dev, "failed to load adreno gpu\n");
 		return PTR_ERR(gpu);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 390fa6720d9b..2c8b38eae7b6 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -71,8 +71,11 @@ enum adreno_family {
 	(((_c) >> 8)  & 0xff), \
 	((_c) & 0xff)
 
+struct adreno_gpu;
+
 struct adreno_gpu_funcs {
 	struct msm_gpu_funcs base;
+	struct msm_gpu *(*init)(struct drm_device *dev);
 	int (*get_timestamp)(struct msm_gpu *gpu, uint64_t *value);
 };
 
@@ -101,7 +104,7 @@ struct adreno_info {
 	const char *fw[ADRENO_FW_MAX];
 	uint32_t gmem;
 	u64 quirks;
-	struct msm_gpu *(*init)(struct drm_device *dev);
+	const struct adreno_gpu_funcs *funcs;
 	const char *zapfw;
 	u32 inactive_period;
 	union {
@@ -673,12 +676,6 @@ OUT_PKT7(struct msm_ringbuffer *ring, uint8_t opcode, uint16_t cnt)
 	OUT_RING(ring, PKT7(opcode, cnt));
 }
 
-struct msm_gpu *a2xx_gpu_init(struct drm_device *dev);
-struct msm_gpu *a3xx_gpu_init(struct drm_device *dev);
-struct msm_gpu *a4xx_gpu_init(struct drm_device *dev);
-struct msm_gpu *a5xx_gpu_init(struct drm_device *dev);
-struct msm_gpu *a6xx_gpu_init(struct drm_device *dev);
-
 static inline uint32_t get_wptr(struct msm_ringbuffer *ring)
 {
 	return (ring->cur - ring->start) % (MSM_GPU_RINGBUFFER_SZ >> 2);

-- 
2.51.0

