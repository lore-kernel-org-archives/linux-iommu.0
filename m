Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC145C433DF
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 05:48:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A84C2074B
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 05:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A84C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 661D68840B;
	Fri, 31 Jul 2020 05:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id azF1xM+VL0nQ; Fri, 31 Jul 2020 05:48:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C3EA788524;
	Fri, 31 Jul 2020 05:48:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B095CC004F;
	Fri, 31 Jul 2020 05:48:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A7B4C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 05:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 08B7E88622
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 05:48:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1QWQ7iz7TuIb for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 05:48:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D93D2883B0
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 05:48:03 +0000 (UTC)
IronPort-SDR: rg9p+3Yy4PHWLkr5rrnHhS7EVHjuKZXSOovSPKnjYTDGHdWRdge5shOyCAPh7IJZ7X97SUWnVX
 oPY5Kf0yUMvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131805397"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; d="scan'208";a="131805397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 22:48:03 -0700
IronPort-SDR: wCr5ZzFnwvkvJgofOohJJ48Ou5YW3fFQYYYofvVd/lgluVGgosmiH9Rip/KJOiyMWSowQSX2fK
 8TBlxqJ/EhNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; d="scan'208";a="321309207"
Received: from daisygao-mobl.ccr.corp.intel.com (HELO [10.254.211.68])
 ([10.254.211.68])
 by orsmga008.jf.intel.com with ESMTP; 30 Jul 2020 22:47:58 -0700
Subject: Re: [PATCH v3 2/4] iommu: Add iommu_aux_at(de)tach_group()
To: Alex Williamson <alex.williamson@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-3-baolu.lu@linux.intel.com>
 <20200714093909.1ab93c9e@jacob-builder>
 <b5b22e01-4a51-8dfe-9ba4-aeca783740f1@linux.intel.com>
 <20200715090114.50a459d4@jacob-builder>
 <435a2014-c2e8-06b9-3c9a-4afbf6607ffe@linux.intel.com>
 <20200729140336.09d2bfe7@x1.home>
 <MWHPR11MB16454283959A365ED7964C488C700@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200730134658.44c57a67@x1.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3e252771-b1ed-a9fc-b179-97c8f280c526@linux.intel.com>
Date: Fri, 31 Jul 2020 13:47:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730134658.44c57a67@x1.home>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

Hi Alex,

