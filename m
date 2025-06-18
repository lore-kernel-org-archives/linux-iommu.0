Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8252EAB6F
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255778; cv=none; b=HtvK1G5AfH4rBfoWsiXkSi7NP2l0SwQdANkQMB+jsEnmfd4YzX3uUmCohSkuv9USgwD39oWyVTbAEbNAqL9zYagqFLxfbwNrUjxnYFuJN4ZuicZbSk709boVaLoda38y4Jdq84yXkzm5zlYgqkkm8Us/hp8BpGJrMfSv5818VAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255778; c=relaxed/simple;
	bh=gAf934q3p4ztJVBWu9FZgouVimm2lufXshc7P1S6iuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvCxvkef47JaHqrRUN7KPNilGFE1uKXlzXcwP0eP3znvq3JubzszHzf+Gj364Q9QUqPoQtHfj/j5fqszhgZIWfayeYovgvtEzp+Hg595CtupyrJjYnLMQ4RBwu5ZRq6j7NkkhC0UxDupzqPuwS4T9qWubjmB9C3lGDbwQNkZCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ppgQl6+n; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ppgQl6+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750255774;
	bh=gAf934q3p4ztJVBWu9FZgouVimm2lufXshc7P1S6iuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppgQl6+nsWC23/4f9LJacUgFTKJNMahegzF7Y5FvVr4c18gPkvgWewEJCbrg6AOpF
	 XTYxF53I4HkHjm9Q0npO84c40U/hEhjN+qa2DyUoZsCG+zw5lfwF6ENWb1VLuwtimX
	 3GMBVMfLcYE/C+rhKPqV1KlvbnCUnqPaNLtIWezhI0lVOGvd6V+Lzh8UPmzdLk54gT
	 9pd3si11U+l8fb2v84mg14Fw8OF62U57yRz+jGsk+HuxecjFY52N2Dh+SEeoyCGfT5
	 Q9NCBYCXU2gcRhlDhNth5rYhdWq1Pkwq2Qqljr+2o1Xnn/8gfxYG0x/lVs9HwnzXAv
	 5o1rqJL2YVU+Q==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:45c6:994a:f902:5c74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 09FF417E10C7;
	Wed, 18 Jun 2025 16:09:34 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 2/5] dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
Date: Wed, 18 Jun 2025 16:09:11 +0200
Message-ID: <20250618140923.97693-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
References: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a device tree binding for the Verisilicon (VSI) IOMMU.
This IOMMU sits in front of hardware encoder and decoder
blocks on SoCs using Verisilicon IP, such as the Rockchip RK3588.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
changes in version 2:
- Add a compatible "rockchip,rk3588-av1-iommu"
- Fix clock-names in binding 
- Remove "vsi_mmu" label in binding example.

 .../bindings/iommu/verisilicon,iommu.yaml     | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
new file mode 100644
index 000000000000..9ae4a45d76f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/verisilicon,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Verisilicon IOMMU
+
+maintainers:
+  - Benjamin Gaignard <benjamin.gaignard@collabora.com>
+
+description: |+
+  A Versilicon iommu translates io virtual addresses to physical addresses for
+  its associated video decoder.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - verisilicon,iommu
+          - rockchip,rk3588-av1-iommu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Core clock
+      - description: Interface clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: iface
+
+  "#iommu-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      iommu@fdca0000 {
+        compatible = "verisilicon,iommu";
+        reg = <0x0 0xfdca0000 0x0 0x600>;
+        interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
+        clock-names = "core", "iface";
+        #iommu-cells = <0>;
+      };
+    };
-- 
2.43.0

