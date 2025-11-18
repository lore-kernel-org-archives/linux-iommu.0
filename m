Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B631196A
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455912; cv=none; b=Pm7azG0mzwBP6eGo40AlUpdYwEjrJqOSvLcaJGAGewzHQqrWwP6U7NVZ+KgtLggGjhvP9GEVHnGu71CV2tOsntZctoOREjPzjC+8S2g8UeAc06X3Eh5SzbXcUY8GZKCbj1z++nxxB8ztxpjjIWyW1tzMD4HxdkyjVFyKf0B+JYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455912; c=relaxed/simple;
	bh=/bkGsdPodJ4SkKP3xxQOVAelGLT5UoB+go22DhK77KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hh/aqp/oN5PRqBBDmvmOjOB9rkyuj+QVpgnDpEg3c7L9DR4DvdB7h1Ej6IW37cs3zpjDA6F9SbmH+5etdmeoMMD12dQWsusQqorJMut/0CradhhdsTUgZ0dybVWjEBtua1vtXKlpF1DHFntaLiZDaARx39wTcCxMmohz4iAeJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VD5WjbSl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aUQvqQFW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VD5WjbSl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aUQvqQFW"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8lDp32755669
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ZwXB4RhWASSlUxI/fZ15AWl1OAJD3U3jm7GNFqQCE8=; b=VD5WjbSlg10PR/Zz
	pPHjDzjg5RAlNjJdXNcCt6EyVw1dWV4LFvu2W8mh0ykFKrqWuXTocWOi9yKp1+85
	nDxGFvum+YIeTDyDfQvwMgiB1bUmFsHpAtzcZEB9PB8zC7dclNmKyW3n583iU5m6
	ptG+8Ij9EpKJcwubisfQ5WJ2OQIVSE0C8L36wzYO4RHQuoxfDPrPOVU/2hlHhq7q
	lvEDunjlQN5X9WIjfap/UgCyipt559vM0fGTzyXtUJGYFvvtLnN5eu7bzft+Q3kE
	CQ9/VR24JHsBtFu7xV2FrGn6TAMFeJP/tDYVg7nULVNcsmlzNIarK3/po60Y//zv
	HslQvQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnkj00ep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 08:51:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297df52c960so136900325ad.1
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763455908; x=1764060708; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZwXB4RhWASSlUxI/fZ15AWl1OAJD3U3jm7GNFqQCE8=;
        b=aUQvqQFWp4GvzbXvIsm8wMhyscP7f+Tx2xSo+NXvR27t1cKgiw3cq7F7YIBcBoRvli
         1v0MSdoV5VWDhnd7CaZbh+yAyk8o3Z7mamI5u1WWsMSleNQUJN6eF4aBcCj0EXU+Cq56
         O0p+sWt7JhNhraeCT4bh8I/F7sG+ejoC9FEzFdeiSw5GaSh2DBsLGJutp32z8mPEIPcD
         pXqJY3ytwv+7WhlbPc2jLub9ooI1AmYo+xc5mVu4HsMsR45G/keBZmjXDr9Js7obKcW4
         sJdeyWEXjhwKTZwCUZJpr4nUi4aoamvzmMQGE/2jBTQP9v9hQ6O5GIJlRSOMo2QIXiDj
         pXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455908; x=1764060708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ZwXB4RhWASSlUxI/fZ15AWl1OAJD3U3jm7GNFqQCE8=;
        b=Wzyh8r0aUCPtepb64GH4cbEInNZ1pbPheJUfALRTN4IEZcPafj+1nfwkdayQclqAqA
         m0C9pW1wY+g8KiL4CNxABF0hKWaYkn9Glr9jLQpjOCH6dNXY8mbfkOzkk4l6SiaHVAi0
         5Wj5qrftFQqzX4cvxLZ6IKNehrzJ2LLtHOkQunoPsT6sbW/lUmZNFUP/+wUQEuVjz8NG
         APiWUTK1QrdxzGO2zkIxLCX6WgQekKl+ObN+Ey3rwkqHrBZPm29FKN7BwQITo9kC/DLi
         mSw0dMbsvO0nE+mKMlgTIcwNtIBR+O3SFe84uUfO9Z9LsQuknTkBIT4/pgUz+6ubarBb
         8RKg==
X-Forwarded-Encrypted: i=1; AJvYcCXdnIGV2tldlKdcDkfOzRX+SEQFCUEcx2ZRDSWKY3uPBi8+diU2ZS96A/DizoQaG25S2X830A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsShpknSMPDjdnFlvgpRi1CdXv0rZKc+ufR+MbSOsZt1aQccll
	/7k7IxLAK2V06xnVyUtv2jbZrzbsBYdvR7Wu/F5Jtj41Vzpn+7uAjhDij4C5i5tlx0zhZts/kg/
	xRapUOgykN2hPm9RGcnr8DFi0UyYrG5+jXpne5TGvRkwgHi/t3fSnzaysqg==
