Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D6CC433FE
	for <iommu@archiver.kernel.org>; Wed,  2 Mar 2022 11:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B7FA440386;
	Wed,  2 Mar 2022 11:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2bRGl67yiFn; Wed,  2 Mar 2022 11:26:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E0BA400F3;
	Wed,  2 Mar 2022 11:26:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BD5BC0082;
	Wed,  2 Mar 2022 11:26:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1C1FC000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 11:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6D89415A7
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 11:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U3swgfyFlkV5 for <iommu@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 11:26:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83F74415A5
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 11:26:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 925091424;
 Wed,  2 Mar 2022 03:26:30 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC3ED3F70D;
 Wed,  2 Mar 2022 03:26:28 -0800 (PST)
Message-ID: <ca208635-449b-2c94-7317-09ed8eb86a2c@arm.com>
Date: Wed, 2 Mar 2022 11:26:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] iommu/iova: Reset max32_alloc_size after cleaning
Content-Language: en-GB
To: Miles Chen <miles.chen@mediatek.com>
References: <b10031aa-8e49-70b3-b498-8aa6b7021fbb@arm.com>
 <20220301232953.17331-1-miles.chen@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220301232953.17331-1-miles.chen@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Libo.Kang@mediatek.com, yf.wang@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, matthias.bgg@gmail.com, will@kernel.org,
 Ning.Li@mediatek.com
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

On 2022-03-01 23:29, Miles Chen via iommu wrote:
> Hi Yunfei,
> 
>>> Since __alloc_and_insert_iova_range fail will set the current alloc
>>> iova size to max32_alloc_size (iovad->max32_alloc_size = size),
>>> when the retry is executed into the __alloc_and_insert_iova_range
>>> function, the retry action will be blocked by the check condition
>>> (size >= iovad->max32_alloc_size) and goto iova32_full directly,
>>> causes the action of retry regular alloc iova in
>>> __alloc_and_insert_iova_range to not actually be executed.
>>>
>>> Based on the above, so need reset max32_alloc_size before retry alloc
>>> iova when alloc iova fail, that is set the initial dma_32bit_pfn value
>>> of iovad to max32_alloc_size, so that the action of retry alloc iova
>>> in __alloc_and_insert_iova_range can be executed.
>>
>> Have you observed this making any difference in practice?
>>
>> Given that both free_cpu_cached_iovas() and free_global_cached_iovas()
>> call iova_magazine_free_pfns(), which calls remove_iova(), which calls
>> __cached_rbnode_delete_update(), I'm thinking no...
>>
>> Robin.
>>
> 
> Like Robin pointed out, if some cached iovas are freed by
> free_global_cached_iovas()/free_cpu_cached_iovas(),
> the max32_alloc_size should be reset to iovad->dma_32bit_pfn.
> 
> If no cached iova is freed, resetting max32_alloc_size before
> the retry allocation only give us a retry. Is it possible that
> other users free their iovas during the additional retry?

No, it's not possible, since everyone's serialised by iova_rbtree_lock. 
If the caches were already empty and the retry gets the lock first, it 
will still fail again - forcing a reset of max32_alloc_size only means 
it has to take the slow path to that failure. If another caller *did* 
manage to get in and free something between free_global_cached_iovas() 
dropping the lock and alloc_iova() re-taking it, then that would have 
legitimately reset max32_alloc_size anyway.

Thanks,
Robin.

> alloc_iova_fast()
>    retry:
>      alloc_iova() // failed, iovad->max32_alloc_size = size
>      free_cpu_cached_iovas()
>        iova_magazine_free_pfns()
>          remove_iova()
> 	  __cached_rbnode_delete_update()
> 	    iovad->max32_alloc_size = iovad->dma_32bit_pfn // reset
>      free_global_cached_iovas()
>        iova_magazine_free_pfns()
>          remove_iova()
> 	  __cached_rbnode_delete_update()
> 	    iovad->max32_alloc_size = iovad->dma_32bit_pfn // reset
>      goto retry;
> 
> thanks,
> Miles
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
