Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66051261360
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820782; cv=none; b=alZwUt4iBSq2U74TAm4Mddq9uaECypYykVdC9EsqK637H3D98drtARenIOGPPk7A+uUsm0m/+D5glJyn7fOkrp9Y00y941Eo5PNMXGw7Wp9UgDtXB7AstNtCtO83eqpmiNweFH7KoASB46mbqwprz04G7yiPnKdCqzcVpwLel5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820782; c=relaxed/simple;
	bh=TMohEHJYtiKqK0QbIroGrKg9TkVJrqxKDbkvZhKqhrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGQkRnD6HAVhAcVd6AGo1KPgIS9reB83z6oOO+QCgxU2O3zAHYFRLdkU733sbZvomR86XHW7Pw5xrwd8HZCLwuVfCTtjZB0EzkSRp8scvXjLPj1qPtI47AFw2WlOfNbifRcC05mxLOzjbRNa+myjWJLgPpU8bRYIJKpVn6VkpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=baFglBqM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baFglBqM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bc21f831bso2602935e9.1
        for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820779; x=1743425579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0KdXJF27mp6zumhGhPwYMpFXFYh4NX8AS29XMRUS7KY=;
        b=baFglBqMPhA6wkH4jB1KpYeTr/TEuWESr7WK+MYwWvgzWFiOz+eK+nmPx9NduTSzwc
         7M8QQK1Clwg059FOw5S+z5oOCTCvyD+XuCLJ59QPZnDZaZ1a1YULqP/gZWbbhWalWXxB
         VLAFR0HU4BSIzwhHW0jMIB0o5qvQL3badp8PKh2fZ2hSlz9dzvnyoGu+Wfe4nm1fhSBM
         F4GiptDrLsV0i+ADdirwd34cssUFHye/agPc+lGXzl9bOuViXTcB52Ndl6AG0v1vV98x
         RT3fMXrBXyQMIiDzUSOWIgyt3UkHpJtBqkpoUVnSoxnA0qjygKPuYlywJUHMbN7mOwJo
         gLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820779; x=1743425579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KdXJF27mp6zumhGhPwYMpFXFYh4NX8AS29XMRUS7KY=;
        b=SnunP0X5MzvQX4idA7v0BWC6mbeORY6gGH0YoeKRtwLN8BOZt9cXUhk+Mj6vfHe6eu
         4QO7BrDNjSBTaFOqjpE735tVEmJpgoFZGLxAZVZBZu7Nc5bOZSb+71HAKEXOipcDdta2
         q5+ZqCnTTOnhfSl9LnpcuAP6HqIkYCxHftdnCRUGd0joxroAEkQZYxhEOvvGwx1kq13F
         Ll8gOPFennWuFYx/WxT6lg/E1D4R67ZxevKVERopqY0mKCG+7D89qM5j6bk2MLWSCPdx
         4GCo7H/4PsNGsnXqgjcBWcyKPebticz/0pYIXB3ce1kUoTYoDWdH1lUeECq+aZgF2JaZ
         bFWg==
X-Forwarded-Encrypted: i=1; AJvYcCUNHgRAgVZ7mw+GF/YdlVjmYa2eXi0wyILMqPlsK+KyQplYqNz5GuEsNDiCJ+aeZCmTG7BJuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYrdr/RP7kAxEpj7HAz7udU2Fivp0euabqlNU2y5wwSEiUbQxu
	Adp2KTBZabF1UI+n4DiZQ9X7rKFyw6wQuZoYOvcc8blnDcimE84XnIdgXnK8qdE=
X-Gm-Gg: ASbGncuxDjDRU8jNdF6N+t4Aqy53FxJEuwD32pewVeQtwG5mY8vo5cALey41cIPyXUV
	ABW5aBoKV3DylMwOq+oVo/DmbyOIXMLKBB6yucZQ5dEX4LNKZySbwkGe0PnyCCY1pUctx0o7ZzQ
	Le7aur3BJlefbMg3dGyYsu8iHqdv5AGJPVN1k+v5n7LAkj6nt0WoHbnIXReq/z043Y70LW1KaZu
	vAfCofEYvsMbyApkLsNRdonEIyNbaxHA1tgvXGikCdn71pT7fCBBOcVoqSXbUmdt7Ny0XLGlXkR
	9KrbsQtqeim/3U1PMVS0M9/GfH5hlnJ4VqhXB76KUEW9n8w+Mm12sd5HZw==
