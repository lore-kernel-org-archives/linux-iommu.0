Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A936F8F1
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613721; cv=none; b=vFEUrAyC8MlFO/sMrzCnppe9M5jpf+AQHggBxAMJMVubS4/zo2pglEC4CmrzsJleSNQPwjgpZHaOCC4bgCRg5gBRBjUj33+UE/aWWEWne/WDSoCs8nCQ240T3AOjAczXYDohx3LZv4kSAbZVZMaWB2gU4BSO/uGAXuTNFOdUR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613721; c=relaxed/simple;
	bh=obY0yd9A9w1nKiCc00V/sWC5PfbbK/PzpgmtQExUcNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnOkTm+yJBjq/kQwgpMzVhQMjuxeVGre2CW4sb4rDdg3NrDFAv4C34ywNrxENCYOjBYAZnBl3wucyhlnHcG19IFgYgPnvRTtFYJU3D/3IQYDKNkebt6cbb4B2OgWeqPczeVWnAtpADuAYtQflGosnphmOp2vzGLvYz5Z+ijAmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQ1PfBqW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z/cGfE2J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQ1PfBqW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/cGfE2J"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CHY6IW591851
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=; b=fQ1PfBqWK4vDsgBm
	ASJFjwaLyIafukD8fECkcArllj+7wqOucIOdTZ9SaHXQVZhlxRgPKS3VZPkjdY13
	TieageF+GcI+pm7PH9pyulrrEyjtlzGB8hR9kb2lFK/WT0cvDoL4oi+zFvfXI6x1
	nr9HF9FtBP/q2pS8EMRbRCY8n2mqRj7FspPVyu8CdA9ONWKr+C2VBYTAxA9VCAvm
	hKNfIx5wS5SM2nqdpXQYGxviuDrsq8DNd/szkUj7vF/YgFavfaiPn/YVswi6vS/f
	e2kIR3rbu675gKQ4zKSwNp4NuRItafeSs4id9H9HXWoskC7B+BOKE4vitb9rWyWx
	0JTlKA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319t2s7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 19:21:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba268cb5e6so51273635ad.1
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778613718; x=1779218518; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=;
        b=Z/cGfE2JSnMheCu4kXSK0OqNpjNqsGmeb5DLRRpjbEpaVBawG/VL3M2UopJfR8I9xa
         FS/54Fw4zFMsMqqe76A6xdwEsCvU/XqUiZ10/V6gxtCmyKXr43hgBB2GZrjdBfByvnyL
         7ZPn9T832YjjNUUvqg/1feiB4ShaPo2TUPi0eTxgBmCJ3U4HoTf8P2Cvb1n+pi6EOgjv
         MmSRfW5q5yPHOM08y8W/47kD5Dzpy7LMiG4RDncQFWPf7hrIOEKCZkrTIf8uJo4XC1Rd
         fFSGt6jCLEbbDzKGk6fs9HfqX+6sDSJXHUryzgSaErIDfTTpkabjd43H25hW/r1a/RmO
         lzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613718; x=1779218518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9dYck4F1ifiwH0J/tkMJzJATF4TXnrW2srpgDnF4SLU=;
        b=cmNcV2UYCexSonM5BPkm2MTsm65fOb95snbTWkfHOLGkf36wpjbG8nWoePKi23QDGo
         C5lQ8jHeTyhciSgVFtn099u85NKRcyNvpZ6ade3sPB25gqxkyqJ37iJ0RTolPgs6i63B
         WhmWRFilCDIm/5uyAKteIcluWX+nkEAjzwZJMRviNaePYJEZ5rhaBEUD/uE33s62cwhh
         MYb2gVJ9aNCIrHEADN4eMzKfNzR1qPacSAYkfGM2ymZ8sfN04S6MkOlewY78YTajRhgZ
         EFnA55sPjCouufjh27bFoW/wBatT4NBpysr+HowtXzElQ/U8vlgs2jM4NzD07/XUeVSg
         xrCg==
X-Forwarded-Encrypted: i=1; AFNElJ/LHaQ0EKAF0h1SiiI8ANgF9XSmgpJonrMYvp14QwdH/pSU05tC/H369KYN7mQY+11v9Y9EIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh3G6z47HvaTxXcfgokz6ZIyzon6Cpk44k9pe4HLqiYaO3QNUv
	f1uFEVVNFxYRugPkIF6ZuFKmxLsYalmx2Ej7DaEa7BAkBVxGHwllkzEW4C6+cRei3VEEofwak8q
	Eh0uLsxO23U7E70lsCnSoKanryki8WGlTw3UbI7VjvoYWXuoWEKPRdhAglE7PzApfIQ==
