Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D0C432C0
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 10:55:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2176C214AF
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 10:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2176C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 98B75854D7;
	Mon,  2 Dec 2019 10:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XmcN_IkjtXFX; Mon,  2 Dec 2019 10:55:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CA56D8536C;
	Mon,  2 Dec 2019 10:55:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5D84C1797;
	Mon,  2 Dec 2019 10:55:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27F20C087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 10:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1680A85413
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 10:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5kjcNug5_EE for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 10:55:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9655B8536C
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 10:55:39 +0000 (UTC)
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 0F38F1F00E00582DE3F6;
 Mon,  2 Dec 2019 10:55:36 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 2 Dec 2019 10:55:35 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 10:55:35 +0000
Subject: Re: [Patch v2 1/3] iommu: match the original algorithm
To: Cong Wang <xiyou.wangcong@gmail.com>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-2-xiyou.wangcong@gmail.com>
 <d0f58734-0c1e-af9d-3437-31cf6c8a86f9@huawei.com>
 <CAM_iQpXAf8obF1-CRCGc3Fb_YmNBozcyoKQC5yuP6r9Akg6HBg@mail.gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <b27d0ba1-4f30-3e25-6898-26305a3d42db@huawei.com>
Date: Mon, 2 Dec 2019 10:55:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAM_iQpXAf8obF1-CRCGc3Fb_YmNBozcyoKQC5yuP6r9Akg6HBg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
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

On 30/11/2019 05:58, Cong Wang wrote:
> On Fri, Nov 29, 2019 at 6:43 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 29/11/2019 00:48, Cong Wang wrote:
>>> The IOVA cache algorithm implemented in IOMMU code does not
>>> exactly match the original algorithm described in the paper.
>>>
>>
>> which paper?
> 
> It's in drivers/iommu/iova.c, from line 769:
> 
>   769 /*
>   770  * Magazine caches for IOVA ranges.  For an introduction to magazines,
>   771  * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
>   772  * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
>   773  * For simplicity, we use a static magazine size and don't implement the
>   774  * dynamic size tuning described in the paper.
>   775  */
> 
> 
>>
>>> Particularly, it doesn't need to free the loaded empty magazine
>>> when trying to put it back to global depot. To make it work, we
>>> have to pre-allocate magazines in the depot and only recycle them
>>> when all of them are full.
>>>
>>> Before this patch, rcache->depot[] contains either full or
>>> freed entries, after this patch, it contains either full or
>>> empty (but allocated) entries.
>>
>> I *quickly* tested this patch and got a small performance gain.
> 
> Thanks for testing! It requires a different workload to see bigger gain,
> in our case, 24 memcache.parallel servers with 120 clients.
> 

So in fact I was getting a ~10% throughput boost for my storage test. 
Seems more than I would expect/hope for. I would need to test more.

> 
>>
>>>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>>> ---
>>>    drivers/iommu/iova.c | 45 +++++++++++++++++++++++++++-----------------
>>>    1 file changed, 28 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index 41c605b0058f..cb473ddce4cf 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -862,12 +862,16 @@ static void init_iova_rcaches(struct iova_domain *iovad)
>>>        struct iova_cpu_rcache *cpu_rcache;
>>>        struct iova_rcache *rcache;
>>>        unsigned int cpu;
>>> -     int i;
>>> +     int i, j;
>>>
>>>        for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>>>                rcache = &iovad->rcaches[i];
>>>                spin_lock_init(&rcache->lock);
>>>                rcache->depot_size = 0;
>>> +             for (j = 0; j < MAX_GLOBAL_MAGS; ++j) {
>>> +                     rcache->depot[j] = iova_magazine_alloc(GFP_KERNEL);
>>> +                     WARN_ON(!rcache->depot[j]);
>>> +             }
>>>                rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
>>>                if (WARN_ON(!rcache->cpu_rcaches))
>>>                        continue;
>>> @@ -900,24 +904,30 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>>
>>>        if (!iova_magazine_full(cpu_rcache->loaded)) {
>>>                can_insert = true;
>>> -     } else if (!iova_magazine_full(cpu_rcache->prev)) {
>>> +     } else if (iova_magazine_empty(cpu_rcache->prev)) {
>>
>> is this change strictly necessary?
> 
> Yes, because it is what described in the paper. But it should be
> functionally same because cpu_rcache->prev is either full or empty.

That is was what I was getting at.

> 
> 
> 
>>
>>>                swap(cpu_rcache->prev, cpu_rcache->loaded);
>>>                can_insert = true;
>>>        } else {
>>> -             struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);

Apart from this change, did anyone ever consider kmem cache for the 
magazines?

>>> +             spin_lock(&rcache->lock);
>>> +             if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>>> +                     swap(rcache->depot[rcache->depot_size], cpu_rcache->prev);
>>> +                     swap(cpu_rcache->prev, cpu_rcache->loaded);
>>> +                     rcache->depot_size++;
>>> +                     can_insert = true;
>>> +             } else {
>>> +                     mag_to_free = cpu_rcache->loaded;
>>> +             }
>>> +             spin_unlock(&rcache->lock);
>>> +
>>> +             if (mag_to_free) {
>>> +                     struct iova_magazine *new_mag = iova_magazine_alloc(GFP_ATOMIC);
>>>
>>> -             if (new_mag) {
>>> -                     spin_lock(&rcache->lock);
>>> -                     if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>>> -                             rcache->depot[rcache->depot_size++] =
>>> -                                             cpu_rcache->loaded;
>>> +                     if (new_mag) {
>>> +                             cpu_rcache->loaded = new_mag;
>>> +                             can_insert = true;
>>>                        } else {
>>> -                             mag_to_free = cpu_rcache->loaded;
>>> +                             mag_to_free = NULL;
>>>                        }
>>> -                     spin_unlock(&rcache->lock);
>>> -
>>> -                     cpu_rcache->loaded = new_mag;
>>> -                     can_insert = true;
>>>                }
>>>        }
>>>
>>> @@ -963,14 +973,15 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
>>>
>>>        if (!iova_magazine_empty(cpu_rcache->loaded)) {
>>>                has_pfn = true;
>>> -     } else if (!iova_magazine_empty(cpu_rcache->prev)) {
>>> +     } else if (iova_magazine_full(cpu_rcache->prev)) {
>>>                swap(cpu_rcache->prev, cpu_rcache->loaded);
>>>                has_pfn = true;
>>>        } else {
>>>                spin_lock(&rcache->lock);
>>>                if (rcache->depot_size > 0) {
>>> -                     iova_magazine_free(cpu_rcache->loaded);
>>
>> it is good to remove this from under the lock, apart from this change
>>
>>> -                     cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
>>> +                     swap(rcache->depot[rcache->depot_size - 1], cpu_rcache->prev);
>>> +                     swap(cpu_rcache->prev, cpu_rcache->loaded);

I wonder if not using swap() at all is neater here.

>>> +                     rcache->depot_size--;
>>
>> I'm not sure how appropriate the name "depot_size" is any longer.
> 
> I think it is still okay, because empty ones don't count. However if you
> have better names, I am open to your suggestion.

Yeah, probably.

thanks,
John

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
