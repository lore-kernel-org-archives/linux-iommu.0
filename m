Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA72280A52
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051227; cv=none; b=kVLH9p2emz2cIt7DxbwQPpiU08qI1Es/EOgX9F01k4dwjzZXZDLsr8nF6G7EckH/BCFpFJ0hBSjPCmCcfMvHyk8fsbkMqnmLsAp/2IgnIXRnyMbzoBCOnrLqoLV3W0WuDIRQRnh79wZU/cYPwpJCpJaipZSBjKTDwxz+ZdCmUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051227; c=relaxed/simple;
	bh=heh+k/1ODoaxXv2R5HPjXJm6oybJcbQZVD3EyshC35g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPreIUn2dzBO60JKWHlMVIWlFivyPpBn0lbB0nBAZLHsdlgEKAT4VSZGDHU8Vz22hTRwHvO4kHIN+KThlDdgqVPUiWhwuc/mMsrxtHxqb0nylTuDVFT67+4plLoyP9YsJuwT5DXpipbBUA4aQtAHF7ucgVIoXko6YWo5vl2UNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZVBYRCcG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZVBYRCcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752051224;
	bh=heh+k/1ODoaxXv2R5HPjXJm6oybJcbQZVD3EyshC35g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVBYRCcGByB+IL/zfbQgWULvB/2vP/SlzwwxsUN8Bi7tedN9cGn2eyDaW6BTHa6wN
	 a3Co1RLYx44hXeyjkC17si8VlilL4ClyTrHSTLjYN3Z9Wlblsj0FYh4vuJmY/eNDT2
	 V4BJPgJyri0x1R+74S/6fOkSWwkjXoeZQDUqC4EhWa4XgxlegI4ej9aGnG1zpS+sLb
	 q2dFBSafYl2MHATEEsZNzxElqL/sgkgQHyFo70AQqKJsS39ouvhH0ukp3qxb3lbU8U
	 1/nGdMNwm+y/eieH59pW8ZK+4stlMb4NBKv4ZaGrDIUWyiqik5YWQquZ6f4yLAaxI9
	 ghx579EKpA5eA==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8d6b:4a4d:ad13:46c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 83FF017E099B;
	Wed,  9 Jul 2025 10:53:43 +0200 (CEST)
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
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/5] dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
Date: Wed,  9 Jul 2025 10:53:27 +0200
Message-ID: <20250709085337.53697-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
References: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iommu/verisilicon,iommu.yaml     | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
new file mode 100644
index 000000000000..d3ce9e603b61
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
@@ -0,0 +1,71 @@
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
+    items:
+      - const: rockchip,rk3588-av1-iommu
+      - const: verisilicon,iommu-1.2
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
+        compatible = "rockchip,rk3588-av1-iommu","verisilicon,iommu-1.2";
+        reg = <0x0 0xfdca0000 0x0 0x600>;
+        interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
+        clock-names = "core", "iface";
+        #iommu-cells = <0>;
+      };
+    };
-- 
2.43.0

