Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE647DFBE
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844241; cv=none; b=os6F+89I/9cTCfOoCgtcKqwZgGLQvJZi5lP7XW+nVTBFZ9DLAHZqLzwge9eHyEDYlXEZoPy9IYXeCEZiK3NK16E4TdJ3qXEvRkpCGZ66fnOqpc9wwJcPhr2gHMbkVZgQkW++427b9a+bEl6LUtYXlXHvu5IsYvlJxI3AY1f0VaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844241; c=relaxed/simple;
	bh=EeIAZMRmgVmSK/Y4l2hVRqTqYGOuHpZ+loERcUpLJ1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPCgcghbOH7vmwkavd6scl/vH9IPAKx21hHEIQ9w8AytYt+XkRvxFNmv/DL9QcVCWgCqL96Wn4VVVx3cUt6pkxkLTF5gGvnQgCLDEb7NbkJl7tK/HBd8pzXX3n3qZ9w7QtCPmRa4bvsnewzwMunY4ve1QBXktoVZyAQuggSghuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=itQNes7S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=epSBh/S5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="itQNes7S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="epSBh/S5"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5iqqY3199796
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B2KaNJ7wQbTV8z+VB/6ohB5R61JdVKBpxz4P1XelljE=; b=itQNes7SuhvrpSgM
	QxK+ZJM48IH0QA7NsuIK/9Z/p89bx+RrUeC9VASU++5Y8hEXp9RCwntEOaVcTsZ3
	icnEdq7qkxCX3yXiQe4ipF84x67nLAZoayguq6Zaq7pi0K6lbwUjd2bQek4jJtu0
	miSzSJlJnoW5Oj/lClq2E+kJFu1fi8xN+DxHSWyYUX7VnJKXtxHG9gmMuvzsL7CW
	PJyswY492TE67Fm4I/ROtg1ovYUUl7Ngi45F11K9Kss/BW4gHVDXI7ZDWSJyw2tx
	Xc8BWR5VwcvrXZmrfFVauAuAr/Ep/LBwTsokdX/m43+mefeEGUl7HsAxtjp4f9M0
	A6g+gQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qtynn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36641bb3d97so5740254a91.3
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844238; x=1779449038; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2KaNJ7wQbTV8z+VB/6ohB5R61JdVKBpxz4P1XelljE=;
        b=epSBh/S5YO+8jif+DE1stPsXF1a0S/3XtUrgIzvaG+M6Srvf0ct5vja/NMr5MEFn+Z
         a2Da9VACdYB+QHmAhaDm9HKcFs24KLVXcKuOV36EtcedwypK9MDuYfR5xMgOIiGwKaCZ
         ypa36IFy5Xn8PJZzkQBpG2R6FUqTk9NxioIH5PtG7pNho9Gcpa/MgGQzjiJmsVmkBUEM
         bFNq/G+15Q4ZaZBXCMGfuIFbq5xY4iZDx1yucQBTl/sGDHZZpaOyMLURCjDS7AU/X1P4
         4D2b1LIXPZcqSo5u7DY6L+N5nd2w/MvKd7k2z4SQA+nolqFpp2HWpNEZnj4beSmiHJS4
         f3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844238; x=1779449038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B2KaNJ7wQbTV8z+VB/6ohB5R61JdVKBpxz4P1XelljE=;
        b=jRR0lezmrS+WIGr4C8zZHlz5xTDgL6B8Xl8C0mgRlyXgQAKT+cY1jOKuzFHwHz88Tu
         IHpskvuxRdiag5NOO82jbzyyU4jge7wAgct9Aw2Cz8ccUNdEladywROawMgasSdb0mXI
         TyMOnYx37VeX4vK40tNbnGZDA+upxbvorVE69Pb79gHjj6vFGYqoR9Elu4tVWYlmCHvk
         ENZAO9574Azp2Zy7BTfHSqTJ54mAdmNA8ueOomYdiyCOA0YELaJYorNqowxegN3dJHNC
         skEkRPAKVU4GRfCRuAN6f8fzHGcXaBHNjOy8xS1D3G9ag/9n/7/zd+D36NHRCVmoBAVX
         dGCw==