X-Google-Smtp-Source: AGHT+IHMYjwcP6IQLAQEeK4JGYmy7U3UUT8QxLTRI83cizBxKScOV+rOEFHkV2KbRv9UquSBZq4bDQ==
X-Received: by 2002:a05:600c:350b:b0:439:9909:c785 with SMTP id 5b1f17b1804b1-43d56dc2af2mr36266185e9.7.1742820778571;
        Mon, 24 Mar 2025 05:52:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efcb1sm11087576f8f.94.2025.03.24.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:52:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Heidelberg <david@ixit.cz>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iommu: Correct indentation and style in DTS example
Date: Mon, 24 Mar 2025 13:52:50 +0100
Message-ID: <20250324125250.82137-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.  While re-indenting, drop
unused labels.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../iommu/allwinner,sun50i-h6-iommu.yaml      |  24 ++--
 .../bindings/iommu/arm,smmu-v3.yaml           |  20 ++--
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 104 +++++++++---------
 .../bindings/iommu/mediatek,iommu.yaml        |  18 +--
 .../bindings/iommu/qcom,apq8064-iommu.yaml    |  20 ++--
 5 files changed, 92 insertions(+), 94 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml b/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
index a8409db4a3e3..ad51ace9ca09 100644
--- a/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
@@ -48,19 +48,19 @@ additionalProperties: false
 
 examples:
   - |
-      #include <dt-bindings/interrupt-controller/arm-gic.h>
-      #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
 
-      #include <dt-bindings/clock/sun50i-h6-ccu.h>
-      #include <dt-bindings/reset/sun50i-h6-ccu.h>
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
 
-      iommu: iommu@30f0000 {
-          compatible = "allwinner,sun50i-h6-iommu";
-          reg = <0x030f0000 0x10000>;
-          interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-          clocks = <&ccu CLK_BUS_IOMMU>;
-          resets = <&ccu RST_BUS_IOMMU>;
-          #iommu-cells = <1>;
-      };
+    iommu@30f0000 {
+        compatible = "allwinner,sun50i-h6-iommu";
+        reg = <0x030f0000 0x10000>;
+        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ccu CLK_BUS_IOMMU>;
+        resets = <&ccu RST_BUS_IOMMU>;
+        #iommu-cells = <1>;
+    };
 
 ...
diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 75fcf4cb52d9..36b31197c908 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -82,14 +82,14 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     iommu@2b400000 {
-            compatible = "arm,smmu-v3";
-            reg = <0x2b400000 0x20000>;
-            interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
-                         <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
-                         <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
-                         <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
-            interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
-            dma-coherent;
-            #iommu-cells = <1>;
-            msi-parent = <&its 0xff0000>;
+        compatible = "arm,smmu-v3";
+        reg = <0x2b400000 0x20000>;
+        interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+        dma-coherent;
+        #iommu-cells = <1>;
+        msi-parent = <&its 0xff0000>;
     };
diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 7b9d5507d6cc..5b56e4f9d106 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -621,73 +621,71 @@ examples:
   - |+
     /* SMMU with stream matching or stream indexing */
     smmu1: iommu@ba5e0000 {
-            compatible = "arm,smmu-v1";
-            reg = <0xba5e0000 0x10000>;
-            #global-interrupts = <2>;
-            interrupts = <0 32 4>,
-                         <0 33 4>,
-                         <0 34 4>, /* This is the first context interrupt */
-                         <0 35 4>,
-                         <0 36 4>,
-                         <0 37 4>;
-            #iommu-cells = <1>;
+        compatible = "arm,smmu-v1";
+        reg = <0xba5e0000 0x10000>;
+        #global-interrupts = <2>;
+        interrupts = <0 32 4>,
+                     <0 33 4>,
+                     <0 34 4>, /* This is the first context interrupt */
+                     <0 35 4>,
+                     <0 36 4>,
+                     <0 37 4>;
+        #iommu-cells = <1>;
     };
 
     /* device with two stream IDs, 0 and 7 */
     master1 {
-            iommus = <&smmu1 0>,
-                     <&smmu1 7>;
+        iommus = <&smmu1 0>,
+                 <&smmu1 7>;
     };
 
 
     /* SMMU with stream matching */
     smmu2: iommu@ba5f0000 {
-            compatible = "arm,smmu-v1";
-            reg = <0xba5f0000 0x10000>;
-            #global-interrupts = <2>;
-            interrupts = <0 38 4>,
-                         <0 39 4>,
-                         <0 40 4>, /* This is the first context interrupt */
-                         <0 41 4>,
-                         <0 42 4>,
-                         <0 43 4>;
-            #iommu-cells = <2>;
+        compatible = "arm,smmu-v1";
+        reg = <0xba5f0000 0x10000>;
+        #global-interrupts = <2>;
+        interrupts = <0 38 4>,
+                     <0 39 4>,
+                     <0 40 4>, /* This is the first context interrupt */
+                     <0 41 4>,
+                     <0 42 4>,
+                     <0 43 4>;
+        #iommu-cells = <2>;
     };
 
     /* device with stream IDs 0 and 7 */
     master2 {
-            iommus = <&smmu2 0 0>,
-                     <&smmu2 7 0>;
+        iommus = <&smmu2 0 0>,
+                 <&smmu2 7 0>;
     };
 
     /* device with stream IDs 1, 17, 33 and 49 */
     master3 {
-            iommus = <&smmu2 1 0x30>;
+        iommus = <&smmu2 1 0x30>;
     };
 
 
     /* ARM MMU-500 with 10-bit stream ID input configuration */
     smmu3: iommu@ba600000 {
-            compatible = "arm,mmu-500", "arm,smmu-v2";
-            reg = <0xba600000 0x10000>;
-            #global-interrupts = <2>;
-            interrupts = <0 44 4>,
-                         <0 45 4>,
-                         <0 46 4>, /* This is the first context interrupt */
-                         <0 47 4>,
-                         <0 48 4>,
-                         <0 49 4>;
-            #iommu-cells = <1>;
-            /* always ignore appended 5-bit TBU number */
-            stream-match-mask = <0x7c00>;
+        compatible = "arm,mmu-500", "arm,smmu-v2";
+        reg = <0xba600000 0x10000>;
+        #global-interrupts = <2>;
+        interrupts = <0 44 4>,
+                     <0 45 4>,
+                     <0 46 4>, /* This is the first context interrupt */
+                     <0 47 4>,
+                     <0 48 4>,
+                     <0 49 4>;
+        #iommu-cells = <1>;
+        /* always ignore appended 5-bit TBU number */
+        stream-match-mask = <0x7c00>;
     };
 
     bus {
-            /* bus whose child devices emit one unique 10-bit stream
-               ID each, but may master through multiple SMMU TBUs */
-            iommu-map = <0 &smmu3 0 0x400>;
-
-
+        /* bus whose child devices emit one unique 10-bit stream
+           ID each, but may master through multiple SMMU TBUs */
+        iommu-map = <0 &smmu3 0 0x400>;
     };
 
   - |+
@@ -695,17 +693,17 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     smmu4: iommu@d00000 {
-      compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
-      reg = <0xd00000 0x10000>;
+        compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+        reg = <0xd00000 0x10000>;
 
-      #global-interrupts = <1>;
-      interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
-             <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
-             <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
-      #iommu-cells = <1>;
-      power-domains = <&mmcc 0>;
+        #global-interrupts = <1>;
+        interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+        #iommu-cells = <1>;
+        power-domains = <&mmcc 0>;
 
-      clocks = <&mmcc 123>,
-        <&mmcc 124>;
-      clock-names = "bus", "iface";
+        clocks = <&mmcc 123>,
+                 <&mmcc 124>;
+        clock-names = "bus", "iface";
     };
diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index ea6b0f5f24de..1eac27893b03 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -218,13 +218,13 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     iommu: iommu@10205000 {
-            compatible = "mediatek,mt8173-m4u";
-            reg = <0x10205000 0x1000>;
-            interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
-            clocks = <&infracfg CLK_INFRA_M4U>;
-            clock-names = "bclk";
-            mediatek,infracfg = <&infracfg>;
-            mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
-                             <&larb3>, <&larb4>, <&larb5>;
-            #iommu-cells = <1>;
+        compatible = "mediatek,mt8173-m4u";
+        reg = <0x10205000 0x1000>;
+        interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&infracfg CLK_INFRA_M4U>;
+        clock-names = "bclk";
+        mediatek,infracfg = <&infracfg>;
+        mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
+                         <&larb3>, <&larb4>, <&larb5>;
+        #iommu-cells = <1>;
     };
diff --git a/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
index 9f83f851e61a..aaecad32dc9d 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
@@ -65,14 +65,14 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     iommu@7500000 {
-            compatible = "qcom,apq8064-iommu";
-            reg = <0x07500000 0x100000>;
-            interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&clk SMMU_AHB_CLK>,
-                     <&clk MDP_AXI_CLK>;
-            clock-names = "smmu_pclk",
-                          "iommu_clk";
-            #iommu-cells = <1>;
-            qcom,ncb = <2>;
+        compatible = "qcom,apq8064-iommu";
+        reg = <0x07500000 0x100000>;
+        interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk SMMU_AHB_CLK>,
+                 <&clk MDP_AXI_CLK>;
+        clock-names = "smmu_pclk",
+                      "iommu_clk";
+        #iommu-cells = <1>;
+        qcom,ncb = <2>;
     };
-- 
2.43.0

