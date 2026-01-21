Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEA369232
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011368; cv=none; b=ukXw/QA0cwrPBfOZCzBnN16wUbpFWBFcBx8xkfnSCX8Gp1ptnYiNVbLPNf14mgHF9wyzJX8JeBnrkS3XZnTxGakYS4H/wBMqRLMZwwZ50nsy74mdExbZ3Ov0wwxpzrSHHU+cxO4CrMWT/M4QBZcgwwcpPPL4Ee6DPH0ESjFyDcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011368; c=relaxed/simple;
	bh=PaTkkbTLymilZT5IHeccGXhs5FbYXmRp0kXnIdLl+/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sMUQlK6dpHQnbt3KLExWFr9cLqc9/mbjiOcQtmFGAWR+9Chg7uKx4sEkUhXmdhqQCsv+GGh1EVp1Jxn5rqFVDGVgjCP0qG+eB0lE45HpX0ER1f5v54svE4tgjMUW6DLEF1XVimcUseQ9U4coiOXzg6eMGsd5QTZZl86STX3CbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxoGDr0G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T385IbnU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxoGDr0G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T385IbnU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LDVK7Q3867435
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 16:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aMdXQSvss6tWFyMGcNBPhn
	c7uNK1YRXhNFqpjDjbWyo=; b=DxoGDr0GkOfW2gIbT31Uz4ZqrMqx2/E5LGQbyM
	RumwKOKl8XAi3mebUuhlcrDRXWDNZOS4zg86xfbrczh10X16bAi/DeYJxnvPDjTW
	2NEVeNvgp61UWDbaeY5pBfWpEcMb09Nj0xY7W2COoLuJ3fQyGmRA5geanm5BOGsH
	6QqzjpJC4Um8ZTypX72LqL4oJF+3g3IVeFeSHPgNL9GmT7BlrJAo30PWvR1B9r4U
	20YaugDfvhM8DN1FW9NT7noOwpZ7a1eJI7P5VlD+Xt0qHKMYSQR3zJyFCjg37yVR
	gNs/kwNV72K01edCnY1p3sFuZycL1olbFIM6Py/J2KqoxJow==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btyrpgjpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 16:02:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c38781efcso21236a91.2
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769011365; x=1769616165; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMdXQSvss6tWFyMGcNBPhnc7uNK1YRXhNFqpjDjbWyo=;
        b=T385IbnUceXp5UvWSMTO/mEVFQsnmgtJZjlZdf350QaBY0JQIXg2J91b6d3gmMVGRN
         i8wLbX57LSIYrfn4zM+fpcoZo8XkULACqCcoqhfUFSafK4llVC/yM3vzwYHQJWX2xwF2
         ijry6HBGoSGD/Sg5W+6m/zSR2pAuNV/+EN3ud/hYKjl+3xbtk6Jdb/PO9MSW0bPidulg
         aubpqDjgLwFoEyLMmoZNXPQzelV7Ycgq5m0sFvGMmb0Mv1isDugl92F6REips222iU3Q
         0v5H7YdGTYLV2y+/ZeO56yCtTiQjzEsJRw1C/HsAdao5HC7HR4Th22RWRNqUnJQ6loV2
         fjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011365; x=1769616165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMdXQSvss6tWFyMGcNBPhnc7uNK1YRXhNFqpjDjbWyo=;
        b=qmuGrer4PSa1YT11qdNp/va9VIMB4V3OOBqmuf66+V12IqZhr0AqIMWRs7ZhK19gvO
         gMjwYVylW1gDsb1GYifp0eG3vCqZdZ4AK+KXOSLwseFG7c6+CszKRxwlIYAQ9qbg2Y5m
         QSuKye2Pjjuq4iyVnJmSvw1Xt+NJfS16cbfDxGjc6BVjJzEiL3C5fdKT2dgBhDgYjPwk
         Wy9hCTUcXQ3XbUP57lrlWz6+KcVUV3dVYO6Lg3EGJBuo4zXYnvmI9GG6jsGlLJGB4ut1
         fYhDKJeeB2WMSrJ0yJMWQRXyxRlobfOqd2kL7s84T1yUMvD3J+WPt47NeW2x4KMFkdMd
         S+5g==
X-Forwarded-Encrypted: i=1; AJvYcCVQKISt9b9D0CqkGV+CamQwDm96paLilKkSkg6ijO2biZQfDYfVptuS6ZmVMUAIl6FyuZuXOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvywU1qs9AWF7ROhSq9Hh4bKiBKAnBwTfgZ3aQZ23Fdx6QMtRh
	wk/n+PDbYQVgJNoglhPe/MHvPfBc/MHwKwSqn8RKiGxwS0tmiQexUc6MRrADqikrkeD4gYMy/dq
	IGCciO99dm8jivPnfZav79jd0a/DiCTDyWWkq9aHcAA20ZNfE2+zgfecX9g==
