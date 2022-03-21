Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F65C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 10:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA19460E96;
	Mon, 21 Mar 2022 10:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4SkId7x7Twxw; Mon, 21 Mar 2022 10:27:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A69F60E70;
	Mon, 21 Mar 2022 10:27:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F014C0012;
	Mon, 21 Mar 2022 10:27:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69223C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 492AA82768
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:27:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q4HMhjXmACu4 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 10:27:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81B648242D
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647858464; x=1679394464;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=LDF4W4xRXP4neOhFFxNRxYCmc5oPsktu1t/2i1GPpFI=;
 b=HURkUetVVe+tMJCvKY7ii8GFo5J81dpCeL7ONz45xjGBidJFU0nortvX
 GIYuJ2n9HqFXRxMpuG9Vln9xpaq7YxscEZjB7CdX86L9SsPF1fVDHws1Z
 HJ78xvhSx9btaFJhsaEnK92ZyeAsOzWWlrhfSBzgBvfFebB8Q/WT5kpM5
 x0PMrLueVIjuYPO5QucUh+qxgtArqILSDgzYhpwRNS2DnHGrh7YjHdHe0
 3W64r/0vI9bBBBNY6n2jqG4tXlwBeJZ3u+EvO0OkxcExHjNYH+DHdUjmx
 7JQfqsSa514V8qOBqqzTlAmOARHwlixJGcJVHQuqZrgItOb9f1oRK+7CT A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="239675043"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="239675043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:27:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="559806927"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.169])
 ([10.254.213.169])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:27:39 -0700
Message-ID: <d62ef788-c6b9-8259-88cc-486efaade2b7@linux.intel.com>
Date: Mon, 21 Mar 2022 18:27:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 03/11] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-4-baolu.lu@linux.intel.com>
 <BL1PR11MB527174765D1253AB4B88D2AD8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB527174765D1253AB4B88D2AD8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

On 2022/3/21 15:13, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Sunday, March 20, 2022 2:40 PM
>>
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of common domain ops for this purpose and implements a
>> couple of wrapper helpers for in-kernel usage.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 22 ++++++++++++++++++++++
>>   drivers/iommu/iommu.c | 41
>> +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 63 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 3e179b853380..e51845b9a146 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -268,6 +268,8 @@ struct iommu_ops {
>>    * struct iommu_domain_ops - domain specific operations
>>    * @attach_dev: attach an iommu domain to a device
>>    * @detach_dev: detach an iommu domain from a device
>> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
>> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>>    * @map: map a physically contiguous memory region to an iommu domain
>>    * @map_pages: map a physically contiguous set of pages of the same size
>> to
>>    *             an iommu domain.
>> @@ -285,6 +287,10 @@ struct iommu_ops {
>>   struct iommu_domain_ops {
>>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>>   	void (*detach_dev)(struct iommu_domain *domain, struct device
>> *dev);
>> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
>> +				struct device *dev, ioasid_t id);
>> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
>> +				 struct device *dev, ioasid_t id);
>>
>>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
>> @@ -678,6 +684,11 @@ int iommu_group_claim_dma_owner(struct
>> iommu_group *group, void *owner);
>>   void iommu_group_release_dma_owner(struct iommu_group *group);
>>   bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>>
>> +int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +			      struct device *dev, ioasid_t pasid);
>> +void iommu_detach_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid);
>> +
>>   #else /* CONFIG_IOMMU_API */
>>
>>   struct iommu_ops {};
>> @@ -1046,6 +1057,17 @@ static inline bool
>> iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   {
>>   	return false;
>>   }
>> +
>> +static inline int iommu_attach_device_pasid(struct iommu_domain
>> *domain,
>> +					    struct device *dev, ioasid_t pasid)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void iommu_detach_device_pasid(struct iommu_domain
>> *domain,
>> +					     struct device *dev, ioasid_t pasid)
>> +{
>> +}
>>   #endif /* CONFIG_IOMMU_API */
>>
>>   /**
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 0c42ece25854..78c71ee15f36 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3167,3 +3167,44 @@ bool iommu_group_dma_owner_claimed(struct
>> iommu_group *group)
>>   	return user;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>> +
>> +int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +			      struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_group *group;
>> +	int ret = -EINVAL;
>> +
>> +	if (!domain->ops->attach_dev_pasid)
>> +		return -EINVAL;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return -ENODEV;
>> +
>> +	mutex_lock(&group->mutex);
>> +	if (iommu_group_device_count(group) != 1)
>> +		goto out_unlock;
> Need move the reason of above limitation from iommu_sva_bind_device()
> to here:
> 
> 	/*
> 	 * To keep things simple, SVA currently doesn't support IOMMU groups
> 	 * with more than one device. Existing SVA-capable systems are not
> 	 * affected by the problems that required IOMMU groups (lack of ACS
> 	 * isolation, device ID aliasing and other hardware issues).
> 	 */
> 	if (iommu_group_device_count(group) != 1)
> 		goto out_unlock;

Yes. We need a comment around this code. But it's not only for SVA but
also for all pasid attachment feature. I need more inputs to judge
whether this limitation is reasonable.

> 
> btw I didn't see any safeguard on above assumption in device hotplug path
> to a group which already has SVA enabled...
> 

Agreed.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
