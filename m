Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D33A1693
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784320912; cv=none; b=o1D/SABCaZIA04Rxjom5oKHIg5WFmY8nAsf4HmVipIl4AfLo8y+m3o+9XW5EE8i/yA8PiRIA1YRVLQyFLKnHnvDIqJSjX6DhpuJodvc+SHDBVaCVDJqgyAi9TPeO2El6/5Jt0cYeaBUcqA2qGi0as+0kSJ14U5pkRu0cWI53rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784320912; c=relaxed/simple;
	bh=6VEjrqVhr7MezwfVHfIVDsIN0YyS4xKPQEXFGvXAkd4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lnuxbRtvsHPKp+qWPmFS3QsBgilassPuHnTXedy/GCLb38kVrqV6qjmm2LTrfFgiuMTSsEzmunvGscYTAzWcZDfjf9WWXKwBVCrDLOU6UPDNl112yahKnZ9ROoF4QFicRfIvfQSROIWnQNQYyMfBMhXLZkTbPGOUIg/xk78vKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HW0ZOYY2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FgfShZct; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HW0ZOYY2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FgfShZct"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtoKP2990980
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sVH+YK2y1vG4lsBrivCXnD
	TuyI7sx5ytr7WDEkhCxnA=; b=HW0ZOYY2FpGcSHpEnfmuVuVyl9JGzmftZEOCaD
	DsPsngIbXbdhA2BGmz7sYPEGS85X8TT+PrP63hasVtmNBcfIrxQPKe1OweE6cB0y
	UZBkk5VqbXoAgBUN8f3zGdBpQbzwVtlQjeys1cqOQKK6iK82SMb2vtBoSUARukYE
	VZ6uWk/mf6YOPdDbB0Jv4SMQbE19eWNZFdLlGrlSGH/Nkd+eqw5FqyjJOgPo5DIG
	tza7D2JwV9v9GT/hcX2om3TNECdCCoBXVMFRKPOcvMhja9Mzo+blHVySnLrNJX0/
	VUM9EzkUB6lDaCNV7mzpqoLH+CGgXAbepodZX/stvLNr//OA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3aurc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 20:41:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so11024143a91.3
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784320909; x=1784925709; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sVH+YK2y1vG4lsBrivCXnDTuyI7sx5ytr7WDEkhCxnA=;
        b=FgfShZct/wYLzyI8Q6YAcB4iC4V1dkIXEZJ6a9iW+VUfaM/TJ5MQQJyqu2TrIl5/N2
         p8aZ8oyJ/UEHeovm4glmCgNDeKeWhU3CN8ZszOeNIbjapIdBF7K+SdS17t0gRUfCQoE6
         +/2xB5MyfhiFyGk23vM/8tW6dTbju+438ArYQtSJPK2unjc48fQlPwg1lUgc+uxqR7zY
         ztciLSsO9kUtVVX1oK1PtPOXqqV2OyNbOwVKaXadMowcPsdyicbzY8djPTnqEEPwjl5M
         793iW1A/I9NK6G0T7ZddMfWe+MIiOxLdrm/yIP2Numt+shc/0kx4mxmIBeeGI5fh8/Pb
         HS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784320909; x=1784925709;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sVH+YK2y1vG4lsBrivCXnDTuyI7sx5ytr7WDEkhCxnA=;
        b=d7MDoSTDtoKWo3H0XnEoZZt7B3EgyT+K6cRkELKqwtqYfC1pUR8RduueYlg2nYIZrD
         PqkqszikeNUkpAyA4P9RhaTqX+OGUPBaI61cswtfFJfzY1Pmcp6I5+WfXmbIqSduRTw+
         t3h1mNC9FNZRsLjvm2w2tQJllo0owXQwVAedaVqI8YbTgHkYdGykMOFfWpPdRmPT3WVi
         TBGTjSJrhP7r3HsyyZJnA8nLrZXuy8UTtqifYUVNGJpL/AgirMtdzZ+j5NnvhxibFlW/
         oYwS6GLggQzqShICAIwI51jUT83UR1BcLHkKiQdBAAG2fIeGzQOPPBfumwu29BxKokQS
         2Kww==
X-Forwarded-Encrypted: i=1; AHgh+RpqqwzRSFTvvOqbIRYyAlT4m4ywYU3MFezlE8DKlqtFdPPI269Kwz+zd9QgvoPaiDcgMndn2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYZPS/BGD341CoP5mQp2Q9CXnnLj01sM4nzwYHfAprRTlfCmF7
	Rx9a8bMgADeKNriNKLonWESIJd6Np44d1ZZtil3Yq6own4G16QiH2sZhFf2wtbJiABJIDqk8QNk
	S7bgAQWiKrfVFkSvdV/9hQRaVURQJxa1vOFI86Ps9Fz3eVMsS/F7pf7wTUQ==
