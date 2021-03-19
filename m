Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C9C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 13:10:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024D764EE6
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 13:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024D764EE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EB8C6071A;
	Fri, 19 Mar 2021 13:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uLJeP2f0XWGI; Fri, 19 Mar 2021 13:10:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02E9F6063B;
	Fri, 19 Mar 2021 13:10:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB804C000B;
	Fri, 19 Mar 2021 13:10:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3014BC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09E22400C0
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wc1PQqXhi91A for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 13:10:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7687A400AB
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 13:10:16 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3E99C68BFE; Fri, 19 Mar 2021 14:10:12 +0100 (CET)
Date: Fri, 19 Mar 2021 14:10:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v4 6/6] media: uvcvideo: Use dma_alloc_noncontiguous API
Message-ID: <20210319131011.GA3372@lst.de>
References: <20210312235521.1408503-1-ribalda@chromium.org>
 <CANiDSCunsYwjB=PYYJnpaEnB3pg7No40gOE1jTVwxJkJJpE2Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANiDSCunsYwjB=PYYJnpaEnB3pg7No40gOE1jTVwxJkJJpE2Nw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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

On Fri, Mar 19, 2021 at 02:05:21PM +0100, Ricardo Ribalda wrote:
> > +                                   uvc_urb->sgt,
> > +                                   uvc_stream_dir(uvc_urb->stream));
> > +       return usb_submit_urb(uvc_urb->urb, GFP_KERNEL);
> > +}
> 
> We should have mem_flags instead of GFP_KERNEL here
> 
> 
> Is it too late to fix it in your tree? Do I need to send a patch to fix it?

As far as I know we don't have anything that has pulled in the tree yet,
so I can just fold the fix in.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
