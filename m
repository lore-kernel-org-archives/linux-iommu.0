Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438A47DD6E
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529544; cv=none; b=tMPCO2c0cjmn7Ie+L10bnROn+ltJhQGAHJ0wnfzKkTxlTzcShCRzm1hizq2wgEq6hhcd92FOdry/XipM8PCbrBNV/JB/3ny5AOTpQP27V03DQicaXbJly9oEYttugNgDhdmttQ8UQ6HIl6eXm56cyd5vmWt9hnuxAMgOqj5o7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529544; c=relaxed/simple;
	bh=1Wl+9r0+s0TDUjhnfcyyKaDZxB4Fsr0gGq2PjdolWCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PPkY9fW+OAfxTsDDdnG+oyCyr0hQt/o6qrmqq4y41KDQP9x0GxW7+NsH+X50fBBA5e+WQXYA+D9YzwRfTaunkKJCEGW/5vbnDQqgdece0QtxGqswdrQbidCdVTNYuBXNgyWK2zrK8V/BLyPI1yag1Lajcbgx5QCfzTtB8sfaCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy8yTGG5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy8yTGG5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383fff6e8b6so111299a91.0
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783529535; x=1784134335; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U//PbZPS0wgDigTHSbhziRKqlRUyA7Fn8Fac9dDowRc=;
        b=Cy8yTGG5kmFOBd9qkg8g+FwFN6h+o//oG6YvwZM1tH+5Tq6dvvpOKQGuDykGjYRf/Z
         MOIZpdMcLm72yJf63juVmVrhaJ6tQ6Bsk3L6KCH4TAKGUrjY2kE5OBkd1Vd8guFpoh7Z
         3lNKVGRroRtlVEvLB5dA2D6LPTLXfejLKC4SoKo3t9a5SG+2NsS+VIOGFhR0Rg2FQksC
         q7I4qQaGJhFoGoLRzaWgzYi5XRuWQ8FOGhLyInVW+d30X36Dn0QqU40b1ynDyq+gHmdW
         imIsZQKvdxWD8uDxqmFjjNdEsflJQzXmJzUD2jIstWTPs6li8SdLvMG8iUUWXmAIiBnh
         XI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783529535; x=1784134335;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=U//PbZPS0wgDigTHSbhziRKqlRUyA7Fn8Fac9dDowRc=;
        b=XQRw7qHTCm8A7n0mzxal9YomSu8pq2xmXCUFNPoWPJuRpUOaynMzNaAJbISrDJJREi
         rj387iMhJ2EBSMDwuHd+qbV9Smnbe4goB0GUpWkBYm79zIAxDI0DavEiBkCEffjcYhho
         KEzNLPzKgtyP6eMlTTkS5/PBWv/v5bRuJecxAeQutKzHvp0UCMpSmYYqoNwf7mEe/94J
         xOR/Gug6cwChjRovC6nGvKe00dvGq8rqa3KWnFKgilgJjRMVezKObpQqV74mOSV+E5yL
         K1ug/paF4TT27oES0auJ2EzJ/K4W3MTAhdFotV4oLDeCsDg3rGT0ktDHzqe6us0dnQhR
         o5fg==
X-Gm-Message-State: AOJu0Yy2oWENRsHlalCioWCgXvCBioYYBcIHObr25f/S7tC8U7ykZqU9
	A+gIi+w80lsv93p209TdgIg5wP51m4LfLp47Rad0sVK9I9h/khA8zhEK
X-Gm-Gg: AfdE7cm8fvd76lg9XZExdtnf8VPaHYMdVL2+hrv/rRUguJpQZ4b2Go+NsXEYlCry6HR
	H2ZOoEQ6VzhxMLsJ1WLrlJlzpLvLUMMuIGz39G94gBS2Jj0sRuQVAhgmC7x5/YavKrgXwHvrCNq
	V3uB/j8kDcCQJGR/q6xik4gCl/LIjOag+1tRIhvYBOVaG8o7bEYr1SMW2gLh6QRMkUr3jAcftvd
	tkOAHNi8FeEMUf40pfj0N5IN59ipsgjXejyeUjFZnmbvS7K7bxmz0Nl0kx/LCT6P0GtUkvTKvAP
	ARTp3JyxkrsyqTjYJOp6dYfabdr6gxThJBcPKLNc8B6YVGcRmIAphVZLCGEV0shQgkHMfciqGb/
	x4JTFJCzmCrcPPfO9YTnSq3TDOExXj85d7LD+nGzZykooFXcSAUhujwxmJcA9oQ18MO+pj2fLJ9
	Nxvor8QOG2ud6mJzLQW6qw6w==
