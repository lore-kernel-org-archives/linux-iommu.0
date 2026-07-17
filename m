Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FC36C9C2
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784320930; cv=none; b=rbhsMYQaqZYgfj+XVHKbRht76ht2fn1KPopdzGu1wB46VJFvlbKGc//g64UT4VXsxFo2aFgvme0NoJ9idHdaQOuBJQAgtX1ghszAWuD5AQyUf1fcOxwlBHQpkS/yzLgbVRKVKnEa7dvUAvYR4wIbdgiPiQ89RErEJA1YPjh6Prk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784320930; c=relaxed/simple;
	bh=OTjz/hUYsdXL1nGMP1P88FY2BvXLf3kfPOscxh457b4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IT54iu4+0XGsJHvgKL6KWmQfe/9+My6JkEl7y0KsW343BX967kXKAyKW/pQP+/M4Eo/JpNdm/eF/I2dU+j8y0HB89RWIUBWq2TaPiSqoL1XjKSh8j1LS+d8D6VzpS1gGfJz+rn4f9on4G63DMSL6FdbSpvdQ7ZoGykN62ysYk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F8KWpHMR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=feUAQqL1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F8KWpHMR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="feUAQqL1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtQ2h2990438
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEJ0uZQVI09LETC6xozJYzAod+qX4DJ0MzQIJLZn12I=; b=F8KWpHMRjsjMPMsl
	iZCB39fkxhgaevrxxSw/OnsjJu9+UxkQXWwyBPOT+jkzHSgljNuwfR7rUYwSxqBj
	97ZmV+/G7hGE5Xy3FoeF2vRifP56AW3n4++Q6qbFuWC9LZDrXBRmsdvMY9Y3m/3W
	JTladnYYNU26T2lZCh4aEjapaV/kTGlnmi8WGIEIlYuvhEiwWdNvxFT/fmuhoQu5
	HNiMz5Mxfl8UV9xci0w+ayfeCtSJ68XMLnAeCljwOQ6KhI7Oaqn3rihx1GWzciVU
	MMb8dhXBsTpKqwWFXnYvm/VipgnF/2ly2maxApBLr7xG32iInLxmzEiovSZ8DRVz
	Ih6oew==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3aurda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:42:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1179625a12.1
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784320927; x=1784925727; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEJ0uZQVI09LETC6xozJYzAod+qX4DJ0MzQIJLZn12I=;
        b=feUAQqL1m6gmems9/M+YU0owPpQ5KmNaFr3BRVY/FB9qgkt1M/4MWkSQvh9Z/Ss9Gx
         IBngnRjgkth/vPe7938sJovSKDzDoRLdge/ooHeyJgFvdbKyXinczHVNQNzem7aIOL9e
         ao8S+5z9ZwnFe+jrBaBh53okKqpTvLW6146But4fLKaTXSZr4EyIEgqcJwRcFMVOavdi
         WAMBoVH8IBiwFRbQ1TAp31TBfE4ElV1p2V3YTaDdqPA2URPORquYUDaB7eOmV6HJLMll
         DAdxEt4iTpb/Un2/gn1w03QOUH5vYMvIIRH+o9j0YUGW9EuU7CWC6wJ+hKiYIJ4Pr1Wf
         eyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784320927; x=1784925727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HEJ0uZQVI09LETC6xozJYzAod+qX4DJ0MzQIJLZn12I=;
        b=fN6RaK3PoZvn38j2CV98Vzi3N3m8oyEJ2+yddqNMHVCdyYkNr/r1apRwSN7TspE732
         3Ba1Hj7hz/KsT9xtMgXq/uKfws1va3JMUdC6u/96SWfzooHT6t2TXvn/+hLzpk9nLJGw
         SPv7hZP5Cizqvtf3MkYmjVeFFF1myLrS629CB7/b2iYJ93F3X7Tzf5vz+jY8iIG3niRm
         d6S8wO7wqmVvJm3TivmrxIIIdQJZFFNogYiXTxnfCWbrRVdd2hd7JrZB8Z3/GTIvwcd2
         4SJJnGM5uAi6OyVeAEDdnikoRHaXj3V2QDwRhreUCA9MTnk2mTFlq3V4LuKWFqf1Fd7T
         oPdw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/wtfcHJvTEsTRXUFPs9pqcxBZNRQNa+++hAciIWISsOkRdcHLOTxKxLFo+Jvh0wgvU31KfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqfBsj4enfeJCRSR9HQEjJ3/cElRA73CZguQ0YZiRRSOK57P8a
	GoI6gDPYtIeCCqJo0DtZEHyc0EkfvELmBygxAKW1vWICvaeqZV9WBdMs5EFutzf737x5raBnAn0
	0PDO7b03uS7UH9d1WDjdJ+jZn7oZep/BX7wtwkbDwZupgPzAXmrJXxs2r+w==
X-Gm-Gg: AfdE7cm/49RrnvZh+7d2qI6DrrvmwedLj1nHoPlK/5mrNxBE6Bb+1i9Cus6TQW8zk+X
	4fFuiYBmHfeM51ZnD3B9iWE+bs+s/QlIsWjFILnUNWZvC6L2LckTFruyt/Zfcb5YIj9HvSjO+9L
	vBDkJQLM47Pm8umbc06EvEHQqCdulp9Glo04OB6CChnCx5i3oPABiKJ6F/zgxutmVJ2XFzzOGaC
	leSpdIGZWLXr9EYn4b7nrW6hmTdbZyEXWPbMIrwX5a60xcWweq/FTxkcSbmDmO2SuC8vOIeAfIi
	kjUQKnmk202AmvvCeI7N7o2kdwmQBPeC3HYu5dID77xVaYvVFVfpiwkdcKsuU6K+kNlzh1KWl45
	5Qx6F93fJY1N/Eg1NYkoUL6oU
