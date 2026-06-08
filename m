Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC33386C2C
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902128; cv=none; b=EWFRA2dINqtoMR0Z4JosxVDBHQOVOQFIdRsGHouj6SJVP0RAcBRP4BLKysE3+zjrr8bRMYJS/+okRdSJOJDF6Gq2XxdLiC2b6pi+/MEXoEMM+SeOJznOtDPV0mF9t7wL1viSyv/tX1ZzqiSnSlIP61+cFvk7lATgVhPyYHLtuAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902128; c=relaxed/simple;
	bh=f/sCFDjTgatU0BGy4aowz36ZzDRGX9hyPbW8Spw3VEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nRQCROpYs5QuGsyM87Z+VZ/EuvcpIaikL+fyasWKHB6/Y9rghI7jyarRlo056bIjfcTQrQAtw/qqvbR7pBg1GbG2RXVuXZEVhKIZmYztV+8lpvEEm7AD3gFZPHn26FWfmt/Hp22vMO5Qy615R7xc8xM22mx7znMQ8zXfGzrcBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LkjzvS6F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CcPrnxWN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LkjzvS6F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CcPrnxWN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Oe5x2385877
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 07:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4SqlhiCUHy+ItpDoHiIxZ33OiGVmsHhLICsi3glIWBc=; b=LkjzvS6F7bXJ4tOj
	C3sz8nXDmROsAjh5QWk5fvuhZV5SLFkwDQvzt0TCTge6v4ZKqKcUJLhgTbKLu18L
	2K3oLpCpzUVIDkr3ZiHDTWSh0kba4+pgsRlOMWAysVBu4equjwoNOrwDysludr8t
	fEiZKyP+h7wEPWLKLYOOEpqCGqEN+KFlUo7o5+4EtvSVAJWMCO+UH+kwFF73dw3Y
	j8/uYDV6FDzQD+/3FkraiDFTR2j18C02fzoRXrSXpVEmCDuOtGGpPBVVY/GxaqoW
	hYqSlMXaizdn3WewH4Dp3UkNPrryCB2tu/sFrHOPPy+TSy4BNEsX3f3ogRti26Fi
	cTuekA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8x69b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 07:02:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-842688fa7b8so4183244b3a.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780902124; x=1781506924; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SqlhiCUHy+ItpDoHiIxZ33OiGVmsHhLICsi3glIWBc=;
        b=CcPrnxWNzJSHGf7G5acA9fjdiF7jfkxyJH13i0ZAHEI6Mr69QBzYHsfz1pLqyNvbFQ
         bwNOB2yuP//DqhbhIbhnvBecBN1KNTpuBw9vUPPrWX7tpc0HzA//8LkTvgdpoutAxw3+
         i0N+fZ9Iq63uvISdGF7npPrUFMsry1kYqBzBRL+peCRPpQcDLJTkmwOMUH6F7VUl1DLm
         gbsZMboS5G+2wzcyCLe+HL4cimjVCaWaPbOnBm6I9wEyFxjfjKuJbZbpvjR8yFUvgFBI
         Jt2iwRFP/NqE2QNRLGiJekm9duikuuZTWHPtYsOn0q39oUoD8xJ4qPT+uYLY64ClVXJ3
         gaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780902124; x=1781506924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4SqlhiCUHy+ItpDoHiIxZ33OiGVmsHhLICsi3glIWBc=;
        b=QXOky5zHzra+KCmfxtEsmGItecrv/mLO+lDhdK+RamCfnSSaO5+48Pw5ObTDO+T740
         KTMSAH9AODaO58Io92DCo7eB6E8JQcZ9bcLv1TzXE+Ms3vO4eGLUbNQgF0U3LnAGcGpQ
         x83VeVKftIvsuSTzLl0+PbH/jI/bq7EpMT7Yl2q1J+IU+bv1f0l7YpJBN7EMwOuQf0R4
         z47nZ+/mGlP7aMO6bUE67hv4+tJxzEydJfIazKRj56IvWjMynhaESoc/3XJRwWFTPB7x
         VrebdfzYMxhFbKv1ZO4+uJNoGCwYrxGsFMcpjfgS9SGsohepPHYmjLLvv50ekXx114Bb
         GdIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qy5m8VqnJ1c+/iUhFgR9lgXaLAl8LZKLirV9tLm1FeLEkS3RTGny660QGJk1exla9mcDuFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1XPG0WRtgSxJVbwBDLrVW0lsC4GVyPhlkk7a0uJuvLOXw75c9
	EnliYm1idreNSP4tVFAen9sUH7sCBXDutxkUZ/lr9wdIQTDoOM/6zogUoTSbkq//gmqnONSRYC9
	+zV/HCTkIBMTNtp+Hu5QObg1lEJ+NopV7M0fpWbAryvput4Nuoqwgw2Tb+Q==
