Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22134C433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 13:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB41D4051F;
	Tue, 17 May 2022 13:50:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X4M5tN16D2n5; Tue, 17 May 2022 13:50:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7418040C72;
	Tue, 17 May 2022 13:50:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D34CC0032;
	Tue, 17 May 2022 13:50:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C855C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44189408CD
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:50:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T2oalnd1SvMQ for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:50:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A20B408FA
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:50:28 +0000 (UTC)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L2cqw2BnSz67xWY;
 Tue, 17 May 2022 21:47:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 15:50:25 +0200
Received: from [10.47.88.19] (10.47.88.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 14:50:24 +0100
Message-ID: <1043830a-02af-bf8a-6089-0eb7a84a8e85@huawei.com>
Date: Tue, 17 May 2022 14:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <hch@lst.de>, <m.szyprowski@samsung.com>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
 <9160031b-50be-6993-5a8e-f238391962c5@huawei.com>
 <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
In-Reply-To: <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
X-Originating-IP: [10.47.88.19]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: liyihang6@hisilicon.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 17/05/2022 13:02, Robin Murphy wrote:
>>>
>>> Indeed, sorry but NAK for this being nonsense. As I've said at least 
>>> once before, if the unnecessary SAC address allocation attempt slows 
>>> down your workload, make it not do that in the first place. If you 
>>> don't like the existing command-line parameter then fine, > there are 
>>> plenty of
>>> other options, it just needs to be done in a way that doesn't break 
>>> x86 systems with dodgy firmware, as my first attempt turned out to.
>>
>> Sorry, but I am not interested in this. It was discussed in Jan last 
>> year without any viable solution.
> 
> Er, OK, if you're not interested in solving that problem I don't see why 
> you'd bring it up, but hey ho. *I* still think it's important, so I 
> guess I'll revive my old patch with a CONFIG_X86 bodge and have another 
> go at some point.

Let me rephrase, I would be happy to help fix that problem if we really 
can get it fixed, however for my problem it's better to try to get the 
SCSI driver to stop requesting uncached IOVAs foremost.

> 
>> Anyway we still have the long-term IOVA aging issue, and requesting 
>> non-cached IOVAs is involved in that. So I would rather keep the SCSI 
>> driver to requesting cached IOVAs all the time.
>>
>> I did try to do it the other way around - configuring the IOVA caching 
>> range according to the drivers requirement but that got nowhere.

Note that this is still not a final solution as it's not always viable 
to ask a user to unbind + bind the driver.

> 
> FWIW I thought that all looked OK, it just kept getting drowned out by 
> more critical things in my inbox so I hoped someone else might comment. 
> If it turns out that I've become the de-facto IOVA maintainer in 
> everyone else's minds now and they're all waiting for my word then fair 
> enough, I just need to know and reset my expectations accordingly. Joerg?

It would be great to see an improvement here...

> 
>>> Furthermore, if a particular SCSI driver doesn't benefit from 
>>> mappings larger than 256KB, then that driver is also free to limit 
>>> its own mapping size. There are other folks out there with use-cases 
>>> for mapping *gigabytes* at once; you don't get to cripple the API and 
>>> say that that's suddenly not allowed just because it happens to make 
>>> your thing go faster, that's absurd.
>>
>> I'd say less catastrophically slow, not faster.
>>
>> So how to inform the SCSI driver of this caching limit then so that it 
>> may limit the SGL length?
> 
> Driver-specific mechanism; block-layer-specific mechanism; redefine this 
> whole API to something like dma_opt_mapping_size(), as a limit above 
> which mappings might become less efficient or start to fail (callback to 
> my thoughts on [1] as well, I suppose); many options.

ok, fine.

> Just not imposing 
> a ridiculously low *maximum* on everyone wherein mapping calls "should 
> not be larger than the returned value" when that's clearly bollocks.

I agree that this change is in violation as the documentation clearly 
implies a hard limit.

However, FWIW, from looking at users of dma_max_mapping_size(), they 
seem to use in a similar way to SCSI/block layer core, i.e. use this 
value to limit the max SGL total len per IO command. And not as a method 
to learn max DMA consistent mappings size for ring buffers, etc.

Anyway I'll look at dma_opt_mapping_size() but I am not sure how keen 
Christoph will be on this... it is strange to introduce that API due to 
peculiarity of the IOVA allocator.

> 
> 
> [1] 
> https://lore.kernel.org/linux-iommu/20220510142109.777738-1-ltykernel@gmail.com/

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
