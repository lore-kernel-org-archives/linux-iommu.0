Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D3CC4332F
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 840ED40339;
	Sat, 27 Nov 2021 01:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jPqSQBuqHwon; Sat, 27 Nov 2021 01:20:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 384AB40424;
	Sat, 27 Nov 2021 01:20:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21605C001C;
	Sat, 27 Nov 2021 01:20:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C8EBC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AE0C405EE
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HlepDGEQ2cTr for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:20:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A13940339
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:20:10 +0000 (UTC)
Message-ID: <20211126224100.303046749@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=//Pymxq2YmulklNSLiTyVoYeHXlxeXwqBLpbcyzsxUc=;
 b=JkixINpLAG7IwgBGTy3CNwpiuZfzHjbD0o7N8tqoQWlATN4Ndsb8bIrIROKXtiKlXXH4GG
 MuxUB+Ktb5WxDEUxj2hmUVioMC0S6XogZC0QBqP0n+59kQsexsga3U2PHkEY4HyE1alk3f
 p8JV7bIX1mUBs68OkmizpXJOseMHtntJOwtcs0IAjZTjy4idbl2a5YBbxpARhFIhTTGekr
 EldqDDwR37StwenotF0nYTzMzKdSTWQU5SvHBGlDLfvw/DxaC3ri1p6QJ/Ff1dY+2pL77p
 2HNO/WH+51ff6rsss6Dk4dUyVwiaR3HbRC4amhWedJ7RpbR4+i6kKfF/bSo/Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=//Pymxq2YmulklNSLiTyVoYeHXlxeXwqBLpbcyzsxUc=;
 b=4aHit6zQT94D+jGrMxPhFPEQhGcg7bSgzNhpj51vxTFnMj1QhhHwGsqkp86iv7vimNWe86
 R8qcqzX4FWAmGqAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 00/37] genirq/msi, PCI/MSI: Spring cleaning - Part 2
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:20:06 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
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

This is the second part of [PCI]MSI refactoring which aims to provide the
ability of expanding MSI-X vectors after enabling MSI-X.

The first part of this work can be found here:

    https://lore.kernel.org/r/20211126222700.862407977@linutronix.de

This second part has the following important changes:

   1) Cleanup of the MSI related data in struct device

      struct device contains at the moment various MSI related parts. Some
      of them (the irq domain pointer) cannot be moved out, but the rest
      can be allocated on first use. This is in preparation of adding more
      per device MSI data later on.

   2) Consolidation of sysfs handling

      As a first step this moves the sysfs pointer from struct msi_desc
      into the new per device MSI data structure where it belongs.

      Later changes will cleanup this code further, but that's not possible
      at this point.

   3) Store per device properties in the per device MSI data to avoid
      looking up MSI descriptors and analysing their data. Cleanup all
      related use cases.

   4) Provide a function to retrieve the Linux interrupt number for a given
      MSI index similar to pci_irq_vector() and cleanup all open coded
      variants.

This second series is based on:

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-1

and also available from git:

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-2

For the curious who can't wait for the next part to arrive the full series
is available via:

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-4

Thanks,

	tglx
---
 arch/powerpc/platforms/cell/axon_msi.c              |    6 
 arch/powerpc/platforms/pseries/msi.c                |   38 +---
 arch/x86/kernel/apic/msi.c                          |    5 
 arch/x86/pci/xen.c                                  |    8 
 drivers/base/core.c                                 |    1 
 drivers/base/platform-msi.c                         |  152 ++++++++---------
 drivers/bus/fsl-mc/dprc-driver.c                    |    8 
 drivers/bus/fsl-mc/fsl-mc-allocator.c               |    9 -
 drivers/bus/fsl-mc/fsl-mc-msi.c                     |   26 +--
 drivers/dma/mv_xor_v2.c                             |   16 -
 drivers/dma/qcom/hidma.c                            |   44 ++---
 drivers/dma/ti/k3-udma-private.c                    |    6 
 drivers/dma/ti/k3-udma.c                            |   14 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         |   23 --
 drivers/irqchip/irq-mbigen.c                        |    4 
 drivers/irqchip/irq-mvebu-icu.c                     |   12 -
 drivers/irqchip/irq-ti-sci-inta.c                   |    2 
 drivers/mailbox/bcm-flexrm-mailbox.c                |    9 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c    |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c    |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c |    5 
 drivers/pci/msi/irqdomain.c                         |   20 +-
 drivers/pci/msi/legacy.c                            |    6 
 drivers/pci/msi/msi.c                               |  118 +++++--------
 drivers/pci/xen-pcifront.c                          |    2 
 drivers/perf/arm_smmuv3_pmu.c                       |    5 
 drivers/soc/fsl/dpio/dpio-driver.c                  |    8 
 drivers/soc/ti/k3-ringacc.c                         |    6 
 drivers/soc/ti/ti_sci_inta_msi.c                    |   22 --
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c              |    4 
 include/linux/device.h                              |   26 ++-
 include/linux/fsl/mc.h                              |    4 
 include/linux/msi.h                                 |  118 +++++++------
 include/linux/pci.h                                 |    1 
 include/linux/soc/ti/ti_sci_inta_msi.h              |    1 
 kernel/irq/msi.c                                    |  171 +++++++++++++++-----
 36 files changed, 463 insertions(+), 445 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
