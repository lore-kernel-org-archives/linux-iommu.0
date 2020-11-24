Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F94DC56201
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 13:33:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2ECD20708
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 13:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ECD20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F72C86777;
	Tue, 24 Nov 2020 13:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6KMH6AodxBM2; Tue, 24 Nov 2020 13:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E16A785C45;
	Tue, 24 Nov 2020 13:33:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6A97C163C;
	Tue, 24 Nov 2020 13:33:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89968C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7571D86151
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3Fi+ub+eeXF for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 13:33:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8776B85C45
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:33:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4C5866736F; Tue, 24 Nov 2020 14:33:15 +0100 (CET)
Date: Tue, 24 Nov 2020 14:33:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH] WIP! media: uvcvideo: Use dma_alloc_noncontiguos API
Message-ID: <20201124133315.GA30214@lst.de>
References: <20200930160917.1234225-9-hch@lst.de>
 <20201118142546.170621-1-ribalda@chromium.org>
 <20201124113512.GA21974@lst.de>
 <CANiDSCtLrqWBOmC9X91V8P-aahQr2=L-GQNjHM6YauT69_QcEg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANiDSCtLrqWBOmC9X91V8P-aahQr2=L-GQNjHM6YauT69_QcEg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
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

On Tue, Nov 24, 2020 at 01:01:33PM +0100, Ricardo Ribalda wrote:
> I was hoping that you could answer that question :).
> 
> Do you have other use-cases than linux-media in mind?
> 
> I think Sergey wants to experiment also with vb2, to figure out how
> much it affects it.
> His change will be much more complicated than mine thought, there are
> more cornercases there.

I don't have anything urgend lined up, although I think there are plenty
other potential use cases.

> > Can you respost a combined series to get started?
> 
> Sure. Shall I also include the profiling patch?

That is in the media code, right?  I don't really care too much.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
