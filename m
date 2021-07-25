Return-Path: <SRS0=497D=MR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB52CC4338F
	for <iommu@archiver.kernel.org>; Sun, 25 Jul 2021 17:37:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67071604DC
	for <iommu@archiver.kernel.org>; Sun, 25 Jul 2021 17:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67071604DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12FA740261;
	Sun, 25 Jul 2021 17:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S8H4hv7JG0In; Sun, 25 Jul 2021 17:37:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 132CE40247;
	Sun, 25 Jul 2021 17:37:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3412C0010;
	Sun, 25 Jul 2021 17:37:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A247C000E
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 17:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 517198338B
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 17:37:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVFnL2w7bUz9 for <iommu@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 17:37:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AA7183388
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=VWlRNY3LlmubsZmgJXQ96OY7Q2TJYsaXTfyxii0FK9E=; b=kEoCBUbJ66NGZotknOlYmGqFPg
 wlFmNe2NWjqIltXcoSf3v7dCsWDjXXqxroveipRGwjEdIUHCg1plfT6DsE/AVe2VQV2Q9Dt5u+Hd6
 4AV1dSJTKRnBKNDa33zK8Wlxv+2M+uRzxrMN4sbOR4B0TPBuF+UrjLxXcdqWH0gBZuyTQDc5x5lt0
 cw+QA1zx/9Tuv2G+cg2WscdhSbMW96GddtYwbuZh0GfKFJ6JNpoEyVsDHxsQgo/czJUh/d6rYBOXD
 Gj/pT1YsMZ8ir4UwHxdIJ8jDQSazGiv718ydYzF0PXmJv9ULJNfeaUCgOTv3ak+yNk3pWWI63rQ0h
 g9y9KuGA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m7i2u-00DDRb-Gh; Sun, 25 Jul 2021 17:36:24 +0000
Date: Sun, 25 Jul 2021 18:36:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
Message-ID: <YP2hDMf8/KQBaPbd@infradead.org>
References: <YPz+qQ6dbZVDbMwu@infradead.org>
 <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christoph Hellwig <hch@infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, Jul 25, 2021 at 09:50:29AM -0700, Linus Torvalds wrote:
> On Sat, Jul 24, 2021 at 11:03 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > dma-mapping fix for Lonux 5.14
> 
> We're calling it "Lonux" now?

Only on weekends :)

> >   - handle vmalloc addresses in dma_common_{mmap,get_sgtable}
> >     (Roman Skakun)
> 
> I've pulled this, but my reaction is that we've tried to avoid this in
> the past. Why is Xen using vmalloc'ed addresses and passing those in
> to the dma mapping routines?
> 
> It *smells* to me like a Xen-swiotlb bug, and it would have been
> better to try to fix it there. Was that just too painful?

vmalloc (or rather vmap) addresses actually are the most common
way to provide uncachable mappings on architectures that are not
cache coherent.  The only Xen part here is that swiotlb-xen is a mess
and gets the address from the dma-direct allocator which does vmapping
for arm/arm64, but then uses the common helpers later due to a variety
of issues that will take a while to address.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
