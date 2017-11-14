From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFT v5 0/3] iommu/ipmmu-vmsa: r8a779(6|70|95) support
Date: Tue, 14 Nov 2017 09:34:48 +0100
Message-ID: <20171114083451.4052-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

This series adds r8a7796 (R-Car M3-W), r8a77970 (R-Car V3M) and
r8a77995 (R-Car D3) support to the IPMMU driver.

The maximum number of micro-TLBs are increased and the driver is adjusted
to match on the new DT bindings posted separately.

Changes since V4:
 - Marked as RFC as I believe more consideration of driver support
   for these SoCs is required
 - Moved DT bindings documentation into separate patch-set
   "[PATCH 0/2] iommu/ipmmu-vmsa: Add r8a779(6|70|95) DT bindings"
   as I believe these are ready to be merged
 - Rebased
 - Collected driver updates for r8a7796, and r8a77970 and r8a77995 SoCs
   into a single patchset.

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

Magnus Damm (2):
  iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
  iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code

Simon Horman (1):
  iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code

 drivers/iommu/ipmmu-vmsa.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

-- 
2.11.0
