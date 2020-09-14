Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56657C43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 03:08:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5876208FE
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 03:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5876208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6CFD7204FD;
	Mon, 14 Sep 2020 03:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9tU2t1+H8yOi; Mon, 14 Sep 2020 03:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0B87C20426;
	Mon, 14 Sep 2020 03:08:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D07CBC088B;
	Mon, 14 Sep 2020 03:08:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1669C0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 03:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BC27987119
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 03:08:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nhp81knGpSuD for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 03:08:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D885F87093
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 03:08:20 +0000 (UTC)
IronPort-SDR: gDqZCaI/+ITeExxspeQ9eArLeVv0b3VR6h/HdvSHLbaFVmc9jYqfjfa1wBmfBHBNT+KaLNmr1E
 qfkeFo03GPGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="146711886"
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; d="scan'208";a="146711886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 20:08:20 -0700
IronPort-SDR: MM5/sFSifKGqGPPL5Uqo4zu6Mz4fdHmevk1+AaGj0Csw64JOdeOSEMSWn24AFq1rwcg9CWswTx
 e8b1YEkqRZ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; d="scan'208";a="408731471"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2020 20:08:16 -0700
Subject: Re: [PATCH v4 2/5] iommu: Add iommu_at(de)tach_subdev_group()
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200901033422.22249-1-baolu.lu@linux.intel.com>
 <20200901033422.22249-3-baolu.lu@linux.intel.com>
 <20200910160547.0a8b9891@w520.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <01d80e65-c372-4944-753f-454a190a8cd0@linux.intel.com>
Date: Mon, 14 Sep 2020 11:02:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910160547.0a8b9891@w520.home>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

Hi Alex,

