Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AD7C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 04:33:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E39D64E87
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 04:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E39D64E87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4914048DF1;
	Wed,  3 Mar 2021 04:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D7KWYwirb0QX; Wed,  3 Mar 2021 04:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE0D54E3C5;
	Wed,  3 Mar 2021 04:33:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF712C000A;
	Wed,  3 Mar 2021 04:33:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B518EC000A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 04:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99F9E839BC
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 04:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rOMisFFbfJBq for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 04:33:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A9C5838C0
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 04:33:31 +0000 (UTC)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 03 Mar 2021 13:33:29 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 2A3F62059025;
 Wed,  3 Mar 2021 13:33:29 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 3 Mar 2021 13:33:29 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan2.css.socionext.com (Postfix) with ESMTP id A14AEB1D40;
 Wed,  3 Mar 2021 13:33:28 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 7A78112053F;
 Wed,  3 Mar 2021 13:33:28 +0900 (JST)
Date: Wed, 03 Mar 2021 13:33:28 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] swiotlb: Fix type of max_slot
In-Reply-To: <436bf276-5b16-62af-6a32-70f91fce7557@oracle.com>
References: <1614705688-10567-1-git-send-email-hayashi.kunihiko@socionext.com>
 <436bf276-5b16-62af-6a32-70f91fce7557@oracle.com>
Message-Id: <20210303133328.4D12.4A936039@socionext.com>
MIME-Version: 1.0
X-Mailer: Becky! ver. 2.70 [ja]
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Jianxiong Gao <jxgao@google.com>
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

On Tue, 2 Mar 2021 15:20:08 -0500
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On 3/2/21 12:21 PM, Kunihiko Hayashi wrote:
> > After the refactoring phase, the type of max_slot has changed from unsigned
> > long to unsigned int. The return type of the function get_max_slots() and
> > the 4th argument type of iommu_is_span_boundary() are different from the
> > type of max_slot. Finally, asserts BUG_ON in iommu_is_span_boundary().
> > > Cc: Christoph Hellwig <hch@lst.de>
> > Fixes: 567d877f9a7d ("swiotlb: refactor swiotlb_tbl_map_single")
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> I think this is all good. Looking at Linus's master I see:
> 
> 
> 537         unsigned long max_slots = get_max_slots(boundary_mask);
> 
> ?

Thanks for the information, and sorry for that.

I found it in next-20210226:
567d877f9a7d ("swiotlb: refactor swiotlb_tbl_map_single")

And it has already fixed in next-20210301:
26a7e094783d ("swiotlb: refactor swiotlb_tbl_map_single")

$ git diff 567d877f9a7d..26a7e094783d
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 381c24e..6962cb4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -496,7 +496,7 @@ static int find_slots(struct device *dev, size_t alloc_size)
        unsigned long boundary_mask = dma_get_seg_boundary(dev);
        dma_addr_t tbl_dma_addr =
                phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
-       unsigned int max_slots = get_max_slots(boundary_mask);
+       unsigned long max_slots = get_max_slots(boundary_mask);
        unsigned int nslots = nr_slots(alloc_size), stride = 1;
        unsigned int index, wrap, count = 0, i;
        unsigned long flags;

Thank you,

---
Best Regards,
Kunihiko Hayashi

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
