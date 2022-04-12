Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF2EC4332F
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 11:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4DF1813BE;
	Tue, 12 Apr 2022 11:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ldGMIfHxTV-1; Tue, 12 Apr 2022 11:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8CBB58138F;
	Tue, 12 Apr 2022 11:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F31CC002F;
	Tue, 12 Apr 2022 11:38:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33FB0C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 11:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1272640199
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 11:38:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UKn1fcn3n60Z for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 11:38:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B239400CC
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649763519; x=1681299519;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N4WSKTydTrMHsksFWCFFkVf1bcccCKP0eWt9cxX6l5w=;
 b=EL1cr6dOf5VKpLzlVavhz4JvYhQxjgebZ2gjxVALrjTHVGQT5yMZhrDs
 AelVLK+L/OtYjCiHjRAWgelB43/vcLI13GZ1dZHBWzl2muEhl8woBz+kD
 wBNbcuDzPc1COCm+N97MWwiDivBU6g9Q2GIFg9K0zgSB/ul6fau3i0fFL
 hlUSurapAICzNglqAKKUUDSdTfqc7aDbR6E6qR2xQ/AAs+r4xrmy+rs54
 ZzUypMXwyrXpDnmj8pt0ARvMz6bfNtqnpo0fdvAafEDsJ8Aq6tDpxe5s9
 vY3n+ayNfSozEMXxSwKhG9efaTjPO/8GfKMnUO7+gVcmxf3CA8S8xcHLb g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242942422"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="242942422"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 04:38:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="572723776"
Received: from spr.sh.intel.com ([10.239.53.23])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 04:38:21 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Date: Tue, 12 Apr 2022 19:38:05 +0800
Message-Id: <20220412113805.3210-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>,
 Wang Zhaoyang1 <zhaoyang1.wang@intel.com>, Gao Liang <liang.gao@intel.com>,
 robin.murphy@arm.com, hch@lst.de
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

When we looked into FIO performance with swiotlb enabled in VM, we found
swiotlb_bounce() is always called one more time than expected for each DMA
read request.

It turns out that the bounce buffer is copied to original DMA buffer twice
after the completion of a DMA request (one is done by in
dma_direct_sync_single_for_cpu(), the other by swiotlb_tbl_unmap_single()).
But the content in bounce buffer actually doesn't change between the two
rounds of copy. So, one round of copy is redundant.

Pass DMA_ATTR_SKIP_CPU_SYNC flag to swiotlb_tbl_unmap_single() to
skip the memory copy in it.

This fix increases FIO 64KB sequential read throughput in a guest with
swiotlb=force by 5.6%.

Reported-by: Wang Zhaoyang1 <zhaoyang1.wang@intel.com>
Reported-by: Gao Liang <liang.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 kernel/dma/direct.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 4632b0f4f72e..8a6cd53dbe8c 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -114,6 +114,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
 	if (unlikely(is_swiotlb_buffer(dev, phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+		swiotlb_tbl_unmap_single(dev, phys, size, dir,
+					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
 #endif /* _KERNEL_DMA_DIRECT_H */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
