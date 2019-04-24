Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F3AC10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 15:06:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23682084F
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 15:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23682084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A3D86FD5;
	Wed, 24 Apr 2019 15:06:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C526CFD2
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 15:06:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 60E1A74A
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 15:06:56 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id EB16368AA6; Wed, 24 Apr 2019 17:06:38 +0200 (CEST)
Date: Wed, 24 Apr 2019 17:06:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
	page allocations
Message-ID: <20190424150638.GA22191@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
	<20190326230131.16275-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190326230131.16275-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	linux@armlinux.org.uk, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, hch@lst.de,
	linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190424150638.co2Zxx1E1yPoejiRENyPjD7E-XEbAj8tfeARNGA4IJw@z>

On Tue, Mar 26, 2019 at 04:01:27PM -0700, Nicolin Chen wrote:
>  	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
> +	if (!page)
> +		page = alloc_pages(gfp, order);

We have this fallback in most callers already.  And with me adding
it to the dma-iommu code in one series, and you to arm here I think
we really need to take a step back and think of a better way
to handle this, and the general mess that dma_alloc_from_contiguous.

So what about:

 (1) change the dma_alloc_from_contiguous prototype to be:

struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);

     that is: calculate order and count internally, pass the full gfp_t
     and mask it internally, and drop the pointless from in the name.
     I'd also use the oppurtunity to forbid a NULL dev argument and
     opencode those uses.
 
 (2) handle the alloc_pages fallback internally.  Note that we should
     use alloc_pages_node as we do in dma-direct.

> +			if (!dma_release_from_contiguous(dev, page, count))
> +				__free_pages(page, get_order(size));

Same for dma_release_from_contiguous - drop the _from, pass the
actual size, and handle the free_pages fallback.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
