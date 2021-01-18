Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE0C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 13:16:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A0A22BEA
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 13:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A0A22BEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4BD4D85F5D;
	Mon, 18 Jan 2021 13:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zWz8YKgAHHoL; Mon, 18 Jan 2021 13:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 620EA845E7;
	Mon, 18 Jan 2021 13:16:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD33C08A1;
	Mon, 18 Jan 2021 13:16:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DACB8C013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 13:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CD43782027
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 13:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aa3sCTU9PAms for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 13:16:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 078B080ED5
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 13:16:24 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DKC1r5CHCzMLqq;
 Mon, 18 Jan 2021 21:14:56 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 18 Jan 2021 21:16:09 +0800
Subject: Re: [PATCH v2 2/2] vfio/iommu_type1: Sanity check pfn_list when
 remove vfio_dma
To: Alex Williamson <alex.williamson@redhat.com>
References: <20210115092643.728-1-zhukeqian1@huawei.com>
 <20210115092643.728-3-zhukeqian1@huawei.com>
 <20210115121447.54c96857@omen.home.shazbot.org>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <32f8b347-587a-1a9a-bee8-569f09a03a15@huawei.com>
Date: Mon, 18 Jan 2021 21:16:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210115121447.54c96857@omen.home.shazbot.org>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark
 Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc
 Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 wanghaibin.wang@huawei.com, Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin
 Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021/1/16 3:14, Alex Williamson wrote:
> On Fri, 15 Jan 2021 17:26:43 +0800
> Keqian Zhu <zhukeqian1@huawei.com> wrote:
> 
>> vfio_sanity_check_pfn_list() is used to check whether pfn_list of
>> vfio_dma is empty when remove the external domain, so it makes a
>> wrong assumption that only external domain will add pfn to dma pfn_list.
>>
>> Now we apply this check when remove a specific vfio_dma and extract
>> the notifier check just for external domain.
> 
> The page pinning interface is gated by having a notifier registered for
> unmaps, therefore non-external domains would also need to register a
> notifier.  There's currently no other way to add entries to the
> pfn_list.  So if we allow pinning for such domains, then it's wrong to
> WARN_ON() when the notifier list is not-empty when removing an external
> domain.  Long term we should probably extend page {un}pinning for the
> caller to pass their notifier to be validated against the notifier list
> rather than just allowing page pinning if *any* notifier is registered.
> Thanks,
I was misled by the code comments. So when the commit a54eb55045ae is added, the only
user of pin interface is mdev vendor driver, but now we also allow iommu backed group
to use this interface to constraint dirty scope. Is vfio_iommu_unmap_unpin_all() a
proper place to put this WARN()?

Thanks,
Keqian

> 
> Alex
>  
>> Fixes: a54eb55045ae ("vfio iommu type1: Add support for mediated devices")
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 24 +++++-------------------
>>  1 file changed, 5 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 4e82b9a3440f..a9bc15e84a4e 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -958,6 +958,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>>  
>>  static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>  {
>> +	WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list);
>>  	vfio_unmap_unpin(iommu, dma, true);
>>  	vfio_unlink_dma(iommu, dma);
>>  	put_task_struct(dma->task);
>> @@ -2251,23 +2252,6 @@ static void vfio_iommu_unmap_unpin_reaccount(struct vfio_iommu *iommu)
>>  	}
>>  }
>>  
>> -static void vfio_sanity_check_pfn_list(struct vfio_iommu *iommu)
>> -{
>> -	struct rb_node *n;
>> -
>> -	n = rb_first(&iommu->dma_list);
>> -	for (; n; n = rb_next(n)) {
>> -		struct vfio_dma *dma;
>> -
>> -		dma = rb_entry(n, struct vfio_dma, node);
>> -
>> -		if (WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list)))
>> -			break;
>> -	}
>> -	/* mdev vendor driver must unregister notifier */
>> -	WARN_ON(iommu->notifier.head);
>> -}
>> -
>>  /*
>>   * Called when a domain is removed in detach. It is possible that
>>   * the removed domain decided the iova aperture window. Modify the
>> @@ -2367,7 +2351,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>  			kfree(group);
>>  
>>  			if (list_empty(&iommu->external_domain->group_list)) {
>> -				vfio_sanity_check_pfn_list(iommu);
>> +				/* mdev vendor driver must unregister notifier */
>> +				WARN_ON(iommu->notifier.head);
>>  
>>  				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
>>  					vfio_iommu_unmap_unpin_all(iommu);
>> @@ -2491,7 +2476,8 @@ static void vfio_iommu_type1_release(void *iommu_data)
>>  
>>  	if (iommu->external_domain) {
>>  		vfio_release_domain(iommu->external_domain, true);
>> -		vfio_sanity_check_pfn_list(iommu);
>> +		/* mdev vendor driver must unregister notifier */
>> +		WARN_ON(iommu->notifier.head);
>>  		kfree(iommu->external_domain);
>>  	}
>>  
> 
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
