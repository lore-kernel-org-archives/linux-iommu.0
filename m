Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366DFC433DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 16:10:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00958207DA
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 16:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RpSSmTL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00958207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC9688639B;
	Tue, 18 Aug 2020 16:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lWw0hx5ygYVU; Tue, 18 Aug 2020 16:10:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 71AD68622A;
	Tue, 18 Aug 2020 16:10:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AA41C088B;
	Tue, 18 Aug 2020 16:10:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20BC0C0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 16:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 093D38624E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 16:10:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6FkMMtIIvENR for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 16:10:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 16A2A8622A
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Sks+YpGBOU4o5+prB+fPm+RZPeb7HCcfoore0HyIIVs=; b=RpSSmTL8+Q0fUzX/6x0fZWIQbm
 pWkqNSJ6xdJBXm3nP8g2FJMORjV6RY3nqtJtW96uGFjUFZfQzDU5yWqLPiimOvCCO1kvjzjvzo7q8
 +JdxSb68PAC6angpC83DmKTvd6/tqe59v3IDDcp38+8NEpV8mAoC/Fr+PiAintL13vLfNz+Crthqo
 IlKLfGg2KJ7GcFqbBd4N9z1s0TtCRIvhoDagGX4oJdgmhvIDKIuvc0hFry98jKeDb1k2VzC7WA0e6
 hiIsKy7aXvrHO8Lo8GWISkb6KSGOlslI8W6tAT/m9/C7LV/JYUYQVOaWA84ZWSPCsOoS/5FoB6Fqm
 DXjJYsUA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k84Bb-0006lM-1W; Tue, 18 Aug 2020 16:10:07 +0000
Date: Tue, 18 Aug 2020 17:10:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200818161006.GA25124@infradead.org>
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
 <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
 <20200818082852.GA15145@willie-the-truck>
 <20200818093739.GB191752@KEI>
 <20200818100756.GA15543@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818100756.GA15543@willie-the-truck>
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

On Tue, Aug 18, 2020 at 11:07:57AM +0100, Will Deacon wrote:
> > > so I'm not sure
> > > that we should be complicating the implementation like this to try to
> > > make it "fast".
> > > 
> > I agree that this patch makes the implementation of dma API a bit more
> > but I don't think this does not impact its complication seriously.
> 
> It's death by a thousand cuts; this patch further fragments the architecture
> backends and leads to arm64-specific behaviour which consequently won't get
> well tested by anybody else. Now, it might be worth it, but there's not
> enough information here to make that call.

So it turns out I misread the series (*cough*, crazy long lines,
*cough*), and it does not actually expose a new API as I thought, but
it still makes a total mess of the internal interface.  It turns out
that on the for cpu side we already have arch_sync_dma_for_cpu_all,
which should do all that is needed.  We could do the equivalent for
the to device side, but only IFF there really is a major benefit for
something that actually is mainstream and matters.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
