Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8212D3727
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781472809; cv=none; b=phiDKOOsAt8WbwRBJdTz6F3pJjgvPukBAJseo4NQES2at8XB8nert9NCuFgAw5FhsXIt1iLOP4OlPj2Hbl13sn0sgJvPP4/kItMhBvZ/WgjafSQjjLf8/4Xv/72RmFy8dAv7Dds0pbYGJ+ZJq6qLh6FFgLEBKWqecPnAQ2s3iw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781472809; c=relaxed/simple;
	bh=aKYaFQuR3mRNY5GJqhrqmXPugj5CU5q+HIdo/n3yIgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfgR0NLWJO6N54NslomgHb6wFW2S7Q6tGqO+u6yLw5scbjNOdYINcgtA13nC0yKxFvjj5TZ3QRDdAEix1m//zWBdHwFrE+y+M+beG5cxzi1rRGSX9Yyo6K3+DbITlPdAxfFX58qzhTu/5BHpMEUV/vHSHbCQ7TxETaL4NB9nhwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DvRqqshj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R97g7QmD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DvRqqshj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R97g7QmD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ELEUpc2694514
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BBa5VYXjVh+mQki1BQtkfNYs/iy5UlWU9hRfZC/T0lc=; b=DvRqqshjKbCq8JJR
	uAHv4S0lD8FL1S9l1b7TWhWXv17tLh/8B+qHSh8JZWbu0pyAzRp23j7et3hhdVKL
	DA1UNHk7x4U+HjMNW2a7Gc4KsyD/CzGGstSnFCN2nSeCikLD7SWuZTzGgXP8Lszu
	6vTbc5BAXVITLbnJQ8zmEUSiYiqG/4nrW80H7HmghacLSyY/zJ5ZMViHNE+RpJKR
	TNfnHFFNAlqMbRzJtcI+Rqmo4q9y9qj9i+svytzIfXFqfULH83eRhZlT53Xfxfv9
	nMAF8TbDHAjRKkHik2ywQLMGBMhr/2TX5thbyG0XtQJytOeo8aMZVzUgUneq0Kt8
	p5eFVg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gvmfg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c2d65d9773so25692975ad.0
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781472806; x=1782077606; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBa5VYXjVh+mQki1BQtkfNYs/iy5UlWU9hRfZC/T0lc=;
        b=R97g7QmD50VYoB3o8vhQhwOjw4KAS311EoCcU/+/mvYQcxPT/RKS+LCH6ppj9AlrEH
         aFEkeuuOHsO5Eau9apbjABim7995KC3qwNDzuBlpl2jv0eIVe3jHJlY5SPdlwzq2SsWB
         JagLPNpKuBQ+31CDdZ0gMmJ2th3ceMhsN6nTTmnQhiXZwU8mAsP97VMC5v8RBw+ouTsm
         PbF/j4W0jUtboLgGzQUCPienBJJjvpXmptpFduX0oPfhC6RmzbpA/MjXMNtdylFbY+3h
         79jo4OR24BmLMwj0gAODJx8V8btgTPL0HeRkCiDauin9zfAogjgvtbRS5FNp0+m3SO22
         sy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781472806; x=1782077606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BBa5VYXjVh+mQki1BQtkfNYs/iy5UlWU9hRfZC/T0lc=;
        b=eHRdMstwfXRtsBIuv/dYFTQeZO3xuDDfvqGkqQmx3RKjf4rncfc79nrSOclTLhayWI
         JCSWO5mAk3V1lkI9kOO2lqb2B5JtWDMvH0PjYK9IVHUOjfKc9es6gzrIjkDHs4UWaJXU
         8MZlr+TCMDvqzeQ4MZiMLY0Yb2RDcNuxA/XGRARaVwogC0QR80aUq4r62LwLoQhiuN4Z
         q2/kqIZhS/XgYYAyHZiD3VO90NGMx1yYOnxriEg6JA4FgLQx3kKnddZicHSgjDivKvxx
         Eh7Lw5wyodGf96U6ZMfr9DQcqcNgoTDg0kjwJLKsVnSalZ8NvdZvNtpj5twYndD8R3Vj
         fdKw==
X-Forwarded-Encrypted: i=1; AFNElJ+iOHqDilEC/UhHrhlEpajbfnUTPOYXhXfqvDo0UumZERtp2AKalzkOyQYIhy/Simowr5ArxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+bkCPeE9sK52eqwmJ3DuVcDjZYRWEwt9s4WdAopgjhuwRVmw8
	PCP7J1938R0MFkzZqxcAY18j4LXkGJGxDP2OyxykF0MPHDKIftvtNeX/eZyzoCEByh4oBjHBtaN
	wNtvjwyY82goKaWPfxbcR/y4LAVsFtpjg0vEPGU5h1p50sRSZldwmUG91Zw==
