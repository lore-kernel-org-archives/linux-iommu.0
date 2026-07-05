Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995235674E
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238461; cv=none; b=pyN3hIznhynM30YFJomj9vFrYzuuulmNS9s9zi3oAijB0+NhWPIUnw9epHwPQcImMqCdyVKHTLNSjJhxm4kkX4xGucejBaTOR9VWqsKh2DKNMLzmvkIt3B4oCwDXuEe0VV0Zn6U4uj8RGB2uhXkX34fg6hw5+mkUwz7VC3xAcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238461; c=relaxed/simple;
	bh=3Byd2iwGy8nbSKXVCEt6BL7u6F87e2rKPSvibHz74Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKJeysUPC8vzOb7QmjxmMEcB81gZSzjnqRnudBR+IwTgqXBN4acUQHJGkU84QgE4YBux7pQdcfuwHXqE4qFEiyVFm2eUDeOBo/jwn3jqivAL8C/VjyUJ5ou9KFg6WgF/56bqYR1cNKWWdibCGOKCZsTuXYArHGgncrN3bj2Jqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FawQpZ4f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Trq+Vv7u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FawQpZ4f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Trq+Vv7u"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6653WdWV616158
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VzQCh286Vg0S8d0fqoIRZWO4vh9rmDpADQm1Ym6AjIk=; b=FawQpZ4fFI+jiPuK
	vx9c5ybAs1WcfqZtTaPGNDX6Akk81RRfV13sdz6DILVqBgDHkBzM8jTBXDvfDWOw
	4A3yUw7iTUqXUtdYCPY2wXwGxp/8gdPGxAmyR1t0Wez7Bg3Z+0SR+/9NO/RIxPKt
	NEsJebZGJN3l4oOuAWSOklB7ZlFlNV9WEQU+m9/mZ9ZWGHCZVGr/60rGhupFLusB
	F0KGFgTZJGea+9UBdjgKoOlx60c6jkQdfqDXDq3qwf3yRUX7GEdUs0rzWNp3RjtR
	IvV6neX6pnWlD6BpRsLhOeviczNpkzxDf1zL7qOfsewArvRB6OIBzzgRI4Qv49Wt
	4OT3Aw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvjbmq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:00:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3840994b0d2so1319485a91.0
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783238458; x=1783843258; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzQCh286Vg0S8d0fqoIRZWO4vh9rmDpADQm1Ym6AjIk=;
        b=Trq+Vv7uPQc4MdbvRfPe4NHTWWDV6GcZTqsuaZAPXIoHdgZWcdSKCIQjvrNwo9yfFg
         vXTUoREeD4YkDZbLugQWJN4s5XwH4K5WKGMz5NuTWGRgZeXddJQEO1ytqvVaDPCJS1Jb
         IWJvMhyrM1Ybb7FYLlVuDCw8njtd8WoZnjZNoJck5HNHaDl43JhbzOrSSpaukGljuori
         RwhG8cSdMdHcwMEzytXMVnqbjHcl2feDz6/iGTI6FQR/fHYSWqRIBCvbBTsDMLkqdgal
         Z62viANlX2OoqU4s4lwbRhoeeRP5nIeYTiekgTdhfkEJspfMOAZ/y3ZTzeHzOpckFM2N
         KmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238458; x=1783843258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VzQCh286Vg0S8d0fqoIRZWO4vh9rmDpADQm1Ym6AjIk=;
        b=b5eAENWoi1IOBXeRkKUfMyu3Mwx3cWCulj9d2eZrlEZ/JQasQZsuYlHvzGSUbBuD2t
         cF04UiG67J0NqcliF0pZqTWeGU5En/lCHN9ct9zGCdAHXHTqM4CiATTGSI+fPufbtnva
         aX5X7Bk9DJppjb/rhyKJ6aosNnXixmsh6BSjS2sQdzoJ8f0TDh7zy3rGSVDZ6C0iCHzq
         d/xXut26oV23G5ZkYBaTX0Aiaj9+ZI32zMddw7CHqkIR1suCIZW5avx2U9XnbGOnETF/
         wGZ9BRb+eThRSOFAlJF23CCbQd1truNf09tvlrG5idx2wiP6hpIQldJPk0tXG7+kOjAp
         6ecw==
X-Forwarded-Encrypted: i=1; AHgh+Rqmdh7Q3KPOfRAafXJ5JnjPlKb4TXLqW3M8smRFrKW9rtpus2j6Mz1w1h86Gr+0/UJO/HC/Ag==@lists.linux.dev
X-Gm-Message-State: AOJu0YypKDouhwcr/uJ0ffO56lqiUi8Y+uoT+uCAtYS4SysOgS3inDEm
	qptE15ze6HrK/n4Ykxd+RSsf5vxoeP9zmYNaAZOpouphvbLhGRNUw7OQNTaZMBTUYzjenM6VNgA
	SSz4BPWs+HXh2WciT95cw3Js1isn9kdyyVyuf65tj8/TshoUmMro2ZhwnHg==
X-Gm-Gg: AfdE7cn0CxpcryJU0aWAJiDg3Ki77m82pn0ka6jpU+7kA+0RWXSrQE0T5tPZy65w5/Y
	PW9PTJbmZub76knnG5Zc1djdvQaAnveBitWb/ll3ClqQHwxQadDNedvxJ7yexMqY6LKinhWcu1c
	mAC29C3HU+XkXtS6GmrM0GOa7SR63dPQZUGt6e6LVxkYvHcKR3CW5/iIa49UdKhHmK0G0kcHYAA
	ELvPhmhkNJFRknBPW544LDzHb7w6R12zN1GoI02md0xHIzUIbvvdsZA8DSGaZmbyBkELAyXea0+
	SCUhj+YP2zvCHH6w64DjnLnIGTA1SSchgmL4Etp/Y3P4UvtgD1Iz7PqYMWfuPEpY45iI4cWZvkP
	fCk7Kcxst5AvgPD1TmtOd/dyeaDWb90Buzwo=
