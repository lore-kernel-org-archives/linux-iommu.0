Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298FDC433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 11:00:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3AB22240
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 11:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3AB22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4CABB8673D;
	Wed, 23 Dec 2020 11:00:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DaX1JLdNacaH; Wed, 23 Dec 2020 11:00:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7810B868BD;
	Wed, 23 Dec 2020 11:00:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B9CFC1787;
	Wed, 23 Dec 2020 11:00:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38AB9C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 11:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 22BBD8725C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 11:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FkiIL6sGH-yw for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 11:00:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7B5C7870A1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 11:00:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C09CE101E;
 Wed, 23 Dec 2020 03:00:40 -0800 (PST)
Received: from [10.57.34.90] (unknown [10.57.34.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3889E3F6CF;
 Wed, 23 Dec 2020 03:00:38 -0800 (PST)
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
To: Tomasz Figa <tfiga@chromium.org>, Yong Wu <yong.wu@mediatek.com>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-7-yong.wu@mediatek.com> <X+MGKBYKdmPNz7VL@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1de76b46-d9c1-4011-c087-1df236f442c3@arm.com>
Date: Wed, 23 Dec 2020 11:00:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X+MGKBYKdmPNz7VL@chromium.org>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On 2020-12-23 08:56, Tomasz Figa wrote:
> On Wed, Dec 16, 2020 at 06:36:06PM +0800, Yong Wu wrote:
>> In current iommu_unmap, this code is:
>>
>> 	iommu_iotlb_gather_init(&iotlb_gather);
>> 	ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
>> 	iommu_iotlb_sync(domain, &iotlb_gather);
>>
>> We could gather the whole iova range in __iommu_unmap, and then do tlb
>> synchronization in the iommu_iotlb_sync.
>>
>> This patch implement this, Gather the range in mtk_iommu_unmap.
>> then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
>> we don't call iommu_iotlb_gather_add_page since our tlb synchronization
>> could be regardless of granule size.
>>
>> In this way, gather->start is impossible ULONG_MAX, remove the checking.
>>
>> This patch aims to do tlb synchronization *once* in the iommu_unmap.
>>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index db7d43adb06b..89cec51405cd 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -506,7 +506,12 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>>   			      struct iommu_iotlb_gather *gather)
>>   {
>>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>> +	unsigned long long end = iova + size;
>>   
>> +	if (gather->start > iova)
>> +		gather->start = iova;
>> +	if (gather->end < end)
>> +		gather->end = end;
> 
> I don't know how common the case is, but what happens if
> gather->start...gather->end is a disjoint range from iova...end? E.g.
> 
>   | gather      | ..XXX... | iova |
>   |             |          |      |
>   gather->start |          iova   |
>                 gather->end       end
> 
> We would also end up invalidating the TLB for the XXX area, which could
> affect the performance.

Take a closer look at iommu_unmap() - the gather data is scoped to each 
individual call, so that can't possibly happen.

> Also, why is the existing code in __arm_v7s_unmap() not enough? It seems
> to call io_pgtable_tlb_add_page() already, so it should be batching the
> flushes.

Because if we leave io-pgtable in charge of maintenance it will also 
inject additional invalidations and syncs for the sake of strictly 
correct walk cache maintenance. Apparently we can get away without that 
on this hardware, so the fundamental purpose of this series is to 
sidestep it.

It's proven to be cleaner overall to devolve this kind of "non-standard" 
TLB maintenance back to drivers rather than try to cram yet more 
special-case complexity into io-pgtable itself. I'm planning to clean up 
the remains of the TLBI_ON_MAP quirk entirely after this.

Robin.

>>   	return dom->iop->unmap(dom->iop, iova, size, gather);
>>   }
>>   
>> @@ -523,9 +528,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>>   	size_t length = gather->end - gather->start;
>>   
>> -	if (gather->start == ULONG_MAX)
>> -		return;
>> -
>>   	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
>>   				       dom->data);
>>   }
>> -- 
>> 2.18.0
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
