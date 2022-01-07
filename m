Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92244C433EF
	for <iommu@archiver.kernel.org>; Fri,  7 Jan 2022 00:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A6DA81919;
	Fri,  7 Jan 2022 00:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ETMLL7XBdWli; Fri,  7 Jan 2022 00:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 22000817BD;
	Fri,  7 Jan 2022 00:27:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE989C0030;
	Fri,  7 Jan 2022 00:27:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82446C001E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 00:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61C0C8186B
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 00:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MqXo1vm5BbH2 for <iommu@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 00:27:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F792817BD
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 00:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641515258; x=1673051258;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=DHF9LNBkwjjdXkY2HtbzusqrhjTjnQLSGj+vV2UJQkc=;
 b=ZyVcNU6QkF0eOpd97SjOpZf9wwM6fwx3Um9OxxN5NbLWQ1/T8TvMZe3p
 TpFtPT0a0eqXiRtYStUQ4dntxDtqpTBXKJOvUrKRFd/0gXGBeJShAy62G
 f8dPe2kYypRAlPLsWzPiG7HqOJ1UCRA7lkui/GfDFKyrVOkTK91SrA26T
 S8hWNmNu39I/ldyoyNunceq7pmWlyW4XIQyR3rtxp+2lCxeAMm8lfz3+D
 fLi6T8tqGmIum+SgcsbIK5qDxap0KHpYvGiNvqOsTnIcSIT+D7RnB79nQ
 z+oO2nrpJAGLHS2X4Nu6/MhQ7TNjS1xmt8IpxaLJLF+xI+js5T9Y6aM8E w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222759386"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="222759386"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 16:27:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="527180734"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 06 Jan 2022 16:27:30 -0800
Subject: Re: [PATCH v1 1/8] iommu: Add iommu_group_replace_domain()
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-2-baolu.lu@linux.intel.com>
 <20220106170608.GI2328285@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <58e2d0d2-649a-a3f5-e8ae-9cbf2719015f@linux.intel.com>
Date: Fri, 7 Jan 2022 08:26:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106170608.GI2328285@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
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

On 1/7/22 1:06 AM, Jason Gunthorpe wrote:
> On Thu, Jan 06, 2022 at 10:20:46AM +0800, Lu Baolu wrote:
>> Expose an interface to replace the domain of an iommu group for frameworks
>> like vfio which claims the ownership of the whole iommu group.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/iommu.h | 10 ++++++++++
>>   drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 408a6d2b3034..66ebce3d1e11 100644
>> +++ b/include/linux/iommu.h
>> @@ -677,6 +677,9 @@ void iommu_device_unuse_dma_api(struct device *dev);
>>   int iommu_group_set_dma_owner(struct iommu_group *group, void *owner);
>>   void iommu_group_release_dma_owner(struct iommu_group *group);
>>   bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>> +int iommu_group_replace_domain(struct iommu_group *group,
>> +			       struct iommu_domain *old,
>> +			       struct iommu_domain *new);
>>   
>>   #else /* CONFIG_IOMMU_API */
>>   
>> @@ -1090,6 +1093,13 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   {
>>   	return false;
>>   }
>> +
>> +static inline int
>> +iommu_group_replace_domain(struct iommu_group *group, struct iommu_domain *old,
>> +			   struct iommu_domain *new)
>> +{
>> +	return -ENODEV;
>> +}
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   /**
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 72a95dea688e..ab8ab95969f5 100644
>> +++ b/drivers/iommu/iommu.c
>> @@ -3431,3 +3431,40 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   	return user;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>> +
>> +/**
>> + * iommu_group_replace_domain() - Replace group's domain
>> + * @group: The group.
>> + * @old: The previous attached domain. NULL for none.
>> + * @new: The new domain about to be attached.
>> + *
>> + * This is to support backward compatibility for vfio which manages the dma
>> + * ownership in iommu_group level.
> 
> This should mention it can only be used with iommu_group_set_dma_owner()

Sure.

> 
>> +	if (old)
>> +		__iommu_detach_group(old, group);
>> +
>> +	if (new) {
>> +		ret = __iommu_attach_group(new, group);
>> +		if (ret && old)
>> +			__iommu_attach_group(old, group);
>> +	}
> 
> The sketchy error unwind here gives me some pause for sure. Maybe we
> should define that on error this leaves the domain as NULL
> 
> Complicates vfio a tiny bit to cope with this failure but seems
> cleaner than leaving it indeterminate.

Fair enough.

> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
