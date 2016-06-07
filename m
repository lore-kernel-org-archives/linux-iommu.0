From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 0/3] iommu/ipmmu-vmsa: Initial r8a7796 support
Date: Tue, 07 Jun 2016 12:39:18 +0900
Message-ID: <20160607033918.28687.98260.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: Initial r8a7796 support

[PATCH 1/3] iommu/ipmmu-vmsa: Add r8a7796 DT binding
[PATCH 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
[PATCH 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code

This series adds r8a7796 support to the IPMMU driver. The DT binding
gets updated, maximum number of micro-TLBs are increased and the
driver is adjusted to match on the new DT binding.

The main differences between r8a7795 and r8a7796 IPMMUs are:
1) Number of on-chip IPMMU device instances
2) Interrupt register bit assignment for IPMMU-MM
3) Maximum number of micro-TLBs
4) Micro-TLB assignment

DT binding extension and change number 3 above are part of this patch
series. Other changes will be part of DT integration code that will be
submitted separately.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on top of next-20160602 and:
 [PATCH v3 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update V3
 [PATCH v2 00/11] iommu/ipmmu-vmsa: r8a7795 support V2

 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |    1 
 drivers/iommu/ipmmu-vmsa.c                                     |   11 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)
