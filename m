Return-Path: <SRS0=DKTI=FZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC8C433E0
	for <iommu@archiver.kernel.org>; Mon, 21 Dec 2020 13:25:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E32C22B51
	for <iommu@archiver.kernel.org>; Mon, 21 Dec 2020 13:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E32C22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 937F18715A;
	Mon, 21 Dec 2020 13:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 683aSTG-FFKK; Mon, 21 Dec 2020 13:25:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 05EDE86500;
	Mon, 21 Dec 2020 13:25:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4197C1825;
	Mon, 21 Dec 2020 13:25:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D42F3C0893
 for <iommu@lists.linux-foundation.org>; Mon, 21 Dec 2020 13:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C87E386FC1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Dec 2020 13:25:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41xf6wA02dy1 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 13:25:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5A09386D9A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Dec 2020 13:25:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F897101E;
 Mon, 21 Dec 2020 05:25:27 -0800 (PST)
Received: from [10.57.34.90] (unknown [10.57.34.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97F83F6CF;
 Mon, 21 Dec 2020 05:25:26 -0800 (PST)
Subject: Re: [PATCH] dma-mapping: benchmark: check the validity of dma mask
 bits
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
References: <20201212101844.23612-1-song.bao.hua@hisilicon.com>
 <69d8ff1a-8993-758f-1aec-e133024cf0b7@arm.com>
 <a3b5a9bd3c444382a0a5e845d59ab031@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3c308f7f-613d-27c5-948e-1f4b83261faa@arm.com>
Date: Mon, 21 Dec 2020 13:25:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <a3b5a9bd3c444382a0a5e845d59ab031@hisilicon.com>
Content-Language: en-GB
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Linuxarm <linuxarm@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>
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

On 2020-12-19 03:15, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>> Sent: Saturday, December 19, 2020 7:10 AM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
>> m.szyprowski@samsung.com
>> Cc: iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>; Dan
>> Carpenter <dan.carpenter@oracle.com>
>> Subject: Re: [PATCH] dma-mapping: benchmark: check the validity of dma mask
>> bits
>>
>> On 2020-12-12 10:18, Barry Song wrote:
>>> While dma_mask_bits is larger than 64, the bahvaiour is undefined. On the
>>> other hand, dma_mask_bits which is smaller than 20 (1MB) makes no sense
>>> in real hardware.
>>>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>>> ---
>>>    kernel/dma/map_benchmark.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>>> index b1496e744c68..19f661692073 100644
>>> --- a/kernel/dma/map_benchmark.c
>>> +++ b/kernel/dma/map_benchmark.c
>>> @@ -214,6 +214,12 @@ static long map_benchmark_ioctl(struct file *file,
>> unsigned int cmd,
>>>    			return -EINVAL;
>>>    		}
>>>
>>> +		if (map->bparam.dma_bits < 20 ||
>>
>> FWIW I don't think we need to bother with a lower limit here - it's
>> unsigned, and a pointlessly small value will fail gracefully when we
>> come to actually set the mask anyway. We only need to protect kernel
>> code from going wrong, not userspace from being stupid to its own detriment.
> 
> I am not sure if kernel driver can reject small dma mask bit if drivers
> don't handle it properly.
> As a month ago, when I was debugging dma map benchmark, I set a value
> less than 32 to devices behind arm-smmu-v3, it could always succeed.
> But dma_map_single() was always failing.
> At that time, I didn't debug this issue. Not sure the latest status of
> iommu driver.

FWIW, dma-direct should reject a mask if it doesn't cover at least the 
whole of ZONE_DMA; iommu-dma does allow anything, but that's because in 
principle it can make any mask down to PAGE_SIZE (or possibly even lower 
depending on the IOMMU) work. It's just that in that case the driver is 
liable to fill up the usable address space really really quickly :)

(I suppose technically it should be checking that masks at least cover 
more than the reserved PFN at IOVA 0, but meh...)

Either way, it still has little bearing on the benchmark itself. Say the 
user successfully sets an "acceptable" 21-bit DMA mask, but with 64K 
pages and >32 threads - the dma_map operations are still likely to start 
failing, and that failure is handled anyway, so why bother having an 
arbitrary and meaningless limit that only serves to make some unworkable 
cases fail slightly differently to others?

Anyway, this doesn't really matter - I see the patch is in -next already 
- it's just one of those things I can't help calling out on principle :)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
