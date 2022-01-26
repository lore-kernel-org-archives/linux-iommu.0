Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAF4C2BA4C
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 17:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE98160F3E;
	Wed, 26 Jan 2022 17:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WOdGUMrZflI6; Wed, 26 Jan 2022 17:58:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D925060F30;
	Wed, 26 Jan 2022 17:58:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B566EC0031;
	Wed, 26 Jan 2022 17:58:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 799A0C002D;
 Wed, 26 Jan 2022 17:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6669E409A0;
 Wed, 26 Jan 2022 17:58:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oxCZ706eqv7Y; Wed, 26 Jan 2022 17:58:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EC9E40338;
 Wed, 26 Jan 2022 17:58:41 +0000 (UTC)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JkWZ23WBCz6FGPH;
 Thu, 27 Jan 2022 01:54:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 18:58:38 +0100
Received: from [10.47.86.172] (10.47.86.172) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 17:58:37 +0000
Subject: Re: [PATCH] iommu/iova: Separate out rcache init
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "will@kernel.org" <will@kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
References: <1643205319-51669-1-git-send-email-john.garry@huawei.com>
 <ee4593b8-cdf6-935a-0eaf-48a8bfeae912@arm.com>
Message-ID: <0ec8829e-aef3-eee7-17cf-416b28db3c4c@huawei.com>
Date: Wed, 26 Jan 2022 17:58:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ee4593b8-cdf6-935a-0eaf-48a8bfeae912@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.86.172]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
> Mangled patch? (no "---" separator here)

hmm... not sure. As an experiment, I just downloaded this patch from 
lore.kernel.org and it applies ok.

> 
> Overall this looks great, just a few comments further down...
> 

...

>> +}
>> +EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
>> +
>> +void iova_domain_free_rcaches(struct iova_domain *iovad)
>> +{
>> +	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
>> +					    &iovad->cpuhp_dead);
>> +	free_iova_rcaches(iovad);
>>    }
>> +EXPORT_SYMBOL_GPL(iova_domain_free_rcaches);
> I think we should continue to expect external callers to clean up with
> put_iova_domain(). 

ok, fine, makes sense

> If they aren't doing that already they have a bug
> (albeit minor), and we don't want to give the impression that it's OK to
> free the caches at any point*other*  than tearing down the whole
> iova_domain, since the implementation really wouldn't expect that.
> 
>>    /*
>>     * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
>> @@ -831,7 +872,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>>    {
>>    	unsigned int log_size = order_base_2(size);
>>    
>> -	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
>> +	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
>>    		return 0;
>>    

..

>> @@ -102,6 +92,8 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>>    	unsigned long pfn_hi);
>>    void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>    	unsigned long start_pfn);
>> +int iova_domain_init_rcaches(struct iova_domain *iovad);
>> +void iova_domain_free_rcaches(struct iova_domain *iovad);
> As above, I vote for just forward-declaring the free routine in iova.c
> and keeping it entirely private.

ok

> 
>>    struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>>    void put_iova_domain(struct iova_domain *iovad);
>>    #else
>> @@ -157,6 +149,15 @@ static inline void init_iova_domain(struct iova_domain *iovad,
>>    {
>>    }
>>    
>> +static inline int iova_domain_init_rcaches(struct iova_domain *iovad)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline void iova_domain_free_rcaches(struct iova_domain *iovad)
>> +{
>> +}
>> +
> I'd be inclined not to add stubs at all - I think it's a reasonable
> assumption that anyone involved enough to care about rcaches has a hard
> dependency on IOMMU_IOVA already.

So iova_domain_free_rcaches() would disappear from here as a result of 
the changes discussed above.

As for iova_domain_init_rcaches(), I was just following the IOMMU/IOVA 
coding practice - that is, always stub.

> It's certainly the case today, and I'd
> hardly want to encourage more users anyway.

I think that stronger deterrents would be needed :)

Anyway, I can remove it.

Thanks,
John




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