X-Gm-Gg: Acq92OG1g5hEqPe9HaD0Mo7CFWUyPoKY7u9eUzasLm5uoiEgY6mM/wKeYAkhcWFh3yp
	QC/9C5aR1dxOFD4eq29Y1miz2sPFSaCq9y71AEz98jnjK7/OSpw4Hgu3LqsY20rQ0vRXdQ+TaJb
	PFbcOYSp+BQrHqK46Kj/elAxok2wJCFXkrVJ3zSbAW+ru8QZW7MDlQupIGgpFSv0upTK3sjXPFE
	P02CxmBUhQCJStpZw69GwfjfwE4shzcMpZoTtZVnc8UViLWHbStTc+0EhDJ7ITixQEOPI2S0tEn
	qx0//wIo1wtOZ84LuI0UFbkWCdvbCn1FdG2APx087yemUpyitVADsmMzKWJzmmoO/qKgRxEiIs1
	rNHlTGr312rDuinne6ZdK2qTPQBGeV1ZEi+yXqGpnVbCIFg==
X-Received: by 2002:a17:903:944:b0:2bf:23c3:34ba with SMTP id d9443c01a7336-2c41216d384mr127694035ad.28.1781472806148;
        Sun, 14 Jun 2026 14:33:26 -0700 (PDT)
X-Received: by 2002:a17:903:944:b0:2bf:23c3:34ba with SMTP id d9443c01a7336-2c41216d384mr127693605ad.28.1781472805748;
        Sun, 14 Jun 2026 14:33:25 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c5dsm78385815ad.21.2026.06.14.14.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:33:25 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 03:02:58 +0530
Subject: [PATCH v2 2/3] drm/msm/adreno: Add support for A704 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-gpu-v2-2-2f2d1347c3fb@oss.qualcomm.com>
References: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781472781; l=1143;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=R79xKmL+sZwSyzKrrAiP2VZ/Wn0sPCCgxYAlwy7UjP4=;
 b=yglw6Mgw5GWhrR/ZbfN4m9aEdZT4bjZDfQ92ZeoxePei8sXC4tz6Dq7Wn02eKzL+XQBxkhzli
 l0y5fuC/0UiCE8iWe7/3pfwwu104Dj9hZAY684jfSys8jDndsDHCPsx
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIyOSBTYWx0ZWRfXzBK09EIy/6VK
 8qkH1UoXlXaGIHqonx59b5V7ILQ2NpNjdPaZeTjUEYPGfImuUNRZYcs264P4rDgwVbCqXYuF4Pg
 OhmlhNH7L7kny8+q55/4z01Fz0T0Bzg=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2f1e27 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIyOSBTYWx0ZWRfX+dW+pTyOcA60
 BoCUmOsm2ZxxLjD1Fpqzexb4DJrhbV2fUhRQDJrvf1MEJoqQ4BvIOg/1Kb09H1KA1SOifVQzVMj
 fRcv6+AMEyhKn/pbYpNxv17VQWda5VlhIRTjJwjbBDsP8l3U90X80xkgDO/ySWROQOptajDvzvH
 HgKr5H1erLbh88nHjIJCri5TFT5FqDFgN8q9wVVXYvw7d4AmLWG8HhZcVLUBDAOQLZIpl/qjB/B
 syqE3fD4vuJGk+1wzNshw/RGZ5X96JwRpgfpo0BEP4KwBPbmvDzjVUbAlxeQEhprR8Aib86l9xO
 DYinFYqzI21zIsQCbI+IghG6hsO080HJUPHOj2RwGfHg3vYosxSKn0Aj+MGZwkigFl5NMQeC0yx
 C2eP8v/zCl2SZKoyCN//wBDV7URLnjIR8uFgqgeOUXXw37YUZ5afzv7ByYAKq85Fj4DZaMhgVeh
 +xEjDh7SzbQ8xMPZp7g==
X-Proofpoint-GUID: ONmi0_vL1IGVDfJRY34sgNHy4LApCgm7
X-Proofpoint-ORIG-GUID: ONmi0_vL1IGVDfJRY34sgNHy4LApCgm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140229

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Just add the new chipid to enable support for A704 GPU in Shikra.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..2de3ab010135 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1454,7 +1454,7 @@ DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
 
 static const struct adreno_info a7xx_gpus[] = {
 	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200, 0x07000400),
 		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
 		.fw = {
 			[ADRENO_FW_SQE] = "a702_sqe.fw",

-- 
2.51.0

