Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794471624;
	b=RJL8En2uiumQJHfPc2A1AiSFXjGXh8F8HSp+RrDwVoymH8JHpnqdwHE/5NzH7wxkEeQA
	 zgcsHbJc2yw1GDLsMnNTHo8UcFF37Z3GFOXK7Az9tr9EUHCThQwkpMjxva2UamOz6zVJJ
	 jKcmuOw0N3Sk5/hQR9p6TRRUrV5Mn019DE8uL8g7UdwLikw3HNsXTzB+InUvlQP0eZzJM
	 Hl2ui/dl0s1iBA/GKnCwNokQzVcsfZSLUc0tatjNl49rZWpGOjIW4Uw93TB6TEOC7kUVs
	 t+OkbqaWL22iIsN+pU2hJ31unYYYeKBEdlizfG9A+F7BmokhFPN4AMyy6o+2V6XPhSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471624;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ecJOhMtckVs+eDoYzRxG0i8XtHYcYnv7fysapUUGyQQ=;
	b=wy9Px+TRRBt0Dm6kYuGwgndE61fnTJ0e3kUuqy6SzIkaKaxmV4JDWADwSwavbnuu0gVz
	 hwjYkl8+8+EUhGfx+tgFWXwcGRdhgfI/3KvMacl/xFy5zph9O5CShqEVCJr5We1nmO8mf
	 QhGrHTULsxRyXhximWEmIGmDqu2ERfVa1SG4BaEZfZH9wNtsvzDzwdtQ/1VR5lRnfb3OL
	 O1Zj+nEszN+6BEYNboyDshZfAGf7C07fiqPkqMRP4mDh1SdWhRWJ5R4SvoNZbFalHaend
	 gMKN88U76VoZ+Rpk6ZWuJ0nI4lc4pwgoeeENlrAbUVCAK4huOJtL3uSPfLHIG/d/Jvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anfNTHdN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E2606A333;
	Thu, 12 Nov 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anfNTHdN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794471623;
	b=KW4G0IE2gRi8W8KRymy9+IqceXSVDHx4b+qDnZkTiq/CgSsASjLMMgOFYTPdkTBDOkda
	 Sbb2U8q4KUYczS2PjoOK7+otLzIIdn2YMhP6KgEV4WHXe3ZfXGN49z9KkUPgPrfEs2Dc+
	 0r0RMhmr2Yvfiiy4u+Cf2Qggo7x0r4TF/KSIqUvW42QpY89HwXqIteUc+LGqZInBN8lzP
	 DmtGkcsYFGlaNtXrQA7vOczK+HqybCtwBLR7yykhN+7nXyGz1ncG8tuoOib1TZrlWAIk7
	 EwcsSABbZUrm3xUl8lSfr+9FOMYy6VNENsr1kpFolPCB9znqjQj06AdhwQwYrNgTQkA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794471623;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ecJOhMtckVs+eDoYzRxG0i8XtHYcYnv7fysapUUGyQQ=;
	b=L/oCXfZDSqODutPuLWxY/8DbUR5TFaBThrVaoPgiQLsPfUdAUAcYqzpYYDxkD/rNkTg1
	 pRbjDCJfMdmO8jjt7tu/9951Sl5R8tTGav8GC7hunMkKmfIpgsoiwF4I+lkT3Pjha/85S
	 m04h4KKeSzWfRadnL5rEIPTAPDIYF4wUYp1/vYGOXno66+wIwF0HsAwmyA+59qiXVbFNz
	 Aee/ymuBpOZtxzTMbTqB/X5YDvIb5NwJz2RV0Ck/xaQrsINKJaLBf7NpDG2ct3yxLyNM8
	 ex5zIoMf3uGmcD9V8kDcgGQpBJxtOphqO1Hsru6xA2qWOu8DocifTBDViC6yMnm9TgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B297B1F00A0D;
	Thu, 12 Nov 2026 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794471623;
	bh=ecJOhMtckVs+eDoYzRxG0i8XtHYcYnv7fysapUUGyQQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=anfNTHdN+vwJh80ie0fpt+1kytwAdvwFZHr+R4vPvazrfjL0b3tnrZHqYG2CE2xnp
	 Pnu6x3ENO/JMrw4HE6UW2eQizJRYpsqGAjJWxYDFnVubKfYfwHjRFf22taQMpv3gTl
	 IhsNscYvVv9YPWsQJ+o5JUXpPPcqGN5ryCUJE6x3X1BWOHgAPVc1gpjA+0ljJCKpbL
	 ioYCre5geD/Fxo1PLcZwOkcDyKU2yBgfpJBvnPJEJdpF1hgVRpgFGRRiCWU3sgN4um
	 XjTzdfFN6SMl6TZfKmr6uq7GsSSCWvYluemYr30Vse3EunGB/12NTwHCY6rSsgncm5
	 hLxNwFAUIMV0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 41F6E4933E;
	Thu, 12 Nov 2026 08:20:22 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v2 0/4] iommu/arm-smmu-v3: Keep the clock of the RK3588
 PCIe SMMU running
