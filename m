Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F24C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 04:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B98DE60E39;
	Tue, 22 Mar 2022 04:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vzQPYjjiJL0x; Tue, 22 Mar 2022 04:50:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 60BC560A8A;
	Tue, 22 Mar 2022 04:50:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37D81C001A;
	Tue, 22 Mar 2022 04:50:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0870C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C664B416D2
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pjyglxatqVhY for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 04:50:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF65F4168F
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647924655; x=1679460655;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cTZrAGX+t69jJcCH7JXAi2XQzqRxygaDZLgYJyVhgpM=;
 b=byX4nrBBiJi9UqvnW7BtBleW/9Z7nn3KzRmHjTab/bP173b3PCO2McAE
 kR+lMqiJNVMADSa+YP53awVywElf5ry0Clvc6rMFMJJGnKow7X0E0Pk/6
 s7G77Xop/E8sP7yRr9XqRmim32uM7YnW/5xf+UEkohqnj8y/kUFczeLYm
 jgCRso75aPNfjKz5So2jKql8RDdR0LMVIhQjFlScR5q87y75X+nqLz3+3
 Z95uEPvhqRLB6N7YsvziN+1MCGUH8ZaW/w8xZA00N3imNMpPIbbIMJe5L
 dNBulW4E4juC1iUe/d4ELSy9tqlYEpNGXsy+D3ESoVf88QDDLXwFsuQWt g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257913031"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="257913031"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 21:50:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="518724693"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186])
 ([10.254.209.186])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 21:50:47 -0700
Message-ID: <966d28f6-3b87-45c5-e758-f38eb339e3c6@linux.intel.com>
Date: Tue, 22 Mar 2022 12:50:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 09/11] iommu: Add iommu_get_domain_for_dev_pasid()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-10-baolu.lu@linux.intel.com>
 <20220321124058.GO11336@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220321124058.GO11336@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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

On 2022/3/21 20:40, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:28PM +0800, Lu Baolu wrote:
>> @@ -3098,7 +3101,16 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>   	if (iommu_group_device_count(group) != 1)
>>   		goto out_unlock;
>>   
>> +	xa_lock(&group->pasid_array);
>> +	curr = __xa_cmpxchg(&group->pasid_array, pasid, NULL,
>> +			    domain, GFP_KERNEL);
>> +	xa_unlock(&group->pasid_array);
>> +	if (curr)
> 
> curr can be an xa_err that should be propogated.

Yes, should check xa_err().

> 
>> +		goto out_unlock;
>> +
>>   	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
>> +	if (ret)
>> +		xa_erase(&group->pasid_array, pasid);
>>   
>>   out_unlock:
>>   	mutex_unlock(&group->mutex);
>> @@ -3118,6 +3130,25 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>>   
>>   	mutex_lock(&group->mutex);
>>   	domain->ops->detach_dev_pasid(domain, dev, pasid);
>> +	xa_erase(&group->pasid_array, pasid);
>> +	mutex_unlock(&group->mutex);
>> +	iommu_group_put(group);
>> +}
>> +
>> +struct iommu_domain *
>> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
>> +
>> +	mutex_lock(&group->mutex);
>> +	domain = xa_load(&group->pasid_array, pasid);
>>   	mutex_unlock(&group->mutex);
>>   	iommu_group_put(group);
> 
> This whole API seems sketchy - what is the lifecycle of the returned
> iommu_domain and what prevents it from being concurrently freed after
> unlocking?

Agreed. The domain could be used in page fault handling thread, hence
need a mechanism to guarantee the concurrence.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
