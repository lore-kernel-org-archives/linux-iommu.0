Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1B3DD529
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964452; cv=none; b=uP91z3PSRqkp3AFl9Ttxu49dCQqPw726eSygaSw0+8QsUaAl1uTuUMfKxJnuzfFEjjnVzGTdKyAZDqe6f9NOPrzG3Z5L62JAZicl67KUBNAdDvPK8D0lrRFjuEYP4mInBA2hn0nh35Ga2GNYxdcgSnzQUK2i+WG/lCJHVkVZeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964452; c=relaxed/simple;
	bh=haVptpgq27xoiy5H+ghFCWo2lm0Cu97MuoRlma08mjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rkwz033OOuTR/fP+xYb33UPxNyL9YoiILGghnKphlqH55b7nM9ZRqxKwD46USUodtTMNSTW/79cVNqVzKrZPksu3mfRlEb3A1HBaIfp7fF5gKS0WxpOY9n0+hySX5i77GgR5fz4eXyJzhNlIbbbR0lesadEJAXjTs5NDaCDDFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hMGiYZgV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QmqYImA/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hMGiYZgV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QmqYImA/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456h4gC3467601
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 07:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RTrt52egNPme2cgLBNhr7G7/5o5IRugC+NSDZDNUkq0=; b=hMGiYZgVRzlLM5re
	EWl1vOVARYnltt3r26HnMW1xGYcNJ1XUKURvFr10miEPXmjDieegVRFp2qVkZadn
	9f0/DoXHJ1AiwJ/h6XbZ3aHFvIrBEvLDHbs9UEu3vLY3P2ybtSJ/ZAFFBUMzPD1y
	+F1sKGusrTjwCnAgcg8O021nKdPhpSEwuS8csbWPFNxdTSMqJIYw6vrKdBnQOM93
	lzebNuBHIlRok8m+x93X4cl+2Oy9JMDM2GW9937UYZzNKbO8LGiHzx2adskZzaQg
	2BSaPrZ0ak15pQd291keStRGp5jKZjYq2K3A1kKiyDk6lMCaId+PnK5Bk7ahq0Fy
	A7XgyA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvtju6a6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 07:00:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35842aa350fso9354455a91.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964450; x=1778569250; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTrt52egNPme2cgLBNhr7G7/5o5IRugC+NSDZDNUkq0=;
        b=QmqYImA/YPptkvuNL/e5YQ+BJgZvxvk3eqjpcgM5HQJLzqcOOClzQGgp4PDoru5E5h
         80TY7kYSIgPNIZfsXrFOLfSB1Yq8U5Hz+dWpVRLfFoRb5WmS6ACGsFMVPfLzyGFiZpxn
         XXBaE0wOLdKsvYzU4VGcYVv/VwUUu6FcBlRBXboynWgA04vOS+s6Ch6zqlzzf1UvF9NN
         dDYnLJKbs9AKTs0JDN6HFbllTzdarjBdrWJipv1RRv13F+LfcbfcFmODgg+pThSSxz/1
         f5xKtAs488CLBq16d0CDGAcoBIt0ucFD1lx6vZtvQQIJZy7579yRIQHAfbMfUGioJ38L
         IofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964450; x=1778569250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RTrt52egNPme2cgLBNhr7G7/5o5IRugC+NSDZDNUkq0=;
        b=GAU3QnoCsLtd2nlwbrHLbssNgItOXqXzvYSJ/UDNkczzX8pioTdQxjBdZVslAXzYOa
         FSQfhcLmVb2rVzYlb0RROiNap4Ir8piXkNflq2dsjixjyQV8yyhv0O75Z9H8Foyc6wSH
         u7AW1muYFRYRRx/5o/uPgId4dfh+dLYiGD/0arTxh2CpKOOdl8pDcw9YUPEyMZDW9q/a
         +ZtYDwqNm691UtghnSqFFmO2sxTtmGAtVhsIpUJ68PY0Ovyd3jLg0LaUDaiHPdYrEJ/B
         CZpy4w+XgpD3fg34G6HQV2vAsFQzZ2dNGiqS9/c5+hJGmY+R8N3pWTx/pHFn4VCKvChb
         YZIA==
X-Forwarded-Encrypted: i=1; AFNElJ8jrGBKiTIHl56FgBG6ZkYijOhybIL0Kae4VVGXQKQAwPSvs7N+ipazktfd/u/lmPEtZT0YDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNBIlBVqE6fKjQTzg5DAHfW133QBeVGsFt+W8xfLPQldH8c3lt
	PjT/ldrCs8HvW7UmnUK8yz8YuR3ums6k65uHCUAvbfj5QhqavlJ5hwZbnbKUa3x1BnEeiiuz++a
	X8n9NuNKrYhQDAo+4TTfyewib2qTlKC3kQiSy19p4nepIpEGzFlsxrWBFnw==
