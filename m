Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E894FC433E0
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 16:17:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9939F20671
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 16:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBQAsnvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9939F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3E2FD88364;
	Wed, 20 May 2020 16:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SB5f6739Pveu; Wed, 20 May 2020 16:15:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9198B882E3;
	Wed, 20 May 2020 16:15:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 723D7C088A;
	Wed, 20 May 2020 16:15:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20440C0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 16:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 088DE20011
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 16:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8LCulu4Tw34u for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 16:15:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 04B1320009
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 16:15:45 +0000 (UTC)
Received: from localhost (mobile-166-175-190-200.mycingular.net
 [166.175.190.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A8C120671;
 Wed, 20 May 2020 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589991344;
 bh=h9MTIGPYQzOllbjEkIgnEniE41lTl+OD7Fs3cDvWlC4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=dBQAsnvSt1BuQnO2Uz0LYcXqH8wrzmcE0sMq3dliKDQWy2VD07oQBTPN8C3Xz4q5j
 EEp4TAFPoo5NVsbBnUlz3FFLpZ4E3P2l4+ULM4f39CP4KxODVhaYOqqg6ZguekD1Z4
 YSmgsUdQndWtM7LDHv6BuDaL4cZ+TEEM751dZfMc=
Date: Wed, 20 May 2020 11:15:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 00/15] PCI: brcmstb: enable PCIe for STB chips
Message-ID: <20200520161541.GA1089402@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Julien Grall <julien.grall@arm.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM \(Serial and Parallel ATA drivers\)"
 <linux-ide@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "open list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>
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

On Tue, May 19, 2020 at 04:33:58PM -0400, Jim Quinlan wrote:
> This patchset expands the usefulness of the Broadcom Settop Box PCIe
> controller by building upon the PCIe driver used currently by the
> Raspbery Pi.  Other forms of this patchset were submitted by me years
> ago and not accepted; the major sticking point was the code required
> for the DMA remapping needed for the PCIe driver to work [1].
> 
> There have been many changes to the DMA and OF subsystems since that
> time, making a cleaner and less intrusive patchset possible.  This
> patchset implements a generalization of "dev->dma_pfn_offset", except
> that instead of a single scalar offset it provides for multiple
> offsets via a function which depends upon the "dma-ranges" property of
> the PCIe host controller.  This is required for proper functionality
> of the BrcmSTB PCIe controller and possibly some other devices.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/1516058925-46522-5-git-send-email-jim2101024@gmail.com/
> 
> Jim Quinlan (15):
>   PCI: brcmstb: PCIE_BRCMSTB depends on ARCH_BRCMSTB
>   ahci_brcm: fix use of BCM7216 reset controller
>   dt-bindings: PCI: Add bindings for more Brcmstb chips
>   PCI: brcmstb: Add compatibily of other chips
>   PCI: brcmstb: Add suspend and resume pm_ops
>   PCI: brcmstb: Asserting PERST is different for 7278
>   PCI: brcmstb: Add control of rescal reset
>   of: Include a dev param in of_dma_get_range()
>   device core: Add ability to handle multiple dma offsets
>   dma-direct: Invoke dma offset func if needed
>   arm: dma-mapping: Invoke dma offset func if needed
>   PCI: brcmstb: Set internal memory viewport sizes
>   PCI: brcmstb: Accommodate MSI for older chips
>   PCI: brcmstb: Set bus max burst side by chip type
>   PCI: brcmstb: add compatilbe chips to match list

If you have occasion to post a v2 for other reasons,

s/PCIE_BRCMSTB depends on ARCH_BRCMSTB/Allow PCIE_BRCMSTB on ARCH_BRCMSTB also/
s/ahci_brcm: fix use of BCM7216 reset controller/ata: ahci_brcm: Fix .../
s/Add compatibily of other chips/Add bcm7278 register info/
s/Asserting PERST is different for 7278/Add bcm7278 PERST support/
s/Set bus max burst side/Set bus max burst size/
s/add compatilbe chips.*/Add bcm7211, bcm7216, bcm7445, bcm7278 to match list/

Rewrap commit logs to use full 75 character lines (to allow for the 4
spaces added by git log).

In commit logs, s/This commit// (use imperative mood instead).

In "Accommodate MSI for older chips" commit log, s/commont/common/.

>  .../bindings/pci/brcm,stb-pcie.yaml           |  40 +-
>  arch/arm/include/asm/dma-mapping.h            |  17 +-
>  drivers/ata/ahci_brcm.c                       |  14 +-
>  drivers/of/address.c                          |  54 ++-
>  drivers/of/device.c                           |   2 +-
>  drivers/of/of_private.h                       |   8 +-
>  drivers/pci/controller/Kconfig                |   4 +-
>  drivers/pci/controller/pcie-brcmstb.c         | 403 +++++++++++++++---
>  include/linux/device.h                        |   9 +-
>  include/linux/dma-direct.h                    |  16 +
>  include/linux/dma-mapping.h                   |  44 ++
>  kernel/dma/Kconfig                            |  12 +
>  12 files changed, 542 insertions(+), 81 deletions(-)
> 
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
