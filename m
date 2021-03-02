Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A1BC433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 18:19:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969B464F1F
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 18:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969B464F1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4614D83A94;
	Tue,  2 Mar 2021 18:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4r4MBIuDrst9; Tue,  2 Mar 2021 18:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 328AE83A99;
	Tue,  2 Mar 2021 18:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08CA8C000A;
	Tue,  2 Mar 2021 18:19:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A83C2C000B
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 17:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92D3C83841
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 17:33:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KCY79T0QFAOw for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 17:33:00 +0000 (UTC)
X-Greylist: delayed 00:11:21 by SQLgrey-1.8.0
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54C798386E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 17:33:00 +0000 (UTC)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 03 Mar 2021 02:21:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2AD5F2059035;
 Wed,  3 Mar 2021 02:21:37 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Wed, 3 Mar 2021 02:21:37 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id C362FB1D40;
 Wed,  3 Mar 2021 02:21:36 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Jianxiong Gao <jxgao@google.com>
Subject: [PATCH] swiotlb: Fix type of max_slot
Date: Wed,  3 Mar 2021 02:21:28 +0900
Message-Id: <1614705688-10567-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Tue, 02 Mar 2021 18:19:20 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

After the refactoring phase, the type of max_slot has changed from unsigned
long to unsigned int. The return type of the function get_max_slots() and
the 4th argument type of iommu_is_span_boundary() are different from the
type of max_slot. Finally, asserts BUG_ON in iommu_is_span_boundary().

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 567d877f9a7d ("swiotlb: refactor swiotlb_tbl_map_single")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 369e4c3..c10e855 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -534,7 +534,7 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
-	unsigned int max_slots = get_max_slots(boundary_mask);
+	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
