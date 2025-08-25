Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D22FD1C3
	for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136101; cv=none; b=up2iTdyGt8kOfr+MHWsoY5LRhYAq1RbVBow3j1iYdzjLUl9HzYlrZAjOjfL1N1z+k1Rnnl5CPUtauafQsptB4G6nSIDQINZszjvpbNyscYCazyjk9XkkYA12jsamQMtvYuV9Mw+B7OWt0Jd8uZW6UI+a0JdExoLm9GA7LMWcQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136101; c=relaxed/simple;
	bh=bThs6dquw7xOvTfV6mBanPsHrJCpSJ7xtTfsAmDs7S0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dPr76hQN5vdRHgBTGog7M0Y+YBqLQUG1yjLVM8Oo0jCVFwTI0rKTItz4Ytcm12O89VOQJt/QtBkoADsUi1tssI7p0e4bFs+sfI69vSOAu3iwP4A1cpy+MsgF8Ri78t3C3KrF14NlZ9COhOFGNtMm+8XnPOL+3e9HzKfaRSu9kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nh1JP5Ip; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nh1JP5Ip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756136096;
	bh=bThs6dquw7xOvTfV6mBanPsHrJCpSJ7xtTfsAmDs7S0=;
	h=From:To:Cc:Subject:Date:From;
	b=nh1JP5Ipb1aw0DYhqo7CEv4Q6KA1OjqQs8HaXYG5vIlRq/KfMovPkB6+/j7Y/JsbZ
	 4UDz7XYX/1JIqx2pPZoru4VmeeJCQKev5BfY+t8TePXK4/qxwYfZN2D7W1bivDxhFP
	 1dIVl2Q1Wnd0i+VpAV1ypZ8Yr1DCrcXeUTvz47Qi3JYT6YshgDKbeuEiDj88ho1b3c
	 App7m2Mo/CCGxQo4rS6ya24EuVRi31+DkbDkCkenjyd6DCgsmp53P0jLe73dhT3xc9
	 W6y4ew4+JE0arVtWZYLRUb2HpCMDPtYhqDqG8eRQ/6e4urmQ3tTGBmQZ+TJq7mFb2j
	 3NvQb9YifYtZg==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f39:d9a9:8ef1:f69a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C23D817E05F0;
	Mon, 25 Aug 2025 17:34:55 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
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
Subject: [PATCH v7 0/6] Add support for Verisilicon IOMMU used by media codec blocks
Date: Mon, 25 Aug 2025 17:34:39 +0200
Message-ID: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
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
 
Benjamin Gaignard (6):
  dt-bindings: vendor-prefixes: Add Verisilicon
  dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
  iommu: Add verisilicon IOMMU driver
  media: verisilicon: AV1: Restore IOMMU context before decoding a frame
  arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
  arm64: defconfig: enable Verisilicon IOMMU

 .../bindings/iommu/verisilicon,iommu.yaml     |  71 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  11 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/vsi-iommu.c                     | 779 ++++++++++++++++++
 drivers/media/platform/verisilicon/hantro.h   |   5 +
 .../media/platform/verisilicon/hantro_drv.c   |  11 +
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c  |  10 +
 10 files changed, 902 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
 create mode 100644 drivers/iommu/vsi-iommu.c

-- 
2.43.0

