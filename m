Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68661C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 06:12:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4181F20850
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 06:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4181F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0F4C814EA;
	Wed, 10 Apr 2019 06:12:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C877114E7
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 06:12:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 843D817E
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 06:12:11 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 7047968B05; Wed, 10 Apr 2019 08:11:58 +0200 (CEST)
Date: Wed, 10 Apr 2019 08:11:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
	helpers
Message-ID: <20190410061157.GA5278@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-13-hch@lst.de>
	<b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
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
Message-ID: <20190410061158.YbAWl9MKn_xCFZPHg1jc4KaZKXCtEDPtrvSgX-HRzCA@z>

On Tue, Apr 09, 2019 at 06:59:32PM +0100, Robin Murphy wrote:
> On 27/03/2019 08:04, Christoph Hellwig wrote:
>> This keeps the code together and will simplify compiling the code
>> out on architectures that are always dma coherent.
>
> And this is where things take a turn in the direction I just can't get on 
> with - I'm looking at the final result and the twisty maze of little 
> disjoint helpers all overlapping each other in functionality is really 
> difficult to follow. And I would *much* rather have things rely on 
> compile-time constant optimisation than spend the future having to fix the 
> #ifdefed parts for arm64 whenever x86-centric changes fail to test them.

Can you draft up a patch on top of my series to show me what you
want?  I can take care of finishing it up and moving the changes
into the right patches in the series.

> Conceptually, everything except the iommu_dma_alloc_remap() case is more or 
> less just dma_direct_alloc() with an IOMMU mapping on top - if we could 
> pass that an internal flag to say "don't fail or bounce because of masks" 
> it seems like that approach could end up being quite a bit simpler (I did 
> once have lofty plans to refactor the old arm64 code in such a way...)

I've been wanting to share more code between DMA direct and the iommu
allocators.  But this series already is huge and has been pending
far too long.  I'll eventually get to it..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
