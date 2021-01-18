Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C60C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 13:34:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47707221EB
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 13:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47707221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 217B2859D1;
	Mon, 18 Jan 2021 13:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iakjZh_KOluM; Mon, 18 Jan 2021 13:34:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F2B7185778;
	Mon, 18 Jan 2021 13:34:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE76AC08A1;
	Mon, 18 Jan 2021 13:34:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB52AC013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 13:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A48DF86FF3
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 13:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zNDgwKAqeTFr for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 13:33:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2DF2086FF2
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 13:33:56 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DKCQ215LFzMLJL;
 Mon, 18 Jan 2021 21:32:26 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 18 Jan 2021 21:33:40 +0800
Subject: Re: [PATCH 1/6] vfio/iommu_type1: Make an explicit "promote" semantic
To: Alex Williamson <alex.williamson@redhat.com>
References: <20210107044401.19828-1-zhukeqian1@huawei.com>
 <20210107044401.19828-2-zhukeqian1@huawei.com>
 <20210115154240.0d3ee455@omen.home.shazbot.org>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <0cf47d65-cb91-199e-af7d-048134634298@huawei.com>
Date: Mon, 18 Jan 2021 21:33:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210115154240.0d3ee455@omen.home.shazbot.org>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Alexios Zavras <alexios.zavras@intel.com>, iommu@lists.linux-foundation.org,
 James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com, Thomas
 Gleixner <tglx@linutronix.de>, jiangkunkun@huawei.com, Will
 Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
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



On 2021/1/16 6:42, Alex Williamson wrote:
> On Thu, 7 Jan 2021 12:43:56 +0800
> Keqian Zhu <zhukeqian1@huawei.com> wrote:
> 
>> When we want to promote the pinned_page_dirty_scope of vfio_iommu,
>> we call the "update" function to visit all vfio_group, but when we
>> want to downgrade this, we can set the flag as false directly.
> 
> I agree that the transition can only go in one direction, but it's
> still conditional on the scope of all groups involved.  We are
> "updating" the iommu state based on the change of a group.  Renaming
> this to "promote" seems like a matter of personal preference.
> 
>> So we'd better make an explicit "promote" semantic to the "update"
>> function. BTW, if vfio_iommu already has been promoted, then return
>> early.
> 
> Currently it's the caller that avoids using this function when the
> iommu scope is already correct.  In fact the changes induces a
> redundant test in the pin_pages code path, we're changing a group from
> non-pinned-page-scope to pinned-page-scope, therefore the iommu scope
> cannot initially be scope limited.  In the attach_group call path,
> we're moving that test from the caller, so at best we've introduced an
> additional function call.
> 
> The function as it exists today is also more versatile whereas the
> "promote" version here forces it to a single task with no appreciable
> difference in complexity or code.  This seems like a frivolous change.
> Thanks,
OK, I will adapt your idea that maintenance a counter of non-pinned groups.
Then we keep the "update" semantic, and the target is the counter ;-).

Thanks,
Keqian

> 
> Alex
> 
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 30 ++++++++++++++----------------
>>  1 file changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 0b4dedaa9128..334a8240e1da 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -148,7 +148,7 @@ static int put_pfn(unsigned long pfn, int prot);
>>  static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
>>  					       struct iommu_group *iommu_group);
>>  
>> -static void update_pinned_page_dirty_scope(struct vfio_iommu *iommu);
>> +static void promote_pinned_page_dirty_scope(struct vfio_iommu *iommu);
>>  /*
>>   * This code handles mapping and unmapping of user data buffers
>>   * into DMA'ble space using the IOMMU
>> @@ -714,7 +714,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>>  	group = vfio_iommu_find_iommu_group(iommu, iommu_group);
>>  	if (!group->pinned_page_dirty_scope) {
>>  		group->pinned_page_dirty_scope = true;
>> -		update_pinned_page_dirty_scope(iommu);
>> +		promote_pinned_page_dirty_scope(iommu);
>>  	}
>>  
>>  	goto pin_done;
>> @@ -1622,27 +1622,26 @@ static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
>>  	return group;
>>  }
>>  
>> -static void update_pinned_page_dirty_scope(struct vfio_iommu *iommu)
>> +static void promote_pinned_page_dirty_scope(struct vfio_iommu *iommu)
>>  {
>>  	struct vfio_domain *domain;
>>  	struct vfio_group *group;
>>  
>> +	if (iommu->pinned_page_dirty_scope)
>> +		return;
>> +
>>  	list_for_each_entry(domain, &iommu->domain_list, next) {
>>  		list_for_each_entry(group, &domain->group_list, next) {
>> -			if (!group->pinned_page_dirty_scope) {
>> -				iommu->pinned_page_dirty_scope = false;
>> +			if (!group->pinned_page_dirty_scope)
>>  				return;
>> -			}
>>  		}
>>  	}
>>  
>>  	if (iommu->external_domain) {
>>  		domain = iommu->external_domain;
>>  		list_for_each_entry(group, &domain->group_list, next) {
>> -			if (!group->pinned_page_dirty_scope) {
>> -				iommu->pinned_page_dirty_scope = false;
>> +			if (!group->pinned_page_dirty_scope)
>>  				return;
>> -			}
>>  		}
>>  	}
>>  
>> @@ -2057,8 +2056,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>  			 * addition of a dirty tracking group.
>>  			 */
>>  			group->pinned_page_dirty_scope = true;
>> -			if (!iommu->pinned_page_dirty_scope)
>> -				update_pinned_page_dirty_scope(iommu);
>> +			promote_pinned_page_dirty_scope(iommu);
>>  			mutex_unlock(&iommu->lock);
>>  
>>  			return 0;
>> @@ -2341,7 +2339,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>  	struct vfio_iommu *iommu = iommu_data;
>>  	struct vfio_domain *domain;
>>  	struct vfio_group *group;
>> -	bool update_dirty_scope = false;
>> +	bool promote_dirty_scope = false;
>>  	LIST_HEAD(iova_copy);
>>  
>>  	mutex_lock(&iommu->lock);
>> @@ -2349,7 +2347,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>  	if (iommu->external_domain) {
>>  		group = find_iommu_group(iommu->external_domain, iommu_group);
>>  		if (group) {
>> -			update_dirty_scope = !group->pinned_page_dirty_scope;
>> +			promote_dirty_scope = !group->pinned_page_dirty_scope;
>>  			list_del(&group->next);
>>  			kfree(group);
>>  
>> @@ -2379,7 +2377,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>  			continue;
>>  
>>  		vfio_iommu_detach_group(domain, group);
>> -		update_dirty_scope = !group->pinned_page_dirty_scope;
>> +		promote_dirty_scope = !group->pinned_page_dirty_scope;
>>  		list_del(&group->next);
>>  		kfree(group);
>>  		/*
>> @@ -2415,8 +2413,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>  	 * Removal of a group without dirty tracking may allow the iommu scope
>>  	 * to be promoted.
>>  	 */
>> -	if (update_dirty_scope)
>> -		update_pinned_page_dirty_scope(iommu);
>> +	if (promote_dirty_scope)
>> +		promote_pinned_page_dirty_scope(iommu);
>>  	mutex_unlock(&iommu->lock);
>>  }
>>  
> 
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
