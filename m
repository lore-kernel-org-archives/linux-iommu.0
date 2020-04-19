Return-Path: <SRS0=y66L=6D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CC1C2BA2B
	for <iommu@archiver.kernel.org>; Sun, 19 Apr 2020 08:01:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A1221D82
	for <iommu@archiver.kernel.org>; Sun, 19 Apr 2020 08:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A1221D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1AEE78768B;
	Sun, 19 Apr 2020 08:01:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gQkMmg4PVKXF; Sun, 19 Apr 2020 08:01:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 325A887524;
	Sun, 19 Apr 2020 08:01:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FD7FC1D7E;
	Sun, 19 Apr 2020 08:01:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F171C0177
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 08:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8F1B98544C
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 08:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CwW7r6vO8L2I for <iommu@lists.linux-foundation.org>;
 Sun, 19 Apr 2020 08:01:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3218385427
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 08:01:03 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7C63E68BEB; Sun, 19 Apr 2020 10:00:58 +0200 (CEST)
Date: Sun, 19 Apr 2020 10:00:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/4] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200419080058.GB12222@lst.de>
References: <20200414122506.438134-1-hch@lst.de>
 <20200414122506.438134-4-hch@lst.de> <20200418124205.GD6113@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200418124205.GD6113@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
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

On Sat, Apr 18, 2020 at 02:42:05PM +0200, Joerg Roedel wrote:
> Hi Christoph,
> 
> On Tue, Apr 14, 2020 at 02:25:05PM +0200, Christoph Hellwig wrote:
> > +static inline bool dma_map_direct(struct device *dev,
> > +		const struct dma_map_ops *ops)
> > +{
> > +	if (likely(!ops))
> > +		return true;
> > +	if (!dev->dma_ops_bypass)
> > +		return false;
> > +
> > +	return min_not_zero(*dev->dma_mask, dev->bus_dma_limit) >=
> > +			    dma_direct_get_required_mask(dev);
> 
> Why is the dma-mask check done here? The dma-direct code handles memory
> outside of the devices dma-mask with swiotlb, no?
> 
> I also don't quite get what the difference between setting the
> dma_ops_bypass flag non-zero and setting ops to NULL is.

The difference is that NULL ops mean imply the direct mapping is always
used, dma_ops_bypass means a direct mapping is used if no bounce buffering
using swiotlb is needed, which should also answer your first question.
The idea is to consolidate code in the core to use an opportunistic
direct mapping instead of the dynamic iommu mapping.  I though the cover
letter and commit log explained this well enough, but maybe I need to
do a better job.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