On 9/11/20 6:05 AM, Alex Williamson wrote:
> On Tue,  1 Sep 2020 11:34:19 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> This adds two new APIs for the use cases like vfio/mdev where subdevices
>> derived from physical devices are created and put in an iommu_group. The
>> new IOMMU API interfaces mimic the vfio_mdev_at(de)tach_domain() directly,
>> testing whether the resulting device supports IOMMU_DEV_FEAT_AUX and using
>> an aux vs non-aux at(de)tach.
>>
>> By doing this we could
>>
>> - Set the iommu_group.domain. The iommu_group.domain is private to iommu
>>    core (therefore vfio code cannot set it), but we need it set in order
>>    for iommu_get_domain_for_dev() to work with a group attached to an aux
>>    domain.
>>
>> - Prefer to use the _attach_group() interfaces while the _attach_device()
>>    interfaces are relegated to special cases.
>>
>> Link: https://lore.kernel.org/linux-iommu/20200730134658.44c57a67@x1.home/
>> Link: https://lore.kernel.org/linux-iommu/20200730151703.5daf8ad4@x1.home/
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 136 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/iommu.h |  20 +++++++
>>   2 files changed, 156 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 38cdfeb887e1..fb21c2ff4861 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2757,6 +2757,142 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>>   
>> +static int __iommu_aux_attach_device(struct iommu_domain *domain,
>> +				     struct device *phys_dev,
>> +				     struct device *sub_dev)
>> +{
>> +	int ret;
>> +
>> +	if (unlikely(!domain->ops->aux_attach_dev))
>> +		return -ENODEV;
>> +
>> +	ret = domain->ops->aux_attach_dev(domain, phys_dev, sub_dev);
>> +	if (!ret)
>> +		trace_attach_device_to_domain(sub_dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static void __iommu_aux_detach_device(struct iommu_domain *domain,
>> +				      struct device *phys_dev,
>> +				      struct device *sub_dev)
>> +{
>> +	if (unlikely(!domain->ops->aux_detach_dev))
>> +		return;
>> +
>> +	domain->ops->aux_detach_dev(domain, phys_dev, sub_dev);
>> +	trace_detach_device_from_domain(sub_dev);
>> +}
>> +
>> +static int __iommu_attach_subdev_group(struct iommu_domain *domain,
>> +				       struct iommu_group *group,
>> +				       iommu_device_lookup_t fn)
>> +{
>> +	struct group_device *device;
>> +	struct device *phys_dev;
>> +	int ret = -ENODEV;
>> +
>> +	list_for_each_entry(device, &group->devices, list) {
>> +		phys_dev = fn(device->dev);
>> +		if (!phys_dev) {
>> +			ret = -ENODEV;
>> +			break;
>> +		}
>> +
>> +		if (iommu_dev_feature_enabled(phys_dev, IOMMU_DEV_FEAT_AUX))
>> +			ret = __iommu_aux_attach_device(domain, phys_dev,
>> +							device->dev);
>> +		else
>> +			ret = __iommu_attach_device(domain, phys_dev);
>> +
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void __iommu_detach_subdev_group(struct iommu_domain *domain,
>> +					struct iommu_group *group,
>> +					iommu_device_lookup_t fn)
>> +{
>> +	struct group_device *device;
>> +	struct device *phys_dev;
>> +
>> +	list_for_each_entry(device, &group->devices, list) {
>> +		phys_dev = fn(device->dev);
>> +		if (!phys_dev)
>> +			break;
> 
> 
> Seems like this should be a continue rather than a break.  On the
> unwind path maybe we're relying on holding the group mutex and
> deterministic behavior from the fn() callback to unwind to the same
> point, but we still have an entirely separate detach interface and I'm
> not sure we couldn't end up with an inconsistent state if we don't
> iterate each group device here.  Thanks,

Yes, agreed.

Best regards,
baolu

> 
> Alex
> 
>> +
>> +		if (iommu_dev_feature_enabled(phys_dev, IOMMU_DEV_FEAT_AUX))
>> +			__iommu_aux_detach_device(domain, phys_dev, device->dev);
>> +		else
>> +			__iommu_detach_device(domain, phys_dev);
>> +	}
>> +}
>> +
>> +/**
>> + * iommu_attach_subdev_group - attach domain to an iommu_group which
>> + *			       contains subdevices.
>> + *
>> + * @domain: domain
>> + * @group:  iommu_group which contains subdevices
>> + * @fn:     callback for each subdevice in the @iommu_group to retrieve the
>> + *          physical device where the subdevice was created from.
>> + *
>> + * Returns 0 on success, or an error value.
>> + */
>> +int iommu_attach_subdev_group(struct iommu_domain *domain,
>> +			      struct iommu_group *group,
>> +			      iommu_device_lookup_t fn)
>> +{
>> +	int ret = -ENODEV;
>> +
>> +	mutex_lock(&group->mutex);
>> +	if (group->domain) {
>> +		ret = -EBUSY;
>> +		goto unlock_out;
>> +	}
>> +
>> +	ret = __iommu_attach_subdev_group(domain, group, fn);
>> +	if (ret)
>> +		__iommu_detach_subdev_group(domain, group, fn);
>> +	else
>> +		group->domain = domain;
>> +
>> +unlock_out:
>> +	mutex_unlock(&group->mutex);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_attach_subdev_group);
>> +
>> +/**
>> + * iommu_detach_subdev_group - detach domain from an iommu_group which
>> + *			       contains subdevices
>> + *
>> + * @domain: domain
>> + * @group:  iommu_group which contains subdevices
>> + * @fn:     callback for each subdevice in the @iommu_group to retrieve the
>> + *          physical device where the subdevice was created from.
>> + *
>> + * The domain must have been attached to @group via iommu_attach_subdev_group().
>> + */
>> +void iommu_detach_subdev_group(struct iommu_domain *domain,
>> +			       struct iommu_group *group,
>> +			       iommu_device_lookup_t fn)
>> +{
>> +	mutex_lock(&group->mutex);
>> +	if (!group->domain)
>> +		goto unlock_out;
>> +
>> +	__iommu_detach_subdev_group(domain, group, fn);
>> +	group->domain = NULL;
>> +
>> +unlock_out:
>> +	mutex_unlock(&group->mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_detach_subdev_group);
>> +
>>   /**
>>    * iommu_sva_bind_device() - Bind a process address space to a device
>>    * @dev: the device
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 871267104915..b9df8b510d4f 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -48,6 +48,7 @@ struct iommu_fault_event;
>>   typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>>   			struct device *, unsigned long, int, void *);
>>   typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
>> +typedef struct device *(*iommu_device_lookup_t)(struct device *);
>>   
>>   struct iommu_domain_geometry {
>>   	dma_addr_t aperture_start; /* First address that can be mapped    */
>> @@ -631,6 +632,12 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
>>   int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev);
>>   void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
>>   int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
>> +int iommu_attach_subdev_group(struct iommu_domain *domain,
>> +			      struct iommu_group *group,
>> +			      iommu_device_lookup_t fn);
>> +void iommu_detach_subdev_group(struct iommu_domain *domain,
>> +			       struct iommu_group *group,
>> +			       iommu_device_lookup_t fn);
>>   
>>   struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>>   					struct mm_struct *mm,
>> @@ -1019,6 +1026,19 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>>   	return -ENODEV;
>>   }
>>   
>> +static inline int
>> +iommu_attach_subdev_group(struct iommu_domain *domain, struct iommu_group *group,
>> +			  iommu_device_lookup_t fn)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void
>> +iommu_detach_subdev_group(struct iommu_domain *domain, struct iommu_group *group,
>> +			  iommu_device_lookup_t fn)
>> +{
>> +}
>> +
>>   static inline struct iommu_sva *
>>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>>   {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
