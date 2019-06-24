Return-Path: <SRS0=0Jvo=UX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85D7C43613
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 06:22:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07B42146F
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 06:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07B42146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 941DE941;
	Mon, 24 Jun 2019 06:22:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B119FB9E
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 06:22:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 40D3E710
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 06:22:29 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 9127868AFE; Mon, 24 Jun 2019 08:21:57 +0200 (CEST)
Date: Mon, 24 Jun 2019 08:21:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC PATCH v7 2/5] iommu/dma: Add a new dma_map_ops of
	get_merge_boundary()
Message-ID: <20190624062157.GB2989@lst.de>
References: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CGME20190620085043epcas2p1f17aa71e547cf3d2b74dfc0c0dcc5ccb@epcas2p1.samsung.com>
	<1561020610-953-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<8bce95ea-93ac-e783-af7c-ec5bfb8e82f6@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8bce95ea-93ac-e783-af7c-ec5bfb8e82f6@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: axboe@kernel.dk, linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Fri, Jun 21, 2019 at 09:59:21AM +0200, Marek Szyprowski wrote:
> Hi,
> 
> On 2019-06-20 10:50, Yoshihiro Shimoda wrote:
> > This patch adds a new dma_map_ops of get_merge_boundary() to
> > expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 205d694..9950cb5 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1091,6 +1091,16 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >   	return ret;
> >   }
> >   
> > +static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +
> > +	if (domain->type != IOMMU_DOMAIN_DMA)
> > +		return 0;	/* can't merge */
> > +
> > +	return (1 << __ffs(domain->pgsize_bitmap)) - 1;
> > +}
> 
> I really wonder if there is any IOMMU, which doesn't support 4KiB pages. 
> Cannot you simply assume that the merge boundary is 4KiB and avoid 
> adding this new API?

No idea if we have one, but I would not be surprised if one shows
up on a system only built to run with 64k pages for example.

Either way the abstraction seems light and self-explanatory, so I see
now reason not to have it even if we assume it would always return
4k, especially as we'd also still need a flag at the dma_map_ops level
to indicate if segement merging is supported at all.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
