Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007957D235
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965861; cv=none; b=ek6nKwwDG1UosGD4BpXL8TZXiKW+98hYhqexG3Oq7fb5tDPvX485HAGChhcKzYAE6qgP7eb/ofBVw8PpJY3mjoxD6+dhmmw1BSQWIQVbdOe7gMNWUKYmF9H0ZctfWKgb+1wUtlpON2dwbALQBhS+/5pcR/yhIzEnAahxBNwbhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965861; c=relaxed/simple;
	bh=ClN1HxPqioNiIjlqriHYURWSJ/USriPE6SkA+Pha1Kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTnPCzCVbIPDOCnKNZW0PUj3vGhyZxQQ3WFq3v/LRTf+BooUK29RR9dzSzSOJxwsO8qtboX2IP4HypgmETLqH8NMHMyA9lcxpiwywPL/7H7eM/3CD4EazMi9J8Xolbybu7+/cjJs7+KS1RiD+V2m03rmkPxPr4QGHZyKlIrmq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R7cpT5/+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bbYQt/88; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7cpT5/+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bbYQt/88"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUBs22171847
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 14:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W3824liDhpxEGBtUO3K6ahqQxpsQoUAznRXV0ie19fc=; b=R7cpT5/+Yc7NrvIL
	JJW2TMN97rsPWYV93VoCeucS7uxtzd22TBT7OWVU/XIEqs2O8JEcfQdbcnwP5mWE
	L1kcv236rmJapkN1jg+ZsOUg4d2Bx080EJitVd6JxneT3AYgHderVwuLysYAoEpg
	Nx7UXfihkk2tgUjvLR7xmfqDQmSjRF5xASYM1t5AAm49AQQULVWW08rxn30nQnZE
	W037BLYfJ9tlAbyhCwSieluh5Sa1+Momf846Rk+HDPkD2XDHZ6ynN5zDxs6M3p9b
	wDVOaTw5PtxiYTXfhr+ByrRj1vjkov8345PJoDILUMy50EjvJCftAu3SbNCh0cVC
	+gwEKg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5rgh2kn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 14:57:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so6903653a12.1
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965857; x=1789570657; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3824liDhpxEGBtUO3K6ahqQxpsQoUAznRXV0ie19fc=;
        b=bbYQt/88mTPGpOahTJIrXeswk3rT5Xctucs718PQIFcj+o9IO9okR49yzu9hWE4C+0
         RYl/wR0ZCs5/iOLV6ejqs3QqCQjAHC8jKLO/2COksWs+rqhKRnF9kmlorzqZjXcUUe/s
         HkuVGjuu7i5vI+4348j9u5choblLDWKy2etW2wPo1MvT8ExkkaZby3a+Yut0dlpLacyL
         k8p3/hm/48vJflNYHt+8ajPYIIKAVSj/L6PZ2QJPz15SBtsCW3wIshI84bwSomY7D6db
         d5oZ8KbTGWyyodUcrCPYoutpMiFhHWIlkIxIkjtPyx4eq31xhA9Q2VzNZmCBCn+4LezE
         HV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965857; x=1789570657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3824liDhpxEGBtUO3K6ahqQxpsQoUAznRXV0ie19fc=;
        b=ZtSk+7GwI0D4vvgza4sPjq8hULi/1oUmsHlWPOf5dB36Wltx7xa6S8FI9GOsyQWrN8
         qqyN4stEjw12wlAH2cXTApfTcPeGaxxrtCjD/+5S5PyyvMDmpZiZSepi2tp/2Kry5whi
         hzaxC7Lk3DyHlsJYb/4XWdngtLmn55YyYVJJolmmJvc18hwOqvRCP9FM7aEqy/hFQ7Tc
         1PyTJiYiofVqp+9/ZgmzWy9DP4Z3Pb12ezyjv2Cm2lzl1V+6Z3YniFrBkVmUYz72tJ3j
         TZ5Tbilqnt75/Qa2jUh0JY25M6rOfMMRuZgRaA2enGWru07Oju6gH1JGz0FnYW6penGJ
         gKSQ==