X-Received: by 2002:a17:90b:540f:b0:37f:e5b1:ec4b with SMTP id 98e67ed59e1d1-38e3d163538mr10090695a91.5.1784320927551;
        Fri, 17 Jul 2026 13:42:07 -0700 (PDT)
X-Received: by 2002:a17:90b:540f:b0:37f:e5b1:ec4b with SMTP id 98e67ed59e1d1-38e3d163538mr10090626a91.5.1784320926891;
        Fri, 17 Jul 2026 13:42:06 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:42:06 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:27 +0530
Subject: [PATCH v2 2/9] drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX-
 variant register
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-2-64379dbebd7a@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=3230;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OTjz/hUYsdXL1nGMP1P88FY2BvXLf3kfPOscxh457b4=;
 b=arW5LOtnhsz7GNASG3k6T6849UaVGE8SxWpxFRJrV5xGwidmIhco5hKA79Zbb2P93PIK0zXO5
 NW9ANLNRiHjBZZmVwziWRlZIJZJK1ayJsn7ebxeRUw+CxcdiSQZwX1A
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfXzBqpRDgISyv3
 lt0/h08uQYNt+Y9T44SH7TsWoDFKr9LE0mn0F5ki2qKpMEPUOCGgixcQodnkHp9NoJJ78D34IrV
 3KPwzd2CcunDZx/ytTFD4asTJyEzbt4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX5VIum3OfmajV
 uzF8L9OisQ1Y7ixsxz7ZdQrTJyDQSNhgBuQv0iFAekRoIqOnsSAumros5u2uZ93fYGJnx0S8WPi
 +mpLhvvkOPUCCwUcDD3YdCFTDne/bIZW/U0RwmfIHqM03UXkJxRV7Mec1m70wCmVxR0UOj0fnk/
 SzInGTm37HAAT6CX2GSJT0v3HhzDppw6Wid4+o87dYEYGfg5LuV7uEbKSCOZXvf0zgWVU8XFqN9
 c7qqHtx6735qXanzTDv1n/KnBeDQ16WMmyiYOIhcCE+UEhF6FFgaFtPLY1rGhQPdTRb9SgfphZm
 80s3SD8tP4pwQ0YD+uKX5KMnJUvS+KujvOn3vYAqIWulTaB5FGN0kzfFgI3F90u41CnapDq8k11
 exiF99svgVNyPgYc5uU/8meZoK+lCGbIqoyEFPJVeHfTxz+nN2RogWFFnEJMs95wZbQ49UdxNNR
 AYbJkRM+dEX2dGrLSUA==
X-Proofpoint-GUID: fDVxIY3ur7BxcUrVE-516mqdpZNjR_sO
X-Proofpoint-ORIG-GUID: fDVxIY3ur7BxcUrVE-516mqdpZNjR_sO
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a93a0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=W9u8H8Hp_niEWJubwdoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170212

The GBIF_CX_CONFIG register exists on GPUs prior to A8XX (it is used on
A722, for example), so it should be tagged as an A6XX variant to match
the register spec. Widen its variant range from "A8XX-" to "A6XX-" in the
register XML and rename the generated macro accordingly at all existing
usage sites.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c     | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         | 2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         | 2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index a98d550b72d0..4b68416e4d05 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -2180,7 +2180,7 @@ static const struct adreno_reglist a840_gbif[] = {
 	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071e20 },
 	{ REG_A6XX_GBIF_QSB_SIDE2, 0x00071e20 },
 	{ REG_A6XX_GBIF_QSB_SIDE3, 0x00071e20 },
-	{ REG_A8XX_GBIF_CX_CONFIG, 0x20023000 },
+	{ REG_A6XX_GBIF_CX_CONFIG, 0x20023000 },
 	{ },
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2e5d7b53a0c3..4a3c8dc8bb88 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1032,7 +1032,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 		gpu_write(gpu, gbif_cx[i].offset, gbif_cx[i].value);
 
 	if (adreno_is_a8xx(adreno_gpu)) {
-		gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
+		gpu_write(gpu, REG_A6XX_GBIF_CX_CONFIG, 0x20023000);
 		gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
 	}
 
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 9e44fd1ae634..6a75bfb6cec1 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -228,7 +228,7 @@ static void a8xx_set_hwcg(struct msm_gpu *gpu, bool state)
 		 * GMU enables clk gating in GBIF during boot up. So,
 		 * override that here when hwcg feature is disabled
 		 */
-		gpu_rmw(gpu, REG_A8XX_GBIF_CX_CONFIG, BIT(0), 0);
+		gpu_rmw(gpu, REG_A6XX_GBIF_CX_CONFIG, BIT(0), 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index 3349c01646e1..69dd0446f8d2 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -1268,7 +1268,7 @@ by a particular renderpass/blit.
 	<reg32 offset="0x3119" name="VBIF_PERF_PWR_CNT_HIGH1" variants="A6XX"/>
 	<reg32 offset="0x311a" name="VBIF_PERF_PWR_CNT_HIGH2" variants="A6XX"/>
 
-	<reg32 offset="0x3c00" name="GBIF_CX_CONFIG" variants="A8XX-"/>
+	<reg32 offset="0x3c00" name="GBIF_CX_CONFIG" variants="A6XX-"/>
 	<reg32 offset="0x3c01" name="GBIF_SCACHE_CNTL0"/>
 	<reg32 offset="0x3c02" name="GBIF_SCACHE_CNTL1"/>
 	<reg32 offset="0x3c03" name="GBIF_QSB_SIDE0"/>

-- 
2.54.0

