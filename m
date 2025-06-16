Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5BC2BEFEB
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085782; cv=none; b=pcQEbDUCYlbiOSG7pXw1xHd40QvZTTp3eJodXdWMVTah9Wi/spaakX4ZgniMDel/u/Cr5eT441lRQ6Os3wp0QVuXYzu1d269TvadjpGVHHrtuMJ2fRjH9eFap2+d3dwOwWV+mJDicI9Dvjrlegcr76wVWgsOzn7cPV6c6cgqu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085782; c=relaxed/simple;
	bh=IPS5pyYgHpxPgbxv/IHzWa6tUPv1UYhANfe/623koZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wj12bDVFtvsldOfmsIniO5Pi+vtjoMlHeVdIEmNyHDPY1aRLURMTWCBkrloAkr4ElvJlzHIdkyK4w81ahK7Cp+hNy7un7nOD9EAee25ZF2ek0fUpsBAxEqI4gu0ia49jwY1ZXcOEFDC+WIIJvu8EI6D3paeB8EYcs4FLfm8BeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BxVRxFhV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BxVRxFhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750085773;
	bh=IPS5pyYgHpxPgbxv/IHzWa6tUPv1UYhANfe/623koZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=BxVRxFhVDcNmrDeC1P7uctqpOqyITQjUmL2LbGMF+iJg8NMWcE3x08UyLK1IYq8Xz
	 9dcQrJltVxmVug43XszNFWEAHtwAm+hhX44hB0teZVItmBmKhG58IJ/K2yPCSB0PBs
	 jt9KA4RjtPoUcF/w3CAWGVGW5uv49wFMF+YzpC3xQQP8CQgVD+KokYwALEAHpZN4Us
	 mRWFOv6TQxj7Vw+KgWfHtxP48Xh2kMN7modxcVvNbYXQSpCVMwtyOHhLybmEsqN8nY
	 PQHep9xrChhiclR2SMiAN1LHp5GDgCu7SdZv0hTY2ZwuCbFWHQpzGlBPAZGWSM14XP
	 UefVISx0bXPnw==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4811:e81c:4b33:730c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BE19517E088C;
	Mon, 16 Jun 2025 16:56:12 +0200 (CEST)
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
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 0/5] Add support for Verisilicon IOMMU used by media codec blocks
Date: Mon, 16 Jun 2025 16:55:48 +0200
Message-ID: <20250616145607.116639-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds support for the Verisilicon IOMMU, which is found in front
of hardware encoder and decoder blocks in several SoCs using Verisilicon IP. 
A first implementation of this IOMMU is available on the Rockchip RK3588 SoC.

Rockchip provides a driver for this hardware in their 6.1 kernel branch:
https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/iommu/rockchip-iommu-av1d.c

This series includes:
- a new binding for the Verisilicon IOMMU
- a basic driver implementation
- DT updates for RK3588
- integration with the Verisilicon VPU driver.

The driver was forward-ported from Rockchip’s 6.1 implementation, 
the prefix was renamed to vsi for generality, and several fixes were applied.

AV1 decoding was tested using the stateless VPU driver and Fluster.
The test results show a score of 205/239, which confirms that no regressions
were introduced by this series.

Feedback and testing welcome.

Thanks,
Benjamin

Benjamin Gaignard (5):
  dt-bindings: vendor-prefixes: Add Verisilicon
  dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
  iommu: Add verisilicon IOMMU driver
  arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
  media: verisilicon: Flush IOMMU before decoding a frame

 .../bindings/iommu/verisilicon,iommu.yaml     |  71 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  11 +
 drivers/iommu/Kconfig                         |   8 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/vsi-iommu.c                     | 900 ++++++++++++++++++
 .../media/platform/verisilicon/hantro_drv.c   |  11 +
 7 files changed, 1004 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
 create mode 100644 drivers/iommu/vsi-iommu.c

-- 
2.43.0

