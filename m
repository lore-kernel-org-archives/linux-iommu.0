Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC15C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 13:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6240260B9A;
	Tue, 12 Apr 2022 13:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MfSaWxkbEneF; Tue, 12 Apr 2022 13:21:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3B9E6606CB;
	Tue, 12 Apr 2022 13:21:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13C8FC002F;
	Tue, 12 Apr 2022 13:21:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17A60C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05FC360B9A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:21:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CnCxRm_srhYc for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:21:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A88B606CB
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649769704; x=1681305704;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=K10aPqsXZD4QBwO3VmQYeC0CYp3r9bJXTTZCH/ubYRg=;
 b=F9x1PI7BydFUTmX7IEE4DqGM+6N436rl09fyC6USfmrUUkdFdY6Dw2Iq
 B7BrKGshyrd+uKCwCZcolDVs+9pdSOIdVdsrj64iSKEBnSzDsTM723jCw
 dqidSPcMtglHOAiD8MCy2WMD57GJ2Aa5nqZaKoPJkO8C12n1Uyf6HyN5i
 MFY2SmRHhOX4/gnc4VZWAAQAduD6EtRDUj639umCzk5qyL3ZcRxG2XXrz
 es5wZWiTaPN3uEz2UgRw/EF30hFLFn69dZb90+0jtLh9QMRs/in1CuEfk
 wmegM75cFudgpZlZs3P01FWb4j++q7/uT/XHQTT5JMSzUkvCfaJud1l9Q w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242959757"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="242959757"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:21:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="551708376"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:21:41 -0700
Date: Tue, 12 Apr 2022 21:21:37 +0800
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Message-ID: <20220412132132.GA18002@gao-cwp>
References: <20220412113805.3210-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220412113805.3210-1-chao.gao@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Tue, Apr 12, 2022 at 07:38:05PM +0800, Chao Gao wrote:
>When we looked into FIO performance with swiotlb enabled in VM, we found
>swiotlb_bounce() is always called one more time than expected for each DMA
>read request.
>
>It turns out that the bounce buffer is copied to original DMA buffer twice
>after the completion of a DMA request (one is done by in
>dma_direct_sync_single_for_cpu(), the other by swiotlb_tbl_unmap_single()).
>But the content in bounce buffer actually doesn't change between the two
>rounds of copy. So, one round of copy is redundant.
>
>Pass DMA_ATTR_SKIP_CPU_SYNC flag to swiotlb_tbl_unmap_single() to
>skip the memory copy in it.
>
>This fix increases FIO 64KB sequential read throughput in a guest with
>swiotlb=force by 5.6%.
>

Sorry. A fixes tag is missing:

Fixes: 55897af63091 ("dma-direct: merge swiotlb_dma_ops into the dma_direct code")

>Reported-by: Wang Zhaoyang1 <zhaoyang1.wang@intel.com>
>Reported-by: Gao Liang <liang.gao@intel.com>
>Signed-off-by: Chao Gao <chao.gao@intel.com>
>Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>---
> kernel/dma/direct.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>index 4632b0f4f72e..8a6cd53dbe8c 100644
>--- a/kernel/dma/direct.h
>+++ b/kernel/dma/direct.h
>@@ -114,6 +114,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
> 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
> 
> 	if (unlikely(is_swiotlb_buffer(dev, phys)))
>-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
>+		swiotlb_tbl_unmap_single(dev, phys, size, dir,
>+					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
> }
> #endif /* _KERNEL_DMA_DIRECT_H */
>-- 
>2.25.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
