Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C132A3CC
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076641; cv=none; b=hc93qen7o3Dk4FAciSzpI4Y0X3h/elU0+acumSfTDLRFmTtwTocFGQfJRvxKujIY+/iqDcwocPDTMixIWH5wtnoUMITsndsrK77xYYxjjs4EmiMaVNzyXgnby8vaQv/YvKVLKK9Hmb/977pI94BUpnFgZzfKqa6KV0DxYvyagrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076641; c=relaxed/simple;
	bh=aLTgU8jaf8pYFojJF1knRYGUYls1un+XUkalxDsrrq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ls51UP3YYYn556bL+A7yHFGGWMkYP8cmIAEOP9GM7UJnqYNBjMCzIMs+9UNCLmYDM2ksWPIeN0MfsFXYfBlICzcfPDgbHeYOcSDFXU04cW9vF+sTEGQLy9+y/5dLdUw9DC6xb1C93s6gF0742PcGrXcMGo4OsZvMoW1KiW3dryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BfMAHJwY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tux9TbHP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfMAHJwY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tux9TbHP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMakbX1703675
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hhSbfQfsXDYo5k86Qy1lI4a/r5FL2WPHyWoclA524Ig=; b=BfMAHJwY5fxflr8P
	IXw0KyTixDRZMxONIjC8C5SVj9SF0YbfculQH5Q4xUy5qHHqli1kA7y5jhD20O/c
	pUG5GfnGViNRoG4LxV/HVdrwP8NKJvlgoN9gT6S0ZmHxCETGdfmjQquvxqaeWJm6
	us0rc7eUJM7sSh+2yEuhjeu+nOYohKRDFDS5kttL58rDPgbqdgEo5lJk/HUCCqvR
	iMBfrQWPMspWTEx+O//AyKxez+HIvs6zB1eHQsAs3vzGZ6KeXVIHNv+aB1NZRqY1
	0BdPBPDkMx/HsPhy93CyflRAd4f2rNqtLfjHQDqNY2Sd5WH/l7N14hm5rau/zu7A
	jSkYbQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9e83xu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:30:38 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b8ed43cd00so1720237b3a.2
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076638; x=1763681438; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhSbfQfsXDYo5k86Qy1lI4a/r5FL2WPHyWoclA524Ig=;
        b=Tux9TbHPoGQac82rnwAgY7dei3w6qpuVUSrthTkXFh7hwNq6VRyI+htDSXiRwCW6Js
         6CJSHbg8JTtl90s5YYBzxypxqcYjFh/JCJRCq/LsOHVwmLwnEDptK+annd2FK79CO8RW
         5e/f2a59TYyTp0Me36JlH6ahYZ+KVwt9TV957k6SVwtzHkjBwueYP8zn3Yn57bo68JSj
         aNpMr0NrY1O4ftLq8uKS41eamuNZFux6UZFhF9dr2+EB1UcFHa08uM2RH0p537eWhLWf
         aQJZqVlVeKqpYmaMMQGjxE/M5NLG7GdbDDHlYiZs2sRp7Nkh7WXUyGAUV/BOHdkfABdm
         4r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076638; x=1763681438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hhSbfQfsXDYo5k86Qy1lI4a/r5FL2WPHyWoclA524Ig=;
        b=hMwtrexZv2d6pxdrXnloEwWlR7kslDTd1tvKdXbHFje/gP8l0t7DH2agnFAfz1RjrO
         hJfastwNio2IbwKjHWQw/vIqGocFOXfhJnWmV+7ll/MRCgmlS6NHkfqLGFECQ0BrMt/K
         pTDQCErjg/4AWm0UyCvXNv7S0fUV8SBqDso41aD+DLJFk+B0YpRn2StgqNxIGMu5olwQ
         tMrz2G+Fl0Dj1b8zKKakx+hHUHNRdT2/N07goPfqe+zkjLQkFYAsA79Y7SzqZQRPh+O4
         eN6Bl6BjS5R8Uk3lS7onCKz1ylrEW/cBp/VNznmM4TJ0YDo5VSs4v8TtaE38NtSTfKQe
         Ld2w==
X-Forwarded-Encrypted: i=1; AJvYcCUvkbheGSxoz+LXb2YG2vhDPk3qJM2N30TGETiE5zrM7WPq8EfdMw7fL1PTZigSEz04jhxb/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhD3kNNDUaA+V+Jr9y5WWeF6c6UgQAYwDKY6213QdLX1XKBZNy
	/qCPYi2ZXPfP0n1doX+CjiEicbklNUTsAUS6Dgx1evhLLnXkR+7DDhp1gO2LEiCP/oK0NVvb2rr
	fpfZ3CwIB/PmMO5weZr8HAK7Er5+UZXOCpxMZCaG2/McTIgrTo1oKN2GAuA==