X-Forwarded-Encrypted: i=1; AKwUvByInL5ax+kgRYoEVk+PAXCaIPoQV8Dn/0lnlXkEKtdnqM4JyoLWzbcVUtCeCKs9Tx1Cb66wAA==@lists.linux.dev
X-Gm-Message-State: AFuF++ltp/I4C3tV2odGyu8W4kZDoYWqKJYDfgm7EwY2TWWxDCaFZ1g7
	iZmmcUGKD0I5I3ds6U+kA6Q0FxHsowh4vSmoDHZn9h6Vzd3jeaphXXIX8482U5Gu+VNX+ejRwwv
	otH74nZpDv4OZz8LxJo/dHEuavv4nRh+GveliUzo/yHK2rgEF5WyMjCRByA==
X-Gm-Gg: AYBFou1DFXNlArVjybmP+rcsWe+Ym0Ss8f4jt5XLbGz8VL6fqz6ouYm1tC/NX8lJ8pt
	RSDeyAZAOE58RWIXvpp8QFtSQnPM3wN0zw7Ccaxm9Z7cOMEse6YLE1HTp7VRwlRV1nH6e+ovVOC
	uN46XMFCPyoHj6ki0M6DGrOZ1hZtPQoFRm3hgK8GymgpFQH3RK/xQTXHzwKbHRH/LvmDsxE889D
	CS57q5Z01q0pmZEkAhUs9gPbCkWyFBfmYmtz+wQQTzcObeu26ZpEr3Xx6zOKIZ+HlNfA4t2pibS
	Mu0GLOdpxjcpNwKn2n8k0/luicYf8iaRJCN4YmpPqsQLS8TaHMJ71tHjHZ+TFd7NgR1uU3yf9de
	M0nvmFj8szouheyaLwQRRZe/Ucwbc0I8GZZU=
X-Received: by 2002:a05:6a20:72a6:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3da39b3a6b3mr50443074637.1.1788965857334;
        Wed, 09 Sep 2026 07:57:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a6:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3da39b3a6b3mr50442961637.1.1788965856678;
        Wed, 09 Sep 2026 07:57:36 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51270766eec.21.2026.09.09.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:57:36 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 20:27:08 +0530
Subject: [PATCH v3 01/13] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-vpu_iommu_iova_handling-v3-1-2fe43ae45495@oss.qualcomm.com>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788965840; l=6191;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=ClN1HxPqioNiIjlqriHYURWSJ/USriPE6SkA+Pha1Kk=;
 b=b74xqKaGQeMMbMBnkJ6h6gZyHbLoxYz6ltfwWDTDCXK3NsNerz6TlxLTZVJlMPf8JHcFz39DK
 uH23C55c/I+DczAHj7JXx0Du/xr3KzDUA5jr8rPleYKS3BLYvIens4M
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX3EZT5s2VqJRk
 MQMB0GaJTbQ5eZFPfnxfdBNkko90uf7XTPV+cezDIa+u9t8dNW38pa2hHC/8n6TrgC0M2oljfDj
 6QrbOviVQjIzb4s+g3nrSRyQ3AUHDq4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfXw/Ixi/QYikfl
 Vedoy2LjeliIC2i9x0bcWXirN5gZarVIJzCy7lBW0P5OnFXwrZS+ROxEBkU7V9TKsLC1OYcgagz
 z/NhfJ4Y4IeEhSuamiQ007vDf9jQKg36w4yFSieJZzOUDAMC8+jEJ3ouyjDYXa+bCw9lIshdXAb
 bBsBmEtuM+unYcGpwUbye5kFVta6obktKC1wzohiM8SyOm47RejiQ60QoKmkDQt1p1s1x8sOz0v
 b4FihiXcjLThv2aMIwctTTJZer+DBZjX3Js+9gKhnYoYuoCBKNOwb3BrItmgWp0w1aqcy5b2PIi
 46aS8IFOJXzJ73qElrnl2btKkd3U+/j8xKpDfb4u+lICIzliYelwKyb0Svx5XrPnEfno2tlrjHR
 2uyPy+1JFpZbhyQKHdG0gh11KnebjUOiMszt8RrIfeg0JQ61S9TPeuH7sR29x8g6bMMUUbJS4fN
 g2zBY5i1LT77bnj288A==
