Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795722696;
	b=DMElxzpittYY1jtIBtNi2BUSkOqeBwWZ32Fs3ZQ6U21bjGArfqgt6GppdAJkg1gmB5eN
	 YA3AD2Ld46R2ApX3dwBBq98ztTAAH6ycKFbOMXxodUGb4TjTFR5rtF308xLKPWV2yTKLy
	 mTQlCiluvA+t9+I8qnaoOFqq/Bxhb4go4So9XvnvJMayujLw2f04c7XaJmRkI61kwQroN
	 BBsSq7oyIrTkOo3hKgDCHScXww8yd+25VZsfUWHMpWbK1AxPU6h5HgmUEIK/ISTRms1eo
	 svg67y2G9vM4m3wwZe98OgoGtc0qoSJlXOjv+yWPtQ8CRua7gzSLzN/0aS5+EvDYtig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722696;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=73w2j9RJXwR9kXhBP0i3TUU2mktgXrCF6+L1iCYVU1A=;
	b=4wTZluJQyW5hGgplLnO0qeneUbH/ErjApt1Y/Nifs3Pgm5Deg+yPkgcKaQgrVc9iyMhL
	 0RLO4WzNPmnNb8zXDyPj6iJeMy3KYsTTlFV0xFbrIfB1UclZtOdihDYD6D+s4LItdLSL6
	 DpWoLjsnxfQbTiJlnRz2rAC0k19W4AtLBR3JGlQLGFarXEyduuFHv/xoBRzuaaMjcj0H1
	 jJtwkJpYADBcX2Mx1t8Nn3Zy7Ou3F1xXKrZ6vlGAYhy/CIEju1NhCi7NZPZyguy2u+9FP
	 sA+2eU7ag8sszVypHG+EuJPI+9NumCnEZvdZ+QGM2XEsLeBM26te+XVLLy3vqUw26rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbXumifJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C25606A326;
	Thu, 26 Nov 2026 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbXumifJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795722695;
	b=NuNEDHOeNwZ0pHv1DIbkuxTPEBkvJ1rGmTdmDYYM2VLpjcGUpYo7xVGN0PkESTI2f3F1
	 aOQJq9Fa0YBW6EKsWP43F6pbsmukXkoYBo4G9gMByNbPXFVpX9bmOkLrsmBknllEaE1NG
	 /ipj90DvvpmgAUSVI5WZTx/G9AP6Cp8Lg/l+zlrx+DYhMDmvw9FmRdDGIdfdLNOHpoZbi
	 zOae3Ez13rEl0Y8LtCb55gKyktFcrXbvE+xEXz30FBUsp0qTjBamUbyPyIlsYaJNxtiYd
	 WAN7VQdD1z1SyKJg1GUQ13/w2hf4G/kP1un+24wHKtkOCBQu5XyAo+zOsvUX/qJ+zYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795722695;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=73w2j9RJXwR9kXhBP0i3TUU2mktgXrCF6+L1iCYVU1A=;
	b=BbwRHsCxkZTPPoVBPqDDF2t/xDOqpuN/ttxzZ5e/pUY/G4lnJTbUlCZTYKw67o02Hd33
	 BSpolHBp9yv+So6McYMpu4LnnId/FYyqT+zgsBsSz4L/f+W+B0tPaqrnHSDhLJkuQCInG
	 P3pNn3Qo2M591OyaScUN/S7RxZ9SeZx+oAWh3uFdoYPM6t1Zl2q9GoHAuQURZJw93HEF6
	 fxlI8faQmJzCS6ok5ekhIR805LW+GxVhvT34vzvWF0PTG7f3BsaGCmsS8q2shVIu6AF00
	 2n6OkVJZBltbhk5yfo5KPucF+4o+UeZ/Vpzieby+JAL49XBc8uaCLqVvlAjkbFsRgEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E13941F000CA;
	Thu, 26 Nov 2026 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795722695;
	bh=73w2j9RJXwR9kXhBP0i3TUU2mktgXrCF6+L1iCYVU1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cbXumifJhczUq1KKbaBTkutvtMCC7CivHo5yy7zmGmdWJVOu500F2zJ5wHM6692cz
	 HQ897/lpvLdTEZ+zppGXboApYH84SmnWdeP1v74zzqZbF9nWPTiVOSTO/ZZX5Guo+X
	 SQqEgHanjxRc7tbvo+i2sNXbYyw6mikCVYUlE1jG5X7H45TeZ1yX0g9krRuhlEJGvA
	 3aTCO1a/GmTJkQMYbeQA7oPL9KKBjyAs9R+f0g9kLpvk2bazg6G/DfMwV8prUNA0Wt
	 5XvTt+o/Zs0tWiM7UWrCu2YO6WpLEtMHrhzNxOn9uvod9Vo/t6py/SXFvfa2HkTEG1
	 +wozHom1qQSXg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6DFDE4D7CA;
	Thu, 26 Nov 2026 19:51:28 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 19:51:27 +0000