Date: Thu, 12 Nov 2026 08:20:21 +0000
Message-Id: <20261112-smmu-v3-pcie-pd-v2-0-3a77bbb6b2c4@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jm7RimEiyuvIdhUcoAYyyQFhoN4
 e4Crl2+5P33FwjshQPckgU8Rwky9BuoUwK2M33LKPXGoFKVE1GKwbkZ4wVHK4xjjUY1pK6Vplo
 3sK1Gz428j+Kj/HGYqyfbac/sRidhGvznuIy0e//rkTDFXGlNhTVZVhX31hl5ne3goFzX9QtxP
 uE9wAAAAA==
X-Change-ID: 20261110-smmu-v3-pcie-pd-a2f127b81d8f
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794471621; l=5863;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=DkGzQiw1cBGS69FGdw2AcOqjm+Tug1xqo0D7+l5vEX8=;
 b=IyHe8/KO76DpK5zSytR2RN9mGIzx3+58yWoQYkcN4ujMiTSnyvnKAY+QW3ksZcCcMbAeGnwC6
 MtvSmkHnoCWAJNRQIlfxWg4rMd53iDSSl9y2ZpGRU1B7OTw7tzaedDc
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The MMU-600 in front of the PCIe controllers of the Rockchip RK3588
(mmu600_pcie) is enabled for every RK3588 board, but its node does not
describe its clock (ACLK_MMU_PCIE). Any enabled PCIe controller holds
that clock, which is why nobody noticed: on a board that enables none
of them (an Orange Pi 5 with its M.2 slot in SATA mode, or any RK3588
board without PCIe), the clock framework gates the clock as unused
after boot, while arm-smmu-v3 stays bound. The SMMU registers then stop
responding: at reboot, arm_smmu_device_shutdown() writes CR0 and polls
CR0ACK, "reboot: Restarting system" is never reached and the board only
comes back ~90 s later when the watchdog fires.

Patch 1 allows a single clock and a single reset in the arm,smmu-v3
binding (arm,smmu.yaml already allows clocks for the earlier SMMUs).
Patch 2 makes the driver get and enable the optional clock of its
firmware node first in probe, before any register access, for as long
as it is bound; nodes without a clock (and ACPI/IORT systems) are
unaffected. Patch 3 describes the clock in rk3588-base.dtsi, and patch
4 the reset (SRST_A_MMU_PCIE). Patches 1 and 2 are for the iommu tree,
patches 3 and 4 for the Rockchip tree once the binding is accepted.

This series is related to Pranjal Shrivastava's "iommu/arm-smmu-v3:
Implement Runtime/System Sleep ops" v11 (2026-09-29,
20260929034510.2023173-1-praan@google.com, not merged), which adds
pm_domain-based runtime PM and resumes the SMMU around shutdown, but has
no clock handling. The two are compatible: once it lands, the clock from
patch 2 should move into its runtime suspend/resume callbacks.

