Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514E37B7A
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:44:16 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b1b92845e1so41012101fa.0
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055455; x=1688647455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFoSdd2Ga9xo4OLf9TgzlJW0pxuOp7Br133fCLs+4A4=;
        b=ewzuy33YtuaRoEO4HVp+fyuSuGBUUXaysYn7UBCEdKthklZPcweRwaWrFgMyRWJVHH
         OClFG7uE7v6+xN/vHAjg96wymyeFKx25K8nAHFUCsR8ZvWNvnhSuzsJLwMiNqzunoS0u
         QWw3kmk8yak1QJw3R6we8JFTeWBX4TvhD2AmjTVq8BVsmQFMpYMBfyDWIvlWaltnyohI
         C9pWCV+in2/0e0AGGfJoT2dRhOhVTAGsSjlNIyZtzAG7x2ew8BJ1bYJsk4BWFBvD6GOT
         JfTyitQQ4a5mgfLj2zGVfrorSS+BH1/ABBGl4uGz2ruB/TLj9BCKSc8bhfNyvwbxFwJA
         +N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055455; x=1688647455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFoSdd2Ga9xo4OLf9TgzlJW0pxuOp7Br133fCLs+4A4=;
        b=Q2yjswGfkpk0qHOjspVycyDr82Iyn21zts3ReVImx4vfBK1kJyGNzl4hfNEkxtehmf
         Wp216LHEeuQPb+HKIA6KVb3ZNTX9+9GLvd01reIFAHrzDTkRIaxVI9wexpINuLmU4FKk
         sldMJG/6iz2nngh+NNJKNq7bpVQAjgKuua/hRPmefDR8OeOwgVFQS/KZNTpA3WsCAenw
         4V/BH4EY5b524QedJIB+5VqSFJqGbNQHbJvRw17eoF2LSNiyHY99rv/cbOBKrxnT3Xbk
         HcaAfRYzpWDtdOZZnB2N6GGHSYE3JwExcMS6H5JNzunw7Aq7Cd04fy70fkvPmMZJlQMm
         uJ5g==
X-Gm-Message-State: AC+VfDwLwU/SnqE6gWocePelBkVa2dgD7zzyfbEcUdvQPIFmSx3cgNkU
	+TxsMwNUlbrKo1R5anzynWCxdg==
X-Google-Smtp-Source: ACHHUZ5KgznT/7T7YvovXwVdlPLIVjVIF1CDZjMaRRLb78GoQJaNKzTja6DE+ZKaqYq/Tiu1ShLuMw==
X-Received: by 2002:a2e:914d:0:b0:2ac:8f73:1fac with SMTP id q13-20020a2e914d000000b002ac8f731facmr1320209ljg.46.1686055454947;
        Tue, 06 Jun 2023 05:44:14 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:14 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Jun 2023 14:43:56 +0200
Subject: [PATCH v6 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-5-dee6a882571b@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=7025;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=v7FiZ9/eBCtDRE+yhICmMVudEQ4vN3khQbvWcoX3vmU=;
 b=E5C/Y++7Ou1FHrGyzi5FSlm9ORMPTPxifHajsUXPfgD5d5QQXKQPU1T95UdAAkBLNs1AMqjGt
 V3PHOq2zGSeBGHPi4c11Tw7xc22CGG9Sa72FDF268SlUM7Mwi7Zk9kT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Document the SM6375 MDSS.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 215 +++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
new file mode 100644
index 000000000000..76369a4f7c4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
@@ -0,0 +1,215 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sm6375-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6375 Display MDSS
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description:
+  SM6375 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
+  like DPU display controller, DSI and DP interfaces etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm6375-mdss
+
+  clocks:
+    items:
+      - description: Display AHB clock from gcc
+      - description: Display AHB clock
+      - description: Display core clock
+
+  clock-names:
+    items:
+      - const: iface
+      - const: ahb
+      - const: core
+
+  iommus:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    maxItems: 2
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,sm6375-dpu
+
+  "^dsi@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        items:
+          - const: qcom,sm6375-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,sm6375-dsi-phy-7nm
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/clock/qcom,sm6375-gcc.h>
+    #include <dt-bindings/clock/qcom,sm6375-dispcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    display-subsystem@5e00000 {
+        compatible = "qcom,sm6375-mdss";
+        reg = <0x05e00000 0x1000>;
+        reg-names = "mdss";
+
+        power-domains = <&dispcc MDSS_GDSC>;
+
+        clocks = <&gcc GCC_DISP_AHB_CLK>,
+                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+        clock-names = "iface", "ahb", "core";
+
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        iommus = <&apps_smmu 0x820 0x2>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        display-controller@5e01000 {
+            compatible = "qcom,sm6375-dpu";
+            reg = <0x05e01000 0x8e030>,
+                  <0x05eb0000 0x2008>;
+            reg-names = "mdp", "vbif";
+
+            clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc DISP_CC_MDSS_ROT_CLK>,
+                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+                     <&gcc GCC_DISP_THROTTLE_CORE_CLK>;
+            clock-names = "bus",
+                          "iface",
+                          "rot",
+                          "lut",
+                          "core",
+                          "vsync",
+                          "throttle";
+
+            assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+            assigned-clock-rates = <19200000>;
+
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmpd SM6375_VDDCX>;
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
+                    dpu_intf1_out: endpoint {
+                        remote-endpoint = <&dsi0_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dpu_intf2_out: endpoint {
+                        remote-endpoint = <&dsi1_in>;
+                    };
+                };
+            };
+        };
+
+        dsi@5e94000 {
+            compatible = "qcom,sm6375-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+            reg = <0x05e94000 0x400>;
+            reg-names = "dsi_ctrl";
+
+            interrupt-parent = <&mdss>;
+            interrupts = <4>;
+
+            clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+                     <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+                     <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+                     <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&gcc GCC_DISP_HF_AXI_CLK>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus";
+
+            assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
+                              <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+            assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+
+            operating-points-v2 = <&dsi_opp_table>;
+            power-domains = <&rpmpd SM6375_VDDMX>;
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
+                    dsi0_in: endpoint {
+                        remote-endpoint = <&dpu_intf1_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dsi0_out: endpoint {
+                    };
+                };
+            };
+        };
+
+        mdss_dsi0_phy: phy@5e94400 {
+            compatible = "qcom,sm6375-dsi-phy-7nm";
+            reg = <0x05e94400 0x200>,
+                  <0x05e94600 0x280>,
+                  <0x05e94900 0x264>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&rpmcc RPM_SMD_XO_CLK_SRC>;
+            clock-names = "iface", "ref";
+        };
+    };
+...

-- 
2.40.1

