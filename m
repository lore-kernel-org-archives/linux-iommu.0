Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEDBC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 14:35:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E57206BA
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 14:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E57206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 69297241D;
	Thu, 11 Apr 2019 14:35:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CA8CE23F1
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 14:34:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5D76CF4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 14:34:44 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 150ED68AFE; Thu, 11 Apr 2019 16:34:31 +0200 (CEST)
Date: Thu, 11 Apr 2019 16:34:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: let the dma map ops handle bouncing
Message-ID: <20190411143430.GA17371@lst.de>
References: <20190411070948.29564-1-hch@lst.de>
	<20190411070948.29564-2-hch@lst.de>
	<CAPDyKFqHrvz_5taNTx7k6Skx=Ox+9XgQHHz0LZyr4QNV9orvRw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPDyKFqHrvz_5taNTx7k6Skx=Ox+9XgQHHz0LZyr4QNV9orvRw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411143430.EUEY9oMzeIHIofrmi9BwyuMckDpCU3Y8rVBkC-8_0kI@z>

On Thu, Apr 11, 2019 at 11:00:56AM +0200, Ulf Hansson wrote:
> >         blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
> >         if (mmc_can_erase(card))
> >                 mmc_queue_setup_discard(mq->queue, card);
> >
> > -       blk_queue_bounce_limit(mq->queue, limit);
> > +       if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> > +               blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
> 
> So this means we are not going to set a bounce limit for the queue, in
> case we have a dma mask.
> 
> Why isn't that needed no more? Whats has changed?

On most architectures it was never needed, the major hold out was x86-32
with PAE.  In general the dma_mask tells the DMA API layer what is
supported, and if the physical addressing doesn't support that it has to
use bounce buffering like swiotlb (or dmabounce on arm32).  A couple
month ago I finally fixes x86-32 to also properly set up swiotlb,
and remove the block layerer bounce buffering that wasn't for highmem
(which is about having a kernel mapping, not addressing), and ISA DMA
(which is not handled like everything else, but we'll get there).
But for some reason I missed mmc back then, so mmc right now is the
only remaining user of address based block layer bouncing.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
