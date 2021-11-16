Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854D4C433F5
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 09:42:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A0661A38
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 09:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28A0661A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E792980EE9;
	Tue, 16 Nov 2021 09:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WT9yM34OAZxH; Tue, 16 Nov 2021 09:42:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA40080EF2;
	Tue, 16 Nov 2021 09:42:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81FD6C001E;
	Tue, 16 Nov 2021 09:42:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EFBEC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 09:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB23C4043F
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 09:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BoREx48AHcBY for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 09:42:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D5194043C
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 09:42:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="233493633"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; d="scan'208";a="233493633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 01:42:13 -0800
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; d="scan'208";a="506359272"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.220])
 ([10.254.210.220])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 01:42:07 -0800
Message-ID: <14bed5c1-a385-7e99-bda9-1041341fe68d@linux.intel.com>
Date: Tue, 16 Nov 2021 17:42:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-7-baolu.lu@linux.intel.com>
 <YZJgMzYzuxjJpWIC@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 06/11] iommu: Expose group variants of dma ownership
 interfaces
In-Reply-To: <YZJgMzYzuxjJpWIC@infradead.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

On 2021/11/15 21:27, Christoph Hellwig wrote:
> On Mon, Nov 15, 2021 at 10:05:47AM +0800, Lu Baolu wrote:
>> The vfio needs to set DMA_OWNER_USER for the entire group when attaching
> 
> The vfio subsystem?  driver?

"vfio subsystem"

> 
>> it to a vfio container. So expose group variants of setting/releasing dma
>> ownership for this purpose.
>>
>> This also exposes the helper iommu_group_dma_owner_unclaimed() for vfio
>> report to userspace if the group is viable to user assignment, for
> 
> .. for vfio to report .. ?

Yes.

> 
>>   void iommu_device_release_dma_owner(struct device *dev, enum iommu_dma_owner owner);
>> +int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner,
>> +			      struct file *user_file);
>> +void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner);
> 
> Pleae avoid all these overly long lines.

Sure. Thanks!

> 
>> +static inline int iommu_group_set_dma_owner(struct iommu_group *group,
>> +					    enum iommu_dma_owner owner,
>> +					    struct file *user_file)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +static inline void iommu_group_release_dma_owner(struct iommu_group *group,
>> +						 enum iommu_dma_owner owner)
>> +{
>> +}
>> +
>> +static inline bool iommu_group_dma_owner_unclaimed(struct iommu_group *group)
>> +{
>> +	return false;
>> +}
> 
> Why do we need these stubs?  All potential callers should already
> require CONFIG_IOMMU_API?  Same for the helpers added in patch 1, btw.

You are right. This helper is only for vfio which requires IOMMU_API. I
will remove this.

The helpers in patch 1 seem not the same. The driver core (or bus
dma_configure() callback as suggested) will also call them.

> 
>> +	mutex_lock(&group->mutex);
>> +	ret = __iommu_group_set_dma_owner(group, owner, user_file);
>> +	mutex_unlock(&group->mutex);
> 
>> +	mutex_lock(&group->mutex);
>> +	__iommu_group_release_dma_owner(group, owner);
>> +	mutex_unlock(&group->mutex);
> 
> Unless I'm missing something (just skipping over the patches),
> the existing callers also take the lock just around these calls,
> so we don't really need the __-prefixed lowlevel helpers.
> 

Move mutex_lock/unlock will make the helper implementation easier. :-)
It seems to be common code style in iommu core. For example,
__iommu_attach_group(), __iommu_group_for_each_dev(), etc.

>> +	mutex_lock(&group->mutex);
>> +	owner = group->dma_owner;
>> +	mutex_unlock(&group->mutex);
> 
> No need for a lock to read a single scalar.

Adding the lock will make kcasn happy. Jason G also told me that

[citing from his review comment]
"
It is always incorrect to read concurrent data without an annotation
of some kind.

For instance it can cause mis-execution of logic where the compiler is
unaware that a value it loads is allowed to change - ie no 
READ_ONCE/WRITE_ONCE semantic.
"

> 
>> +
>> +	return owner == DMA_OWNER_NONE;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_group_dma_owner_unclaimed);

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
