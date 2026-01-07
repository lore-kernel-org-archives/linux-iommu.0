Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80E2F5A13
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780620; cv=none; b=ExMXIumPhJRWMXz7Z67kWMcbpqFBJg6P3EmCTc+6vbrAMl9WPjwJuMt+ZZqk6JWaORWvyryOAmeFZbvvu7dBlrFJhTpiL9xKus4Vn+GJ2ViCurFI0ssK+QY6nm42mxa1JKSbGHRXlBLHB/nHvVzqazY0XULInI/QRuUiRbdVOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780620; c=relaxed/simple;
	bh=KOzFr3CAfSgNpnDPdkCG81xM9fUQ94llU5hQD+SKDg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VFJXS5T9dhiCHvBhkeHa621xJYWWF3XBLC1pqr+KS1Vv7YF6oAnAoTJLng5PaK7xRM5BBqwhjJBsWnYcAM7n7HGeTGzK1lP2KW7ARh4Fc80axV0wcra//GFNI1FEIsBj7IzDKqrLjZF+t64E/VOB3J3QILcQAoall3kxN0V8G9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G2ErqJiy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G2ErqJiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1767780614;
	bh=KOzFr3CAfSgNpnDPdkCG81xM9fUQ94llU5hQD+SKDg8=;
	h=From:To:Cc:Subject:Date:From;
	b=G2ErqJiyQSsdoSvIgcd8EM4c2V6NxbkKALYOGcFNMIbSN7v/l3w/AtNmEO//YQNXr
	 0uVBAlSbS2grRYsyuiu+zhWp98tglpVSM3vDLPyve1bo38/ml0YekryEboVc9eCDD9
	 /U/hMZPfFEKyUrJNRWMNE993M1wUSFUcH0QQmvOeT89LUy5mLv0LyZBbn86UyHtRU8
	 +TaEMGYXcjyCcw6DbF/Y0sHddJrlx6CPi86p9sr3enDvd8cQVE8gPgz1BUs9P1TFCB
	 kdpQ2LVsvCVu/tnGF+uvno8anKnfAqeyxf7oFm+4kldpW/pmBn7YJI1W939pvFaAT9
	 DGoMYzy57BUmg==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7e36:2305:d47f:6e43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D1E617E1146;
	Wed,  7 Jan 2026 11:10:14 +0100 (CET)
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
Subject: [PATCH v11 0/7] Add support for Verisilicon IOMMU used by media
Date: Wed,  7 Jan 2026 11:09:50 +0100
Message-ID: <20260107101005.84039-1-benjamin.gaignard@collabora.com>
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

This patch series adds support for the Verisilicon IOMMU, which is found
in front
of hardware encoder and decoder blocks in several SoCs using Verisilicon
IP. 
A first implementation of this IOMMU is available on the Rockchip RK3588
SoC.

Rockchip provides a driver for this hardware in their 6.1 kernel branch:
https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/iommu/rockchip-iommu-av1d.c

This series includes:
- a new binding for the Verisilicon IOMMU
- a driver implementation
- DT updates for RK3588

The driver was forward-ported from Rockchip’s 6.1 implementation, 
the prefix was renamed to vsi for generality, and several fixes were
applied.

AV1 decoding was tested using the stateless VPU driver and Fluster.
The test results show a score of 205/239, which confirms that no
regressions
were introduced by this series.

Feedback and testing welcome.

changes in version 11:
- Fix dependency issue when decoder driver is build as module.

changes in version 10:
- Update vsi_iommu_identity_attach() and vsi_iommu_attach_device()
  prototypes.
- Fix build as module issue when Verisilicon video decoder is built-in.
- Rebase on master branch.

changes in version 9:
- removing blanks lines.

changes in version 8:
- Add myself in MAINTAINERS file.
- Add API to restore VSI iommu context from decoder driver
- Fix reported checkpatch issues: add comment in pinlock_t declaration
  and remove blank line.
- Include board name in defconfig patch commit message

changes in version 7:
- fix locking issues.
- add a patch in AV1 video decoder to manage per context iommu domain.
- fix compilation issues when build as module.
- remove useless "rockchip,rk3588-av1-iommu" compatible in driver code.

Benjamin Gaignard (7):
  dt-bindings: vendor-prefixes: Add Verisilicon
  dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
  iommu: Add verisilicon IOMMU driver
  MAINTAINERS: Add entry for Verisilicon IOMMU driver
  media: verisilicon: AV1: Restore IOMMU context before decoding a frame
  arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
  arm64: defconfig: enable Verisilicon IOMMU for Rockchip RK3588

 .../bindings/iommu/verisilicon,iommu.yaml     |  71 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  11 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/vsi-iommu.c                     | 808 ++++++++++++++++++
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c  |  15 +
 include/linux/vsi-iommu.h                     |  21 +
 10 files changed, 949 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
 create mode 100644 drivers/iommu/vsi-iommu.c
 create mode 100644 include/linux/vsi-iommu.h

-- 
2.43.0

