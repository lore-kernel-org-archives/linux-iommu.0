Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5F3358CA
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430398; cv=none; b=njaX/uNnmlF27fZxTRAj/+ikPKG9Yu4GZq4BT2+v6Lx2idRCNr3nLzLGzsPNfUMk6HqifkQyHRqhJ2Crizz7BrnXcZvL8IPQT6kMU9oeazIQOSqUwU3wCi5q8413xSGeKwhRGfRE/Hk8CjFkubW+1HpP+DVHGpQFV6qn88XMxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430398; c=relaxed/simple;
	bh=tGKS4T92lrECaZQhadjFHBGpVn6bF3J4R7FWoMwtElw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZgok2LfGH5Q4uMWGCNO3XHLQ3gkuEjid36P9csjosQGv6FWZjbh3F/992cjlnKDbyYBR7hRnxh8D5MXIq/J4JT3eBQB/MdfmGBSbiuM/U+SD2U3ttNeYh9rPoni02rqgEitOUWvi8YQErYfEb4yHwGA8HgHYHkAC53XbCbE4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTzoS6v3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cCcRzBsh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTzoS6v3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cCcRzBsh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q8Oo5h493215
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FF5H5bV09c8fWN0vXsZAWtIwWT18Rthxv0eooXBFjfg=; b=NTzoS6v3tklV6okW
	LzTIumiqL8VsrxFjva+FQq9IHp90VjaBkXi2O/JrnWBfTszXTR4OW7/gvQDYvMWY
	565ecqM4KbpKAVa1R2z+IauMd2yO5aFFor3ZX+bxLDBWYvcBn1tHBfEaciURz7EX
	bhSg9LjdwSw63UL+swldLTsOwKlgxHU8CHC1K7FK6pUstGLkl676Gi8QrzeEC2Wv
	muWC1CxkmQGV2ex0YhpORiPpRpf2hsYECp0HhfMsjc3yBZMQ8d0tBIvMTS9Nb5tj
	+VpltIidUmqKNdYHMsnrHBkS7BwpnrWLxxkJiXCb6mQRawsFOFoRrai6QiF72CQO
	uh5jJQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq6uvfd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:26:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6133262e4eso2494523a12.2
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 04:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769430394; x=1770035194; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF5H5bV09c8fWN0vXsZAWtIwWT18Rthxv0eooXBFjfg=;
        b=cCcRzBshjltTmxz4JO7/Lb60v8J0JcZbs8UhLC7xCFwFxtfNV1mNbu/pvTBXMsDTLr
         E1HczafzZyZLuLs19fD/T56dyb3moktgwN9NXxoCwrwviKgTHtssOpB0G5rCTnsJJlue
         ezHA/S8dUDVsIq0ThYaYqpGcOxtjMc7ZD0NJOC4dMKJ2vPcHTqWm9RHuJz9okU2IG0IW
         ibS5XKqpI0KyuiXFRFR6XM7dUZGxM7lMqWljsWgNrXnjYxLqu1k9IVUYDep+n0v10pAw
         vpo0v2tNDxYiAVv4NEidCMWhcxkE2BT88g5Lme6gvCSM/iP2Ht7u3G7+i4el7waIYcSR
         C4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430394; x=1770035194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FF5H5bV09c8fWN0vXsZAWtIwWT18Rthxv0eooXBFjfg=;
        b=OlirNsN3L98xGtIvbDs6wg5EruMLTXGm4Gz2GPACxfBeKR8G1X+FEqj72OqIIo3xjr
         JCvSp8Qi2FFKq/rJDtxmVnnnTLfOPaQPqjBz9yojR1OVWoH25ucovXgLYlbI6S1A5eHi
         7BkQBKXElAow2/97ioqLCEOK37lZuAgrQNyw5hO0kaKnRyZtMHugWyT6NSFxAwwbIQ6A
         CWDV+FSaNKAEMJLIoEZKkKs42vTREpfj4RcRThYyADg4tzE7PlxMZ9A+oKGwpPKB0qeA
         WwOjyq8sYNsT1z9zH1OmJKgSsMKhe1P6xnKGGXXl0vFWIC82houuGXZ+21t3OFhda5Xc
         MAjA==
