Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795854614;
	b=JuQW1cImznQGhP1Bg/QoSr1d7o1G055POWpJK1sBFtJb/NppSy23r/aX/qe/4DIfH9Ip
	 BGpsajXVbGxFLS89l/9h9BUDtg+7Z/yUmElK3wblv4sOxgbGVIcATUujv0EIBAiqTRtIO
	 jOUsGCbIob8h1F0h0Z8CGqNHNsWMOfaY2wMg/Jv9+twTDgmaM3UPh3z19gaZwZbD2Sbam
	 IxNVNIo+gYtabEyZlPvHEl3d8VPE6IAkfB3Bera1nvRnp5yabX1LSlBW2gNvL6XclRxii
	 fajDMzdNC2sKFTyKUvVbycPLVFarQKj/TaQDBtBpJ15RI81NsqZ8MW3OskG1HHM7lMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795854614;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=73w2j9RJXwR9kXhBP0i3TUU2mktgXrCF6+L1iCYVU1A=;
	b=oMOReTJrTl+aMPPakC6zaawIPRTsPW4g/CPie0gUbUOhIXEPFoJI5N2fclX/+5rKCve9
	 C5PEA9GF4DGZ/69EZwTtKsoiEBqTE6OCpXqJMqIHfB6NB3GGi3hdA1xW6TGcvegmxVvH8
	 h5p1qMkgyGPVAImvXfx5+ypU5BhI0Y2whKVmGUEwbAH8meF/11eufPNdcr822uqzRZ5JM
	 SpGOu9HjVwBILDuf8PlkC3sG7F4TOYhZX3jOz8qjt++zYFAoVNtAMqp8I8kfUVURM4Swl
	 7lFr3xdL6aXTSMUBeHq+UGP8wIvI9sG90PKhUe32DIk1ZQN6bR36j9Yz7bdjF0pMZGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMAc6ipv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88B606A332;
	Sat, 28 Nov 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMAc6ipv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795854614;
	b=R3vz9TOH64xSqwp5siyDYgbm7IZcKA3WjhaZa9QG1ZAGs03TKSai8zPHREbKyN84s716
	 2WAUZ3hO/w1kuIa3fzUpgoF0NLRdEHlnlLrWSfJWG2RyEGYPi1j1UQahYJuVf8xNHcBej
	 xz1vAAaXtUspuCEhrpXl8QQXRQMaqmDYMOrAaQUKsM45m2C+lKkgMT7choQYvayPJR3x4
	 BMThyDzVoAAa6ZE4Ol26LahSDODPPQQ77WYTXVapJUmPJeEbImkNZZGKT3X23SLSq90+X
	 wj1FlDRk58hYwMuP9eqJj85i5yXThtoJATE7XmeGFpwJvQ8F3Yy9HTB+M224uQrlAaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795854614;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=73w2j9RJXwR9kXhBP0i3TUU2mktgXrCF6+L1iCYVU1A=;
	b=u7/zruTSaoNbhGL6lDssTqu/BktUYn3E9tK0Lrlu1rNPfiB2vKmV+4F2vUNP2WabNorv
	 5B4cd2X3kSRXbt9Ai+EdPuwi1BjaKpF4pbUa7Wz6e/sHf6twi5/rvsNlvhXXzeBIYhxBX
	 kP9FSSIDvhHM+bDfT8N1yIhOUzs2QwoXv706NTVF54EZbTz7nz9k7qdwKKfRvuOVZRs8x
	 lG8iF9uW4TGq//MIzw46EJ79le0i1vqgGh99OzXu/C+gApxZJ3VS6FvwvWesN0HYiWWTm
	 hgKp014yz/fXkaWODdIOuRReZuaH/qFZnTHOi+O0jRaSaeENAFSkiB5RPKjY/tNHKPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A5F961F00897;
	Sat, 28 Nov 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795854614;
	bh=73w2j9RJXwR9kXhBP0i3TUU2mktgXrCF6+L1iCYVU1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nMAc6ipvIwGCWunUhuheSd7nvlo0VBzl6wWTbG4aEQZeyDuSvJXmL3zL+saTFsMqe
	 cTxeriR0InQzEn62QUzmUHMAx5fhrZWQ5UFqvUq3BHPn+hUDDUfJWi0AGN/P9JJpJk
	 DxHAY1PO5Dj3TY1Y0qa/dKuD8qrLPBlQpvaoGZuWS5plmUjywtzIqkQ9Z1Cr/2wtWm
	 HqPpbEltnVUFOaQypsJPc5+1mdRLivYnc8hk2n8ywxdoqubGjcA+SQOIlt5sP2c84P
	 jmomUBYK2SauyX5aaF9Be+behjHdft/UkLFT+sltzXI1xXCLnkHune8qzqY0JA0A7z
	 yqOfo1fdlWrRA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2CA894E036;
	Sat, 28 Nov 2026 08:30:08 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 28 Nov 2026 08:30:07 +0000
Subject: [PATCH v6 1/4] media: dt-bindings: Add Rockchip IEP2 deinterlacer
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
Message-Id: <20261128-iep2-v6-1-5f4f10a0dbeb@gmail.com>
References: <20261128-iep2-v6-0-5f4f10a0dbeb@gmail.com>
In-Reply-To: <20261128-iep2-v6-0-5f4f10a0dbeb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795854607; l=3925;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Qe6wQ4E2xaAvete4oI5amRHE0suyCMaOjV61Q0hB68c=;
 b=R8Jlkn+pG6lnsUuFgrxt72FQ8NNeHUoGdnvC7byeX6Zpl2SHd7gpbvgjWypyQuJ+Oq4y376sG
 Ga1vybXpWVMBt8WdCz31mXiHhq07/0IDUCbiw+pJapQ2gBFjHojBYk6
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


