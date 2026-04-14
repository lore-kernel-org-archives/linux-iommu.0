Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71D21638D
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142839; cv=none; b=T4HQIe7vhyM43tjd9gLYwNm2dRPB5tTr3/lge66Zf9k5OskMpFUmdPZ52BFZUf1Y44OhLdv25UBQxOQNeM4MDCMm/E/8XlxartJLE/pb8zHlswxS9I/Y/VhvQz/l3CAsFZlxSW+avqm+46g3Kh74iwzwLSJuVy/psfUatYJ6rRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142839; c=relaxed/simple;
	bh=+G8A9ery+s3UQR4ks8cuL74090Vvan1tS6zqjUU4Zrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApnSgF87eGX1UJ/m/9GtXtCklEowaVCQjfeMFngxLMtiRsXG/capcIaKgOaudCbAUq6veXFgJtR9bgdG2nnCUyyEgyE8wTBD4bLcqUMfcWbLQTmEDEQc5f4+fJIDic90CGTHPdqdcaGbKQaiS5IqsBGjEssunGmrx0f0U3Z4RtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=apcGzutO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hW+/41pC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="apcGzutO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hW+/41pC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLDiK43681775
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fKV/5f3Zwel3X0HBSamMpA4C9Dpr5+g/2xdz/loKqVQ=; b=apcGzutOoE2Vbx5N
	MqeP2A+WfN6Lu4A8/aXlHbG0SCvgqt/uvlBpGyk0cTSAcnscG2XrNFXSppUbWLnU
	PBmxJz/BKs6Gr4I4+lDU6ah30DqGAG7epR9rEDG+1unKxHev6f1TR9D6jJ6WzdFy
	r/t+teaOKRlIhnXMA2fM6wMafx4znIVUswDsB1fSkn5j0XKhPMaa9uBDsTfPSVR5
	CZqRHupdwqHBegVtmsJ2l+POgiBsYlr9R8hu//gNfVTufKQaiDY1Ef/pu3aeCzVU
	0P/v9Sz30ZaOdzP19Py8+H13SS2zpHgKkeuqjqHyB2j/NXD/njiD4zoq5eBueIHQ
	5qdR2Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87d121j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:00:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2ead99f5dso32990985ad.0
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 22:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776142836; x=1776747636; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKV/5f3Zwel3X0HBSamMpA4C9Dpr5+g/2xdz/loKqVQ=;
        b=hW+/41pCseW0kC+WuwsBd1p+McW/FdblGg/dNEnESoI9DExnbpw6ypZDjVj4MZJkK6
         Hnz57/H0fuf8SR8IfBHZCuBF5R1X+QsO/03ZMR3Lg8/omnEUUatf67OHvmXTv2xFEDFc
         TNL6K0moJH8f3/svLYoxpgvaBOzlSSzX/NV027pcAfxh3IRDsgRQSp5OX5XbbLNp1/Z+
         uYRmTTGs8Bu9Y+odyLFMMavkjlPLXpAC5Svn+vj+2oQdyFrCflqnqndVpyjLA0/vbvr7
         zKdT1drFe/Z2qm6QPl0ZKX8GUqqzNKR5WA+RH2a4rIs2OmBXiZE10MLzu1B7BihJXet5
         K1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142836; x=1776747636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fKV/5f3Zwel3X0HBSamMpA4C9Dpr5+g/2xdz/loKqVQ=;
        b=pyBMgMJBY8QhOjosGJ40nYUiPfx2AmeKVJLM6kH98yHwAgMbX0PgFqn4wP8mNvmiP/
         NNSfEhaYgYaB48KL2yaNRTXkzOwVXSLSAn47kWE6J0UQunuJzpIcSXRYrfMxgV3bBgxS
         M2Gpwl57yESDfjHE8kK+2x3zVYr7nxGResM2N4TdmrS1FMtUFYKLank2krOcVRckbEB7
         l/kFOsvrjR2Zxp1dognIcm940+yPMTwPTPrsmH48R1B44BXdYIddPOmBTsIKEokN9/Vd
         /pH2oKOwIIkbyuh9yX/+aIgzgQhBVlgmZUk4H+P9wlqOJTUogkYtS2QzmNS9S6HWdroe
         Pjxw==
X-Forwarded-Encrypted: i=1; AFNElJ/Xi2Ur2Qrb3YzR7HHEfSV6n3BS8ThLKLST9r41QzNDxPTpgMFHAZHC6MjUGE3oGQ71lgNRFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGQba3WPlZCwTrpqjO2Ad94Mx9xlRqZu580TJgV6xWNr3gjw8I
	m8HJVif6xu1yem/Df92nZV6CxK2UPRoJIQg0869wScIp0EmJB0BI2nAaYWHc9F7rb/aao/OH5bz
	1JAMSVwqd4lLy5+IAMeNuvJnoOaz62PV12m3YX8C76esnwgSxU52J0V6odQ==
