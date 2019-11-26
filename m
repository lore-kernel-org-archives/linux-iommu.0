Return-Path: <SRS0=2ATj=ZS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC938C43215
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 09:20:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729C0207DD
	for <iommu@archiver.kernel.org>; Tue, 26 Nov 2019 09:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729C0207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 38AC687E6F;
	Tue, 26 Nov 2019 09:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55MCram+SHOz; Tue, 26 Nov 2019 09:20:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EB5AB87E63;
	Tue, 26 Nov 2019 09:20:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE715C0880;
	Tue, 26 Nov 2019 09:20:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5746C0878
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 09:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A4FD86A48
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 09:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yNYsu6zz78na for <iommu@lists.linux-foundation.org>;
 Tue, 26 Nov 2019 09:20:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6E3E786940
 for <iommu@lists.linux-foundation.org>; Tue, 26 Nov 2019 09:20:38 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 853D2BA60;
 Tue, 26 Nov 2019 09:20:35 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: andrew.murray@arm.com,
	maz@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] Raspberry Pi 4 PCIe support
Date: Tue, 26 Nov 2019 10:19:38 +0100
Message-Id: <20191126091946.7970-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 f.fainelli@gmail.com, linux-rockchip@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, phil@raspberrypi.org,
 jeremy.linton@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, mbrugger@suse.com,
 bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
 james.quinlan@broadcom.com, netdev@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-rpi-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This series aims at providing support for Raspberry Pi 4's PCIe
controller, which is also shared with the Broadcom STB family of
devices.

There was a previous attempt to upstream this some years ago[1] but was
blocked as most STB PCIe integrations have a sparse DMA mapping[2] which
is something currently not supported by the kernel.  Luckily this is not
the case for the Raspberry Pi 4.

Note that the driver code is to be based on top of Rob Herring's series
simplifying inbound and outbound range parsing.

[1] https://patchwork.kernel.org/cover/10605933/
[2] https://patchwork.kernel.org/patch/10605957/

---

Changes since v2:
  - Redo register access in driver avoiding indirection while keeping
    the naming intact
  - Add patch editing ARM64's config
  - Last MSI cleanups, notably removing MSIX flag
  - Got rid of all _RB writes
  - Got rid of all of_data
  - Overall churn removal
  - Address the rest of Andrew's comments

Changes since v1:
  - add generic rounddown/roundup_pow_two64() patch
  - Add MAINTAINERS patch
  - Fix Kconfig
  - Cleanup probe, use up to date APIs, exit on MSI failure
  - Get rid of linux,pci-domain and other unused constructs
  - Use edge triggered setup for MSI
  - Cleanup MSI implementation
  - Fix multiple cosmetic issues
  - Remove supend/resume code

Jim Quinlan (3):
  dt-bindings: PCI: Add bindings for brcmstb's PCIe device
  PCI: brcmstb: add Broadcom STB PCIe host controller driver
  PCI: brcmstb: add MSI capability

Nicolas Saenz Julienne (4):
  linux/log2.h: Add roundup/rounddown_pow_two64() family of functions
  ARM: dts: bcm2711: Enable PCIe controller
  MAINTAINERS: Add brcmstb PCIe controller
  arm64: defconfig: Enable Broadcom's STB PCIe controller

 .../bindings/pci/brcm,stb-pcie.yaml           |   97 ++
 MAINTAINERS                                   |    4 +
 arch/arm/boot/dts/bcm2711.dtsi                |   41 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/acpi/arm64/iort.c                     |    2 +-
 drivers/net/ethernet/mellanox/mlx4/en_clock.c |    3 +-
 drivers/of/device.c                           |    2 +-
 drivers/pci/controller/Kconfig                |    9 +
 drivers/pci/controller/Makefile               |    1 +
 .../pci/controller/cadence/pcie-cadence-ep.c  |    7 +-
 drivers/pci/controller/cadence/pcie-cadence.c |    7 +-
 drivers/pci/controller/pcie-brcmstb.c         | 1012 +++++++++++++++++
 drivers/pci/controller/pcie-rockchip-ep.c     |    9 +-
 include/linux/log2.h                          |   52 +
 kernel/dma/direct.c                           |    3 +-
 15 files changed, 1230 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-brcmstb.c

-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
