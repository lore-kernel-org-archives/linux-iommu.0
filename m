Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2EB286D5E
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045043; cv=none; b=Z3O9gVy032RcWvHK5WR+ftSIZyJGzX5UZeDqS3J5xS/mrSSLWWmRuhranO+bpbqyl2OHfbWgq85giWFitEo+AidlPbgEttraWqchtpT3nr6oDngoumj1NyfHYjUbGciNAnKYr56aAla5URKQb+vjDkGCWkQIyzXnGITIFfHfXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045043; c=relaxed/simple;
	bh=1LtcgFQre1URA/vBEgHnSf1Cl4CNgR+s5lXnrBq+ITw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBeggZngKscseOMuZcd3/KEyqE3g/yCl3WkHeSwIaG7kLr1BD4Xr/URQGnM/pPwQqjXBwef5EhBTVwQmuZxirqmustDpqOYYgCjl2PCgMzLUZJZDaUl3a/ywvvx/tuTA+fOjiECjvBRCpdSzaEb1nRSSvHwgM2lCWnHxvsJFZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R8gOHMaO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZaL1m9WH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R8gOHMaO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZaL1m9WH"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5RQW73959308
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PvynsP24NIPCCSbLPAo876X8cdGxa0GYKqGInuT+d7c=; b=R8gOHMaOcfqrUkW3
	3XnB3gubCqIzvMfvN1zx5fOVe+/YPDn0Yh4QjPg6QszNms8Ppxb4f9XQKjqd6Fxs
	ocJH4COsrmARHWKUXCskP188peCp7UYxe3e9REyU9h2w2wF9eInkgedCkCi7nV/x
	Fmtg/aWFkaRTUUA8Om4IIMfLXKLYHfBKrR/kXQFnnnXKgVt526ApMqdC4/Fss8Ec
	C/JhAVm8VNXSWQ+W72fWiZAMMprNTDqnzemYSFUYBv4GspwQdCGovMJleJh+P+aL
	ynl8om/cI3pGjhyNAf6q2P6Er/ZFZ8gDffQ9kAj82TTjSe4xZUb3teoHYWs94//n
	80sjtw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmjgn2pwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 05:50:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7049fa552so1059424a12.2
        for <iommu@lists.linux.dev>; Sat, 25 Jul 2026 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785045039; x=1785649839; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvynsP24NIPCCSbLPAo876X8cdGxa0GYKqGInuT+d7c=;
        b=ZaL1m9WHFvY2hEEJyk+aUpLbeyyxuKW8OI9WEHDRI609/8RNMdtI9KEBEohoLbE8hj
         2CfRYaa172oRjzTZA2NOqoe6dM7Amj6IkfgTF25iyRuy6DKL6VUd1qVeWXmjMSuUAi/4
         BZ9GiyAkLlhG8hifdXzw6iWM7/2oRklzXDOGg/7h82LPIs2vmmNLscyVdua0Zcn04ISC
         NUD6/xHSp4SRZhghLemRXIT/CCb4KOoDlAo8X9geBhUu8gW+5o9KoH2HF3JatxmPbHsT
         FJG64BcN7tVUsm/NTtE773bB0nkfUrIvxQsCu0Ih1g6CRccY0Jkzj8T8OVC8WxIYnm8N
         jeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045039; x=1785649839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PvynsP24NIPCCSbLPAo876X8cdGxa0GYKqGInuT+d7c=;
        b=WFQWgmHg8nfIqVZw4ubRRvDHnHyz8VPoNXgoIHOUNraTL2QtjvFNTopCKQi1k+GVtf
         yaGFzGaqXPVfYP5225iU8hUFq82IeA5WG0V6HZoOzVswBRTwfqvGQZHtAPn3ZUweCQ84
         Yi/Rc11peS6D98GJmQO2w8yg+wSt8m5wY2uxNAaPuGtJbYRv09FWAV2I9cFSNVZgg9Cs
         wM3be63qXV2o8vFPXrGHBSFz/YGcueuNztJ5QQRbthUWSWxhJxDjS0eEd0BEVq4nlxTm
         UUoIwZWlEUz+k3fYRDBQrVmo/Gl1QYpScSkYxHy3cueftEt6zF4Uk03qMl8N+cTbuQYZ
         kRiA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/zA6wnUy8XMAP7KD258n07RX3uhQmcD0WDm4jBDQeSybC2fcoRlPDSWU7QcUXfubIalWeMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbYnZ3pYpbjqo/Ii7FVEPE0K7C3tMAFVXvKvVLvfUZ5f6Va0co
	3O6CfT4FenXyZQphE1vsRIeSMJsHACHxEVIbtg6Nb1CjGid7F40WU+iK2s5Whc+Qcu028z+nsyH
	LzI/V59S9Kg3ov4thjpbww6V/hAGbXMKzob72xRYVFHNPWKewCgDrC9RuujYs+41EUQ==
