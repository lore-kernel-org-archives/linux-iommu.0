From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [GIT PULL FOR v3.20] Renesas IPMMU driver
Date: Fri, 16 Jan 2015 18:08:16 +0200
Message-ID: <17336548.2pFUfTyJuB@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git iommu/next

for you to fetch changes up to 78e1f974dd351ac82d978e3aac2d27422013f914:

  iommu/ipmmu-vmsa: Remove platform data support (2015-01-16 18:03:05 +0200)

----------------------------------------------------------------
Laurent Pinchart (7):
      iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or attachment
      iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the child page table
      iommu/ipmmu-vmsa: Invalidate TLB after unmapping
      iommu/ipmmu-vmsa: Add device tree bindings documentation
      iommu/ipmmu-vmsa: Add device tree support
      iommu/ipmmu-vmsa: Support multiple micro TLBs per device
      iommu/ipmmu-vmsa: Remove platform data support

 .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt    |  41 +++++++
 drivers/iommu/ipmmu-vmsa.c                              | 151 +++++++++++----
 include/linux/platform_data/ipmmu-vmsa.h                |  24 ----
 3 files changed, 154 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-
vmsa.txt
 delete mode 100644 include/linux/platform_data/ipmmu-vmsa.h

-- 
Regards,

Laurent Pinchart

