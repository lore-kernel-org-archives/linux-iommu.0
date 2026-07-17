Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE23A1695
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784320921; cv=none; b=VpazX1oQzEu7Zl/YT7hJTLnYXm+sZgiUy4oAWf2NZD75lvjnD0EOY1JD4tVSrYe6PcAz8K3viVVFAbz6P2FE/4k9UWnAorgqEbDt/K0bJtx0veF8VZRQuSkxwkDwhMNX1wAQzVSephO9NDTVOquURRnsL4J8lIw6CE6Dt5F68uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784320921; c=relaxed/simple;
	bh=9inCuGVgbyRRoULQ+mF7qHPLQIcozjf/f8dlewYf790=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQWuWt+LYagncqqvvBUyweKGxL5wnkmSv5e5QOegFui9yEvWo+e7djQqeVuxTKeyigxOB7H/4IV2RH1rVSEkntIc5zvlATnXTAzVXLLzPASnFiweIjIAXsr+UhbgN6VubHkDM19ch3JBDIOYClrooFYBEzGqlekozS/l9hFc3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZHl6nAEW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V5T8iGO5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZHl6nAEW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5T8iGO5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtpnb2599010
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hj9k/hn+4mYiUHK6HA/S0PAPXL5EHORkZMZGm7VAmsA=; b=ZHl6nAEWI3hupkUA
	RSklRR+dgpPQifepZ+uCiNbc/lwwhV9sXYZ2JsPr4nannzsEyudc3hLYcZ+dKuRI
	fsH7hrYvDaOmeHqRN1YgIx80p6Q1rdI9yjYvdZ7a2Caa4fh6CyjWvxPOeT5yDVUz
	o+sUhfF6o3IAP6Pvq5sd8se77yVU6+f6JMM6yQZFTJFbeCDZ+k2zsTVUg3HZ7YA9
	/PwO/Bm1jSfoKDJIZhaWnAQQaxb1nQgF4ZC56/+hAtxgr7QpR0nfmWdxqkUtSIfu
	pgcSIm/DOf1yW2S3XozgVCwOiUlQWF8VRSqIANpYJCMuvARJFOa0zxa3yQqytlRF
	GZzmvQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrp8rrc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:41:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9151bf6ce7so8966182a12.3
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784320918; x=1784925718; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hj9k/hn+4mYiUHK6HA/S0PAPXL5EHORkZMZGm7VAmsA=;
        b=V5T8iGO5Sk/JdtxJkHNlfYBkB+vsa2dFD3Ap+5IS7VzcFYYfHr5nQBVO+QlJKjnvO8
         iVYe058sRBsjGmZ0p1cM1NPAsSXNfTDxSAFAIhX+MSIZM/lAHM8EnqTuMorBCwyn13eR
         FTRhxuL7Y7/+MKl77B1fUIXWJgS5Xq7gGQIWrfKtKv6qGFXC09cfTGth5VJOjpUVYXJw
         ua/eEj81m3zOMbjOVev9GGGrqYizpirdYqyIbdhvncrCiyhVXZ7YlAPqUUvre8hYlmOn
         nf2vWDIK2SeJPuwT7IMCr8P9Bue/xe9ATHbLlXI6sMyQar3atn3IqxBw0La/Ltbf4i3z
         nD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784320918; x=1784925718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hj9k/hn+4mYiUHK6HA/S0PAPXL5EHORkZMZGm7VAmsA=;
        b=R51xExOKPaJyNf4XKhNRXMorkHHnDqLwItseOf4eJazCZB0myzhwvJ6f/BnsVM18/p
         UQPJ7eYzi9nBAwypyC1+PPj20RwoTiyFI9JYwKESUKmiDL07Y9J7bppQVkN1GHCUrlTT
         inn1LUhrCaoSF6kDSO/x6hahet0suEoSqbCM76P+3uLr15xKgx/eHDcd9O7YJSrsrlYe
         jStmuxZ+xdsmvD7AR43oI6sXBIgRuEcGgDVo6/iw7uTmxHuaa4x6/HRyAZlo01rNjD2r
         Nv2/aizYCtytj7XzOXCLribZpdnlcH0ujACRsD3/UiMxAtBSHZ4MbwNTqUBzzm1+dVph
         VyCA==
X-Forwarded-Encrypted: i=1; AHgh+Rpbgf7ZBJEmM9qKm61+27n99hTGWrOBXczG0Z1xNCI6JVYVXOmZD35gBzKywtsIGBP3vaXE+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww1UpU4B6YCpiYTy+sR8mTY8GmVgu63+9EAKkv8ye66tW7Jurp
	Sg1Sbvrlr2yhipvPYxXQNwsmNAIu948bIFKeCqAEVVXlEwHu0Bq9a4DdZodpLFJwYYabD1I+lVn
	koTXUoFV8VnfwFddxTdd7J2uSN+gkwEMbjkMqM9qaTmqstLsaNoTXbvP/vg==
