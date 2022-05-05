Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C063C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 06:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0AED83F7F;
	Thu,  5 May 2022 06:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qvFSEdEpoEzp; Thu,  5 May 2022 06:30:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 91B5D83F85;
	Thu,  5 May 2022 06:30:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A241C0039;
	Thu,  5 May 2022 06:30:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E76CC0032
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 06:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EEC0418BA
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 06:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P2xdwuOrQEcl for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 06:30:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B40E418B3
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 06:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651732243; x=1683268243;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FWdkTJQPgfah88qi8uE8TAWSXAdTDOOpVO7WtKyi8WI=;
 b=P2nzKX3Amhp56FNZN/bMhoPsU+xAhqrnp/B25pz08IIa+D3iZctF/+J2
 AA8TLs2M6M2Dt3fjQWyT2l4mEHo5Wf6sr+dte+DHRevybmuVwospV4m6r
 vomWCJzla3LLRfRQ47BneejzCTyViyjqRctIYSOehgNNBjsJUVdn3mIU9
 nXzruyeqqXIEm4MuKIEvUfcDV8tIACTnvTCE29E3qaFUa/wW54mOYLv/C
 ptIV/rU9Ei0nr1TeLYouz02HUCF/QGbZc/MWfuxdLZMtTZ5AEEXemX1P0
 nj6RIeBRYKS1fTaJBW6u6TFjv/hwD4b6qv9DQ9Vxkk9FraOxzf4uTptGa w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="249996924"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="249996924"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 23:28:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="563093444"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75])
 ([10.255.30.75])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 23:28:12 -0700
Message-ID: <d0e78ba5-9698-1dbf-4834-553fbcef6aad@linux.intel.com>
Date: Thu, 5 May 2022 14:28:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 03/12] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-4-baolu.lu@linux.intel.com> <YnFvX8IUwP2drNoj@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnFvX8IUwP2drNoj@myrica>
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

On 2022/5/4 02:07, Jean-Philippe Brucker wrote:
> On Mon, May 02, 2022 at 09:48:33AM +0800, Lu Baolu wrote:
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA (Shared Virtual Address)
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of common domain ops for this purpose and adds helpers
>> to attach/detach a domain to/from a {device, PASID}. Some buses, like
>> PCI, route packets without considering the PASID value. Thus a DMA target
>> address with PASID might be treated as P2P if the address falls into the
>> MMIO BAR of other devices in the group. To make things simple, these
>> interfaces only apply to devices belonging to the singleton groups, and
>> the singleton is immutable in fabric i.e. not affected by hotplug.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> just a nit below
> 
>> ---
>>   include/linux/iommu.h | 21 ++++++++++++
>>   drivers/iommu/iommu.c | 76 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 97 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index b8ffaf2cb1d0..ab36244d4e94 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -263,6 +263,8 @@ struct iommu_ops {
>>    * struct iommu_domain_ops - domain specific operations
>>    * @attach_dev: attach an iommu domain to a device
>>    * @detach_dev: detach an iommu domain from a device
>> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
>> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>>    * @map: map a physically contiguous memory region to an iommu domain
>>    * @map_pages: map a physically contiguous set of pages of the same size to
>>    *             an iommu domain.
>> @@ -283,6 +285,10 @@ struct iommu_ops {
>>   struct iommu_domain_ops {
>>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
>> +				struct device *dev, ioasid_t pasid);
>> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
>> +				 struct device *dev, ioasid_t pasid);
>>   
>>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
>> @@ -678,6 +684,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>>   void iommu_group_release_dma_owner(struct iommu_group *group);
>>   bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>>   
>> +int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +			      struct device *dev, ioasid_t pasid);
>> +void iommu_detach_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid);
>>   #else /* CONFIG_IOMMU_API */
>>   
>>   struct iommu_ops {};
>> @@ -1051,6 +1061,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   {
>>   	return false;
>>   }
>> +
>> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +					    struct device *dev, ioasid_t pasid)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
>> +					     struct device *dev, ioasid_t pasid)
>> +{
>> +}
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   /**
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 29906bc16371..89c9d19ddb28 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -38,6 +38,7 @@ struct iommu_group {
>>   	struct kobject kobj;
>>   	struct kobject *devices_kobj;
>>   	struct list_head devices;
>> +	struct xarray pasid_array;
>>   	struct mutex mutex;
>>   	void *iommu_data;
>>   	void (*iommu_data_release)(void *iommu_data);
>> @@ -630,6 +631,7 @@ struct iommu_group *iommu_group_alloc(void)
>>   	mutex_init(&group->mutex);
>>   	INIT_LIST_HEAD(&group->devices);
>>   	INIT_LIST_HEAD(&group->entry);
>> +	xa_init(&group->pasid_array);
>>   
>>   	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
>>   	if (ret < 0) {
>> @@ -3190,3 +3192,77 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   	return user;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>> +
>> +/*
>> + * Use standard PCI bus topology and isolation features to check immutable
>> + * singleton. Otherwise, assume the bus is static and then singleton can
>> + * know from the device count in the group.
>> + */
> 
> The comment doesn't really add anything that can't be directly understood
> from the code.

Yes. It's fine to remove it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