X-Gm-Gg: AeBDiet4T+U2QdIP4bEs/PtjCQefTfpUml0UEDGCaMtKQwiipJAp4oKMaB85V+hZeth
	/y2o3N2k/Dj1Kkih8lKIGN5EXECZNsM7P28ybMsK8vlAICQCi1LxzcPaYfHdLPloE7AZRZt8wiD
	0Z0890nqToSdOTGGllp1sywfZ5KcqduLPIHB9Z1Z0rjlpmuWIobtIXald2r/hQNxDp71M2emS8c
	AP6mlqBRB8EA/XTa0+Vt6mKeMB6svXmUOmOnuxV3SQGmbXw9a1s871seODMWBBb7YL5AjHzgYec
	HvkA9mTkoctuv7OBfeVG1HTrdwW5h0fp8TDpwWmDvexskpUPUU14NANPSW4KUKMVsgrLXf8Fafc
	tCFoQnKd3Ifw626rUph8xpj+Egu5tnKXfeKIXW8WjLTTaoHRJ9dYKwBM=
X-Received: by 2002:a17:903:1d1:b0:2b2:5c31:24bf with SMTP id d9443c01a7336-2b2d59b838cmr173347495ad.19.1776142835799;
        Mon, 13 Apr 2026 22:00:35 -0700 (PDT)
X-Received: by 2002:a17:903:1d1:b0:2b2:5c31:24bf with SMTP id d9443c01a7336-2b2d59b838cmr173346045ad.19.1776142834257;
        Mon, 13 Apr 2026 22:00:34 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm134678425ad.3.2026.04.13.22.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:00:33 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:29:57 +0530
Subject: [PATCH 01/11] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-glymur-v1-1-7d3d1cf57b16@oss.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776142821; l=7566;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=+G8A9ery+s3UQR4ks8cuL74090Vvan1tS6zqjUU4Zrk=;
 b=XO1zeby/rN6i9PLEcVfWtA0m0CIuWGsMgjInqQlzFiOsTdjyiloYh9P4cjbtWRq/DqAw3dmE3
 c3nzQHxMEHqB8QMmy569IAuCmPBR1bLQH8lMu4YGlGuaWOfd7bbQZNB
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA0NCBTYWx0ZWRfX7GSuTUeTQbeM
 iwS3jTVodf2dabdtqQ2X3ShGVpvINCTR9rHx8TJ0dECFEeJXA30MyTIpJJAyHj+QZRmSw0h3xaq
 kSvZW/OfQY03/OY6cLelDlFoRBN7bKeci8ISGu8UpjuTGNQ2KKnn8pN4gSi/AfgMeJO5qtpqpU0
 qahgMXaAwzBwBpQF3N69wltKS9BbRB8DO9fdVmgJDMr36iQr+p/fyCDH2kOanSMi1yglyxz5KdZ
 9MtkvVCCDUn1dkHjtBfiPbHcNCPu6U21XnoFuFFkbE/k0i6jw/tEoB37QTlioIWqfD9be3c0UGo
 oVtWvrhdjulzfSAGb4exzEEb4KE6JPO+GvF4O9Nx4UEtc1IgdQ7l6v+YQpI/FJ294UqaJSegrme
 s77caBOkqMp0sHtw0Uio57IJa7soOaqf44+6oJ6vY6XkkgtPMzMbldIzG1WW6xJ9lvvBWSsL+gm
 LXsRjNSezznzfuXzcdA==
X-Authority-Analysis: v=2.4 cv=N+8Z0W9B c=1 sm=1 tr=0 ts=69ddc9f4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=17OVpTNTOV0qq6DYWkQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 1cq4_2SdzYv1gDEsRuOAmSvA2sx0DEwI
X-Proofpoint-ORIG-GUID: 1cq4_2SdzYv1gDEsRuOAmSvA2sx0DEwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140044

Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
is a new generation of video IP that introduces a dual-core architecture.
The second core brings its own power domain, clocks, and reset lines,
requiring additional power domains and clocks in the power sequence.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../bindings/media/qcom,glymur-iris.yaml           | 220 +++++++++++++++++++++
 include/dt-bindings/media/qcom,glymur-iris.h       |  11 ++
 2 files changed, 231 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
new file mode 100644
index 000000000000..10ee02cd1a7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
@@ -0,0 +1,220 @@
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
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 9
+
+  clock-names:
+    items:
+      - const: iface
+      - const: core
+      - const: vcodec0_core
+      - const: iface_ctrl
+      - const: core_freerun
+      - const: vcodec0_core_freerun
+      - const: iface1
+      - const: vcodec1_core
+      - const: vcodec1_core_freerun
+
+  dma-coherent: true
+
+  firmware-name:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: cpu-cfg
+      - const: video-mem
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 4
+
+  iommu-map:
+    maxItems: 1
+
+  memory-region:
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
+      - const: bus_ctrl
+      - const: core
+      - const: vcodec0_core
+      - const: bus1
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
+                      "iface_ctrl",
+                      "core_freerun",
+                      "vcodec0_core_freerun",
+                      "iface1",
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
+        iommu-map = <IRIS_FIRMWARE &apps_smmu 0x19e2 0x1>;
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
+                      "bus_ctrl",
+                      "core",
+                      "vcodec0_core",
+                      "bus1",
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
index 000000000000..5766db0b9247
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
+#define IRIS_FIRMWARE	0
+
+#endif

-- 
2.34.1

