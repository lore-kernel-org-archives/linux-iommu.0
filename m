Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CD3D5672
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496439; cv=none; b=N28NSoLKGNrODNmvgM509mlbssJ30XPlMyzTxrp5L1wm1NOCqEA91z64fkAhUzn4Ab20hzB/4I6f3IMAV2BxbKspuF3Kd3cYKhtOwBn7D6vW4G3a25lsUEMY1XZ8DeqvYjU+uT8QKvWStjz0dmkxIjjE4NBxfHT7KVIiDASfk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496439; c=relaxed/simple;
	bh=7v80iys2y5h8NVocyNFzsPoJBWek2lbLTcxLamMtxWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2e+S65t2wwcvvOiGPz4xJzhUR7PWD6BpS7mzvEYqIyZ24NKeAzABdUj9CFT1OH7ydKy+8T0ZlaLXVfxqZY0/mk/fCHmuPKdfTj6yfyMX1jA5VAnTgT3WeO9OMVmM5uBNsbx/saRY2xnJ2QIAPplIRmItpMlR3J5jRKbwVQfAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCqT/cit; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NaI4C31l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCqT/cit";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NaI4C31l"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CZss5380669
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1mVnZa/wkDPRTu+I/PBz2v9E4SBWbwuBh4uYP+UgSe0=; b=eCqT/citJ9OtyHT5
	gh2vrZ3Hs+/MnZWy/VGEL1J0BEUDZBhtHMuA79TBF3kXqEDWA/KITh14Yqr4X96i
	YguJaq6X7+wQZ4vlD6k0wqlUS0+8DEiWSAmN0wTFSq+5v6bEQke1XFLFT2GSCv3W
	xVZzaFW1cwk3EGiBmCFkHqG7SSyShGH3KWFq4Fs3ZDOcUDj8m99rbbghF9BBfhWQ
	82Oi/xotiCw8kFR2jvUzK0pqWCLxB5PL4Eyp8PY7/I64ulzv98hBr9OO1bzlGti0
	0n5dFcHIZQhmQocQs03rJV9h/ybWVCeGVapq33jS1tVmDkLaevR+Bg9KNGG4Y6Fj
	+OsxPA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejewhsvn2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:20:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso40120955ad.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780496437; x=1781101237; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mVnZa/wkDPRTu+I/PBz2v9E4SBWbwuBh4uYP+UgSe0=;
        b=NaI4C31lWPFZKYQ/19MaFFZ0FFRPaseblI/s6kFrKBFifXr/Pl9h59IzVaP0/FUFHd
         KD/5dMWl2U2BVaFapIDmxzHYLGsy18kce483viqmUIVE8fp0NFiB0ki8moKROBwUhvEN
         epWG45Wo05i8GOFq3oIysU1gZ/qtwKX5BsLFwzfudA4jaj2h8uRFQE/bDwJM9SW4QHkF
         L+gqsCi2p9uJ3v9ixm1kNRKt22oX1qo1e+mrxTWCEjrkH/kfK3siL9x40Pg8XhjN3tTj
         qNFf+HEL3CkxfIwdNKlwLg8xuZS4vSZ+Gl9C1GesAB8nk/fDIU++WkyoDErGKXBhjyBL
         J3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496437; x=1781101237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1mVnZa/wkDPRTu+I/PBz2v9E4SBWbwuBh4uYP+UgSe0=;
        b=MeAZc6w9AkYUGSlQpnO3B4hcFIIjle9FvsUBsy9D650vxnajZj+dJlyMo8ZSP1t/Wg
         eMXaqwqGnQ9NFwqvC2OYUoFOwySfPnQlOBTjoylSsF/c98AN9lPoV31m/oQcL86WGj6J
         8lI/7PY2JvnHkeve5loAnf74kdlG9CuXiAVoPne6qCEQykdexfE+D2dpanj6f4r4ktlP
         7vgn8taeBQUsg0Dgye5Z/i/YiLj+dwJkym5IBHYR3xQp4AB5XxBUagOb7GZge0Mgp16u
         KHfE7CyPwi+F+N6fi7Adw1sB4aCYpYNXFWuqbWyxMvPKlDU1nCMXk89P4/Gl8pOkJM55
         6i7g==
