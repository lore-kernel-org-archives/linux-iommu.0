Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6B9C4332F
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 11:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDFA341CF6;
	Fri, 25 Mar 2022 11:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w1KaobcP1irA; Fri, 25 Mar 2022 11:27:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6E1741CF8;
	Fri, 25 Mar 2022 11:27:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 733C6C001D;
	Fri, 25 Mar 2022 11:27:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D9AFC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 11:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CFD341CF8
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 11:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3uibSElQxbym for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 11:27:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1EFE941CF6
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 11:27:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EEFB12FC;
 Fri, 25 Mar 2022 04:27:48 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B7E03F73B;
 Fri, 25 Mar 2022 04:27:45 -0700 (PDT)
Message-ID: <cce202fb-5185-aa3e-9e9b-11626192cb49@arm.com>
Date: Fri, 25 Mar 2022 11:27:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Content-Language: en-GB
To: mbizon@freebox.fr, Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On 2022-03-25 10:25, Maxime Bizon wrote:
> 
> On Thu, 2022-03-24 at 12:26 -0700, Linus Torvalds wrote:
> 
>>
>> It's actually very natural in that situation to flush the caches from
>> the CPU side again. And so dma_sync_single_for_device() is a fairly
>> reasonable thing to do in that situation.
>>
> 
> In the non-cache-coherent scenario, and assuming dma_map() did an
> initial cache invalidation, you can write this:
> 
> rx_buffer_complete_1(buf)
> {
> 	invalidate_cache(buf, size)
> 	if (!is_ready(buf))
> 		return;
> 	<proceed with receive>
> }
> 
> or
> 
> rx_buffer_complete_2(buf)
> {
> 	if (!is_ready(buf)) {
> 		invalidate_cache(buf, size)
> 		return;
> 	}
> 	<proceed with receive>
> }
> 
> The latter is preferred for performance because dma_map() did the
> initial invalidate.
> 
> Of course you could write:
> 
> rx_buffer_complete_3(buf)
> {
> 	invalidate_cache(buf, size)
> 	if
> (!is_ready(buf)) {
> 		invalidate_cache(buf, size)
> 		return;
> 	}
> 	
> <proceed with receive>
> }
> 
> 
> but it's a waste of CPU cycles
> 
> So I'd be very cautious assuming sync_for_cpu() and sync_for_device()
> are both doing invalidation in existing implementation of arch DMA ops,
> implementers may have taken some liberty around DMA-API to avoid
> unnecessary cache operation (not to blame them).

Right, if you have speculatively-prefetching caches, you have to 
invalidate DMA_FROM_DEVICE in unmap/sync_for_cpu, since a cache may have 
pulled in a snapshot of partly-written data at any point beforehand. But 
if you don't, then you can simply invalidate up-front in 
map/sync_for_device to tie in with the other directions, and trust that 
it stays that way for the duration.

What muddies the waters a bit is that the opposite combination 
sync_for_cpu(DMA_TO_DEVICE) really *should* always be a no-op, and I for 
one have already made the case for eliding that in code elsewhere, but 
it doesn't necessarily hold for the inverse here, hence why I'm not sure 
there even is a robust common solution for peeking at a live 
DMA_FROM_DEVICE buffer.

Robin.

> For example looking at arch/arm/mm/dma-mapping.c, for DMA_FROM_DEVICE
> 
> sync_single_for_device()
>    => __dma_page_cpu_to_dev()
>      => dma_cache_maint_page(op=dmac_map_area)
>        => cpu_cache.dma_map_area()
> 
> sync_single_for_cpu()
>    => __dma_page_dev_to_cpu()
>      =>
> __dma_page_cpu_to_dev(op=dmac_unmap_area)
>        =>
> cpu_cache.dma_unmap_area()
> 
> dma_map_area() always does cache invalidate.
> 
> But for a couple of CPU variant, dma_unmap_area() is a noop, so
> sync_for_cpu() does nothing.
> 
> Toke's patch will break ath9k on those platforms (mostly silent
> breakage, rx corruption leading to bad performance)
> 
> 
>> There's a fair number of those dma_sync_single_for_device() things
>> all over. Could we find mis-uses and warn about them some way? It
>> seems to be a very natural thing to do in this context, but bounce
>> buffering does make them very fragile.
> 
> At least in network drivers, there are at least two patterns:
> 
> 1) The issue at hand, hardware mixing rx_status and data inside the
> same area. Usually very old hardware, very quick grep in network
> drivers only revealed slicoss.c. Probably would have gone unnoticed if
> ath9k hardware wasn't so common.
> 
> 
> 2) The very common "copy break" pattern. If a received packet is
> smaller than a certain threshold, the driver rx path is changed to do:
> 
>   sync_for_cpu()
>   alloc_small_skb()
>   memcpy(small_skb, rx_buffer_data)
>   sync_for_device()
> 
> Original skb is left in the hardware, this reduces memory wasted.
> 
> This pattern is completely valid wrt DMA-API, the buffer is always
> either owned by CPU or device.
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
