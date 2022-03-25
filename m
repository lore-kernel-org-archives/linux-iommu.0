Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14176C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 19:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3F1740022;
	Fri, 25 Mar 2022 19:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d82t4jOwwMFu; Fri, 25 Mar 2022 19:14:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 15C054049E;
	Fri, 25 Mar 2022 19:14:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF543C001D;
	Fri, 25 Mar 2022 19:14:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93B62C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BA8640903
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9IJI2WEv_vc for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 19:14:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 797F7402BE
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 19:14:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A898413D5;
 Fri, 25 Mar 2022 12:14:26 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A5C93F73D;
 Fri, 25 Mar 2022 12:14:23 -0700 (PDT)
Message-ID: <a1829f4a-d916-c486-ac49-2c6dff77521a@arm.com>
Date: Fri, 25 Mar 2022 19:14:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Content-Language: en-GB
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Maxime Bizon <mbizon@freebox.fr>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
Cc: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
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

On 2022-03-25 18:30, Linus Torvalds wrote:
> On Fri, Mar 25, 2022 at 3:25 AM Maxime Bizon <mbizon@freebox.fr> wrote:
>>
>> In the non-cache-coherent scenario, and assuming dma_map() did an
>> initial cache invalidation, you can write this:
> 
> .. but the problem is that the dma mapping code is supposed to just
> work, and the driver isn't supposed to know or care whether dma is
> coherent or not, or using bounce buffers or not.
> 
> And currently it doesn't work.
> 
> Because what that ath9k driver does is "natural", but it's wrong for
> the bounce buffer case.
> 
> And I think the problem is squarely on the dma-mapping side for two reasons:
> 
>   (a) this used to work, now it doesn't, and it's unclear how many
> other drivers are affected
> 
>   (b) the dma-mapping naming and calling conventions are horrible and
> actively misleading
> 
> That (a) is a big deal. The reason the ath9k issue was found quickly
> is very likely *NOT* because ath9k is the only thing affected. No,
> it's because ath9k is relatively common.
> 
> Just grep for dma_sync_single_for_device() and ask yourself: how many
> of those other drivers have you ever even HEARD of, much less be able
> to test?
> 
> And that's just one "dma_sync" function. Admittedly it's likely one of
> the more common ones, but still..
> 
> Now, (b) is why I think driver nufgt get this so wrong - or, in this
> case, possibly the dma-mapping code itself.
> 
> The naming - and even the documentation(!!!) - implies that what ath9k
> does IS THE RIGHT THING TO DO.
> 
> The documentation clearly states:
> 
>    "Before giving the memory to the device, dma_sync_single_for_device() needs
>     to be called, and before reading memory written by the device,
>     dma_sync_single_for_cpu(), just like for streaming DMA mappings that are
>     reused"

Except that's documentation for the non-coherent allocation API, rather 
than the streaming API in question here. I'll refrain from commenting on 
having at least 3 DMA APIs, with the same set of sync functions serving 
two of them, and just stand back a safe distance...




Anyway, the appropriate part of that document is probably:

   "You must do this:

    - Before reading values that have been written by DMA from the device
      (use the DMA_FROM_DEVICE direction)"

I'm not saying it constitutes *good* documentation, but I would note how 
it says "have been written", and not "are currently being written". 
Similarly from the HOWTO:

    "If you need to use the same streaming DMA region multiple times and
     touch the data in between the DMA transfers, the buffer needs to be
     synced properly..."

Note "between the DMA transfers", and not "during the DMA transfers". 
The fundamental assumption of the streaming API is that only one thing 
is ever accessing the mapping at any given time, which is what the whole 
notion of ownership is about.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
