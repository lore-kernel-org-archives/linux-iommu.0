Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B803C282DD
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 23:24:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF543206ED
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 23:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF543206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F9D588582;
	Fri, 10 Jan 2020 23:24:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7VwesaFeP9hA; Fri, 10 Jan 2020 23:24:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 52D4288581;
	Fri, 10 Jan 2020 23:24:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41A89C1D7D;
	Fri, 10 Jan 2020 23:24:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4AA6C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 23:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A18E586C4B
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 23:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tn3MQV9U2aSb for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 23:24:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 99C8F86C47
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 23:24:02 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 15:24:01 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="212412125"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.226])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 15:24:00 -0800
From: Jon Derrick <jonathan.derrick@intel.com>
To: <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v3 0/5] Clean up VMD DMA Map Ops
Date: Fri, 10 Jan 2020 10:21:08 -0700
Message-Id: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
 Jon Derrick <jonathan.derrick@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

v2 Set: https://lore.kernel.org/linux-iommu/1578580256-3483-1-git-send-email-jonathan.derrick@intel.com/T/#t
v1 Set: https://lore.kernel.org/linux-iommu/20200107134125.GD30750@8bytes.org/T/#t

VMD currently works with VT-d enabled by pointing DMA and IOMMU actions at the
VMD endpoint. The problem with this approach is that the VMD endpoint's
device-specific attributes, such as the DMA Mask Bits, are used instead.

This set cleans up VMD by removing the override that redirects DMA map
operations to the VMD endpoint. Instead it introduces a new DMA alias mechanism
into the existing DMA alias infrastructure.

v1 added a pointer in struct pci_dev that pointed to the DMA alias' struct
pci_dev and did the necessary DMA alias and IOMMU modifications.

v2 introduced a new weak function to reference the 'Direct DMA Alias', and
removed the need to add a pointer in struct device or pci_dev. Weak functions
are generally frowned upon when it's a single architecture implementation, so I
am open to alternatives.

v3 references the pci_dev rather than the struct device for the PCI
'Direct DMA Alias' (pci_direct_dma_alias()). This revision also allows
pci_for_each_dma_alias() to call any DMA aliases for the Direct DMA alias
device, though I don't expect the VMD endpoint to need intra-bus DMA aliases.

Changes from v2:
Uses struct pci_dev for PCI Device 'Direct DMA aliasing' (pci_direct_dma_alias)
Allows pci_for_each_dma_alias to iterate over the alias mask of the 'Direct DMA alias'

Changes from v1:
Removed 1/5 & 2/5 misc fix patches that were merged
Uses Christoph's staging/cleanup patches
Introduce weak function rather than including pointer in struct device or pci_dev.

Based on Joerg's next:
https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/

Jon Derrick (5):
  x86/pci: Add a to_pci_sysdata helper
  x86/PCI: Expose VMD's PCI Device in pci_sysdata
  PCI: Introduce pci_direct_dma_alias()
  PCI: vmd: Stop overriding dma_map_ops
  x86/pci: Remove X86_DEV_DMA_OPS

 arch/x86/Kconfig               |   3 -
 arch/x86/include/asm/device.h  |  10 ---
 arch/x86/include/asm/pci.h     |  31 ++++-----
 arch/x86/pci/common.c          |  45 ++----------
 drivers/iommu/intel-iommu.c    |  18 +++--
 drivers/pci/controller/Kconfig |   1 -
 drivers/pci/controller/vmd.c   | 152 +----------------------------------------
 drivers/pci/pci.c              |  19 +++++-
 drivers/pci/search.c           |   7 ++
 include/linux/pci.h            |   1 +
 10 files changed, 61 insertions(+), 226 deletions(-)

-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
