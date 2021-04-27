Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069BDC43460
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 12:41:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D33E613BD
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 12:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D33E613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 467E0607EB;
	Tue, 27 Apr 2021 12:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id egBKBeUs4xeL; Tue, 27 Apr 2021 12:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2422F607C0;
	Tue, 27 Apr 2021 12:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEC9AC000E;
	Tue, 27 Apr 2021 12:41:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77227C000B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65F5183BF2
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fFQhzsdkcB9 for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 12:41:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53BA083BE0
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:41:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 457B861059;
 Tue, 27 Apr 2021 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1619527277;
 bh=P+oLcg/KgUKwLIvYmcCRqckymcvWUs4EWrMcpfr89qA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Si+4HW3ASVsCkRRhUXpnUKiBsIwvgH3s6gMg4zAZtzXEBMAmchfr006GslZOmi5ne
 zmyRrYlPnFg9Gj9jQ+zSQi0qCfjzk2AUWbN6rWwfgbhACVw4/Ibky3v05fZ2wOybUi
 aCGmRnJQGAhbBdGCJVlGikWmDcmXUoCL4vLwa3EQ=
Date: Tue, 27 Apr 2021 14:41:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: dma-api debugfs directory is not created since debugfs is not
 initialized
Message-ID: <YIgGa6yF/adg8OSN@kroah.com>
References: <YIf2w1navFNeYjMS@Red> <YIf35EzfSY7qavWw@kroah.com>
 <22f268bb-9b96-1208-0292-68c9b50422a1@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <22f268bb-9b96-1208-0292-68c9b50422a1@arm.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
 hch@lst.de
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

On Tue, Apr 27, 2021 at 01:32:50PM +0100, Robin Murphy wrote:
> On 2021-04-27 12:39, Greg KH wrote:
> > On Tue, Apr 27, 2021 at 01:34:27PM +0200, Corentin Labbe wrote:
> > > Hello
> > > 
> > > I try to debug some DMA problem on next-20210427, and so I have enabled CONFIG_DMA_API_DEBUG=y.
> > > But the dma-api directory does show up in debugfs, but lot of other directory exists in it.
> > 
> > Does it show up properly in 5.12?
> > 
> > > After debugging it seems due to commit 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
> > > Reverting the commit permit to "dma-api" debugfs to be found. (but seems not the right way to fix it).
> > 
> > We have had some odd start-up ordering issues that the above commit has
> > caused to show.  Given that this commit is now in stable kernels, with
> > no report of this issue so far, I'm worried that maybe this is a dma
> > subsystem ordering issue?
> 
> Both debugfs_init() and dma_debug_init() do run at core_initcall level, and
> disassembling the vmlinux from my current working tree does indeed suggest
> that they somehow end up in the wrong relative order:
> 
> [...]
> ffff80001160d0c8 <__initcall__kmod_debug__325_918_dma_debug_init1>:
> ffff80001160d0c8:       feb0d528        .word   0xfeb0d528
> 
> [...]
> 
> ffff80001160d108 <__initcall__kmod_debugfs__357_848_debugfs_init1>:
> ffff80001160d108:       fff4326c        .word   0xfff4326c
> [...]
> 
> 
> I always had the impression that initcall ordering tended to work out
> roughly alphabetical, such that entries from fs/* might come before
> kernel/*, but I guess it's at the whims of the linker in the end :/

init call ordering happens from link ordering.

> Perhaps the easiest thing to do is split out dma_debug_fs_init() and run
> that at a later level? We do want the dma-debug infrastructure itself to be
> up as early as possible, but I think the debugfs view of its internals can
> happily wait until closer to the time that there's actually a userspace to
> be able to look at it.

That seems like a better idea here, there's no need for "special
treatment" of debugfs.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
