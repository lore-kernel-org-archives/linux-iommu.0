Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096F3314A1
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348576; cv=none; b=jTpEntLOBoR9LG2COeeplBJjfCrPJjkKALZj8jfi1jhf8QloHAAJ5ZSNJHMDmKSvjZ/Q9+qtFpWBgcEjbfPz9CfZdHpR11Df1ncHl+mf+zdCVafisg79uHxuFXEejU1M6uGbHaPj0JX8OEL8mzDBGWPVPeqyCSzfsc12K21JuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348576; c=relaxed/simple;
	bh=AuIMbc0fKqW+ZtVnfeBML3Ai6KXaZ8hBVqiyyzdw++k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqWrxGfMOAXzIPY+CRGAACmYPHttv1D0E2ss3o5e5daJwQdt5FNoRjtEOfxrPX/XzHcNoBY30VU5Lb2HobkHwU5P4XxSplOHBBzYwnj3U3L3aPL3q81vV96rlonFtL0VFwXQBoPQbR681hUS8Dr1mJSFzNdRAqSOeDeQjdqOqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NjosH5/M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HUuR6Od+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NjosH5/M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HUuR6Od+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S26XaQ1237213
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hcMM3x7M6VCbANVsmt0CnWhUSF2Bk1TlLTXZNDVbg9o=; b=NjosH5/MJGbbl3x9
	OQwXmmIU1g+q+D8V25zHLygIQz0yFU0vCfQGzqGF8DWFcd+m4p6Uw7eq+CXaqwOj
	takx1CqCVSJLr3bI2Kyb0SF5UaT6qaFi8ENjAnlTUw36BmPkbKvpL/342Egrps3f
	1JtofDaT3pArcpkpakbbZzcBgEnvxLPBNf3PqJcfn6DxzsTQOfEeXIQpJvfgC9RY
	BXsYDDv2pYRu8EiyR81WH8ddUHns+/znjEzt4wJqgdXQl+rGyYwXa+ZQY4EZQKT9
	2hATfttpD9YoGLuwRZtrJ288QacqD+VBFjUtuFkfr9YpxWiCvIHe7sE83xhQTw5k
	uUuQ6Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4kef4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 03:56:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3594620fe97so24272806a91.1
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 20:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777348572; x=1777953372; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcMM3x7M6VCbANVsmt0CnWhUSF2Bk1TlLTXZNDVbg9o=;
        b=HUuR6Od+oVjebQC+gBEHIwkZbK7whV9GgDyoGPrSaC+DgR/r7jAeVZA6k9VBFye5bu
         Dtj/K2NYY7bf7pxGTDJ9fWYUilNg5m1gIcYn4b4eR7jQfZ0nbM6Mi6JE20n1UAfa+IyO
         jQByhHzImW+mRJX6zRKXnKXzEi6dXlVB2QdfoikqCbGxb5uIe/Jx4kUNq+3wdlwVHKjO
         jzfAb6UB320taKUf9ya1jfNAxnGaoAeVi9+wGPgHoMDJzWhqsav5fpN2l8+SAMm1xbbw
         oBUR0lcdGfqN7GL85L0IC8Y1vGISW8IJ1AXraXsc2dPLatMG8Grl4SuvnVbCayY/JdPp
         xmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777348572; x=1777953372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcMM3x7M6VCbANVsmt0CnWhUSF2Bk1TlLTXZNDVbg9o=;
        b=TnxMJ81Oq633mNJfH2KQ5qsnCfl4u9RW7FblDz36oYRYPxOi7aPiqiZ3LkYtZrEkYc
         gORjLOaijxhvdMjYdnLzugp34wB4wLtlzqgXY2VsRCh6w8TPQHjMCiNHIVYYFdU3yoWm
         162o2eYbVYlFplm5qEpWRVUYP41S2lXiw6VWZJWMa4R5+6NMKT6W0diJsSclrP8evsEc
         xFSWEbD5kgCplr66eflKyKyy18zn4VGxmWBwZGZyjtWAolTgw23QjtM8NjkxqkZLXFH/
         mqfEbay2bhK63WHtTITY13M/Mcw5oYymb7wkhLyqmVOmlffVLAnXII2FAd+vc7qHteFp
         S2Sg==
