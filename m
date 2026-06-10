Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D515376BF2
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073036; cv=none; b=soFKD+Q9KVlehvTq+/MRCeLLNQI6kFpO37rGa1CiuXq+hMB8ToHfoq55NyAwBfEbHCEGqqBz+2X3i1yX7mlGyC8f/LicrRacgv7aH1hkP6njbblPEDS1PHgL5hYHgF6tBJrHwHhQUbadxmwE0Ip1C3HjZyuw8xdOyaZOrKbAX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073036; c=relaxed/simple;
	bh=7v80iys2y5h8NVocyNFzsPoJBWek2lbLTcxLamMtxWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJnvJig/A/2zx7yDgfJp74MDc90PY6ae6q4DY3mxbRntMw+GJwOsujUrFc//wnXUHtoq1pYvIV6wngen32pONXl8dPvLJc5DOlpEABNQ3ClgwoKnizusb2Q1nFH9EPVCEY6eI4fvIRASlNDM1e6vebSmil5oo7nKZSV3kYKkZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nSPyg7l1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fG6iuJhJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nSPyg7l1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fG6iuJhJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A4WheY571712
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1mVnZa/wkDPRTu+I/PBz2v9E4SBWbwuBh4uYP+UgSe0=; b=nSPyg7l1z4GXPVTG
	2AIFutQDHYUJabvo7UbWsvbOUFv+CIhJdsO9TJHSSEJa5qwQHBjcGuJy9EsmuPXN
	SU1FrWigq7eo5/SeAvNKb76fYSQ6vuKlZVmARugbQtcZocuaGmfrV9ZkoIZAkIae
	ELiJH4uVH/a7W3/N57NeqexrmqEFfplGV5yogThyhSGf6l1HCFBrF3pSKtG9WLs3
	lJgzz8cK6zJXUrXDKlbO29kh46uOMBf6BdC4/PNvYMN1FSZC8dexZhn/NzWy7LVB
	sVrIl9nDwqCzEzlzkYkKmbKYTu4ST1yWVXno5IwU1Ds8wr0IYNnbBp9l0/FPW1FV
	DJIS+w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq10a8cnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 06:30:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so6413818a91.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781073029; x=1781677829; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mVnZa/wkDPRTu+I/PBz2v9E4SBWbwuBh4uYP+UgSe0=;
        b=fG6iuJhJhdDmcj4T7dMTjE8y+d56TQ5KBJY0I6c07PyPKvbPhYx7k3Rq/j1GAosBe4
         5nA8U+OQLxv1ysvfIuppX/33l40/MCbnRXUD4G6MLhtW5moqcwqkUFO14U3wW/KeuDV0
         ClN+uZWpUH2ZfuB8Ip0qNPGOIKrYTNGW0aXrICz+LPVUj/gNMhe6b+kPHh0TQDNE8hN5
         h5VC3ysQjiklwO5+cYiCpkfwUboe6CU51MEQFs3vCFKHGYHoTlLeF5FzWUNeCB1FSddg
         EJeb23CaFGaSZoqfwQ0dayTgpF0wWvBqn/Sr9j9Wpzx4F4V3vAI2eYC+W604aPxsfbTU
         YgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073029; x=1781677829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1mVnZa/wkDPRTu+I/PBz2v9E4SBWbwuBh4uYP+UgSe0=;
        b=WOYodHIWIB+2WW3YXyNCJhRbOX1Id6gq9xiI00srzVLkcSG0Do94n1QtZp7N0RPTkU
         SztlkB/1tgBcj+iZ1lkdf222syBXsAVRLqdtKYGy5GH5oi7tA5l30eR3D87SFIr0WSwE
         H+93b85NtHuxcdo5VRSOVWOzUKzPwLyAeFeC11qvqEgzbSYNGrPTH45azyWAAHvENfGy
         xq/x76WywcNrwWUrlxu0fwOYzpvrTNu8YKUCaTw4WCCkfUy5IrkB0UH7af1XqOQn5hVf
         sfTAlcg4sTqkgPUN7aURotbTPayeJwmwX3UJLqwFn1SskXA9nvhspZEfdH/zmslsdLaz
         liZA==
X-Forwarded-Encrypted: i=1; AFNElJ82nWdAkVYVe6d97GBpIPEHCsW0U6urWSh7jDXRVKhfdm6vYplMmjslzUMYCF3XfvMlQBc4IQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YycptVgdnWRq42CySkVc2h9EfTteGYXGQK5vsl4XfD1dTU3zQRo
	RrCtcaHjpBBzIgvkppaiy9GDmBSM8ogfyOvSpR7rzIWVsEYzc/pMQx+FDt/e/EQEn8x5uwbKvO/
	MGGdT98o8aMmbhBoyiY9FNxFKuzd3ubk0JRyKPAaISXt4+hpg2ZdJxGrUSA==
X-Gm-Gg: Acq92OH/TmNHqkZYPSzOhFr+bzinJ0sxPHNrqAAXFLgfNHlvZrxuiLJW9+NXM9Y5Gn9
	GBTVQnbR5i8Rp1n2vGF8gUlFowr86XGAmLqL1Cfkz6qeQLmdo1SVCXOEmKT9bwwTHYM6WOfwaAW
	WG0hHeWoUD7d0DJEh4b+19Ixa59TFMydYwEyhaJ4uIwAdsmO/n+fhgRblzsuHm/l48wqBKPS07g
	wJmUrtezVouBKy8Wn84BYPDMJWn6QVNcKp5MmFS8hfXc9DWAClqIdOYvSHXyidQPXCLa+RXp6yL
	cqIu5p/kC781NtNH/oeYw9+3k8mb6xx7oXZMdsgJAZNrquTiHAksW53Y6/sQr7w8TYhfYu7nkUq
	7wk3jUU6Lyko7HCp9jae43eM6qdlBTc3ymkdclIircktphXxISg88nGqCgGGW9R1H7A==
