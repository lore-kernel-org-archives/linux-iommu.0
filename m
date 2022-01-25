Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AABAC433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 03:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD400827F0;
	Tue, 25 Jan 2022 03:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5q033-6XjrRe; Tue, 25 Jan 2022 03:19:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7C2E5827AF;
	Tue, 25 Jan 2022 03:19:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A53CC0031;
	Tue, 25 Jan 2022 03:19:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5402C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3C4760FD0
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 731nUfC_j51z for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:19:06 +0000 (UTC)
X-Greylist: greylisting inactive for iommu@lists.linux-foundation.org in
 SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA64160759
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643080746; x=1674616746;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=+G9uJ5cBRukDuRVioB36b7JgfNmSiiRAztt/zlvEwis=;
 b=VP8mE3X974hdsrDA8SWk9e1TelgqbUvnD1w1P9ZypSH0ShBaw3XBpKTh
 bxl01CIVpVb8nyKyN0Ia0IkuoXOufnBM8lKOCLWLPQ1Jz3nS6z6CETTqM
 jNc6lRS431/FZcKMTVTmf3SaNeqRnbgVad7vq6zIadLw4BfDNzg3NqAIC
 nGUkewmVgi3570Qln1PdN2rvcHQdk/MA/sRfQr30SmTobh6/hHJAHZVhC
 MUFpQT4VQlq/MWJb9OaB3HzcwK+jseBQEm2Gjp8rk98Oa5U1FWyUCC877
 KWyvPdd0t6HA6vaBQF398NQ0hr5eQb0vGSyWQJh8semiGYrA8uizUbang A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226185212"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="226185212"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 19:19:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="534536381"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:19:01 -0800
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <20220124173650.GF966497@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e4493dac-07bf-7ee3-5bea-a159fd37a2dd@linux.intel.com>
Date: Tue, 25 Jan 2022 11:18:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220124173650.GF966497@nvidia.com>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

On 1/25/22 1:36 AM, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 03:11:01PM +0800, Lu Baolu wrote:
>> The common iommu_ops is hooked to both device and domain. When a helper
>> has both device and domain pointer, the way to get the iommu_ops looks
>> messy in iommu core. This sorts out the way to get iommu_ops. The device
>> related helpers go through device pointer, while the domain related ones
>> go through domain pointer.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/iommu.h |  8 ++++++++
>>   drivers/iommu/iommu.c | 25 ++++++++++++++-----------
>>   2 files changed, 22 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index aa5486243892..111b3e9c79bb 100644
>> +++ b/include/linux/iommu.h
>> @@ -385,6 +385,14 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
>>   	};
>>   }
>>   
>> +static inline const struct iommu_ops *dev_iommu_ops_get(struct device *dev)
>> +{
>> +	if (dev && dev->iommu && dev->iommu->iommu_dev)
>> +		return dev->iommu->iommu_dev->ops;
>> +
>> +	return NULL;
> 
> What is the purpose of this helper?

Get the iommu_ops from a device pointer. Just want to avoid duplicate
code in various functions.

> 
>> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>>   	struct iommu_domain *domain = group->default_domain;
>>   	struct iommu_resv_region *entry;
>>   	struct list_head mappings;
>> @@ -785,8 +786,8 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>>   		dma_addr_t start, end, addr;
>>   		size_t map_size = 0;
>>   
>> -		if (domain->ops->apply_resv_region)
>> -			domain->ops->apply_resv_region(dev, domain, entry);
>> +		if (ops->apply_resv_region)
>> +			ops->apply_resv_region(dev, domain, entry);
> 
> Here we call it and don't check for NULL? So why did we check the
> interior pointers in the helper?

Yes. Should check.

> 
>> @@ -831,8 +832,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>>   static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>>   				     struct device *dev)
>>   {
>> -	if (domain->ops->is_attach_deferred)
>> -		return domain->ops->is_attach_deferred(domain, dev);
>> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>> +
>> +	if (ops->is_attach_deferred)
>> +		return ops->is_attach_deferred(domain, dev);
> 
> Same here, at least return false if ops is null..

Yes.

>    
>> @@ -1251,10 +1254,10 @@ int iommu_page_response(struct device *dev,
>>   	struct iommu_fault_event *evt;
>>   	struct iommu_fault_page_request *prm;
>>   	struct dev_iommu *param = dev->iommu;
>> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>>   	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
>> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>>   
>> -	if (!domain || !domain->ops->page_response)
>> +	if (!ops || !ops->page_response)
>>   		return -ENODEV;
>>   
>>   	if (!param || !param->fault_param)
>> @@ -1295,7 +1298,7 @@ int iommu_page_response(struct device *dev,
>>   			msg->pasid = 0;
>>   		}
>>   
>> -		ret = domain->ops->page_response(dev, evt, msg);
>> +		ret = ops->page_response(dev, evt, msg);
>>   		list_del(&evt->list);
>>   		kfree(evt);
>>   		break;
> 
> Feels weird that page_response is not connected to a domain, the fault
> originated from a domain after all. I would say this op should be
> moved to the domain and the caller should provide the a pointer to the
> domain that originated the fault.
> 
> Ideally since only some domain's will be configured to handle faults
> at all - domains that can't do this should have a NULL page_response
> op, even if other domains created by the same device driver could
> handle page_response..
> 
>> @@ -1758,10 +1761,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
>>   
>>   static int iommu_group_do_probe_finalize(struct device *dev, void *data)
>>   {
>> -	struct iommu_domain *domain = data;
>> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>>   
>> -	if (domain->ops->probe_finalize)
>> -		domain->ops->probe_finalize(dev);
>> +	if (ops->probe_finalize)
>> +		ops->probe_finalize(dev);
> 
> This is an oddball one too, it is finishing setting up the default
> domain for a device? Several drivers seem to recover the default
> domain in their implementations..

In order to avoid default domain type (DMA or IDENDITY) conflict among
devices in a same iommu_group, the probe process is divided into two
phases, one for determining the default domain type and the other for
allocating the default domain and attaching it to the device.

ops->probe_finalize() is called to tell the vendor iommu driver that
the device probe is done. Normally the vendor iommu driver could set the
dma ops in this callback.

> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