X-Forwarded-Encrypted: i=1; AFNElJ9ttDjeT8ObQDhrKYbCkxj60mRdZM+8COH1KDQJ5RQMuRdAANwbwcYD8rdTKU8rN3su2I8r7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHEIVCw7BF4wj86z8tQICxWNU1eXruUq85lgkdHUhDG4CiQrNQ
	NCv5tuyxErDfJYCT5bsuI0fSDFpFToZCWxXF2I7A7oAV9PVmwu12+AmlswTxeLWNuOVSXRu9V1w
	7NfLdloqFUyxmd7PvPFtq3sw98z1tvGzlU2LgwqZIrK9Iv9rCBmbIu+3FYA==
X-Gm-Gg: AeBDietw9d1zr4bv/GJb0UGwU38KZF1Bl8nFMte2xyE+rkyuIihzl2oEmyan2XiP24B
	Fyltgekq+uZDxUy3sRuUkbFOk3/ffNfMm9hxZl2h61y89SDNQFJ2s+jXUbtnJMnpRh6FNO1QgCA
	+C9MnqDI5XFJsidW78yUMbT1aUDZibaZmzcKjmT8LemPF/5aYgvN7XPxBuuGlJgsG7eY2drMVgm
	vdB0QiSH7ytXH9UKI4PmvMcicaIVWGYMJ0+aCLyj0fODsXB1aTgVgJu/nSs0xxwQFIDmgAd3eg0
	VFKu2ZhA3Kwq1ZIWPDn8f2iT5i4aGCj9lF0r34fR4roEbWO8iHDeOEyeQWwYXsyowRgivRbykYt
	KBtuSrr7G5aq+0ZnMJDJeBFHMIFqCD3Gms4WXUUQqYoHvQ2A2l9hsYykVllM3FTTWkg==
X-Received: by 2002:a17:90b:4a10:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-364920a614emr1430116a91.18.1777348572304;
        Mon, 27 Apr 2026 20:56:12 -0700 (PDT)
X-Received: by 2002:a17:90b:4a10:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-364920a614emr1430084a91.18.1777348571760;
        Mon, 27 Apr 2026 20:56:11 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490905648sm393888a91.4.2026.04.27.20.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:56:11 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:24:08 +0530
Subject: [PATCH v3 02/12] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-glymur-v3-2-8f28930f47d3@oss.qualcomm.com>
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
In-Reply-To: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777348550; l=8561;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=AuIMbc0fKqW+ZtVnfeBML3Ai6KXaZ8hBVqiyyzdw++k=;
 b=GH6JDhHcNmOBMTFZwxThhZGKJkeSOwwpbkLX8YoNZDArW9Pkov0k3mbieDUOvnd1NR1a3rLKf
 9lyS/xzF2LdBDWm4aun//zKLF89isk1xpTb+k8FihcZQUrbr4bvoo3Y
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: rcjS1EL-atat2l_qkN-LBbymcbC0AIuS
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69f02fdd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=kWiFqobyyPn0S43oj-cA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: rcjS1EL-atat2l_qkN-LBbymcbC0AIuS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAzMyBTYWx0ZWRfX0/UmPRu1oJmx
 O9C3crmJV54zFuLiNrJMAL34TqtpS1LRcWXEmDHb5IcpRjQFX7gLqJ8+Sc7qxt7l6WQvG+kip1z
 SN9+F9wOhfURBExTAJ6h5ZrTst1Bl0fiohrmVTywf72E8x8kH79/IQ7RPhGeSTBth0jeHdx8RS9
 NBvKqu644HvwUuFPrVJM7bRQ02BRyH5L2dJg0ZrOqSKqPMuRuX6L3eV9fwDiUrg5RNVWKhxYpJX
 wL93GibKN4uNCWl/8EZtkG1tl4oHmzkSxnmI2NHtYX24gMH52+J2lmK0IEATYOdqk0+6C6aBmgp
 kZQ5bRQKKT6yjnZ7NPn5HfkMeonpnFD+I3AvO2q53ZF0HIKBxA2EXtWUlAwDeZ9Rn8iDnanVXQn
 Dp9h5h09DQK6Aj1R2+HtfJZP9KKpfYJWYr5492RCjgWt51knB6MsRWq8mtfqGbdX8bySYYK/pVJ
 W8/hb7KcDOzD5Iod4Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280033

Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
is a new generation of video IP that introduces a dual-core architecture.
The second core brings its own power domain, clocks, and reset lines,
requiring additional power domains and clocks in the power sequence.

