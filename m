Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF63328B50
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076587; cv=none; b=f/qQK9KxhsoCHqIpPkR0Gj5RIim85cBYHN17rGmbo61FCmtsAR5IBoyhyfDZVwiDldDaKJM7KXIvc9WiYG9BvO8cqU/gJ/9vxm2hkuacIJjYytEqbrN9XehXrKgTaOfiDTsuQfS6x56xHrOxAk+hIDFH6gITSheNT0GhTdepTI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076587; c=relaxed/simple;
	bh=J+VkJjrkoaNRlDaKnTG93cqZ7QXfLD1gOTCZPhZm8Z4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n5RL1NQTTc1Yl2aDQOm6HHcuS6936pEc9Zy3L1P5dcQJmdfofuFjhblKYkLIrDATk4BJNuynN7v+QUH4V1diZhU8hLwP5SuPiPp+vkpN3x/dMy5uOc4TRqbx5qh9xqKoTH3Wor7nimMu6HNzVKV0DHnhnJ6a2KW5xdI2NaYA3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HZtJVv3J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z2mKo1XV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZtJVv3J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z2mKo1XV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMaoGJ1629664
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SyFk5zcqS7Ph8XKnWlZh2u
	bVnnsYVplPvWIOQ6aWBiU=; b=HZtJVv3Jh1HkaZRkLJlJberqZysyyYId0dCyI8
	rAlx1V3ZNjax9rPJO4yOImknFW86sBWiQMNT6Q0XiKiwtgHutZKzxkiNeWnjFkrE
	wAB0AOBl4eB712bD0nL2bsBFmLr9SQE3f1R1ekxK/nh5BqwFRzIyVeToHgfn4Um6
	8RPf5V1PcrlWiJrAM8ehSsly5gFIZe8Ej/laEL+VGNozs9/VG0zdxqj35lPlzAov
	6lI5alCvJK9i5ClfVZRNGLQKtjso+4/iobMiFYMiiSKIcajtD6oaShrwOK6UkMD7
	hf8RZDIB/AlXcegl19UON30vLIp157rQql+irVbUlDUsSprQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9d83uu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 23:29:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2956f09f382so12593405ad.1
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763076584; x=1763681384; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SyFk5zcqS7Ph8XKnWlZh2ubVnnsYVplPvWIOQ6aWBiU=;
        b=Z2mKo1XVq6TbE4mr7uIi/tuIL/9uiLiaVWHQ5KOUXdEj6yY17R2HykMHvXVAMrL1R0
         XJT7WlILTcuhuT7ySVONLoJTM+V5eIRqbJZNsdQwgsYh8HI53+kGPSzL4gBe8tz1fsE3
         hVOTL8wKBQXv+w7lR7fgjxLomHOLkYVVY8QMJA4acWIusd25zZuw5xenxl1/cyeiBaOH
         PmeQcOLsWbA2KU741D6EJotPNMhSrCIhJ70k8Gma12quNeEyeiQPOhEiBeawy4YA0ptu
         5JWeuz3YKvgQyUvj9BUYMnUb9hPd0hb6W/QdrnoWHSkN8ByxlR4lSWJaTrMV2HpLgteT
         WOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076584; x=1763681384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyFk5zcqS7Ph8XKnWlZh2ubVnnsYVplPvWIOQ6aWBiU=;
        b=tFVvJwkT4wO+Oaz7adlF2VYBm+1RC4g6wrGGz6IV5ZL/cqwrbELqyjXXmUmUKiYDGB
         1/4co+2srhXuc83ExgXy7WLgXl5FzMH9VjK5kphYNQmZLQ39285yHUCSEBJhsYeUql0+
         2BIdnrnyHFAg/6KXj4j9M0ePvd1Ey5AZ7aE4ArzpMzyDHx46PIyS020DLY4ATRmxCOXs
         lkdbIb5fpJSTo3wdOH/iGJzUSxMg5+QlGeD3lyJMIwsbcdq9J7S8cvPjKKocIOetz/hr
         jX1w1szOnvTP/1PLEEoJ0+dt0z2k4qq84CUXth2Ek8vogZvxgefkWheejz5swqfxlYxH
         C1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW6ZoXNEd1RA7g17+Qwp3Ahf2Hqh8LhRfMqF2DQvZAVkK5E0gmCQvMivhVSxuY4EFflezNbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOi6qnnbc8vTMjOSldwU3BUuGj4zXD8WYoQBX/GE/VvMVs1fRN
	LwLrHcYf5LzjOiCA2UaIBCYH+bocdEkP1S+3HrFMwirUPaKn64GtF9dssDDeYlMHlcTVOoYoFvh
	LIMYG3X2QQLoN9104vakAxwv2tFcjj+OIYIQWKGQUkN0vx8Hh0Vblxvdy5Q==
