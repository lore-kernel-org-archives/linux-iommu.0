Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E27C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 04:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7536C61199;
	Tue, 22 Mar 2022 04:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KB0bF2Jz7jQv; Tue, 22 Mar 2022 04:29:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 272AB61197;
	Tue, 22 Mar 2022 04:29:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE298C001A;
	Tue, 22 Mar 2022 04:29:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B6C4C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 513C161199
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxZR5PU3VcXj for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 04:29:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90C3161197
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647923390; x=1679459390;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=e1W86sXEli1RnC50Lifh7zwKkpipBaeccg3PcImsLsw=;
 b=LGcB583aHUDx8pgAO6GlISwwQCtUcfPnn1Vri30upODi+EDy6d7e49Ab
 nQXavbT3POx6ds7FLFWIiTSEcjJlraAe0UuKQWOYhRixIeCKSbjB4VS8S
 yFNy/x4a0rHHP2eJ2JxNg9Blr84CNx7bOWNzf57cXUVOHjH9YdG3GKyde
 c9MLsSw+zq3V1ItLSRP5CemFD36gJmOjbUnjbtIRmi9TSkDqk0aouKndL
 YZ0wnipyguOSmwQztGSxmtAzxH2roYwPmuLsc5ttx85Rebu/BkbpsgAnI
 lY9xOofRosdpnOneQDA1qPTm+V2szwSdJPwS9mK8gZQAuB6UgoY/bZEyh w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="239877640"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="239877640"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 21:29:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="518718729"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186])
 ([10.254.209.186])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 21:29:42 -0700
Message-ID: <ba9802c5-2a45-9a85-2e0b-ebbc84870dc8@linux.intel.com>
Date: Tue, 22 Mar 2022 12:29:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com> <YjhiohZAbN1ornmB@myrica>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YjhiohZAbN1ornmB@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

On 2022/3/21 19:33, Jean-Philippe Brucker wrote:
> On Sun, Mar 20, 2022 at 02:40:25PM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
>> index 106506143896..47cf98e661ff 100644
>> --- a/drivers/iommu/iommu-sva-lib.c
>> +++ b/drivers/iommu/iommu-sva-lib.c
>> @@ -3,6 +3,8 @@
>>    * Helpers for IOMMU drivers implementing SVA
>>    */
>>   #include <linux/mutex.h>
>> +#include <linux/iommu.h>
>> +#include <linux/slab.h>
>>   #include <linux/sched/mm.h>
>>   
>>   #include "iommu-sva-lib.h"
>> @@ -69,3 +71,101 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_sva_find);
>> +
>> +static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev)
>> +{
>> +	struct bus_type *bus = dev->bus;
>> +	struct iommu_domain *domain;
>> +
>> +	if (!bus || !bus->iommu_ops)
>> +		return NULL;
>> +
>> +	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_SVA);
>> +	if (domain)
>> +		domain->type = IOMMU_DOMAIN_SVA;
>> +
>> +	return domain;
>> +}
>> +
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to it
>> + * @drvdata: opaque data pointer to pass to bind callback
>> + *
>> + * Create a bond between device and address space, allowing the device to access
>> + * the mm using the returned PASID. If a bond already exists between @device and
>> + * @mm, it is returned and an additional reference is taken.
> This is not true anymore, we return a different structure for each call.
> 
>> Caller must call
>> + * iommu_sva_unbind_device() to release each reference.
>> + *
>> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
>> + * initialize the required SVA features.
>> + *
>> + * On error, returns an ERR_PTR value.
>> + */
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>> +{
>> +	int ret = -EINVAL;
>> +	struct iommu_sva *handle;
>> +	struct iommu_domain *domain;
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +	if (!handle)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
>> +	if (ret)
>> +		goto out;
>> +
>> +	domain = iommu_sva_domain_alloc(dev);
>> +	if (!domain) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +	domain->sva_cookie = mm;
>> +
>> +	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
>> +	if (ret)
>> +		goto out_free_domain;
>> +
>> +	handle->dev = dev;
>> +	handle->domain = domain;
>> +	handle->pasid = mm->pasid;
>> +
>> +	return handle;
>> +
>> +out_free_domain:
>> +	iommu_domain_free(domain);
>> +out:
>> +	kfree(handle);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
>> +
>> +/**
>> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
>> + * @handle: the handle returned by iommu_sva_bind_device()
>> + *
>> + * Put reference to a bond between device and address space.
> Same here. But I'd prefer keeping the old behavior so device drivers don't
> have to keep track of {dev, mm} pairs themselves.

Okay. Thank you for pointing this out. Let me figure it out in the next
version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
