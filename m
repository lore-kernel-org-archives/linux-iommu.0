Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588034;
	b=O1D6ZvVCuaCRaHWL4EnykuNSdl/fgCCWMYvv6aq8nWpUuEcr8NMa4UC7M8YkvPVIbat0
	 c+vcim9AVAPrh/fH0GhkBKsNjN8T8+N9i0ycLxFzoMCmbz5sBoUuRM8KfDyElD3PuaSDh
	 M57IZShL/Sx8HWTFnoTXGdC6cgkdzH94kXjvSSZ6UOvQi7/6H9Eqb3GzuL0mxpn4aimMw
	 EOgdy+l5EugBClMGTHW8BGHaKcImeMLXaowKElWG96Z3Os9n/ejAShEPg+x3Mnn9jLfGF
	 Y1ioltktu9g9kgtg0RweP7R9PWx3wsO728RBe/eDeh5z78hUT3dWxhx7MbTY6OTJNfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588034;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Yz/8g0n4NRMp1v0RG/mbf9AW0/DPBjADn4ea0vIBins=;
	b=lIuUAxVaNukwfL7qfh3JoLQmJTgnjJNuAB96gNCEYo1m4Vnc13FabHScPm7WYT9l8le5
	 Tf4QKHPh5XxSlKjd+08xTbbVeQ3PjQYARVdIxjExRXsDShMormaLT4ySQNvSHGNAcvkoS
	 Bka6Uwo3PLqmlyyJgCvCcxSCKbEOnSYWZQsDa6o86a2UQRZCUKZSy3MLcKuvTw++zXldn
	 cclAVbYZgY3njcS4PcpZ4xGBLhgZmG+3Qn80955TlUwwphyhaL3ggduErKxfPsgNkv5b6
	 /2ZpFwkeCYmT1pqFZBMHJM+K3CcH766TMuI6Qjie6FydJhvlbXmh7N4kSn37uIwNSEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/AySg0i";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD560A6F62;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/AySg0i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588033;
	b=e4krojrIfADKXhPKH5Dp/MMFgG3OB7ha+VrO/gbewD0C39mHMPTksFwLgv4zTmpbPOMm
	 oasc7664Ccq9p7cRv8ziIx8U0TJD+WsRm2jCyGYFX15QP81qnHNP2j01O8k05KRsN2h5H
	 INwQX4b6OHB2bGqW1gKMsmDMJUACg50LYaP0pJtu9VjbcS/ToQ2/CRqfRp/Kf3I56v1yu
	 KEuVZbMWYq1iTkTzIc4d13s/9ifsbtJrZcemCuPoteoGwohqcjPHO+T9D5RfcDTcW4+1k
	 Q4vi/0dZNb/M5wZHKKlphQR1/eUFfN5AKhZVS/abre6lkWg9CEMPYCqDW6AK0jzDtnQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588033;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Yz/8g0n4NRMp1v0RG/mbf9AW0/DPBjADn4ea0vIBins=;
	b=sKEq3nzpQ9r3nPZ26bvrGefLTc+YwLWJSMfBm2VgNlQTJWLJ6lANOzFvXAiS/mjQ1o3S
	 c7F2mZpB3N21Th0AYOuUSgrghwoyeUFYiC75PQT4hLRXJCrQcNGBk3C1NJTCNgzw+NRer
	 yBYhoxLJPLLQfM4JjD6wKu0UgbNRmkOnBg1y0DampSTMaQopKFpH+6E/eiQTqnjlVX5YT
	 QP+uA4H+GZG5UXC3UZ2JveXunjLLPZazyNa1DTRSz1gAJJK6Esd2LfqVnpkGNyRvyPHY0
	 93Ej4futhPVG/gGV4EdMY5PxtTMYO4hn5GJUy4ajRVyEuqflDoJHK3EjpjhkgQjaDOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2D89A1F000C5;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588033;
	bh=Yz/8g0n4NRMp1v0RG/mbf9AW0/DPBjADn4ea0vIBins=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U/AySg0iu0kEu2OduIZVmFTEmM/NqFdg+EqvUudwgH87BXKMhMuueVRzKx/z7WBdD
	 Wmp/FGgSmXDYfBj4t4YBV7ZOWmCjIhCeyflvYGYVIqdJqHpBzp11Uh9ndFF0UkUjlj
	 IYRiQfJMQ4l3IUlLPez76bR4UvBI8mNCMsc2e5rcOCpO9MS0YLqPSvPg8f2Doz/Phk
	 L3vgtOKEkByuNkbjCgLADygZ3liQBmqIb9NRatp7FMbPRuRzVVmh8cIj3QUEXXeJp+
	 k1ftiZ3OkoLGUU5A8btdopZrGRIkoeQWB2KnwyYHrBZTOeMoUMFTEMqFmsfUdtFHNS
	 T5KRnC/KIbt1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B3967499D8;
	Fri, 13 Nov 2026 16:40:32 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:32 +0000
Subject: [PATCH v3 01/12] dt-bindings: media: rockchip,rk3568-vepu: Add the
 reset lines
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
Message-Id: <20261113-hantro-robust-v3-1-82383c722ad2@gmail.com>
References: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
In-Reply-To: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, iommu@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Arun Iyengar <aiyengar1990@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588031; l=1209;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=MRydKxLJI0KA7GKlYnR04VTSaxTd+BLkO918wvLJV3w=;
 b=K8uB0c2XX7c4uheBnmnxsvmBT8na1dLiaxSRrgYZIJRv/zoj3/EzCXkIBHOM+LliMraOSG6G/
 0nFRXNg4AqPDR6pJOzw0CCwcXGiBnhEysj4HUWFoPe4mTog3Xj2/sxD
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The VEPU121 encoder cores of the RK3588 each have their own AXI and AHB
reset lines in the CRU (SRST_A_JPEG_ENCODERx and SRST_H_JPEG_ENCODERx).
They are needed to recover a core that is stuck on the bus, which its
registers can't stop.

Describe them as optional, so that existing device trees stay valid.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml        | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
index d246f5d38427..e9fda4373f0f 100644
--- a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
@@ -32,6 +32,16 @@ properties:
       - const: aclk
       - const: hclk
 
+  resets:
+    items:
+      - description: AXI reset line
+      - description: AHB reset line
+
+  reset-names:
+    items:
+      - const: axi
+      - const: ahb
+
   power-domains:
     maxItems: 1
 

-- 
2.55.0


