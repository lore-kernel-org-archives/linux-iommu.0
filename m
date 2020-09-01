Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA24C433E7
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:13:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EC320767
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EC320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D95CB870C4;
	Tue,  1 Sep 2020 17:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6Ab9POMJo-6; Tue,  1 Sep 2020 17:13:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3255A8708C;
	Tue,  1 Sep 2020 17:13:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 280FBC07FF;
	Tue,  1 Sep 2020 17:13:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BFABC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 983A086155
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EkraXY4yKSNG for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 17:13:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D664785082
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:13:06 +0000 (UTC)
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1kD9qC-0004aY-00; Tue, 01 Sep 2020 19:13:04 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id A3E0EC0E68; Tue,  1 Sep 2020 19:12:41 +0200 (CEST)
Date: Tue, 1 Sep 2020 19:12:41 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 22/28] sgiseeq: convert from dma_cache_sync to
 dma_sync_single_for_device
Message-ID: <20200901171241.GA20685@alpha.franken.de>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-23-hch@lst.de>
 <20200901152209.GA14288@alpha.franken.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200901152209.GA14288@alpha.franken.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-nvme@lists.infradead.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>, linux-media@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
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

On Tue, Sep 01, 2020 at 05:22:09PM +0200, Thomas Bogendoerfer wrote:
> On Wed, Aug 19, 2020 at 08:55:49AM +0200, Christoph Hellwig wrote:
> > Use the proper modern API to transfer cache ownership for incoherent DMA.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/net/ethernet/seeq/sgiseeq.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/seeq/sgiseeq.c b/drivers/net/ethernet/seeq/sgiseeq.c
> > index 39599bbb5d45b6..f91dae16d69a19 100644
> > --- a/drivers/net/ethernet/seeq/sgiseeq.c
> > +++ b/drivers/net/ethernet/seeq/sgiseeq.c
> > @@ -112,14 +112,18 @@ struct sgiseeq_private {
> >  
> >  static inline void dma_sync_desc_cpu(struct net_device *dev, void *addr)
> >  {
> > -	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> > -		       DMA_FROM_DEVICE);
> > +	struct sgiseeq_private *sp = netdev_priv(dev);
> > +
> > +	dma_sync_single_for_cpu(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> > +			sizeof(struct sgiseeq_rx_desc), DMA_BIDIRECTIONAL);
> >  }
> >  
> >  static inline void dma_sync_desc_dev(struct net_device *dev, void *addr)
> >  {
> > -	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> > -		       DMA_TO_DEVICE);
> > +	struct sgiseeq_private *sp = netdev_priv(dev);
> > +
> > +	dma_sync_single_for_device(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> > +			sizeof(struct sgiseeq_rx_desc), DMA_BIDIRECTIONAL);
> >  }
> 
> this breaks ethernet on IP22 completely, but I haven't figured out why, yet.

the problem is that dma_sync_single_for_cpu() doesn't flush anything
for IP22, because it only flushes for CPUs which do speculation. So
either MIPS arch_sync_dma_for_cpu() should always flush or sgiseeq
needs to use a different sync funktion, when it wants to re-read descriptors
from memory.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
