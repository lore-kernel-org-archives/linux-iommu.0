Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE04C31E46
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 07:32:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C038D206BA
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 07:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C038D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7AD591715;
	Wed, 12 Jun 2019 07:32:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7BB031580
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 07:31:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EF55E7F8
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 07:31:27 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id BC64968AFE; Wed, 12 Jun 2019 09:30:59 +0200 (CEST)
Date: Wed, 12 Jun 2019 09:30:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: How to resolve an issue in swiotlb environment?
Message-ID: <20190612073059.GA20086@lst.de>
References: <20190611064158.GA20601@lst.de>
	<Pine.LNX.4.44L0.1906110956510.1535-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906110956510.1535-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

First things first:

Yoshihiro, can you try this git branch?  The new bits are just the three
patches at the end, but they sit on top of a few patches already sent
out to the list, so a branch is probably either:

   git://git.infradead.org/users/hch/misc.git scsi-virt-boundary-fixes

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/scsi-virt-boundary-fixes

And now on to the rest:

> We would like to avoid the extra I/O overhead for host controllers that
> can't handle SG.  In fact, switching to sg_tablesize = 1 would probably
> be considered a regression.

Ok, makes sense.

> >  - set the virt boundary as-is for devices supporting "basic" scatterlist,
> >    although that still assumes they can rejiggle them because for example
> >    you could still get a smaller than expected first segment ala (assuming
> >    a 1024 byte packet size and thus 1023 virt_boundary_mask):
> > 
> >         | 0 .. 511 | 512 .. 1023 | 1024 .. 1535 |
> > 
> >    as the virt_bondary does not guarantee that the first segment is
> >    the same size as all the mid segments.
> 
> But that is exactly the problem we need to solve.

So based on the above I'm a little confused about the actual requirement
again.  Can you still split the SCSI command into multiple URBs?  And
is the boundary for that split still the scatterlist entry as in the
description above?  If so I don't really see how the virt_boundary
helps you at all. as it only guarnatees that in a bio, each subsequent
segment start as the advertised virt_boundary.  It says nothing about
the size of each segment.

> The issue which prompted the commit this thread is about arose in a
> situation where the block layer set up a scatterlist containing buffer
> sizes something like:
> 
> 	4096 4096 1536 1024
> 
> and the maximum packet size was 1024.  The situation was a little 
> unusual, because it involved vhci-hcd (a virtual HCD).  This doesn't 
> matter much in normal practice because:

Thay is someething the virt_boundary prevents.  But could still give
you something like:

	1536 4096 4096 1024

or
	1536 16384 8192 4096 16384 512

> The ->sysdev field points to the device used for DMA mapping.  It is
> often the same as ->controller, but sometimes it is
> ->controller->parent because of the peculiarities of some platforms.

Thanks, taken into account in the above patches!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
