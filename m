Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D3CC433FE
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 00:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BAA941BA4;
	Mon, 18 Apr 2022 00:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KrT7EQljIAIg; Mon, 18 Apr 2022 00:52:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 410CE41C19;
	Mon, 18 Apr 2022 00:52:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0860BC002F;
	Mon, 18 Apr 2022 00:52:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A96E6C002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 00:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E57641C19
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 00:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IvRDYGjsdmOo for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 00:52:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8259941BBF
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 00:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650243163; x=1681779163;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/kFQnsBqkXI0hmaJKub5IQkJHcP80qmW7WdRtl8Uumc=;
 b=LgZ21s+BWqna2vdpF2VKdYSHo3T5Q1tx8mJgxH4XhmWBX3gRNqBovVor
 cdRO4Y8xj90rOyavy1t2NQSCtbrmI8fpcRpqogKy2uKhuAfbMqYYsoNXB
 AZ1Whodxj2Mof7uat+4hf9tgxug0kEFgjLDF+yBSfyoZmQscMAZpSkwYR
 4e8kk2PBOL2Ia3fF3XB/djiZpDFL3TphYnmG4f6sN5mxiXStkfmaxnMdR
 6bmgQlA4PvmsfONUCn5uZPXNKjEllIbvvEtW0HIcy5YrFvEbV/Hr0wKyC
 Y/qxTueIZVIKhDeXSTm3cVSXy2EVhBnhrTwbEw3mVb4C38EWwnOtYSc2t A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262284650"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; d="scan'208";a="262284650"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2022 17:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; d="scan'208";a="701651301"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [RESEND PATCH v8 06/11] PCI: portdrv: Set driver_managed_dma
Date: Mon, 18 Apr 2022 08:49:55 +0800
Message-Id: <20220418005000.897664-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org
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

If a switch lacks ACS P2P Request Redirect, a device below the switch can
bypass the IOMMU and DMA directly to other devices below the switch, so
all the downstream devices must be in the same IOMMU group as the switch
itself.

The existing VFIO framework allows the portdrv driver to be bound to the
bridge while its downstream devices are assigned to user space. The
pci_dma_configure() marks the IOMMU group as containing only devices
with kernel drivers that manage DMA. Avoid this default behavior for the
portdrv driver in order for compatibility with the current VFIO usage.

We achieve this by setting ".driver_managed_dma = true" in pci_driver
structure. It is safe because the portdrv driver meets below criteria:

- This driver doesn't use DMA, as you can't find any related calls like
  pci_set_master() or any kernel DMA API (dma_map_*() and etc.).
- It doesn't use MMIO as you can't find ioremap() or similar calls. It's
  tolerant to userspace possibly also touching the same MMIO registers
  via P2P DMA access.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 4b8801656ffb..7f8788a970ae 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -202,6 +202,8 @@ static struct pci_driver pcie_portdriver = {
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
+	.driver_managed_dma = true,
+
 	.driver.pm	= PCIE_PORTDRV_PM_OPS,
 };
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
