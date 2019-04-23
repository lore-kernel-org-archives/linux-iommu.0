Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CD2C10F14
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 09:48:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E83720843
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 09:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E83720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 45C5EF09;
	Tue, 23 Apr 2019 09:48:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DA2D5F08
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 09:48:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 85DB7F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 09:48:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B4C6374;
	Tue, 23 Apr 2019 02:48:52 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60913F557;
	Tue, 23 Apr 2019 02:48:50 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
	helpers
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-13-hch@lst.de>
	<b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
	<20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de>
	<83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
	<20190418163512.GA25347@lst.de>
	<433dec64-ef15-b31d-ace4-4c72b81d2942@arm.com>
	<20190419090759.GA22885@lst.de>
Message-ID: <290377cd-8cd3-aa7a-0057-36df3d7cd728@arm.com>
Date: Tue, 23 Apr 2019 10:48:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419090759.GA22885@lst.de>
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
Message-ID: <20190423094849.ClB-P7CGn25fe2ha3B2e2H0O_JSNvjxpthpvUUhiovU@z>

On 2019-04-19 10:07 am, Christoph Hellwig wrote:
> On Thu, Apr 18, 2019 at 05:41:00PM +0100, Robin Murphy wrote:
>>>   From a very high level POV this looks ok, but sometimes a bit to
>>> convoluted to me.  The major issue why I went with the version I posted
>>> is that I can cleanly ifdef out the remap code in just a few sections.
>>> In this version it is spread out a lot more, and the use of IS_ENABLED
>>> means that we'd need a lot more stubs for functionality that won't
>>> ever be called but needs to be compilable.
>>
>> What functionality do you have planned in that regard? I did do a quick
>> build test of my arm64 config with DMA_DIRECT_REMAP hacked out, and
>> dma-iommu.o appeared to link OK (although other bits of arm64 and
>> dma-direct didn't, as expected). I will try x86 with IOMMU_DMA to make
>> sure, though.
> 
> Yeah, this seems to actually work, there just is a huge chunk of
> remapping that is hopefully discarded by the compiler even without the
> ifdefs.

Right, the major point of this approach is that you don't need stubs; 
indeed, stubs themselves fall into the category of "#ifdefed code I'd 
prefer to avoid". The preprocessing essentially resolves to:

	if (0)
		function_that_doesnt_exist();

so compilation treats it as an external reference, but since constant 
folding ends up eliding the call, that symbol isn't referenced in the 
final object, so linking never has to resolve it. All it needs is a 
declaration to avoid a compiler warning, but that's the same declaration 
that's needed anyway for when the function does exist. Similarly, static 
functions like iommu_dma_alloc_remap() still get compiled - so we don't 
lose coverage - but then get discarded at the link stage (via 
gc-sections) since they end up unreferenced. It's really pretty neat.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
