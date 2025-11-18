Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344030DD2F
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455888; cv=none; b=GTiEOCpdbLiVJA9IW/JyLxvqRbsby29UOkziv0ax8KI+W6QlVYPrtNWPdTnbVo/spcrI1VH52GUJp399dIJvilzcD40+z9GWp2q4QgQDNOFHvnKmbsf9k0pPvKq6MOFWxKMLsR2eOXCYKfDvwemPqIYJVg4uGD9livbQSZoyWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455888; c=relaxed/simple;
	bh=75w/DSS2hsmQuGew0+oPiaGMUNyIZyrF4qSNr7xCjPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8tsDGnJAG9b+9noRXcFprCk8rTwb/P7nVd0MjX0MmQX4yJ5xRJlAin/oV2IQDdFh0AWM1yGJ/2LcneEWEIwsbsiJbIs2uGKkCpKHPdvZHiZH96J2ql24v3o2gmEwwF763kxDJmw7PsRb7BDvQLymUcaITr54zyZbZvAyPCb4Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZbQn/brj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gMU7jEjS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZbQn/brj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gMU7jEjS"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8VKEN2249853
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H4vCyzBAng103Oq0fMyz/UmnE+wwp6D/i+dL9/t/Pjo=; b=ZbQn/brjBhwoMCd/
	IXPswd+gdSg8ZixoZa5dJWsmP1Ku/zoA5LoC7BMJCRfwM0dL2cACyBXx/hP0dJNR
	w3gez8M0G3VQDwe0y9GX1ECUUhLBj43GfqOMriaOfD29Dgm4c5J3BEn+N1MYNSEe
	UmeJ9/fe9tXuwUhAJH3Vn9wGezXaxEMd2K96b+GZFFVPKpbBKdSVGFGDRkK2qIws
	c5F5qEGOddVkXdolc5LYbL+VBl7jBDAyAqRHr7vmCs68RP3IpaOevwTt4kEqlAMd
	2jQ3eF/DOGkCp4Rad4w59Y2nec+cy8oeqtvjQE8V7wkr26V4/+NJgzSuPy15ADCD
	8DBFMw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnc5g1mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:51:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295fbc7d4abso67819635ad.1
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763455885; x=1764060685; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4vCyzBAng103Oq0fMyz/UmnE+wwp6D/i+dL9/t/Pjo=;
        b=gMU7jEjSPz0GLg3HtkUjY/IBhKc5D6RzenlVs8Gg65B3mvrmC4ocOPMeAFtzC59YsU
         9rM8ZSoza9WpFtpG3qMhaBMeQHkPGngOn4h55PkrFYiH6vJdXN0PC3V113AyNglcIa5+
         xPddEGgnVbXlB3/sAn7w7rkFw4jX7c9/keVLLsWifqFTGhTJ7d1IFeLoxyGZZWYVRYh3
         iZRuVWjJSzl7PBLqZKy41IXIJ6egtpErQ3OCVzrmJqTie2aH+Vp7dmWWU8VgDZUsZfUE
         ELmW7+T0JoZNWnhgwdOrW/CEVW6Y9WI17n977wROfNS7ON5fCes9xULzNw2rWrjw7C9m
         YB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455885; x=1764060685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H4vCyzBAng103Oq0fMyz/UmnE+wwp6D/i+dL9/t/Pjo=;
        b=MvvfLShjyLxCZ+1FZJ9+WoDrPkyZFF6vwshLzCNpLkWDJerR0mB7L32TDMeLHIoXvN
         HszObS0MHOGXw3wgEJUwzzplgjQHjxPh84xWPBjolUbVJH631EMX5mqZZhe33pwsY6Jf
         CJysdcceVNhMzzuVP7qrgtSAkJCLuV/CrsFyr/MNpYHg+slLYUiAU4dXPNEVwP8QyVkX
         l61Pe2EOvGYneB+64SG61L9odWrhRHIIj2ZSSxnqmBvJvVLG9i4A9cQ2csZakGOXulQv
         OoLwtXLlgsqus9IY8qmd1AF9whY3Xizl2GCl63xm7wvE7Jg2qy37QmuU54SbDe8Zhv+s
         nyjg==
X-Forwarded-Encrypted: i=1; AJvYcCU4xRMWbgLSk+pQglLg9pnZaJAvluiuFr+cATB9+LhZsMcU9qa1R6D5wWmhc2/W6Tz6JIwqFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YywJ4zR59hniMYB1EE3TYAsJxDO9jQo0Zb5EBXb50a0BPtgIWqg
	maUfo69wOcibwBoTTguirw1EogYn2uRkc2JsQ7CEZoqXkccenju+7GoX9DrvKix2xGXH2+C0ESR
	XIYKOegFWShEC7JMrBAsaU7dPaGZktrfK9JDa1DufdtJmk5mKwB+LiKrp5w==