X-Gm-Gg: AfdE7ckijXZpdtSRsllbVBKQMiyiBuzCRRI/o7Z2ss0Y1bwYJC74Qeao+xZFtxA6Q6L
	FbypEl/DdN39AtNGJdrvQ35W9SWGboQ3jYHireAuwA0hwNb1IrSnKkRS96fRQ62OACspayFxdFk
	lQ0CkC4mkhLpp6PXguy0K91dvvCyGZEBFcxurGv7X03SgTu532FO+0+9pw0kRwSIwKkpGC+LYF4
	v/AkKq1V1FhkV3COt5819rFNnGRLHp6HE3TjMxPFgolueoxgzy9hTmtEtyqRFH+ZITA+UfMs1O9
	ZZcDBF82hhmtNbKJsNwaefOO7jsHVxbqo3E8mpyrpseYTx3PYmeBLWPjSrwBVYBKylZ6HiA7bB/
	v1fSuzWsM8FcmEmmE3jIyDpMb
X-Received: by 2002:a17:90b:4c8e:b0:38d:a8be:a592 with SMTP id 98e67ed59e1d1-38e4b43cccamr3944743a91.19.1784320918508;
        Fri, 17 Jul 2026 13:41:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8e:b0:38d:a8be:a592 with SMTP id 98e67ed59e1d1-38e4b43cccamr3944683a91.19.1784320917831;
        Fri, 17 Jul 2026 13:41:57 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:41:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:26 +0530
Subject: [PATCH v2 1/9] drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in
 a730_hwcg
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-1-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=1299;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=7exucDpQz56UUOX/GS72C0Nnz1GCp2aiTngaIPcMmkY=;
 b=59JZ+AiPbO7Um2ErH7yj1zS6z8HAFQqgcXTIpwOre8CaO2cTECbjzx98rAS+Oug8orhhgR49a
 K3NAhQOAEYCBdkiHjRWR8HaW5ARAVWD3vALuGFL4Nw0BCXXBQAVBjGF
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX+iyMI8kFJJ9w
 o6T4x26rZQzApi5zNBWpWfoC2I/fX3XDpoC6HszNhbHwAWc1L4GgmcoSGFnyRE3S1H/4rpIPdfY
 23ZD1jXBAbiRmBr1SL/jiQrq17MoPGg=
X-Proofpoint-ORIG-GUID: AgE9XgNc7y5quzYQdPHgAXI-yLhgQXwe
X-Proofpoint-GUID: AgE9XgNc7y5quzYQdPHgAXI-yLhgQXwe
X-Authority-Analysis: v=2.4 cv=fMYJG5ae c=1 sm=1 tr=0 ts=6a5a9397 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Vf0ozLlH3VOCCO7dkaEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX6zZDqw+IiCBR
 QQkHEoqpYlsqPFExwtHdnksX6xH/IJETMlIdwkvTrrFedNMHyuxrvVe72f8OIrntmStmwM4vcQ6
 gLHGArzSf/ttikMIWFxevcAvGSljMZTJlk3JafLoiSDJX2+M41eZV7n5TqoWVptZBGcxYDgqr5j
 0DpibTyGqCHlgMxwObo0lb+cgkhQkXNdaEXkKtTnPI2uzjiyWxAFRcyjbMbgFjmNLHWBjPOoRrg
 CjzJmN4RfzMWs8g8qpIlKu5Zzpnl+wDzhQD9RzYpPvruXxAwJGREiqIrnwTJ42sLhWHON4Oamfp
 v7BrFFyQI52+tU6JMA9g1zpWHMLDlLZzUBcpTc8xYp3sHyiq2hloYGj7ps5lRIlsAy0NGT0gtTH
 EvnmurLOoPpiGFGnvit7iwTLUEL7FkWKkMw6bfCLq78EFrIEUZl1NwFnO/TM79mbPq8hDjRMOhD
 fK7nZ2oEZEFlyXb3y8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170212

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

The RBBM_CLOCK_CNTL3_TP0 entry in a730_hwcg has bits[19:16] set to 2
(clock gating enabled for that TP0 stage). As per the latest
recommendation, clear this nibble to disable clock gating for this
particular stage.

Fixes: 9588d2f860a4 ("drm/msm/a6xx: Add A730 support")
Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..a98d550b72d0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1199,7 +1199,7 @@ static const struct adreno_reglist a730_hwcg[] = {
 	{ REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000080 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222220 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22220222 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00222222 },
 	{ REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x77777777 },
 	{ REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x77777777 },

-- 
2.54.0

