Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A783BC433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 20:49:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61EF2072C
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 20:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BGCCEXGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61EF2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 794E58691B;
	Tue, 19 May 2020 20:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SZBXcJ6umb1A; Tue, 19 May 2020 20:49:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D1F258682F;
	Tue, 19 May 2020 20:49:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4BAAC07FF;
	Tue, 19 May 2020 20:49:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84515C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 20:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6AE21203CF
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 20:42:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aq6G22n+za-k for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 20:42:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from rnd-relay.smtp.broadcom.com (rnd-relay.smtp.broadcom.com
 [192.19.229.170])
 by silver.osuosl.org (Postfix) with ESMTPS id 9497D2011A
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 20:42:02 +0000 (UTC)
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net
 [10.75.242.48])
 by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 02B4730D7BF;
 Tue, 19 May 2020 13:33:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 02B4730D7BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1589920402;
 bh=yuPEfulO+iRK9pTGrG+3vEVTPxwnaY2RYoFKfJNpl/4=;
 h=From:To:Cc:Subject:Date:From;
 b=BGCCEXGcLPBUG5WcSDFpUnH7X6Scj2cn6JSilSFImuyVpUvNUEbcGLaTqCiJFjL3K
 RC/aTNSU30qAdciwtiidWHRIF/dypocgc+fxv9lyMCer+wWJgYag7fmkpvdu32QtpX
 rTr1Zk1rKZs1p0VraKIQ5wSOx8XgHzb84gj4JsY0=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net
 [10.28.16.211])
 by mail-irv-17.broadcom.com (Postfix) with ESMTP id 4463514008B;
 Tue, 19 May 2020 13:34:42 -0700 (PDT)
To: james.quinlan@broadcom.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 00/15] PCI: brcmstb: enable PCIe for STB chips
Date: Tue, 19 May 2020 16:33:58 -0400
Message-Id: <20200519203419.12369-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 19 May 2020 20:49:28 +0000
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Julien Grall <julien.grall@arm.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM Serial and Parallel ATA drivers"
 <linux-ide@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "open list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patchset expands the usefulness of the Broadcom Settop Box PCIe
controller by building upon the PCIe driver used currently by the
Raspbery Pi.  Other forms of this patchset were submitted by me years
ago and not accepted; the major sticking point was the code required
for the DMA remapping needed for the PCIe driver to work [1].

There have been many changes to the DMA and OF subsystems since that
time, making a cleaner and less intrusive patchset possible.  This
patchset implements a generalization of "dev->dma_pfn_offset", except
that instead of a single scalar offset it provides for multiple
offsets via a function which depends upon the "dma-ranges" property of
the PCIe host controller.  This is required for proper functionality
of the BrcmSTB PCIe controller and possibly some other devices.

[1] https://lore.kernel.org/linux-arm-kernel/1516058925-46522-5-git-send-email-jim2101024@gmail.com/

Jim Quinlan (15):
  PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
  ahci_brcm: fix use of BCM7216 reset controller
  dt-bindings: PCI: Add bindings for more Brcmstb chips
  PCI: brcmstb: Add compatibily of other chips
  PCI: brcmstb: Add suspend and resume pm_ops
  PCI: brcmstb: Asserting PERST is different for 7278
  PCI: brcmstb: Add control of rescal reset
  of: Include a dev param in of_dma_get_range()
  device core: Add ability to handle multiple dma offsets
  dma-direct: Invoke dma offset func if needed
  arm: dma-mapping: Invoke dma offset func if needed
  PCI: brcmstb: Set internal memory viewport sizes
  PCI: brcmstb: Accommodate MSI for older chips
  PCI: brcmstb: Set bus max burst side by chip type
  PCI: brcmstb: add compatilbe chips to match list

 .../bindings/pci/brcm,stb-pcie.yaml           |  40 +-
 arch/arm/include/asm/dma-mapping.h            |  17 +-
 drivers/ata/ahci_brcm.c                       |  14 +-
 drivers/of/address.c                          |  54 ++-
 drivers/of/device.c                           |   2 +-
 drivers/of/of_private.h                       |   8 +-
 drivers/pci/controller/Kconfig                |   4 +-
 drivers/pci/controller/pcie-brcmstb.c         | 403 +++++++++++++++---
 include/linux/device.h                        |   9 +-
 include/linux/dma-direct.h                    |  16 +
 include/linux/dma-mapping.h                   |  44 ++
 kernel/dma/Kconfig                            |  12 +
 12 files changed, 542 insertions(+), 81 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
