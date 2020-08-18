Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B56C433E3
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 10:08:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C3F20786
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 10:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zEdB5WL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C3F20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2E0458721E;
	Tue, 18 Aug 2020 10:08:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zr2Bmv5+HAHI; Tue, 18 Aug 2020 10:08:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 44C548700E;
	Tue, 18 Aug 2020 10:08:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29321C088B;
	Tue, 18 Aug 2020 10:08:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAE5DC0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 10:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CEA32859BD
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 10:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NRrIY2IsD+8K for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 10:08:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 168F48588C
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 10:08:04 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2C5B2065D;
 Tue, 18 Aug 2020 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597745283;
 bh=b6X4T9udwsSd8aIqKl0IHJmnTP0SOrvoOTKnY0xll6c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zEdB5WL++ak9OSgezaNr3YiCb55aM1Q3nYsIX2i6FxaocZJOY5sqqKhAQ1+xM5XWU
 xlg98bPTKEXvlRXwveeRkvUzrR4e4FTaM4iwg89m00sEvKQIQT7f8rK2cOaGN59erm
 K1uKoju7tI+HYGu+bwAl8BloAFoVONlAeQqrCzXU=
Date: Tue, 18 Aug 2020 11:07:57 +0100
From: Will Deacon <will@kernel.org>
To: Cho KyongHo <pullip.cho@samsung.com>
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200818100756.GA15543@willie-the-truck>
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
 <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
 <20200818082852.GA15145@willie-the-truck>
 <20200818093739.GB191752@KEI>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818093739.GB191752@KEI>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: janghyuck.kim@samsung.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, hyesoo.yu@samsung.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Aug 18, 2020 at 06:37:39PM +0900, Cho KyongHo wrote:
> On Tue, Aug 18, 2020 at 09:28:53AM +0100, Will Deacon wrote:
> > On Tue, Aug 18, 2020 at 04:43:10PM +0900, Cho KyongHo wrote:
> > > Cache maintenance operations in the most of CPU architectures needs
> > > memory barrier after the cache maintenance for the DMAs to view the
> > > region of the memory correctly. The problem is that memory barrier is
> > > very expensive and dma_[un]map_sg() and dma_sync_sg_for_{device|cpu}()
> > > involves the memory barrier per every single cache sg entry. In some
> > > CPU micro-architecture, a single memory barrier consumes more time than
> > > cache clean on 4KiB. It becomes more serious if the number of CPU cores
> > > are larger.
> > 
> > Have you got higher-level performance data for this change? It's more likely
> > that the DSB is what actually forces the prior cache maintenance to
> > complete,
> 
> This patch does not skip necessary DSB after cache maintenance. It just
> remove repeated dsb per every single sg entry and call dsb just once
> after cache maintenance on all sg entries is completed.

Yes, I realise that, but what I'm saying is that a big part of your
justification for this change is:

  | The problem is that memory barrier is very expensive and dma_[un]map_sg()
  | and dma_sync_sg_for_{device|cpu}() involves the memory barrier per every
  | single cache sg entry. In some CPU micro-architecture, a single memory
  | barrier consumes more time than cache clean on 4KiB.

and my point is that the DSB is likely completing the cache maintenance,
so as cache maintenance instructions retire faster in the micro-architecture,
the DSB becomes absolutely slower. In other words, it doesn't make much
sense to me to compare the cost of the DSB with the cost of the cache
maintenance; what matters more is the code of the high-level unmap()
operation for the sglist.

> > so it's important to look at the bigger picture, not just the
> > apparent relative cost of these instructions.
> > 
> If you mean bigger picture is the performance impact of this patch to a
> complete user scenario, we are evaluating it in some latency sensitve
> scenario. But I wonder if a performance gain in a platform/SoC specific
> scenario is also persuasive.

Latency is fine too, but phrasing the numbers (and we really need those)
in terms of things like "The interrupt response time for this in-tree
driver is improved by xxx ns (yy %) after this change" or "Throughput
for this in-tree driver goes from xxx mb/s to yyy mb/s" would be really
helpful.

> > Also, it's a miracle that non-coherent DMA even works,
> 
> I am sorry, Will. I don't understand this. Can you let me know what do
> you mena with the above sentence?

Non-coherent DMA sucks for software. For the most part, Linux does a nice
job of hiding this from device drivers, and I think _that_ is the primary
concern, rather than performance. If performance is a problem, then the
solution is cache coherence or a shared non-cacheable buffer (rather than
the streaming API).

> > so I'm not sure
> > that we should be complicating the implementation like this to try to
> > make it "fast".
> > 
> I agree that this patch makes the implementation of dma API a bit more
> but I don't think this does not impact its complication seriously.

It's death by a thousand cuts; this patch further fragments the architecture
backends and leads to arm64-specific behaviour which consequently won't get
well tested by anybody else. Now, it might be worth it, but there's not
enough information here to make that call.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
