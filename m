Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C36DC4332F
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 01:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E07B94046D;
	Mon,  6 Dec 2021 01:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oxVfDil7Zkin; Mon,  6 Dec 2021 01:59:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7DE0740462;
	Mon,  6 Dec 2021 01:59:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E76BC001E;
	Mon,  6 Dec 2021 01:59:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19881C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 01:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 029B080F14
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 01:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AmubH6gD5XJO for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 01:59:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D39A80EF2
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 01:59:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224482702"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="224482702"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2021 17:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="514541894"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Dec 2021 17:59:12 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v3 00/18] Fix BUG_ON in vfio_iommu_group_notifier()
Date: Mon,  6 Dec 2021 09:58:45 +0800
Message-Id: <20211206015903.88687-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

Hi folks,

The iommu group is the minimal isolation boundary for DMA. Devices in
a group can access each other's MMIO registers via peer to peer DMA
and also need share the same I/O address space.

Once the I/O address space is assigned to user control it is no longer
available to the dma_map* API, which effectively makes the DMA API
non-working.

Second, userspace can use DMA initiated by a device that it controls
to access the MMIO spaces of other devices in the group. This allows
userspace to indirectly attack any kernel owned device and it's driver.

Therefore groups must either be entirely under kernel control or
userspace control, never a mixture. Unfortunately some systems have
problems with the granularity of groups and there are a couple of
important exceptions:

 - pci_stub allows the admin to block driver binding on a device and
   make it permanently shared with userspace. Since PCI stub does not
   do DMA it is safe, however the admin must understand that using
   pci_stub allows userspace to attack whatever device it was bound
   it.

 - PCI bridges are sometimes included in groups. Typically PCI bridges
   do not use DMA, and generally do not have MMIO regions.

Generally any device that does not have any MMIO registers is a
possible candidate for an exception.

Currently vfio adopts a workaround to detect violations of the above
restrictions by monitoring the driver core BOUND event, and hardwiring
the above exceptions. Since there is no way for vfio to reject driver
binding at this point, BUG_ON() is triggered if a violation is
captured (kernel driver BOUND event on a group which already has some
devices assigned to userspace). Aside from the bad user experience
this opens a way for root userspace to crash the kernel, even in high
integrity configurations, by manipulating the module binding and
triggering the BUG_ON.

This series solves this problem by making the user/kernel ownership a
core concept at the IOMMU layer. The driver core enforces kernel
ownership while drivers are bound and violations now result in a error
codes during probe, not BUG_ON failures.

Patch partitions:
  [PATCH 1-9]: Detect DMA ownership conflicts during driver binding;
  [PATCH 10-13]: Add security context management for assigned devices;
  [PATCH 14-18]: Various cleanups.

This is part one of three initial series for IOMMUFD:
 * Move IOMMU Group security into the iommu layer
 - Generic IOMMUFD implementation
 - VFIO ability to consume IOMMUFD

Change log:
v1: initial post
  - https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/

v2:
  - https://lore.kernel.org/linux-iommu/20211128025051.355578-1-baolu.lu@linux.intel.com/

  - Move kernel dma ownership auto-claiming from driver core to bus
    callback. [Greg/Christoph/Robin/Jason]
    https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#m153706912b770682cb12e3c28f57e171aa1f9d0c

  - Code and interface refactoring for iommu_set/release_dma_owner()
    interfaces. [Jason]
    https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#mea70ed8e4e3665aedf32a5a0a7db095bf680325e

  - [NEW]Add new iommu_attach/detach_device_shared() interfaces for
    multiple devices group. [Robin/Jason]
    https://lore.kernel.org/linux-iommu/20211115020552.2378167-1-baolu.lu@linux.intel.com/T/#mea70ed8e4e3665aedf32a5a0a7db095bf680325e

  - [NEW]Use iommu_attach/detach_device_shared() in drm/tegra drivers.

  - Refactoring and description refinement.

v3:
  - Rename bus_type::dma_unconfigure to bus_type::dma_cleanup. [Greg]
    https://lore.kernel.org/linux-iommu/c3230ace-c878-39db-1663-2b752ff5384e@linux.intel.com/T/#m6711e041e47cb0cbe3964fad0a3466f5ae4b3b9b

  - Avoid _platform_dma_configure for platform_bus_type::dma_configure.
    [Greg]
    https://lore.kernel.org/linux-iommu/c3230ace-c878-39db-1663-2b752ff5384e@linux.intel.com/T/#m43fc46286611aa56a5c0eeaad99d539e5519f3f6

  - Patch "0012-iommu-Add-iommu_at-de-tach_device_shared-for-mult.patch"
    and "0018-drm-tegra-Use-the-iommu-dma_owner-mechanism.patch" have
    been tested by Dmitry Osipenko <digetx@gmail.com>.

This is based on v5.16-rc3 and available on github:
https://github.com/LuBaolu/intel-iommu/commits/iommu-dma-ownership-v3

Best regards,
baolu

Jason Gunthorpe (2):
  vfio: Delete the unbound_list
  drm/tegra: Use the iommu dma_owner mechanism

Lu Baolu (16):
  iommu: Add device dma ownership set/release interfaces
  driver core: Add dma_cleanup callback in bus_type
  driver core: platform: Rename platform_dma_configure()
  driver core: platform: Add driver dma ownership management
  amba: Add driver dma ownership management
  bus: fsl-mc: Add driver dma ownership management
  PCI: Add driver dma ownership management
  PCI: pci_stub: Suppress kernel DMA ownership auto-claiming
  PCI: portdrv: Suppress kernel DMA ownership auto-claiming
  iommu: Add security context management for assigned devices
  iommu: Expose group variants of dma ownership interfaces
  iommu: Add iommu_at[de]tach_device_shared() for multi-device groups
  vfio: Set DMA USER ownership for VFIO devices
  vfio: Remove use of vfio_group_viable()
  vfio: Remove iommu group notifier
  iommu: Remove iommu group changes notifier

 include/linux/amba/bus.h              |   1 +
 include/linux/device/bus.h            |   3 +
 include/linux/fsl/mc.h                |   5 +
 include/linux/iommu.h                 |  93 ++++++--
 include/linux/pci.h                   |   5 +
 include/linux/platform_device.h       |   3 +-
 drivers/amba/bus.c                    |  30 ++-
 drivers/base/dd.c                     |   7 +-
 drivers/base/platform.c               |  31 ++-
 drivers/bus/fsl-mc/fsl-mc-bus.c       |  26 +-
 drivers/gpu/drm/tegra/dc.c            |   1 +
 drivers/gpu/drm/tegra/drm.c           |  55 +++--
 drivers/gpu/drm/tegra/gr2d.c          |   1 +
 drivers/gpu/drm/tegra/gr3d.c          |   1 +
 drivers/gpu/drm/tegra/vic.c           |   1 +
 drivers/iommu/iommu.c                 | 329 ++++++++++++++++++++------
 drivers/pci/pci-driver.c              |  21 ++
 drivers/pci/pci-stub.c                |   1 +
 drivers/pci/pcie/portdrv_pci.c        |   2 +
 drivers/vfio/fsl-mc/vfio_fsl_mc.c     |   1 +
 drivers/vfio/pci/vfio_pci.c           |   1 +
 drivers/vfio/platform/vfio_amba.c     |   1 +
 drivers/vfio/platform/vfio_platform.c |   1 +
 drivers/vfio/vfio.c                   | 248 ++-----------------
 24 files changed, 502 insertions(+), 366 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