X-Forwarded-Encrypted: i=1; AFNElJ8UfUzmDXzXQaXDgUVhVQF0PRg0HVlie9iP9/1cQNbXLwnlXGufJtThIOwKvreJuMKyxNPOyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7eGFul6I/si9319p1wdad8WpgVCQzT5Pby2rLMs9oeeMjn/6l
	yhMQuJAisS77qnedtJsctWFkgKhIT3FBZa5vu/colFTkWVNNtQOz6eAaiPLMYSovkJ5NXsrGyy+
	zstVFlVnM06/4lAej5SH4ch+ZFlZ/3vs0CtAvsBgDuCmHByxwdcT6YnhmzA==
X-Gm-Gg: Acq92OG6A54nZbqCFN/i8CtiXfPwXiiSdoX/Ekl8hb3oJcjorcIkUQhNW9znXzmNWjm
	CegTpc0FjmgO8XCQKZwGs5IXGJB7A8D5SMO6xZ1x6Afv3IOsMKFk3nnawZoqOV2aN1QAjVck23V
	eoKSKwuSbEZjEFn01iH8+eRCQINWs59tna93dCotDt3u2qe2WCzmHl50yD7ahLiHj8W3xmnBxDO
	PdGSylQ9XvCjlak3oPHjtLBTn1jpoj9f5uptOi/4k6CA9D0Afz5zZ4kjtmH+rJX94LEG4JcvW9r
	nwF67KDjRF6mdEbQ7P61AT9B1RPX0xumuPuqakFxKYAwueTwHVcgV927egS94GLyQWeEWAapLgr
	LPMg0iopWAJPsNz2DB4asb5lgaQHFoXoK1yuJcDaKJ6lRPeuRNimxLYxgopptviObjQ==
X-Received: by 2002:a17:902:e851:b0:2c0:d99a:2fc with SMTP id d9443c01a7336-2c1639eddffmr38928235ad.2.1780496436748;
        Wed, 03 Jun 2026 07:20:36 -0700 (PDT)
X-Received: by 2002:a17:902:e851:b0:2c0:d99a:2fc with SMTP id d9443c01a7336-2c1639eddffmr38927825ad.2.1780496436187;
        Wed, 03 Jun 2026 07:20:36 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm41514955ad.9.2026.06.03.07.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:20:35 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 19:48:41 +0530
Subject: [PATCH v7 03/12] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-glymur-v7-3-afaa55d11fe0@oss.qualcomm.com>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
In-Reply-To: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780496410; l=8936;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=7v80iys2y5h8NVocyNFzsPoJBWek2lbLTcxLamMtxWs=;
 b=At8fxvkKcyX0Z46+kYKOef2Mz9nHPpb2hQrCJklli6zw+A3oP1vztYwlSC33QgKxXTAvnWRuq
 Lotd1vLyiSEBWwdZ9vn/idWoznXlCJn+tBlqoLBSGmYLA9cJzjXp/Sh
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNyBTYWx0ZWRfXxllwmuBQBxaS
 nHkmHpsss/K4JtI/33Z9qZL64Q6+t/XyR5DMM50NM6ZmYkFisHSP5+28D8qA4pRXuBvxFL2OOEZ
 wpgPWTre9vW8PGu02Tw8EIsM1BWcsEXzdyu9BSN2OySlu2MaYxUMSEk8ETZEoqakkmxpTbSy9Og
 BTatQO1vSjIoHr7FYnzqqBPtTmOjJlgr9C5UL5FGKaIEs9Jz2SAiP8eDRRh1EvQnK/WB/oHR8PW
 RmPsAePA4iNkQ0qrNZgKttp9ydRD0i8qDh9OygnWfAmZBQDoAi5d0WfthcW8MTW62UVd1BXxo8I
 wOeYNO68pTixqXrgWWFoSMk+QefzE+IkEFYwlNOC/veUwVA4GaT5hYLaTXKpVWHjcubh6qWpM5Z
 ISLxpZNYL4T56xUh6dg3oD+OKjFxuHTebbHPL6wa7HVvGLqa3TUrwWdb1aOTaVwa2ctG51b2Z/e
 FWERQShNI+/3hLC+FYg==
X-Authority-Analysis: v=2.4 cv=Zewt8MVA c=1 sm=1 tr=0 ts=6a203835 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=OF-BzGz0GBlUsAOtOPIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: nE_RRuYPn7C7K7Ux8x6v1REXC3MXByqO
X-Proofpoint-ORIG-GUID: nE_RRuYPn7C7K7Ux8x6v1REXC3MXByqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030137

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

