Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294711;
	b=4z+0FhyydEPeRNgOIv8LVsxKWlDoAjhQpZMKFJEEX8qYjnDPX5uiogmwbylyLiaHRRRq
	 VksR02EY6gbzgV5nP6RS7gmcsfUX4aB7ZIVLhUMFzhiFEIsb0SxK3xflo/bDcQ9urzxyN
	 OQjqtLACA5MpmCBIIziy5LbXTvhnuwX+15nN7oobGe2UOiKvLmAzAj/MVe4ebCglDFizy
	 8j0U0nnphUvt8runYOKhRDCTAifrQsZ4FJ6PzfouzWDpNyNYELatJJCVUkXwSzqR6PxpG
	 3rPNummNMP0iqllA8M+GIlXVoCaRvZsXCgBJv85trml6Qbge6jBxGs+DwNcQfVmzw9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294711;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BlGCS7+vHVkCstdONHb4lplbAMJsQFpBwNtspRDMc5s=;
	b=m14ovg2i7EdhdZtIF880OzdLl4oypbm0PSfxLxmCxZNlIQJJaQYjME8pbfFDA2Arvzw0
	 cLiQEbBaoSIG/Ls0vX7qPM1BO8N9qZZabaj62TTso3j/zEEMckSxMUqnIqYpWti1vNKu4
	 /hEAiuxJ5f0rTKmd1jQM7B4+2L7l3HFcYjRyK+N0pmt6yRyGypjvlUHfEXsfmdXyeISQZ
	 Jlj6xcikz6icVOb5ISXk7+246JbWLVa6n5R+6BdnKKbqU4IkLAQ9ZaxEGq1nzzhEgM5HI
	 RFUw65iv1N7Xd+li4pU8uPQD86AXeDsDyz+avjvg95zsLyUpS5CVCsvhRI2NOMCyEtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esPVOOLa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255060A2601;
	Tue, 10 Nov 2026 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esPVOOLa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294711;
	b=0M94otHKyl4mudNDAt3db1l+rwNo0ipUqBKBDs4SFK5tlzVAOWslHGgVANsCR80mJ0DD
	 AHKOLJ4maP2KdG68M5StKKFoFyio9fPnwIcywgtWmzLEodYPFVipEu7D7dzG+P0/f+U3E
	 /rCP0dqX9kncj8Tl3hxWE5Y6ewkNrL0DMd/mzC31H4Dk7C/9rDmyCovdP5B47iu6uGbvf
	 hEDLEfc2MwVFTPc3tv4seMyZ8apn43EGjVN3JPQvP9OMelamdjMxsalzLru/TTmK2wFOA
	 /YeXcqio7OT/X1vo7iHY9K8sIpM4ayHwoXCY0FCpl0q13XkoxfXB8SgWH/3VtSAnuYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294711;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BlGCS7+vHVkCstdONHb4lplbAMJsQFpBwNtspRDMc5s=;
	b=2OxjPiFkQSX5kWQ03hKUjiAcFtD7MKDSKUA4Ud/KelQlUz8uoZ7CpvaNbqOyPf6OdAIr
	 IGU9yx9b0WXlLKH79TJR/I7B88HIXf5cGQdDwUVfl9QRK60Oc8WYJzshsN6SzQrr1VBhe
	 viS9SLaARjx7YBMpx0V9VkKUkE7ymMQVEayzfoi4K31/4zSyKzDvD+1L9B03VZHbcPubK
	 620q+f66sQJ7lwQXYN7QSo0aAWak4EnqM2TRrJVuZYPVvfjMHHCiCMsAV76wdwzQhzxnI
	 UEoh8s12ht0JwWxvENUfC9Z6vk67ZpA8JmmIiuHjNBelPQ7haWUYSfsytsYva7JNBLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5AF0E1F008BE;
	Tue, 10 Nov 2026 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294710;
	bh=BlGCS7+vHVkCstdONHb4lplbAMJsQFpBwNtspRDMc5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=esPVOOLaMVT39KsaHoKCU3BrHLcXfeldeZ9alhMawxuZDFCOYNlelVdqwksjFQfsz
	 5kQ+KLrqd5zL+Nst4pLfLM7u+QcigCSvO3q5tTXxxExs0RSQqmYigKoQcoh070SKGG
	 Cac6KzhUSt2yDvygQKP+OKUsYhHignxby4ImqMDYIbO++obf88ZuaMMkU8uhkAHmXB
	 KdB2hMpGXMHH5tWtXrBkGYuyUhkUUwYcdtOgpfbI59vHzgl2ATdLvaxQ6NsvBCKf2+
	 8muu29sXN8ZOlPOOwwQMeSOOG99gwntQ7t5IGtYclamwVvEUMGGJFZN0VKitRjHV6Q
	 J2NfqAZqNh27Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0609E48953;
	Tue, 10 Nov 2026 07:11:49 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:52 +0000
Subject: [PATCH 5/5] arm64: dts: rockchip: add the clock of the RK3588 PCIe
 SMMU
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
Message-Id: <20261110-smmu-v3-pcie-pd-v1-5-628819ca44b9@gmail.com>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294708; l=1149;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=bLcKcj+LRANwxoiMM46Cd89sIDqhd3QCt7Lj2mURtSQ=;
 b=z/amT++A9MqE0D1vOB9Z/nfaV7eqMvL0FbII2ljxfJoqQxQ3SwBJ94YvBvnKfIr81kZIptXkc
 /SnPZWdCfrxDT1hrAOLYlG9Pag59fuWPCU3SGV3HxnyEFzaypVbR4VF
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The PCIe MMU-600 runs from ACLK_MMU_PCIE, which is also the parent of
the PCIe controllers' master clocks. When no PCIe controller is enabled,
nothing holds it and it gets gated as unused after boot, while
arm-smmu-v3 is still bound to the SMMU.

Describe the clock, so that the SMMU driver keeps it running.

Fixes: da92d3dfc871 ("arm64: dts: rockchip: enable the mmu600_pcie IOMMU on the rk3588 SoC")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index bcd342c025c9..8eed22ca69ab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -559,6 +559,7 @@ mmu600_pcie: iommu@fc900000 {
 			     <GIC_SPI 374 IRQ_TYPE_EDGE_RISING 0>,
 			     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING 0>;
 		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+		clocks = <&cru ACLK_MMU_PCIE>;
 		#iommu-cells = <1>;
 		power-domains = <&power RK3588_PD_PCIE>;
 	};

-- 
2.55.0


