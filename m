Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A27C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 09:25:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD44223E8
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 09:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD44223E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B302B20349;
	Mon, 18 Jan 2021 09:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJSYfamPlMxp; Mon, 18 Jan 2021 09:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 76B352002B;
	Mon, 18 Jan 2021 09:25:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EEB2C08A1;
	Mon, 18 Jan 2021 09:25:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACDB9C013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 09:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9B1238574A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 09:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r9s5K1d3BYi2 for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 09:25:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B555085722
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 09:25:36 +0000 (UTC)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DK5pw2p2mz67bl2;
 Mon, 18 Jan 2021 17:20:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 18 Jan 2021 10:25:31 +0100
Received: from [10.47.11.164] (10.47.11.164) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 18 Jan
 2021 09:25:30 +0000
Subject: Re: [PATCH v4 2/3] iommu/iova: Avoid double-negatives in magazine
 helpers
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-3-git-send-email-john.garry@huawei.com>
 <YAHRKCkcHAEUdRNT@larix.localdomain>
From: John Garry <john.garry@huawei.com>
Message-ID: <69c30e85-4a72-a0e1-1e56-4ffbd0df5aba@huawei.com>
Date: Mon, 18 Jan 2021 09:24:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YAHRKCkcHAEUdRNT@larix.localdomain>
Content-Language: en-US
X-Originating-IP: [10.47.11.164]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: will@kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On 15/01/2021 17:30, Jean-Philippe Brucker wrote:
> On Thu, Dec 10, 2020 at 02:23:08AM +0800, John Garry wrote:
>> A similar crash to the following could be observed if initial CPU rcache
>> magazine allocations fail in init_iova_rcaches():
> 

thanks for having a look

> Any idea why that's happening?  This fix seems ok but if we're expecting
> allocation failures for the loaded magazine then we could easily get it
> for cpu_rcaches too, and get a similar abort at runtime.

It's not specifically that we expect them (allocation failures for the 
loaded magazine), rather we should make safe against it.

So could you be more specific in your concern for the cpu_rcache 
failure? cpu_rcache magazine assignment comes from this logic.

Anyway, logic like "if not full" or "if not empty" is poor as the 
outcome for NULL is ambiguous (maybe there's a better word) and the code 
is not safe against it, and so I replace with "if space" or "if have an 
IOVA", respectively.

Thanks,
John

> 
> Thanks,
> Jean
> 
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> Mem abort info:
>>
>>    free_iova_fast+0xfc/0x280
>>    iommu_dma_free_iova+0x64/0x70
>>    __iommu_dma_unmap+0x9c/0xf8
>>    iommu_dma_unmap_sg+0xa8/0xc8
>>    dma_unmap_sg_attrs+0x28/0x50
>>    cq_thread_v3_hw+0x2dc/0x528
>>    irq_thread_fn+0x2c/0xa0
>>    irq_thread+0x130/0x1e0
>>    kthread+0x154/0x158
>>    ret_from_fork+0x10/0x34
>>
>> The issue is that expression !iova_magazine_full(NULL) evaluates true; this
>> falls over in __iova_rcache_insert() when we attempt to cache a mag and
>> cpu_rcache->loaded == NULL:
>>
>> if (!iova_magazine_full(cpu_rcache->loaded)) {
>> 	can_insert = true;
>> ...
>>
>> if (can_insert)
>> 	iova_magazine_push(cpu_rcache->loaded, iova_pfn);
>>
>> As above, can_insert is evaluated true, which it shouldn't be, and we try
>> to insert pfns in a NULL mag, which is not safe.
>>
>> To avoid this, stop using double-negatives, like !iova_magazine_full() and
>> !iova_magazine_empty(), and use positive tests, like
>> iova_magazine_has_space() and iova_magazine_has_pfns(), respectively; these
>> can safely deal with cpu_rcache->{loaded, prev} = NULL.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
>> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
>> ---
>>   drivers/iommu/iova.c | 29 +++++++++++++++++------------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index cf1aacda2fe4..732ee687e0e2 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -767,14 +767,18 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>>   	mag->size = 0;
>>   }
>>   
>> -static bool iova_magazine_full(struct iova_magazine *mag)
>> +static bool iova_magazine_has_space(struct iova_magazine *mag)
>>   {
>> -	return (mag && mag->size == IOVA_MAG_SIZE);
>> +	if (!mag)
>> +		return false;
>> +	return mag->size < IOVA_MAG_SIZE;
>>   }
>>   
>> -static bool iova_magazine_empty(struct iova_magazine *mag)
>> +static bool iova_magazine_has_pfns(struct iova_magazine *mag)
>>   {
>> -	return (!mag || mag->size == 0);
>> +	if (!mag)
>> +		return false;
>> +	return mag->size;
>>   }
>>   
>>   static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>> @@ -783,7 +787,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>>   	int i;
>>   	unsigned long pfn;
>>   
>> -	BUG_ON(iova_magazine_empty(mag));
>> +	BUG_ON(!iova_magazine_has_pfns(mag));
>>   
>>   	/* Only fall back to the rbtree if we have no suitable pfns at all */
>>   	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
>> @@ -799,7 +803,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>>   
>>   static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>>   {
>> -	BUG_ON(iova_magazine_full(mag));
>> +	BUG_ON(!iova_magazine_has_space(mag));
>>   
>>   	mag->pfns[mag->size++] = pfn;
>>   }
>> @@ -845,9 +849,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>>   	spin_lock_irqsave(&cpu_rcache->lock, flags);
>>   
>> -	if (!iova_magazine_full(cpu_rcache->loaded)) {
>> +	if (iova_magazine_has_space(cpu_rcache->loaded)) {
>>   		can_insert = true;
>> -	} else if (!iova_magazine_full(cpu_rcache->prev)) {
>> +	} else if (iova_magazine_has_space(cpu_rcache->prev)) {
>>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>>   		can_insert = true;
>>   	} else {
>> @@ -856,8 +860,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   		if (new_mag) {
>>   			spin_lock(&rcache->lock);
>>   			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>> -				rcache->depot[rcache->depot_size++] =
>> -						cpu_rcache->loaded;
>> +				if (cpu_rcache->loaded)
>> +					rcache->depot[rcache->depot_size++] =
>> +							cpu_rcache->loaded;
>>   			} else {
>>   				mag_to_free = cpu_rcache->loaded;
>>   			}
>> @@ -908,9 +913,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
>>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>>   	spin_lock_irqsave(&cpu_rcache->lock, flags);
>>   
>> -	if (!iova_magazine_empty(cpu_rcache->loaded)) {
>> +	if (iova_magazine_has_pfns(cpu_rcache->loaded)) {
>>   		has_pfn = true;
>> -	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
>> +	} else if (iova_magazine_has_pfns(cpu_rcache->prev)) {
>>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>>   		has_pfn = true;
>>   	} else {
>> -- 
>> 2.26.2
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
