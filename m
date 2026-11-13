Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588038;
	b=AtzwhQ2JXh6tJ7iEjI1I/NLb8GD3TRgVrBA+01T1Ch37HKS/KBIv9qirACmRaL8guZV1
	 U5tRh225mTAELZJCxQJJOtLj9uBUkLfk4ni5cvw2vhWO0loQGv5aMRjzQ5KA3k39fZYpr
	 /j0yzJlM0u5FXIy7cjRP2JEnDALQNBAf4a3cwk3+r8Glbj2MjnjhQgb020IfYi2JSt7GW
	 em9LdBN+WaxpwMhIY5BpBPHsc0UVHlbv/cCuPKMarJD6FJSe5xasWG2KCLxWeHbiXTyuI
	 40P/ukJ8+TqxNNo4kRekypXe+bXkLGwgg3TQU8RNWdHcW5m8RKT86EQTSemTe7ha3VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588038;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ea52I2vnQCe6Ni6efkUTjPrh+GmNSqV3kj5+yTLJAXI=;
	b=kCCiu0BvG1qj5Zh4FVj5nP8f4W4wjxLQbpu6vrzPGNp7IHg79xIzvsiopCagtq7HJRWK
	 YYoam3fxidrtM5uuVgYo4/WX0M/pLq/wBGoKJ895+/QpgbWc9GEZflvU5frk9G/5dI5So
	 2IT+m43uLeCbRrSZO012GdgA+gIurjyUR5bAfbYfLDhDz6qBrg3vt8L5y+J8qvBdH6EkT
	 rx0eGidneyE3vynSsP4ekR33I7jF9cANEOWzhEw/pA77sB3+/whdKNnE6MzGWy7l6ELTZ
	 K4hXKq+nqUnmcMTjSIjo35DZ3NVuPzxEKbwLVlQ0CRGezzQqzhi2GhPf9QrJ1ROVoRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6z+1PLw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B7606EBD8;
	Fri, 13 Nov 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E6z+1PLw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588037;
	b=rWHVYq8EWtVlBdkATnfY2VCI5cA5S5Qq3/Kp4u0Vm6u6e9QMk3Ly6EClQADtmFqvNjb7
	 JkD/oFtXcVZbnzzvdKNmFu1uIihZXgA+FUJYtvE8sw2cx/qQGwQW8U5C/ZrHz0TQQsPfh
	 z27/HnOme71boanfhwtjsTo14qd0/30AtQo+W8sGhIChhHA8GYcGhw75FsILTxt2/lYB9
	 4wxlEw6hhq+HIiqi4rAVBvi/BNyKDNqTIlFnKzX2NbsGwfqpruoOo8DYIYxzIKAGKmJQs
	 m765hfgxQtDa4nVla8b2VfGjCm2x38HP7weUCV9bWqlFWfFTBHiFzmjlqbv4la3HUmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588037;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ea52I2vnQCe6Ni6efkUTjPrh+GmNSqV3kj5+yTLJAXI=;
	b=iIu5mM7nW7jMxPT7HweHlWsQ9iZC3mrOkaJf8VnqqwFw4/M+2tPWrJ/kfPJNdLFcTwe1
	 u98XgGcjNTABdZ8bJEe8fk7yklwqQNhnMwIIjDSmqeP4a8UBsW93F5uqGcYttTK7e5P9m
	 RxpEhIZENNT61dJ3lJ5SptNSh7LBbrW5XQ07xGrW9dkdr64zPTArlhdUXA3sGLTepSVYq
	 nAXZkdvetotubfwYOyHRIPZB94VKQ7OBCAUsQMatBR1fylXbW/8ksyCqA5TA/8sSA/f3m
	 pP47DoEfOYYIByKQFk8KjbcYocHFqGWb3Y6vNJn3N660nOW7U8Mu1myEpFLIkcJvkiw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0CE771F00931;
	Fri, 13 Nov 2026 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588037;
	bh=Ea52I2vnQCe6Ni6efkUTjPrh+GmNSqV3kj5+yTLJAXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=E6z+1PLw8ZgAazWXSe/Qw4zD+zAqi2H3Z5Kcwfn7C/AiwBCNpw28yhjPMtymk2QuB
	 P6sSxXZzhObCZtfShROoo2fgNwwI1B4xqlVDi8I30JsJcUqug85DI7JUatjjPVryWR
	 WZvVrz8jRD8cH+CKvqQza9dTw9KTakTtcX9FpXayjtAd2dHd3iA9aPbGL+Y/Z8JR7q
	 FfYI1hrx3OxBWNjo923169tWLrmZ567rMD5z5DW7ApxFFm5BHOFc3pMeMQi7FEqLgj
	 rTxJoqUyokjDYaI9ZwNyIuPNSPfNWs72fF3EQeUA0pV8xjCol9YNxVR11UUcc1qAxt
	 jBKTFUTIfgW0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A7008499FF;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:42 +0000
