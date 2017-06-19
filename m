From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
Date: Mon, 19 Jun 2017 20:04:16 +0900
Message-ID: <149787025647.32495.1584960416060100962.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: r8a7796 support V4

[PATCH v4 1/3] iommu/ipmmu-vmsa: Add r8a7796 DT binding
[PATCH v4 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
[PATCH v4 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code

This series adds r8a7796 support to the IPMMU driver. The DT binding
gets updated, maximum number of micro-TLBs are increased and the
driver is adjusted to match on the new DT binding.

Changes since V3:
 - Rebased on top of [PATCH v4 00/09] iommu/ipmmu-vmsa: r8a7795 support V4
 - Patch 3/3 updated with Reviewed-by - thanks Geert!

Changes since V2:
 - Patch 2/3 updated with an outer set of () - thanks Ramesh!
 - Patch 2/3 updated with Reviewed-by - thanks Geert!
 - Patch 3/3 updated to include white list support

Changes since V1:
 - Patch 1/3 updated with more Acked-by tags
 - Patch 2/3 updated with high I/O register range support

Patch 1/3 is ready for upstream merge and includes the following tags:
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch 2/3 and 3/3 are quite trivial but have no acked-by so far.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on top of next-20170614 with the following series applied
 [PATCH 00/04] iommu/ipmmu-vmsa: 32-bit ARM update
 [PATCH v4 00/09] iommu/ipmmu-vmsa: r8a7795 support V4

 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |    1 
 drivers/iommu/ipmmu-vmsa.c                                     |   24 +++++++---
 2 files changed, 18 insertions(+), 7 deletions(-)
