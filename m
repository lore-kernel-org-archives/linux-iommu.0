Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588037;
	b=MKCGLtKKbMQEukk3Ua2ro9T+E0rK1lHTmb9VXspnvHmgQriJxW9FZhixmro6XH2lU6uV
	 ws0A3mYpv2KNzhM798n/mQ9EyRoyebbzfQNUnSj+zc/RDR1rv5OQZIS6teo1l6Ymu7VQ6
	 VL4VUcZHvLy9aaZjEaot7Qvavav4tVyjU64QT/s3iqGLQMIWUDiTbhL4XrBwu67HMvE6F
	 iSrDaPVU4cDW1mxjP30a/ZUeBvCAteu+FADtJ5poMyjGlnvSa2loJp/UqVKCrLp+25uNR
	 4zZcnV6rkx4VlAYbkuBP5Q79LOG6p8zQpE6Qr32o8W5fOX5vkZz+StKBw3HIf/qtM3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588037;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=32waLqqt2swUzhJWArbh1IzS7YkAtqX1L64oSzrx3MM=;
	b=uUxkleO12T0AZCdBSjL4USe4cp2b0UtsWNgHu8X6e3YmI+QAEQVOBieC+I5RvH9cpH3M
	 OhPT6aBftQf+/lWvA5eSPm7akLvEVwqiODAVG44lzKxkiSbEIZXJoFGC/3vEH0Hd80YOz
	 GC1TMpR5yBEyjEXS/bLAwtsChTdHXd8jD6jQ2J09xOV7GLoI21OtNgG5QBrvgRgqpFzlO
	 Apx9g4rOVXex4LO1Y6It7duIpu2fS+BLT2QAEixLnmwVHnBHm80LNNwgeaqGtvKDii7sD
	 ziVmogP5O4hHh/3ZvSW9glz6zKfh7LkuB9jFUKI9IpUtGKhsa0lRa15+4o+SOJrt0ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRT4sSRi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEF606EBC0;
	Fri, 13 Nov 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRT4sSRi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588037;
	b=Z4V861lIS9RjuPAPsT1JvEnolKqBESsD4NZSQAsA63Bgo2H9jAmAXQCPl+akOi1XjdZn
	 7ts25hxmjjAobUn78Sog1Z61r1fqUpCDNOmq78oqGSGzImk7HYzJMqo8PCrtooYsTt89P
	 pxcOlMIPw7hL7CobNODaPC/MIyekExb2hIfQOxfyj2Tkx8ZC/avC+D8DaHzbpiE2MEIIp
	 0UylXwlEjLq9EnrbLVU8dsmtRDMHCuzY3mYD8gY4aJLY8JlYexkG2CUYMqgwnFl/7g3fy
	 SRn2/MfvIRYT7PZ2C6WXnVQFUYZNzB+dritr8NDTdxzfShnONGsuzgWsDL2apiiQ/DQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588037;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=32waLqqt2swUzhJWArbh1IzS7YkAtqX1L64oSzrx3MM=;
	b=EHVlCarq5KKfXNHG/bWtaxclpG9YhyLSd9t3Kx+lo9u1WEGgFf8ywBJ1mF72MDE/f2+1
	 7ddyGZEtwPVMbfUKFLhdfrVxMUslN4Hn7fa3Qh9aKys1fzViEwhOgNx6/kl1hzK2zN+VS
	 f1iIhRPon/jkJ4DCNDxCtPglaULoJb43WDFJ5UHwNWNuhXvT/nQjtfZ6uDih3Sw5fV/BA
	 C3bY+0OSRfztzzwIGWX/+UbC2zgt2LYxw+2EyK4ChDxgrI/LOXKZ90co4jiY/yitUe8Om
	 TQAopqQ8GKu+rtP1QXyLlikXYJFAYXWijuQyp3mRJMzZrg9Ci1rU207YyoyPlXvdGww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6630F1F000D2;
	Fri, 13 Nov 2026 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588037;
	bh=32waLqqt2swUzhJWArbh1IzS7YkAtqX1L64oSzrx3MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jRT4sSRiN65Rea6q+ooPLoSCtMVlDimAMl+nISOb4ZqfqT/pE4h4M7qV8wEtXB0RG
	 TRT+T0ejGizzpZpzxHSimS7oAlcNwo/x+A2VjRlbiiVCgQ7K4dl3hWRPElDIFdKTNf
	 RH9axCSCiegr6MbL7JHaigw8Run1lIaBmxl1fMBdC6DovVgbBaYg9zE6P2J+2G5cT7
	 VtSlS4r4vkwC55TCOt0qKbtGK/K6IP6iApC2UD7XjnK3ExKFUHxgx5a3z6wXqOnr2C
	 8B5LLuJzR1yF7NTs5k/ICfDf/fMrzyRUNnJ7CE2NDmisqXTm77M8OoyA1ulAYsLUq9
	 2o/5LjlIB2uIw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 81431499F7;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:40 +0000
Subject: [PATCH v3 09/12] dt-bindings: iommu: verisilicon: Add the reset
 lines
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
Message-Id: <20261113-hantro-robust-v3-9-82383c722ad2@gmail.com>
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
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=1642;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=a+eZKtwV8FPJqeLafXDDZfyk/cG+VGlzjpq9Qo8/bY8=;
 b=L1wozRVp2YsBLp3pnvZOk6Asi0zgyaASac5q4LLSW86i3YR69JPYnHiVkoLFTnbNW5SGSsSLt
 1z+C7LIT1weBo0dAv6on114npHG1f0hH7gdwj0HY9/mqbqP+VVsAHTz
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The RK3588 AV1 IOMMU is part of the AV1 block and has no reset lines
of its own: the four AV1 resets also cover it. Its registers can't be
accessed while they are asserted. Describe them.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
index d3ce9e603b61..70df03102015 100644
--- a/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
@@ -41,6 +41,13 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    items:
+      - description: AXI reset line
+      - description: AXI bus interface unit reset line
+      - description: APB reset line
+      - description: APB bus interface unit reset line
+
 required:
   - compatible
   - reg
@@ -55,6 +62,7 @@ examples:
   - |
     #include <dt-bindings/clock/rockchip,rk3588-cru.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 
     bus {
       #address-cells = <2>;
@@ -67,5 +75,7 @@ examples:
         clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
         clock-names = "core", "iface";
         #iommu-cells = <0>;
+        resets = <&cru SRST_A_AV1>, <&cru SRST_A_AV1_BIU>,
+                 <&cru SRST_P_AV1>, <&cru SRST_P_AV1_BIU>;
       };
     };

-- 
2.55.0


