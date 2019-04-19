Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D416C282DA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 09:08:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775EE218CD
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 09:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775EE218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5F4C8230D;
	Fri, 19 Apr 2019 09:08:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 771AD2308
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 09:08:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 14BF5466
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 09:08:15 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 3141F68B20; Fri, 19 Apr 2019 11:08:00 +0200 (CEST)
Date: Fri, 19 Apr 2019 11:07:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
	helpers
Message-ID: <20190419090759.GA22885@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-13-hch@lst.de>
	<b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
	<20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de>
	<83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
	<20190418163512.GA25347@lst.de>
	<433dec64-ef15-b31d-ace4-4c72b81d2942@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <433dec64-ef15-b31d-ace4-4c72b81d2942@arm.com>
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
Message-ID: <20190419090759.zIhB1ExvANz2cyx84p64Px8E_vdfUOuMHbCzjTcG87M@z>

On Thu, Apr 18, 2019 at 05:41:00PM +0100, Robin Murphy wrote:
>>  From a very high level POV this looks ok, but sometimes a bit to
>> convoluted to me.  The major issue why I went with the version I posted
>> is that I can cleanly ifdef out the remap code in just a few sections.
>> In this version it is spread out a lot more, and the use of IS_ENABLED
>> means that we'd need a lot more stubs for functionality that won't
>> ever be called but needs to be compilable.
>
> What functionality do you have planned in that regard? I did do a quick 
> build test of my arm64 config with DMA_DIRECT_REMAP hacked out, and 
> dma-iommu.o appeared to link OK (although other bits of arm64 and 
> dma-direct didn't, as expected). I will try x86 with IOMMU_DMA to make 
> sure, though.

Yeah, this seems to actually work, there just is a huge chunk of
remapping that is hopefully discarded by the compiler even without the
ifdefs.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
