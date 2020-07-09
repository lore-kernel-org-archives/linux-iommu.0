Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F01C433DF
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 00:41:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA62D206DF
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 00:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA62D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B12CB887C0;
	Thu,  9 Jul 2020 00:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xENk4tzePxPp; Thu,  9 Jul 2020 00:41:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A84388729;
	Thu,  9 Jul 2020 00:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44315C077B;
	Thu,  9 Jul 2020 00:41:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF823C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 00:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9E06021FFB
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 00:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TMV9jlj29AHD for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 00:41:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id A7D452094C
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 00:41:42 +0000 (UTC)
IronPort-SDR: Po5CmdbveNGkcdlFdBAZS9o+h5Be7QxLphzODacnidEZcJc36DEUVS3sRZge6HJdlwYXfWeQ5K
 278eEwIJOicw==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="146994315"
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; d="scan'208";a="146994315"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 17:41:41 -0700
IronPort-SDR: uFYAuuFAEeKqUbfSVzwhGtPX1KZ8Z0GGOB6JqZTlsOu0uIlRAMezTlwtEZlfmko2Zj5RIF0TLo
 tk/URUk9oIQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; d="scan'208";a="457700177"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by orsmga005.jf.intel.com with ESMTP; 08 Jul 2020 17:41:38 -0700
Subject: Re: [PATCH v2 1/2] iommu: iommu_aux_at(de)tach_device() extension
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200707013957.23672-1-baolu.lu@linux.intel.com>
 <20200707013957.23672-2-baolu.lu@linux.intel.com>
 <20200707150408.474d81f1@x1.home>
 <dc98a109-7121-36b7-0854-f899b09692a4@linux.intel.com>
 <20200708130749.1b1e1421@x1.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f1946060-d01c-70d2-7dd5-7730694a4d46@linux.intel.com>
Date: Thu, 9 Jul 2020 08:37:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708130749.1b1e1421@x1.home>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
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

On 7/9/20 3:07 AM, Alex Williamson wrote:
> On Wed, 8 Jul 2020 10:53:12 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Alex,
>>
>> Thanks a lot for your comments. Please check my reply inline.
>>
>> On 7/8/20 5:04 AM, Alex Williamson wrote:
>>> On Tue,  7 Jul 2020 09:39:56 +0800
>>> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>    
>>>> The hardware assistant vfio mediated device is a use case of iommu
>>>> aux-domain. The interactions between vfio/mdev and iommu during mdev
>>>> creation and passthr are:
>>>>
>>>> - Create a group for mdev with iommu_group_alloc();
>>>> - Add the device to the group with
>>>>           group = iommu_group_alloc();
>>>>           if (IS_ERR(group))
>>>>                   return PTR_ERR(group);
>>>>
>>>>           ret = iommu_group_add_device(group, &mdev->dev);
>>>>           if (!ret)
>>>>                   dev_info(&mdev->dev, "MDEV: group_id = %d\n",
>>>>                            iommu_group_id(group));
>>>> - Allocate an aux-domain
>>>>           iommu_domain_alloc()
>>>> - Attach the aux-domain to the physical device from which the mdev is
>>>>     created.
>>>>           iommu_aux_attach_device()
>>>>
>>>> In the whole process, an iommu group was allocated for the mdev and an
>>>> iommu domain was attached to the group, but the group->domain leaves
>>>> NULL. As the result, iommu_get_domain_for_dev() doesn't work anymore.
>>>>
>>>> The iommu_get_domain_for_dev() is a necessary interface for device
>>>> drivers that want to support aux-domain. For example,
>>>>
>>>>           struct iommu_domain *domain;
>>>>           struct device *dev = mdev_dev(mdev);
>>>>           unsigned long pasid;
>>>>
>>>>           domain = iommu_get_domain_for_dev(dev);
>>>>           if (!domain)
>>>>                   return -ENODEV;
>>>>
>>>>           pasid = iommu_aux_get_pasid(domain, dev->parent);
>>> How did we know this was an aux domain? ie. How did we know we could
>>> use it with iommu_aux_get_pasid()?
>>
>> Yes. It's a bit confusing if iommu_get_domain_for_dev() is reused here
>> for aux-domain.
>>
>>>
>>> Why did we assume the parent device is the iommu device for the aux
>>> domain?  Should that level of detail be already known by the aux domain?
>>>
>>> Nits - The iomu device of an mdev device is found via
>>> mdev_get_iommu_device(dev), it should not be assumed to be the parent.
>>> The parent of an mdev device is found via mdev_parent_dev(mdev).
>>
>> My bad. The driver should use mdev_get_iommu_device() instead.
>>
>>>
>>> The leaps in logic here make me wonder if we should instead be exposing
>>> more of an aux domain API rather than blurring the differences between
>>> these domains.  Thanks,
>>
>> How about add below API?
>>
>> /**
>>    * iommu_aux_get_domain_for_dev - get aux domain for a device
>>    * @dev: the accessory device
>>    *
>>    * The caller should pass a valid @dev to iommu_aux_attach_device() before
>>    * calling this api. Return an attached aux-domain, or NULL otherwise.
> 
> That's not necessarily the caller's responsibility, that might happen
> elsewhere, this function simply returns an aux domain for the device if
> it's attached to one.

Yes. Fair enough. This piece of comments will be removed.

> 
>>    */
>> struct iommu_domain *iommu_aux_get_domain_for_dev(struct device *dev)
>> {
>>           struct iommu_domain *domain = NULL;
>>           struct iommu_group *group;
>>
>>           group = iommu_group_get(dev);
>>           if (!group)
>>                   return NULL;
>>
>>           if (group->aux_domain_attached)
>>                   domain = group->domain;
>>
>>           iommu_group_put(group);
>>
>>           return domain;
>> }
>> EXPORT_SYMBOL_GPL(iommu_aux_get_domain_for_dev);
> 
> For your example use case, this seems more clear to me.  Thanks,
> 

Okay, thank you!

> Alex

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