The second MMU-600 of the RK3588 (mmu600_php), which Shawn Lin asked
about, is disabled in rk3588-base.dtsi and is not changed here. Giving
it the same handling, as Heiko Stuebner suggested, needs a test with
that SMMU enabled and is left for a separate series.

Tested on an Orange Pi 5 (RK3588S) with the M.2 slot in SATA mode and
the root filesystem on the SATA SSD, where every reboot used to hang.
v1 (clock and PD_PCIE power domain): three consecutive reboots printed
"reboot: Restarting system" and the boot loader started 0.6 s later
(previously ~89 s, from the watchdog); clk_summary showed aclk_mmu_pcie
enabled with iommu@fc900000 as consumer; the SMMU probed as before and
SATA kept running at 6.0 Gbps without errors. With the power domain
alone (clock still gated) the reboot still hung at "arm-smmu-v3
fc900000.iommu: shutdown" on the serial console. Boards with PCIe
enabled are already in the state this series describes.

v2 (clock only, no power domain; patches 2 and 3, together with the
separately sent CMDQV fix, on a 7.3 kernel):
again three consecutive reboots printed "reboot: Restarting system" and
the boot loader started 0.59 s later each time; clk_summary showed
aclk_mmu_pcie enabled with fc900000.iommu as consumer; arm-smmu-v3
probed without errors or deferrals in all four boots; the root
filesystem stayed on the SATA SSD at 6.0 Gbps with no ATA errors, and
the kernel log had no warnings.

Patch 4 only completes the hardware description: the driver does not
use the reset, which is already deasserted at boot, so the board test of
the clock change covers all functional changes of this series.

This series was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit messages, and I reviewed and tested
every change as described above.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v2:
- The existing Tegra CMDQV reference leak on a bad #iommu-cells that
  the Sashiko AI review of v1 found is fixed in a separate patch,
  "iommu/arm-smmu-v3: Don't leak the CMDQV device on a bad
  #iommu-cells", as it is not related to this series.
- Dropped the v1 patches that allowed power-domains in the binding and
  put the SMMU in RK3588_PD_PCIE: the TRM puts MMU600_PCIE in PD_PHP,
  which Linux does not control (rk3588-base.dtsi has no PD_PHP node), so
  no power domain is needed (Sebastian Reichel, Shawn Lin). The hang was
  the clock alone, now tested on its own.
- Binding: allow a single clock with a description instead of up to
  four unconstrained clocks, and say why in the commit message (Sashiko
  AI review, Sebastian Reichel).
- Driver: get one optional clock to match the binding, and get it
  before the firmware probe, so that a failure or -EPROBE_DEFER cannot
  leak the CMDQV device reference (Sashiko AI review). Its comment now
  only says why the clock is got first (Sebastian Reichel). Sebastian's
  Reviewed-by of v1 is not carried over, as the patch changed.
- DTS: the clock patch's commit message now gives the whole cause on
  its own (clock gated as unused, SMMU registers no longer respond, hang
  in arm_smmu_device_shutdown()). Its diff is the same as in v1, so
  Sebastian's Reviewed-by is kept.
- Added the reset line to the binding and the PCIe SMMU node (new
  patch 4) (Sebastian Reichel).
- Capitalized the patch subjects.
- Link to v1: https://patch.msgid.link/20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com

---
Arun Iyengar (4):
      dt-bindings: iommu: arm,smmu-v3: Allow a clock and a reset
      iommu/arm-smmu-v3: Enable an optional clock
      arm64: dts: rockchip: Add the clock of the RK3588 PCIe SMMU
      arm64: dts: rockchip: Add the reset of the RK3588 PCIe SMMU

 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 11 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi            |  2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c              | 11 +++++++++++
 3 files changed, 24 insertions(+)
---
base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
change-id: 20261110-smmu-v3-pcie-pd-a2f127b81d8f

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


