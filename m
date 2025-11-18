Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CE32F771
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456051; cv=none; b=NKpqP+7U9c81MoI/LKapPi2FB0TgrTIZ4BpFM9isMlDnvTYl3xlftmAlXVUiJl5emAir78GgmUXnySyrE71RKDgUKsExmWqEZWeSikhNF3Cu/zplbvthUs6m7KwG5PtpOd1xgzvSE+E5XpT5ydy6vIJgkEuiszxLiyaWqQApRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456051; c=relaxed/simple;
	bh=wceYkLyUbkNoE/pP8sWa3zSzsulvkqlQyOrCItWxr1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1KGQ1I+TUl/XizkWMhQOVe43Fgcrs2By8eVPYSwX0XoRHb8czKINc61u/q1eTp/7UCSmO8DtzEePoJXtjjqCtOXw/K5qpePjrFauGI7EqeHJS1p0szD/cQlXTaAe2Jy4yCxElrExLs8VK0ZZI0Sn390Ez5aEtTvu9/Xbf+30mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XSJrKjwo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a45Lyo3J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XSJrKjwo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a45Lyo3J"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI3CJKW376011
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PrV6w/KNsg/+0gK7/2DObzlG/RNC5GFYtRF+8U90aj0=; b=XSJrKjwoVjc3E6RO
	PWDEeilTCueTASJKgSjrC3dJJBhl95aZ2GbxaMRERmW+cCH1EctTbG8YufS0NXS1
	elUEnVsHJfJqhC5O4e42Z3QfZsGtwJln1BhAzfla/PJE1oPmmGonbgBGJnSbG4S7
	uhsahzWLq29xyCVLAbR0KcDYFFgLR9PyT2/jElEqq9NmUl2UuMkvr9rGk13Xkm64
	jH+s/yuVabDyI8WYgBkIoNj+SQKARX4lmFL5hC2p8ZncvDbO7gXJ6XMvkfFdnf+G
	Q3gDpCgL2p23bFgPTwaXy804y7cUFKerC4U7LKdcxk40VWYDK7UWhQN5HiRg1zx5
	Z8Fmag==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag76njg0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:54:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29809acd049so90960035ad.3
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763456048; x=1764060848; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrV6w/KNsg/+0gK7/2DObzlG/RNC5GFYtRF+8U90aj0=;
        b=a45Lyo3Jp+/ZKmcumXF0JBvXzB1K/e+qCuR/ngbN2294636ALkd++OrnZk7DgrM/TG
         51SPCygFkLm7BBH1ZCg09heKYM68+g9vXeRhLkYnl/xvOl2NtyGl30OembXqh3CV9PUW
         C//PvCRu6ZuusJh8Epr6GZxWrDvfTHDktqS7tHBls6ArgYeMUD142WACYfl0fXboB5HQ
         oK8dtuTgq6vwOuI9LiMbgfCwNOYvdv/sXE76ufqz47jGA4w8PczwucROy/8bzao5FQ/M
         N+kmYhQR0V7dPivv6YZ9ovt4X7FFHPc/Xm8thg8jFCGz+ee0tTKTcNvvMIEcVRL7vsSE
         uRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456048; x=1764060848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PrV6w/KNsg/+0gK7/2DObzlG/RNC5GFYtRF+8U90aj0=;
        b=ntHJFieu3EVOysIeFV/B6gIhZY41Nlzwyp0GKz+pLqLsAl2ZwN39Fus7tHhiSle4el
         PrhMhVlWWyD/imfZN4sjIrngN7apXfxJgp1t/nvKkBgFVPdt+PMz/z9erI5awclk84yP
         alagpgecgzbBR3glHlU+YvpAwOjMHsIzhdKJsvJ9y8kw5Zra1wlqsMjB4YauPBdRrJME
         TECPOpSDVGaJiDuE9TzxB1ogzRzwvUItFQLz+FOPyylS5R6DX71PWznKQMSQ7tgzgDfZ
         pdq+45i6gJJe+S90u74+JlJMev6Nhjh6MOSY6AQDup8uQpIYuOOr22dfD6msfxgiu72e
         c1AA==
X-Forwarded-Encrypted: i=1; AJvYcCV8z/IbIDzJTjLvnQ7OrymFXFDdhl18nlwVXtExgV0kah9qqJleLvTgOVFraopTKDDaqwGw4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHAXc0nQsKmU/JtND73TfByGX1XoVteKJK4s/cCZZf4xb5nVUL
	h0vFNpovwSBkdjaHU94HqJIcMCcc6867ryIOqYxiyow2xq9NtID1fPVBfKY7RezakrWQz7d6Dea
	NS7k115y/qyHbHnZfF5kvAu4O8fZpDaaamk5flwz7nroQevS30WMopjRDEA==
