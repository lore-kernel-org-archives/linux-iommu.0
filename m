From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update
Date: Tue, 15 Dec 2015 21:02:12 +0900
Message-ID: <20151215120212.26216.61530.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: IPMMU multi-arch update

[PATCH 01/06] iommu/ipmmu-vmsa: Remove platform data handling
[PATCH 02/06] iommu/ipmmu-vmsa: Convert to dev_data
[PATCH 03/06] iommu/ipmmu-vmsa: Break out utlb control function
[PATCH 04/06] iommu/ipmmu-vmsa: Rework interrupt code and use bitmap for context
[PATCH 05/06] iommu/ipmmu-vmsa: Break out 32-bit ARM mapping code
[PATCH 06/06] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency

These patches update the IPMMU driver with a few minor changes
to support multiple architectures. With these patches applied
the driver is known to compile without issues on 32-bit ARM,
64-bit ARM and x86_64.

With the series applied the r8a7790 IPMMU still gets invoked
when the modetest utility is used to display a test pattern
on the VGA port driven by the DU device.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on top of renesas-drivers-2015-12-08-v4.4-rc4

 drivers/iommu/Kconfig      |    1 
 drivers/iommu/ipmmu-vmsa.c |  224 +++++++++++++++++++++++++++-----------------
 2 files changed, 139 insertions(+), 86 deletions(-)
