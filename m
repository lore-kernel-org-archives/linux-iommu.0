Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF2C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 19:27:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F5C208E4
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 19:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F5C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0E12B1636;
	Wed, 24 Apr 2019 19:27:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6865A1632
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:27:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CCA9087D
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 19:27:11 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 253F368C4E; Wed, 24 Apr 2019 21:26:53 +0200 (CEST)
Date: Wed, 24 Apr 2019 21:26:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
	page allocations
Message-ID: <20190424192652.GA29032@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
	<20190326230131.16275-2-nicoleotsuka@gmail.com>
	<20190424150638.GA22191@lst.de>
	<20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com,
	linux@armlinux.org.uk, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190424192652.Dgxkzy5oNkbzAv8001HNsa3LC4odDWzdh7ZvVWaP7Uo@z>

On Wed, Apr 24, 2019 at 11:33:11AM -0700, Nicolin Chen wrote:
> I feel it's similar to my previous set, which did most of these
> internally except the renaming part. But Catalin had a concern
> that some platforms might have limits on CMA range [1]. Will it
> be still okay to do the fallback internally?
> 
> [1: https://www.spinics.net/lists/arm-kernel/msg714295.html ]

Catalins statement is correct, but I don't see how it applies to
your patch.  Your patch just ensures that the fallback we have
in most callers is uniformly applied everywhere.  The non-iommu
callers will still need to select a specific zone and/or retry
just the page allocator with other flags if the CMA (or fallback)
page doesn't match what they need.  dma-direct does this correctly
and I think the arm32 allocator does as well, although it is a bit
hard to follow sometimes.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
