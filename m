Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C913EC433EF
	for <iommu@archiver.kernel.org>; Mon, 22 Nov 2021 03:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7885B402DC;
	Mon, 22 Nov 2021 03:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q6WBVvc-Xl0w; Mon, 22 Nov 2021 03:29:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2D04D40283;
	Mon, 22 Nov 2021 03:29:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 190F8C002E;
	Mon, 22 Nov 2021 03:29:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C0E6C0012
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 03:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EA0980D41
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 03:29:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l8GW-cdVWHFQ for <iommu@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 03:29:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74C5D80D1D
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 03:29:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="295523924"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; d="scan'208";a="295523924"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 19:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; d="scan'208";a="496702663"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 21 Nov 2021 19:29:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/vt-d: Fix unmap_pages support
Date: Mon, 22 Nov 2021 11:24:58 +0800
Message-Id: <20211122032458.2549761-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122032458.2549761-1-baolu.lu@linux.intel.com>
References: <20211122032458.2549761-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Alex Williamson <alex.williamson@redhat.com>

When supporting only the .map and .unmap callbacks of iommu_ops,
the IOMMU driver can make assumptions about the size and alignment
used for mappings based on the driver provided pgsize_bitmap.  VT-d
previously used essentially PAGE_MASK for this bitmap as any power
of two mapping was acceptably filled by native page sizes.

However, with the .map_pages and .unmap_pages interface we're now
getting page-size and count arguments.  If we simply combine these
as (page-size * count) and make use of the previous map/unmap
functions internally, any size and alignment assumptions are very
different.

As an example, a given vfio device assignment VM will often create
a 4MB mapping at IOVA pfn [0x3fe00 - 0x401ff].  On a system that
does not support IOMMU super pages, the unmap_pages interface will
ask to unmap 1024 4KB pages at the base IOVA.  dma_pte_clear_level()
will recurse down to level 2 of the page table where the first half
of the pfn range exactly matches the entire pte level.  We clear the
pte, increment the pfn by the level size, but (oops) the next pte is
on a new page, so we exit the loop an pop back up a level.  When we
then update the pfn based on that higher level, we seem to assume
that the previous pfn value was at the start of the level.  In this
case the level size is 256K pfns, which we add to the base pfn and
get a results of 0x7fe00, which is clearly greater than 0x401ff,
so we're done.  Meanwhile we never cleared the ptes for the remainder
of the range.  When the VM remaps this range, we're overwriting valid
ptes and the VT-d driver complains loudly, as reported by the user
report linked below.

The fix for this seems relatively simple, if each iteration of the
loop in dma_pte_clear_level() is assumed to clear to the end of the
level pte page, then our next pfn should be calculated from level_pfn
rather than our working pfn.

Fixes: 3f34f1259776 ("iommu/vt-d: Implement map/unmap_pages() iommu_ops callback")
Reported-by: Ajay Garg <ajaygargnsit@gmail.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Link: https://lore.kernel.org/all/20211002124012.18186-1-ajaygargnsit@gmail.com/
Link: https://lore.kernel.org/r/163659074748.1617923.12716161410774184024.stgit@omen
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0bde0c8b4126..8ed3fc3b11d6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1366,7 +1366,7 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
 						       freelist);
 		}
 next:
-		pfn += level_size(level);
+		pfn = level_pfn + level_size(level);
 	} while (!first_pte_in_page(++pte) && pfn <= last_pfn);
 
 	if (first_pte)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
