Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFA310629
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792708; cv=none; b=NwNTQTgpLVsMkqYKZaXrNJ2fyh20VsSbkOCILzY2TsHEpDUbRIP2cViMqPYhACFJDJhFRYqkJvZHrXR1/RM8XazCTclqXYsws/EVozVo9tiYbl/036wg0FBYsC1IAhdNTh40GfzMFFzPAv990K9Dgwrz02ARj2lU366VUwJLQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792708; c=relaxed/simple;
	bh=B0t21POhzhnkPllkO0aJhsfTVayUVxYvYda/rajz62U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmINwx5QEGJVFd8k0MQ2/JrtBjlPLhPcJ6ofL/MwZvH02AwAdWMN1bRXOhjpqsCuZ2bOusGsncQox6yKf6/oxou8YxZSHoyCf6QMBWUrld3vNNn9rKr2BqHQNVoKBSE22a+vj+50pUOvyjPftCvHJ6sigp9omcxKakwDYeAId7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pefX5QbF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBO7bhld; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pefX5QbF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBO7bhld"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFQ9Lw4071541
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U76nAoGUFZhSMgN3LNNB9B5figDIPjE3gLJdeoHmGms=; b=pefX5QbFhFPxMWvq
	WEqX56c2bZF/NoxpQmnZAWt+Lkl02FkvcTAAD9ENCMOl+gw+syWgArhpcatRaVhz
	OsLx3+5UGGqGP6R4HIkcKSErnvRAi9C70jhwOWWFmsthUI6n+4BodjkgylCjZWjg
	JV2sBIsricxd2Jzi/iKtTEPxeq3fLTh2m7UYRvGVEyntoCWkYNiqJ/T/9J7nS7l+
	NUBP0qlH0EIDVg1pCVWKs5ZgD7c+WZGYCqgLV0kjXGXC/JJJRdLN2fI1ybHHiJKd
	cnTnG14zAxscCkqswdUccF4fNv5g9EUmqg49u8aCIgtxvTM4IQKoxvcbuAiVodIc
	JbU6lA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjpgr8uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:38:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340c07119bfso7880801a91.2
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 08:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792704; x=1763397504; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U76nAoGUFZhSMgN3LNNB9B5figDIPjE3gLJdeoHmGms=;
        b=RBO7bhldqyCAWF3kToXqYF69DfrPLfcluLUn200Rxs/y6XlQPEmjLjTza6aP1Mvacw
         nVXufcntxtPdbQE9yxbVImfkpHg4RuG68UqVIuxrxs1dxz4l9FFf0lQw0HtbcOpwGt8X
         AmhWxTZfGmZc1H60Q9+2tqX4cjBm0q+OxqyUGcqpV9K60TtPVu04aELcV/dM9LoB5DaZ
         UG7yODyQSm+iN3AsCGk7MimdAWfL8LOVaZfv72sOpeNLZV8Lfax+DEkhnqyhoC4LMgCk
         DbsDjcTDBYFmip+gvTxcIxuE86m3WkOmtPUigT2KSaigxg/SAQRdiGZXp+SoWmM6MXEr
         Nmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792704; x=1763397504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U76nAoGUFZhSMgN3LNNB9B5figDIPjE3gLJdeoHmGms=;
        b=MM53o+iQW1YadYoOxsaAGlDFV0slaBmHe3+RQ4RSxMKsH3RmKAc1ME6KjAlvKqoxFQ
         CNb+KAnJ5C7QKdN/3V9/NpU9Au3QGqi0EN4K7lrLk5fWtCM9R4c0wt3MgynUL6tOfa8P
         hIpjsRiHvSXnZAFTFNWnHf5UYW9baYVlKTscmmhNdW7uTvbGZdKHOMyG8hUHqH8PJtck
         IuxXL6W7X0UcLnSV8Z9S18xgLaX/JhuzlyJGd0D6O0cMvfvFLQdQn5fMRifBxbiSzeZs
         hxyyjZ48HKBW3t8Vp9ATb3I/h9PlRuN8TgVH2B1X0pc/TzZ5y1WVYjd834qgP+3gthfY
         9rAg==
X-Forwarded-Encrypted: i=1; AJvYcCVR0cxuGxK8kHUgqH04qYfnxDA5cqNxoqBvCccO3qXK6bjaCQMDgMs+xeJZ7KFRfvQPQbuR0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw73tYyuYDcfe9AceOV6XqnFmlPaeBWptlbBmvuD8mSh8cybB3+
	xEBatytpNc+vyo93/o/qxZepEO2EuwIdlZdbLVzUNZKT7fCpz6UYnk1KTcHgf1UHwil49ta+iLl
	w/cHyLUi2dE+75N9oF7cYCwCS5F/p75kf7Q1G4s1FuYDvXKRgwGmtPs3Idg==
