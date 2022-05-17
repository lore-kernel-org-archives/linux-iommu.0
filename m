Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E8AC433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 12:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4767940185;
	Tue, 17 May 2022 12:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WBknt8i6Ga2c; Tue, 17 May 2022 12:02:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0305C401DD;
	Tue, 17 May 2022 12:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C93D3C007A;
	Tue, 17 May 2022 12:02:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5172FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 12:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DB94402A7
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 12:02:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PvLoIiZJD_Vv for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 12:02:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98F9340250
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 12:02:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E40B1042;
 Tue, 17 May 2022 05:02:06 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E27C03F66F;
 Tue, 17 May 2022 05:02:04 -0700 (PDT)
Message-ID: <8f193bdd-3a0a-f9ed-0726-e6081f374320@arm.com>
Date: Tue, 17 May 2022 13:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 hch@lst.de, m.szyprowski@samsung.com
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
 <9160031b-50be-6993-5a8e-f238391962c5@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9160031b-50be-6993-5a8e-f238391962c5@huawei.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-05-17 12:26, John Garry wrote:
> On 17/05/2022 11:40, Robin Murphy wrote:
>> On 2022-05-16 14:06, John Garry wrote:
>>> For streaming DMA mappings involving an IOMMU and whose IOVA len 
>>> regularly
>>> exceeds the IOVA rcache upper limit (meaning that they are not cached),
>>> performance can be reduced.
>>>
>>> Add the IOMMU callback for DMA mapping API dma_max_mapping_size(), which
>>> allows the drivers to know the mapping limit and thus limit the 
>>> requested
>>> IOVA lengths.
>>>
>>> This resolves the performance issue originally reported in [0] for a 
>>> SCSI
>>> HBA driver which was regularly mapping SGLs which required IOVAs in
>>> excess of the IOVA caching limit. In this case the block layer limits 
>>> the
>>> max sectors per request - as configured in __scsi_init_queue() - which
>>> will limit the total SGL length the driver tries to map and in turn 
>>> limits
>>> IOVA lengths requested.
>>>
>>> [0] 
>>> https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/ 
>>>
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>> Sending as an RFC as iommu_dma_max_mapping_size() is a soft limit, 
>>> and not
>>> a hard limit which I expect is the semantics of 
>>> dma_map_ops.max_mapping_size
>>
>> Indeed, sorry but NAK for this being nonsense. As I've said at least 
>> once before, if the unnecessary SAC address allocation attempt slows 
>> down your workload, make it not do that in the first place. If you 
>> don't like the existing command-line parameter then fine, > there are 
>> plenty of
>> other options, it just needs to be done in a way that doesn't break 
>> x86 systems with dodgy firmware, as my first attempt turned out to.
> 
> Sorry, but I am not interested in this. It was discussed in Jan last 
> year without any viable solution.

Er, OK, if you're not interested in solving that problem I don't see why 
you'd bring it up, but hey ho. *I* still think it's important, so I 
guess I'll revive my old patch with a CONFIG_X86 bodge and have another 
go at some point.

> Anyway we still have the long-term IOVA aging issue, and requesting 
> non-cached IOVAs is involved in that. So I would rather keep the SCSI 
> driver to requesting cached IOVAs all the time.
> 
> I did try to do it the other way around - configuring the IOVA caching 
> range according to the drivers requirement but that got nowhere.

FWIW I thought that all looked OK, it just kept getting drowned out by 
more critical things in my inbox so I hoped someone else might comment. 
If it turns out that I've become the de-facto IOVA maintainer in 
everyone else's minds now and they're all waiting for my word then fair 
enough, I just need to know and reset my expectations accordingly. Joerg?

>> Furthermore, if a particular SCSI driver doesn't benefit from mappings 
>> larger than 256KB, then that driver is also free to limit its own 
>> mapping size. There are other folks out there with use-cases for 
>> mapping *gigabytes* at once; you don't get to cripple the API and say 
>> that that's suddenly not allowed just because it happens to make your 
>> thing go faster, that's absurd.
> 
> I'd say less catastrophically slow, not faster.
> 
> So how to inform the SCSI driver of this caching limit then so that it 
> may limit the SGL length?

Driver-specific mechanism; block-layer-specific mechanism; redefine this 
whole API to something like dma_opt_mapping_size(), as a limit above 
which mappings might become less efficient or start to fail (callback to 
my thoughts on [1] as well, I suppose); many options. Just not imposing 
a ridiculously low *maximum* on everyone wherein mapping calls "should 
not be larger than the returned value" when that's clearly bollocks.

Cheers,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/20220510142109.777738-1-ltykernel@gmail.com/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