On 2020/7/31 3:46, Alex Williamson wrote:
> On Wed, 29 Jul 2020 23:34:40 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
>>> From: Alex Williamson <alex.williamson@redhat.com>
>>> Sent: Thursday, July 30, 2020 4:04 AM
>>>
>>> On Thu, 16 Jul 2020 09:07:46 +0800
>>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>    
>>>> Hi Jacob,
>>>>
>>>> On 7/16/20 12:01 AM, Jacob Pan wrote:
>>>>> On Wed, 15 Jul 2020 08:47:36 +0800
>>>>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>>   
>>>>>> Hi Jacob,
>>>>>>
>>>>>> On 7/15/20 12:39 AM, Jacob Pan wrote:
>>>>>>> On Tue, 14 Jul 2020 13:57:01 +0800
>>>>>>> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>>>>>   
>>>>>>>> This adds two new aux-domain APIs for a use case like vfio/mdev
>>>>>>>> where sub-devices derived from an aux-domain capable device are
>>>>>>>> created and put in an iommu_group.
>>>>>>>>
>>>>>>>> /**
>>>>>>>>     * iommu_aux_attach_group - attach an aux-domain to an
>>> iommu_group
>>>>>>>> which
>>>>>>>>     *                          contains sub-devices (for example
>>>>>>>> mdevs) derived
>>>>>>>>     *                          from @dev.
>>>>>>>>     * @domain: an aux-domain;
>>>>>>>>     * @group:  an iommu_group which contains sub-devices derived
>>> from
>>>>>>>> @dev;
>>>>>>>>     * @dev:    the physical device which supports
>>> IOMMU_DEV_FEAT_AUX.
>>>>>>>>     *
>>>>>>>>     * Returns 0 on success, or an error value.
>>>>>>>>     */
>>>>>>>> int iommu_aux_attach_group(struct iommu_domain *domain,
>>>>>>>>                               struct iommu_group *group,
>>>>>>>>                               struct device *dev)
>>>>>>>>
>>>>>>>> /**
>>>>>>>>     * iommu_aux_detach_group - detach an aux-domain from an
>>>>>>>> iommu_group *
>>>>>>>>     * @domain: an aux-domain;
>>>>>>>>     * @group:  an iommu_group which contains sub-devices derived
>>> from
>>>>>>>> @dev;
>>>>>>>>     * @dev:    the physical device which supports
>>> IOMMU_DEV_FEAT_AUX.
>>>>>>>>     *
>>>>>>>>     * @domain must have been attached to @group via
>>>>>>>> iommu_aux_attach_group(). */
>>>>>>>> void iommu_aux_detach_group(struct iommu_domain *domain,
>>>>>>>>                                struct iommu_group *group,
>>>>>>>>                                struct device *dev)
>>>>>>>>
>>>>>>>> It also adds a flag in the iommu_group data structure to identify
>>>>>>>> an iommu_group with aux-domain attached from those normal ones.
>>>>>>>>
>>>>>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>>>>>> ---
>>>>>>>>     drivers/iommu/iommu.c | 58
>>>>>>>> +++++++++++++++++++++++++++++++++++++++++++
>>> include/linux/iommu.h |
>>>>>>>> 17 +++++++++++++ 2 files changed, 75 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>>>>> index e1fdd3531d65..cad5a19ebf22 100644
>>>>>>>> --- a/drivers/iommu/iommu.c
>>>>>>>> +++ b/drivers/iommu/iommu.c
>>>>>>>> @@ -45,6 +45,7 @@ struct iommu_group {
>>>>>>>>     	struct iommu_domain *default_domain;
>>>>>>>>     	struct iommu_domain *domain;
>>>>>>>>     	struct list_head entry;
>>>>>>>> +	unsigned int aux_domain_attached:1;
>>>>>>>>     };
>>>>>>>>
>>>>>>>>     struct group_device {
>>>>>>>> @@ -2759,6 +2760,63 @@ int iommu_aux_get_pasid(struct
>>> iommu_domain
>>>>>>>> *domain, struct device *dev) }
>>>>>>>>     EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * iommu_aux_attach_group - attach an aux-domain to an
>>> iommu_group
>>>>>>>> which
>>>>>>>> + *                          contains sub-devices (for example
>>>>>>>> mdevs) derived
>>>>>>>> + *                          from @dev.
>>>>>>>> + * @domain: an aux-domain;
>>>>>>>> + * @group:  an iommu_group which contains sub-devices derived
>>> from
>>>>>>>> @dev;
>>>>>>>> + * @dev:    the physical device which supports
>>> IOMMU_DEV_FEAT_AUX.
>>>>>>>> + *
>>>>>>>> + * Returns 0 on success, or an error value.
>>>>>>>> + */
>>>>>>>> +int iommu_aux_attach_group(struct iommu_domain *domain,
>>>>>>>> +			   struct iommu_group *group, struct
>>>>>>>> device *dev) +{
>>>>>>>> +	int ret = -EBUSY;
>>>>>>>> +
>>>>>>>> +	mutex_lock(&group->mutex);
>>>>>>>> +	if (group->domain)
>>>>>>>> +		goto out_unlock;
>>>>>>>> +
>>>>>>> Perhaps I missed something but are we assuming only one mdev per
>>>>>>> mdev group? That seems to change the logic where vfio does:
>>>>>>> iommu_group_for_each_dev()
>>>>>>> 	iommu_aux_attach_device()
>>>>>>>   
>>>>>>
>>>>>> It has been changed in PATCH 4/4:
>>>>>>
>>>>>> static int vfio_iommu_attach_group(struct vfio_domain *domain,
>>>>>>                                       struct vfio_group *group)
>>>>>> {
>>>>>>            if (group->mdev_group)
>>>>>>                    return iommu_aux_attach_group(domain->domain,
>>>>>>                                                  group->iommu_group,
>>>>>>                                                  group->iommu_device);
>>>>>>            else
>>>>>>                    return iommu_attach_group(domain->domain,
>>>>>> group->iommu_group);
>>>>>> }
>>>>>>
>>>>>> So, for both normal domain and aux-domain, we use the same concept:
>>>>>> attach a domain to a group.
>>>>>>   
>>>>> I get that, but don't you have to attach all the devices within the
>>>>
>>>> This iommu_group includes only mediated devices derived from an
>>>> IOMMU_DEV_FEAT_AUX-capable device. Different from
>>> iommu_attach_group(),
>>>> iommu_aux_attach_group() doesn't need to attach the domain to each
>>>> device in group, instead it only needs to attach the domain to the
>>>> physical device where the mdev's were created from.
>>>>   
>>>>> group? Here you see the group already has a domain and exit.
>>>>
>>>> If the (group->domain) has been set, that means a domain has already
>>>> attached to the group, so it returns -EBUSY.
>>>
>>> I agree with Jacob, singleton groups should not be built into the IOMMU
>>> API, we're not building an interface just for mdevs or current
>>> limitations of mdevs.  This also means that setting a flag on the group
>>> and passing a device that's assumed to be common for all devices within
>>> the group, don't really make sense here.  Thanks,
>>>
>>> Alex
>>
>> Baolu and I discussed about this assumption before. The assumption is
>> not based on singleton groups. We do consider multiple mdevs in one
>> group. But our feeling at the moment is that all mdevs (or other AUX
>> derivatives) in the same group should come from the same parent
>> device, thus comes with above design. Does it sound a reasonable
>> assumption to you?
> 
> No, the approach in this series doesn't really make sense to me.  We
> currently have the following workflow as Baolu notes in the cover
> letter:
> 
> 	domain = iommu_domain_alloc(bus);
> 
> 	iommu_group_for_each_dev(group...
> 
> 		iommu_device = mdev-magic()
> 
> 		if (iommu_dev_feature_enabled(iommu_device,
> 						IOMMU_DEV_FEAT_AUX))
> 			iommu_aux_attach_device(domain, iommu_device);
> 
> And we want to convert this to a group function, like we have for
> non-aux domains:
> 
> 	domain = iommu_domain_alloc(bus);
> 
> 	iommu_device = mdev-magic()
> 
> 	iommu_aux_attach_group(domain, group, iommu_device);
> 
> And I think we want to do that largely because iommu_group.domain is
> private to iommu.c (therefore vfio code cannot set it), but we need it
> set in order for iommu_get_domain_for_dev() to work with a group
> attached to an aux domain.  Passing an iommu_device avoids the problem
> that IOMMU API code doesn't know how to derive an iommu_device for each
> device in the group, but while doing so it ignores the fundamental
> nature of a group as being a set of one or more devices.  Even if we
> can make the leap that all devices within the group would use the same
> iommu_device, an API that sets and aux domain for a group while
> entirely ignoring the devices within the group seems very broken.

Agreed. We couldn't assume that all devices in an iommu group shares a
same iommu_device, especially when it comes to PF/VF wrapped mediated
device case.

> 
> So, barring adding an abstraction at struct device where an IOMMU API
> could retrieve the iommu_device backing anther device (which seems a
> very abstract concept for the base class), why not have the caller
> provide a lookup function?  Ex:
> 
> int iommu_aux_attach_group(struct iommu_domain *domain,
> 			   struct iommu_group *group,
> 			   struct device *(*iommu_device_lookup)(
> 				struct device *dev));
> 
> Thus vfio could could simply provide &vfio_mdev_get_iommu_device and
> we'd have equivalent functionality to what we have currently, but with
> the domain pointer set in the iommu_group.

This looks good to me.

> 
> This also however highlights that our VF backed mdevs will have the
> same issue, so maybe this new IOMMU API interface should mimic
> vfio_mdev_attach_domain() more directly, testing whether the resulting
> device supports IOMMU_DEV_FEAT_AUX and using an aux vs non-aux attach.
> I'm not sure what the name of this combined function should be,
> iommu_attach_group_with_lookup()?  This could be the core
> implementation of iommu_attach_group() where the existing function
> simply wraps the call with a NULL function pointer.
> 
> Anyway, I think there are ways to implement this that are more in line
> with the spirit of groups.

Another possible implementation, just for discussion purpose:

1. Add a member in group_device to save the iommu_device if it exists:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b6858adc4f17..6474e82cf4b4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -47,9 +47,16 @@ struct iommu_group {
         struct list_head entry;
  };

+/*
+ * dma_alias: The device put in this group might depends on another
+ *            physical device to do the DMA remapping. At(de)taching
+ *            the domain to/from @dma_alias instead of @dev if
+ *            @dma_alias is set.
+ */
  struct group_device {
         struct list_head list;
         struct device *dev;
+       struct device *dma_alias;
         char *name;
  };

2. Pass in the iommu_device when calling iommu_group_add_device().

int iommu_group_add_device(struct iommu_group *group,
                            struct device *dev,
                            struct device *dma_alias)

Hence, the iommu core could get a chance to set the iommu_device in the
group device.

3. Mimic vfio_mdev_attach_domain() logic in iommu_group_do_attach_device():

if (group->dma_alias) {
	if (iommu_dev_feature_enabled(group->dma_alias, IOMMU_DEV_FEAT_AUX))
		iommu_aux_attach_device(domain, group->dma_alias);
	else
		__iommu_attach_device(domain, group->dma_alias);
} else {
	__iommu_attach_device(domain, dev);
}

One limitation is that the driver should call mdev_set_iommu_device()
before the mdev_probe() get called.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