X-Gm-Gg: AfdE7cnZjYABgW1hQtx3J1Dx/MA51FXWS0NluMW4jWS+FUlRikVxazP9ycjfrUwD8nw
	m/ABCtHZT5OtIOymzAcgIO5LBmOVaPEKP8/jSbar8kAAhmFozSEQAsNCPmnXuIXcumvzYM2zDPA
	HZEDzto9wmS0JBKoi7ayUoBStF7EM6b7aBTxLRBQEeusncfZKLzjC1LIFS+U27bgf/i7VC9AVyu
	pH2XBD1yzikL60ixruGIsUPWccRA1N0mCRkmU9mxiBsEsaFui7lyEC6DkH6GzY8NIgtZVcev5Ph
	CPyYPtGGsw8ipAmWXsYLBftMQTofb53TU2pyGulZhUNuQSJPz9qfBKzuAKdnUoRIx+TCEVAdWHr
	YzB6OPeL83XiZAbbqiGq8d7wT
X-Received: by 2002:a17:90b:1dca:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-38e4b454d1cmr4623517a91.10.1784320909233;
        Fri, 17 Jul 2026 13:41:49 -0700 (PDT)
X-Received: by 2002:a17:90b:1dca:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-38e4b454d1cmr4623483a91.10.1784320908803;
        Fri, 17 Jul 2026 13:41:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:41:48 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/9] drm/msm: Support for Eliza GPU
Date: Sat, 18 Jul 2026 02:11:25 +0530
Message-Id: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHWTWmoC/2WP22rDMAyGXyXoei62m6Q4jLH3GCU4itIa6qS1k
 tADefc5bi4GAyH4dfh+6QVMwRFDlb0g0OzYDX0U+iMDPNv+RMK1UYOWupQHmQu6uKcVp+skCLF
 TJi+x2SPE+Wugzt0T6+f41oFuU0SO7yI0lkng4L0bq6yn+yg2rF73PTHbZFhln6lRSiOazbL2v
 kas51LEkEId2k4aKkwu8Xtg3t0me1nRu5i+YPU/Ox6H8EivzSodsNkVf76YVaSh6dS+yNum1eY
 fDY7LsvwCx3XanCkBAAA=
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=3090;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=6VEjrqVhr7MezwfVHfIVDsIN0YyS4xKPQEXFGvXAkd4=;
 b=SNwxy/SDmWuwEjIaqCpTdLVsE7jZE/sH0Uta1x17D2avioGP0wvW5JmMtKbo/r0IwoMsTchaW
 sdJOBpo6jhuBxTd0mN2Iwym1w7M71JU8qdNIuLFrokRXTF7MmACLhLE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX06CagYMTZSsI
 am2Lw61n/TZqNL1hA0dxakL3z7gdRW/fuZtR7JUYDGT0+wU4Tr03hNWc0YJlneI6f5zo4rp6Nqu
 66wwpop3osg2+dcE4UnsE/uWqeUr2dI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX7nUOXtfijo4R
 mU2Gbyz9FM/F0KfIehFB0o4UsZY9WJVYXn7Dblt6r9bz1Mx9T5c/S8RaTyZwRpqee0HTt6Jw3jN
 wUXMT/TOfZcunWts07y22B4x3GA5nRCWezrCRLTPsVXjm+hlmUGE1aSJQE/zJnIPD6H/caJjlaQ
 FWmElonJL7KtJcM8IE9vfZ/YR1zUIjoTlElF+DmixzSjYkgKWnhrtvP5gDEHRy37coTher5FrAT
 lr8rAY+zExYX8Aze/+z3GbuUcNxvA+ETJMzYA95E2Vdjizcbg5BXh4ehKUx3Hrp254eFcQTbvLK
 v0VRnk7uetzygVu4IlpNahqHWZM//nAwpxV3KzjlZ3ememcoWf8UFAiZxkw5jABUX0qdHEsydiR
 TMdxrSuGfwHqCK/QcgY1bSyC850RPKF62ksXAWHwUT0i3eDKFxVN0J5hAYMFyloaSa6LoUugyFj
 e13fnm4XPCiDEsG31sw==
X-Proofpoint-GUID: pbNuGbiOWZ1KL0q0zrIm4tmkayEsPtxP
X-Proofpoint-ORIG-GUID: pbNuGbiOWZ1KL0q0zrIm4tmkayEsPtxP
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a938d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VR85YU2tW1KY0NdMjCQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170212

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
Changes in v2:
- Add a new patch for GPU passive cooling
- Rename firmwares to gen717*
- Capture trailers
- Link to v1: https://lore.kernel.org/r/20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com

---
Abel Vesa (1):
      arm64: dts: qcom: eliza: Add GPU SMMU node

Akhil P Oommen (2):
      drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX- variant register
      dt-bindings: arm-smmu: Document GPU SMMU for Eliza SoC

Gaurav Kohli (1):
      arm64: dts: qcom: eliza: Add GPU cooling

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
 arch/arm64/boot/dts/qcom/eliza.dtsi                | 209 +++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  38 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  17 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  81 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   5 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   2 +-
 .../gpu/drm/msm/adreno/adreno_gen7_17_0_snapshot.h | 428 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   2 +-
 14 files changed, 773 insertions(+), 30 deletions(-)
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

