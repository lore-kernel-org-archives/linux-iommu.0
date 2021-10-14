Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA930C433EF
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 16:34:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7E561181
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 16:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A7E561181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F3F3608C9;
	Thu, 14 Oct 2021 16:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39ZFZHBnTREr; Thu, 14 Oct 2021 16:34:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BCBC1605C5;
	Thu, 14 Oct 2021 16:34:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 958DFC0011;
	Thu, 14 Oct 2021 16:34:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 112F7C000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 16:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E747580E78
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 16:34:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YxoVxL2FYP69 for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 16:34:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A584180E67
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=B5Ne9PwyaPKNZsA4nfALs8ysb+j2MUAWcASB0gSVPg8=; b=MbGq3u2CTyKdZTtigfOZBK7Lki
 3Ga0B05uSgD+BBKke0F9DUEDGVHlDrqGNzSnicVILFTQDWhwRKyGik/tMgvbgBxN6aL24fKCWKBEA
 BGU/2r5xhjqtcjVuUD2vZw+Xdh8NjgrBTs+pk9wK+4SysW1KgtRpnjHq3vZ1oXysbM1p9Xwa6I1j/
 TiedRIInv8urTwouhihFJ6rlEA59ohqMPlgEiQ0EGFskVauow5XCNGVKCZ7a8ZPSF8QqPZLG4XL3d
 cn2fujCbqnQdTHFS4zdRh7wrQI2q7TrQsirZ3lU1svdErLODsyOnLt2VfYqq+kHbm2PhNr6Oi6wn2
 Dt0+v1cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mb3eT-008Sme-Qz; Thu, 14 Oct 2021 16:32:36 +0000
Date: Thu, 14 Oct 2021 17:32:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC] iommu: Use put_pages_list
Message-ID: <YWhbkaWpAJgdM1b5@casper.infradead.org>
References: <20210930162043.3111119-1-willy@infradead.org>
 <YV85dvlyj5LBdsro@casper.infradead.org>
 <YWgShKtp+89f1a/J@casper.infradead.org>
 <5e147b84-f048-b5ff-09d6-ceffe4c2364a@huawei.com>
 <93425cf4-3027-940f-3bee-29c4ee61105f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93425cf4-3027-940f-3bee-29c4ee61105f@arm.com>
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Thu, Oct 14, 2021 at 05:17:18PM +0100, Robin Murphy wrote:
> On 2021-10-14 12:52, John Garry wrote:
> > On 14/10/2021 12:20, Matthew Wilcox wrote:
> > > I'm going to keep pinging this patch weekly.
> > > 
> > > On Thu, Oct 07, 2021 at 07:17:02PM +0100, Matthew Wilcox wrote:
> > > > ping?
> > 
> > Robin, Were you checking this? You mentioned "I got
> > side-tracked trying to make io-pgtable use that freelist properly" in
> > another thread, which seems related.
> 
> Ooh, thanks for the heads-up John - I'm still only just starting to catch up
> on my mailing list folders since I got back off holiday.
> 
> Indeed I already started untangling the freelist handling in the flush queue
> code (to make the move into iommu-dma smaller). Once I'd figured out how it
> worked I did wonder whether there was any more "standard" field to borrow,
> since page->freelist did seem very much in the minority. If page->lru is it
> then great! From a quick skim of the patch I think I'd only have a few
> trivial review comments to make - certainly no objection to the fundamental
> change itself (indeed I hit a point in io-pgtable-arm where adding to the
> pointer chain got rather awkward, so having proper lists to splice would be
> lovely).

Great to hear!

> Matthew - is this something getting in the way of mm development, or just a
> nice cleanup? I'd be happy either to pursue merging it on its own, or to
> pick it up and work it into a series with my stuff.

This is probably going to get in the way of MM development in ~6 months
time.  I'm happy for you to pick it up and put it in a series of your own!
BTW, the optimisation of the implementation of put_pages_list() is sitting
in akpm's tree, so if you see a performance problem, please give that
a try.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
