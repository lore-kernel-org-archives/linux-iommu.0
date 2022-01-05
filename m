Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9224BC433EF
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 06:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AB248144F;
	Wed,  5 Jan 2022 06:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aMFQiyET7f4z; Wed,  5 Jan 2022 06:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EBA3880DB9;
	Wed,  5 Jan 2022 06:58:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE441C0030;
	Wed,  5 Jan 2022 06:58:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E485C001E
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 06:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83B716FB34
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 06:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fwty0MLeBwSG for <iommu@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:58:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFD216FB30
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 06:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641365919; x=1672901919;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=yBeZgFZXz0WezV8A7VIFIHNPB9e3L10eKsd6tnEonRs=;
 b=IbTtRUuDOgIe6lZKuQCCjyynL/b/ah8lDue4fvo/1GCmvUFH3WQnPfmF
 HTuZLlm5Ybj89Qe1WfuBpxHDJpWn/B2ygtFsAb8v+mhJIRu3+dPkiPfbM
 ZMYdxlL9TqnU7Dg6DUzBh8g0layqTx+qVzY1NnafrvdPQi8+O2vxaty0a
 d1nJljJEAbeWe2dE5EvVtg7HG08VTUaWjoRU9JIO8szFwvFeaRfALhQ1+
 vy/+bkIkbvKQh+24rdlvJDFue5g+r1QH5MQNxQNdZId/6bJrUCA14ru55
 FSVEmCenNb+FleFD9OuMWQk4FF1nrzUTua/ShQ/GdfA4AiFA5U4qRjeJ4 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239923929"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; d="scan'208";a="239923929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2022 22:58:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; d="scan'208";a="526392923"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 22:58:32 -0800
Subject: Re: [PATCH v5 01/14] iommu: Add dma ownership management interfaces
To: Christoph Hellwig <hch@infradead.org>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-2-baolu.lu@linux.intel.com>
 <YdQcgFhIMYvUwABV@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a95e2aec-aabf-2db1-0d51-a7829c378d47@linux.intel.com>
Date: Wed, 5 Jan 2022 14:57:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdQcgFhIMYvUwABV@infradead.org>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Christoph,

On 1/4/22 6:08 PM, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 09:56:31AM +0800, Lu Baolu wrote:
>> Multiple devices may be placed in the same IOMMU group because they
>> cannot be isolated from each other. These devices must either be
>> entirely under kernel control or userspace control, never a mixture.
>>
>> This adds dma ownership management in iommu core and exposes several
>> interfaces for the device drivers and the device userspace assignment
>> framework (i.e. vfio), so that any conflict between user and kernel
>> controlled DMA could be detected at the beginning.
>>
>> The device driver oriented interfaces are,
>>
>> 	int iommu_device_use_dma_api(struct device *dev);
>> 	void iommu_device_unuse_dma_api(struct device *dev);
>>
>> Devices under kernel drivers control must call iommu_device_use_dma_api()
>> before driver probes. The driver binding process must be aborted if it
>> returns failure.
>>
>> The vfio oriented interfaces are,
>>
>> 	int iommu_group_set_dma_owner(struct iommu_group *group,
>> 				      void *owner);
>> 	void iommu_group_release_dma_owner(struct iommu_group *group);
>> 	bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>>
>> The device userspace assignment must be disallowed if the set dma owner
>> interface returns failure.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h |  31 ++++++++
>>   drivers/iommu/iommu.c | 161 +++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 189 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index de0c57a567c8..568f285468cf 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -682,6 +682,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>>   
>> +int iommu_device_use_dma_api(struct device *dev);
>> +void iommu_device_unuse_dma_api(struct device *dev);
>> +
>> +int iommu_group_set_dma_owner(struct iommu_group *group, void *owner);
>> +void iommu_group_release_dma_owner(struct iommu_group *group);
>> +bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>> +
>>   #else /* CONFIG_IOMMU_API */
>>   
>>   struct iommu_ops {};
>> @@ -1082,6 +1089,30 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>>   {
>>   	return NULL;
>>   }
>> +
>> +static inline int iommu_device_use_dma_api(struct device *dev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void iommu_device_unuse_dma_api(struct device *dev)
>> +{
>> +}
>> +
>> +static inline int
>> +iommu_group_set_dma_owner(struct iommu_group *group, void *owner)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void iommu_group_release_dma_owner(struct iommu_group *group)
>> +{
>> +}
>> +
>> +static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>> +{
>> +	return false;
>> +}
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   /**
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 8b86406b7162..ff0c8c1ad5af 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -48,6 +48,8 @@ struct iommu_group {
>>   	struct iommu_domain *default_domain;
>>   	struct iommu_domain *domain;
>>   	struct list_head entry;
>> +	unsigned int owner_cnt;
>> +	void *owner;
>>   };
>>   
>>   struct group_device {
>> @@ -289,7 +291,12 @@ int iommu_probe_device(struct device *dev)
>>   	mutex_lock(&group->mutex);
>>   	iommu_alloc_default_domain(group, dev);
>>   
>> -	if (group->default_domain) {
>> +	/*
>> +	 * If device joined an existing group which has been claimed
>> +	 * for none kernel DMA purpose, avoid attaching the default
>> +	 * domain.
>> +	 */
>> +	if (group->default_domain && !group->owner) {
>>   		ret = __iommu_attach_device(group->default_domain, dev);
>>   		if (ret) {
>>   			mutex_unlock(&group->mutex);
>> @@ -2320,7 +2327,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>>   {
>>   	int ret;
>>   
>> -	if (group->default_domain && group->domain != group->default_domain)
>> +	if (group->domain && group->domain != group->default_domain)
>>   		return -EBUSY;
>>   
>>   	ret = __iommu_group_for_each_dev(group, domain,
>> @@ -2357,7 +2364,11 @@ static void __iommu_detach_group(struct iommu_domain *domain,
>>   {
>>   	int ret;
>>   
>> -	if (!group->default_domain) {
>> +	/*
>> +	 * If group has been claimed for none kernel DMA purpose, avoid
>> +	 * re-attaching the default domain.
>> +	 */
> 
> none kernel reads odd.  But maybe drop that and just say 'claimed
> already' ala:
> 
> 	/*
> 	 * If the group has been claimed already, do not re-attach the default
> 	 * domain.
> 	 */
> 

Sure!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
