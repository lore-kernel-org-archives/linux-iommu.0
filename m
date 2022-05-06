Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF561C433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 05:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78FEB409E0;
	Fri,  6 May 2022 05:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QzEmEDAPnC8W; Fri,  6 May 2022 05:40:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 494EA40025;
	Fri,  6 May 2022 05:40:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18813C0032;
	Fri,  6 May 2022 05:40:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F5CAC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5907660B9A
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:40:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWx1tkj7UQ2q for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 05:40:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 80CB960BC0
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651815608; x=1683351608;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RIVpEAtkuYO7pp01GcFGdlSw/mydcbT7MxtS5DfXDFI=;
 b=DUVyWhKP4s/TiNAejY3qz08TiYLJCpzC8OJIh0UDnA86kjj14814TuCA
 Eg/oCRs0kR4miOpHyI1H07chINF+J/O3GjWwi/nRAmYWxvClab9YJLi8C
 DedefbzJEeXURdR1hu3nzQx1pdQdcpgB1tksy7V7yN3z73oOEVA+BV+aj
 jBWf7+7Q3PbVMPMu0xquS/moqKtdj2ao2OBAbW4+mCSX/8dRe028meXU9
 qxkXrI7bhfHjloTTlbybHr8myGd+EPfEI7thoNXuXEEAd/4Kn0qjpdzls
 Ek0HhXx7vEd/L4TQ9oc+HK62YHJmt2byOVZPpA63cZJsmqUov4qNeajVI Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248265643"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="248265643"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 22:40:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="735409172"
Received: from sunyanwa-mobl1.ccr.corp.intel.com (HELO [10.255.31.183])
 ([10.255.31.183])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 22:40:04 -0700
Message-ID: <5bbf6ccf-2a49-7611-b8af-143252decc1f@linux.intel.com>
Date: Fri, 6 May 2022 13:40:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 10/12] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-11-baolu.lu@linux.intel.com> <YnFydE8j8l7Q4m+b@myrica>
 <9144a782-04d2-a09d-4ac1-7133e5986619@linux.intel.com>
 <YnPTXwjpHnnGp4j2@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnPTXwjpHnnGp4j2@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On 2022/5/5 21:38, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> On Thu, May 05, 2022 at 04:31:38PM +0800, Baolu Lu wrote:
>> On 2022/5/4 02:20, Jean-Philippe Brucker wrote:
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 7cae631c1baa..33449523afbe 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -3174,3 +3174,24 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>>>>    	iommu_group_put(group);
>>>>    }
>>>> +
>>>> +struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
>>>> +						    ioasid_t pasid)
>>>> +{
>>>> +	struct iommu_domain *domain;
>>>> +	struct iommu_group *group;
>>>> +
>>>> +	if (!pasid_valid(pasid))
>>>> +		return NULL;
>>>> +
>>>> +	group = iommu_group_get(dev);
>>>> +	if (!group)
>>>> +		return NULL;
>>>> +
>>>> +	mutex_lock(&group->mutex);
>>> Unfortunately this still causes the deadlock when unbind() flushes the
>>> IOPF queue while holding the group mutex.
>>
>> Sorry, I didn't get your point here.
>>
>> Do you mean unbind() could hold group mutex before calling this helper?
>> The group mutex is only available in iommu.c. The unbind() has no means
>> to hold this lock. Or, I missed anything?
> 
> I wasn't clear, it's iommu_detach_device_pasid() that holds the
> group->mutex:
> 
>   iommu_sva_unbind_device()          |
>    iommu_detach_device_pasid()       |
>     mutex_lock(&group->mutex)        |
>     domain->ops->detach_dev_pasid()  | iopf_handle_group()
>      iopf_queue_flush_dev()          |  iommu_get_domain_for_dev_pasid()
>       ... wait for IOPF work         |   mutex_lock(&group->mutex)
>                                      |    ... deadlock

Ah! Yes. Thank you for the clarification.

> 
> Thanks,
> Jean
> 
>>
>> Best regards,
>> baolu
>>
>>>
>>> If we make this function private to IOPF, then we can get rid of this
>>> mutex_lock(). It's OK because:
>>>
>>> * xarray protects its internal state with RCU, so we can call
>>>     xa_load() outside the lock.
>>>
>>> * The domain obtained from xa_load is finalized. Its content is valid
>>>     because xarray stores the domain using rcu_assign_pointer(), which has a
>>>     release memory barrier, which pairs with data dependencies in IOPF
>>>     (domain->sva_ioas etc).
>>>
>>>     We'll need to be careful about this when allowing other users to install
>>>     a fault handler. Should be fine as long as the handler and data are
>>>     installed before the domain is added to pasid_array.
>>>
>>> * We know the domain is valid the whole time IOPF is using it, because
>>>     unbind() waits for pending faults.
>>>
>>> We just need a comment explaining the last point, something like:
>>>
>>>          /*
>>> 	* Safe to fetch outside the group mutex because:
>>>           * - xarray protects its internal state with RCU
>>>           * - the domain obtained is either NULL or fully formed
>>> 	* - the IOPF work is the only caller and is flushed before the
>>> 	*   domain is freed.
>>>           */

Agreed. The mutex is needed only when domain could possibly be freed
before unbind(). In that case, we need this mutex and get a reference
from the domain. As we have dropped the domain user reference, this lock
is unnecessary.

>>>
>>> Thanks,
>>> Jean
>>>
>>>> +	domain = xa_load(&group->pasid_array, pasid);
>>>> +	mutex_unlock(&group->mutex);
>>>> +	iommu_group_put(group);
>>>> +
>>>> +	return domain;
>>>> +}
>>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
