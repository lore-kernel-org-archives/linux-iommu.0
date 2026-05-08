Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B941323B
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266894; cv=none; b=SRfS3tupr6ofyFv4Zbj9uB3oXvZ+P9McsVpzuqTspYAgwoeCpXWnyQbtZn3d4s6TgFZJWKHvkT9J+cg6qw+ud/Oq4nPbVMg45ESh8zCwzdnSoDtieiybu64V/CJgPWywSRM+NvJOVCnGfmtx9+WphpYrDVDgWNjLezSMTOY2Nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266894; c=relaxed/simple;
	bh=EeIAZMRmgVmSK/Y4l2hVRqTqYGOuHpZ+loERcUpLJ1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WMzia+OhgBXBvg+9m3hwgdgGYdMpOHhnn8thm/W0+CbycUKkwcs08Kn0m5vckbH0bbbL/Z5zjAzzFCLtEVirjENJsrybYxKoolsm8PMPEJnUCoqG8UCX1oDfS9ErataX12s4HzB6ndtRjpHoBRjq+UT1Zrko5mvr+lGGkW42mr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o1MfV9po; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LDNonmMM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o1MfV9po";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LDNonmMM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648DTMjn317393
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B2KaNJ7wQbTV8z+VB/6ohB5R61JdVKBpxz4P1XelljE=; b=o1MfV9po/5AzGvQY
	XRXWnINt7kvqpcJcJLIhSS2Mx9pzpvPNTFBz/b+bwohPPql8a6xS0mR1ihkAoCwN
	2wtQRkwaeZ9ALJJ9HGERVsu04aUf20TQ4Ll+gv1E3JIwHY0HfYAWRkrhgleRbg/I
	OnGwqVHBLTEqBVBKycZI/oUZ4AWK7h2qb6QWFwj8nmgHWVbMnGTrieQKQRKTklhW
	LZgq1PdSB8i9DIX2ozRwSFNEPIBhh0CrvD2zia2Rk1ilP26DsK6/utwWb9VpOPcz
	MD5qwshwJdw1hFB5joCDz7PkFMqbamm78RrxcZf6Ih86ZRikiLZg142LsrdlnNjr
	AWoBfg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1bc02td4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:01:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-835444b6ce1so1755626b3a.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778266891; x=1778871691; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2KaNJ7wQbTV8z+VB/6ohB5R61JdVKBpxz4P1XelljE=;
        b=LDNonmMMPRKt7nzWWnGfbHbubJwpJ2X1+Z8IqAqSw0zay6MIsHyEHALTP7Xw7IS5Uv
         9ICRvfiD58vbyGIYycxFUkA1XwlgzDOyFqGtQxv2Hy5LhVn6NEBa5ZIZUte15O19WvoW
         PgpN2smT8Bn6/Ei660IvmbiQr8utPWfKBw+hipuMOTE1e6fW2S1T+iyKqtDYnV4Y1Nqs
         kKd8DuJlAWJVCLv+soebsyniRU/yaPNTs3szNMlqZctAl9GXsrFK8+WADjGCdXVuGQPC
         My9bBolzf5UZoTAhS9JEjRCy+zuoBbg5bTN0krBtDVhTLxVwOoTFRl5n3SkD75b+JZ9d
         DGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266891; x=1778871691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B2KaNJ7wQbTV8z+VB/6ohB5R61JdVKBpxz4P1XelljE=;
        b=DQrEZOTHafEZscpAleu0TmYVs5bF3r8+gpolkw1Q6U8HZG8AI8sWjMWShKFPozw/qN
         gqaiI7SSyI006EEo/yEE/Qb66UwwXGtfXpUewFUqdo3rdEmwSQOJhP2+rxm4SOh9r+U9
         8m4Ahfj5Y1QGJ5kUQZ+UvsK2A5944AyQXm8zMDF2FnUzLL5Ga271X6xJGs8iIHCo91gv
         Bbh2ddt/WqHRBXrseKBjaH/136C7Jzb/vGhMO2s0qGg4TirB4v5VNEZbtjgFWK/W9zPj
         OtHLjH+u6OxgTkpeHTDxXxwN5lMcnCV4MLGaTdjxobrqCoW/WPWWzm81nTBWhQNFifBF
         iISQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NXNlOz07ZbNxW9GXggNpTZMwdtSHXHlTt0UFvLgi1/PYU8wRev0HZGPbybkDinrO2JHxprA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNSXR5wAkW+Eqmr8t3OBSF3qbwA66ezMj2XY9c5xPanPtvYyW7
	P+eAc2limcrei63Wlc6xvkzlAe4q6D9cUwzlJh+Vti2d3YKYuGHwHvmMqWCaz8e/w9tlrtQiu4r
	6Ehk9kBWfkBjrCu+rCltZTnk2Bz2wl2mvN6Yun+JZH2VPagIolq0LrqLrNA==
