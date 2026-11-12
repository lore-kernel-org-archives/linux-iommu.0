Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794471624;
	b=DNs9fMBfbV3zvApkl99EeLxbNo/1MpDkM6ymdqKr3UbYxNs2af3FE69IhMLQQxbpsx1j
	 6Y6wRDhLsa7Lm8fNkErVyxQLRVkQgo4X0SI5OZvBI9oSXVpulflqamYKOKvIBH3HB6DnF
	 sdKP9SHPS+4eliVQiniQHXPOg9l4ybF10Mh0xhYfYnXfNQbs0AezxOw7ysxvmizyqU2F6
	 R9SsAmaVTWu3mx1z4ME0gtUK5gaz+tCJ0mCmJwnsa5jzDa22FHOD4/z8OQ4iw6f2+lPDp
	 Ky5T3dwvfpM4Sc3v/CLdnjfDBlakryoo5T82oAEnZU6I473anhkEvY8FNFyEXvsi6mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471624;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Dqc75Um4x4s4KdFptbcUZrqdn2XgXjk1Mqp7t2vN8Tc=;
	b=xlJqw+WZdfCVpvSS97fhGYd3yQP9po0LFQxsW5hwJwhc86p7FxKJdP6sxaelN5G03a7Q
	 WaTEiNRuHTrJLwnkPCvBwQS1OBKKOxvxKuw3IUsfgygU0vTg0UyIAQjEUQ1GdeK8yHuei
	 P6qLA9uQb/xYAyml8y945nzIrAgqeVK4L/c5cJ+hXZyh8vK/ZwkcY66L7nDY4wGQ8l3yY
	 io9ivZDRDZxi68zzYIWjGiFMcnp7zBuVkhilo1swUhTnQ278gEFz5rVcO50EETrRoHTp3
	 E+SJGpXMfy087fneEkdjgNHjT8xZ9+rhfXgt1F9nh3VrUFcmTD934PtgNKkyTsW50dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxwmNrJ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9B606A334;
	Thu, 12 Nov 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxwmNrJ6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794471624;
	b=GwTEaWYJQLt692BqmLrL9SGVOkZIASTzNHsJsLB82hfQqWZt54W4iGD92uJPEd71Rha7
	 bV7HE/7U6bRy7JlqQWa1ygcxkxjqyWLKFa1E7ypXLoqVhKqstyJfE+97JRgK+UbrnW3YN
	 ZBskLVtDISMhoidzoGe5IjoLyfhkTgmrDkiOsUAxMKdx7xw1wz3r9kDVcxS1YcsVNGpIi
	 As+/1t7CzzJmIoyS7b5D8jq1o2Q8bK1bciGSSpLUQsbwdUfzZ/Smpcwp2dg/pR+Im0std
	 gfrM1sjtskYZ8NPtPiyfB02QGIESNyoeZfCFP7TP7W1akk/7zv5+d5oS9Wl0vKS7dVg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794471624;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Dqc75Um4x4s4KdFptbcUZrqdn2XgXjk1Mqp7t2vN8Tc=;
	b=iTdHR8A3jUoHdFybW+fani4vtos/XVyznDEnNFvQOlDjv2w1YP7OKaoATJDKHFh6bgxo
	 yPgp97kUsn2zLPqU9xUMwukEICmnBz3EWC0GLKzpIuatzODieHOa0iOMzFvE05XYcEg26
	 kWU04Rf3iZxWWFAGR56jSOEjzczrUG2q3dBrncYVaq8balQuamCQPyfZ1taPkJX9aUiro
	 TlvKwxbTBBZrpyP89KqOocMw9KQ6Ce8QnYlWlV7fr/4ysNrzZjXWqeoA2Za+ANLxDYmD/
	 f+8gsdS1jbgh1yYs2GJ3gLqJxvmRluGwW1i1oX/lAna64LSFrsl6RmKPdiLeoreEOhA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EE9711F00A13;
	Thu, 12 Nov 2026 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794471624;
	bh=Dqc75Um4x4s4KdFptbcUZrqdn2XgXjk1Mqp7t2vN8Tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SxwmNrJ6FI2VXIBJ26KDWePQPZ1/2+zKKLwh+lcrk0TzTipjHvdcRq8q9j/7AA62R
	 H4DXUKd59ZpMjNyJUYiA9340BnidAi8pLKq1PYSjiP+SHm9/QNVdCG8/mr5zq87pLV
	 BYLHR3KEeYUjxUb2NIIOoSdmAsVE2j0VC4IuIAOiRscjxun0W/0ldVjRnPbGllMJwQ
	 mfY7aDIVHcxXL8Kmk+3plUmx4pqJBDq99YLWao0cPGHwih5Bjo1K3gq6qhjZIexxoz
	 0ONOFEPPJP1eadnSxPAILDiFBeSb7Uvfw30GY+elzbJfJCLJ85rcY4MTEkirh3e9JH
	 tXVdugxWsPd7A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7B0FF4934D;
	Thu, 12 Nov 2026 08:20:22 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:20:24 +0000
Subject: [PATCH v2 3/4] arm64: dts: rockchip: Add the clock of the RK3588
 PCIe SMMU
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
Message-Id: <20261112-smmu-v3-pcie-pd-v2-3-3a77bbb6b2c4@gmail.com>
References: <20261112-smmu-v3-pcie-pd-v2-0-3a77bbb6b2c4@gmail.com>
In-Reply-To: <20261112-smmu-v3-pcie-pd-v2-0-3a77bbb6b2c4@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794471621; l=1677;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=bT4wW5fxE+lRE4iUQ2xEu2GNE9wpr1LdQatMTtwsJ4Y=;
 b=GhAq+MnnkgyIMxuNGov5TI+kHb/LxReTEmJLO905SXhtYgwWC85vQO5dIvKil11OUOwvvzYYG
 otr73P35N7oDWlqt2Qe+SGga2fJNEi74Q0coyoMuI4LBhq9vTEUKNEb
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The MMU-600 for the PCIe controllers (mmu600_pcie) is enabled for every
RK3588 board, but its node does not describe its clock, ACLK_MMU_PCIE.
That gate is also the parent of the PCIe controllers' master clocks, so
on most boards an enabled PCIe controller keeps it running.

On a board that enables none of these PCIe controllers (the Orange Pi 5
with its M.2 slot in SATA mode is one), nothing holds the clock and it
is gated as unused late in boot, while arm-smmu-v3 is still bound to the
SMMU. The SMMU registers then stop responding: at reboot,
arm_smmu_device_shutdown() writes CR0 and polls CR0ACK, the kernel never
reaches "reboot: Restarting system" and the board only comes back once
the watchdog fires.

Describe the clock, so that the SMMU driver keeps it running for as long
as it is bound.

Fixes: da92d3dfc871 ("arm64: dts: rockchip: enable the mmu600_pcie IOMMU on the rk3588 SoC")
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index aa69fd3793fd..dfed34a8aa57 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -559,6 +559,7 @@ mmu600_pcie: iommu@fc900000 {
 			     <GIC_SPI 374 IRQ_TYPE_EDGE_RISING 0>,
 			     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING 0>;
 		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+		clocks = <&cru ACLK_MMU_PCIE>;
 		#iommu-cells = <1>;
 	};
 

-- 
2.55.0


