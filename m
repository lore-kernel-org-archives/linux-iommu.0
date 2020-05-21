Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBE6C433E5
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 13:00:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73C82072C
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 13:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73C82072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7F6618702D;
	Thu, 21 May 2020 13:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YYb5FipDw9BL; Thu, 21 May 2020 13:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD3438625E;
	Thu, 21 May 2020 13:00:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0837C088B;
	Thu, 21 May 2020 13:00:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3031C0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 13:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A174184E5F
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 13:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zIS1hpGKMEr6 for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 13:00:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 75AA78445E
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 13:00:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D010ED6E;
 Thu, 21 May 2020 06:00:16 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.29.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AC5A3F305;
 Thu, 21 May 2020 06:00:14 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/12] ACPI/OF: Upgrade MSI/IOMMU ID mapping APIs
Date: Thu, 21 May 2020 13:59:56 +0100
Message-Id: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Diana Craciun <diana.craciun@oss.nxp.com>
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

Firmware bindings provided in the ACPI IORT table[1] and device tree
bindings define rules to carry out input/output ID mappings - ie
retrieving an IOMMU/MSI controller input ID for a device with a given
ID.

At the moment these firmware bindings are used exclusively for PCI
devices and their requester ID to IOMMU/MSI id mapping but there is
nothing PCI specific in the ACPI and devicetree bindings that prevent
the firmware and kernel from using the firmware bindings to traslate
device IDs for any bus that requires its devices to carry out
input/output id translations.

The Freescale FSL bus is an example whereby the input/output ID
translation kernel code put in place for PCI can be reused for devices
attached to the bus that are not PCI devices.

This series updates the kernel code to make the MSI/IOMMU input/output
ID translation PCI agnostic and apply the resulting changes to the
device ID space provided by the Freescale FSL bus.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf

Cc: Rob Herring <robh+dt@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Joerg Roedel <joro@8bytes.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>

Diana Craciun (3):
  of/irq: make of_msi_map_get_device_domain() bus agnostic
  bus/fsl-mc: Refactor the MSI domain creation in the DPRC driver
  bus: fsl-mc: Add ACPI support for fsl-mc

Laurentiu Tudor (1):
  dt-bindings: arm: fsl: Add msi-map device-tree binding for fsl-mc bus

Lorenzo Pieralisi (8):
  ACPI/IORT: Make iort_match_node_callback walk the ACPI namespace for
    NC
  ACPI/IORT: Make iort_get_device_domain IRQ domain agnostic
  ACPI/IORT: Make iort_msi_map_rid() PCI agnostic
  ACPI/IORT: Remove useless PCI bus walk
  ACPI/IORT: Add an input ID to acpi_dma_configure()
  of/iommu: Make of_map_rid() PCI agnostic
  of/device: Add input id to of_dma_configure()
  of/irq: Make of_msi_map_rid() PCI bus agnostic

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt |  30 ++++-
 drivers/acpi/arm64/iort.c                     | 108 ++++++++++++------
 drivers/acpi/scan.c                           |   8 +-
 drivers/bus/fsl-mc/dprc-driver.c              |  31 ++---
 drivers/bus/fsl-mc/fsl-mc-bus.c               |  79 +++++++++----
 drivers/bus/fsl-mc/fsl-mc-msi.c               |  36 ++++--
 drivers/bus/fsl-mc/fsl-mc-private.h           |   6 +-
 drivers/iommu/of_iommu.c                      |  53 ++++++---
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   |  88 +++++++++++++-
 drivers/of/base.c                             |  42 +++----
 drivers/of/device.c                           |   8 +-
 drivers/of/irq.c                              |  34 +++---
 drivers/pci/msi.c                             |   5 +-
 include/acpi/acpi_bus.h                       |   9 +-
 include/linux/acpi.h                          |   7 ++
 include/linux/acpi_iort.h                     |  26 +++--
 include/linux/of.h                            |  17 ++-
 include/linux/of_device.h                     |  16 ++-
 include/linux/of_iommu.h                      |   6 +-
 include/linux/of_irq.h                        |  19 ++-
 20 files changed, 451 insertions(+), 177 deletions(-)

-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
