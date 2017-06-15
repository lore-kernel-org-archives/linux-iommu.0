From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/04] iommu/ipmmu-vmsa: 32-bit ARM update
Date: Thu, 15 Jun 2017 19:29:05 +0900
Message-ID: <149752254550.21887.15183665699230243235.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, sricharan@codeaurora.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: 32-bit ARM update

[PATCH 01/04] iommu/ipmmu-vmsa: Use iommu_device_register()/unregister()
[PATCH 02/04] iommu/ipmmu-vmsa: Consistent ->of_xlate() handling
[PATCH 03/04] iommu/ipmmu-vmsa: Use fwspec on both 32 and 64-bit ARM
[PATCH 04/04] iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids

This series updates the IPMMU driver to make use of recent IOMMU framework
changes and also improves code sharing in the driver between the 32-bit and
64-bit dma-mapping architecture glue code.

Suggested-by: Robin Murphy <robin.murphy@arm.com> (Patch 2 and 4)
Signed-off-by: Robin Murphy <robin.murphy@arm.com> (Patch 3)
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on renesas-drivers-2017-06-13-v4.12-rc5 and rebased to next-20170614

 drivers/iommu/ipmmu-vmsa.c |  186 +++++++++++---------------------------------
 1 file changed, 49 insertions(+), 137 deletions(-)
