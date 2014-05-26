From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 02/10] iommu/ipmmu-vmsa: Cleanup failures of ARM
 mapping creation or attachment
Date: Mon, 26 May 2014 13:31:17 +0200
Message-ID: <20140526113117.GI17056@8bytes.org>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1400150451-13469-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140526092310.GA11299@8bytes.org>
 <9405311.lnqBdrCsyu@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9405311.lnqBdrCsyu@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 26, 2014 at 12:08:37PM +0200, Laurent Pinchart wrote:
> 
> Thank you. I'll rebase the patch on top of your tree as soon as you publish 
> the related branch and resubmit.

I also put this patch on-top to fix a compile error.

>From 720b0cef715ab97b21b33e7f3c328e2863411cab Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Mon, 26 May 2014 13:07:01 +0200
Subject: [PATCH] arm/ipmmu-vmsa: Fix compile error

The function arm_iommu_create_mapping lost the order
parameter. Remove it from this IOMMU driver too to make it
build.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/ipmmu-vmsa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 95b819a..53cde08 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1087,7 +1087,7 @@ static int ipmmu_add_device(struct device *dev)
 		struct dma_iommu_mapping *mapping;
 
 		mapping = arm_iommu_create_mapping(&platform_bus_type,
-							SZ_1G, SZ_2G, 0);
+						   SZ_1G, SZ_2G);
 		if (IS_ERR(mapping)) {
 			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
 			return PTR_ERR(mapping);
-- 
1.7.9.5


