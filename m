Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9619369206
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239279; cv=none; b=GtcPO9Opf0IJnOoaLx+Iy/Trer4p8VozD0KqZmSrFzaVAefdUlO3NdIY4cLhuPVSBCNpAy2axXUHyjjXIVpzaUu0hN8dVZpssOdfAYvNi60oihIatsK7Yi0UVNn08fEN2bbCbI+pOhRlTflt00YUbbrpIvR/bFdlvE4yvLY9D+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239279; c=relaxed/simple;
	bh=ze1VllbOqZnKEAM3Tp176IzqqLnZ/N83LBmJnq4dOkM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SyQGNGXK2RM3DqRY9kda8RzT3K+lSkWAb2TP+cTLASMRLKesb02xFfTPTAxOsiS5Fiiv9wkyhJMCuEJnPlSP2QB3Qy0sf/kjx9knrlikzXy5qY61NV4zr9g0cKfzVI3IGC7ISK31lum1ODWJYRqio6QV97IUQWii96T4AV/1was=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KsFB6ywt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iyg/dnEC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KsFB6ywt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iyg/dnEC"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6653lnnX651862
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Mmu9NS1f13WBdz/LPDqPCJ
	b63FFDMcYOR5yWaGxSv4I=; b=KsFB6ywt4epudRYYTWTMSQw8+mpUkjXrF+Lfvw
	QpVQMQhh7zKPQ+GD7fcYQF4MdsQGJwDBrZx0zZ96jaj/PvF2/hQov+NVHrybgudb
	th7LHRztP7xVnZ56IiCLaDuXkYDjDAUK9Afij97RvN+E2MF49DV2ENABIUHX7JBl
	tgK3JBHvr7RAc36R+Cs20MQH1ZV8MdvoRabm0JPmnBP+6Wc4xjnlaTf/oXJ5TD8f
	0wxIw6Jbgr7in4Mm7QWFdry8lwhmC9bI2iUlUEwFhFFStbtPP57hSrAUwa2pavhm
	UG+yFV0hVUEJCk4wMr/Xa0H7Pp/oC3xRtR5C6+PWlxM6rDsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64jexj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:14:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c9a700dc0eso14544615ad.1
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783239275; x=1783844075; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmu9NS1f13WBdz/LPDqPCJb63FFDMcYOR5yWaGxSv4I=;
        b=Iyg/dnECPIKdwvp+BvjHWxouhB6GpjImdIdfaakbYISHDkNY24jgh92aV2bF8bcd8+
         E8iygKGCSjH/bHV5RaWQ97cb49qRroqyJp25bMyNqiDrKgWOGwqaTCcJZs9N8kZJqJM3
         g2hXJqBM2uxQSLN13r3fLRXAqfpyErSHdFLEncpHdlJQhzdCt0GHbWgvs7GDrgU3fc3k
         9rMYo0lHOmLaem1irnLE7muymCLJbOpnFhhoXnEfGJ0fJfAfVetWoduKwt8i9poNUcKa
         eOeWymZCbyqTJNvZTI+DzirvaW26/EtsxMQzzvMKOKmk4S7d8JZ0teAZx5bZb3vIrUU1
         YDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239275; x=1783844075;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mmu9NS1f13WBdz/LPDqPCJb63FFDMcYOR5yWaGxSv4I=;
        b=AoYwqeTne7tZ+gQGmqY/w/gDfFv65GAJWKFVb5QTn//Nvi6ejHSBLscdKwGBlN5kVe
         9F8hXtKwNFvZWCaLtMvBp2DgMzG1MrD8hQFmLs6XtEI4FWUgvQXsDJXLnMB+B8fTyc5X
         vfzeJ/4Vk/dWaQ7U5PIp05jO7fXjgUROKNYLBP1/ay3LOcAdGFwUhFeMmvTtUNs+BE8I
         rxbsKLsSJAJlwqd/lekUurOfplNbmILHDzcwqc15LVimMHq0K60JVN8H/zLe7ysZeVym
         uW+J8eN0DVKZA6AsqJR9Rurm2h5dK88TpXtCG2/C6vhse9h//MIG1NQg/7Q9XYe8JPKN
         Nd+w==
