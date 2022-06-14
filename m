Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A009C43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 07:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36FFF60F02;
	Tue, 14 Jun 2022 07:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Cab6MmrF0DN; Tue, 14 Jun 2022 07:16:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CC8AC60EF6;
	Tue, 14 Jun 2022 07:16:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AF20C0032;
	Tue, 14 Jun 2022 07:16:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E6B4C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2D004157F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HXBJ2FkStctj for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 07:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A36EF4155B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655190967; x=1686726967;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NHeKt8AVVuoNMGzSRtkrNqEDEEKj+JEu5vZWp4ee3Qg=;
 b=SO3vFHa1o79Up9AKFx4YE+hfaeuO+fRhYxIqmlSwVMoaBtCD8/ry7snG
 I2QspiDJBYw1rcIvOxSJr/ZEwPA28skyJcX9m2+VJXzeORloqEhCCrplm
 Np84J9+XGHBvaiwChG26by61TkWX30eWKoPIWsWXZ8Jk/BKzpKUII0pwE
 xbJ/30hjxPZGFk5fj/y+mKGiGDX8IVeWum9IIxbJ33JAneTChCMu8N9HU
 huAvl/9CY8fLGreyQ3oEHGCrIe34R0UpvujsyERiCmW34gqhCSXg+sifY
 iYrDRVh0VdcKV9HN8ph+LqFv91sPzlkjCOAnks5XzIqt8QLtVdYe3pn+a Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277312913"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="277312913"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:15:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="910834149"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:15:50 -0700
Message-ID: <1161fe02-7dbb-6f97-39c0-a84be016e0a9@linux.intel.com>
Date: Tue, 14 Jun 2022 15:15:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 01/12] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527680C1957C0E29E8AE85168CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527680C1957C0E29E8AE85168CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

Hi Kevin,

Thanks for your reviewing.

On 2022/6/14 14:43, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 10:51 AM
>>
>> The domain_translation_struct debugfs node is used to dump the DMAR
>> page
>> tables for the PCI devices. It potentially races with setting domains to
>> devices. The existing code uses a global spinlock device_domain_lock to
>> avoid the races, but this is problematical as this lock is only used to
>> protect the device tracking lists of each domain.
> 
> is it really problematic at this point? Before following patches are applied
> using device_domain_lock should have similar effect as holding the group
> lock.

The device_domain_lock only protects the device tracking list of the
domain, it doesn't include the domain pointer stored in the dev_info
structure. That's really protected by the group->mutex.

> 
> Here it might make more sense to just focus on removing the use of
> device_domain_lock outside of iommu.c. Just that using group lock is
> cleaner and more compatible to following cleanups.

Fair enough. I will update the commit message with above statement.

> and it's worth mentioning that racing with page table updates is out
> of the scope of this series. Probably also add a comment in the code
> to clarify this point.

Sure.

> 
>>
>> This replaces device_domain_lock with group->mutex to protect page tables
>> from setting a new domain. This also makes device_domain_lock static as
>> it is now only used inside the file.
> 
> s/the file/iommu.c/

Sure.

> 
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h   |  1 -
>>   drivers/iommu/intel/debugfs.c | 49 +++++++++++++++++++++++++----------
>>   drivers/iommu/intel/iommu.c   |  2 +-
>>   3 files changed, 36 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index a22adfbdf870..8a6d64d726c0 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -480,7 +480,6 @@ enum {
>>   #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
>>
>>   extern int intel_iommu_sm;
>> -extern spinlock_t device_domain_lock;
>>
>>   #define sm_supported(iommu)	(intel_iommu_sm &&
>> ecap_smts((iommu)->ecap))
>>   #define pasid_supported(iommu)	(sm_supported(iommu) &&
>> 		\
>> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
>> index d927ef10641b..5ebfe32265d5 100644
>> --- a/drivers/iommu/intel/debugfs.c
>> +++ b/drivers/iommu/intel/debugfs.c
>> @@ -342,15 +342,23 @@ static void pgtable_walk_level(struct seq_file *m,
>> struct dma_pte *pde,
>>   	}
>>   }
>>
>> -static int show_device_domain_translation(struct device *dev, void *data)
>> +struct show_domain_opaque {
>> +	struct device *dev;
>> +	struct seq_file *m;
>> +};
> 
> Sounds redundant as both bus_for_each_dev() and
> iommu_group_for_each_dev() declares the same fn type which
> accepts a device pointer and void *data.
> 
>> +
>> +static int __show_device_domain_translation(struct device *dev, void *data)
>>   {
>> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> -	struct dmar_domain *domain = info->domain;
>> -	struct seq_file *m = data;
>> +	struct show_domain_opaque *opaque = data;
>> +	struct device_domain_info *info;
>> +	struct seq_file *m = opaque->m;
>> +	struct dmar_domain *domain;
>>   	u64 path[6] = { 0 };
>>
>> -	if (!domain)
>> +	if (dev != opaque->dev)
>>   		return 0;
> 
> not required.

Together with above comment.

The iommu group might have other devices. I only want to dump the domain
of the secific @opaque->dev. It reads a bit confusing, but it's the
only helper I can use outside of drivers/iommu/iommu.c.

Or, since all devices in the iommu group share the same domain, hence
only dump once?

> 
>> +	info = dev_iommu_priv_get(dev);
>> +	domain = info->domain;
>>
>>   	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
>>   		   (u64)virt_to_phys(domain->pgd));
>> @@ -359,20 +367,33 @@ static int show_device_domain_translation(struct
>> device *dev, void *data)
>>   	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
>>   	seq_putc(m, '\n');
>>
>> -	return 0;
>> +	return 1;
>>   }
>>
>> -static int domain_translation_struct_show(struct seq_file *m, void *unused)
>> +static int show_device_domain_translation(struct device *dev, void *data)
>>   {
>> -	unsigned long flags;
>> -	int ret;
>> +	struct show_domain_opaque opaque = {dev, data};
>> +	struct iommu_group *group;
>>
>> -	spin_lock_irqsave(&device_domain_lock, flags);
>> -	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
>> -			       show_device_domain_translation);
>> -	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +	group = iommu_group_get(dev);
>> +	if (group) {
>> +		/*
>> +		 * The group->mutex is held across the callback, which will
>> +		 * block calls to iommu_attach/detach_group/device. Hence,
>> +		 * the domain of the device will not change during traversal.
>> +		 */
>> +		iommu_group_for_each_dev(group, &opaque,
>> +					 __show_device_domain_translation);
>> +		iommu_group_put(group);
>> +	}
>>
>> -	return ret;
>> +	return 0;
>> +}
>> +
>> +static int domain_translation_struct_show(struct seq_file *m, void *unused)
>> +{
>> +	return bus_for_each_dev(&pci_bus_type, NULL, m,
>> +				show_device_domain_translation);
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 19024dc52735..a39d72a9d1cf 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -314,7 +314,7 @@ static int iommu_skip_te_disable;
>>   #define IDENTMAP_GFX		2
>>   #define IDENTMAP_AZALIA		4
>>
>> -DEFINE_SPINLOCK(device_domain_lock);
>> +static DEFINE_SPINLOCK(device_domain_lock);
>>   static LIST_HEAD(device_domain_list);
>>
>>   /*
>> --
>> 2.25.1
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
