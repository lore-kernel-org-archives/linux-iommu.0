Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD8AC31E46
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 11:33:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E51208CA
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 11:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E51208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2BAC11B08;
	Wed, 12 Jun 2019 11:33:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 43BE21AFB
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 11:31:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0823C174
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 11:31:30 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id D62C068B02; Wed, 12 Jun 2019 13:31:02 +0200 (CEST)
Date: Wed, 12 Jun 2019 13:31:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: How to resolve an issue in swiotlb environment?
Message-ID: <20190612113102.GA24742@lst.de>
References: <20190611064158.GA20601@lst.de>
	<Pine.LNX.4.44L0.1906110956510.1535-100000@iolanthe.rowland.org>
	<20190612073059.GA20086@lst.de>
	<OSAPR01MB3089D154C6DF0237003CE80CD8EC0@OSAPR01MB3089.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OSAPR01MB3089D154C6DF0237003CE80CD8EC0@OSAPR01MB3089.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Alan Stern <stern@rowland.harvard.edu>, Christoph Hellwig <hch@lst.de>
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

On Wed, Jun 12, 2019 at 08:52:21AM +0000, Yoshihiro Shimoda wrote:
> Hi Christoph,
> 
> > From: Christoph Hellwig, Sent: Wednesday, June 12, 2019 4:31 PM
> > 
> > First things first:
> > 
> > Yoshihiro, can you try this git branch?  The new bits are just the three
> > patches at the end, but they sit on top of a few patches already sent
> > out to the list, so a branch is probably either:
> > 
> >    git://git.infradead.org/users/hch/misc.git scsi-virt-boundary-fixes
> 
> Thank you for the patches!
> Unfortunately, the three patches could not resolve this issue.
> However, it's a hint to me, and then I found the root cause:
>  - slave_configure() in drivers/usb/storage/scsiglue.c calls
>    blk_queue_max_hw_sectors() with 2048 sectors (1 MiB) when USB_SPEED_SUPER or more.
>  -- So that, even if your patches (also I fixed it a little [1]) could not resolve
>     the issue because the max_sectors is overwritten by above code.
> 
> So, I think we should fix the slave_configure() by using dma_max_mapping_size().
> What do you think? If so, I can make such a patch.

Yes, please do.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