Subject: [PATCH v5 1/4] media: dt-bindings: Add Rockchip IEP2 deinterlacer
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-iep2-v5-1-3deac0976f10@gmail.com>
References: <20261126-iep2-v5-0-3deac0976f10@gmail.com>
In-Reply-To: <20261126-iep2-v5-0-3deac0976f10@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Alex Bee <knaerzche@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795722687; l=3925;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Qe6wQ4E2xaAvete4oI5amRHE0suyCMaOjV61Q0hB68c=;
 b=nt5nRKKgSGB0J+czoTa4eC5CQiDVbWv0v1w7HAThLK8XPDSOAQG8mqYwHThJVeigi9VF/oiKd
 rsbBIWwX2/EBxmULE5Lab+/xab2/vRnZaxbVGAVlOdr3q1lhcgQ8IWh
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Add a binding for the IEP2 deinterlacer of the RK3568 and RK3588 SoCs.
It is a different block from the IEP of RK3228/RK3288/RK3328/RK3399,
hence "iep2". The RK3588 block falls back to the RK3568 compatible.

Clock and reset names follow the RGA binding. The resets are optional:
the block has its own soft reset.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 .../bindings/media/rockchip,rk3568-iep2.yaml       | 95 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 101 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-iep2.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-iep2.yaml
new file mode 100644
index 000000000000..834282ef99a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-iep2.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/rockchip,rk3568-iep2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip IEP2 image enhancement processor
+
+maintainers:
+  - Arun Iyengar <aiyengar1990@gmail.com>
+
+description:
+  Memory to memory video deinterlacer of the Rockchip RK3568 and RK3588
+  SoCs. It has its own IOMMU, with which it shares its interrupt line.
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3568-iep2
+      - items:
+          - const: rockchip,rk3588-iep2
+          - const: rockchip,rk3568-iep2
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AXI bus clock
+      - description: AHB bus clock
+      - description: Core clock
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: hclk
+      - const: sclk
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: AXI reset
+      - description: AHB reset
+      - description: Core reset
+
+  reset-names:
+    items:
+      - const: axi
+      - const: ahb
+      - const: core
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - power-domains
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/rk3588-power.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      deinterlace@fdbb0000 {
+        compatible = "rockchip,rk3588-iep2", "rockchip,rk3568-iep2";
+        reg = <0x0 0xfdbb0000 0x0 0x500>;
+        clocks = <&cru ACLK_IEP2P0>, <&cru HCLK_IEP2P0>,
+                 <&cru CLK_IEP2P0_CORE>;
+        clock-names = "aclk", "hclk", "sclk";
+        interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&cru SRST_A_IEP2P0>, <&cru SRST_H_IEP2P0>,
+                 <&cru SRST_IEP2P0_CORE>;
+        reset-names = "axi", "ahb", "core";
+        power-domains = <&power RK3588_PD_VDPU>;
+        iommus = <&iep_mmu>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f72ce07a4e38..90ec701edce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24285,6 +24285,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
 F:	sound/soc/rockchip/rockchip_i2s_tdm.*
 
+ROCKCHIP IEP2 DEINTERLACER DRIVER
+M:	Arun Iyengar <aiyengar1990@gmail.com>
+L:	linux-rockchip@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/rockchip,rk3568-iep2.yaml
+
 ROCKCHIP ISP V1 DRIVER
 M:	Dafna Hirschfeld <dafna@fastmail.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
2.55.0


