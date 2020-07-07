Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B43C433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 06:47:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9766020675
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 06:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9766020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3CCF8203EE;
	Tue,  7 Jul 2020 06:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ewNGWQfToaY; Tue,  7 Jul 2020 06:47:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7856A2037E;
	Tue,  7 Jul 2020 06:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60063C0891;
	Tue,  7 Jul 2020 06:47:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76B6CC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 65C85893AF
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YfvGM5YWprPM for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 06:47:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 39BDD88F41
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:47:34 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id AD38268AFE; Tue,  7 Jul 2020 08:47:30 +0200 (CEST)
Date: Tue, 7 Jul 2020 08:47:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: [PATCH 1/4] dma-mapping: add a new dma_need_sync API
Message-ID: <20200707064730.GA23602@lst.de>
References: <20200629130359.2690853-1-hch@lst.de>
 <20200629130359.2690853-2-hch@lst.de>
 <20200706194227.vfhv5o4lporxjxmq@bsd-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200706194227.vfhv5o4lporxjxmq@bsd-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bpf@vger.kernel.org,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 Christoph Hellwig <hch@lst.de>, Magnus Karlsson <magnus.karlsson@intel.com>
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

On Mon, Jul 06, 2020 at 12:42:27PM -0700, Jonathan Lemon wrote:
> On Mon, Jun 29, 2020 at 03:03:56PM +0200, Christoph Hellwig wrote:
> > Add a new API to check if calls to dma_sync_single_for_{device,cpu} are
> > required for a given DMA streaming mapping.
> > 
> > +::
> > +
> > +	bool
> > +	dma_need_sync(struct device *dev, dma_addr_t dma_addr);
> > +
> > +Returns %true if dma_sync_single_for_{device,cpu} calls are required to
> > +transfer memory ownership.  Returns %false if those calls can be skipped.
> 
> Hi Christoph -
> 
> Thie call above is for a specific dma_addr.  For correctness, would I
> need to check every addr, or can I assume that for a specific memory
> type (pages returned from malloc), that the answer would be identical?

You need to check every mapping.  E.g. this API pairs with a
dma_map_single/page call.  For S/G mappings you'd need to call it for
each entry, although if you have a use case for that we really should
add a dma_sg_need_sync helper instea of open coding the scatterlist walk.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