X-Gm-Gg: Acq92OH2pZVkplqxToHNxuisd958xDD94HxQ+2Dnpgd16m8PnqIjZaPvqmzS0eW0CJH
	QPOWlLcwAOx2sKjSvEHzEwTw9/tDHVkzNN26m0XKpSHAH8UhglKzyCna3nhkYI3zQy+45l3SqYe
	vGVTsPSWBqTHVjhKzCJ7pbURmT9kOhVO9KiolLP0nylZjnUaL2XZwi2bdJq4kxNFef8IOPIyX9Z
	MlDuXsjWDzOPWLRz0T0C5tnvuiU1C6jfNujMNnAKjXk8Zm4i4R7YWSImivYQywjzY7b2uggdji+
	z7ghowsEUfNbYbbAqGrdKMeTcdEPzX9rLkjm4/qEKMk3E1BBUabloGGgqgoMYyJg1aLkePJzBrZ
	Vqg8Qlb8/MhCFHR4Sb74DwP9voOnd7Pt4BDmQg+jUwo+a3lMjMnW1fhJsGWo=
X-Received: by 2002:a05:6a21:6b8c:b0:3b3:3506:cf3f with SMTP id adf61e73a8af0-3b4d39ea8d8mr11958871637.1.1780902124080;
        Mon, 08 Jun 2026 00:02:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b8c:b0:3b3:3506:cf3f with SMTP id adf61e73a8af0-3b4d39ea8d8mr11958792637.1.1780902123334;
        Mon, 08 Jun 2026 00:02:03 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86151154a8sm6267723a12.22.2026.06.08.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:02:02 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:31:42 +0530
Subject: [PATCH v4 1/2] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-display-v4-1-88a846afdd5d@oss.qualcomm.com>
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780902106; l=3783;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=f/sCFDjTgatU0BGy4aowz36ZzDRGX9hyPbW8Spw3VEo=;
 b=3x+ZlUOf+wBvB+AHBU7fiuERNwbEV6hSQI9aySyJjZAyO4j5aINgHa5ClzJ3B/FdpAky6FC31
 e7ARgDXnF/bBbGnNPhCthcBG2EpS3e8W1qCplKY/8LUfa9o4nFpoBd7
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: zpB7610hKeGCKrRoReGhKoXsFidi0uUS
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a2668ec cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=OEkpyX7SRU1z48_sfK4A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX3yOGhkofbo27
 AAowCJL8Um/1NZpJb7vNXwHSq2T2zV4BXDE3tdu88bJDMs2V46Ju+shp0pk4hrwE3gdtqMlIgBD
 wJbi1YDsmTp+plQUfntovw/HpcYwpq6yv0y54G+DEAxAI88ym3tHuLOZnwEr7MTb2yumE39IZ0W
 pB18sQ3gVpdbOlfqNG0to9YLflrjQ6H1LPewVvv8IHb8nUpgFZCqehRSwOnVvfKdoAfz0wscM/2
 AmMJSvUIhF8WE1mSI4ybtmdY50kjJh7h2eK+zjXViaY5ZndnCi4nGF6tWJjUfyuLpjZCa/AYKp8
 UCaShB9TpgkSCntag2ddeXpad+RtyrF1VMbk4exuYSbS0zBCSBrjFWCJ2wmQr7xz4MI/cPcJSjg
 j2DNYBn66szGPRqK+92dkWWjEXZ3lkydMeRyGyzV7oyDC5vn0fjYdY/05N8PzacgBVCWHhM4AGJ
 Bp8id3Hs8/PWgNZEWrQ==
X-Proofpoint-GUID: zpB7610hKeGCKrRoReGhKoXsFidi0uUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
the existing qcm2290 bindings to cover Shikra by adding fallback
compatible chains for MDSS, DPU and DSI controller nodes rather
than introducing a separate binding file.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/msm/dsi-controller-main.yaml     |  4 ++++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml        |  6 +++++-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml       | 19 ++++++++++++-------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index dbc0613e427e..fd0834d09ad6 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -47,6 +47,10 @@ properties:
               - qcom,sm8650-dsi-ctrl
               - qcom,sm8750-dsi-ctrl
           - const: qcom,mdss-dsi-ctrl
+      - items:
+          - const: qcom,shikra-dsi-ctrl
+          - const: qcom,qcm2290-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
       - items:
           - enum:
               - qcom,qcs8300-dsi-ctrl
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index be6cd8adb3b6..034d3df8d247 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -13,7 +13,11 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,qcm2290-dpu
+    oneOf:
+      - const: qcom,qcm2290-dpu
+      - items:
+          - const: qcom,shikra-dpu
+          - const: qcom,qcm2290-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index bb09ecd1a5b4..49a7b5c4c678 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QCM220 Display MDSS
+title: Qualcomm QCM2290 and Shikra Display MDSS
 
 maintainers:
   - Loic Poulain <loic.poulain@linaro.org>
@@ -12,13 +12,18 @@ maintainers:
 description:
   Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
   sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
-  are mentioned for QCM2290 target.
+  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
+  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
 
 $ref: /schemas/display/msm/mdss-common.yaml#
 
 properties:
   compatible:
-    const: qcom,qcm2290-mdss
+    oneOf:
+      - const: qcom,qcm2290-mdss
+      - items:
+          - const: qcom,shikra-mdss
+          - const: qcom,qcm2290-mdss
 
   clocks:
     items:
@@ -52,7 +57,8 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,qcm2290-dpu
+        contains:
+          const: qcom,qcm2290-dpu
 
   "^dsi@[0-9a-f]+$":
     type: object
@@ -60,9 +66,8 @@ patternProperties:
 
     properties:
       compatible:
-        items:
-          - const: qcom,qcm2290-dsi-ctrl
-          - const: qcom,mdss-dsi-ctrl
+        contains:
+          const: qcom,qcm2290-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object

-- 
2.34.1

