From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/9] Renesas ipmmu-vmsa: Miscellaneous cleanups and fixes
Date: Mon, 21 Apr 2014 16:13:00 +0200
Message-ID: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch set cleans up and fixes small issues in the ipmmu-vmsa driver. The
patches are based on top of "[PATCH v3] iommu: Add driver for Renesas
VMSA-compatible IPMMU" that adds the ipmmu-vmsa driver.

The most interesting part of this series is the rewrite of the page table
management code. The IOMMU core guarantees that the map and unmap operations
will always be called only with page sizes advertised by the driver. We can
use that assumption to remove loops of PGD and PMD entries, simplifying the
code.

Will, would it make sense to perform the same cleanup for the arm-smmu driver,
or is there a reason to keep loops over PGD and PMD entries ? Removing them
makes the implementation of 68kB and 2MB pages easier.

Laurent Pinchart (9):
  iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or
    attachment
  iommu/ipmmu-vmsa: Fix the supported page sizes
  iommu/ipmmu-vmsa: Define driver-specific page directory sizes
  iommu/ipmmu-vmsa: Set the PTE contiguous hint bit when possible
  iommu/ipmmu-vmsa: PMD is never folded, PUD always is
  iommu/ipmmu-vmsa: Rewrite page table management
  iommu/ipmmu-vmsa: Support 2MB mappings
  iommu/ipmmu-vmsa: Remove stage 2 PTE bits definitions
  iommu/ipmmu-vmsa: Support clearing mappings

 drivers/iommu/ipmmu-vmsa.c | 443 +++++++++++++++++++++++++++++++--------------
 1 file changed, 309 insertions(+), 134 deletions(-)

-- 
Regards,

Laurent Pinchart

