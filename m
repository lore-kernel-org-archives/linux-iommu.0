From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/5] Renesas VMSA-compatible IPMMU DT support
Date: Sat, 29 Mar 2014 00:36:16 +0100
Message-ID: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch set adds DT support to the Renesas VMSA-compatible IPMMU driver.
The first patch refactors the driver to remove dependencies on platform data,
the second patch adds the DT bindings documentation and the third patch
implement them in the driver.

The next two patches show real-life examples for IPMMU DT bindings usage.
Patch 4/5 adds IPMMU DT nodes to the r8a7791 SoC dtsi file, and patch 5/5
enables IOMMU support for the VSP1 on the same platform.

The patches are based on top of the IPMMU driver previously submitted to the
iommu mailing list. The last patch additionally requires to VSP1 DT support
patch series previously submitted to the linux-media mailing list and is thus
a test patch only at the moment, not meant to be merged yet.

The DT bindings are pretty simple, with only three standard properties in the
IPMMU DT node. The device to IOMMU association is represented in the bus master
device nodes using an iommus property, similarly to interrupts or clocks. This
model departs from the ARM SMMU DT bindings that represent the same information
inside the IOMMU DT node. I'm not sure what's best, so I'm open to suggestions.

Every IPMMU instance serves multiple bus master devices and implements four
independent page tables and TLBs. Each bus master can be freely assigned to one
of the page tables, lowering the risk of TLB miss when multiple bus masters
require address translation at the same time. I've decided not to express the
bus master to page table association in DT as this seems to me to be a software
configuration decision, not a hardware property. Feel free to disagree.

As a side note, there's no API at the moment to configure that association. My
plan is to assign bus masters to page tables automatically in the driver in a
round-robin way. A more configurable solution might be needed later, but I
believe that's out of scope of DT.

Cc: devicetree@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>

Laurent Pinchart (5):
  iommu/ipmmu-vmsa: Refactor micro-TLB lookup
  iommu/ipmmu-vmsa: Add device tree bindings documentation
  iommu/ipmmu-vmsa: Add device tree support
  ARM: shmobile: r8a7791: Add IPMMU DT nodes
  [TEST] ARM: shmobile: r8a7791: Enable IOMMU support for the VSP1

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  35 +++++++
 arch/arm/boot/dts/r8a7791.dtsi                     |  54 ++++++++++
 drivers/iommu/ipmmu-vmsa.c                         | 115 +++++++++++++--------
 3 files changed, 163 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt

-- 
Regards,

Laurent Pinchart

