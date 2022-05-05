Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5622C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 08:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AD4660B8E;
	Thu,  5 May 2022 08:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iMIQw4T5Pun3; Thu,  5 May 2022 08:31:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F8A460F96;
	Thu,  5 May 2022 08:31:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13C26C0032;
	Thu,  5 May 2022 08:31:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41814C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 08:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 221D740236
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 08:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HQZO6XRh0kC9 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:31:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F194400A4
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651739509; x=1683275509;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=roh0ARsU0A0vGZ1wvEez4gzYA90rB5c2aWwIVA4MWDc=;
 b=ZX4xoxoFxFi7W0qH0LGW3/waUotLisH8j0s6bjK0+xOl87sV0CUbdeXR
 NJya+2A6LAEy/GQTWQ6XSDGZxnbHwHiJv3AaOzaCcQAFwdbznBHBukm6J
 0BabLdbV8Qdhw79o312JBzdHEmOydJsMdIMxhfnwL9tU0WnheA6wkDX8d
 xogmUxYZL/23fcvQipUcnC94NF3+3B+cMTU49Dv1KULCHBLRPuwXwJnUq
 FhM/6b/mqbZErSD2oUfwN69d46HStZH19pLfxFMJ1e9iKy3VRT93YeSlt
 1MDdO65TjQ80Tvu8TYZMXe7nYeVJX7p0Pb+ZOf+v1402IgAbVxlRxCe4N w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268191718"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="268191718"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 01:31:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="563139126"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75])
 ([10.255.30.75])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 01:31:41 -0700
Message-ID: <9144a782-04d2-a09d-4ac1-7133e5986619@linux.intel.com>
Date: Thu, 5 May 2022 16:31:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 10/12] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-11-baolu.lu@linux.intel.com> <YnFydE8j8l7Q4m+b@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnFydE8j8l7Q4m+b@myrica>
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

On 2022/5/4 02:20, Jean-Philippe Brucker wrote:
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 7cae631c1baa..33449523afbe 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3174,3 +3174,24 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>>   
>>   	iommu_group_put(group);
>>   }
>> +
>> +struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
>> +						    ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	if (!pasid_valid(pasid))
>> +		return NULL;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
>> +
>> +	mutex_lock(&group->mutex);
> Unfortunately this still causes the deadlock when unbind() flushes the
> IOPF queue while holding the group mutex.

Sorry, I didn't get your point here.

Do you mean unbind() could hold group mutex before calling this helper?
The group mutex is only available in iommu.c. The unbind() has no means
to hold this lock. Or, I missed anything?

Best regards,
baolu

> 
> If we make this function private to IOPF, then we can get rid of this
> mutex_lock(). It's OK because:
> 
> * xarray protects its internal state with RCU, so we can call
>    xa_load() outside the lock.
> 
> * The domain obtained from xa_load is finalized. Its content is valid
>    because xarray stores the domain using rcu_assign_pointer(), which has a
>    release memory barrier, which pairs with data dependencies in IOPF
>    (domain->sva_ioas etc).
> 
>    We'll need to be careful about this when allowing other users to install
>    a fault handler. Should be fine as long as the handler and data are
>    installed before the domain is added to pasid_array.
> 
> * We know the domain is valid the whole time IOPF is using it, because
>    unbind() waits for pending faults.
> 
> We just need a comment explaining the last point, something like:
> 
>         /*
> 	* Safe to fetch outside the group mutex because:
>          * - xarray protects its internal state with RCU
>          * - the domain obtained is either NULL or fully formed
> 	* - the IOPF work is the only caller and is flushed before the
> 	*   domain is freed.
>          */
> 
> Thanks,
> Jean
> 
>> +	domain = xa_load(&group->pasid_array, pasid);
>> +	mutex_unlock(&group->mutex);
>> +	iommu_group_put(group);
>> +
>> +	return domain;
>> +}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
