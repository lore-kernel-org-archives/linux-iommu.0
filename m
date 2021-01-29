Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E9C433E0
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 12:03:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D366C64E8D
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 12:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D366C64E8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 76CBB86AF2;
	Fri, 29 Jan 2021 12:03:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HKWisTGzUlP6; Fri, 29 Jan 2021 12:03:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87DB186AE0;
	Fri, 29 Jan 2021 12:03:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C8B3C0FA8;
	Fri, 29 Jan 2021 12:03:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33A04C08A1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 12:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 202A1233B0
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 12:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-eXJkp2aziV for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 12:03:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id E3EBC232D2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 12:03:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 204EA1424;
 Fri, 29 Jan 2021 04:03:42 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA4EF3F7C3;
 Fri, 29 Jan 2021 04:03:40 -0800 (PST)
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210129092120.1482-1-thunder.leizhen@huawei.com>
 <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
Date: Fri, 29 Jan 2021 12:03:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
Content-Language: en-GB
Cc: Vijayanand Jitta <vjitta@codeaurora.org>
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

On 2021-01-29 09:48, Leizhen (ThunderTown) wrote:
> 
> Currently, we are thinking about the solution to the problem. However, because the end time of v5.11 is approaching, this patch is sent first.

However, that commit was made for a reason - how do we justify that one 
thing being slow is more important than another thing being completely 
broken? It's not practical to just keep doing the patch hokey-cokey 
based on whoever shouts loudest :(

> On 2021/1/29 17:21, Zhen Lei wrote:
>> This reverts commit 4e89dce725213d3d0b0475211b500eda4ef4bf2f.
>>
>> We find that this patch has a great impact on performance. According to
>> our test: the iops decreases from 1655.6K to 893.5K, about half.
>>
>> Hardware: 1 SAS expander with 12 SAS SSD
>> Command:  Only the main parameters are listed.
>>            fio bs=4k rw=read iodepth=128 cpus_allowed=0-127

FWIW, I'm 99% sure that what you really want is [1], but then you get to 
battle against an unknown quantity of dodgy firmware instead.

Robin.

[1] 
https://lore.kernel.org/linux-iommu/d412c292d222eb36469effd338e985f9d9e24cd6.1594207679.git.robin.murphy@arm.com/

>> Fixes: 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search fails")
>> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/iova.c | 23 ++++++-----------------
>>   1 file changed, 6 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index d20b8b333d30d17..f840c7207efbced 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -185,9 +185,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>>   	struct rb_node *curr, *prev;
>>   	struct iova *curr_iova;
>>   	unsigned long flags;
>> -	unsigned long new_pfn, retry_pfn;
>> +	unsigned long new_pfn;
>>   	unsigned long align_mask = ~0UL;
>> -	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
>>   
>>   	if (size_aligned)
>>   		align_mask <<= fls_long(size - 1);
>> @@ -200,25 +199,15 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>>   
>>   	curr = __get_cached_rbnode(iovad, limit_pfn);
>>   	curr_iova = rb_entry(curr, struct iova, node);
>> -	retry_pfn = curr_iova->pfn_hi + 1;
>> -
>> -retry:
>>   	do {
>> -		high_pfn = min(high_pfn, curr_iova->pfn_lo);
>> -		new_pfn = (high_pfn - size) & align_mask;
>> +		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
>> +		new_pfn = (limit_pfn - size) & align_mask;
>>   		prev = curr;
>>   		curr = rb_prev(curr);
>>   		curr_iova = rb_entry(curr, struct iova, node);
>> -	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
>> -
>> -	if (high_pfn < size || new_pfn < low_pfn) {
>> -		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
>> -			high_pfn = limit_pfn;
>> -			low_pfn = retry_pfn;
>> -			curr = &iovad->anchor.node;
>> -			curr_iova = rb_entry(curr, struct iova, node);
>> -			goto retry;
>> -		}
>> +	} while (curr && new_pfn <= curr_iova->pfn_hi);
>> +
>> +	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
>>   		iovad->max32_alloc_size = size;
>>   		goto iova32_full;
>>   	}
>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
