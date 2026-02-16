Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72472E972B
	for <iommu@lists.linux.dev>; Mon, 16 Feb 2026 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235515; cv=none; b=VSFYq8CLsmaipTV8EdtCJxExmDNznaj67ImcXtIM+zkxSd+Hzz+XM5nlWaKRWSj8/aqVqrv2lWj/4gJ1f1KxEkcsU6Npw4dT8TfXoYGD848tbyuYRRFXioyH/sSxVLEGQVndV3wVfuhDTSlaZbOIIKCP6dD4xICRUK3BzeO8dGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235515; c=relaxed/simple;
	bh=heh+k/1ODoaxXv2R5HPjXJm6oybJcbQZVD3EyshC35g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DraIfE1ke4WUfwT5zLQpuOHRPxWN7C7RK/l7AlV81KdG1L6rQijriyIo+ptsU5x5kjxz/p9505DBOyHjGiCy/wIiNsm3IsnYF+fIWrS895wIrDtoxQYuAGhvJOCrccjk+0SMazn3M6mIlYmWWa+Uo7bVPg5dF4viyg6oMXKWZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fjqVhhKm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fjqVhhKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771235511;
	bh=heh+k/1ODoaxXv2R5HPjXJm6oybJcbQZVD3EyshC35g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjqVhhKmdFEBHsg8hJXcn6Wi0hhbjGuoelb0wgH8edDYuWX37zt7/0Vovc1tzpjpQ
	 xm+niTc7vBlPQIXGtTmnqQ9Xc9koWMT9EadAvJv4YV3dimJSTDkX9SIt5Qx/hWECpi
	 5QscVJhrHlfMnjELBcqoiEU7sLFaRML479UQwbiONb+pBhRcmXti2ySkNIvbSSOdyu
	 kbOixHUXMVatSFVWtDMimvJ2oWiq5sKNnIGvqZCjBvX/uk5lrhjUWhABT+9i8eiZ7v
	 DOL6ndD76LFg7UC0P8A3Q0b+TVlolHnq4AyjM3qvQUz+uDeBae77YEi+l7rA2c5IQa
	 3c1WKijRMk8aQ==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f6d2:8ed9:560e:4f27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C64B817E156E;
	Mon, 16 Feb 2026 10:51:50 +0100 (CET)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v13 2/6] dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
Date: Mon, 16 Feb 2026 10:51:34 +0100
Message-ID: <20260216095144.107356-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216095144.107356-1-benjamin.gaignard@collabora.com>
References: <20260216095144.107356-1-benjamin.gaignard@collabora.com>
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

