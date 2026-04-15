Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110939A7E1
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237838; cv=none; b=jNdZWMgeL+Hgoqz+EKgWoYVJpDGbI8ASg/K9OO5Uzws7j65KBUZgxJp9IYk38pOxyaHkgxsIJ5MmRsN8nShhlo1elEUxSvyBl+utTqq4BlLHNuSYvuBkIUFj3qnr8ZLjuiFkD7+Wa9zTVm40dfugQC8ArrSZLg4dai1/k1UXHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237838; c=relaxed/simple;
	bh=eRo0+yo2ngViAuu3brKHy0pNsCzdGRzaTCVPZgYzQas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G6iD12WRUE87n+CBjexPvMPajuYSb4cXG8N1JRN9J1iekVmzndNLUDtUftku75BOrjD/ZuN5PekItFn5/JRQ0v27EkDzfvlVV2H2Nttn+IF/1M3lUV3vGaJQbumO3mDGAMiIhY4IGDP+ZasCWZ6emeOKZqETi4Em+0wOpxDcYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BzYMpl5u; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BzYMpl5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776237835;
	bh=eRo0+yo2ngViAuu3brKHy0pNsCzdGRzaTCVPZgYzQas=;
	h=From:To:Cc:Subject:Date:From;
	b=BzYMpl5uKa165kt3aF5stFxo0UVLEHO8DhDP91xqtKCnaYPLoCsEgE0+k8bSN6rlT
	 mbOiLBmrV2T3/0exac42/PcEHGq86SeWjebaECc0ftugy58MTiIy1Pr3i8KYr+9zmr
	 g8s8jhT1xPqiCy+MXNwE/WmRYRmoxJXRnEPlPMGvhC6OUIdNRfrfnz6f7bdPMOuJyF
	 vRC3QCGx84TL0Ij3DYyInMpRKV8KeSjZ7l+HRYmq3TNauBJPpE+ko32s0lkhFPVP+D
	 PpkwmHBihwif05WfVOS8CKEga6DmHsf7VDRaMB9cneBAe4jbU3MOjhXa7PEnFEFNLC
	 iE+WOCPKKZVGQ==
Received: from benjamin-XPS-13-9310.. (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B967617E131B;
	Wed, 15 Apr 2026 09:23:54 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v14 0/5] Add support for Verisilicon IOMMU used by media codec blocks
Date: Wed, 15 Apr 2026 09:23:36 +0200
Message-ID: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
the prefix was renamed to vsi for generality, and several fixes were
applied.

AV1 decoding was tested using the stateless VPU driver and Fluster.
The test results show a score of 205/239, which confirms that no
regressions were introduced by this series.

Feedback and testing welcome.

changes in version 14:
 - Flush TLB after each map/unmap operations.
 - Remove vsi_iommu_restore_ctx() and do not touch Verisilicon stateless
   video decoder.
 - Allow to build the driver as a module.

changes in version 13:
 - On top the driver file explicit why the hardware is different than Rockchip IOMMU
 - Document why vsi_iommu_restore_ctx() is needed when using Verisilicon
   stateless video decoder.

changes in version 12:
- Remove useless vsi_iommu_flush_tlb_all()
- Merge MAINTAINERS changes in the patch introducing VSI iommu driver


Benjamin Gaignard (5):
  dt-bindings: vendor-prefixes: Add Verisilicon
  dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
  iommu: Add verisilicon IOMMU driver
  arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
  arm64: defconfig: enable Verisilicon IOMMU for Rockchip RK3588

 .../bindings/iommu/verisilicon,iommu.yaml     |  71 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  11 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/iommu/Kconfig                         |  11 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/vsi-iommu.c                     | 796 ++++++++++++++++++
 8 files changed, 901 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
 create mode 100644 drivers/iommu/vsi-iommu.c

-- 
2.43.0