X-Gm-Gg: AZuq6aLQM3Tcf5A4PIuO5XvuEfWWlpFbft4IX5He063Ho+aDZwETIw4PUYD2S/7M/BP
	MLrOk8yjlPJZmLKGq3YImDNFLPo9UUD4PiX6Pm7+GdCIsUtgnpcPib3eYDmRMHruhDSvfdiXEgU
	eIch8AGFb2FSNi5PNZRbfgeoNCNow7m3Kh1g8thb93Njvwi8Sq0wez/OX1Zf4YbN3c3MSpYbPEJ
	3+5hQBVWHf9QmbFyM9/FRAEgtyUqjH46FmxFODFm9Lq9xLlLOpNKQAbY5LoCDzOc+Ps4tia0Qt4
	KHUHLpzX5r/kS8to/aHIqBl/+T3A/PPzPDxl7U0Sj+CFC6RuPS1UJIkiGAGbWkbSBRiqxLfRw36
	pJhkcGVflfeEZXrbzRUIFTndq4LVl2+HE0w==
X-Received: by 2002:a17:90b:50cb:b0:352:d59a:b28 with SMTP id 98e67ed59e1d1-352d59a0c07mr3968700a91.19.1769011364552;
        Wed, 21 Jan 2026 08:02:44 -0800 (PST)
X-Received: by 2002:a17:90b:50cb:b0:352:d59a:b28 with SMTP id 98e67ed59e1d1-352d59a0c07mr3968652a91.19.1769011363854;
        Wed, 21 Jan 2026 08:02:43 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353032f5e46sm1123495a91.7.2026.01.21.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:02:43 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 21:31:57 +0530
Subject: [PATCH v5] drm/msm/a8xx: Add UBWC v6 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-kaana-gpu-support-v5-1-984848af12e4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHT4cGkC/3XQzY6DIBQF4FcxrIeWH63aVd9jMguES0tmEAtq2
 jS+e281mXRBF5AcyP044UESRAeJHIsHiTC75EKPofoqiL6o/gzUGcxEMFGxVrT0V6le0fMw0TQ
 NQ4gj5dwIrhuruNEE54YI1t1W8/tnyxGuE9Ljdkg6lYDq4L0bj0UEH/Bib6KnPvk9LtrDbSSv2
 YtLY4j3td7M1+GtiWSZJjOnjNaykqxjNWNgTiGl3XVSf6/Hdrit6Cz+Ic55FhIIdWB5o7SpoC0
 /QPIdKnOQRKgVkjFdA/6R/QCV71CTg0qEmgNA10ArbXfIQMuyPAHCiVk30AEAAA==
X-Change-ID: 20250929-kaana-gpu-support-11d21c8fa1dc
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769011355; l=1710;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=PaTkkbTLymilZT5IHeccGXhs5FbYXmRp0kXnIdLl+/0=;
 b=rXu9YJKS9ujSb5yaEUR2l2aYorjvlsWV7pynHqrZWZahhpAS72Vx7fVtv4Qe6+d7fBolYwErJ
 VKSvfw4oiHkCxTeAcGIyxWG23AW5Gb6Kk9n8pIY61s6/gq+UvyO+cuO
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: V-8AQX182Os_YYktUC4DDQ4_stYLsBCh
X-Proofpoint-GUID: V-8AQX182Os_YYktUC4DDQ4_stYLsBCh
X-Authority-Analysis: v=2.4 cv=KpdAGGWN c=1 sm=1 tr=0 ts=6970f8a5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dVXzBuOjJOJ3YG4SI_cA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEzNSBTYWx0ZWRfX3skQs6d1XTJU
 YFS3thYH0eeLXC8007SEXN6VQG0Q4241hCbbG9wtkO9ZuRR+6ridiyVLSwK0Hd2s3TUsDXDYRNf
 NTRndtuzp009B2PVUlGyOBVKhKQLpRkRjfwFVXHdi60r9xhjo6/6C4U95EqjHleMNfyqJaH/KVP
 YzSM7ULR7QI38Mox4yoCIFfsxihDZNS1HQXJWWBq0fey4pA3NohxyvYMnfJNBIkkllICKA6L0ss
 HMU6olnbls6o6cTEINg5/GUXKVyMebCsHKO/6Qv20Qpv6tiRikmgmvsQydF8TNQIogvLr3oD7am
 YpUkAMUwbENuA2ANgywmcqYjeAU7d+SQPxnXiP8M9rWxAgZWfxn8+k1fIxQ8AmTCv3ctvXxIU4k
 g6urSvBjAclCNSJF3eLo9I+ItDAT9qfvUNbaEHEkaxgUNkW2aiO6IIxUvsXtPnSOd2XWHll3drF
 YTpd8L1rYwv8KcFRD1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210135

Adreno 840 GPU supports UBWC v6. Add support for this.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
<< Trimmed the cover letter since b4 folds it into the single patch >>

This series adds the A8xx HWL along with Adreno 840 GPU support to the
drm-msm driver. A8x is the next generation in the Adreno family,
featuring a significant hardware design change. A major update to the
design is the introduction of 'Slice' architecture. Slices are sort of
mini-GPUs within the GPU which are more independent in processing Graphics
and compute workloads. Also, in addition to the BV and BR pipe we saw in
A7x, CP has more concurrency with additional pipes.

The single pending patch in this series in now ready to pick up into
the msm-next.
---
Changes in v5:
- Dropped merged patches
- Rebased on top of msm-next tip
- Link to v4: https://lore.kernel.org/r/20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com
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

---
base-commit: f185076da44c774241a16a82a7773ece3c1c607b
change-id: 20250929-kaana-gpu-support-11d21c8fa1dc

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

