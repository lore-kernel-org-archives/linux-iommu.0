Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD085C433EF
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 00:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E1DB40B48;
	Mon, 18 Apr 2022 00:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nei-zXv9ZV28; Mon, 18 Apr 2022 00:52:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2E028400FB;
	Mon, 18 Apr 2022 00:52:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01ED9C002F;
	Mon, 18 Apr 2022 00:52:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75067C002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 00:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 508EC41B39
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 00:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K-QcUn1WwtnM for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 00:52:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E5EB41760
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 00:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650243154; x=1681779154;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=szoCLBC/pIys3NwbIzrfbRFurpriz5wEpftUR2JNNlw=;
 b=jBkqQjJSvtwL7m4S2wRka9PGoQSj50NSqPazHn1f4sryjYKy0metAvfY
 xUnu7P8Jbt9yJ2kERDWc79Uw0unq0SffAHuQxyW9r6uA98SugAT9o4dcB
 aI38kxVy9mfgBruIEWpjBbKyga4nS/nTtbxwMF40WpIEgP9PKuOqZhXhV
 8uNbaQiepgZeotsUfAb/pMQSUc6EcCe25W/wxwztj32dqtkKf050lPpuB
 IwJSeS45vlt9IMjUFAzf9gC83s8sny1xVmRNfkcIpuFyC2zN7wPgJRHon
 +TfPVHdfSyISjAdtLEfV44A6/9tDkMT9S9MmDRKJsXH39BafgsS+EjXoR g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262284631"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; d="scan'208";a="262284631"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2022 17:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; d="scan'208";a="701651270"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Date: Mon, 18 Apr 2022 08:49:49 +0800
Message-Id: <20220418005000.897664-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Hi Joerg,

This is a resend version of v8 posted here:
https://lore.kernel.org/linux-iommu/20220308054421.847385-1-baolu.lu@linux.intel.com/
as we discussed in this thread:
https://lore.kernel.org/linux-iommu/Yk%2Fq1BGN8pC5HVZp@8bytes.org/

All patches can be applied perfectly except this one:
 - [PATCH v8 02/11] driver core: Add dma_cleanup callback in bus_type
It conflicts with below refactoring commit:
 - 4b775aaf1ea99 "driver core: Refactor sysfs and drv/bus remove hooks"
The conflict has been fixed in this post.

No functional changes in this series. I suppress cc-ing this series to
all v8 reviewers in order to avoid spam.

Please consider it for your iommu tree.

Best regards,
baolu

Change log:
- v8 and before:
  - Please refer to v8 post for all the change history.

- v8-resend
  - Rebase the series on top of v5.18-rc3.
  - Add Reviewed-by's granted by Robin.
  - Add a Tested-by granted by Eric.

Jason Gunthorpe (1):
  vfio: Delete the unbound_list

Lu Baolu (10):
  iommu: Add DMA ownership management interfaces
  driver core: Add dma_cleanup callback in bus_type
  amba: Stop sharing platform_dma_configure()
  bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management
  PCI: pci_stub: Set driver_managed_dma
  PCI: portdrv: Set driver_managed_dma
  vfio: Set DMA ownership for VFIO devices
  vfio: Remove use of vfio_group_viable()
  vfio: Remove iommu group notifier
  iommu: Remove iommu group changes notifier

 include/linux/amba/bus.h              |   8 +
 include/linux/device/bus.h            |   3 +
 include/linux/fsl/mc.h                |   8 +
 include/linux/iommu.h                 |  54 +++---
 include/linux/pci.h                   |   8 +
 include/linux/platform_device.h       |  10 +-
 drivers/amba/bus.c                    |  37 +++-
 drivers/base/dd.c                     |   5 +
 drivers/base/platform.c               |  21 ++-
 drivers/bus/fsl-mc/fsl-mc-bus.c       |  24 ++-
 drivers/iommu/iommu.c                 | 228 ++++++++++++++++--------
 drivers/pci/pci-driver.c              |  18 ++
 drivers/pci/pci-stub.c                |   1 +
 drivers/pci/pcie/portdrv_pci.c        |   2 +
 drivers/vfio/fsl-mc/vfio_fsl_mc.c     |   1 +
 drivers/vfio/pci/vfio_pci.c           |   1 +
 drivers/vfio/platform/vfio_amba.c     |   1 +
 drivers/vfio/platform/vfio_platform.c |   1 +
 drivers/vfio/vfio.c                   | 245 ++------------------------
 19 files changed, 338 insertions(+), 338 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