X-Gm-Gg: ASbGncuiDL+JeggCyAYUd2ROrP/K2MreUWWNzlOBKekL9LJ4wQD1Rn7gmF1DglmZBWG
	PBIVo/DY8ZOknq3X5VScjXxfAZ3zp5kmkaUrGNoUXL9FUYMIXSwiRsBN0oDFCyHqU09lssWWxZC
	Ga+y1gYJLqtV/DwdSfOhIcms7aBmyoHVX2sl4MYujGdSwezVV/8DMiFXn/EN/+H1RAbiZOn0/Dm
	TBItc6QPF8XPZUSJWqng67Y6tCWaA/D8exd9NKhcmO/dt9T1LkCRqU0tly20dFrVP/OXKDwSXiX
	BESmk9xubqe3g8xNAjl6+Y6DaWufqOZfRCq5Jy4RZ8e/nIRYsORd5xgz2AM4ESeeXG8fxUxKPsm
	kX7hMLQMoSvEC8pT/c4caNnQ=
X-Received: by 2002:a17:903:2b10:b0:295:915d:1eed with SMTP id d9443c01a7336-2986a752d2dmr184978015ad.47.1763456048190;
        Tue, 18 Nov 2025 00:54:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVjIlIvPTSiLdTNwr5hmoMfFZEBIQrZl3YPil3Ox+0tEXFjgQlXvbvrH6me3SXOyh31lsTdA==
X-Received: by 2002:a17:903:2b10:b0:295:915d:1eed with SMTP id d9443c01a7336-2986a752d2dmr184977645ad.47.1763456047717;
        Tue, 18 Nov 2025 00:54:07 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:54:07 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:49 +0530
Subject: [PATCH v4 22/22] drm/msm/a8xx: Add UBWC v6 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-22-86eeb8e93fb6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=712;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wceYkLyUbkNoE/pP8sWa3zSzsulvkqlQyOrCItWxr1g=;
 b=ab9CsH8NF32fs2MhCaQYzdCr2lNXGHBIXRiN2OcE/b/eGPfTzV94cxPkR/EkNz+ftEVQXOWXR
 YhM7yhyZPncD+Uqsl3lAE5hf7Myb66BTpP+CS3Bd1dT6SCaSlLLFKhI
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX9Lm5wpxmIvSJ
 8M8LroU3uGOKt73tUgicJ9kAhX1mx+yAYYU1FKAMDsaba8sMeACHlfwQp4M3LS+Mlga8dE4m2ZG
 AlVoYad44HdDCfjN6m02HsTqI5cRPizg27rPl9A/d2r6u6I2NXkB8MvmUtQGcIWjsF7MgzKyBaS
 G6ucmqVZN9GdEph/Y5kEvs5lNJrRBLyixdzR0wminiUBKKFG1INFvJ/SNsAo8g6M532SnG9uZPR
 Car73lJmFUYM7G8gWRQEiKhc/pg4jyawa6DaEwsB6uE8yWukFn2lnXJIad/qPpo5u2qcbLz5d+l
 vxPTs1OCkTADqVzHpCjBnuom4W1wrFZlbA3F0hvZBc6VuL2H0fjzOB3LQl5D0/JnIq91dKWIzCi
 +sDhsqN3KYCUjaNclC8aRGdiqBZOkg==
X-Proofpoint-GUID: YiZScVbjD5jsmGqJqo54GcAXiuLfqbyU
X-Proofpoint-ORIG-GUID: YiZScVbjD5jsmGqJqo54GcAXiuLfqbyU
X-Authority-Analysis: v=2.4 cv=a4I9NESF c=1 sm=1 tr=0 ts=691c3431 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LUS0w5LV-g8XRIoliPwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180069

Adreno 840 GPU supports UBWC v6. Add support for this.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 30de078e9dfd..5a320f5bde41 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -276,6 +276,10 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	u8 uavflagprd_inv = 2;
 
 	switch (ubwc_version) {
+	case UBWC_6_0:
+		yuvnotcomptofc = true;
+		mode = 5;
+		break;
 	case UBWC_5_0:
 		amsbc = true;
 		rgb565_predicator = true;

-- 
2.51.0

