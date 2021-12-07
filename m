Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE02C4332F
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 02:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D795E60E50;
	Tue,  7 Dec 2021 02:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sJVdRnVPla0T; Tue,  7 Dec 2021 02:07:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 974FC607B3;
	Tue,  7 Dec 2021 02:07:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AEAEC001E;
	Tue,  7 Dec 2021 02:07:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32076C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 02:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A44841C23
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 02:07:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FAEYmIH2ZLcM for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:07:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5101841C22
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 02:07:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="300846042"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="300846042"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 18:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="515046131"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 06 Dec 2021 18:07:23 -0800
Subject: Re: [PATCH v3 01/18] iommu: Add device dma ownership set/release
 interfaces
To: Christoph Hellwig <hch@infradead.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-2-baolu.lu@linux.intel.com>
 <Ya4hZ2F7MYusgmSB@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2872aa9f-c325-ca28-fb64-f86857ad3e91@linux.intel.com>
Date: Tue, 7 Dec 2021 10:07:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya4hZ2F7MYusgmSB@infradead.org>
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

On 12/6/21 10:42 PM, Christoph Hellwig wrote:
> On Mon, Dec 06, 2021 at 09:58:46AM +0800, Lu Baolu wrote:
>> >From the perspective of who is initiating the device to do DMA, device
>> DMA could be divided into the following types:
>>
>>          DMA_OWNER_DMA_API: Device DMAs are initiated by a kernel driver
>> 			through the kernel DMA API.
>>          DMA_OWNER_PRIVATE_DOMAIN: Device DMAs are initiated by a kernel
>> 			driver with its own PRIVATE domain.
>> 	DMA_OWNER_PRIVATE_DOMAIN_USER: Device DMAs are initiated by
>> 			userspace.
>>
>> Different DMA ownerships are exclusive for all devices in the same iommu
>> group as an iommu group is the smallest granularity of device isolation
>> and protection that the IOMMU subsystem can guarantee. This extends the
>> iommu core to enforce this exclusion.
>>
>> Basically two new interfaces are provided:
>>
>>          int iommu_device_set_dma_owner(struct device *dev,
>>                  enum iommu_dma_owner type, void *owner_cookie);
>>          void iommu_device_release_dma_owner(struct device *dev,
>>                  enum iommu_dma_owner type);
>>
>> Although above interfaces are per-device, DMA owner is tracked per group
>> under the hood. An iommu group cannot have different dma ownership set
>> at the same time. Violation of this assumption fails
>> iommu_device_set_dma_owner().
>>
>> Kernel driver which does DMA have DMA_OWNER_DMA_API automatically set/
>> released in the driver binding/unbinding process (see next patch).
>>
>> Kernel driver which doesn't do DMA could avoid setting the owner type.
>> Device bound to such driver is considered same as a driver-less device
>> which is compatible to all owner types.
>>
>> Userspace driver framework (e.g. vfio) should set
>> DMA_OWNER_PRIVATE_DOMAIN_USER for a device before the userspace is allowed
>> to access it, plus a owner cookie pointer to mark the user identity so a
>> single group cannot be operated by multiple users simultaneously. Vice
>> versa, the owner type should be released after the user access permission
>> is withdrawn.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 36 +++++++++++++++++
>>   drivers/iommu/iommu.c | 93 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 129 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index d2f3435e7d17..24676b498f38 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -162,6 +162,23 @@ enum iommu_dev_features {
>>   	IOMMU_DEV_FEAT_IOPF,
>>   };
>>   
>> +/**
>> + * enum iommu_dma_owner - IOMMU DMA ownership
>> + * @DMA_OWNER_NONE: No DMA ownership.
>> + * @DMA_OWNER_DMA_API: Device DMAs are initiated by a kernel driver through
>> + *			the kernel DMA API.
>> + * @DMA_OWNER_PRIVATE_DOMAIN: Device DMAs are initiated by a kernel driver
>> + *			which provides an UNMANAGED domain.
>> + * @DMA_OWNER_PRIVATE_DOMAIN_USER: Device DMAs are initiated by userspace,
>> + *			kernel ensures that DMAs never go to kernel memory.
>> + */
>> +enum iommu_dma_owner {
>> +	DMA_OWNER_NONE,
>> +	DMA_OWNER_DMA_API,
>> +	DMA_OWNER_PRIVATE_DOMAIN,
>> +	DMA_OWNER_PRIVATE_DOMAIN_USER,
>> +};
>> +
>>   #define IOMMU_PASID_INVALID	(-1U)
>>   
>>   #ifdef CONFIG_IOMMU_API
>> @@ -681,6 +698,10 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>>   
>> +int iommu_device_set_dma_owner(struct device *dev, enum iommu_dma_owner owner,
>> +			       void *owner_cookie);
>> +void iommu_device_release_dma_owner(struct device *dev, enum iommu_dma_owner owner);
>> +
>>   #else /* CONFIG_IOMMU_API */
>>   
>>   struct iommu_ops {};
>> @@ -1081,6 +1102,21 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>>   {
>>   	return NULL;
>>   }
>> +
>> +static inline int iommu_device_set_dma_owner(struct device *dev,
>> +					     enum iommu_dma_owner owner,
>> +					     void *owner_cookie)
>> +{
>> +	if (owner != DMA_OWNER_DMA_API)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void iommu_device_release_dma_owner(struct device *dev,
>> +						  enum iommu_dma_owner owner)
>> +{
>> +}
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   /**
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 8b86406b7162..1de520a07518 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -48,6 +48,9 @@ struct iommu_group {
>>   	struct iommu_domain *default_domain;
>>   	struct iommu_domain *domain;
>>   	struct list_head entry;
>> +	enum iommu_dma_owner dma_owner;
>> +	refcount_t owner_cnt;
> 
> owner_cnt is only manipulated under group->mutex, not need for a
> refcount_t here, a plain unsigned int while do it and will also
> simplify a fair bit of code as it avoid the need for atomic add/sub
> and test operations.

Fair enough.

> 
>> +static int __iommu_group_set_dma_owner(struct iommu_group *group,
>> +				       enum iommu_dma_owner owner,
>> +				       void *owner_cookie)
>> +{
> 
> As pointed out last time, please move the group->mutex locking into
> this helper, which makes it identical to the later added public
> function.

I didn't mean to ignore your comment. :-) As I replied, by placing the
lock out of the function, the helper could easily handle the error paths
(return directly without something like "goto out_unlock").

As the implementation of iommu_group_set_dma_owner() has been greatly
simplified, I agree with you now, we should move the group->mutex
locking into the helper and make it identical to the latter public
interface.

I will work towards this.

> 
>> +static void __iommu_group_release_dma_owner(struct iommu_group *group,
>> +					    enum iommu_dma_owner owner)
>> +{
> 
> Same here.
> 

Ditto.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
