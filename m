Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294710;
	b=keeDzyPLv8aKqJKsuFq/o0dC+el1OZ/FQt9oLvxSaXsWwrSXmHXMok/qMUNtCZmzRgsv
	 Z7TWk7brDn0NynRxiU5QZcJnrii5jdOg1jqSFDi1cYH9FhYZwlis3ldIhchYk3XtDD6+G
	 6o1hBeLCaQgkN3RE50ipIwe/m91x+GcdyrnqM81rLGqkdJe2qNdWTzgl3nK02CuVpIv5N
	 oHmzcIyD1gc68u8fBZWh58Ui/o7gOZcUNZbwDinXGtkocQRNl/k32HS4EGlixZFCDIwjZ
	 EQ2d8r3DRUn0kMPFeW7jhMgTFP7W/kQGOMA5S6w8sY3POPamUBgf+WJODnW1sp5mTNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294710;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=5f1GvIK41A8s9bIU2KEd2J1qzu5ZOqDPX/YLl0Dakyg=;
	b=1gZ7JMTMB10TeCrVyt3S5HGgYxJ90BlhrIWjBqFq3AaUv8AngfJJPyn14GUhazOgufu8
	 rg/c/GD1imkPZdkR6bUX08apfeW9mzJGSJrJVoLwU07hQjKSCIOiwbgGE0OK8sB/gvdsZ
	 eNnPLZA54I/FgiIYLzG9Af1XAqOZ42n3hjLwQMCPeBpLPv593DMkGzsRmxaKpS6NGPIsl
	 Ns7U/lnGw1OSuMWCBziBNmyxvhk5XtHJbfQlBFNUq9c/0TPRVkJM+kB1G8d4tCtJvprTW
	 XmT+VplvAQ67TH8QsgpV4qsGxRT/CsC74cz42m+9oMCI6/cxraKtyRhI+ETzrM0XLqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOdAUpPQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284EF60A260A;
	Tue, 10 Nov 2026 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOdAUpPQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294709;
	b=1HfbEMEop4l12y3NVmFb0+Zg2xQtsctKS0LppGPPP80NaUdAXt+gyhb7uT3vEUa8NSwY
	 EZRfiYe1Yetb2QQRpdq8vIHLYXJ7C6N0lLbrVWIZeSDr9qD2VfW5Z2ajH4Ohpr5MPOJMK
	 DQxwbodphbKZA/M7713YZJeiLEv/Y1JI/2kEY3u2OEXb5BNX8LxZc1gBZgBQPn8jddoXy
	 UBaicC/Jo8R7SaVAog3MxsXQBh63fCyMxS+ZLk8/489HgcC0TiClpuuK5yBpVtf7l83dY
	 YbApM+y3Z8EyP7QIt5vmmtVsy+P4QDb9rY0zY1CktDS4ZO5+l9lmn8CKUk9zadP7YIw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294709;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=5f1GvIK41A8s9bIU2KEd2J1qzu5ZOqDPX/YLl0Dakyg=;
	b=Ub1nfAZJRVo+7p/hCPsQI+muexp0b8RHuDbxQJiI5BaNd8DCvqL6Ju7ie6GYbSaP5ryj
	 lehua1I+3zkbwDN29nDcgU466gLPjIadFNLwGFhi+3OQYqcLXOXxebj+5gqxxZeaTruSQ
	 xxJN2cJDsVXTQ7ykXWiBiQGvopW3+QKlTQZ8Sa7s5KRWDCnJEnbtlEB0xvHa/MtXi0abO
	 EnA3qu3DDw9IHe6HCV21vXfmGpxLl1/6g8cDwrMzqN+okXIqpjCNGt5s5yifJtRWhDiCQ
	 4t4b3K1/UsxPc2RfkXaofD2gfnDrAptE/ka64I/fgX++Q71LH7ckCW17FlyUv0DHbCg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1BAE11F0089F;
	Tue, 10 Nov 2026 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294709;
	bh=5f1GvIK41A8s9bIU2KEd2J1qzu5ZOqDPX/YLl0Dakyg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=GOdAUpPQ/yn+8vt88EtCCwf6j9vKOY0UO67Lhh9oeUkn9M+U+yKHQVkitQ0aJ5YgV
	 vu4Q0G1+pwbTKCX1suGb3boEEAwL4eqBrCzOai4Kr/Ggdw0/ufryBKRSG5bmyDu6tU
	 M2pDLmtWrZzYAK4khiEJMhMIcbtlkifl8X3tgYp9ks5AoE7LKJNs1G4W64IYJC475V
	 GFl54Z34QlWh8D/aTlAj1K2+/OuO3mA4cm0z+BX/QjWsL1D+Z3ggaKE0Y+NdT6juYV
	 JCZIuSPIHJe3TCmiC0p1hzU5CuWojBlsLuS7qBatWQQpQbxw0qiZTnD6HSfHh0KcAL
	 J1EnqV1rifHQw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A33F54892E;
	Tue, 10 Nov 2026 07:11:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/5] iommu/arm-smmu-v3: power domain and clock of the
 RK3588 PCIe SMMU
