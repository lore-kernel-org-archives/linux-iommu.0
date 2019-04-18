Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A0C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 16:41:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760092064A
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 16:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760092064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 339BC1A8D;
	Thu, 18 Apr 2019 16:41:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 414871A88
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 16:41:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id EEC2E108
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 16:41:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5302380D;
	Thu, 18 Apr 2019 09:41:04 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0132E3F557;
	Thu, 18 Apr 2019 09:41:01 -0700 (PDT)
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
	helpers
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-13-hch@lst.de>
	<b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
	<20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de>
	<83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
	<20190418163512.GA25347@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <433dec64-ef15-b31d-ace4-4c72b81d2942@arm.com>
Date: Thu, 18 Apr 2019 17:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418163512.GA25347@lst.de>
Content-Language: en-GB
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418164100.PYnNJLaWvXzGuuOMv9-jx2ANv0BsZWOC2OcP6BgZ_8c@z>

On 18/04/2019 17:35, Christoph Hellwig wrote:
> On Thu, Apr 18, 2019 at 04:06:56PM +0100, Robin Murphy wrote:
>> OK, I'm still looking at mmap and get_sgtable, but for now I've pushed out
>> a partial branch that consolidates alloc and free in a way which makes
>> sense to me:
>>
>>    git://linux-arm.org/linux-rm  dma/rework
>>
>> Please let me know what you think.
> 
>  From a very high level POV this looks ok, but sometimes a bit to
> convoluted to me.  The major issue why I went with the version I posted
> is that I can cleanly ifdef out the remap code in just a few sections.
> In this version it is spread out a lot more, and the use of IS_ENABLED
> means that we'd need a lot more stubs for functionality that won't
> ever be called but needs to be compilable.

What functionality do you have planned in that regard? I did do a quick 
build test of my arm64 config with DMA_DIRECT_REMAP hacked out, and 
dma-iommu.o appeared to link OK (although other bits of arm64 and 
dma-direct didn't, as expected). I will try x86 with IOMMU_DMA to make 
sure, though.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