X-Gm-Gg: ASbGncvwkCGFhGJLXGh3qkekxHGkTFr6jPD8v8TLbSJEoi3ZT6JljqzmwsokyCvXH2j
	H1Nwf7x03NJBNhlfwmhpLekseij4PugB5QmDPikD/G/Y6wnp1KYqee5rATOHwTUnDvS0K8/E1HK
	z9jrqGxGYYouenNgAcawJHXc7vrLBup/AdXq973D52LPOpa7vBWlfH5nQSPe/rCRFFAR6uxUvUX
	uD5tCi5VmDWbva3aEfcwT2ttsmBlt63aXxQZ1rMi4CEMX3aIJ7NPFK+GvoWZv4TUDKVhqj5oH9A
	DwAuDUx3InY/vvEC705ZVg8baAhQCaSnUMmmy+rMEHOXf6kwELB4w+bCe11TuCvXZO10w2mOB9g
	tPhuZ2vTThBfu3J7Q3U3XnT4=
X-Received: by 2002:a17:902:f603:b0:295:5b68:9967 with SMTP id d9443c01a7336-2986a752d17mr194312875ad.49.1763455885231;
        Tue, 18 Nov 2025 00:51:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbC51hO2dOCARJAyGl+8Koi6W7aP2bRmpLcyj3T7XMY2HEbsh68c6kf4TSJcXeGL2xke4r6g==
X-Received: by 2002:a17:902:f603:b0:295:5b68:9967 with SMTP id d9443c01a7336-2986a752d17mr194312525ad.49.1763455884759;
        Tue, 18 Nov 2025 00:51:24 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:51:24 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:28 +0530
Subject: [PATCH v4 01/22] drm/msm/a6xx: Fix out of bound IO access in
 a6xx_get_gmu_registers
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-1-86eeb8e93fb6@oss.qualcomm.com>
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
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=1041;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=75w/DSS2hsmQuGew0+oPiaGMUNyIZyrF4qSNr7xCjPw=;
 b=jLipoeUTateSBD+g7vKKvS2yUCM4T7jj8HbWbcE3idzdOQIu0EPirauUiY3Is2Tzh/Nibkr/K
 97kGQ3WCvoMAzjLIS/xjcAXB0eXKO6+mlb+Pc7iuP/yIi+AHnbe11mu
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: IC0RJfY53AWv42KUWHBNjkJ9bfOTGNpu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX5f3C8jcm3QF3
 9pbmap7xQjm+6r12Aaq4l0C+/lKJdgfo3rnZWCfjWuheg6u8w5Gdxi4bbU73XAt+Z/MJjz5GkMS
 scU/kZtSmMncSUD6oR2DbAG/vG/6Fj5qChZaRLVA/ULKi20/2I8PCV02RG5HA/zehciwvqSVVH5
 P1i45h65lo5/WdIpj8pD4Tc7pra9Af3Ry6WrEgLiHQ5d8rtrq+qRRZo7WBfdHX2GVPVjWzgLNbp
 wx9QhbpnDEAZf/Iq/vRfuLGN9wQ68Ztf682WPe1iF5sYxKXvEWfPLtzc2GAgtLlh60ZWwW/uBSk
 +ODm+vI45nfqbPk9KiqcIpN0dA5hLA8JvjRpaDcZiPRTC7aE223FhXd1fGlQalVoXjomSPKyObE
 rIKmyl3G43FAMRdDsJSiAtAaVEAx+w==
X-Authority-Analysis: v=2.4 cv=BYTVE7t2 c=1 sm=1 tr=0 ts=691c338d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=PiXygW76SPkGC_ia2qEA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: IC0RJfY53AWv42KUWHBNjkJ9bfOTGNpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180069

REG_A6XX_GMU_AO_AHB_FENCE_CTRL register falls under GMU's register
range. So, use gmu_write() routines to write to this register.

Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
Cc: stable@vger.kernel.org
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 838150ff49ab..d2d6b2fd3cba 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1255,7 +1255,7 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
 		return;
 
 	/* Set the fence to ALLOW mode so we can access the registers */
-	gpu_write(gpu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
 
 	_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[2],
 		&a6xx_state->gmu_registers[3], false);

-- 
2.51.0

