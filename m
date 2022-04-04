Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC028C433FE
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 06:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A16140510;
	Mon,  4 Apr 2022 06:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7B9JXVgXy5uN; Mon,  4 Apr 2022 06:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F0C8240102;
	Mon,  4 Apr 2022 06:47:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC664C001D;
	Mon,  4 Apr 2022 06:47:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE3B9C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 06:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D703F82AED
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 06:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ohx9pEQ-kVFM for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 06:47:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07B6482AA9
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649054833; x=1680590833;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=1qb2JwH7lgsujR96fwZNadimhjb2aZ4RRps5Gl3fB8s=;
 b=Iqom9+S2XOvUwEE/pUMzmWVyxkxAA/gSSD4V41ho5DTUsfxQAb3k7/4Z
 I2guJq9fZYAtYrKuy+htwLgtYP3hcV/ZF2wlKsgKxiRFVSTtN6EqA+YPh
 Qqex2Z7nwYuA9Dm9ETfG/owCSnjm7cQHUwLV9Yb9w5J043BLCRreL5gff
 b6RE5HKZvpezEpKzROyqTzmbLBs68Rq185z9zfg5hmKEMRVJRKje2cmh1
 Nd+EZqKxi6GDalFfPCTSEKFQlKKUHc/cibS9HBpZP408g12YhRxCjxMK7
 ciVZVwyrfiue58cHyubJY2eRYRyX5dft4olSUg79g7/5a9tlh1o4Ppelv g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="241038033"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="241038033"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 23:47:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="548544591"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140])
 ([10.254.214.140])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 23:47:08 -0700
Message-ID: <9958fae3-2918-c1b7-6804-8b840807eb5c@linux.intel.com>
Date: Mon, 4 Apr 2022 14:47:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-5-baolu.lu@linux.intel.com>
 <20220330190852.GC2120790@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 04/11] iommu: Add attach/detach_dev_pasid domain ops
In-Reply-To: <20220330190852.GC2120790@nvidia.com>
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

Hi Jason,

On 2022/3/31 3:08, Jason Gunthorpe wrote:
> On Tue, Mar 29, 2022 at 01:37:53PM +0800, Lu Baolu wrote:
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA (Shared Virtual Address)
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of common domain ops for this purpose and adds some
>> common helpers to attach/detach a domain to/from a {device, PASID} and
>> get/put the domain attached to {device, PASID}.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/iommu.h | 36 ++++++++++++++++++
>>   drivers/iommu/iommu.c | 88 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 124 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 29c4c2edd706..a46285488a57 100644
>> +++ b/include/linux/iommu.h
>> @@ -269,6 +269,8 @@ struct iommu_ops {
>>    * struct iommu_domain_ops - domain specific operations
>>    * @attach_dev: attach an iommu domain to a device
>>    * @detach_dev: detach an iommu domain from a device
>> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
>> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>>    * @map: map a physically contiguous memory region to an iommu domain
>>    * @map_pages: map a physically contiguous set of pages of the same size to
>>    *             an iommu domain.
>> @@ -286,6 +288,10 @@ struct iommu_ops {
>>   struct iommu_domain_ops {
>>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
>> +				struct device *dev, ioasid_t id);
>> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
>> +				 struct device *dev, ioasid_t id);
> 
> ID should be pasid for consistency

Sure.

> 
>> +int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +			      struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_group *group;
>> +	int ret = -EINVAL;
>> +	void *curr;
>> +
>> +	if (!domain->ops->attach_dev_pasid)
>> +		return -EINVAL;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return -ENODEV;
>> +
>> +	mutex_lock(&group->mutex);
>> +	/*
>> +	 * To keep things simple, we currently don't support IOMMU groups
>> +	 * with more than one device. Existing SVA-capable systems are not
>> +	 * affected by the problems that required IOMMU groups (lack of ACS
>> +	 * isolation, device ID aliasing and other hardware issues).
>> +	 */
>> +	if (!iommu_group_singleton_lockdown(group))
>> +		goto out_unlock;
>> +
>> +	xa_lock(&group->pasid_array);
>> +	curr = __xa_cmpxchg(&group->pasid_array, pasid, NULL,
>> +			    domain, GFP_KERNEL);
>> +	xa_unlock(&group->pasid_array);
> 
> Why the xa_lock/unlock? Just call the normal xa_cmpxchg?

I should use xa_cmpxchg() instead.


> 
>> +void iommu_detach_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_group *group;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (WARN_ON(!group))
>> +		return;
> 
> This group_get stuff really needs some cleaning, this makes no sense
> at all.
> 
> If the kref to group can go to zero within this function then the
> initial access of the kref is already buggy:
> 
> 	if (group)
> 		kobject_get(group->devices_kobj);
> 
> Because it will crash or WARN_ON.
> 
> We don't hit this because it is required that a group cannot be
> destroyed while a struct device has a driver bound, and all these
> paths are driver bound paths.
> 
> So none of these group_get/put patterns have any purpose at all, and
> now we are adding impossible WARN_ONs to..

The original intention of this check is that the helper is called on the
correct device. I agree that WARN_ON() is unnecessary because NULL
pointer reference will be caught automatically.

> 
>> +struct iommu_domain *
>> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
> 
> And now we are doing useless things on a performance path!

Agreed.

> 
>> +	mutex_lock(&group->mutex);
>> +	domain = xa_load(&group->pasid_array, pasid);
>> +	if (domain && domain->type == IOMMU_DOMAIN_SVA)
>> +		iommu_sva_domain_get_user(domain);
>> +	mutex_unlock(&group->mutex);
>> +	iommu_group_put(group);
> 
> Why do we need so much locking on a performance path? RCU out of the
> xarray..
> 
> Not sure I see how this get_user refcounting can work ?

I should move the refcountering things to iommu_domain and make the
change easier for review. Will improve this in the new version.

> 
> Jason

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
