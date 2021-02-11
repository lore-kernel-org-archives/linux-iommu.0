Return-Path: <SRS0=8k88=HN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894FC433DB
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 13:56:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A95464E9A
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 13:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A95464E9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C9C4F87415;
	Thu, 11 Feb 2021 13:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SYNEfQuYJvNb; Thu, 11 Feb 2021 13:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23394873A1;
	Thu, 11 Feb 2021 13:56:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01B9DC0174;
	Thu, 11 Feb 2021 13:56:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5314C013A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 13:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C1227874C1
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 13:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HyDPhgQmnmlr for <iommu@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 13:55:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8B0B98745D
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 13:55:59 +0000 (UTC)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi
 [62.78.145.57])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id E03A541;
 Thu, 11 Feb 2021 14:55:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1613051756;
 bh=teYYPUpBTKJG/hwpTHvlrp6FYATi01gIOZT+tY/o6ts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X/SZoBdYbkudSjrtcFYX/4NBpWqkHvFgcjwqkj0c/Rsr5balCqfa6P3sVRtlHJIV9
 hvf43GRveZ++t3h6m3H9WNlcp260O+RYJ1erfwE9FcpMlq/l3m2hqCyaNaDSwcu2Kd
 YzJ6s83p6/UkRSKd7zhKu7smBthBczzWqzqQ57hA=
Date: Thu, 11 Feb 2021 15:55:30 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: add a new dma_alloc_noncontiguous API v2
Message-ID: <YCU3UuftNEl5Bxpf@pendragon.ideasonboard.com>
References: <20210202095110.1215346-1-hch@lst.de>
 <20210207184855.GA27553@lst.de>
 <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
 <20210209082213.GA31902@lst.de>
 <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
 <CANiDSCvPodsmcOi1fMwvZsyMxWsRQWNT7VkbZs4=XePYXfiXow@mail.gmail.com>
 <20210209170217.GA10199@lst.de>
 <CANiDSCs8dXVoWuwkVs=v+=s770MpzH1xiDuj-080-98ynuz97g@mail.gmail.com>
 <20210211130625.GA20155@lst.de>
 <CANiDSCupVLQMbJVKrrKBJvJxHgteeVFik7LAJy5zbUi2ESwsGA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANiDSCupVLQMbJVKrrKBJvJxHgteeVFik7LAJy5zbUi2ESwsGA@mail.gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
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

Hi Ricardo,

On Thu, Feb 11, 2021 at 02:20:30PM +0100, Ricardo Ribalda wrote:
> On Thu, Feb 11, 2021 at 2:06 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Thu, Feb 11, 2021 at 10:08:18AM +0100, Ricardo Ribalda wrote:
> > > Hi Christoph
> > >
> > > What are your merge plans for the uvc change?
> > > http://git.infradead.org/users/hch/dma-mapping.git/commit/3dc47131f8aacc2093f68a9971d24c754e435520
> > >
> > > Are you going to remove the patch on your Merge request and then send
> > > it for review to Laurent? or merge it through your tree with a S-o-B
> > > him?
> >
> > I though I had all the ACKs to queue it up.  Is that not what was
> > intended?  Queueing up the API without a user is generally a bad idea.
> >
> 
> I am pretty sure we need the ack from Laurent. He maintains uvc
> 
> @Laurent Pinchart what are your thoughts?

I think it would have been nice to CC me on the patch in the first place
:-) I won't have time to review the series before next week at the
earliest.

-- 
Regards,

Laurent Pinchart
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
