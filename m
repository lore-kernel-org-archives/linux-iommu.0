Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB1C004C9
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 19:04:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC092075E
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 19:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC092075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DFBFB2C06;
	Mon, 29 Apr 2019 19:04:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 258D21F6D
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 19:04:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BA7A8883
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 19:04:05 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 6398268AFE; Mon, 29 Apr 2019 21:03:48 +0200 (CEST)
Date: Mon, 29 Apr 2019 21:03:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 14/26] iommu/dma: Refactor iommu_dma_free
Message-ID: <20190429190348.GB5637@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
	<20190422175942.18788-15-hch@lst.de>
	<8321a363-f448-3e48-48f6-58d2b44a2900@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8321a363-f448-3e48-48f6-58d2b44a2900@arm.com>
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
Message-ID: <20190429190348.0hxuTyq5ut5y4Rum9zDedtaZiTAtKksWTE2QCR-cmqI@z>

On Mon, Apr 29, 2019 at 02:59:43PM +0100, Robin Murphy wrote:
> Hmm, I do still prefer my original flow with the dma_common_free_remap() 
> call right out of the way at the end rather than being a special case in 
> the middle of all the page-freeing (which is the kind of existing 
> complexity I was trying to eliminate). I guess you've done this to avoid 
> having "if (!dma_release_from_contiguous(...))..." twice like I ended up 
> with, which is fair enough I suppose - once we manage to solve the new 
> dma_{alloc,free}_contiguous() interface that may tip the balance so I can 
> always revisit this then.

Ok, I'll try to accomodate that with a minor rework.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