X-Gm-Gg: Acq92OH0Y6dklQar3t6Z6UmIfAMKjxyotwXm9SBBB+5sNu1VDrSL4Z+jy9ELbBehn4X
	O+DgatzHOZT196VdRPfwZmJmfVCa4jHZjZJdURsrpBLVjHG5GY61pdWrzJiYhhQg1dI/U3BRZCM
	XRV+23iPUQ5uHlBAKJiAbZ+1dhcHkRSrGFKePNle1Yy1D4unaWPlUmUoIZIKVpaHZW+NLw4HNhl
	1qc5iePHsWCyI3nqnIKxXfiGFk2Xw1583yil4kxqKCc14/XHx7mcsuyHcOqYdyN62pIff3V1s++
	Dt3mgac9qWvh9ZnFEb3D+XdkcMRCAPSrrQpKuD30oIYVJTR3Q6ybTmZB8K/0L+mWydKH8LK8AaF
	tEFgqtU1XhhRGI2OAOE4g0RtjWq70itWDznAs1Qf0lo1kz34C+725PJc=
X-Received: by 2002:a05:6a00:c95:b0:82f:74dc:5f48 with SMTP id d2e1a72fcca58-83a5b2d34ffmr13292284b3a.2.1778266891145;
        Fri, 08 May 2026 12:01:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:c95:b0:82f:74dc:5f48 with SMTP id d2e1a72fcca58-83a5b2d34ffmr13292226b3a.2.1778266890551;
        Fri, 08 May 2026 12:01:30 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm13395550b3a.19.2026.05.08.12.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:01:30 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sat, 09 May 2026 00:29:54 +0530
Subject: [PATCH v5 05/14] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-glymur-v5-5-7fbb340c5dbd@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778266845; l=7497;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=EeIAZMRmgVmSK/Y4l2hVRqTqYGOuHpZ+loERcUpLJ1g=;
 b=0Li8hjN7gXO/t9mp5SMARAExK1BNGbI/HrJEE88yo4eydEDe6qKlPbQEz2JaLJXTMT7zvjgbB
 Nz+L6IlbMXaB8F/et9ZAfkga+riQMV0cwbQnn9bXTYxtmUfnIsxph8t
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX1RvCx3mZ6nEY
 fEgcGbxRLDIZ1oNIdMDSZWB9p8eO1fu+IxLvwpUBEcg72ROyKFHY6HZmJLD+B0ffI0Pbo1KkGSd
 apzFll+KufvFJ6f2NdXYnjHT8rkDpjylwFk/Kg2zNz/313rY8WmujlpNePRKKu6yDchGuzyUXoN
 FkCwfaj1xps6/7FxSKK6OUFOOl3tEnTIUaW9LBoLVTluGZD9l44Vmw3SG/ddAa2/70lUyw1BtFE
 40c7mY/WNbc0+GoIRV0/B0UA2p4xw9aBBTrU43XnnBxt5JkZI2GssgxxkgJC9gJM2A+mScrG1Pn
 64z0nR4gLMGclxolrP1olm2VF+SW2PlFnMsYyrkAflHWiELMYOrdk/wdReNgcx+sDPXaj+86gk5
 7dUTqyWEvuL8jG3aoXVModUzAGweiFRT6jh9F6/yEUsLJCy/nCg84Z/i1tm06foKcMJvWIkcbRl
 8WCeOYh/YuGbLzs/E8A==
X-Proofpoint-GUID: 6h6gBu2Vohop7r1FQ_gHavMJGQIM3myI
X-Authority-Analysis: v=2.4 cv=JJQLdcKb c=1 sm=1 tr=0 ts=69fe330c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=1OCxxfDL7RIz13hN0lYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 6h6gBu2Vohop7r1FQ_gHavMJGQIM3myI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
is a new generation of video IP that introduces a dual-core architecture.
The second core brings its own power domain, clocks, and reset lines,
requiring additional power domains and clocks in the power sequence.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../bindings/media/qcom,glymur-iris.yaml           | 208 +++++++++++++++++++++
 include/dt-bindings/media/qcom,glymur-iris.h       |  11 ++
 2 files changed, 219 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
new file mode 100644
index 000000000000..7b0bb001de85
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
@@ -0,0 +1,208 @@
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
+  - clocks
+  - clock-names
+  - compatible
+  - dma-coherent
+  - interconnects
+  - interconnect-names
+  - iommus
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