X-Forwarded-Encrypted: i=1; AHgh+RpSa2ICIEVEIgyfHHnzwUY0qPwLea4AYec2eUb88yLiJJVDYRCT4cjIIKChJglk95v4lcn63w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt8Nya2b4ctsEP8nHvvXLMhMGDdZxxl1e9RjAp5EbXQhmkXYDJ
	vcWnnD5lLjqgomaEAp9B/ZTDDwNPSTLPyMc9p1Nn5fPKrkEId0FuBhf2wsl1ybcI1ijqyrggWRQ
	UpfA0ZUkDtSHSXoULKhZdOHsRfts/3AIOPFOaZDHzux+IvJuh/fNrjM4e4w==
X-Gm-Gg: AfdE7clLy3nM1kZsYyQa8nRXlWpgO5m6OpFGFU0+VIwz9lx2XkCOjhFBy2EsqnTZHGf
	klr5HWjNMptVaqEGS0UQ4BouacG/mpDrc4JsXy1bc/PqJ7bWJYK+xz+nuNkP3jaN8No5Qq2uSLV
	6vSq/sXPnBnkFI3Jn+Wvs1HCFRbC0LUhGKhTFZsSY4hSIjnLiZp9VzEbK23C4mGlGXNpal2Xmv0
	btaKRxUtfmCMvhphcSV6tab/WBvcO+TMZKZGs33eeKagXc+YJzA5dNs9uqSUm7yARaZKd/EGBKQ
	9TFVs58PzsAWsrtPF78ynxoPbpzXGf6BrOhvnEN2//aFIYTIFRl912+kxWi5BR851Q5lLBbFcKI
	tsZsUDcnYzIgcdcLYjH9Q8JnCHO2IsS/tVr4=
X-Received: by 2002:a17:903:2cd:b0:2c9:97a7:b1eb with SMTP id d9443c01a7336-2cbb9eeb474mr55795695ad.42.1783239275121;
        Sun, 05 Jul 2026 01:14:35 -0700 (PDT)
X-Received: by 2002:a17:903:2cd:b0:2c9:97a7:b1eb with SMTP id d9443c01a7336-2cbb9eeb474mr55795445ad.42.1783239274618;
        Sun, 05 Jul 2026 01:14:34 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:14:33 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/8] drm/msm: Support for Eliza GPU
Date: Sun, 05 Jul 2026 13:44:15 +0530
Message-Id: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFgSSmoC/y2NaQqDMBBGryL53ZFobUQppfcoInEcbcC4JCpS8
 e6NCwwDb5b3rcySUWRZ6q3M0Kys6loHwc1j+JVtTaBKxyzkoeAxj4Aa9ZNQ9xMQYhUkkcDijsz
 d94YqtRyuT3ayoWFyyvEcskJaAuy0VmPqtbSMcGnD/V+TtfIITL3nsRA8geKKzLXOEfNZgCsOQ
 VxWPKFHEnF8d9b6wySbXe279mLZtv0BUyuNi9sAAAA=
