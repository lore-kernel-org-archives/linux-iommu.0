Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017FF37155
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349771; cv=none; b=LaYfbJLArXGcKqS6HKlqgSeJGXjB9d5A616E8qLVidV2pec87ooG+eEN5ErU5N9ZeRF4ZNe5wyiivBMkeZZeNah7wU3g5DquKg1Zv8XTK6tQXjGn1d91yAhhN7bh6gLhJ/7eAAmdZWJki62a82ICMdb0vyYPJj5JuN/eJpQuYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349771; c=relaxed/simple;
	bh=KHcmvINhJktJpppGgwULcqvLybPcSbgdTRhruWN1EGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOcCTr3o/dJVeg/9wNlpmF5Mu2FUIz+zQ6MwV0yQYtgsmsNEssvBEqvXabQSNOleoh+RGuEgHvql+3awXUa5gxNSQEGxPOreUo7XWS+xohFHwyWPLq2vkSY/Otm9V2xzlnBDxv0aDmWAOhTH4NiMrH1UlzOyDU5+55P+vsmxAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSkQT76K; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSkQT76K"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso2287235a12.1
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 05:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708349767; x=1708954567; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDFtd1C6W8+z/D4oBojXzEo0MFOHKoG2NOfGOeLFv6c=;
        b=sSkQT76KvEJaOTgPCX9MBwdBa4QRQC++IoA86IIEKVOdJhLIy6wZjbxtOJ0xuyLhEf
         y/4n0/RG+F19UzM2CC+wdSaTwsi2pP2AuK5S1elKpcRuN1xSMvz8u723tTIYco9IHzoB
         JxyFIFIiigFiv14K4uTGJzV7lIfwGO3CROnTfp8ec2KFreyq8nH6rYLuWUPgZ+SeewcU
         MTwPWUM/hQVNcCYHx3SRXZiwCtg2PJJj09ojB5dvbijD1VrvqnnDW+Xp74UqlRbfNPKg
         svaKtkJrx+ui77dvmHel7zoVeYY2w9GeRbyXmI6WVSp1BK/J/t4Fi/wt54D3xiJuLSPc
         ABIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708349767; x=1708954567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDFtd1C6W8+z/D4oBojXzEo0MFOHKoG2NOfGOeLFv6c=;
        b=wu8jSuO0pSlIKMEfQf8iftezhgBH5Is4AvwzpU2DNjVMiXL3TZMNYiTnSimRPBbz6q
         evvMs53GZyS/jOA6EcTHvRZkWCsWOesXX+Op4OmzhD58Wczfl2KNCWrrKlYU1iGHPFH9
         4FvVA/a+RdtyVI6lkKlMBa1FLNg7PDCTnhv04NzlmhPI4TsoDGke6PEg5eEw2PCsguMo
         a74yn1xrG///KxtH0dj89f60kXJRxvYYykdhULbijXtGp5BMB2npeNwLW9wu1aDa3f+3
         45EeDo9+hTAZfWhsN1rfLvfnsznnHUxFOzMwj57bta+bJCUL3z+PNpaxWMzxt/wqazfY
         vTjg==
X-Forwarded-Encrypted: i=1; AJvYcCXDBQGHWIAsTZbyPpPkQ06lgGyHnI9d9IRF8WdrrQcWKL5VrggPksAdoe9sBimbHjA5L8tzzvt+2DLzVWkoGGdDSuxMLpc=
X-Gm-Message-State: AOJu0Yz4PQCfYMeEoHwkW3ahsL/D3s37tQxbT24kfXURkFqS9oKBVpYo
	fAUK3E9ZxqpricpsQxEoXH94AAoYlfpkte+0xhDgYJPWMpPRjpHWTlOmhexNoP8=
X-Google-Smtp-Source: AGHT+IHcY/jmN1CahbTZpalD29/Injnjyxx742wPBMQHK911Hmm+agbpDEvGFC5DMtm4072JH0z4Dg==
X-Received: by 2002:aa7:d382:0:b0:564:69be:6e86 with SMTP id x2-20020aa7d382000000b0056469be6e86mr2364504edq.0.1708349767419;
        Mon, 19 Feb 2024 05:36:07 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm2900168edi.59.2024.02.19.05.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:36:07 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 19 Feb 2024 14:35:47 +0100
Subject: [PATCH 2/8] dt-bindings: clock: Add Qcom QCM2290 GPUCC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v1-2-d260fa854707@linaro.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708349759; l=3746;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KHcmvINhJktJpppGgwULcqvLybPcSbgdTRhruWN1EGg=;
 b=NaBvuZXGfNqiXM+yEApolRkCjYx+y/6MOaCnl4/saDR6RxS+H19AcURQQ3xL9s1DIJWPv3piV
 7kE09+GRuIVBIzkVJIDvLMhuz1i4zyjDATa4Q78cYVazSmKNUX6FuQw
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add device tree bindings for graphics clock controller for Qualcomm
Technology Inc's QCM2290 SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/clock/qcom,qcm2290-gpucc.yaml         | 76 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,qcm2290-gpucc.h     | 32 +++++++++
 2 files changed, 108 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
new file mode 100644
index 000000000000..a16cb7e87e26
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,qcm2290-gpucc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Graphics Clock & Reset Controller on QCM2290
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  Qualcomm graphics clock control module provides the clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also::
+    include/dt-bindings/clock/qcom,qcm2290-gpucc.h
+
+properties:
+  compatible:
+    - const: qcom,qcm2290-gpucc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AHB interface clock,
+      - description: SoC CXO clock
+      - description: GPLL0 main branch source
+      - description: GPLL0 div branch source
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@5990000 {
+            compatible = "qcom,qcm2290-gpucc";
+            reg = <0x0 0x05990000 0x0 0x9000>;
+            clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
+                     <&rpmcc RPM_SMD_XO_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+            power-domains = <&rpmpd QCM2290_VDDCX>;
+            required-opps = <&rpmpd_opp_low_svs>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+            #power-domain-cells = <1>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,qcm2290-gpucc.h b/include/dt-bindings/clock/qcom,qcm2290-gpucc.h
new file mode 100644
index 000000000000..7c76dd05278f
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,qcm2290-gpucc.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_QCM2290_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_QCM2290_H
+
+/* GPU_CC clocks */
+#define GPU_CC_AHB_CLK			0
+#define GPU_CC_CRC_AHB_CLK		1
+#define GPU_CC_CX_GFX3D_CLK		2
+#define GPU_CC_CX_GMU_CLK		3
+#define GPU_CC_CX_SNOC_DVM_CLK		4
+#define GPU_CC_CXO_AON_CLK		5
+#define GPU_CC_CXO_CLK			6
+#define GPU_CC_GMU_CLK_SRC		7
+#define GPU_CC_GX_GFX3D_CLK		8
+#define GPU_CC_GX_GFX3D_CLK_SRC		9
+#define GPU_CC_PLL0			10
+#define GPU_CC_SLEEP_CLK		11
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK	12
+
+/* Resets */
+#define GPU_GX_BCR			0
+
+/* GDSCs */
+#define GPU_CX_GDSC			0
+#define GPU_GX_GDSC			1
+
+#endif

-- 
2.43.2

