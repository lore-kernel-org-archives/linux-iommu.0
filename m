Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF330280305
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051226; cv=none; b=qZ8UFjhOUsGtgwwHtfJOgmIdpKPDMfMteXijtkseSAuDFsUxwmqFR14ZWvUeLZHAphqJPEY+Jd8JegzSIaGEgACPn7TK76ea39m2eQd7eRoQf1UtGswHCgHdExUuFoUmNBwtQUfWBxWx4kNonLENvG7Od6zDqBeAa7gah6lQs/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051226; c=relaxed/simple;
	bh=8IQx6W/1PdnreYyNzZK7oBqPlduYE0b8d+5NrbHzL0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ef3PLo0jv7/EqsLHXn+lLRPl42Vu3fNDk/utirAyBskEhsCmARQGUpd4UzG6BtRse274gTCmWnjOAT5CT+4NpHVjhAyUHGjJ/jLo1Y1RqhTldllhZpGBKnpDJ7lL/7ZsoviLC+8WVnNirCJXmR1rGmS5uu3l1PfV06cVzC7AU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uftlh972; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uftlh972"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752051222;
	bh=8IQx6W/1PdnreYyNzZK7oBqPlduYE0b8d+5NrbHzL0k=;
	h=From:To:Cc:Subject:Date:From;
	b=Uftlh972MTTEqcOpOSkMnlptEKhlJK16hoz0M4o3cGXcQ3Oh5/QxoOI+LJd/8S4jF
	 C/jkw+AVhjZ5FegZDN8CrAShwWjj30NcCDS+T1+bGr7tWemalzlLgUUznXxGfC7fgE
	 55F9wm4puGgC/h3eGKaZbsaIzv1rWtKvUPrFqMYZZRbUDawwAPkatzsOoqnxGjn3kI
	 IlFmZfF5VkWXXSYtDwjR8nBN7v1MjFsYrdI/4uIBeoEh7HlAKkpXUahyGopl2XHfLE
	 /W9InXLwv8pCHqzG5miR7iZygrdaSAAaeAGnCEpS3VnFvFR/P3U65HDEX+zF6AAaFO
	 6qypXe0QvgfOw==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8d6b:4a4d:ad13:46c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A9AC17E04AA;
	Wed,  9 Jul 2025 10:53:42 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v5 0/5] Add support for Verisilicon IOMMU used by media codec blocks
Date: Wed,  9 Jul 2025 10:53:25 +0200
Message-ID: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
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
- a driver implementation
- DT updates for RK3588

The driver was forward-ported from Rockchip’s 6.1 implementation, 
the prefix was renamed to vsi for generality, and several fixes were applied.

AV1 decoding was tested using the stateless VPU driver and Fluster.
The test results show a score of 205/239, which confirms that no regressions
were introduced by this series.

Feedback and testing welcome.

changes in version 5:
- change locking schema to use 2 spin_locks: one to protect vsi_domain
  data and one to protect vsi_iommu structure.
- make suspend/resume more robust by calling disable/enable function.
- rebased on top of v6.16-rc5

changes in version 4:
- rename and reorder compatibles fields.
- Kconfig dependencies
- Fix the remarks done by Jason and Robin: locking, clocks, macros
  probing, pm_runtime, atomic allocation.

changes in version 3:
- Change compatible to "rockchip,rk3588-iommu-1.2"
- Fix compatible in .yaml
- Update DT and driver to use "rockchip,rk3588-iommu-1.2" compatible
- Set CONFIG_VSI_IOMMU as module in defconfig
- Create an identity domain for the driver
- Fix double flush issue
- Rework attach/detach logic
- Simplify xlate function
- Discover iommu device like done in ARM driver
- Remove ARM_DMA_USE_IOMMU from Kconfig

changes in version 2:
- Add a compatible "rockchip,rk3588-av1-iommu"
- Fix clock-names in binding 
- Remove "vsi_mmu" label in binding example.
- Rework driver probe function
- Remove double flush
- Rework driver internal structures and avoid allocate
  in xlate function.
- Do not touch to VPU driver anymore (path removed)
- Add a patch to enable the driver in arm64 defconfig


 
Benjamin Gaignard (5):
  dt-bindings: vendor-prefixes: Add Verisilicon
  dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
  iommu: Add verisilicon IOMMU driver
  arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
  arm64: defconfig: enable Verisilicon IOMMU

 .../bindings/iommu/verisilicon,iommu.yaml     |  71 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  11 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/vsi-iommu.c                     | 775 ++++++++++++++++++
 7 files changed, 872 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
 create mode 100644 drivers/iommu/vsi-iommu.c

-- 
2.43.0

