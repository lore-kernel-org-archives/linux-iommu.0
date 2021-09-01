Return-Path: <SRS0=1qmC=NX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05145C432BE
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 18:53:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F22D61183
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 18:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F22D61183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B01F80C8C;
	Wed,  1 Sep 2021 18:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cd0CgwAfoRtT; Wed,  1 Sep 2021 18:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3404180C7D;
	Wed,  1 Sep 2021 18:53:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB86C0010;
	Wed,  1 Sep 2021 18:53:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EC51C000E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 18:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1520D4011D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 18:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wr0fggNjttHN for <iommu@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 18:53:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 352CB400BD
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 18:53:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E847F1063;
 Wed,  1 Sep 2021 11:53:30 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 623C13F694;
 Wed,  1 Sep 2021 11:53:29 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] iommu: Move IOMMU pagesize check to attach_device
To: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-7-sven@svenpeter.dev> <YS6hl0gAOMoMxNhf@sunset>
 <adee671d-976a-4906-8592-c7391da9906b@www.fastmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ede06b33-38ff-1ba2-c32c-c5bb3aaddb62@arm.com>
Date: Wed, 1 Sep 2021 19:53:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <adee671d-976a-4906-8592-c7391da9906b@www.fastmail.com>
Content-Language: en-GB
Cc: Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-09-01 18:14, Sven Peter wrote:
> 
> 
> On Tue, Aug 31, 2021, at 23:39, Alyssa Rosenzweig wrote:
>>> +	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {
>>
>> Not a fan of this construction. Could you assign `(1 <<
>> __ffs(domain->pgsize_bitmap))` to an appropriately named temporary (e.g
>> min_io_pgsize) so it's clearer what's going on?
> 
> Good point, will do that for the next version.

Or maybe just test "__ffs(domain->pgsize_bitmap) > PAGE_SHIFT", or 
perhaps even avoid shifts altogether with something like 
"domain->pgsize_bitmap & (PAGE_SIZE | PAGE_SIZE - 1)".

Robin.

> 
>>
>>> +		pr_warn("IOMMU page size cannot represent CPU pages.\n");
>>
>> "Represent" how?
>>
> 
> Looks like I dropped an "exactly" there when taking this line from iova.c :)
> 
> 
> 
> Thanks,
> 
> 
> Sven
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
