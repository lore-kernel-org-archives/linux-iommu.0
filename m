Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859C1C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 14:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16B5A84539;
	Wed, 22 Jun 2022 14:30:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16B5A84539
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 81QisXAZyDZl; Wed, 22 Jun 2022 14:30:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E22318450B;
	Wed, 22 Jun 2022 14:30:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E22318450B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B92B4C0039;
	Wed, 22 Jun 2022 14:30:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C839C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5573184529
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5573184529
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLTrpd8rQBgr for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 14:30:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A74684513
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A74684513
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:30:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6CB3D6E;
 Wed, 22 Jun 2022 07:30:00 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.41.243])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A1083F792;
 Wed, 22 Jun 2022 07:29:59 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] swiotlb: Remove redundant swiotlb_force
Date: Wed, 22 Jun 2022 15:29:52 +0100
Message-Id: <20220622142952.320057-1-steven.price@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>
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

The variable (and enum) was removed in commit c6af2aa9ffc9 ("swiotlb:
make the swiotlb_init interface more useful") but the declaration was
left in swiotlb.h. Tidy up by removing the declaration as well.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 include/linux/swiotlb.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7ed35dd3de6e..b1f5ace37502 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -60,8 +60,6 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
 #ifdef CONFIG_SWIOTLB
-extern enum swiotlb_force swiotlb_force;
-
 /**
  * struct io_tlb_mem - IO TLB Memory Pool Descriptor
  *
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