X-Gm-Gg: ASbGncvSCSlPQFGLUfnpZx+Z9///7eQHClcv9Po+fRLrm0b76bDrxkjttzUi+5oVloN
	Doyz87uWuGv9sOUNwrIuCDwX3xNs9BFKtvij4V/yuUB+R/XI/tECEXJSz0R4cEUAM4fvLsxPblG
	DS5bvYJhDnl9isZ/4pjWKjU0Y9rop/JAIW7wkRa8wxsXxRrWwb7fssE0ctWb9PEx+iSqji0XvCj
	6oXsrE0PTkaHoXGxGI9eKfchEfHok5lvz9L+lWkI6dIsCCSm08O7VWW5+9qJhTOoHLAO8u1x5Yo
	iEI3wiOLgMUe02MPKazLSHbmzYv4lkN8cK1CO3wZiaOProd0EmxnF/yQ+aDUNyxHbbjF8HNatOq
	LeJpy9kjTxG0AWusLegfie9s=
X-Received: by 2002:a17:903:11c7:b0:281:fd60:807d with SMTP id d9443c01a7336-29867ec97d1mr13571565ad.2.1763076583727;
        Thu, 13 Nov 2025 15:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0JoKSqTMESiDKuWUM4M75A1GvjOSZKSKBeYjatr/BGas5j9pizj/bo7phZeFbq/ZDKNvORg==
X-Received: by 2002:a17:903:11c7:b0:281:fd60:807d with SMTP id d9443c01a7336-29867ec97d1mr13571265ad.2.1763076583020;
        Thu, 13 Nov 2025 15:29:43 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm3049486a12.11.2025.11.13.15.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:29:41 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v3 00/20] drm/msm/adreno: Introduce Adreno 8xx family
 support
Date: Fri, 14 Nov 2025 04:58:57 +0530
Message-Id: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALlpFmkC/23OQQ6CMBAF0KuQrh0yUySKK+9hXJR20Eal2BaiI
 dzdAokrNk3+JP/9jiKwtxzEKRuF58EG69oUil0m9F21NwZrUhYSZYmVrOChVKvg1vUQ+q5zPgK
 RkaSPjSKjRep1nhv7WczLdc2e332i43oUtQoM2r1eNp6ylj8RZp6IUMyFuw3R+e/yp4GWxjpf4
 Mb8QIBwKMoCazwgsjm7EPJ3r57zQp6eBR3kH5qHtiCZoJobOiptSq72G9A0TT/Bv30cMwEAAA=
 =
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
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <rob.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763076573; l=7615;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=J+VkJjrkoaNRlDaKnTG93cqZ7QXfLD1gOTCZPhZm8Z4=;
 b=8p7XjN3Y1LQcpmECcDL5FAlQrwIXhy+O+Jxm62gGRbKGs6Mgoe2vlW3Mos1mEnGrJBx0avjHI
 PotaQrfxNXSAUUHFflb3gEMXobClbU70XJydWwa0baHKjJF+/oYLlR4
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 6DJsGLt7JedpCKN9Ys0fVF0RtKx0QON4
X-Authority-Analysis: v=2.4 cv=Rdidyltv c=1 sm=1 tr=0 ts=691669e8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=qC_FGOx9AAAA:8 a=VwQbUJbxAAAA:8
 a=XQ7dgq76HTNx6dD4gTwA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: 6DJsGLt7JedpCKN9Ys0fVF0RtKx0QON4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE4NSBTYWx0ZWRfX5Y302AiCC30J
 16N+cYC6Lw/3PUAg8R4rl3Az46w5e6zznrWfoDk9DyKzHL/KrJAWQYXkjoMZJpTp7N9xZthjQpi
 YGW3PT7s4PAaxZGptCn49ErDVPE4s+A2InTpbbB8NtqqMJYHqe4ZlH8eQa/4moz5e/8qxTG2ahl
 gjgP+gerH3ckfOaeJSaxme9h9/cc7Kn2CtuFHq3fZztNopahUSNugG/CkqoXzefeoO29dpjKmuO
 k8nCIh5xSBo0twcCu9fIMZqBiQQyS92R6R7TTOIhX5Gww6umVzbEBQtbA325R4hNIGmNHlQLrEF
 xEgs8NMEBw1QDv2urz/90UNtPxnXGIJChTHKCqEz+2Im8lkCx4cKVvkotvRBlNufSb2ewZXHCnj
 PItPjgg7vagqUqJFgUNxatoqe2H0NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130185