X-Received: by 2002:a17:90b:54c3:b0:36a:d6dd:9fee with SMTP id 98e67ed59e1d1-37520dc57d2mr7180272a91.12.1781073029074;
        Tue, 09 Jun 2026 23:30:29 -0700 (PDT)
X-Received: by 2002:a17:90b:54c3:b0:36a:d6dd:9fee with SMTP id 98e67ed59e1d1-37520dc57d2mr7180228a91.12.1781073028586;
        Tue, 09 Jun 2026 23:30:28 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a2892esm21580420a91.10.2026.06.09.23.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:30:28 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:59:39 +0530
Subject: [PATCH v8 03/12] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-glymur-v8-3-1c79b9d51fc0@oss.qualcomm.com>
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
In-Reply-To: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781073002; l=8936;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=7v80iys2y5h8NVocyNFzsPoJBWek2lbLTcxLamMtxWs=;
 b=a7MG02QoOCHcJGq57k1Df9k4wbzqwDlUEDSi5TsmENEM/Rft6JH+pPv7wt6nMUzu1Yfi0Hh1a
 8E5ATzPv0LyBRvoDgVtll/920JiXSi/aQoQARdry0jqQo0reKLnO20f
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=GoFyPE1C c=1 sm=1 tr=0 ts=6a290486 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=OF-BzGz0GBlUsAOtOPIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 1ujGJzfCDInaaaR_p9pBHe1fsU6mn0KC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1OSBTYWx0ZWRfX+XE6CmL6NPb9
 AnBD29Ou/C64to1aMuDoXRkUr2CLBSNdq+FTYLrhLmcS10n/3j7k1Gb5yPT1/X/8fcxSofL/SIr
 sGrAn5Tj/q8aP8HODKK4oK66b3yokYvMrlgS7Z8YF/lAc/ElO90yNR6QgyAbh6ieO+TxuodVBUL
 49bCgvwEnMOeOeWtTtOPvd5OT7zMOtpRlGsVgYjd0KutL6/pw99a6IMqAfeBmnHNENZA6z9mp0e
 EWPtsgq5EZ4cZMSWpGL+wNFOl4l2KqcTgqnU+1vgfexednJpBPzxwFFpDZa/IXYRGzyogj58Y7l
 bCqqqclStuPfQWTQf3oc+E3Y87+Z52xNkQSjXSkqTvf2LjbCw2jwAAN8RjZfKd/ShuZspeVenQx
 zA58O2A9ViFUaLZ0l5Tq3gRE0dEIRyqRb4lyKOea85ENdxYWGoiynS0gFuqDEAdM2or3bCUEfQ/
 vsMHnW8mXvNeHnqzxXQ==
X-Proofpoint-GUID: 1ujGJzfCDInaaaR_p9pBHe1fsU6mn0KC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100059

Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
is a new generation of video IP that introduces a dual-core architecture.
The second core brings its own power domain, clocks, and reset lines,
requiring additional power domains and clocks in the power sequence.

The current maxItems constraints for clocks and power-domains in the
common venus schema were sized for platforms available at the time of
authoring. The glymur platform introduces a dual core architecture
that requires more clocks and power domains, exceeding these limits.

Raise maxItems for clocks, clock-names, power-domains and
power-domain-names to accommodate the glymur platform.

The glymur platform-specific schema have fixed constraints for these
properties, so the common schema only acts as an upper bound.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../bindings/media/qcom,glymur-iris.yaml           | 208 +++++++++++++++++++++
 .../bindings/media/qcom,venus-common.yaml          |   8 +-
 include/dt-bindings/media/qcom,glymur-iris.h       |  11 ++
 3 files changed, 223 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
new file mode 100644
index 000000000000..a1c4a045291d
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
+      - const: core_iface
+      - const: core
+      - const: vcodec0_core
+      - const: vcodec0_iface
+      - const: core_freerun
+      - const: vcodec0_core_freerun
+      - const: vcodec1_iface
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
+      - const: core_bus
+      - const: vcodec0_bus
+      - const: core
+      - const: vcodec0_core
+      - const: vcodec1_bus
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
+        clocks = <&gcc_video_axi0c_clk>,
+                 <&videocc_mvs0c_clk>,
+                 <&videocc_mvs0_clk>,
+                 <&gcc_video_axi0_clk>,
+                 <&videocc_mvs0c_freerun_clk>,
+                 <&videocc_mvs0_freerun_clk>,
+                 <&gcc_video_axi1_clk>,
+                 <&videocc_mvs1_clk>,
+                 <&videocc_mvs1_freerun_clk>;
+        clock-names = "core_iface",
+                      "core",
+                      "vcodec0_core",
+                      "vcodec0_iface",
+                      "core_freerun",
+                      "vcodec0_core_freerun",
+                      "vcodec1_iface",
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
+        resets = <&gcc_video_axi0c_clk_ares>,
+                 <&gcc_video_axi0_clk_ares>,
+                 <&videocc_mvs0c_freerun_clk_ares>,
+                 <&videocc_mvs0_freerun_clk_ares>,
+                 <&gcc_video_axi1_clk_ares>,
+                 <&videocc_mvs1_freerun_clk_ares>;
+        reset-names = "core_bus",
+                      "vcodec0_bus",
+                      "core",
+                      "vcodec0_core",
+                      "vcodec1_bus",
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
index 59a3fde846d2..10716a93dd35 100644
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
 
 required:
   - reg
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

