Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB613FC5D0
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325397; cv=none; b=XB3rrwiSCwo/STfTSFoaOqBvg2wMjFGvEpEw+jsZF5c5ePzV3nNPi2FjQOW8QC56QeLIQTxGtP0MffDE+taJXcBXdzCueAP/q5wOr/e6TQ6aNFHIW/4+cEmAH2fNVQx6aLOm5wAM1Y0Lqi0s8lG0vDFaOeWUSyh/0IFJnbHLnwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325397; c=relaxed/simple;
	bh=AiyWfqplixyHhsYEa6qazzHkZE3xEPK1wk4cmDCQzxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzXmYi4E7Iw1YCu9Z4x7Q4OnZLa3C9rkAJFhmXs61DqKBkRNDsXiht1U86tsE8QBujKR4Q0QtsyX3+LOmqI7KvlFxlIHFi/buD3WtTA0ug97nCTBOwPTSQs+pJ++tHfKWccr1apXVY+1I7Cfn4PXVQdIKXvaR5YipCVIJN6SUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZpnZospk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WDXfy+Mj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZpnZospk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WDXfy+Mj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI2ciI2290409
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j/B543lMo2xs5fq0oxi7+gzjq2nnRamJAsArnba3yCk=; b=ZpnZospk0atr1Q4t
	GWeK1YAhSl++J7e+yWGzMdx5FSQ9mE8F+oKDuu8tpg6eXbvJ1bALB1gR29VkOyeZ
	bmGxfwg52pVBsdkZNg6JuSkSnq90jfrbuCy2Y6NABKchbj0Agv1WzQMmhLlKOUX+
	oi738aHpfdNw0lLZxLb2OWN307hEr4aU4/eK/E6xaHAOQzJyp5cX35kcEdbzJt9C
	UoTro1WO+1M4E0rk7h73J7sT2HTIvl4kYORRqXA2IeT1Pn1JbqN44rS1XV6wcVoq
	AZTLEWJnC+/hrT9Kbs0FGn/wJCrRbCwM5QcJ2ijEYCmmdzYVKzeqiH8yPyc5R9qr
	MpX4qQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dbvq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:49:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398fe469aa0so4718139a91.2
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325393; x=1789930193; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j/B543lMo2xs5fq0oxi7+gzjq2nnRamJAsArnba3yCk=;
        b=WDXfy+MjmqPejt11CF5PFk0wLw2ouO9USMkO4GW1U0/2jgo+U7DA9Cs95RFKTlzqnz
         ZaBX8OTRZ8RfS3Z3UiuBtKAmpHk+KT2oJgPV5iiRCGMj4bEuSl6cUcBVZ7Qu+i8xDefE
         oc6UpzHTMBj22rv7nfl20uN0BWMq6QYfTISxBu91HVa+xhdciTVx6FAO+4Fl4ByhvO0C
         yIcJqAovTy7yUZvNxo+FANHDt20UmPEtRQHSKj/k5iT5MRNf65df5pWr8W9yhwmJaoyS
         zFmAz90QONrQVbP2uqGrFYkthdKdXjpJU+A1Us4T1cyqzZx5LDlfw3at/6f5ZDrps+MK
         EgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325393; x=1789930193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j/B543lMo2xs5fq0oxi7+gzjq2nnRamJAsArnba3yCk=;
        b=mW9H8OSUA547/EMy9PGueLwiLtNnm3LWfq5ATvyfjAd/ffScj6e3AXuZhW8DjGgF2J
         CXtzwZxHcc2J98SZvBcD1Rm64oiZRai01PKJgJ79UfbbrwYqcSXLyJQ/UMuiU2o5KrNe
         Vh/rCN769LlqUG18ikm5RatYapJFZtzY4SsjKjKb6fG1TKSX9Qtouvx9r7lYPUoLxeXU
         ZZxHeZ1YooAnRE5j8msXa6Y3UI6SZYgM3R0/MnE64xaEOcnAyBTlyjk+H0iAGk8O3BFq
         7mrDquKbEoSFVjCOnrhy/RUPf47Xs5/SCDGqsUEB9EZAjb3z5LZZbojxIQZFc3LwiIa3
         H+6g==
