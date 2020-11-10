Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CE9C5517A
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 09:25:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F2220829
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 09:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F2220829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B756186451;
	Tue, 10 Nov 2020 09:25:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MLUisse6SQhE; Tue, 10 Nov 2020 09:25:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 61D5F85045;
	Tue, 10 Nov 2020 09:25:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 481E1C08A1;
	Tue, 10 Nov 2020 09:25:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C58EC016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 09:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4801386365
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 09:25:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rNlgtWwCNeAk for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 09:25:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F1027862F4
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 09:25:11 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4D1126736F; Tue, 10 Nov 2020 10:25:07 +0100 (CET)
Date: Tue, 10 Nov 2020 10:25:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
Message-ID: <20201110092506.GA24469@lst.de>
References: <20200930160917.1234225-1-hch@lst.de>
 <20200930160917.1234225-9-hch@lst.de>
 <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
 <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Nov 09, 2020 at 03:53:55PM +0100, Ricardo Ribalda wrote:
> Hi Christoph
> 
> I have started now to give a try to your patchset. Sorry for the delay.
> 
> For uvc I have prepared this patch:
> https://github.com/ribalda/linux/commit/9094fe223fe38f8c8ff21366d893b43cbbdf0113
> 
> I have tested successfully in a x86_64 noteboot..., yes I know there
> is no change for that platform :).
> I am trying to get hold of an arm device that can run the latest
> kernel from upstream.
> 
> On the meanwhile if you could take a look to the patch to verify that
> this the way that you expect the drivers to use your api I would
> appreciate it

This looks pretty reaosnable.

Note that ifdef  CONFIG_DMA_NONCOHERENT in the old code doesn't actually
work, as that option is an internal thing just for mips and sh..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
