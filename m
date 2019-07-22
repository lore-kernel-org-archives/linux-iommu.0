Return-Path: <SRS0=E6XH=VT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE584C76188
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 15:26:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAF22084D
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 15:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAF22084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C8A9D82;
	Mon, 22 Jul 2019 15:26:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9E4FFD13;
	Mon, 22 Jul 2019 15:26:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4C0B7102;
	Mon, 22 Jul 2019 15:26:40 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C11868B20; Mon, 22 Jul 2019 17:26:38 +0200 (CEST)
Date: Mon, 22 Jul 2019 17:26:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 1/2] dma-mapping: Protect dma_addressing_limited
	against NULL dma_mask
Message-ID: <20190722152637.GA3780@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190722145509.1284-2-eric.auger@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com,
	robin.murphy@arm.com, hch@lst.de
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

>  static inline bool dma_addressing_limited(struct device *dev)
>  {
> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> -		dma_get_required_mask(dev);
> +	return WARN_ON_ONCE(!dev->dma_mask) ? false :
> +		min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> +			dma_get_required_mask(dev);

This should really use a separate if statement, but I can fix that
up when applying it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
