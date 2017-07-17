From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 00/05] iommu/ipmmu-vmsa: 32-bit ARM update V2
Date: Mon, 17 Jul 2017 22:04:59 +0900
Message-ID: <150029669967.22030.8059216113725566341.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, sricharan@codeaurora.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: 32-bit ARM update V2

[PATCH v2 01/05] iommu/ipmmu-vmsa: Use iommu_device_register()/unregister()
[PATCH v2 02/05] iommu/ipmmu-vmsa: Consistent ->of_xlate() handling
[PATCH v2 03/05] iommu/ipmmu-vmsa: Use fwspec on both 32 and 64-bit ARM
[PATCH v2 04/05] iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids
[PATCH v2 05/05] iommu/ipmmu-vmsa: Clean up device tracking

This series updates the IPMMU driver to make use of recent IOMMU framework
changes and also improves code sharing in the driver between the 32-bit and
64-bit dma-mapping architecture glue code.

Suggested-by: Robin Murphy <robin.murphy@arm.com> (Patch 2 and 4)
Signed-off-by: Robin Murphy <robin.murphy@arm.com> (Patch 3 and 5)
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Minor changes to patch 1 and 2 - thanks Robin and Geert!
 - Added patch 5 to include further clean ups

 Developed on top of v4.13-rc1

 drivers/iommu/ipmmu-vmsa.c |  198 ++++++++++----------------------------------
 1 file changed, 49 insertions(+), 149 deletions(-)
