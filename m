Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B285C433E1
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 01:12:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C961320791
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 01:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C961320791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9DEB487DFF;
	Thu, 16 Jul 2020 01:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9th1HPvYTYza; Thu, 16 Jul 2020 01:12:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 00FA087E16;
	Thu, 16 Jul 2020 01:12:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE175C0891;
	Thu, 16 Jul 2020 01:12:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 301B8C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 01:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2C20387E16
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 01:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yQzvutVS_t6d for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 01:12:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 747AF87DFF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 01:12:28 +0000 (UTC)
IronPort-SDR: AkXJB7wU4s65AXBleUuboEM9s6qmzTfnKt1MA1JkoiO7wtiaxs8NctV1PfKEbXBPgXyINegqWe
 2qVFD8kuEiUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="148448759"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; d="scan'208";a="148448759"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 18:12:26 -0700
IronPort-SDR: GhBuvpJerEQSGZCcQwjV6esXaMp0MVHcttK2IMF8/qwgeeLs4waGLsGO+L6VICx8W1I+0Eonmq
 4vlc+KAEaZbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; d="scan'208";a="460289202"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by orsmga005.jf.intel.com with ESMTP; 15 Jul 2020 18:12:23 -0700
Subject: Re: [PATCH v3 2/4] iommu: Add iommu_aux_at(de)tach_group()
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-3-baolu.lu@linux.intel.com>
 <20200714093909.1ab93c9e@jacob-builder>
 <b5b22e01-4a51-8dfe-9ba4-aeca783740f1@linux.intel.com>
 <20200715090114.50a459d4@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <435a2014-c2e8-06b9-3c9a-4afbf6607ffe@linux.intel.com>
Date: Thu, 16 Jul 2020 09:07:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200715090114.50a459d4@jacob-builder>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>,
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

Hi Jacob,

On 7/16/20 12:01 AM, Jacob Pan wrote:
> On Wed, 15 Jul 2020 08:47:36 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Jacob,
>>
>> On 7/15/20 12:39 AM, Jacob Pan wrote:
>>> On Tue, 14 Jul 2020 13:57:01 +0800
>>> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>    
>>>> This adds two new aux-domain APIs for a use case like vfio/mdev
>>>> where sub-devices derived from an aux-domain capable device are
>>>> created and put in an iommu_group.
>>>>
>>>> /**
>>>>    * iommu_aux_attach_group - attach an aux-domain to an iommu_group
>>>> which
>>>>    *                          contains sub-devices (for example
>>>> mdevs) derived
>>>>    *                          from @dev.
>>>>    * @domain: an aux-domain;
>>>>    * @group:  an iommu_group which contains sub-devices derived from
>>>> @dev;
>>>>    * @dev:    the physical device which supports IOMMU_DEV_FEAT_AUX.
>>>>    *
>>>>    * Returns 0 on success, or an error value.
>>>>    */
>>>> int iommu_aux_attach_group(struct iommu_domain *domain,
>>>>                              struct iommu_group *group,
>>>>                              struct device *dev)
>>>>
>>>> /**
>>>>    * iommu_aux_detach_group - detach an aux-domain from an
>>>> iommu_group *
>>>>    * @domain: an aux-domain;
>>>>    * @group:  an iommu_group which contains sub-devices derived from
>>>> @dev;
>>>>    * @dev:    the physical device which supports IOMMU_DEV_FEAT_AUX.
>>>>    *
>>>>    * @domain must have been attached to @group via
>>>> iommu_aux_attach_group(). */
>>>> void iommu_aux_detach_group(struct iommu_domain *domain,
>>>>                               struct iommu_group *group,
>>>>                               struct device *dev)
>>>>
>>>> It also adds a flag in the iommu_group data structure to identify
>>>> an iommu_group with aux-domain attached from those normal ones.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/iommu.c | 58
>>>> +++++++++++++++++++++++++++++++++++++++++++ include/linux/iommu.h |
>>>> 17 +++++++++++++ 2 files changed, 75 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index e1fdd3531d65..cad5a19ebf22 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -45,6 +45,7 @@ struct iommu_group {
>>>>    	struct iommu_domain *default_domain;
>>>>    	struct iommu_domain *domain;
>>>>    	struct list_head entry;
>>>> +	unsigned int aux_domain_attached:1;
>>>>    };
>>>>    
>>>>    struct group_device {
>>>> @@ -2759,6 +2760,63 @@ int iommu_aux_get_pasid(struct iommu_domain
>>>> *domain, struct device *dev) }
>>>>    EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>>>>    
>>>> +/**
>>>> + * iommu_aux_attach_group - attach an aux-domain to an iommu_group
>>>> which
>>>> + *                          contains sub-devices (for example
>>>> mdevs) derived
>>>> + *                          from @dev.
>>>> + * @domain: an aux-domain;
>>>> + * @group:  an iommu_group which contains sub-devices derived from
>>>> @dev;
>>>> + * @dev:    the physical device which supports IOMMU_DEV_FEAT_AUX.
>>>> + *
>>>> + * Returns 0 on success, or an error value.
>>>> + */
>>>> +int iommu_aux_attach_group(struct iommu_domain *domain,
>>>> +			   struct iommu_group *group, struct
>>>> device *dev) +{
>>>> +	int ret = -EBUSY;
>>>> +
>>>> +	mutex_lock(&group->mutex);
>>>> +	if (group->domain)
>>>> +		goto out_unlock;
>>>> +
>>> Perhaps I missed something but are we assuming only one mdev per
>>> mdev group? That seems to change the logic where vfio does:
>>> iommu_group_for_each_dev()
>>> 	iommu_aux_attach_device()
>>>    
>>
>> It has been changed in PATCH 4/4:
>>
>> static int vfio_iommu_attach_group(struct vfio_domain *domain,
>>                                      struct vfio_group *group)
>> {
>>           if (group->mdev_group)
>>                   return iommu_aux_attach_group(domain->domain,
>>                                                 group->iommu_group,
>>                                                 group->iommu_device);
>>           else
>>                   return iommu_attach_group(domain->domain,
>> group->iommu_group);
>> }
>>
>> So, for both normal domain and aux-domain, we use the same concept:
>> attach a domain to a group.
>>
> I get that, but don't you have to attach all the devices within the

This iommu_group includes only mediated devices derived from an
IOMMU_DEV_FEAT_AUX-capable device. Different from iommu_attach_group(),
iommu_aux_attach_group() doesn't need to attach the domain to each
device in group, instead it only needs to attach the domain to the
physical device where the mdev's were created from.

> group? Here you see the group already has a domain and exit.

If the (group->domain) has been set, that means a domain has already
attached to the group, so it returns -EBUSY.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