Date: Tue, 10 Nov 2026 07:11:47 +0000
Message-Id: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQSUHFq5QuNJnoCLEhU0UQ7
 95Yl2/x/wHKWVihqw7IvInKZymgRwVu6peRUXwxWGNrIjKoMa64PTE5YUweexvINkNLvg1QqpQ
 5yP4/vt63dR1mdt9rA+f5A0Mz+z1zAAAA
X-Change-ID: 20261110-smmu-v3-pcie-pd-a2f127b81d8f
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294708; l=3396;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=YiFHdqWNwSB3JLobSnfZFcEq0DBZVx3dfBcT0SvTUnA=;
 b=vGVSbQIptB7q8Knk0YRw8Xy7JTTyVesyHrwcLDjVnBHlNDkoSbwifjktratUfAvNDDUMpG4+p
 v5zjYVT9qWFBXsurhLTIIauP1umEiJlnI1RR2u8dugIBvvQ5oXERsZW
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The MMU-600 in front of the PCIe controllers of the Rockchip RK3588
(mmu600_pcie) is enabled for every RK3588 board, but its node describes
neither the power domain it lives in (RK3588_PD_PCIE) nor its clock
(ACLK_MMU_PCIE). Both are held by any enabled PCIe controller, which is
why nobody noticed: on a board that enables no PCIe controller in that
domain (an Orange Pi 5 with its M.2 slot in SATA mode, or any RK3588
board without PCIe), genpd powers the domain off and the clock framework
gates the clock as unused after boot, while arm-smmu-v3 stays bound.
At reboot, arm_smmu_device_shutdown() then writes CR0 and polls CR0ACK on
the dead block, the interconnect stalls, "reboot: Restarting system" is
never reached and the board only comes back ~90 s later when the
watchdog fires.

Patches 1 and 2 allow power-domains and clocks in the arm,smmu-v3
binding (arm,smmu.yaml already allows both for the earlier SMMUs).
Patch 3 makes the driver get and enable the clocks of its firmware node
before the first register access, for as long as it is bound; nodes
without clocks (and ACPI/IORT systems) are unaffected. Patches 4 and 5
describe the power domain and the clock in rk3588-base.dtsi. Both DT
patches are needed: with the power domain alone the clock is still
gated and the shutdown still hangs.

Related: Pranjal Shrivastava's "iommu/arm-smmu-v3: Add runtime PM
support" v11 (2026-09-29, 20260929034510.2023173-1-praan@google.com,
not merged) adds pm_domain-based runtime PM and resumes the SMMU around
shutdown, but has no clock handling. This series is compatible with it:
once it lands, the clocks from patch 3 should move into its runtime
suspend/resume callbacks.

Tested on an Orange Pi 5 (RK3588S) with the M.2 slot in SATA mode and
the root filesystem on the SATA SSD, where every reboot used to hang:
three consecutive reboots printed "reboot: Restarting system" and the
boot loader started 0.6 s later (previously ~89 s, from the watchdog);
clk_summary shows aclk_mmu_pcie enabled with iommu@fc900000 as consumer
and pm_genpd_summary shows PD_PCIE on; the SMMU probes as before and
SATA keeps running at 6.0 Gbps without errors. With patch 4 alone
(power domain, clock still gated) the reboot still hung at
"arm-smmu-v3 fc900000.iommu: shutdown" on the serial console. Boards
with PCIe enabled are already in the state these patches describe.

This series was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit messages, and I reviewed and tested
every change as described above.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (5):
      dt-bindings: iommu: arm,smmu-v3: allow a power domain
      dt-bindings: iommu: arm,smmu-v3: allow clocks
      iommu/arm-smmu-v3: enable optional clocks
      arm64: dts: rockchip: add the PCIe power domain to the RK3588 PCIe SMMU
      arm64: dts: rockchip: add the clock of the RK3588 PCIe SMMU

 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 10 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi            |  2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c              |  7 +++++++
 3 files changed, 19 insertions(+)
---
base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
change-id: 20261110-smmu-v3-pcie-pd-a2f127b81d8f

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