X-Gm-Gg: ASbGncvC2K2yc+KM6GpoKK9P9mpJK2kCZD6Penen0uL5UAC2T35pER+APUG4O+MPrKK
	3ZfQREmS+1i6gCGjClT9El1dTcu+3M4L1bMiXJq1aBEkrMVwtzhQ2Vp44brEfTVkS1wLf6EovGV
	oPmxnGBSYJKUiFTWIba66mGtgMlGRb1e9Aw6yhUvvun1eoFW9TKiVZ41+S/bSAIf4b7hLUyYZQZ
	/FLd+OFmIZUnBbgLhPKARx81ukUt5CohNBcwyIQIrfl1mBIjZOMJBxz9StkLziQf+WcQzC2CGRx
	Yd/y1TpDhQO3wAHG8+BNCa0Stpo2bR1xikPUV7/pGPV0aizFiFvMc5NHymkBhKM2ERbND4ucOUh
	qkVB2wdbKISh1ekyH/h5H9Ss=
X-Received: by 2002:a05:6a21:6d85:b0:334:95d7:3305 with SMTP id adf61e73a8af0-35ba22a4e5cmr1764926637.28.1763076637807;
        Thu, 13 Nov 2025 15:30:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEn2fDftnkPr0EHpOpGMZQLIPAqXnlxWXCkdgBWD+7nx4rt/A++vHmEwuulwWe68hN+6xKeg==
X-Received: by 2002:a05:6a21:6d85:b0:334:95d7:3305 with SMTP id adf61e73a8af0-35ba22a4e5cmr1764869637.28.1763076637246;
        Thu, 13 Nov 2025 15:30:37 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:30:37 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 04:59:04 +0530
Subject: [PATCH v3 07/20] drm/msm/adreno: Add MMU fault handler to
 adreno_gpu_func
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kaana-gpu-support-v3-7-92300c7ec8ff@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076574; l=2452;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=aLTgU8jaf8pYFojJF1knRYGUYls1un+XUkalxDsrrq0=;
 b=Tk4URntM++zmLSb6MOWmkLrsE9HFNdTk7nCYDUKwhHi9SospA9oJhyJsDSjF4eU3RjzsTrddk
 U5TuaRXL3yADupie5aIE/4U2SHV05LRHE+SWVpJw7MFgF3uJWO4lapH
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=ccPfb3DM c=1 sm=1 tr=0 ts=69166a1e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=i9YFFn0sWQDpYGFnbDoA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 3DokNy_-4Lfudv2SxEx3GX1AOMyo3Cdk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX4F0sLmuA3zMx
 iHeOk/b62UTCOnDfY6wpFIElrMWX1F4oBUDDmGhp0/ZES7YRrx7uJraI5cNDt4H/bpU0zNdamdl
 iEa3LN729v2FesBN5cwFtSidIm8aAMvW2tFsFluVgC/t7EvOyc38UTCx2uHeZXleC9wGEmQexyQ
 r59DCHmoPVTYQR0UrFOlbSyP3LlE9lmoK9XY9YXrzgj8dhD1xejelArvKINdgL2NEnM4vDrI4JZ
 DKGv6knizHmvu7nY7w3ddRIqLEBEh6PShamHUYIIK981fKtyjSxwF3/MZ0Y29hYsf2An75bEcjM
 zsYwe1RU8sckTqVMX8W8oVCqh9yfOe744DDfCUee244VLkPVCfzDe1X87S69enFKXNqxrzr1kBL
 WWwUJ+8ciDb8Fp2NRcLPcS8MusPxRA==
X-Proofpoint-ORIG-GUID: 3DokNy_-4Lfudv2SxEx3GX1AOMyo3Cdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130185

Move MMU fault handler for each generation to adreno function list. This
will help to use common code for mmu pagefault handler registration between
a6x/a7x and a8x layer.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 5 ++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 9c6af226b076..685763c12690 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2615,7 +2615,7 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu->uche_trap_base = 0x1fffffffff000ull;
 
 	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
-				  a6xx_fault_handler);
+				  adreno_gpu->funcs->mmu_fault_handler);
 
 	ret = a6xx_calc_ubwc_config(adreno_gpu);
 	if (ret) {
@@ -2660,6 +2660,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
 
 const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
@@ -2691,6 +2692,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
 
 const struct adreno_gpu_funcs a7xx_gpu_funcs = {
@@ -2724,4 +2726,5 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 19a1a1f699bc..34b09cb127ed 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -78,6 +78,7 @@ struct adreno_gpu_funcs {
 	struct msm_gpu *(*init)(struct drm_device *dev);
 	int (*get_timestamp)(struct msm_gpu *gpu, uint64_t *value);
 	void (*bus_halt)(struct adreno_gpu *adreno_gpu, bool gx_off);
+	int (*mmu_fault_handler)(void *arg, unsigned long iova, int flags, void *data);
 };
 
 struct adreno_reglist {

-- 
2.51.0

