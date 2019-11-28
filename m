Return-Path: <SRS0=S8Y4=ZU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EDEC432C0
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 07:52:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E36215E5
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 07:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E36215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 35BC987736;
	Thu, 28 Nov 2019 07:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y9jEjywy3xKn; Thu, 28 Nov 2019 07:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4195987787;
	Thu, 28 Nov 2019 07:52:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BED7C1DDA;
	Thu, 28 Nov 2019 07:52:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44A11C0881
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 07:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2E0DB86DDB
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 07:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fmoSI30CYOK7 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Nov 2019 07:51:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 00A3986864
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 07:51:56 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7F47868B05; Thu, 28 Nov 2019 08:51:53 +0100 (CET)
Date: Thu, 28 Nov 2019 08:51:53 +0100
From: "hch@lst.de" <hch@lst.de>
To: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH 2/2] dma-mapping: force unencryped devices are always
 addressing limited
Message-ID: <20191128075153.GD20659@lst.de>
References: <20191127144006.25998-1-hch@lst.de>
 <20191127144006.25998-3-hch@lst.de>
 <a95d9115fc2a80de2f97f001bbcd9aba6636e685.camel@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a95d9115fc2a80de2f97f001bbcd9aba6636e685.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
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

On Wed, Nov 27, 2019 at 06:22:57PM +0000, Thomas Hellstrom wrote:
> >  bool dma_addressing_limited(struct device *dev)
> >  {
> > +	if (force_dma_unencrypted(dev))
> > +		return true;
> >  	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
> >  			    dma_get_required_mask(dev);
> >  }
> 
> Any chance to have the case
> 
> (swiotlb_force == SWIOTLB_FORCE)
> 
> also included?

We have a hard time handling that in generic code.  Do we have any
good use case for SWIOTLB_FORCE not that we have force_dma_unencrypted?
I'd love to be able to get rid of it..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
