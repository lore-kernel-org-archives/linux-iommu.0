Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56977C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 12:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F22A5607D3;
	Tue,  7 Dec 2021 12:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DrqmAE8EcQxw; Tue,  7 Dec 2021 12:43:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5500607C0;
	Tue,  7 Dec 2021 12:43:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA234C002F;
	Tue,  7 Dec 2021 12:43:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B613EC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 931E3607D3
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PH_Y7swMHHR6 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 12:43:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99211607C0
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:43:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2DC711FB;
 Tue,  7 Dec 2021 04:43:12 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33B4C3F5A1;
 Tue,  7 Dec 2021 04:43:12 -0800 (PST)
Message-ID: <8868f719-f6fe-4210-cd2d-03075dd49d53@arm.com>
Date: Tue, 7 Dec 2021 12:43:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 04/11] dma-direct: clean up the remapping checks in
 dma_direct_alloc
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
References: <20211111065028.32761-1-hch@lst.de>
 <20211111065028.32761-5-hch@lst.de>
 <4f0109a6-8aea-185a-b73a-0b6e5ed1d514@arm.com>
 <20211207114943.GB20713@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211207114943.GB20713@lst.de>
Cc: iommu@lists.linux-foundation.org, David Rientjes <rientjes@google.com>
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

On 2021-12-07 11:49, Christoph Hellwig wrote:
> On Mon, Dec 06, 2021 at 04:33:10PM +0000, Robin Murphy wrote:
>> On 2021-11-11 06:50, Christoph Hellwig wrote:
>>> Add two local variables to track if we want to remap the returned
>>> address using vmap or call dma_set_uncached and use that to simplify
>>> the code flow.
>>
>> I still wonder about the asymmetry between the remap and set_uncached cases
>> WRT the memset(), which stands out even more the further we clean things
>> up, but that's another matter.
> 
> The memset for the remap case obviously needs to be done after
> remapping.

For highmem and certain encryption setups, yes, but plain non-cacheable 
remaps like on arm64 could technically be done either way round.

> OTOH for the set_uncached case the memset is much faste
> when done on the cached mapping, which must be done before calling
> arch_dma_set_uncached.

Indeed the memset() itself will be faster, but a fair amount of that 
"saving" will just be punting work to arch_dma_prep_coherent() - 
ultimately the same number of bytes of zeros has to be pushed out into 
the memory system either way. It should certainly be somewhat more 
efficient in that any previously-dirty cache lines won't get written out 
twice, and background cache eviction allows a bit more overlap of 
operations, but I'm wondering how significant a difference it really is 
in practice.

Really, though, I'm thinking ahead to the remap-in-place idea using 
set_memory_*() or similar, and where that might fit into all this, as it 
seems to be about equal parts remap, set_uncached, and neither.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
