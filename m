Return-Path: <SRS0=FJ9b=3U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD0EC2D0DB
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 17:43:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A40A214D8
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 17:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A40A214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5C4E2228A0;
	Fri, 31 Jan 2020 17:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gezlc0yxWe+D; Fri, 31 Jan 2020 17:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 957BD2043B;
	Fri, 31 Jan 2020 17:43:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D7F0C0178;
	Fri, 31 Jan 2020 17:43:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 513FFC0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 17:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4128A86AE8
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 17:43:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PXLXNRAMaXgm for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 17:43:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 813D986AE6
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 17:43:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C78FAFEC;
 Fri, 31 Jan 2020 09:43:50 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF0873F68E;
 Fri, 31 Jan 2020 09:43:49 -0800 (PST)
Subject: Re: [PATCH] dma-debug: dynamic allocation of hash table
To: Eric Dumazet <edumazet@google.com>
References: <20200130191049.190569-1-edumazet@google.com>
 <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
 <CANn89i+fRqeSAz9eH8f2ujzBWSLUXw0eTT=tK=eNj8hL71MiFQ@mail.gmail.com>
 <f870ae85-995f-7866-ebbd-95b89ca28dc5@arm.com>
 <CANn89iKfA+yPHiL4R7-jkewwhDgM6jkwhW5o9H=VL9CnyBikhw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <62e1ee46-ad9e-988f-a2a3-8fd217e28f24@arm.com>
Date: Fri, 31 Jan 2020 17:43:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CANn89iKfA+yPHiL4R7-jkewwhDgM6jkwhW5o9H=VL9CnyBikhw@mail.gmail.com>
Content-Language: en-GB
Cc: Joerg Roedel <jroedel@suse.de>, Eric Dumazet <eric.dumazet@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>
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

On 31/01/2020 2:42 pm, Eric Dumazet wrote:
> On Fri, Jan 31, 2020 at 4:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> ...and when that represents ~5% of the total system RAM it is a *lot*
>> less reasonable than even 12KB. As I said, it's great to make a debug
>> option more efficient such that what it observes is more representative
>> of the non-debug behaviour, but it mustn't come at the cost of making
>> the entire option unworkable for other users.
>>
> 
> Then I suggest you send a patch to reduce PREALLOC_DMA_DEBUG_ENTRIES
> because having 65536 preallocated entries consume 4 MB of memory.

...unless it's overridden on the command-line ;)

> Actually this whole attempt to re-implement slab allocations in this
> file is suspect.

Again that's a matter of expected usage patterns - typically the 
"reasonable default" or user-defined preallocation should still be 
enough (as it *had* to be before), and the kind of systems that can 
sustain so many live mappings as to regularly hit the dynamic expansion 
path are also likely to have enough memory not to care that later-unused 
entries never get 'properly' freed back to the kernel (plus as you've 
observed, many workloads tend to reach a steady state where entries are 
mostly only transiently free anyway). The reasoning for the exact 
implementation details is there in the commit logs.

> Do not get me wrong, but if you really want to run linux on a 16MB host,
> I guess you need to add CONFIG_BASE_SMALL all over the places,
> not only in this kernel/dma/debug.c file.

Right, nobody's suggesting that defconfig should "just work" on your 
router/watch/IoT shoelaces/whatever, I'm just saying that tuning any 
piece of common code for datacenter behemoths, for quality-of-life 
rather than functional necessity, and leaving no way to adjust it other 
than hacking the source, would represent an unnecessary degree of 
short-sightedness that we can and should avoid.

Taking a closer look at the code, it appears fairly straightforward to 
make the hash size variable, and in fact making it self-adjusting 
doesn't seem too big a jump from there. I'm happy to have a go at that 
myself if you like.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
