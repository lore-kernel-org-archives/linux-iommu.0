Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7818C03B
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932578; cv=none; b=fx68BjWsqQbZ3UwZbA4n8nVkVoJiyh0lX2ntpYdzyclH8dstnq7k7MFlEUsKIAa/ryTHC0EyXQUf/8Qha9BJewo4ak/8P2UvP2X/o8sAU81wZsCIPszHuJ1hZ95ZoGgra0YlQI2DTEhGJjslPWYCO4/yxuJa6Tv7OVLqPjQbKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932578; c=relaxed/simple;
	bh=VfB9gJwKSkL78mMZ16Sd0RgaTvRJ7KCT53uxqzo9TzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0CFIANgXM0Fs6rn2rvuMi2xhyUMKQ0nAqkydPIVAv9Xu+DNrstK8oLXWHcuz2b3vUOTMoahrcyMTnCB4jKmOqBIZdAaCs0BoBt/QwjnuAB0CGfHCTLcCLUgllPdPC81LABF4KcumehkhehMdl9FSxpsPM9KtGyRlCQU9cWPJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j4Rfza94; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j4Rfza94"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGufGJ019923
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1sUbM2SvyfVJOsSLSsKL5IhU1OYw0ytKP1s5wBNpq2E=; b=j4Rfza94M7CTeQU1
	BzzlR9PSsL/xuxUi60bUdA0zYewVeh37UEbSpyNZRpkQxoZ7wYSZAxOBRob2xGHe
	XABk1WHgvNIV+SEl2YDbyxmR38tCgDo0r5Q/vciKw+u6atrrLLfPrqh4Sne/0IvW
	9LFJF5iFZ6lRIpLKgsihcEiogxRy4oQ+MEWMnnFOTWoQVcW7UO+xIBnwPy7PCvj5
	/QljtPTJ+VyKytSe0gDHwWnnmhYNhA0++/M+sDXxhDA9hV8sR4SWVD6HFcnCylVl
	XPJoihHY7YwJ/urrw3Xq87ad1WS18+Ga0kO2YomRes/Kb9HndwNWS6nQ9JBQWV4M
	dwuxFQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bts0k9e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c54e8ad9b3so507782485a.1
        for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 23:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932575; x=1742537375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sUbM2SvyfVJOsSLSsKL5IhU1OYw0ytKP1s5wBNpq2E=;
        b=GrT31StogNqKKKSmpq1Z0FyQX5i2mIRJL8c7NDxG0QHDzqtnnlSVB5bFjWkyzGDvVu
         5KP7GLY7vH5Baely41F41euFPsyV27T/cAHNH9BMrHjK4yLo45gAdYZgNtBdBs5RBeBR
         yCNCexhos34JoDe+3cQL7/wBfuwZHJVTlrSwN8yuFnpG2/jvbs+jE7TxlwD5RrOtmQoI
         M7P36UzHfim3XMn5KZOR3wu7bHrjjqj7AgLgYs+wpfgJMjYW4dHqLI67ctyoQzvDHJ8F
         DveLhN5BOn3zS3PTcAskALixen/UkX93w2OgUxqKSijxJFePmFLwQVSFAylFYI07rIrL
         NSvg==
X-Forwarded-Encrypted: i=1; AJvYcCXU0BpvFQBhKlM1USQ96usYPnT0W4Bft2jRXK4O8azOVeaSHA2oXraBolyar6e0+mOEt8A9pQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkEnKJ6iAmaeUmv31dMSA4bDuuoq+Qg7OSyeNLzVsvXJkYTXQL
	wnvN55uxQ3hoX3TzHZ5qTv1IW3qGLO3l8KT1htPa9JsH5j4SWfMZEgdCD2c4UbJIlA7/QtI3WaX
	ctKOSDJGYclost5F/lbREB/gb9cCwszDeR2jbcS9olJQvpP9UKtIZKw==
