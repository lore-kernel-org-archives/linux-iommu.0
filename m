Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C89C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 11:51:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5BA20673
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 11:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5BA20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D13BE1F5B;
	Mon, 29 Apr 2019 11:51:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 583651F3F
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 11:49:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 00103711
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 11:49:35 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id D4EC168AFE; Mon, 29 Apr 2019 13:49:18 +0200 (CEST)
Date: Mon, 29 Apr 2019 13:49:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
	helpers
Message-ID: <20190429114918.GB30460@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-13-hch@lst.de>
	<b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
	<20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de>
	<83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
	<20190418163512.GA25347@lst.de>
	<228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
	<20190419082348.GA22299@lst.de>
	<0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20190429114918.JkeACFJiYWEXQ6ngetg9nnoLEyqGXoNIMaPrEqQioLE@z>

On Tue, Apr 23, 2019 at 11:01:44AM +0100, Robin Murphy wrote:
> Wouldn't this suffice? Since we also use alloc_pages() in the coherent 
> atomic case, the free path should already be able to deal with it.
>
> Let me take a proper look at v3 and see how it all looks in context.

Any comments on v3?  I've been deferring lots of other DMA work to
not create conflicts, so I'd hate to miss this merge window.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