X-Received: by 2002:a17:90b:4ecd:b0:380:86d8:8162 with SMTP id 98e67ed59e1d1-3811238f60fmr10862368a91.18.1783238457450;
        Sun, 05 Jul 2026 01:00:57 -0700 (PDT)
X-Received: by 2002:a17:90b:4ecd:b0:380:86d8:8162 with SMTP id 98e67ed59e1d1-3811238f60fmr10862324a91.18.1783238456864;
        Sun, 05 Jul 2026 01:00:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:00:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:05 +0530
Subject: [PATCH v2 1/8] drm/msm/a6xx: Increase HFI GX perf level limit to
 24
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-1-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=1999;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=3Byd2iwGy8nbSKXVCEt6BL7u6F87e2rKPSvibHz74Wg=;
 b=tw/H1MbksYZS+PlUsCOdhIVPmvoITEFmuWZhx/fspqQLWZq2Uz+hdMwK37lq55MF8qglQRsta
 7jMqHdoWGJLBZrYt67Ukusw7TuMk9Jvgcz0QFBu7VPGvZi2gEF1f0ry
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4a0f3a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=bjN1K8ZYlNTK_pBii84A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: XqlA77Ksx4MeJUnKIyi2gfwKlvCUcogY
X-Proofpoint-GUID: XqlA77Ksx4MeJUnKIyi2gfwKlvCUcogY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX9CTmDjf1PQyL
 4ZurKWq/jnZcOgneCVqsb+93OTxmooWVT/b6ClfAil7BI3A7AnXvLR2WgubHCrD/rzsduEINUxq
 cAZQ8EnskSQIiqPeEZV4gUcJo4oRF4HMCt/Xc2johuPcBOp04maIZqODNDJ5p9CHAAouZekgj/M
 hEb5GAdeK4s7mkq3MaA8TCWGRPZcZrYQZwa791thYKVnOKyVNX5ghdo91mKITR9bCiO0T9qkVa2
 4nhwkr5sRWHboD7R5zjfDU7tfp/Oy0W06islsrmh3IEibooroCNzgJ9l9nX/0PBamSFhL5RRDGp
 86Tl9JuGp9o8m/+sN0NpSVOe7kmdvHf+OBbjyhQhbQIN9Vz/k3Zrkf4DamwiLGHy2QbKWLuUW6U
 xrSSg+OFo4AyKmW9bJYfxq0klOIBxFSyhS7oejDYkaUAqeLr3q7gRi0ZDZKOfAtfVJBmTBFgUOx
 2kybcCGF9E5mQUVjY1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfXzyIDD75JmO95
 Z38Ax4beMqQ6dC9ByidR8DpIdH2TmRli/kRrkmd/hSf4Be8x5ltgFtmf9f/W+YnJOzZA/xRxRk/
 QM1rcKJZe4my83jIf+ZzUq1diRtJlDk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081

Newer Adreno GPUs expose more than 16 GX frequency levels. Introduce
HFI_MAX_GX_LEVELS and use it to size the perf-table and bandwidth-table
GX vote arrays, and to derive GMU_MAX_GX_FREQS, so these levels are not
truncated.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 3f96b10b5f61..62e3fb230cd3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -20,7 +20,7 @@ struct a6xx_gmu_bo {
 	u64 iova;
 };
 
-#define GMU_MAX_GX_FREQS	32
+#define GMU_MAX_GX_FREQS	HFI_MAX_GX_LEVELS
 #define GMU_MAX_CX_FREQS	6
 #define GMU_MAX_BCMS		3
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
index e10d32ce93e0..f4da73a555c6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
@@ -5,6 +5,7 @@
 #define _A6XX_HFI_H_
 
 #define HFI_MAX_QUEUES 3
+#define HFI_MAX_GX_LEVELS 24
 
 struct a6xx_hfi_queue_table_header {
 	u32 version;
@@ -119,7 +120,7 @@ struct a6xx_hfi_msg_perf_table_v1 {
 	u32 num_gpu_levels;
 	u32 num_gmu_levels;
 
-	struct perf_level gx_votes[16];
+	struct perf_level gx_votes[HFI_MAX_GX_LEVELS];
 	struct perf_level cx_votes[4];
 } __packed;
 
@@ -128,7 +129,7 @@ struct a6xx_hfi_msg_perf_table {
 	u32 num_gpu_levels;
 	u32 num_gmu_levels;
 
-	struct perf_gx_level gx_votes[16];
+	struct perf_gx_level gx_votes[HFI_MAX_GX_LEVELS];
 	struct perf_level cx_votes[4];
 } __packed;
 
@@ -144,7 +145,7 @@ struct a6xx_hfi_msg_bw_table {
 	u32 cnoc_cmds_addrs[6];
 	u32 cnoc_cmds_data[2][6];
 	u32 ddr_cmds_addrs[8];
-	u32 ddr_cmds_data[16][8];
+	u32 ddr_cmds_data[HFI_MAX_GX_LEVELS][8];
 } __packed;
 
 #define HFI_H2F_MSG_TEST 5

-- 
2.54.0