X-Change-ID: 20260704-eliza-gpu-eccf1946cb3c
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=2808;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ze1VllbOqZnKEAM3Tp176IzqqLnZ/N83LBmJnq4dOkM=;
 b=9a9GOk9tVX4B1OGU6WAqIUkEf1RpZhendeSNrLU98rnIfNAxFU45RsIYy6SGBU1u/wg9t8oic
 STHhe5reKfWAdXRtit78WKmncVmmgtFAsoHhpnTcMDyGfm8Scoe32zi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfXzQpVIObOgKMC
 v9Utu5QbDmarwt1AQWNGRgBXSk5zilDdS8nw1kDMTlQXfsNdAseqd7lkFtBmhWqt96ANjqbs61O
 Y//Kz7ZRHXgDfMvObWapaqiTrulQ/Xkopul2Yv60RZ9zzY7Vneazg8kuogkLJDcVJeUudkfRB+G
 LiA8dB7UyMZAd9SBLw8wVY9wWNFDj7m0OCp2Gm2h0RbkL3HuU84sSHQLwbCbT+r609gQXpTaKeb
 sJGdI4olOuDw8oFTtBTgJqUcG1yQk60n8ajqMRn4AtYECvgLL2elq7WmRVWXvmRm0ACxr0zAcOJ
 stF3/6adanU4F6JQqRM05HFsC3vraDhRd0XSM5LX0nToCVPsdiXF0lAzrpwNOrCsTb7iMLcJyRV
 O2JaN5Dw8nMiXvFwfDJOF94JYsxK8GNqCBS7n/eLvmxQMoWtNe9E+Wy6GPZsip3uJ+lot3RDZe8
 ZvGsvOnhmg36fQ4neTw==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4a126c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=bIsOEyWjDz43KqZfDzYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: F9MQWQohe8Vqb-HnZR_CVv3XcwXbAhjX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX/JDe9KjM5MZI
 oRzBdTT2N33AX/3v6AUGS0ZWiamGWJI/Wyw4+sY2qvvBLsOMfjvu0gsfrufKSMsbXpXv+iqffIP
 Q93yfmjxWbjgiBrgbpoZAAq0K1SekAk=
X-Proofpoint-GUID: F9MQWQohe8Vqb-HnZR_CVv3XcwXbAhjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050082

Adreno 722 found in Eliza chipset belongs to the A7x Gen1 family. It is
derived from A730 and shares the same IP-level configurations: HWCG
registers, protected registers, GBIF CX registers and gmu_cgc_mode.
Major differences include smaller cache/core counts, 1MB GMEM, no
Concurrent Binning & LPAC support. Some of the peripheral blocks like
RSCC are from A740 that resulted in updates to RSC layout.

The first few patches that updates driver and dt binding docs are for
Rob Clark and the remaining devicetree bits are for Bjorn to pick up.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Abel Vesa (1):
      arm64: dts: qcom: eliza: Add GPU SMMU node

Akhil P Oommen (2):
      drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX- variant register
      dt-bindings: arm-smmu: Document GPU SMMU for Eliza SoC

Puranam V G Tejaswi (5):
      drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in a730_hwcg
      drm/msm/a6xx: Add Adreno 722 support
      dt-bindings: display/msm: Document Adreno 722 GPU and GMU
      arm64: dts: qcom: eliza: Add GPU nodes
      arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU

 .../devicetree/bindings/display/msm/gmu.yaml       |   1 +
 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 arch/arm64/boot/dts/qcom/eliza-mtp.dts             |   8 +
 arch/arm64/boot/dts/qcom/eliza.dtsi                | 190 +++++++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  38 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  17 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  81 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   5 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   2 +-
 .../gpu/drm/msm/adreno/adreno_gen7_17_0_snapshot.h | 428 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   2 +-
 14 files changed, 756 insertions(+), 28 deletions(-)
---
base-commit: a9498e40e3e314ade387d3ab0d5cb14f0f3aa1ad
change-id: 20260704-eliza-gpu-eccf1946cb3c
prerequisite-message-id: <20260609-b4-eliza_mm_cc_v6-v6-0-17df09e5940c@oss.qualcomm.com>
prerequisite-patch-id: ecae5e45a33a79ec3f500e3f318e3a0129fddfb7
prerequisite-patch-id: 19fe32e5af810250eef42dab488c982ef70c055c
prerequisite-patch-id: 60dde5421adbc86f355b4899bedd0d7a1a0c4e5e
prerequisite-patch-id: 58c9dbb18795c662ea22c3a82b07d6465f604e08
prerequisite-patch-id: 0c6e220ecf2b42776f990ea5b98ba4ee97d229ee
prerequisite-patch-id: 0e0bed1091d12c102e2542b1c2931f61a543f2b0
prerequisite-patch-id: c0f22b4ff0bb79935848dde50c524f6063011ebb

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