This series adds the A8xx HWL along with Adreno 840 GPU support to the
drm-msm driver. A8x is the next generation in the Adreno family,
featuring a significant hardware design change. A major update to the
design is the introduction of 'Slice' architecture. Slices are sort of
mini-GPUs within the GPU which are more independent in processing Graphics
and compute workloads. Also, in addition to the BV and BR pipe we saw in
A7x, CP has more concurrency with additional pipes.

From KMD-HW SWI perspective, there is significant register shuffling in
some of the blocks. For slice or aperture related registers which are
virtualized now, KMD/crashdumper has to configure an aperture register
to access them. On the GMU front, there are some shuffling in register
offsets, but it is manageable as of now. There is a new HFI message to
transfer data tables and new power related features to support higher
peak currents and thermal mitigations.

Adreno 840 GPU is the second generation architecture in the A8x family
present in Kaanapali (a.k.a Snapdragon 8 Elite Gen 5) chipset [1]. It
has a maximum of 3 slices with 2 SPs per slice. Along with the 3-slice
configuration, there is also another 2-slice SKU (Partial Slice SKU).
A840 GPU has a bigger 18MB of GMEM which can be utilized for graphics
and compute workload. It also features improved Concurrent binning
support, UBWC v6 etc.

Adreno X2-85 GPU present in Glymur chipset is very similar to A840
architecturally. So adding initial support for it requires just an
additional entry in the catalog with the necessary register lists.

This series adds only the driver side support along with a few dt bindings
updates. Devicetree patches will be sent separately, but those who
are interested can take look at it from the Qualcomm's public tree [2].
Features like coredump, gmu power features, ifpc, preemption etc will be
added in a future series.

Initial few patches are for improving code sharing between a6xx/a7xx and
a8x routines. Then there is a patch to rebase GMU register offsets from
GPU's base. Rest of the patches add A8x HWL and Adreno 840/X2-85 GPU
support.

Mesa support for A8x/A840 GPU is WIP and will be posted in the near
future.

[1] https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-8-elite-gen-5
[2] https://git.codelinaro.org/clo/linux-kernel/kernel-qcom/-/commit/5fb72c27909d56660db6afe8e3e08a09bd83a284

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v3:
- Squash gpu smmu bindings patches for Kaana and Glymur (Krzysztof)
- Reuse a6xx_flush() and drop the patch that added submit_flush callback
- Fix GBIF configs for a640 and a650 family (Konrad)
- Add partial SKU detection support
- Correct Chipids in the catalog
- Add a new patch to drop SCRATCH reg dumps (Rob)
- Read slice info right after CX gdsc is up
- Don't drop raytracing support if preemption is unsupported
- Drop the unused A840 pwrup list (Konrad)
- Updates to A840 nonctxt list (Rob)
- Capture trailers
- Link to v2: https://lore.kernel.org/r/20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com

