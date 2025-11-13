Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F632F76B
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076673; cv=none; b=IedVi1vurRWR2OWPYsXr6BY9DqmAMr1d9WKcgq8eYc/V+SKHE+onz13DIneZqp21ytLJwe/zNwL/yqgUlzGmbwe+lxfXnEVrgvqmEAyFYq8M+ly4lMfg6vOrzxaHmTgvvtMTpH7DBVTBuzjbiu5eb64xFFV/vFxQbICxvMLeRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076673; c=relaxed/simple;
	bh=6xiTxu+QK2g5DX1T1txHhYRR5FauCvoidVNtsUXBMYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdME+VUZ6NbcKqEI7uPOjkQ1Tylbu1JjaA+gIIvjMKxOSVPo3MOH7aRgMvwqb/aCEcdMcnxuSuYI0QqPgnE6Zuugw98tR8Lq8fnSJ+PZ2cv+zyfjpajYKplBgC+3DmImAXSvucBWLUmVzW5ISJNXqdGDdJiWmhsXHI6R4LjVGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dcmpx793; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GU8DjeAy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dcmpx793";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GU8DjeAy"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMaikb1479481
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ogd55nO2nJMubbd6drWs5Znn7Ejg1QAMnSKWLgnRFIU=; b=dcmpx79369qnBr4c
	+yDP0pXqwJYJZ3z8L+GDq616nmiqW8Qg2ScL+qoEIf2jnxoIUYZJZaHtOvT/9F72
	12mzK9VsMrKe3e78AZ/opjEFYnwWS5brVEoy67HQwAoRcjk+fU1Ksg+nn2eD2IZR
	kwoKBY6zD3f3Qs7Zu9mEr1t2nlmVtnKiWxl6VjogbG62ykWpOl6CZzK7nOeb1vzo
	j+7COuUwy1YBGWT2lJGc7yNvu3M2yXzFzszpOo3NLQtL2maeheQhr8JAMgJOSfGZ
	xxtW7dwzoOgmeg0DXAkuGFdAvdprY0WOLiKs+Gy8mhs8wMzWS4LimAD/fyD+ivit
	xbHaLg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9dr45s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:31:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3437b43eec4so2377672a91.3
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076669; x=1763681469; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogd55nO2nJMubbd6drWs5Znn7Ejg1QAMnSKWLgnRFIU=;
        b=GU8DjeAy1fJFjHDPprJY1OKUNv1i5PkmBLcD2LHPnrPDrzCHsCHxETHSzvLxAokhC/
         duBuI6rHfz3ph4t/yz8BY2bLzLuisqdohUTZYxdhTZ35FMdT/DbJhI231UWWNADO81IG
         D6viMSykCIXOOAjh9+ZyQ+wwzJJLtjZlJ/qIJ7Nut3alJ4kn8ovEs3t0IYBsJl+h2q40
         g0Rjx+iuRp0GkEje4zho93Y9/v3GePfRmUBLUde8IaEBlDHwAnDg27UGy7Mbksm332ZO
         +72rse5t6c/iMMmL893zGHHW9AnZ4CMYwjitwgwOIRpOU4PQnoK56mEvIzaoUfzhF5B+
         pNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076669; x=1763681469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogd55nO2nJMubbd6drWs5Znn7Ejg1QAMnSKWLgnRFIU=;
        b=ND+COVUWBEfcg7xp+Ei7tCvRuVbv0SZWzb71kvNDTFpdaXYWMHinI7/Btnq9INedPH
         LMW17+uE/p5x5Z9Cgcjqrqk5tLvt2O9oVknWcCO3AN57vtrpWP/qnK7JjWzEaU1czylk
         wBeuem/cyxuhoNZqLbh1bD3JlJPAFxlTmg28dvvYs/YESxlMCTsI8SEt9Aqh0JuJ3o7E
         lI4c3P6WwQBoD5qGzgsg6u72kqt0+b4U68PtJxnVXHy5573AqsWW8MqIMPhI9ADioVqC
         2+4dofrJG3PSL/ydqNFx9Qs18+b19WDaXGe55aWRTuPplNtZF4UCuASItgAGuUhP7Ulm
         tJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkZy2R/qYPSfmYp6HRaRo0IvycVvSqG1PN+OdCOcU7zEh8xQdOGCAs1Y5PXf4BhcEUoXlWJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxcx1dYjhCn9oPLO1ukoYuejzJ8OCYUfTGjWPo1fs7kikUj0WNT
	31EuEOZPIoFik4ZN+MonZbteTwrCy+PggeW4fAqw8j+LWp1zy1kzICc1JrnOhaX+/kGZAoYrB1y
	pgg0iABVFqcnTAlPWs8VZ6dcHuJAOKISwcsADbZ5wphLGleHthsZEUykd6z3ToASS8Q==
