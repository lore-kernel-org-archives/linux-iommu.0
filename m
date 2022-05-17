Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2A9C433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 11:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75E5781322;
	Tue, 17 May 2022 11:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yC8pqrHrWdY9; Tue, 17 May 2022 11:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4E6F280DCF;
	Tue, 17 May 2022 11:26:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10D1FC0032;
	Tue, 17 May 2022 11:26:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A8FFC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24D5541A0F
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7Oqi_as3Fxm for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 11:26:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E813D402B3
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 11:26:26 +0000 (UTC)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L2Yj52qykz689TL;
 Tue, 17 May 2022 19:26:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 13:26:23 +0200
Received: from [10.47.88.19] (10.47.88.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 12:26:22 +0100
Message-ID: <9160031b-50be-6993-5a8e-f238391962c5@huawei.com>
Date: Tue, 17 May 2022 12:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <hch@lst.de>, <m.szyprowski@samsung.com>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
 <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
In-Reply-To: <f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com>
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

On 17/05/2022 11:40, Robin Murphy wrote:
> On 2022-05-16 14:06, John Garry wrote:
>> For streaming DMA mappings involving an IOMMU and whose IOVA len 
>> regularly
>> exceeds the IOVA rcache upper limit (meaning that they are not cached),
>> performance can be reduced.
>>
>> Add the IOMMU callback for DMA mapping API dma_max_mapping_size(), which
>> allows the drivers to know the mapping limit and thus limit the requested
>> IOVA lengths.
>>
>> This resolves the performance issue originally reported in [0] for a SCSI
>> HBA driver which was regularly mapping SGLs which required IOVAs in
>> excess of the IOVA caching limit. In this case the block layer limits the
>> max sectors per request - as configured in __scsi_init_queue() - which
>> will limit the total SGL length the driver tries to map and in turn 
>> limits
>> IOVA lengths requested.
>>
>> [0] 
>> https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/ 
>>
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>> Sending as an RFC as iommu_dma_max_mapping_size() is a soft limit, and 
>> not
>> a hard limit which I expect is the semantics of 
>> dma_map_ops.max_mapping_size
> 
> Indeed, sorry but NAK for this being nonsense. As I've said at least 
> once before, if the unnecessary SAC address allocation attempt slows 
> down your workload, make it not do that in the first place. If you don't 
> like the existing command-line parameter then fine, > there are plenty of
> other options, it just needs to be done in a way that doesn't break x86 
> systems with dodgy firmware, as my first attempt turned out to.

Sorry, but I am not interested in this. It was discussed in Jan last 
year without any viable solution.

Anyway we still have the long-term IOVA aging issue, and requesting 
non-cached IOVAs is involved in that. So I would rather keep the SCSI 
driver to requesting cached IOVAs all the time.

I did try to do it the other way around - configuring the IOVA caching 
range according to the drivers requirement but that got nowhere.

> 
> Furthermore, if a particular SCSI driver doesn't benefit from mappings 
> larger than 256KB, then that driver is also free to limit its own 
> mapping size. There are other folks out there with use-cases for mapping 
> *gigabytes* at once; you don't get to cripple the API and say that 
> that's suddenly not allowed just because it happens to make your thing 
> go faster, that's absurd.

I'd say less catastrophically slow, not faster.

So how to inform the SCSI driver of this caching limit then so that it 
may limit the SGL length?

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