X-Forwarded-Encrypted: i=1; AJvYcCW7noc3UGqmM2u7h7sphw/heEqUshbUvAjqQy/b9mey6ID3yVUGXxY7KXeIkQNLylpV49o8WQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrlD3tZSaKK12p91WjTG8n95kzZfLTO7VFaTwij6X2nrEQcFVs
	DgpLEyfpxzymun2YP6VHRyu5Oa/ENCwIDrne8uBQkgBb4OFRomAA8AQGOkbL/zYoWwyL8an0FS6
	a2a/XT0HvUFxxrk/ODjNeyS4easVWDVDN5Zgl8134u/77O0wR/fHbONt06w==
X-Gm-Gg: AZuq6aK7L/difRwJ2AGz6javV2tuFsUeXk2AroqLCq9i/4jzo/sjCO0PaZc4nqKEvfJ
	7QGrmqeuPc3s+0ftnpvNw8D1bQKKU7vW2RT5tLhiTPZNswxjmG7LqadLqygjm3k+rp22zI73NTB
	ORp2XtoszHBgs2/HKo6rOn967zNtFH+oU6HC9jsxgn7BxLPn1uIvzlXbBSs+oFMU0buisBJOqFi
	E9dt3KGwvQ7sjMnFysmM0siBrZ5AtOYq9WYXI2KcotH5AkoTCdgANLjt0LtRiJgE6WpomqtsM5c
	xdKpAbH0CJZLrvfWbtSWODwDyc3bcb7o/tEJhZArVRvZAtRYGcdzXeLBwaCJ3g/kpwWFKhvpkFo
	Hwu5LRQ4jkT9HzdKaiFnwolfUUXV5Zghdtwl9p7C0DE7W
X-Received: by 2002:a05:6a20:1604:b0:38b:dea2:fd0f with SMTP id adf61e73a8af0-38e9f11003dmr4162613637.21.1769430394400;
        Mon, 26 Jan 2026 04:26:34 -0800 (PST)
X-Received: by 2002:a05:6a20:1604:b0:38b:dea2:fd0f with SMTP id adf61e73a8af0-38e9f11003dmr4162586637.21.1769430393880;
        Mon, 26 Jan 2026 04:26:33 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6366644379sm6076022a12.33.2026.01.26.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 04:26:33 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 17:55:44 +0530
Subject: [PATCH 1/7] media: dt-bindings: qcom-kaanapali-iris: Add kaanapali
 video codec binding
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-kaanapali-iris-v1-1-e2646246bfc1@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
In-Reply-To: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769430381; l=8103;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=tGKS4T92lrECaZQhadjFHBGpVn6bF3J4R7FWoMwtElw=;
 b=HROUZwon26Sdvm09gkLPN2Y/qqvNXRElUO31/tz+MRZ42SyMCtLkwrdGc9/zUdCk7umE9ZcoN
 n1zjijlJz/LCS2c68b6SZ1FNf0ub0jajPXEQkYMQO+4W5z5QCv6thVr
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwNSBTYWx0ZWRfX+WMAm+wOZPKX
 qMzmM0K+45OTVkuMFfQRP4dxujCkF9s/03Gne7LxO2dS6tKFY1ejgUn+j2c0IaHuqzAoasDC9+d
 5hfC1Zs31ywGLE+oEWogyPAH/F5aZzp1zcqJ6JzfacfIpKH7UpudbXK2g9QpOhcIBuGC/bpscAd
 DSvPMVoYigOyH50SREUesr4xcnAeM4TMEhPut11/mWFhyQ+5O5RfKpZHOTg6ZmU5IVbSFkUXipw
 yKgfcucTPYYnsB022pwjkIieN/qvvqbBLQHSafBqF521mLoVLlTrTVGjwkpWLQ3N2vFOaNlsMLK
 QvQrsohXiIo9J/wjUcmGh5Bk1zibeLOj2hg4WMISanQgHuFaF5wyo6N1tthCVZGis4MZhuz2d1c
 XStdCVkYIsTyjF5kOCrl94WOYpNU2PFH3uL6182cj/v+9PpJpmcLmM+SagmGaoj1M5JHVOd17Cy
 p2w9iX5QKDAHfxdQJ9w==