To accommodate glymur clock and power resources requirement, the maxItems
constraints in qcom,venus-common.yaml are relaxed. This allows the glymur
binding to inherit from the common venus schema without duplicating shared
properties.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../bindings/media/qcom,glymur-iris.yaml           | 211 +++++++++++++++++++++
 .../bindings/media/qcom,venus-common.yaml          |   8 +-
 include/dt-bindings/media/qcom,glymur-iris.h       |  11 ++
 3 files changed, 226 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
new file mode 100644
index 000000000000..3c5305b688ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
@@ -0,0 +1,211 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,glymur-iris.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Glymur SoC Iris video encoder and decoder
+
+maintainers:
+  - Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
+
+description:
+  The Iris video processing unit on Qualcomm Glymur SoC is a video encode and
+  decode accelerator.
+
+properties:
+  compatible:
+    const: qcom,glymur-iris
+
+  clocks:
+    maxItems: 9
+
+  clock-names:
+    items:
+      - const: iface
+      - const: core
+      - const: vcodec0_core
+      - const: iface1
+      - const: core_freerun
+      - const: vcodec0_core_freerun
+      - const: iface2
+      - const: vcodec1_core
+      - const: vcodec1_core_freerun
+
+  dma-coherent: true
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: cpu-cfg
+      - const: video-mem
+
+  iommus:
+    maxItems: 4
+
+  iommu-map:
+    maxItems: 1
+
+  operating-points-v2: true
+  opp-table:
+    type: object
+
+  power-domains:
+    maxItems: 5
+
+  power-domain-names:
+    items:
+      - const: venus
+      - const: vcodec0
+      - const: mxc
+      - const: mmcx
+      - const: vcodec1
+
+  resets:
+    maxItems: 6
+
+  reset-names:
+    items:
+      - const: bus0
+      - const: bus1
+      - const: core
+      - const: vcodec0_core
+      - const: bus2
+      - const: vcodec1_core
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - dma-coherent
+  - interconnects
+  - interconnect-names
+  - interrupts
+  - iommus
+  - memory-region
+  - power-domains
+  - power-domain-names
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/media/qcom,glymur-iris.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    video-codec@aa00000 {
+        compatible = "qcom,glymur-iris";
+        reg = <0x0aa00000 0xf0000>;
+
+        clocks = <&gcc_video_axi0_clk>,
+                 <&videocc_mvs0c_clk>,
+                 <&videocc_mvs0_clk>,
+                 <&gcc_video_axi0c_clk>,
+                 <&videocc_mvs0c_freerun_clk>,
+                 <&videocc_mvs0_freerun_clk>,
+                 <&gcc_video_axi1_clk>,
+                 <&videocc_mvs1_clk>,
+                 <&videocc_mvs1_freerun_clk>;
+        clock-names = "iface",
+                      "core",
+                      "vcodec0_core",
+                      "iface1",
+                      "core_freerun",
+                      "vcodec0_core_freerun",
+                      "iface2",
+                      "vcodec1_core",
+                      "vcodec1_core_freerun";
+
+        dma-coherent;
+
+        interconnects = <&hsc_noc_master_appss_proc &config_noc_slave_venus_cfg>,
+                        <&mmss_noc_master_video &mc_virt_slave_ebi1>;
+        interconnect-names = "cpu-cfg",
+                             "video-mem";
+
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+        iommus = <&apps_smmu 0x1940 0x0>,
+                 <&apps_smmu 0x1943 0x0>,
+                 <&apps_smmu 0x1944 0x0>,
+                 <&apps_smmu 0x19e0 0x0>;
+
+        iommu-map = <IOMMU_FID_IRIS_FIRMWARE &apps_smmu 0x19e2 0x1>;
+
+        memory-region = <&video_mem>;
+
+        operating-points-v2 = <&iris_opp_table>;
+
+        power-domains = <&videocc_mvs0c_gdsc>,
+                        <&videocc_mvs0_gdsc>,
+                        <&rpmhpd RPMHPD_MXC>,
+                        <&rpmhpd RPMHPD_MMCX>,
+                        <&videocc_mvs1_gdsc>;
+        power-domain-names = "venus",
+                             "vcodec0",
+                             "mxc",
+                             "mmcx",
+                             "vcodec1";
+
+        resets = <&gcc_video_axi0_clk_ares>,
+                 <&gcc_video_axi0c_clk_ares>,
+                 <&videocc_mvs0c_freerun_clk_ares>,
+                 <&videocc_mvs0_freerun_clk_ares>,
+                 <&gcc_video_axi1_clk_ares>,
+                 <&videocc_mvs1_freerun_clk_ares>;
+        reset-names = "bus0",
+                      "bus1",
+                      "core",
+                      "vcodec0_core",
+                      "bus2",
+                      "vcodec1_core";
+
+        iris_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-240000000 {
+                opp-hz = /bits/ 64 <240000000 240000000 360000000>;
+                required-opps = <&rpmhpd_opp_svs>,
+                                <&rpmhpd_opp_low_svs>;
+            };
+
+            opp-338000000 {
+                opp-hz = /bits/ 64 <338000000 338000000 507000000>;
+                required-opps = <&rpmhpd_opp_svs>,
+                                <&rpmhpd_opp_svs>;
+            };
+
+            opp-366000000 {
+                opp-hz = /bits/ 64 <366000000 366000000 549000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>,
+                                <&rpmhpd_opp_svs_l1>;
+            };
+
+            opp-444000000 {
+                opp-hz = /bits/ 64 <444000000 444000000 666000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>,
+                                <&rpmhpd_opp_nom>;
+            };
+
+            opp-533333334 {
+                opp-hz = /bits/ 64 <533333334 533333334 800000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>,
+                                <&rpmhpd_opp_turbo>;
+            };
+
+            opp-655000000 {
+                opp-hz = /bits/ 64 <655000000 655000000 982000000>;
+                required-opps = <&rpmhpd_opp_nom>,
+                                <&rpmhpd_opp_turbo_l1>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
index 3153d91f9d18..bf926c602037 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
@@ -20,11 +20,11 @@ properties:
 
   clocks:
     minItems: 3
-    maxItems: 7
+    maxItems: 9
 
   clock-names:
     minItems: 3
-    maxItems: 7
+    maxItems: 9
 
   firmware-name:
     maxItems: 1
@@ -41,11 +41,11 @@ properties:
 
   power-domains:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   power-domain-names:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   video-firmware:
     type: object
diff --git a/include/dt-bindings/media/qcom,glymur-iris.h b/include/dt-bindings/media/qcom,glymur-iris.h
new file mode 100644
index 000000000000..dcaa2bc21db5
--- /dev/null
+++ b/include/dt-bindings/media/qcom,glymur-iris.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_MEDIA_QCOM_GLYMUR_IRIS_H_
+#define _DT_BINDINGS_MEDIA_QCOM_GLYMUR_IRIS_H_
+
+#define IOMMU_FID_IRIS_FIRMWARE	0
+
+#endif

-- 
2.34.1