X-Forwarded-Encrypted: i=1; AFNElJ/8WV1dOVpO2+VkCFkx0NjYjfqSxlI7A5xuLUi0mHyDlTMtgYyp4+ISZLq/J0XVZ/PTZ9UDCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywbt5mUrklRV+voSjN51ZAarqMsSYkhQpUB5hKL+5+/K+bvT9cW
	YdJpGOolhmuAGYyS1vMUUi9yMcMsvtexgy2I9q+NK4m6/DpE8vInRMBwxKlmQSziNwpxFuGuUs+
	ks6nKKQiw8LWHRhWbCcEuzmj06qH/Rg/5SP40Yl84KqPmRlDmSc8B38Ycgg==
X-Gm-Gg: Acq92OHdQSsL5tOHnouBdohR9ovkbTuUsirh4FYpMj2Elqvgikv9+9KIH2pFBXUpoYi
	XZCKCz8QpIVp6DOL3i2jn8gaxTFoPCpICfEaAaZRMdVeGc1YYlnT4jENKA+eLBwp6bdDL1g3qhn
	t7okFw/J87yar5B5UhCYuITXxVkdEjPY+VjJj7bpKqEqRYw0OywfNW4QjJRZOr3dGP8C6BEWAYx
	9YtIH9FLHI4g6IdkE3wj8/SBXC2DbbVutuammSMMYsRi4wx1AtFjRmuDO1d+Bq8+inH9tytTRUg
	tNnn0+US2U7B8GY6LKIivvv6JtqUF+V7UtJZBFF2sn3DeoZNfg9u2H2XG2iItzz2qCYBqlm4wOW
	PpED+uRFaSQeebNDJ28sypbrJJzwurbIy7M7P5x6DSZbCaTn0mWMfmF0=
X-Received: by 2002:a17:90b:2742:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36951b82f8fmr3535772a91.15.1778844238201;
        Fri, 15 May 2026 04:23:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2742:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36951b82f8fmr3535721a91.15.1778844237623;
        Fri, 15 May 2026 04:23:57 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:23:57 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:20 +0530
Subject: [PATCH v6 05/14] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-5-f6a99cb43a24@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
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
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=7497;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=EeIAZMRmgVmSK/Y4l2hVRqTqYGOuHpZ+loERcUpLJ1g=;
 b=WQ+LE7PjKkMsIjWqAIkBhVmdS4sqY5ZJMsSgCLXJqnXUhtgoBYEJgWF7CZ0FY5eR6sIXTsIr/
 TQfAdn5iu91A5xE4QaJcFgORmhUA0u780rGEreGywYbdOeU64zKDY2i
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=HbkkiCE8 c=1 sm=1 tr=0 ts=6a07024e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=1OCxxfDL7RIz13hN0lYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: OrZeQW2BviclQp7pg6dEF_9IjlQrGYI1
X-Proofpoint-ORIG-GUID: OrZeQW2BviclQp7pg6dEF_9IjlQrGYI1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX/c7j2tdl1AB3
 XSndMF3Y2ZCtAdHBaRDNoyYNUKuVlcBE202lZD5pN49J8TlOgePQzYzZG2ug/bXrmIPmogbc34b
 JQQVKCSdnrl6UZJl4lFJcSLzd8copTTXaQ/rXnESAKJKYCO1VWzlZ/5L3D75eP69uDOPYFE95f+
 Igdzk+R+rYs3ghogAIABKKCj+49cG1cYhONdjq0ImswB+b3fwRVPBhKY8peB30e39vxOZxQ7d/E
 a/KunUzdO7z9tuHvDKUqJvglslTtUs/tTM6a49aS8UBEyMUnSinbvh8GbPZt04zFZVnu3Q0KwYx
 Qb4Q5yAM10VnMnT+7dnR4YgCRw9MPuxNyRxA4EKuBnv4Q5uB1U5CggvIaHjKCCHYuoilyvkQ3se
 QFi3sLKAHYUAOCiq7VSlxyYPVbhP1R1TEM4HtdGP4z3oQNpw1OGjzjgrNPl4RoqQYSCfdtM8JWl
 N+ty+z5ChFu+RNAj/ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

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

