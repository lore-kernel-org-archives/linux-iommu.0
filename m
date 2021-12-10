Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C002C433FE
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 22:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A996C418D9;
	Fri, 10 Dec 2021 22:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DFmmcAdnh9bx; Fri, 10 Dec 2021 22:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E9FA5418D7;
	Fri, 10 Dec 2021 22:18:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6059C0076;
	Fri, 10 Dec 2021 22:18:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4108BC0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FF00418C9
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y4X4OBEqMRSw for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 22:18:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0847418D4
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:18:47 +0000 (UTC)
Message-ID: <20211210221642.869015045@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639174723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IBbfy8DUMmeX2/DxJ4bxtqprC0vLuk1jWkG3suZ0PZw=;
 b=qC+ywncigd88uX881G7drnWnPitC8LQEDjIxWICRbmx1CnZuuhH2HOM78Mj73Xd+ZCv0Kb
 ncvkjbnzAtbd+ixrpTmp/mZ4pThJranbywfqMLopOdcOEGpsPc6uk3V8xaldwObLZfsa/F
 EQ9V2dZmFKR1bqfNssiazFt8n3Mf+7q1vPMaTRADEfAyYuxcvDch8l/qTyx/UZYaRnEdfG
 107k2ftTZl52fiKXc5XfVwoW5s/CdJw8zCMdv0ss6LKqyYgeRXX/LiA2+XXHlrLhd7JdKS
 +inOsrufS8ZmeqDmP1k3/yTr0mCeJApmaMV52ZYaBfM4TpXhGFC+GjjHRExr/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639174723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IBbfy8DUMmeX2/DxJ4bxtqprC0vLuk1jWkG3suZ0PZw=;
 b=5lxdmWfE59j3yHf4IXX2tpXuGGPaN2BKbOiQcB9ippOtvBNy75YsOs7y6x5FiIbDSi4ZaA
 +C6w+xOR5nRMXFBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
MIME-Version: 1.0
Date: Fri, 10 Dec 2021 23:18:43 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

This is based on the first part of this work which can be found here:

    https://lore.kernel.org/r/20211206210147.872865823@linutronix.de

and has been applied to:

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi


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

   3) Use PCI device properties instead of looking up MSI descriptors and
      analysing their data.

   4) Provide a function to retrieve the Linux interrupt number for a given
      MSI index similar to pci_irq_vector() and cleanup all open coded
      variants.

It's also available from git:

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v3-part-2

Part 3 of this effort is available on top

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v3-part-3

     Part 3 is not going to be reposted as there is no change vs. V2.

V2 of part 2 can be found here:

    https://lore.kernel.org/r/20211206210307.625116253@linutronix.de

Changes versus V2:

  - Use PCI device properties instead of creating a new set - Jason

  - Picked up Reviewed/Tested/Acked-by tags as appropriate

Thanks,

	tglx
---
 arch/powerpc/platforms/cell/axon_msi.c              |    5 
 arch/powerpc/platforms/pseries/msi.c                |   38 +---
 arch/x86/kernel/apic/msi.c                          |    5 
 arch/x86/pci/xen.c                                  |   11 -
 drivers/base/platform-msi.c                         |  152 ++++++++-----------
 drivers/bus/fsl-mc/dprc-driver.c                    |    8 -
 drivers/bus/fsl-mc/fsl-mc-allocator.c               |    9 -
 drivers/bus/fsl-mc/fsl-mc-msi.c                     |   26 +--
 drivers/dma/mv_xor_v2.c                             |   16 --
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
 drivers/pci/msi/irqdomain.c                         |   20 ++
 drivers/pci/msi/legacy.c                            |    6 
 drivers/pci/msi/msi.c                               |  133 ++++++----------
 drivers/pci/xen-pcifront.c                          |    2 
 drivers/perf/arm_smmuv3_pmu.c                       |    5 
 drivers/soc/fsl/dpio/dpio-driver.c                  |    8 -
 drivers/soc/ti/k3-ringacc.c                         |    6 
 drivers/soc/ti/ti_sci_inta_msi.c                    |   22 --
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c              |    4 
 include/linux/device.h                              |   25 ++-
 include/linux/fsl/mc.h                              |    4 
 include/linux/msi.h                                 |   95 ++++--------
 include/linux/pci.h                                 |    1 
 include/linux/soc/ti/ti_sci_inta_msi.h              |    1 
 kernel/irq/msi.c                                    |  158 +++++++++++++++-----
 35 files changed, 429 insertions(+), 458 deletions(-)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