X-Gm-Gg: AeBDietsjrL3jnNrDaVtXkloRJeTjfZCzed6yuJutVUw3qUIQ1hd+Mz0r+Z21KkXefG
	XxJKGGjJBWDAVd3sCTtghiuV5Wt0HIFpgJd8MNWV1AvGGd0oNZe4jgi7i9E2oeapf3oEt4uL5sP
	ACbigmComSDXF2LNVaH/UqI3AZFTuPuCjH3SQeuxxP9fvNS4wnuRCC91MgVVOXp8s3Bx7b6HdWa
	m5t7QcYA8QdK/V2HUXYJbDhSI25omZAKZHAjTcOG2+nPNHJiFjoTpSsgwyUTsnZGMwgyvIE02MZ
	thaIXZeYNZbQilbJKM0cx7UinPq0WEwBjTzgNANzqOdXE8sbWm95PUDQT7uLqHpmLRcNDQPXB/8
	Qr1V/xIGd4MF9J9Wn6Rdt2S5V5w3Zrs8C6KXdtEGeVnwZexNftBqE+mBE//IPvH7vEg==
X-Received: by 2002:a17:90b:2f86:b0:35b:e593:b1d7 with SMTP id 98e67ed59e1d1-3650cdda08emr12089720a91.12.1777964448829;
        Tue, 05 May 2026 00:00:48 -0700 (PDT)
X-Received: by 2002:a17:90b:2f86:b0:35b:e593:b1d7 with SMTP id 98e67ed59e1d1-3650cdda08emr12089665a91.12.1777964447971;
        Tue, 05 May 2026 00:00:47 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:00:47 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:24 +0530
Subject: [PATCH v4 03/13] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-3-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=7373;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=haVptpgq27xoiy5H+ghFCWo2lm0Cu97MuoRlma08mjU=;
 b=bZy3G0h1U+GGLGRzzqWucm2z2f4HazszlWBN8ifukLxO6srlCJmuuKKlud7HiHRbUW3vCoKeB
 6QRPnOjseFnAEcNajLkVD/Oh6Okei1pzRlxEE2V7Fmqrb8Iuh0FLYUL
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: cyVX45He9Bdl4QTFeNL1JivdiLQelqGB
X-Authority-Analysis: v=2.4 cv=KuN9H2WN c=1 sm=1 tr=0 ts=69f995a2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=UwTKh30HLDACofytdwoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MyBTYWx0ZWRfX1taMVPeQzu24
 L7xMDyOUUq1N8iB+zBjloF2+RzZf4GJixo6uyZG5rv9YmXMQqTw8SjsUTU39HFt++MUGVOFPuY9
 kd6snqzhxwhIqVNJGw25PN46sNTne/ujBYz3JbK46/myUOpop5ccrJPrWMCcL7QJygLE6bnh9pX
 BmQUfOIhOPamI9ICChRF/OFBt4bS1xPI+IET47MCWTlDLKtniiXWS5McRMrHA1tTWm3Tod3xq23
 LKSYtef58dv5Wxzm5eQusl/939ny/CFkf0DYi3cRPQGAKMFvGKQxRMTu/CrR/O3QTx0B4AeqcR2
 CloVkGhemPpYCg/uLCz6ta+ycz3DzutgbGBdjLCGFAna6KQ++HpjD/qL6w4YukpkwKDvYCJWe0G
 5GrRtua0N+LtpYAsuYjBk78Vo2eVh29S6HJGTUrVCCtEEPjYU4/kxmzloaAgOs6GhNmOB821h4P
 VBQCJTLwKvqCQn7KA9g==
X-Proofpoint-ORIG-GUID: cyVX45He9Bdl4QTFeNL1JivdiLQelqGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050063

Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
is a new generation of video IP that introduces a dual-core architecture.
The second core brings its own power domain, clocks, and reset lines,
requiring additional power domains and clocks in the power sequence.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../bindings/media/qcom,glymur-iris.yaml           | 205 +++++++++++++++++++++
 include/dt-bindings/media/qcom,glymur-iris.h       |  11 ++
 2 files changed, 216 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
new file mode 100644
index 000000000000..8ff02c302b07
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
@@ -0,0 +1,205 @@
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
+  - dma-coherent
+  - interconnects
+  - interconnect-names
+  - iommus
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

