From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/3] Renesas IPMMU-VMSA fixes
Date: Thu, 24 Jul 2014 17:27:02 +0200
Message-ID: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hello,

This series fixes small issues with the ipmmu-vmsa driver. Please see
individual patches for details.

If not too late, I'd like these fixes to be merged in v3.17 (after proper
review of course, or, in the worst case, after lack of review).

Laurent Pinchart (3):
  iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or
    attachment
  iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the child page
    table
  iommu/ipmmu-vmsa: Invalidate TLB after unmapping

 drivers/iommu/ipmmu-vmsa.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
Regards,

Laurent Pinchart