X-Forwarded-Encrypted: i=1; AKwUvBxwhnO9pzINbT8t4KC5DClvEyEB4saYVPKMyjRWemh5rsr/08Kr24Q91U2z6ht3difHaLtvTQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lEJsVsgaqOrCTURsoJ4pdS7jHFVRfwys1+4Yx5m86QZjgW/0Mz
	d7dttqsWDDGx+8mUhbVjmOQdrDncMKSYa/3c3OlUORs7qG4uae640KRSXDq3zKQpKWXLrbKj5c8
	nACykjQWhSPW+zJ+65knJb4/9RaQro+nfBgY3sCrt2Sg/DUIeDydanS0N6A==
X-Gm-Gg: AYBFou0mFG5XUuyKmQeQKM59nafSHqjbAUke73xm86vLj1TP1orArBHfjgINIMUN8HT
	SMQEBl8bCUrYuN/5LdJbQ95z23sDOw9juWyImmG0z7OQTP0WmZroZpJCz3PG0ZKOMPjw+hHW1Ms
	osxxZS73EP8jQ0qR4a6nPS8iAtuucMRZmkIuJQdCcN6dM8E/iBMhD4Gjx2VSi8GvRWiB37u3fk4
	xkTJfCwHoKea1HIts5xAS8Ab2p4D2gq8a5lrYBkUVb/n5MXDhtGvJY0yUjmvc9O7JG/Tb+csAjC
	FoCkxAvf/pAZdXHMDpgNuwAosVC41aEjL5Zp0fGffHxYARW1lH5crHeUDh18oN6qL0HevsupIoW
	/6my2Ed6Nfa3I9UK+/Rr8jXCjr2EcHNRxZ4A=
X-Received: by 2002:a17:90b:3dcd:b0:399:ea1:5a82 with SMTP id 98e67ed59e1d1-39d9bc66ab9mr26784605a91.3.1789325392685;
        Sun, 13 Sep 2026 11:49:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3dcd:b0:399:ea1:5a82 with SMTP id 98e67ed59e1d1-39d9bc66ab9mr26784562a91.3.1789325392257;
        Sun, 13 Sep 2026 11:49:52 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:49:51 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 00:19:18 +0530
Subject: [PATCH v4 01/13] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vpu_iommu_iova_handling-v4-1-9b9074a73c41@oss.qualcomm.com>
References: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
In-Reply-To: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
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
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=6062;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=AiyWfqplixyHhsYEa6qazzHkZE3xEPK1wk4cmDCQzxc=;
 b=seUnoj2xKMJ+NXtkcDwdorJnyiOhZ5yI5zE511+9J5owCUGD2ScaOoQdrNvNdU70jaB5Gg3oN
 M3sFFhfxNxEAq+AOdjPKv+18yIpYYKr40BTFC3UFh94ZvCYL9gcO45A
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX5MigWHWf8yRA
 5WzYhR152rNLLR1zAk63Ykk1dj7HLMFFfWKI+datAa9nkHrSoJDH8EnX/r5f13HeRT/9+JgC3Qu
 B+fvxI/lNP3z7LNCirdi2ClWjZj5isD0bten/Uco/e/mGtQ3tHBtqfDLoxcRoFox/e3yp6NGzuk
 Ittn76jE7F/kVLvlPQfZ+XfJ9kKBlJRd8iEeR55klgfNUmg4vGq/Nk0XUOido1xID6qFfYfDxnP
 fAUgn4RtujS/KCUi+S35NkXaD1uPi6533Kt/nd2g+gPM9GWsC2NrWxsSUHzr0d1GTs/wjYO5jEk
 gMAXGhE253nUaU5zFclBIzYOFlOOchrOMSD0Qz0oWLga5/yBwi4sChI6rT8l0keYOrjojbAxwhu
 hBs6v3kDsjGJVX49hAJKzzDYvmgLLhaXWYN5H4ye1t4wg31R7zcAbAclKdmf4NuZRDh0S94Jpvt
 RkoblkqQs4GFA+npMmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX2D6SsxoSlB5p
 NjDfHRCAF2Io4YBzjeKkWX+5AuiTq/Gkhxq8gOj5vZ3Irvqx68FPshwAqkQ3gUcA8TiwTk6OjHk
 ctGJSm+sppDyaHVX9BNmBUuM10hRbV0=
X-Proofpoint-GUID: x_mqmPPkoxerOwDNmSjDQ-1AviUryU0W
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa6f051 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=weiu3rfF03DHpAy_C5IA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: x_mqmPPkoxerOwDNmSjDQ-1AviUryU0W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130267

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