X-Authority-Analysis: v=2.4 cv=UqRu9uwB c=1 sm=1 tr=0 ts=69775d7b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=PIz1-sESaiOoqeWa7OYA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 3tp9UsQ72Sn8dXXiJkl5aGJEEyz4U-3F
X-Proofpoint-GUID: 3tp9UsQ72Sn8dXXiJkl5aGJEEyz4U-3F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601260105

Kaanapali SOC brings in the new generation of video IP i.e iris4. When
compared to previous generation, iris3x, it has,
- separate power domains for stream and pixel processing hardware blocks
  (bse and vpp).
- additional power domain for apv codec.
- power domains for individual pipes (VPPx).
- different clocks and reset lines.

iommu-map include all the different stream-ids which can be possibly
generated by vpu4 hardware.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../bindings/media/qcom,kaanapali-iris.yaml        | 234 +++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4ed2afacb19043a60cfd67c4492356b4adb81c3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
@@ -0,0 +1,234 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,kaanapali-iris.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Kaanapali Iris video encoder and decoder
+
+maintainers:
+  - Vikash Garodia <vikash.garodia@oss.qualcomm.com>
+  - Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
+
+description:
+  The iris video processing unit is a video encode and decode accelerator
+  present on Qualcomm Kaanapali SoC.
+
+properties:
+  compatible:
+    const: qcom,kaanapali-iris
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 10
+
+  clock-names:
+    items:
+      - const: iface
+      - const: core
+      - const: vcodec0_core
+      - const: iface1
+      - const: core_freerun
+      - const: vcodec0_core_freerun
+      - const: vcodec_bse
+      - const: vcodec_vpp0
+      - const: vcodec_vpp1
+      - const: vcodec_apv
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
+  iommu-map: true
+
+  memory-region:
+    maxItems: 1
+
+  operating-points-v2: true
+  opp-table:
+    type: object
+
+  power-domains:
+    maxItems: 7
+
+  power-domain-names:
+    items:
+      - const: venus
+      - const: vcodec0
+      - const: mxc
+      - const: mmcx
+      - const: vpp0
+      - const: vpp1
+      - const: apv
+
+  resets:
+    maxItems: 4
+
+  reset-names:
+    items:
+      - const: bus0
+      - const: bus1
+      - const: core
+      - const: vcodec0_core
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
+  - iommu-map
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
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    video-codec@2000000 {
+        compatible = "qcom,kaanapali-iris";
+        reg = <0x02000000 0xf0000>;
+
+        clocks = <&gcc_video_axi0_clk>,
+                 <&video_cc_mvs0c_clk>,
+                 <&video_cc_mvs0_clk>,
+                 <&gcc_video_axi1_clk>,
+                 <&video_cc_mvs0c_freerun_clk>,
+                 <&video_cc_mvs0_freerun_clk>,
+                 <&video_cc_mvs0b_clk>,
+                 <&video_cc_mvs0_vpp0_clk>,
+                 <&video_cc_mvs0_vpp1_clk>,
+                 <&video_cc_mvs0a_clk>;
+        clock-names = "iface",
+                      "core",
+                      "vcodec0_core",
+                      "iface1",
+                      "core_freerun",
+                      "vcodec0_core_freerun",
+                      "vcodec_bse",
+                      "vcodec_vpp0",
+                      "vcodec_vpp1",
+                      "vcodec_apv";
+
+        dma-coherent;
+
+        interconnects = <&gem_noc_master_appss_proc &config_noc_slave_venus_cfg>,
+                        <&mmss_noc_master_video_mvp &mc_virt_slave_ebi1>;
+        interconnect-names = "cpu-cfg",
+                             "video-mem";
+
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+        iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
+                    <0x100 &apps_smmu 0x1a20 0x0 0x1>,
+                    <0x100 &apps_smmu 0x1944 0x0 0x1>,
+                    <0x101 &apps_smmu 0x1943 0x0 0x1>,
+                    <0x200 &apps_smmu 0x1941 0x0 0x1>,
+                    <0x200 &apps_smmu 0x1a21 0x0 0x1>,
+                    <0x201 &apps_smmu 0x1945 0x0 0x1>,
+                    <0x202 &apps_smmu 0x1946 0x0 0x1>,
+                    <0x300 &apps_smmu 0x1a22 0x0 0x1>;
+
+        memory-region = <&video_mem>;
+
+        operating-points-v2 = <&iris_opp_table>;
+
+        power-domains = <&video_cc_mvs0c_gdsc>,
+                        <&video_cc_mvs0_gdsc>,
+                        <&rpmhpd RPMHPD_MXC>,
+                        <&rpmhpd RPMHPD_MMCX>,
+                        <&video_cc_mvs0_vpp0_gdsc>,
+                        <&video_cc_mvs0_vpp1_gdsc>,
+                        <&video_cc_mvs0a_gdsc>;
+        power-domain-names = "venus",
+                             "vcodec0",
+                             "mxc",
+                             "mmcx",
+                             "vpp0",
+                             "vpp1",
+                             "apv";
+
+        resets = <&gcc_video_axi0_clk_ares>,
+                 <&gcc_video_axi1_clk_ares>,
+                 <&video_cc_mvs0c_freerun_clk_ares>,
+                 <&video_cc_mvs0_freerun_clk_ares>;
+        reset-names = "bus0",
+                      "bus1",
+                      "core",
+                      "vcodec0_core";
+
+        iris_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-240000000 {
+                opp-hz = /bits/ 64 <240000000 240000000 240000000 360000000>;
+                required-opps = <&rpmhpd_opp_low_svs_d1>,
+                                <&rpmhpd_opp_low_svs_d1>;
+            };
+
+            opp-338000000 {
+                opp-hz = /bits/ 64 <338000000 338000000 338000000 507000000>;
+                required-opps = <&rpmhpd_opp_low_svs>,
+                                <&rpmhpd_opp_low_svs>;
+            };
+
+            opp-420000000 {
+                opp-hz = /bits/ 64 <420000000 420000000 420000000 630000000>;
+                required-opps = <&rpmhpd_opp_svs>,
+                                <&rpmhpd_opp_svs>;
+            };
+
+            opp-444000000 {
+                opp-hz = /bits/ 64 <444000000 444000000 444000000 666000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>,
+                                <&rpmhpd_opp_svs_l1>;
+            };
+
+            opp-533000000 {
+                opp-hz = /bits/ 64 <533000000 533000000 533000000 800000000>;
+                required-opps = <&rpmhpd_opp_nom>,
+                                <&rpmhpd_opp_nom>;
+            };
+
+            opp-630000000 {
+                opp-hz = /bits/ 64 <630000000 630000000 630000000 1104000000>;
+                required-opps = <&rpmhpd_opp_turbo>,
+                                <&rpmhpd_opp_turbo>;
+            };
+
+            opp-800000000 {
+                opp-hz = /bits/ 64 <800000000 630000000 630000000 1260000000>;
+                required-opps = <&rpmhpd_opp_turbo_l0>,
+                                <&rpmhpd_opp_turbo_l0>;
+            };
+
+            opp-1000000000 {
+                opp-hz = /bits/ 64 <1000000000 630000000 850000000 1260000000>;
+                required-opps = <&rpmhpd_opp_turbo_l1>,
+                                <&rpmhpd_opp_turbo_l1>;
+            };
+        };
+    };

-- 
2.34.1

