Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83128C5B4
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135899; cv=none; b=sObWFHIvSIbLrfx9YCXL68Emgl3H3JWZoxDtB35L6UBuH+ijpozLLxGA0puaZxdxQfyeT4y+uFb2R8F2S5402vSWz0wC7Kd8Nkhjmo7X8lr5HyJz1T8itFaFIIYOM9U0oCwjzwbIT7Y4kdT6bUQ/ZnOjCkpAA22aS3cYRR+8x1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135899; c=relaxed/simple;
	bh=RSb5FnrJfgrfcEGlCCqOZG6UrJpfA0M16YWy/6TW8TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LOBUlGz6pwGOYRxn1XyHtooceO9gTzDTpj496JrpXI71re3JLOYTFmqSIGdoXV4e/2OyjldxBRzAID8Hk4lx8OSQBW5ANWMpozMlGJxaRAxNw7hjm38y/a6t80d5RvyzaVm7OQUJPzx39nPetFUSbGRqxzo1Jg1ie8dmTIoO+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EB61m1Y4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EB61m1Y4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752135895;
	bh=RSb5FnrJfgrfcEGlCCqOZG6UrJpfA0M16YWy/6TW8TY=;
	h=From:To:Cc:Subject:Date:From;
	b=EB61m1Y4V1uZtjXAhd2IiGSshpKinfCA1OGePv9fEXzDHPyscRFrsuLqPlu7APTYq
	 TJew8ik0BGCaLStJOBZxNWE/YVtFvtN96faslsWx0nmqFBCZgi6MBHovQQQJz910b5
	 mUMGbgbiAxlI0lbEf2WZxJBNBQnsHFpuIBHeWx8NrtLW/BwJYsekiXX1ths9SGgypW
	 CxLHlgbzoB26uLurKB4iHJ3jgFjtESmFoocQY6jzZlz1N3mynKD08ihx/esatu1UR2
	 +4b0nq2m3tpVsNE51zJT5rR0IqgBjNAIRJsKbqoEgj3vHW7g4qS0DOhixkB6UrjUod
	 JJvWnho8eoXNw==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9f5a:8ea0:8d89:78d4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EC5D217E0FB8;
	Thu, 10 Jul 2025 10:24:54 +0200 (CEST)
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
Subject: [PATCH v6 0/5] Add support for Verisilicon IOMMU used by media codec blocks
Date: Thu, 10 Jul 2025 10:24:41 +0200
Message-ID: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
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
 drivers/iommu/vsi-iommu.c                     | 781 ++++++++++++++++++
 7 files changed, 878 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
 create mode 100644 drivers/iommu/vsi-iommu.c

-- 
2.43.0