X-Gm-Gg: AR+sD12O8pRiWC1N+sZioJrRGZHQM7AGtkCgdshrExqyvjNQfCItZcWv6otmlzhlZ2q
	//g63vdDi0Gfr4pXuKOBAyixDjDo00nzM7fS56WLkhaNW6DI1u8FsrgGyik+8YqiaNWEKzQy549
	eM25TbZS3O4/R3iH84qZ+ceQCXXc91NhQKRR1ipKMPmwfiBtI5s26S+EwVbWi7zQ/wXWlnY/8kH
	huzzFIh2XyjfottCWszxMHU0STrkYCef9PU3FGDjW1B840geSwjWDLPAvBYSD0xpooDzXUIExxi
	YzUq0+TXPCNTPdAM+1wZnsSmoFHaICUAzZKLv+zgWUGggzKtn73CsQCurL5rD4FEPO8XMQvwtbK
	GFyBQUMAhyYYHuIl1PewGU6KFrR1kyWPs5g==
X-Received: by 2002:a05:6a21:6494:b0:3c3:9aff:7a5b with SMTP id adf61e73a8af0-3c67df803fbmr3695659637.50.1785045039028;
        Sat, 25 Jul 2026 22:50:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:6494:b0:3c3:9aff:7a5b with SMTP id adf61e73a8af0-3c67df803fbmr3695635637.50.1785045038582;
        Sat, 25 Jul 2026 22:50:38 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm67106334c88.15.2026.07.25.22.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 22:50:38 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:19:31 +0530
Subject: [PATCH v10 01/14] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-glymur-v10-1-de451559e88b@oss.qualcomm.com>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
In-Reply-To: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045023; l=9324;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=1LtcgFQre1URA/vBEgHnSf1Cl4CNgR+s5lXnrBq+ITw=;
 b=/PDkKhZxgT9liBiidRBNV5AttNeBhUJPX4nae5uA3GwNiZrIbSytHG1HXtDBqpqVVBJxaYUTP
 7KkwOPJ41aDBNrQ4+VvfpbOyXqwg055ZxnvHSX44UwaYGsPxFkggjP6
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: Wxf6shBFhAe2e0is3Bgj1UZriZdmW6ox
X-Authority-Analysis: v=2.4 cv=HMHz0Itv c=1 sm=1 tr=0 ts=6a65a030 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=o-YURiciIQWsX3ptiuUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfX7B7G0xnr3ggX
 ghL3DLRZqfgVZtqVf0XSUWK5VhaI8V0n9FzJPX2UT/cfkB6jSpsHp0JJq+DNzEz3YIx8HRD6ztC
 tLLI6W+lGyu5xjAVhzoi6FtT808SH+h6c4RyhXwipXe6EkPfylbbZwZKE5Tu1ZuAEuf6cXS66wG
 Z/Gvagok/VfBL9GBXD9I7/cKiqxNxfjKQnmUKJy38Cw4jQbIO+54ekSE7Oyju61N+SDDzwnLdZ0
 n5RHBO9FQ1jTeBwBFgF1BXdE1eRCcWAWlACutkEi4afBBe1nkSD8HEMzZdeOzaNmQCXJSRqfPYB
 HuhRfOHmkjpAYNKmFRNMwknXIH8GzdqCZ2H6R0DlDQMMuYj3WpI4yyCkdrUVP1ER87O8URr5LtA
 xMgyIYMDFbCyGqji4hmnKeFHM9SHGmZx0pwk3DoWJ7oi045GEXxtm4BYBmrvZoJEsQV9ZIUmDC5
 Cm9rkLABWiWb3PXt5Yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA1NCBTYWx0ZWRfX87Uy6CCUYVD7
 8Uplh5YNJp1p2voXGlZ7r/JaCDfub6PkeG9GlR9hPiAyg84qpyiiwsL1apOfSikFu9/jgdM1dch
 XHqot++bw4y1NRTRJykMaEAkHuq66aU=
X-Proofpoint-ORIG-GUID: Wxf6shBFhAe2e0is3Bgj1UZriZdmW6ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260054

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

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../bindings/media/qcom,glymur-iris.yaml           | 257 +++++++++++++++++++++
 .../bindings/media/qcom,venus-common.yaml          |   8 +-
 2 files changed, 261 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
new file mode 100644
index 000000000000..1bb16206d859
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
@@ -0,0 +1,257 @@
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
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  non-pixel:
+    type: object
+    description:
+      Context bank for VPU non-pixel buffers, including compressed and internal buffers.
+    properties:
+      iommus:
+        maxItems: 3
+      memory-region:
+        maxItems: 1
+    required:
+      - iommus
+      - memory-region
+    additionalProperties: false
+
+  pixel:
+    type: object
+    description:
+      Context bank for VPU pixel buffers containing uncompressed video data.
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+    additionalProperties: false
+
+  video-firmware:
+    type: object
+    description:
+      Context bank for the VPU firmware processing domain.
+    properties:
+      iommus:
+        maxItems: 1
+    required:
+      - iommus
+    additionalProperties: false
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
+  - "#address-cells"
+  - "#size-cells"
+  - non-pixel
+  - pixel
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
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        non-pixel {
+            iommus = <&apps_smmu 0x1940 0x0000>,
+                     <&apps_smmu 0x1944 0x0000>,
+                     <&apps_smmu 0x19e0 0x0000>;
+            memory-region = <&iris_resv>;
+        };
+
+        pixel {
+            iommus = <&apps_smmu 0x1943 0x0000>;
+        };
+
+        video-firmware {
+            iommus = <&apps_smmu 0x19e2 0x0000>;
+        };
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

-- 
2.34.1