Subject: [PATCH v3 11/12] arm64: dts: rockchip: Add the reset lines of the
 RK3588 VEPU121 cores
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
Message-Id: <20261113-hantro-robust-v3-11-82383c722ad2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=2128;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=pWGgDNReqboxSyr5VfPbRCUDYTeDvzJsJNZ3jQadXZk=;
 b=xlaQlRPGNedb+7Aggz+XzrrJ5V2GEFZb3cM3x2htpaw4NA4fX5zQHfHCaZ26hKfcMjd+YQkLU
 0XqMYpqifR5AhYVZjF+SM+b95Ukk4rvYav9GDAd5ZwXPXSEPWJMgVFE
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Describe the AXI and AHB reset lines of the four VEPU121 JPEG encoder
cores, so that the driver can reset a core that is stuck after a fault
of its IOMMU.

The IOMMU of each core sits in the same register block and is clocked
by the same clocks, so these resets likely cover its bus interface as
well. This relies on the driver not leaving the VPU in reset after
remove ("media: verisilicon: Don't hold the VPU in reset after remove").

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index aa69fd3793fd..227465d446a2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1325,6 +1325,8 @@ vepu121_0: video-codec@fdba0000 {
 		clock-names = "aclk", "hclk";
 		iommus = <&vepu121_0_mmu>;
 		power-domains = <&power RK3588_PD_VDPU>;
+		resets = <&cru SRST_A_JPEG_ENCODER0>, <&cru SRST_H_JPEG_ENCODER0>;
+		reset-names = "axi", "ahb";
 	};
 
 	vepu121_0_mmu: iommu@fdba0800 {
@@ -1345,6 +1347,8 @@ vepu121_1: video-codec@fdba4000 {
 		clock-names = "aclk", "hclk";
 		iommus = <&vepu121_1_mmu>;
 		power-domains = <&power RK3588_PD_VDPU>;
+		resets = <&cru SRST_A_JPEG_ENCODER1>, <&cru SRST_H_JPEG_ENCODER1>;
+		reset-names = "axi", "ahb";
 	};
 
 	vepu121_1_mmu: iommu@fdba4800 {
@@ -1365,6 +1369,8 @@ vepu121_2: video-codec@fdba8000 {
 		clock-names = "aclk", "hclk";
 		iommus = <&vepu121_2_mmu>;
 		power-domains = <&power RK3588_PD_VDPU>;
+		resets = <&cru SRST_A_JPEG_ENCODER2>, <&cru SRST_H_JPEG_ENCODER2>;
+		reset-names = "axi", "ahb";
 	};
 
 	vepu121_2_mmu: iommu@fdba8800 {
@@ -1385,6 +1391,8 @@ vepu121_3: video-codec@fdbac000 {
 		clock-names = "aclk", "hclk";
 		iommus = <&vepu121_3_mmu>;
 		power-domains = <&power RK3588_PD_VDPU>;
+		resets = <&cru SRST_A_JPEG_ENCODER3>, <&cru SRST_H_JPEG_ENCODER3>;
+		reset-names = "axi", "ahb";
 	};
 
 	vepu121_3_mmu: iommu@fdbac800 {

-- 
2.55.0