X-Gm-Gg: ASbGnct4pyutITznyesiUDUaUJ2CDzo7Plt2RPS32zFoA5x6c+BrAOTnrIH53JM0Hwb
	LWcr2qYbVk3IzUkS5WPg/l5BeTQE5JtJsX8tiAwvF4lFY0ZLTC/pexTIwK0jv7K1PpH/hX+JQwe
	QqU5tcLXSMp0r57fnpgK7T7Hcn2/W+OtyqGe0obdE0Hrm0LBBy1Na9vzgfKx1JYUepuApVXodOn
	sDBtXGinuyCHnmI7swFChXH0QYx03Y4qwa9jdanIAYLorQQxAnwNHVQAXlDHWllDjK9y3Pf+Yix
	db3e5vEwHc9tNFp6XvUEsi5R3/kH1qKTPmEKgE+03XYgYFmWFMgQ0W7z2mwAwhaJu3pmESm/3jb
	ZMvTg9kwnRpOzTSDV59xGXSY=
X-Received: by 2002:a17:902:d58f:b0:297:dad8:f265 with SMTP id d9443c01a7336-2986a6bd2a9mr208182375ad.3.1763455908399;
        Tue, 18 Nov 2025 00:51:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtBwZUTiYtLygrybb58YIF/amuW50qQQNcGd/n0p3+CKZ3EeqPoD0tAmXoPQD31iO91XcZYg==
X-Received: by 2002:a17:902:d58f:b0:297:dad8:f265 with SMTP id d9443c01a7336-2986a6bd2a9mr208181955ad.3.1763455907923;
        Tue, 18 Nov 2025 00:51:47 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:51:47 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:31 +0530
Subject: [PATCH v4 04/22] drm/msm/a6xx: Skip dumping SCRATCH registers
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-4-86eeb8e93fb6@oss.qualcomm.com>
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
        Rob Clark <rob.clark@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=1280;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=/bkGsdPodJ4SkKP3xxQOVAelGLT5UoB+go22DhK77KQ=;
 b=Cu8W/7U4vntfUypSIoT+e6ZMqwHXL7dXJoM/TB2ZZ5v2hzpBwXrk0KoTeeYPef/fxMeMm2NbR
 A2soFU6jNtJDglw1G9wBMZQVrVwgL6mvZP4CKOGIPlVdXK+L2shNBIy
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: eeytthYCMxJuWGPQhhHIA8B504G7h6dD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfX1EbOH3Ym5QfW
 h4JhCa5VPKYTY74JUkxmn8eFwvbHEhnVWddCDyKVO2ypHE54OIZXX6VK59SS0GgDv1c3IeeuvMi
 yttUMGtxRx7BAvRMUtJb1MRxyR0Na0q6DyY0NXytjAgGl/7GRDhldp2I7Cq6bXO3p6BMUdittCr
 CXAIxA+HVCjlUNbdvVvRZItu1nrJ5d2ZDHNTmJFyy5BXmb12NZpKWrSWkhw4BJscAgrueBRrRRL
 dL2FhXjGNHWGdkfHSCbRR5KT0oUA3UR+Q5XBDYkU/t7O6r8qT25n3YF+4zRdwtm/9zaWXfnObSU
 K66/16qvZ6hMF3hURcPPbMgrXcrmY2Qxu+lH+O1cUxxVkWz20mtldcyz++K3L57wqwFog/COMlD
 bTiPI/rKVmvf70pqsXFjTy8Khlwv5g==
X-Authority-Analysis: v=2.4 cv=cs+WUl4i c=1 sm=1 tr=0 ts=691c33a5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rH6QHmREy2P50qlKy74A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: eeytthYCMxJuWGPQhhHIA8B504G7h6dD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180069

Crashdec doesn't require SCRATCH registers anymore for a6xx and newer
architectures. So skip dumping them during recovery.

Suggested-by: Rob Clark <rob.clark@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e6393ef0fd78..c6b2fdb86c17 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1561,7 +1561,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
-	int i, active_submits;
+	int active_submits;
 
 	adreno_dump_info(gpu);
 
@@ -1569,10 +1569,6 @@ static void a6xx_recover(struct msm_gpu *gpu)
 		/* Sometimes crashstate capture is skipped, so SQE should be halted here again */
 		gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
 
-		for (i = 0; i < 8; i++)
-			DRM_DEV_INFO(&gpu->pdev->dev, "CP_SCRATCH_REG%d: %u\n", i,
-				gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(i)));
-
 		if (hang_debug)
 			a6xx_dump(gpu);
 

-- 
2.51.0

