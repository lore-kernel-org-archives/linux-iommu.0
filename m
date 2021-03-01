Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5330AC433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:53:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E4864DE0
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E4864DE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90C4F842CD;
	Mon,  1 Mar 2021 08:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JY4nresQWYoi; Mon,  1 Mar 2021 08:53:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66E47842BF;
	Mon,  1 Mar 2021 08:53:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D7D1C000A;
	Mon,  1 Mar 2021 08:53:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD89BC0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B0364F2AA
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7cP8CM-NDyGI for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:53:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E865B4F2A7
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=/y/IlBQLfgNT2S5nwStuxp6zBAlsDLYSfzk0/A7qRR4=; b=Crdvh+f2fbEBfXNlDsCHXyvPlT
 ZJcLBYUP+YsUw5+jCgIBYF6lr4RM4lJM81MK9aO/Gol4awhfP1xAFbDp6BRnKeTy4IvssYipAfBfC
 XO4SuKTVOuh4YcPbZMtdlHZdQ3pfPctiEBcvi8DpX0q4CAuTxl1F9pmZ576OR0uGXZ3te2UV8EwBg
 xhy5wrLGTyBla/QqmY1OuFbiH7iSNTzg41D5bk2t/TuwzDHwMofcPhuuw9AUm0LQSxNSjugMo8oTk
 heHmY957JH5sFQD3eYzBlIYiBzmqEuTySCwmRkDhWM1YzdzFIcgMGSDP9mZldpull582kMY1ZVF0D
 /+TREJqg==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGeI9-00FVFN-3I; Mon, 01 Mar 2021 08:52:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 iommu@lists.linux-foundation.org
Subject: add a new dma_alloc_noncontiguous API v3
Date: Mon,  1 Mar 2021 09:52:30 +0100
Message-Id: <20210301085236.947011-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

Hi all,

this series adds the new noncontiguous DMA allocation API requested by
various media driver maintainers.

Changes since v2:
 - rebased to Linux 5.12-rc1
 - dropped one already merged patch
 - pass an attrs argument to dma_alloc_noncontigous
 - clarify the dma_vmap_noncontiguous documentation a bit
 - fix double assignments in uvcvideo

Changes since v1:
 - document that flush_kernel_vmap_range and invalidate_kernel_vmap_range
   must be called once an allocation is mapped into KVA
 - add dma-debug support
 - remove the separate dma_handle argument, and instead create fully formed
   DMA mapped scatterlists
 - use a directional allocation in uvcvideo
 - call invalidate_kernel_vmap_range from uvcvideo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