Changes in v2:
- Rebase on top of next-20251110 tag
- Include support for Glymur chipset
- Drop the ubwc_config driver patch as it is picked up
- Sync the latest a6xx register definitions from Rob's tree
- New patch to do LRZ flush to fix pagefaults
- Reuse a7xx_cx_mem_init(). Dropped related patch (Connor)
- Few changes around cp protect configuration to align it with downstream
- Fix the incorrect register usage at few places
- Updates to non-ctxt register list
- Serialize aperture updates (Rob)
- More helpful cp error irq logging
- Split A8x GMU support patch (Dmitry)
- Use devm_platform_get_and_ioremap_resource in GMU init (Konrad)
- Link to v1: https://lore.kernel.org/r/20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com

---
Akhil P Oommen (20):
      drm/msm/a6xx: Flush LRZ cache before PT switch
      drm/msm/a6xx: Fix the gemnoc workaround
      drm/msm/a6xx: Skip dumping SCRATCH registers
      drm/msm/adreno: Common-ize PIPE definitions
      drm/msm/adreno: Move adreno_gpu_func to catalogue
      drm/msm/adreno: Move gbif_halt() to adreno_gpu_func
      drm/msm/adreno: Add MMU fault handler to adreno_gpu_func
      drm/msm/a6xx: Sync latest register definitions
      drm/msm/a6xx: Rebase GMU register offsets
      drm/msm/a8xx: Add support for A8x GMU
      drm/msm/a6xx: Improve MX rail fallback in RPMH vote init
      drm/msm/a6xx: Share dependency vote table with GMU
      drm/msm/adreno: Introduce A8x GPU Support
      drm/msm/adreno: Support AQE engine
      drm/msm/a8xx: Add support for Adreno 840 GPU
      drm/msm/adreno: Do CX GBIF config before GMU start
      drm/msm/a8xx: Add support for Adreno X2-85 GPU
      dt-bindings: arm-smmu: Add Kaanapali and Glymur GPU SMMU
      dt-bindings: display/msm/gmu: Add Adreno 840 GMU
      dt-bindings: display/msm/gmu: Add Adreno X2-85 GMU

 .../devicetree/bindings/display/msm/gmu.yaml       |   60 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |    2 +
 drivers/gpu/drm/msm/Makefile                       |    2 +
 drivers/gpu/drm/msm/adreno/a2xx_catalog.c          |    7 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   50 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.h              |    2 +
 drivers/gpu/drm/msm/adreno/a3xx_catalog.c          |   13 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   52 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.h              |    2 +
 drivers/gpu/drm/msm/adreno/a4xx_catalog.c          |    7 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |   54 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.h              |    2 +
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c          |   17 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   61 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |    1 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  369 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  287 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   25 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  393 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   31 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   18 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |   53 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   17 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              | 1205 ++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_device.c         |    4 +-
 .../gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h  |  420 ++---
 .../gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h  |  332 ++--
 .../gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h  |  470 ++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   38 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      | 1954 +++++++++++++++-----
 .../gpu/drm/msm/registers/adreno/a6xx_enums.xml    |    2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml  |  283 +--
 .../gpu/drm/msm/registers/adreno/a7xx_enums.xml    |    7 -
 .../drm/msm/registers/adreno/a8xx_descriptors.xml  |  120 ++
 .../gpu/drm/msm/registers/adreno/a8xx_enums.xml    |  289 +++
 .../gpu/drm/msm/registers/adreno/adreno_common.xml |   12 +
 36 files changed, 5008 insertions(+), 1653 deletions(-)
---
base-commit: edf57d8dafc63f9298a209e518ea6a2e0df78ed0
change-id: 20250929-kaana-gpu-support-11d21c8fa1dc

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

