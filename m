Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BC3C433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 16:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A6A960BCF;
	Fri, 25 Mar 2022 16:23:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f3qbAW92UuP7; Fri, 25 Mar 2022 16:23:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4DF760AE5;
	Fri, 25 Mar 2022 16:23:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBA96C002C;
	Fri, 25 Mar 2022 16:23:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C69FC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 16:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 173EB408EB
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 16:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3a1oF9aldMLK for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 16:23:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 91482408E4
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 16:23:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E0F1D6E;
 Fri, 25 Mar 2022 09:23:40 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E48393F73D;
 Fri, 25 Mar 2022 09:23:37 -0700 (PDT)
Message-ID: <11d4c863-5bee-aa98-526c-ac7170296485@arm.com>
Date: Fri, 25 Mar 2022 16:23:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Content-Language: en-GB
To: Halil Pasic <pasic@linux.ibm.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324190216.0efa067f.pasic@linux.ibm.com>
 <20220325162508.3273e0db.pasic@linux.ibm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220325162508.3273e0db.pasic@linux.ibm.com>
Cc: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
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

On 2022-03-25 15:25, Halil Pasic wrote:
> On Thu, 24 Mar 2022 19:02:16 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>>> I'll admit I still never quite grasped the reason for also adding the
>>> override to swiotlb_sync_single_for_device() in aa6f8dcbab47, but I
>>> think by that point we were increasingly tired and confused and starting
>>> to second-guess ourselves (well, I was, at least).
>>
>> I raised the question, do we need to do the same for
>> swiotlb_sync_single_for_device(). Did that based on my understanding of the
>> DMA API documentation. I had the following scenario in mind
>>
>> SWIOTLB without the snyc_single:
>>                                    Memory      Bounce buffer      Owner
>> --------------------------------------------------------------------------
>> start                             12345678    xxxxxxxx             C
>> dma_map(DMA_FROM_DEVICE)          12345678 -> 12345678             C->D
>> device writes partial data        12345678    12ABC678 <- ABC      D
>> sync_for_cpu(DMA_FROM_DEVICE)     12ABC678 <- 12ABC678             D->C
>> cpu modifies buffer               66666666    12ABC678             C
>> sync_for_device(DMA_FROM_DEVICE)  66666666    12ABC678             C->D
>> device writes partial data        66666666    1EFGC678 <-EFG       D
>> dma_unmap(DMA_FROM_DEVICE)        1EFGC678 <- 1EFGC678             D->C
>>
>> Legend: in Owner column C stands for cpu and D for device.
>>
>> Without swiotlb, I believe we should have arrived at 6EFG6666. To get the
>> same result, IMHO, we need to do a sync in sync_for_device().
>> And aa6f8dcbab47 is an imperfect solution to that (because of size).
>>
> 
> @Robin, Christoph: Do we consider this a valid scenario?

Aha, I see it now (turns out diagrams really do help!) - so essentially 
the original situation but with buffer recycling thrown into the mix as 
well... I think it's technically valid, but do we know if anything's 
actually doing that in a way which ends up affected? For sure it would 
be nice to know that we had all bases covered without having to audit 
whether we need to, but if it's fundamentally incompatible with what 
other code expects, that we know *is* being widely used, and however 
questionable it may be we don't have an easy fix for, then we're in a 
bit of a tough spot :(

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
