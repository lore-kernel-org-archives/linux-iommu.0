Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795686879;
	b=Lt3blWCSXmpwIgEblh30q+53epiHjPgaAlJsmUEgYURsUhmzr8OC/vgAIUCJHwJXZHAG
	 KsWFQp6Lg30MFpzvBCe4d6l6Y3cwdQREIfe+P06tDUCMSS8urs0FbuWsW5fcX6sxTO7a1
	 jL5yrBHOxoApMWYqHL6Tr3n38ctM27s7tINX7iX5IkdozOdn4lykUo3oalHPvBYnLF0Yv
	 DAlGBwsRCcHiLJekthDLR162SRosrnjf/SEvZHQsxRDx2m1nfpQzFqlxLkfTGXs9EYJGP
	 YBNIaiNmzNQKBRgtZrNd/zM2DzAZXSNVZjkjN0EwU89Prq/cSvblEO1IThwpT6gRGIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686879;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=LrXkkhn+csZHwC0v+/65n16FhGVifrxEgQhE/Pa5wFw=;
	b=WpbYt3WvdobSnobtjpkw4MEQLBABvx+z808xegH+PkXG+n9N8zQezDGA4sXm9/6tNbe0
	 hifTodihc3fPNdYbSEkFuR/NUuIkHsqmr1piik96AYiMQZMS3gTRHXF40Lak8btrgtQFw
	 8/EQfsrC0JViYJiVfQ/3+DTKNMJu8PVATz3nGuByDd0LiDo1fWtcnS+R3hKcDhV1PH5+5
	 otcU9k/Cjpb1R7SDXNRTaAQifN2o71G06ixDbxcjxKzTCmmjdeob/N7xmVYd6y9/dMHhe
	 +njF3X+vL0KiUnRdncjnO2BNGcdEGgqCEX4AMObw518RLfPa+kjrYX32SxbcgPREd/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+3nfrFb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389A606A31C;
	Thu, 26 Nov 2026 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+3nfrFb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795686878;
	b=TDi1yMZh+0pTTnRJaOEDo9LEQJ7EfmonNLsLcLZ9XHiaPD2Xsr2coH3DTIoBfczFEOKd
	 SBz+zIA5UUo3fAaeLZDA7vB5S08YYlht5mDfsiUQ97Hk6JSK8dnykprjfgJBrJLCzFjwO
	 v61ynUBVGUJMNlkaRpHL27cSywkYKILvLHW35NLrSz5iqkOHMDKBY3GgCYtnD+/ACRfj2
	 AR9MyjZaS1bM5+zCjx8oLasv1WoGl3eKod3ksOVrrHCXhs8Oxc1rsSd7mBKRA71EW7OAS
	 S7efwz1GcVBOoGXpBtlhdInujsSNcAmukvmWJLZ/Z8LmCRStjmwk25rfS3/hbDGOvXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795686878;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=LrXkkhn+csZHwC0v+/65n16FhGVifrxEgQhE/Pa5wFw=;
	b=fh9wQmP/9fVf4DStKALhOi1haMRb3WJNKSq21SMdDFeWCsc1eMXjNTL/51QejcxIB2ww
	 Qvo363Pv/St0z13kCFlCgaQ+AOKCu1fvXL6LpasE6VH7O5BHRyAw6z1oFu49FfxeKojY+
	 Tom3GdowWO1EctIhx+yPahGJfQrwhCK2VqgtUDNXbG/ANi9aIT4dy3z3sKM0cne2iMgIC
	 Fkd+RDwp11TIIiJdfzzLP83eSvBJmsMMSf29AvVPnxE6oFrzYtN+8hPHDZD4+dk8AVBA9
	 qzsmOIff8xqcaStxfOyAbZHXH9x1BL4pObIK/9ujvECADq2c38cCseM6rjLRt6IImsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 67F8E1F000C4;
	Thu, 26 Nov 2026 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795686878;
	bh=LrXkkhn+csZHwC0v+/65n16FhGVifrxEgQhE/Pa5wFw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=F+3nfrFbvd2n9Exq6P/RJBPmUwQm88ebWYY57R9qicJHbttkmhGDjz0llWSf6yilI
	 dJMdxVuMiWAJkRzKM7FdTe+h2KZdiYXhSUDGpsVodq6rv4MKOEGg19VYUMNS1ynoe0
	 pbRlxDmTEinR+U6OFjwbP83B15JepldMR6UTANTtWxpiVzEJ60E2PNks+3uE0Tjkhz
	 oczQkpU/qIPlyy656Kl+ejSPndotet3F3yocGkaEHFR7rLVM7FQau3Ol7dwE+yqQwV
	 twdKXvLsuMsToxbOPMvXsG5N6zoYoqA1e5tVF0xFC110kK+a2UzoqbbwnhsOVg0Anb
	 3PhNn9IhINYOQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E02944D3BE;
	Thu, 26 Nov 2026 09:54:12 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v4 0/3] iommu/arm-smmu-v3: Keep the clock of the RK3588
 PCIe SMMU running