X-Gm-Gg: ASbGncuxeCiBVwhP88WKDnHGjwcC7BEMFSSIXSH2M0rtnwQYB/nk9B1QImZr5wTxCpn
	1RCl2//Mcnu3wu5ub9uxjSMD4P0rRtgfWlTmrir79n2tzLP7C9pKfOLgp+7ccg1rGdVJ2we/281
	UCZsUJ/jUvlKy5QNwVI6YAyvQgwpIrcxeg5YcxaCme6OApVnciaPu1N0YGXH2FezOZZeNbXBMwB
	04nb7Mc+y90+7Leh1zHb99h0DgsaVAd+JPd0bDOzox6EcPTaxIsbiMroNB3jjcs8Xh2QiIC/5Ri
	5tbNHGzdbeuTAHtPoJjdKMvCg+/3cr7AlkcUFGr+rnjTU9Wg8tbyJEQkX4VpACbiaslV/1lZGX3
	qYZZcjjihRuuOz8RyDwfSJBc=
X-Received: by 2002:a05:6a20:3d1a:b0:342:2a1b:86fa with SMTP id adf61e73a8af0-35ba1b90665mr1474122637.45.1763076669217;
        Thu, 13 Nov 2025 15:31:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELj1AccU1iAtNlF/d1rwvp3D0O0GtJ2fmP978ebIYh6+n2bRYHdSZZAqBoSZaQIswf+5R01A==
X-Received: by 2002:a05:6a20:3d1a:b0:342:2a1b:86fa with SMTP id adf61e73a8af0-35ba1b90665mr1474054637.45.1763076668465;
        Thu, 13 Nov 2025 15:31:08 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:31:08 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 04:59:08 +0530
Subject: [PATCH v3 11/20] drm/msm/a6xx: Improve MX rail fallback in RPMH
 vote init
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kaana-gpu-support-v3-11-92300c7ec8ff@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076574; l=2950;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=6xiTxu+QK2g5DX1T1txHhYRR5FauCvoidVNtsUXBMYQ=;
 b=IttmFcbenAkdyewwx77FnOo0XWIhoBfw7cDraxU2XeqU/3OiNFFUAG7R+9K8RedUjOJawDXlp
 Jb4HDun0pjmA42rV3ROB75c/jOtuhSsvRqvyUfDYw/rz2cgt1d0uQGa
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=IaiKmGqa c=1 sm=1 tr=0 ts=69166a3e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=feIks7WodE12ze-Om1wA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: cDDTwQKlAanq8z2X12iGpDA-TqKAPt_E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX1acuAupM6HIG
 0tf3STdD7NZs92qIAF2fSvMFJQShVLofA3iUrIfkdahAlJObG8eX+80zUP8PjttXkvLiosUHb4H
 5g2wq+KPkEiVlukpNbgsvI2on/iFzeC+w7QNp3d3UYPF29sa+dv+WVvve04UyvqmdlqL5oVQYK7
 WebnPsrkE1JhXNrJ+uJTQlEIj7Opa31VnWcyq7uvbvYU3OVK19VfQm+VFCbXpR8zOeJkwUeQVGm
 frVzPYlOJ2cUjIcGOVNHW4IVbC/RyU8LgTQkWya4uuHScDg8dW9ksT4wKNxpG2bkyNQvp7eH5xw
 n3Hx7hwEdGM7WlpG0/fSBrRm94yrGod0qAjbzmOBH3UvFjP8jQHdkrs/el+sRn1SGrviwHxPncr
 Z5E2SfA7H2swWd74VUtb8rdPq/VpgQ==
X-Proofpoint-GUID: cDDTwQKlAanq8z2X12iGpDA-TqKAPt_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130185

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
index 53461be14dc3..f32e1aba146b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1518,13 +1518,14 @@ static unsigned int a6xx_gmu_get_arc_level(struct device *dev,
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
@@ -1535,13 +1536,7 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
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
 
@@ -1609,15 +1604,24 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
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

