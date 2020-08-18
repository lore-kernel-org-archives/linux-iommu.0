Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A23FC433DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 08:37:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18892067C
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 08:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sChHbAxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18892067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EFC1D20372;
	Tue, 18 Aug 2020 08:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M55-nM1lRcFu; Tue, 18 Aug 2020 08:37:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6D77B2012D;
	Tue, 18 Aug 2020 08:37:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E5DCC088B;
	Tue, 18 Aug 2020 08:37:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A509AC0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 08:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8897720365
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 08:37:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 488u9V572MfU for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 08:37:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 340EE2012D
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=z+RycezjV2WVCujs2S8itL6PhqDnVUaq7qp6xVdLAo4=; b=sChHbAxde70X2xuGN/HW+28KHz
 HI6YetzZL7SCINwQdD5+hHwkS6qWOP4voGDc8BYsONfhYhnkoQjB8JI7DJJ9WQFCYfhWEbCSaLAB/
 omXVKQnx1SSatRgDqyYjcqU0OpvgaD2swot7bjhdFztT6gzNDrjEARqivLy9gDHU+rpvRWfZnA8TU
 EXesWd61vo9k2yjd6ObDCJVrP1fhwDN5MYWt/fXfGTXqq8r+QJLiuZzA0MqYq9MFwmi9U6wOVFmOZ
 0288DMbrkGzzFf92AljB7ECFX3C4q0e5AVJDUpv6hEAlOSfHWemTogfSP8tf0Sw1RswoQai5g6knN
 CYOJR6QQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k7x7Q-0002kj-2n; Tue, 18 Aug 2020 08:37:20 +0000
Date: Tue, 18 Aug 2020 09:37:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200818083720.GA9451@infradead.org>
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
 <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
 <20200818082852.GA15145@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818082852.GA15145@willie-the-truck>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: janghyuck.kim@samsung.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, hyesoo.yu@samsung.com,
 iommu@lists.linux-foundation.org, Cho KyongHo <pullip.cho@samsung.com>,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Tue, Aug 18, 2020 at 09:28:53AM +0100, Will Deacon wrote:
> On Tue, Aug 18, 2020 at 04:43:10PM +0900, Cho KyongHo wrote:
> > Cache maintenance operations in the most of CPU architectures needs
> > memory barrier after the cache maintenance for the DMAs to view the
> > region of the memory correctly. The problem is that memory barrier is
> > very expensive and dma_[un]map_sg() and dma_sync_sg_for_{device|cpu}()
> > involves the memory barrier per every single cache sg entry. In some
> > CPU micro-architecture, a single memory barrier consumes more time than
> > cache clean on 4KiB. It becomes more serious if the number of CPU cores
> > are larger.
> 
> Have you got higher-level performance data for this change? It's more likely
> that the DSB is what actually forces the prior cache maintenance to
> complete, so it's important to look at the bigger picture, not just the
> apparent relative cost of these instructions.
> 
> Also, it's a miracle that non-coherent DMA even works, so I'm not sure
> that we should be complicating the implementation like this to try to
> make it "fast".

And without not just an important in-tree user but one that actually
matters and can show how this is correct the whole proposal is complete
nonstarter.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