Date: Thu, 26 Nov 2026 09:54:12 +0000
Message-Id: <20261126-smmu-v3-pcie-pd-v4-0-c340c2dbd1d2@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBQE4KuQrq3hvVagrryHcdGWAjXyEwqNh
 nB3KW5Q4nKS+WYm4kxvjSPnaCK98dbZtlkCP0REV7IpDbX5kgnGmABATF1dj9Qz2mlraJdTiQV
 gqjLIs4IsqutNYZ/r4vX2yW5Ud6OHMBMalXVD27/WSw+h93/dA41pglkGQkvOlbiUtbSPo25rE
 tY9bj3uPS6eyTRVSiUKNf/1bOvZ3rPghVG8ECBO+PU/z/MbLIR2xEABAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795686852; l=2915;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=OykbgClr+ZRK4+0ppCdomu1EHFQbW+fawWJaWWyDfFk=;
 b=4w4KGwCAjg+suLsY7Wb+HjUF+MXqiHM+K6VvQS1vu8dKFbs1s3X6LFFI9MENRlif9M9NxN7S1
 uwd52RE1j4wBnUqWqyH26/yNQulQKg1cKZ6csv8oSQrHEfUy1zQE0eT
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

On RK3588 boards without an enabled PCIe controller, ACLK_MMU_PCIE is
gated as unused while arm-smmu-v3 is bound to the PCIe SMMU, and reboot
hangs in arm_smmu_device_shutdown() until the watchdog fires.

Patches 1-2 are for the iommu tree, patch 3 for the Rockchip tree. The
clock can move into the runtime PM callbacks of Pranjal Shrivastava's
pending SMMUv3 sleep ops series once it lands.

Tested as v2 (same code apart from comments) on an Orange Pi 5 with the
M.2 slot in SATA mode: reboot reaches the boot loader in 0.59 s (was
~89 s, via the watchdog). The resets property is unused by the driver
and untested.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v4:
- 1/3: Acked-by Rob Herring
- 2/3: kept dev_err_probe(): the clk getters do not print, and the
  message records the deferral reason (Sebastian Reichel)
- 2/3, 3/3: shorter commit messages; 2/3: shorter comment
- Rebased
- Link to v3: https://patch.msgid.link/20261113-smmu-v3-pcie-pd-v3-0-39eb4f919529@gmail.com

Changes in v3:
- Shortened the commit messages and the cover letter, and dropped the
  "on SoCs where ..." part of the binding's clock description
  (Sebastian Reichel).
- Squashed the DTS reset patch into the clock patch (Sebastian Reichel).
  His Reviewed-by of the clock patch is kept.
- Dropped the description of the binding's resets property.
- No code changes.
- Link to v2: https://patch.msgid.link/20261112-smmu-v3-pcie-pd-v2-0-3a77bbb6b2c4@gmail.com

Changes in v2:
- Moved the fix for the Tegra CMDQV reference leak on a bad
  #iommu-cells (Sashiko AI review) to a separate patch.
- Dropped the power-domain patches: the TRM puts MMU600_PCIE in PD_PHP,
  which Linux does not control (Sebastian Reichel, Shawn Lin).
- Binding: one clock instead of up to four (Sashiko, Sebastian Reichel).
- Driver: one optional clock, got before the firmware probe so a failure
  cannot leak the CMDQV reference (Sashiko); shorter comment (Sebastian
  Reichel).
- Added the reset to the binding and the DTS (Sebastian Reichel).
- Link to v1: https://patch.msgid.link/20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com

---
Arun Iyengar (3):
      dt-bindings: iommu: arm,smmu-v3: Allow a clock and a reset
      iommu/arm-smmu-v3: Enable an optional clock
      arm64: dts: rockchip: Add the clock and reset of the RK3588 PCIe SMMU

 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 8 ++++++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi            | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c              | 8 ++++++++
 3 files changed, 18 insertions(+)
---
base-commit: c9b82d9808c4af1734e6d08f06fd411c30438ae8
change-id: 20261110-smmu-v3-pcie-pd-a2f127b81d8f

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


