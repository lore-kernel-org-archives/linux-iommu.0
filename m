Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F599C433DF
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 12:53:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5926E206C3
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 12:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5926E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2375F85FC6;
	Mon,  8 Jun 2020 12:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HjwlFntFhqKF; Mon,  8 Jun 2020 12:53:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7EAB985FAC;
	Mon,  8 Jun 2020 12:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64F70C07FF;
	Mon,  8 Jun 2020 12:53:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FADBC016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 12:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F20BB8815E
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 12:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Id9KMn0ayiSe for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 12:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id E40A78816F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 12:53:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D97DF31B;
 Mon,  8 Jun 2020 05:53:21 -0700 (PDT)
Received: from [10.57.9.113] (unknown [10.57.9.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C02BA3F52E;
 Mon,  8 Jun 2020 05:53:20 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: Fix too large DMA pools on medium systems
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20200608085231.8924-1-geert@linux-m68k.org>
 <92b53a24-2f1f-2add-6bea-eeda7317520f@arm.com>
 <CAMuHMdXxT5ZgcK5r0MWOk7vWVj63gmr6k3zgACe2Lew7Q4KC9w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <aef59070-6e16-1503-b7a0-0e089369b72b@arm.com>
Date: Mon, 8 Jun 2020 13:53:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXxT5ZgcK5r0MWOk7vWVj63gmr6k3zgACe2Lew7Q4KC9w@mail.gmail.com>
Content-Language: en-GB
Cc: Linux IOMMU <iommu@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 David Rientjes <rientjes@google.com>
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

On 2020-06-08 13:25, Geert Uytterhoeven wrote:
> Hi Robin,
> 
> On Mon, Jun 8, 2020 at 2:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2020-06-08 09:52, Geert Uytterhoeven wrote:
>>> On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
>>> memory pools are much larger than intended (e.g. 2 MiB instead of 128
>>> KiB on a 256 MiB system).
>>>
>>> Fix this by correcting the calculation of the number of GiBs of RAM in
>>> the system.
>>>
>>> Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
>>> --- a/kernel/dma/pool.c
>>> +++ b/kernel/dma/pool.c
>>> @@ -175,8 +175,8 @@ static int __init dma_atomic_pool_init(void)
>>>         * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
>>>         */
>>>        if (!atomic_pool_size) {
>>> -             atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
>>> -                                     SZ_128K;
>>> +             unsigned long gigs = totalram_pages() >> (30 - PAGE_SHIFT);
>>> +             atomic_pool_size = max(gigs, 1UL) * SZ_128K;
>>>                atomic_pool_size = min_t(size_t, atomic_pool_size,
>>>                                         1 << (PAGE_SHIFT + MAX_ORDER-1));
>>>        }
>>
>> Nit: although this probably is right, it seems even less readable than
> 
> ">> (x - PAGE_SHIFT)" is a commonly used construct in the kernel.

Sure, but when "x" is a magic number there's still extra cognitive load 
in determining whether it's the *right* magic number ;)

Mostly, though, it was just the fact that an expression involving 5 
different units (bytes, pages, "gigs", bits, and whatever MAX_ORDER is) 
is inherently more challenging to follow than the equivalent thing 
framed in fewer, especially when it can be reasonably done in just two 
(bytes and pages).

Robin.

>> the broken version (where at least some at-a-glance 'dimensional
>> analysis' flags up "(number of pages) >> PAGE_SHIFT" as rather
>> suspicious). How about a something a little more self-explanatory, e.g.:
>>
>>          unsigned long pages = totalram_pages() * SZ_128K / SZ_1GB;
> 
> That multiplication will overflow on 32-bit systems (perhaps even on
> large 64-bit systems; any 47-bit addressing?).
> 
>          unsigned long pages = totalram_pages() / (SZ_1GB / SZ_128K);
> 
>>          atomic_pool_size = min(pages, MAX_ORDER_NR_PAGES) << PAGE_SHIFT;
>>          atomic_pool_size = max_t(size_t, atomic_pool_size, SZ_128K);
> 
> I agree this part is an improvement.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
