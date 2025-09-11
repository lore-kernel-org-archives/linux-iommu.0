Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9620FA9C
	for <iommu@lists.linux.dev>; Thu, 11 Sep 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606250; cv=none; b=TAH8XhSzkMacMeABBmyXr6JD0f0iwPLqIbN5r3TNXoGKsuI/vUojR9l6CYCbmwlOCiRImys170fsXxETntVXLwYd0JayP46Ybn+Mr+7+hFoJLdyIxzFrAhMV/XouEESZGyhlPeIICQanBqDVkkny9rXWwGW4lyKjBhA80FVDfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606250; c=relaxed/simple;
	bh=a0IIVelCiz6nryZoqnORSBXKjaIL+ikdZr6o/qVwlUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KrS3517wxb0uotLJqrqXXXgASiUwn2z28/DfddTa0jzPBTDrOvCE59K5r5kIw6kMjNzyBV0eFcYSCYlqtK7rKrVAV8AW0x87W1Fvr8A1x+2xwgosexwQ66Kf/J44Ap7jGR3RP3efv6DgrBAbYNWMQL+tzuOZ+PWBFyCfefAwGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pdTTYlLZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pdTTYlLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757606246;
	bh=a0IIVelCiz6nryZoqnORSBXKjaIL+ikdZr6o/qVwlUI=;
	h=From:To:Cc:Subject:Date:From;
	b=pdTTYlLZhlHYQlP+o9qAP3T5h/uYT/eUY6MgioNeVwDR2es8HfSrZ/6rwp3EEP15U
	 eneYP0SGS97k3TfBmSmDyCE9pY8rACdPRp6dEWiKBaP5mvngZqVI1jCzSTVNqm/wDp
	 MJIdpEc5iNj2IHusnFg8BO8P6L995xLc8CVLv0+m0oxeFSGFA1cLO+kZbugo/VtXXy
	 6QwMwwTKTSWXk2/Abop9vXmOS+R+yDHeOaUUVCBkT2ENSwNwjtmyrBuZmpR7eW5Kyc
	 XlLXRxXAWjPpm8aRfOn1Np/UUriW9FL2kLkuHGDT7c8nbe29G0y2Jghzz0plWkcZjF
	 +FrcGplk9Bnvg==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36e5:357f:56a7:54dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 198CC17E0C96;
	Thu, 11 Sep 2025 17:57:26 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	linux-media@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v9 0/7] Add support for Verisilicon IOMMU used by media codec blocks
Date: Thu, 11 Sep 2025 17:57:10 +0200
Message-ID: <20250911155720.180465-1-benjamin.gaignard@collabora.com>
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

changes in version 6:
- rework lock schema in vsi_iommu_attach_device() so
  it protected against concurrent invalidation.
- flush the cache after changing of domain.

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