X-Gm-Gg: ASbGncthgWqIP7apLeCkZp+RL9L9kHacCLRxZ7Nc5wJwBkR1Om2klTOVmCp9tVEX8ts
	DDNKQeYWGXW+LpqjfB76W0tpAkoze2dwEAwXh6hcSmwnCFz+FLQVWsLAQNp+Ep8ekZbJKhJusLF
	WFhTX8jbXm2zD25SR80ZyyjlrcX1aD79gOwPX+i7aLY5ZASC2LzvZYUeEkF6wruQf/jpA9G1gFq
	RAQ7J3Ab4aPOP383MhZYZUXF4goOtxGyiGO6ruRJocEFNQgEqMRwfqYWTBih7Uno6jY+MMk6RbG
	wrr5AGvRbOfr0uUBm8mPe39DlNhLccyOCChCS0nFBYa4ccobn53BckUR8lligOEbguwv7T1Wd/1
	S0po+OBk+rOh5v3JFiMA1CkA=
X-Received: by 2002:a17:90a:ec84:b0:340:b86b:39c7 with SMTP id 98e67ed59e1d1-3436cb91cdbmr12379107a91.11.1762792704052;
        Mon, 10 Nov 2025 08:38:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoVMuhMcPsQUnqMT/Oy8cOyzF5h70KIN3Q83LoJcFWHaGhmdTuOn6UcLQhDffxl/Uu5uGmCQ==
X-Received: by 2002:a17:90a:ec84:b0:340:b86b:39c7 with SMTP id 98e67ed59e1d1-3436cb91cdbmr12379065a91.11.1762792703541;
        Mon, 10 Nov 2025 08:38:23 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:23 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:08 +0530
Subject: [PATCH v2 02/21] drm/msm/a6xx: Fix the gemnoc workaround
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-2-bef18acd5e94@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=1529;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=B0t21POhzhnkPllkO0aJhsfTVayUVxYvYda/rajz62U=;
 b=5LGxm8q7C7nTAl599JSjm02h9F6JnfyOhlzuY9M+RH/QtTw4F1E31ZgmBsJOxt67zTsOJpNGK
 U43gtcuNh5UCTjwVDvswqSwaglhNGbvuhplr6cbwINEpI7UGgZnf/qy
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX6bv6slthc1hq
 IIoaWiOPYTKozFhEGNuwDZI2OU1OHtsQi53cPIteawMYtCSPm5uRH2fD38Zi3DY9TXBqyCjF29r
 9h+6e6PIeZ5LMMvvH6vY5j4e1RxJsEKTQKZPVj88VeCqz0lzaXZxmZczafAC1pPpxT6GBxhYX0F
 xxLDuDa49d7vdKUAO8kZrF+g786QefbMVgGRIImXVm1S/a7ujBKeUWkR7t+ZJGaamCQhi/aZEOl
 q0AK9BQo4OBHZXPQPKxkzQfiGSOtfUksdwk1oT89HH8J5n4fd+qhX7WlxhDpfDo8+6IjQuflAtz
 Og1PBwlC7OavrkdnMo2OkOKeoCXFS/C5ZFJbqdCIvv5huJMMsnYpIhx8EXl3tpsBdJEten56YYP
 iA9zxI//YiSQIU9xaINlhhKDGcjLWg==
X-Authority-Analysis: v=2.4 cv=br5BxUai c=1 sm=1 tr=0 ts=69121501 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gggc3m2WwWe7Cuz57AEA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: FxwHX6gCZbze8x7bhORaDEIuj0cBG9mL
X-Proofpoint-ORIG-GUID: FxwHX6gCZbze8x7bhORaDEIuj0cBG9mL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

Correct the register offset and enable this workaround for all A7x
and newer GPUs to match the recommendation. Also, downstream does this
w/a after moving the fence to allow mode. So do the same.

Fixes: dbfbb376b50c ("drm/msm/a6xx: Add A621 support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 4e6dc16e4a4c..605bb55de8d5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -485,8 +485,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
 	 * in the power down sequence not being fully executed. That in turn can
 	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
 	 */
-	if (adreno_is_a621(adreno_gpu) || adreno_is_7c3(adreno_gpu))
-		gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, BIT(0));
+	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
+				adreno_is_7c3(adreno_gpu)))
+		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));
 }
 
 /* Let the GMU know that we are about to go into slumber */
@@ -522,10 +523,9 @@ static int a6xx_gmu_notify_slumber(struct a6xx_gmu *gmu)
 	}
 
 out:
-	a6xx_gemnoc_workaround(gmu);
-
 	/* Put fence into allow mode */
 	gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+	a6xx_gemnoc_workaround(gmu);
 	return ret;
 }
 

-- 
2.51.0

