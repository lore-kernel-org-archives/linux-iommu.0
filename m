Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8111C3A5A4
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 12:28:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A812A21874
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 12:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A812A21874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 36C166028;
	Fri, 30 Aug 2019 12:28:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4704F5FE5
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 12:27:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id C58E0EC
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 12:27:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3637D337;
	Fri, 30 Aug 2019 05:27:29 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C18B3F246;
	Fri, 30 Aug 2019 05:27:28 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: avoid false sharing on fq_timer_on
To: Joerg Roedel <jroedel@suse.de>, Eric Dumazet <edumazet@google.com>
References: <20190828131338.89832-1-edumazet@google.com>
	<20190830104925.GI17192@suse.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ffd6989-229b-9c67-d9fb-7a8e413c1336@arm.com>
Date: Fri, 30 Aug 2019 13:27:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190830104925.GI17192@suse.de>
Content-Language: en-GB
Cc: Jinyu Qi <jinyuqi@huawei.com>, iommu@lists.linux-foundation.org,
	Will Deacon <will@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 30/08/2019 11:49, Joerg Roedel wrote:
> Looks good to me, but adding Robin for his opinion.

Sounds reasonable to me too - that should also be true for the majority 
of Arm systems that we know of. Will suggested that atomic_try_cmpxchg() 
might be relevant, but AFAICS that's backwards compared to what we want 
to do here, which I guess is more of an "atomic_unlikely_cmpxchg".

Acked-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> On Wed, Aug 28, 2019 at 06:13:38AM -0700, Eric Dumazet wrote:
>> In commit 14bd9a607f90 ("iommu/iova: Separate atomic variables
>> to improve performance") Jinyu Qi identified that the atomic_cmpxchg()
>> in queue_iova() was causing a performance loss and moved critical fields
>> so that the false sharing would not impact them.
>>
>> However, avoiding the false sharing in the first place seems easy.
>> We should attempt the atomic_cmpxchg() no more than 100 times
>> per second. Adding an atomic_read() will keep the cache
>> line mostly shared.
>>
>> This false sharing came with commit 9a005a800ae8
>> ("iommu/iova: Add flush timer").
>>
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Cc: Jinyu Qi <jinyuqi@huawei.com>
>> Cc: Joerg Roedel <jroedel@suse.de>
>> ---
>>   drivers/iommu/iova.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 3e1a8a6755723a927a7942a7429ab7e6c19a0027..41c605b0058f9615c2dbdd83f1de2404a9b1d255 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -577,7 +577,9 @@ void queue_iova(struct iova_domain *iovad,
>>   
>>   	spin_unlock_irqrestore(&fq->lock, flags);
>>   
>> -	if (atomic_cmpxchg(&iovad->fq_timer_on, 0, 1) == 0)
>> +	/* Avoid false sharing as much as possible. */
>> +	if (!atomic_read(&iovad->fq_timer_on) &&
>> +	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
>>   		mod_timer(&iovad->fq_timer,
>>   			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
>>   }
>> -- 
>> 2.23.0.187.g17f5b7556c-goog
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
