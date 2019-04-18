Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F9BC10F14
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 15:07:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE7A205F4
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 15:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE7A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1E31C1908;
	Thu, 18 Apr 2019 15:07:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3915D1902
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 15:07:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DF4C8823
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 15:06:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E06515AB;
	Thu, 18 Apr 2019 08:06:59 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 458363F5AF;
	Thu, 18 Apr 2019 08:06:58 -0700 (PDT)
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
	helpers
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-13-hch@lst.de>
	<b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
	<20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
Date: Thu, 18 Apr 2019 16:06:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417063358.GA24139@lst.de>
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
Message-ID: <20190418150656.1PJBnjxuMkCpIbiFA6x9ChItY63seK-8mjHk_X4bKBA@z>

On 17/04/2019 07:33, Christoph Hellwig wrote:
> On Wed, Apr 10, 2019 at 08:11:57AM +0200, Christoph Hellwig wrote:
>> On Tue, Apr 09, 2019 at 06:59:32PM +0100, Robin Murphy wrote:
>>> On 27/03/2019 08:04, Christoph Hellwig wrote:
>>>> This keeps the code together and will simplify compiling the code
>>>> out on architectures that are always dma coherent.
>>>
>>> And this is where things take a turn in the direction I just can't get on
>>> with - I'm looking at the final result and the twisty maze of little
>>> disjoint helpers all overlapping each other in functionality is really
>>> difficult to follow. And I would *much* rather have things rely on
>>> compile-time constant optimisation than spend the future having to fix the
>>> #ifdefed parts for arm64 whenever x86-centric changes fail to test them.
>>
>> Can you draft up a patch on top of my series to show me what you
>> want?  I can take care of finishing it up and moving the changes
>> into the right patches in the series.
> 
> Any chance to make some progress on this?  Or at least a better
> description of what you want?

OK, I'm still looking at mmap and get_sgtable, but for now I've pushed 
out a partial branch that consolidates alloc and free in a way which 
makes sense to me:

   git://linux-arm.org/linux-rm  dma/rework

Please let me know what you think.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