X-Gm-Gg: ASbGnctw9foGtUv68YmI+SawPIaXwhgeiS57dA9IvXRefxgfPsB1odcFLE5/IxO9vmU
	IVfe8rf4IhZGlp9HIcO2T49Ud3c3x6ehBxBbCWM87a9kenMuQLxjFoL1X2osebRXjgYevBP2/ag
	6Hli16Ewib7Brv6EBIsXpasxcWRjpkbx+cAkStcCT+euoEGCZCQKeq0inku5c1zscw6r4EYoMU1
	Za/EYxFCyJjEhlRb8KmB+0G8/9kQhUlgY4sVGs3ZP1e4rMFjFGTnEYk3+811zzhU/3jbI3ijOC2
	D6zyneI6TULHkcTqOwWxqjDaol/3unFZSelsdqMiYAUMjKzd9SCbO6btxqzsGAhZxg/BwZTVoqC
	XD/++lXiD+ZlQtbZyt7ZXkv1WRJL9
X-Received: by 2002:a05:620a:2450:b0:7c3:dbb2:9b2d with SMTP id af79cd13be357-7c5736e2b15mr833314085a.2.1741932574728;
        Thu, 13 Mar 2025 23:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiczPIzoLiw1K6MLhP6jFTeQCsK8L+jcvk60VRCv8qzQ8LFkHt2oyl7Tx7neBgrwJKFvQFwg==
X-Received: by 2002:a05:620a:2450:b0:7c3:dbb2:9b2d with SMTP id af79cd13be357-7c5736e2b15mr833311185a.2.1741932574346;
        Thu, 13 Mar 2025 23:09:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864fc9sm416071e87.140.2025.03.13.23.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 23:09:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 08:09:09 +0200