X-Received: by 2002:a17:90b:4c0e:b0:381:1ffc:7d35 with SMTP id 98e67ed59e1d1-38a2122c84amr257831a91.6.1783529535194;
        Wed, 08 Jul 2026 09:52:15 -0700 (PDT)
Received: from [192.168.1.2] ([2401:4900:881c:f765:f05c:d31e:8ae0:b06d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm7136661eec.24.2026.07.08.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:52:14 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 08 Jul 2026 22:21:43 +0530
Subject: [PATCH v2] dt-bindings: iommu: ti,omap-iommu: Convert to DT schema
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ti-omap-iommu-v2-1-612d4a6644ba@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jm7RgoCMSV9zAshjqFMZaSthAN4
 e4Crl2+5P33FwjshQNckwU8zxLEDRuoUwK6p6FjlMfGoFJVplVaYxR0lkYUZ+2EOStlqtzolhR
 sm9GzkffRuzc/DlP7ZB33yG70EqLzn+NwznbvX3vOMMOi1kZfciIqyltnSV5n7Sw067p+Ae2co
 lO8AAAA
X-Change-ID: 20260708-ti-omap-iommu-3e22f73fcba2
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783529530; l=6812;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=1Wl+9r0+s0TDUjhnfcyyKaDZxB4Fsr0gGq2PjdolWCg=;
 b=lFU8uyDQABCOFUqV6yGWemDCgw90I2sdy3M0wBvWUKs6x3ud5O5vkGIWo9zbTdMZJFL+pZkgU
 CSg/0AYIcAeArks8DjXtY8ClaZrrSbbANMU+VYqk/zDzTTwx7RzBfjn
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert Texas Instruments OMAP2+ IOMMU from text to DT schema. Make the
'ti,hwmods' property optional and mark it deprecated as it is no longer
used, it is kept to support legacy dtbs.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v2:
- Added maxItems:1 to ti,syscon-mmuconfig as property expects only one
  pair of phandle-args
- Added deafult value 32 for ti,#tlb-entries
- Link to v1: https://lore.kernel.org/r/20260708-ti-omap-iommu-v1-1-48cfc53aaa46@gmail.com
---
 .../devicetree/bindings/iommu/ti,omap-iommu.txt    |  59 -----------
 .../devicetree/bindings/iommu/ti,omap-iommu.yaml   | 114 +++++++++++++++++++++
 2 files changed, 114 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
deleted file mode 100644
index 4bd10dd881b8..000000000000
--- a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-OMAP2+ IOMMU
-
-Required properties:
-- compatible : Should be one of,
-		"ti,omap2-iommu" for OMAP2/OMAP3 IOMMU instances
-		"ti,omap4-iommu" for OMAP4/OMAP5 IOMMU instances
-		"ti,dra7-dsp-iommu" for DRA7xx DSP IOMMU instances
-		"ti,dra7-iommu" for DRA7xx IOMMU instances
-- ti,hwmods  : Name of the hwmod associated with the IOMMU instance
-- reg        : Address space for the configuration registers
-- interrupts : Interrupt specifier for the IOMMU instance
-- #iommu-cells : Should be 0. OMAP IOMMUs are all "single-master" devices,
-                 and needs no additional data in the pargs specifier. Please
-                 also refer to the generic bindings document for more info
-                 on this property,
-                     Documentation/devicetree/bindings/iommu/iommu.txt
-
-Optional properties:
-- ti,#tlb-entries : Number of entries in the translation look-aside buffer.
-                    Should be either 8 or 32 (default: 32)
-- ti,iommu-bus-err-back : Indicates the IOMMU instance supports throwing
-		          back a bus error response on MMU faults.
-- ti,syscon-mmuconfig : Should be a pair of the phandle to the DSP_SYSTEM
-                        syscon node that contains the additional control
-                        register for enabling the MMU, and the MMU instance
-                        number (0-indexed) within the sub-system. This property
-                        is required for DSP IOMMU instances on DRA7xx SoCs. The
-                        instance number should be 0 for DSP MDMA MMUs and 1 for
-                        DSP EDMA MMUs.
-
-Example:
-	/* OMAP3 ISP MMU */
-	mmu_isp: mmu@480bd400 {
-		#iommu-cells = <0>;
-		compatible = "ti,omap2-iommu";
-		reg = <0x480bd400 0x80>;
-		interrupts = <24>;
-		ti,hwmods = "mmu_isp";
-		ti,#tlb-entries = <8>;
-	};
-
-	/* DRA74x DSP2 MMUs */
-	mmu0_dsp2: mmu@41501000 {
-		compatible = "ti,dra7-dsp-iommu";
-		reg = <0x41501000 0x100>;
-		interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
-		ti,hwmods = "mmu0_dsp2";
-		#iommu-cells = <0>;
-		ti,syscon-mmuconfig = <&dsp2_system 0x0>;
-	};
-
-	mmu1_dsp2: mmu@41502000 {
-		compatible = "ti,dra7-dsp-iommu";
-		reg = <0x41502000 0x100>;
-		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
-		ti,hwmods = "mmu1_dsp2";
-		#iommu-cells = <0>;
-		ti,syscon-mmuconfig = <&dsp2_system 0x1>;
-	};
diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.yaml b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.yaml
new file mode 100644
index 000000000000..9588eb60376e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/ti,omap-iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP2+ IOMMU
+
+maintainers:
+  - Bhargav Joshi <j.bhargav.u@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,omap2-iommu
+      - ti,omap4-iommu
+      - ti,dra7-dsp-iommu
+      - ti,dra7-iommu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#iommu-cells':
+    const: 0
+
+  ti,#tlb-entries:
+    description: Number of entries in the translation look-aside buffer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 32]
+    default: 32
+
+  ti,iommu-bus-err-back:
+    description:
+      Indicates the IOMMU instance supports throwing back a bus error response
+      on MMU faults.
+    type: boolean
+
+  ti,syscon-mmuconfig:
+    description:
+      Pair of the phandle to the DSP_SYSTEM syscon node that
+      contains the additional control register for enabling the MMU, and the
+      MMU instance number (0-indexed) within the sub-system. The instance number
+      should be 0 for DSP MDMA MMUs and 1 for DSP EDMA MMUs.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+    items:
+      items:
+        - description: phandle to the DSP_SYSTEM syscon node
+        - description: MMU instance number
+          enum: [0, 1]
+
+  ti,hwmods:
+    description: Name of the hwmod associated with the IOMMU instance
+    $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+  - interrupts
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,dra7-dsp-iommu
+    then:
+      required:
+        - ti,syscon-mmuconfig
+    else:
+      properties:
+        ti,syscon-mmuconfig: false
+
+additionalProperties: false
+
+examples:
+  - |
+    mmu@480bd400 {
+        #iommu-cells = <0>;
+        compatible = "ti,omap2-iommu";
+        reg = <0x480bd400 0x80>;
+        interrupts = <24>;
+        ti,hwmods = "mmu_isp";
+        ti,#tlb-entries = <8>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mmu@41501000 {
+        compatible = "ti,dra7-dsp-iommu";
+        reg = <0x41501000 0x100>;
+        interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+        ti,hwmods = "mmu0_dsp2";
+        #iommu-cells = <0>;
+        ti,syscon-mmuconfig = <&dsp2_system 0x0>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mmu@41502000 {
+        compatible = "ti,dra7-dsp-iommu";
+        reg = <0x41502000 0x100>;
+        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+        ti,hwmods = "mmu1_dsp2";
+        #iommu-cells = <0>;
+        ti,syscon-mmuconfig = <&dsp2_system 0x1>;
+    };

---
base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
change-id: 20260708-ti-omap-iommu-3e22f73fcba2

Best regards,
-- 
Bhargav