X-Gm-Gg: Acq92OHF3k+oPE5YzFaFpZ98BdDPmHX6JXIaQam+zp7fzmnhoKbef3Uu6rHMWBB0xfp
	FNInC1cdFgWjXCg+lBMROZg7fkGEjO5VjkyJpuPeo5SGs3uOY15ILh/2oLmZRijqEoQR7c9VZlY
	SFnJGtDMMndfJN7yLBUXlQPMkhjDyZhfXRtpOQdjQXfWozeXkXqJsPhdoXTzikloP8x8tA7+Xqy
	vCTdQXOU0GxKZTUje7VB8qYJsQaHo/Uq5h7Loubkvw2BpyozZ0jY6QOHtyF0eu+i7BE/I5QnkxH
	Lmd89OJO7V1HRXOjbikrfVu76KbUdmq8UEOJvNAILCsrt1c9Cy14TT8aMKXCJ6EGNa40Sy93XJd
	vAxM/qSNlsglQ3B4AqaTz3HDRkMCVzTH61ezp0V8F1e+PVw==
X-Received: by 2002:a17:902:768c:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2bd27133a91mr2513775ad.8.1778613717156;
        Tue, 12 May 2026 12:21:57 -0700 (PDT)
X-Received: by 2002:a17:902:768c:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2bd27133a91mr2513465ad.8.1778613716644;
        Tue, 12 May 2026 12:21:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 12:21:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 00:51:18 +0530
Subject: [PATCH v4 1/6] drm/msm/a8xx: Fix RSCC offset
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-glymur-gpu-dt-v4-1-f83832c3bc9a@oss.qualcomm.com>
References: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
In-Reply-To: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=1052;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=obY0yd9A9w1nKiCc00V/sWC5PfbbK/PzpgmtQExUcNY=;
 b=WFrdXoJxRMyXFTXXynT+vDwKDHONIdU5yJw6WcZBGk2wkEkuw18xTJtD0Ah268ZR+tV/3Pzjv
 W3m23loJVEvBmUzKN29QDTNc5Dv9Uv0e4liGaVXV1DuPDjaagm7KW4i
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfX7b4AMRM6oUDm
 O9y6Ypo+6qn58zBoj10Ov+Y1+uDCHAE3HDDhNwWLANYU3EQBwuYBYJZHMmB2O+oA+vzH9MAb4UK
 wPa92TX5nUAt+OuTwqSEbqKVBVlXV9bscjEd3UnuHT5rkl9ZnvQgduejBA0M6/Dh+CvctdnXpoJ
 qxVwgL4xm7eVKxA3++XrZGx7iQnFyYgnxbgUUDxMWJcxJBf895TL6+pkBkpcJQAsWjqT7nkY8Di
 lMBsVFdO+1yPeYQ/biICVFDSz9ArjnpCPP3SMDP3aYg2eosAdR4iOXg4TttbT0zg8xIhKTPYp/1
 3lZAdXk8f0tYzOZ/3fc/NyjEk6eUlwL7DoK4qaRBMy3DKeqN9yY8oI7NvIIGohxkJ6O8Jnm6Ol5
 MBNx8op8WhOhmwPaFfpvMMumM24iyeL7YZK0lO8mW0EaZtdtj9wCjEOIq4jRq3dZuM1hvHOSAGQ
 IQhv8gPRx9oP9TKFOCQ==
X-Proofpoint-GUID: 9w-HK_UAMX1SunK9EHoFpQxPnEKS8AHn
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a037dd6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4MPhRinBehVJTi7DQIkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 9w-HK_UAMX1SunK9EHoFpQxPnEKS8AHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120200

In A8xx, the RSCC block is part of GPU's register space. Update the
virtual base address of rscc to point to the correct address.

Fixes: 50e8a557d8d3 ("drm/msm/a8xx: Add support for A8x GMU")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1b44b9e21ad8..cab4c46c6cf2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2357,7 +2357,12 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 			goto err_mmio;
 		}
 	} else if (adreno_is_a8xx(adreno_gpu)) {
-		gmu->rscc = gmu->mmio + 0x19000;
+		/*
+		 * On a8xx , RSCC lives at GPU base + 0x50000, which falls
+		 * inside the GPU's kgsl_3d0_reg_memory range rather than the
+		 * GMU's.
+		 */
+		gmu->rscc = gpu->mmio + 0x50000;
 	} else {
 		gmu->rscc = gmu->mmio + 0x23000;
 	}

-- 
2.51.0

