From: Dmitry Safonov <dima@arista.com>
Subject: [PATCHv2 0/6] iommu/intel: Handle DMAR faults in a wq
Date: Mon, 12 Feb 2018 16:48:19 +0000
Message-ID: <20180212164825.22421-1-dima@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Changes to v2:
- Ratelimit printks for dmar faults (6 patch)

First version:
https://lkml.org/lkml/2018/1/24/364

A softlockup-panic fix I've meet on kernel test suite.
While at it, fix a couple of minor issues.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org

Dmitry Safonov (6):
  iommu/intel: Add __init for dmar_register_bus_notifier()
  iommu/intel: Clean/document fault status flags
  iommu/intel: Introduce clear_primary_faults() helper
  iommu/intel: Handle DMAR faults on workqueue
  iommu/intel: Rename dmar_fault() => dmar_serve_faults()
  iommu/intel: Ratelimit each dmar fault printing

 drivers/iommu/dmar.c                | 73 +++++++++++++++++++++++++++++++------
 drivers/iommu/intel-iommu.c         |  8 +++-
 drivers/iommu/intel_irq_remapping.c |  2 +-
 include/linux/dmar.h                |  3 +-
 include/linux/intel-iommu.h         | 12 +++---
 5 files changed, 78 insertions(+), 20 deletions(-)

-- 
2.13.6