Subject: [PATCH v2 05/10] dt-bindings: display/msm: Add Qualcomm SAR2130P
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sar2130p-display-v2-5-31fa4502a850@oss.qualcomm.com>
References: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
In-Reply-To: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14907;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mhVUBuasCeOBkqrxG/5PgGqIfKxDHldHx8QOIkjyyg4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn08gGEGhOStiAQ9q+BX0yTfKI7tEBx70wL+wF0
 ptm+zhx9HaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9PIBgAKCRCLPIo+Aiko
 1XNmB/wJnGQmTb/Ak7VdmPYDhhfv4SkYGL2YmjxdpyCYUlElGEopGPF1WuX8ggT3T8Tkiq5KbMW
 YCOEC+pBV/iiuxnK1HzE1vRt1aeVlTsG+1s7KQJZHQS2Z3naB5Fe59uoQ6O6dnBWNqKToDUszwv
 7F9hMweRha2T92o1yNM2N1eE0ccO/0zugQstJksubZOIojdEFJf/cH1tHdoTDJyJopg0jNQYK2f
 nrAK0Z8Nb1euurpgVOQENKpD5UngeI7Rf9MZu88OqpNUcQ1tx4+OJaGoHPxnhLFrg6Wrz+uSxRR
 2nwiT1N0ozwCThsNTzt1rmowZRgU1OLdWy3yTF+I03Si0qts
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: EhFGuSNtTxZzThLwOzCmx_2ANeTS8OlV
X-Authority-Analysis: v=2.4 cv=DNSP4zNb c=1 sm=1 tr=0 ts=67d3c81f cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=-YBHemuPtO_JcOlGpNkA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: EhFGuSNtTxZzThLwOzCmx_2ANeTS8OlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140047

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Describe the Mobile Display SubSystem (MDSS) device present on the
Qualcomm SAR2130P platform. It looks pretty close to SM8550 on the
system level. SAR2130P features two DSI hosts and single DisplayPort
controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,sar2130p-mdss.yaml   | 439 +++++++++++++++++++++
 1 file changed, 439 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..870144b53cec9d3e0892276e14b49b745d021879
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml
@@ -0,0 +1,439 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sar2130p-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SAR2130P Display MDSS
+
+maintainers:
+  - Dmitry Baryshkov <lumag@kernel.org>
+
+description:
+  SAR2310P MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
+  DPU display controller, DSI and DP interfaces etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sar2130p-mdss
+
+  clocks:
+    items:
+      - description: Display MDSS AHB
+      - description: Display AHB
+      - description: Display hf AXI
+      - description: Display core
+
+  iommus:
+    maxItems: 1
+
+  interconnects:
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
+
+  interconnect-names:
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,sar2130p-dpu
+
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          const: qcom,sar2130p-dp
+
+  "^dsi@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          const: qcom,sar2130p-dsi-ctrl
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,sar2130p-dsi-phy-5nm
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    #include <dt-bindings/phy/phy-qcom-qmp.h>
+
+    display-subsystem@ae00000 {
+        compatible = "qcom,sar2130p-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+
+        interconnects = <&mmss_noc_master_mdp &mc_virt_slave_ebi1>,
+                        <&gem_noc_master_appss_proc &config_noc_slave_display_cfg>;
+        interconnect-names = "mdp0-mem", "cpu-cfg";
+
+        resets = <&dispcc_disp_cc_mdss_core_bcr>;
+
+        power-domains = <&dispcc_mdss_gdsc>;
+
+        clocks = <&dispcc_disp_cc_mdss_ahb_clk>,
+                 <&gcc_gcc_disp_ahb_clk>,
+                 <&gcc_gcc_disp_hf_axi_clk>,
+                 <&dispcc_disp_cc_mdss_mdp_clk>;
+        clock-names = "iface", "bus", "nrt_bus", "core";
+
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        iommus = <&apps_smmu 0x1c00 0x2>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        display-controller@ae01000 {
+            compatible = "qcom,sar2130p-dpu";
+            reg = <0x0ae01000 0x8f000>,
+                  <0x0aeb0000 0x2008>;
+            reg-names = "mdp", "vbif";
+
+            clocks = <&gcc_gcc_disp_ahb_clk>,
+                     <&gcc_gcc_disp_hf_axi_clk>,
+                     <&dispcc_disp_cc_mdss_ahb_clk>,
+                     <&dispcc_disp_cc_mdss_mdp_lut_clk>,
+                     <&dispcc_disp_cc_mdss_mdp_clk>,
+                     <&dispcc_disp_cc_mdss_vsync_clk>;
+            clock-names = "bus",
+                          "nrt_bus",
+                          "iface",
+                          "lut",
+                          "core",
+                          "vsync";
+
+            assigned-clocks = <&dispcc_disp_cc_mdss_vsync_clk>;
+            assigned-clock-rates = <19200000>;
+
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    dpu_intf0_out: endpoint {
+                        remote-endpoint = <&mdss_dp0_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    dpu_intf1_out: endpoint {
+                        remote-endpoint = <&mdss_dsi0_in>;
+                    };
+                };
+
+                port@2 {
+                    reg = <2>;
+
+                    dpu_intf2_out: endpoint {
+                        remote-endpoint = <&mdss_dsi1_in>;
+                    };
+                };
+            };
+
+            mdp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-200000000 {
+                    opp-hz = /bits/ 64 <200000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-325000000 {
+                    opp-hz = /bits/ 64 <325000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-375000000 {
+                    opp-hz = /bits/ 64 <375000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-514000000 {
+                    opp-hz = /bits/ 64 <514000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+            };
+        };
+
+        displayport-controller@ae90000 {
+            compatible = "qcom,sar2130p-dp",
+                         "qcom,sm8350-dp";
+            reg = <0xae90000 0x200>,
+                  <0xae90200 0x200>,
+                  <0xae90400 0xc00>,
+                  <0xae91000 0x400>,
+                  <0xae91400 0x400>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <12>;
+            clocks = <&dispcc_disp_cc_mdss_ahb_clk>,
+                     <&dispcc_disp_cc_mdss_dptx0_aux_clk>,
+                     <&dispcc_disp_cc_mdss_dptx0_link_clk>,
+                     <&dispcc_disp_cc_mdss_dptx0_link_intf_clk>,
+                     <&dispcc_disp_cc_mdss_dptx0_pixel0_clk>;
+            clock-names = "core_iface",
+                          "core_aux",
+                          "ctrl_link",
+                          "ctrl_link_iface",
+                          "stream_pixel";
+
+            assigned-clocks = <&dispcc_disp_cc_mdss_dptx0_link_clk_src>,
+                              <&dispcc_disp_cc_mdss_dptx0_pixel0_clk_src>;
+            assigned-clock-parents = <&usb_dp_qmpphy_QMP_USB43DP_DP_LINK_CLK>,
+                                     <&usb_dp_qmpphy_QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+            phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
+            phy-names = "dp";
+
+            #sound-dai-cells = <0>;
+
+            operating-points-v2 = <&dp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    mdss_dp0_in: endpoint {
+                        remote-endpoint = <&dpu_intf0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    mdss_dp0_out: endpoint {
+                        remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+                    };
+                };
+        };
+
+        dp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-162000000 {
+                    opp-hz = /bits/ 64 <162000000>;
+                    required-opps = <&rpmhpd_opp_low_svs_d1>;
+                };
+
+                opp-270000000 {
+                    opp-hz = /bits/ 64 <270000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-540000000 {
+                    opp-hz = /bits/ 64 <540000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-810000000 {
+                    opp-hz = /bits/ 64 <810000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+            };
+        };
+
+        dsi@ae94000 {
+            compatible = "qcom,sar2130p-dsi-ctrl",
+                         "qcom,mdss-dsi-ctrl";
+            reg = <0x0ae94000 0x400>;
+            reg-names = "dsi_ctrl";
+
+            interrupt-parent = <&mdss>;
+            interrupts = <4>;
+
+            clocks = <&dispcc_disp_cc_mdss_byte0_clk>,
+                     <&dispcc_disp_cc_mdss_byte0_intf_clk>,
+                     <&dispcc_disp_cc_mdss_pclk0_clk>,
+                     <&dispcc_disp_cc_mdss_esc0_clk>,
+                     <&dispcc_disp_cc_mdss_ahb_clk>,
+                     <&gcc_gcc_disp_hf_axi_clk>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus";
+
+            assigned-clocks = <&dispcc_disp_cc_mdss_byte0_clk_src>,
+                              <&dispcc_disp_cc_mdss_pclk0_clk_src>;
+            assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+
+            operating-points-v2 = <&dsi_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            phys = <&mdss_dsi0_phy>;
+            phy-names = "dsi";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    mdss_dsi0_in: endpoint {
+                        remote-endpoint = <&dpu_intf1_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    mdss_dsi0_out: endpoint {
+                    };
+                };
+            };
+
+            dsi_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-187500000 {
+                    opp-hz = /bits/ 64 <187500000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-300000000 {
+                    opp-hz = /bits/ 64 <300000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-358000000 {
+                    opp-hz = /bits/ 64 <358000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+            };
+        };
+
+        mdss_dsi0_phy: phy@ae94400 {
+            compatible = "qcom,sar2130p-dsi-phy-5nm";
+            reg = <0x0ae95000 0x200>,
+                  <0x0ae95200 0x280>,
+                  <0x0ae95500 0x400>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            clocks = <&dispcc_disp_cc_mdss_ahb_clk>,
+                     <&rpmhcc_rpmh_cxo_clk>;
+            clock-names = "iface", "ref";
+        };
+
+        dsi@ae96000 {
+            compatible = "qcom,sar2130p-dsi-ctrl",
+                         "qcom,mdss-dsi-ctrl";
+            reg = <0x0ae96000 0x400>;
+            reg-names = "dsi_ctrl";
+
+            interrupt-parent = <&mdss>;
+            interrupts = <5>;
+
+            clocks = <&dispcc_disp_cc_mdss_byte1_clk>,
+                     <&dispcc_disp_cc_mdss_byte1_intf_clk>,
+                     <&dispcc_disp_cc_mdss_pclk1_clk>,
+                     <&dispcc_disp_cc_mdss_esc1_clk>,
+                     <&dispcc_disp_cc_mdss_ahb_clk>,
+                     <&gcc_gcc_disp_hf_axi_clk>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus";
+
+            assigned-clocks = <&dispcc_disp_cc_mdss_byte1_clk_src>,
+                              <&dispcc_disp_cc_mdss_pclk1_clk_src>;
+            assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
+
+            operating-points-v2 = <&dsi_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            phys = <&mdss_dsi1_phy>;
+            phy-names = "dsi";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    mdss_dsi1_in: endpoint {
+                        remote-endpoint = <&dpu_intf2_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    mdss_dsi1_out: endpoint {
+                    };
+                };
+            };
+        };
+
+        mdss_dsi1_phy: phy@ae97000 {
+            compatible = "qcom,sar2130p-dsi-phy-5nm";
+            reg = <0x0ae97000 0x200>,
+                  <0x0ae97200 0x280>,
+                  <0x0ae97500 0x400>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            clocks = <&dispcc_disp_cc_mdss_ahb_clk>,
+                     <&rpmhcc_rpmh_cxo_clk>;
+            clock-names = "iface", "ref";
+        };
+    };
+...

-- 
2.39.5

