From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 00/10] Renesas IPMMU-VMSA fixes and DT support
Date: Tue, 16 Dec 2014 15:44:07 +0200
Message-ID: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Simon Horman <horms@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch fixes several small issues with the Renesas IPMMU-VMSA driver and
then implements DT support.

Patches 01/10 to 04/10 are small bug fixes. Please see the individual patches
for more information.

Patches 05/10 and 06/10 define DT bindings and implement DT support. Patches
07/10 and 08/10 then add support for multiple micro TLBs per device and remove
platform data support. Finally patches 09/10 and 10/10 add the IPMMU DT nodes
for the R-Car H2 and M2.

Joerg, as the patches have all been sent to public mailing lists previously I
will send you a pull request for patches 01/10 to 08/10 for v3.20 when the
v3.19 merge window closes. Patches 09/10 and 10/10 can then be merged
independently through the Renesas tree.

Compared to v1, the DT bindings have been updated to

- extend the register range over both the base registers bank and the
  non-secure aliases ; and
- specify both the secure and non-secure interrupt, when applicable.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Simon Horman <horms@verge.net.au>

Axel Lin (1):
  iommu/ipmmu-vmsa: Return proper error if devm_request_irq fails

Laurent Pinchart (9):
  iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or
    attachment
  iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the child page
    table
  iommu/ipmmu-vmsa: Invalidate TLB after unmapping
  iommu/ipmmu-vmsa: Add device tree bindings documentation
  iommu/ipmmu-vmsa: Add device tree support
  iommu/ipmmu-vmsa: Support multiple micro TLBs per device
  iommu/ipmmu-vmsa: Remove platform data support
  ARM: shmobile: r8a7790: Add IPMMU DT nodes
  ARM: shmobile: r8a7791: Add IPMMU DT nodes

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  41 ++++++
 arch/arm/boot/dts/r8a7790.dtsi                     |  51 +++++++
 arch/arm/boot/dts/r8a7791.dtsi                     |  60 ++++++++
 drivers/iommu/ipmmu-vmsa.c                         | 153 +++++++++++++++------
 include/linux/platform_data/ipmmu-vmsa.h           |  24 ----
 5 files changed, 266 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
 delete mode 100644 include/linux/platform_data/ipmmu-vmsa.h

-- 
Regards,

Laurent Pinchart

