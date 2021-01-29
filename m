Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56120C433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 07:47:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F9964E03
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 07:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F9964E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4FAC9860F6;
	Fri, 29 Jan 2021 07:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EXZzgEmxdKkB; Fri, 29 Jan 2021 07:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 80F8A869C0;
	Fri, 29 Jan 2021 07:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72D7EC08A1;
	Fri, 29 Jan 2021 07:47:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 953CCC013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 07:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 89066869C0
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 07:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zCTnXnYi5fYe for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 07:47:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 16F59860F6
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 07:47:37 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DRqCb61DszjF9v;
 Fri, 29 Jan 2021 15:46:19 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 29 Jan 2021 15:47:27 +0800
Subject: Re: [PATCH v3 2/2] vfio/iommu_type1: Fix some sanity checks in detach
 group
To: Alex Williamson <alex.williamson@redhat.com>
References: <20210122092635.19900-1-zhukeqian1@huawei.com>
 <20210122092635.19900-3-zhukeqian1@huawei.com>
 <20210127164641.36e17bf5@omen.home.shazbot.org>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <605515c3-baf6-83c0-b137-a721ea72c733@huawei.com>
Date: Fri, 29 Jan 2021 15:47:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210127164641.36e17bf5@omen.home.shazbot.org>
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



On 2021/1/28 7:46, Alex Williamson wrote:
> On Fri, 22 Jan 2021 17:26:35 +0800
> Keqian Zhu <zhukeqian1@huawei.com> wrote:
> 
>> vfio_sanity_check_pfn_list() is used to check whether pfn_list and
>> notifier are empty when remove the external domain, so it makes a
>> wrong assumption that only external domain will use the pinning
>> interface.
>>
>> Now we apply the pfn_list check when a vfio_dma is removed and apply
>> the notifier check when all domains are removed.
>>
>> Fixes: a54eb55045ae ("vfio iommu type1: Add support for mediated devices")
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 33 ++++++++++-----------------------
>>  1 file changed, 10 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 161725395f2f..d8c10f508321 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -957,6 +957,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>>  
>>  static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>  {
>> +	WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list));
>>  	vfio_unmap_unpin(iommu, dma, true);
>>  	vfio_unlink_dma(iommu, dma);
>>  	put_task_struct(dma->task);
>> @@ -2250,23 +2251,6 @@ static void vfio_iommu_unmap_unpin_reaccount(struct vfio_iommu *iommu)
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
>> @@ -2366,10 +2350,10 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>  			kfree(group);
>>  
>>  			if (list_empty(&iommu->external_domain->group_list)) {
>> -				vfio_sanity_check_pfn_list(iommu);
>> -
>> -				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
>> +				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
>> +					WARN_ON(iommu->notifier.head);
>>  					vfio_iommu_unmap_unpin_all(iommu);
>> +				}
>>  
>>  				kfree(iommu->external_domain);
>>  				iommu->external_domain = NULL;
>> @@ -2403,10 +2387,12 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>  		 */
>>  		if (list_empty(&domain->group_list)) {
>>  			if (list_is_singular(&iommu->domain_list)) {
>> -				if (!iommu->external_domain)
>> +				if (!iommu->external_domain) {
>> +					WARN_ON(iommu->notifier.head);
>>  					vfio_iommu_unmap_unpin_all(iommu);
>> -				else
>> +				} else {
>>  					vfio_iommu_unmap_unpin_reaccount(iommu);
>> +				}
>>  			}
>>  			iommu_domain_free(domain->domain);
>>  			list_del(&domain->next);
>> @@ -2488,9 +2474,10 @@ static void vfio_iommu_type1_release(void *iommu_data)
>>  	struct vfio_iommu *iommu = iommu_data;
>>  	struct vfio_domain *domain, *domain_tmp;
>>  
>> +	WARN_ON(iommu->notifier.head);
> 
> I don't see that this does any harm, but isn't it actually redundant?
> It seems vfio-core only calls the iommu backend release function after
> removing all the groups, so the tests in _detach_group should catch all
> cases.  We're expecting the vfio bus/mdev driver to remove the notifier
> when a device is closed, which necessarily occurs before detaching the
> group.  Thanks,
Right. Devices of a specific group must be closed before detach this group.
Detach the last group have checked this, so vfio_iommu_type1_release doesn't
need to do this check again.

Could you please queue this patch and delete this check btw? Thanks. ;-)

Keqian.

> 
> Alex
> 
>> +
>>  	if (iommu->external_domain) {
>>  		vfio_release_domain(iommu->external_domain, true);
>> -		vfio_sanity_check_pfn_list(iommu);
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
