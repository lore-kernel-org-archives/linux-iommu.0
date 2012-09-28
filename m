From: Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 0/16] Interrupt remapping support for AMD IOMMU
Date: Fri, 28 Sep 2012 14:23:50 +0200
Message-ID: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a new version of the remaining patches to add interrupt
remapping support to the AMD IOMMU driver. The patches have been rebased
to v3.6-rc7 and tested again on various machines. As with the previous
version no issued were found with these patches too.

Regards,

	Joerg

Diffstat:

 drivers/iommu/Kconfig           |    2 +-
 drivers/iommu/amd_iommu.c       |  504 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c  |  237 +++++++++++++++++-
 drivers/iommu/amd_iommu_proto.h |    8 +
 drivers/iommu/amd_iommu_types.h |   53 ++++
 drivers/iommu/irq_remapping.c   |    5 +
 drivers/iommu/irq_remapping.h   |    6 +
 7 files changed, 801 insertions(+), 14 deletions(-)