X-Authority-Analysis: v=2.4 cv=B6qJFutM c=1 sm=1 tr=0 ts=6aa173e2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=t9ty7G3lAAAA:8
 a=EUspDBNiAAAA:8 a=weiu3rfF03DHpAy_C5IA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Vxmtnl_E_bksehYqCbjh:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-GUID: HE_KEv1wgwKkESW15wwl3jT9iazGDBfS
X-Proofpoint-ORIG-GUID: HE_KEv1wgwKkESW15wwl3jT9iazGDBfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090167

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
A single "iommus" property on the video-codec node puts every stream in
one IOMMU domain sharing one IOVA allocator, so nothing restricts a
non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
that boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Given that the address range restriction is for specific VPU stream, it
should be ideally be moved to that stream. To achieve the same, a subset
of streams is now represented as subnodes, so that each can be
associated with its respective addressable range. The design was
discussed and agreed by mainatiners here
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org

In the past, this limitation was addressed with an iommu-map approach,
with the iris driver dynamically creating the devices. That approach was
later concluded to be a hack to avoid having subnodes, and was NAKed by
the iommu maintainers. It was discussed in detail here:
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/

"iommu-ranges" on the subnode describes the *allowed* IOVA range that
stream is allowed to use, so the IOVA is allocated from the specified
range only. Define all the possible subnodes so as to describe all the
VPU hardware iommu interfaces, both secure as well as non secure.

address-cells, size-cells and dma-ranges declares the 1:1 DMA
translation into the parent.

The parent "iommus" is kept as an alternative via "oneOf", so platforms
that have not been converted to subnodes still validate. New platforms
should use the subnode form.

This patch depends-on:
https://github.com/devicetree-org/dt-schema/pull/207

 Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../bindings/media/qcom,sc7180-venus.yaml          | 15 ----
 .../bindings/media/qcom,venus-common.yaml          | 97 ++++++++++++++++++++++
 2 files changed, 97 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
index b21bed314848480b82153e49602f0b19e08e7335..bfd8b1ad473128c974bce84639cb0aff59d8c2cc 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
@@ -91,21 +91,6 @@ properties:
     deprecated: true
     additionalProperties: false
 
-  video-firmware:
-    type: object
-    additionalProperties: false
-
-    description: |
-      Firmware subnode is needed when the platform does not
-      have TrustZone.
-
-    properties:
-      iommus:
-        maxItems: 1
-
-    required:
-      - iommus
-
 required:
   - compatible
   - power-domain-names
diff --git a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
index 59a3fde846d2196ab1e4588eb396012ba6860712..68d5e592a028c5eecde04ce72cd5ae6815ba5c82 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
@@ -47,6 +47,93 @@ properties:
     minItems: 1
     maxItems: 4
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  dma-ranges:
+    maxItems: 1
+
+  non-pixel:
+    type: object
+    description:
+      Context bank for VPU non-pixel buffers, including compressed and internal buffers.
+    additionalProperties: false
+
+    properties:
+      iommus:
+        maxItems: 1
+      iommu-ranges:
+        maxItems: 1
+    required:
+      - iommus
+      - iommu-ranges
+
+  pixel:
+    type: object
+    description:
+      Context bank for VPU pixel buffers containing uncompressed video data.
+    additionalProperties: false
+
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+
+  video-firmware:
+    type: object
+    description:
+      Context bank for the VPU firmware processing domain.
+    additionalProperties: false
+
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+
+  secure-non-pixel:
+    type: object
+    description:
+      Context bank for VPU secure non-pixel buffers.
+    additionalProperties: false
+
+    properties:
+      iommus:
+        maxItems: 1
+      iommu-ranges:
+        maxItems: 1
+    required:
+      - iommus
+      - iommu-ranges
+
+  secure-pixel:
+    type: object
+    description:
+      Context bank for VPU secure pixel buffers containing uncompressed video data.
+    additionalProperties: false
+
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+
+  secure-bitstream:
+    type: object
+    description:
+      Context bank for VPU secure bitstream buffers containing compressed video data.
+    additionalProperties: false
+
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+
 required:
   - reg
   - clocks
@@ -55,4 +142,14 @@ required:
   - memory-region
   - power-domains
 
+oneOf:
+  - required:
+      - iommus
+  - required:
+      - '#address-cells'
+      - '#size-cells'
+      - dma-ranges
+      - non-pixel
+      - pixel
+
 additionalProperties: true

-- 
2.34.1

