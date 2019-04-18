Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE12C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 18:15:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BA620675
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 18:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BA620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2FC651BF9;
	Thu, 18 Apr 2019 18:15:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D87121934
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 18:15:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 8DEDC82D
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 18:15:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BC7F80D;
	Thu, 18 Apr 2019 11:15:04 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE7893F5AF;
	Thu, 18 Apr 2019 11:15:02 -0700 (PDT)
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
Message-ID: <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
Date: Thu, 18 Apr 2019 19:15:00 +0100
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
Message-ID: <20190418181500.UtDCwWUnhaq64oVuEjEY1NgRaMl2oxMgaaDChzP0XDg@z>

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

OK, for some reason I'd convinced myself that mmap and get_sgtable would 
need changes to properly handle the new non-remapped CMA case - not sure 
how I reached that conclusion. On inspection they do appear to be broken 
for the non-coherent atomic case, but AFAICS that's been so forever...

Still, I've worked in the vm_map_pages() stuff pending in MM and given 
them the same treatment to finish the picture. Both x86_64_defconfig and 
i386_defconfig do indeed compile and link fine as I expected, so I 
really would like to understand the concern around #ifdefs better.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
