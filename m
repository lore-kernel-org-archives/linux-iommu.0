Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE35AC433E1
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 01:42:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A269D208E4
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 01:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A269D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7407187D1A;
	Fri, 31 Jul 2020 01:42:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ZEVNh7e9EZ2; Fri, 31 Jul 2020 01:42:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D50087C5A;
	Fri, 31 Jul 2020 01:42:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D255C004F;
	Fri, 31 Jul 2020 01:42:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02ED6C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 01:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F270388520
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 01:42:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SRpO5eFa27SY for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 01:42:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7B12E87CD2
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 01:42:52 +0000 (UTC)
IronPort-SDR: XP+CGjaEM9Yo90PkcSnWzou7eY13ctMgnpjXG/zPJ6r5+YD1lNaOerQm7USgQMXJQ/vCfA5H4p
 V1ab4mgs2lvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="213252263"
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; d="scan'208";a="213252263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 18:42:51 -0700
IronPort-SDR: baMEzDWRkgxeQuoFC0ybDsUEFaxwWr9nxeCh/3VHi+mgCilOH1oafwKyMbMVumsNmjAqaPVQ+l
 EHJVYFGGSXFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; d="scan'208";a="395179041"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2020 18:42:48 -0700
Subject: Re: [PATCH v3 4/4] vfio/type1: Use iommu_aux_at(de)tach_group() APIs
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-5-baolu.lu@linux.intel.com>
 <20200729143258.22533170@x1.home>
 <af6c95a7-3238-1cbd-8656-014c12498587@linux.intel.com>
 <20200730151703.5daf8ad4@x1.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7caa6533-b980-8135-6dba-2aac5b0bb23f@linux.intel.com>
Date: Fri, 31 Jul 2020 09:37:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730151703.5daf8ad4@x1.home>
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

On 7/31/20 5:17 AM, Alex Williamson wrote:
> On Thu, 30 Jul 2020 10:41:32 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Alex,
>>
>> On 7/30/20 4:32 AM, Alex Williamson wrote:
>>> On Tue, 14 Jul 2020 13:57:03 +0800
>>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>    
>>>> Replace iommu_aux_at(de)tach_device() with iommu_aux_at(de)tach_group().
>>>> It also saves the IOMMU_DEV_FEAT_AUX-capable physcail device in the
>>>> vfio_group data structure so that it could be reused in other places.
>>>>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/vfio/vfio_iommu_type1.c | 44 ++++++---------------------------
>>>>    1 file changed, 7 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index 5e556ac9102a..f8812e68de77 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -100,6 +100,7 @@ struct vfio_dma {
>>>>    struct vfio_group {
>>>>    	struct iommu_group	*iommu_group;
>>>>    	struct list_head	next;
>>>> +	struct device		*iommu_device;
>>>>    	bool			mdev_group;	/* An mdev group */
>>>>    	bool			pinned_page_dirty_scope;
>>>>    };
>>>> @@ -1627,45 +1628,13 @@ static struct device *vfio_mdev_get_iommu_device(struct device *dev)
>>>>    	return NULL;
>>>>    }
>>>>    
>>>> -static int vfio_mdev_attach_domain(struct device *dev, void *data)
>>>> -{
>>>> -	struct iommu_domain *domain = data;
>>>> -	struct device *iommu_device;
>>>> -
>>>> -	iommu_device = vfio_mdev_get_iommu_device(dev);
>>>> -	if (iommu_device) {
>>>> -		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
>>>> -			return iommu_aux_attach_device(domain, iommu_device);
>>>> -		else
>>>> -			return iommu_attach_device(domain, iommu_device);
>>>> -	}
>>>> -
>>>> -	return -EINVAL;
>>>> -}
>>>> -
>>>> -static int vfio_mdev_detach_domain(struct device *dev, void *data)
>>>> -{
>>>> -	struct iommu_domain *domain = data;
>>>> -	struct device *iommu_device;
>>>> -
>>>> -	iommu_device = vfio_mdev_get_iommu_device(dev);
>>>> -	if (iommu_device) {
>>>> -		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
>>>> -			iommu_aux_detach_device(domain, iommu_device);
>>>> -		else
>>>> -			iommu_detach_device(domain, iommu_device);
>>>> -	}
>>>> -
>>>> -	return 0;
>>>> -}
>>>> -
>>>>    static int vfio_iommu_attach_group(struct vfio_domain *domain,
>>>>    				   struct vfio_group *group)
>>>>    {
>>>>    	if (group->mdev_group)
>>>> -		return iommu_group_for_each_dev(group->iommu_group,
>>>> -						domain->domain,
>>>> -						vfio_mdev_attach_domain);
>>>> +		return iommu_aux_attach_group(domain->domain,
>>>> +					      group->iommu_group,
>>>> +					      group->iommu_device);
>>>
>>> No, we previously iterated all devices in the group and used the aux
>>> interface only when we have an iommu_device supporting aux.  If we
>>> simply assume an mdev group only uses an aux domain we break existing
>>> users, ex. SR-IOV VF backed mdevs.  Thanks,
>>
>> Oh, yes. Sorry! I didn't consider the physical device backed mdevs
>> cases.
>>
>> Looked into this part of code, it seems that there's a lock issue here.
>> The group->mutex is held in iommu_group_for_each_dev() and will be
>> acquired again in iommu_attach_device().
> 
> These are two different groups.  We walk the devices in the mdev's
> group with iommu_group_for_each_dev(), holding the mdev's group lock,
> but we call iommu_attach_device() with iommu_device, which results in
> acquiring the lock for the iommu_device's group.

You are right. Sorry for the noise. Please ignore it.

> 
>> How about making it like:
>>
>> static int vfio_iommu_attach_group(struct vfio_domain *domain,
>>                                      struct vfio_group *group)
>> {
>>           if (group->mdev_group) {
>>                   struct device *iommu_device = group->iommu_device;
>>
>>                   if (WARN_ON(!iommu_device))
>>                           return -EINVAL;
>>
>>                   if (iommu_dev_feature_enabled(iommu_device,
>> IOMMU_DEV_FEAT_AUX))
>>                           return iommu_aux_attach_device(domain->domain,
>> iommu_device);
>>                   else
>>                           return iommu_attach_device(domain->domain,
>> iommu_device);
>>           } else {
>>                   return iommu_attach_group(domain->domain,
>> group->iommu_group);
>>           }
>> }
>>
>> The caller (vfio_iommu_type1_attach_group) has guaranteed that all mdevs
>> in an iommu group should be derived from a same physical device.
> 
> Have we?

We have done this with below.

static int vfio_mdev_iommu_device(struct device *dev, void *data)
{
         struct device **old = data, *new;

         new = vfio_mdev_get_iommu_device(dev);
         if (!new || (*old && *old != new))
                 return -EINVAL;

         *old = new;

         return 0;
}

But I agree that as a generic iommu aux-domain api, we shouldn't put
this limited assumption in it.

> iommu_attach_device() will fail if the group is not
> singleton, but that's just encouraging us to use the _attach_group()
> interface where the _attach_device() interface is relegated to special
> cases.  Ideally we'd get out of those special cases and create an
> _attach_group() for aux that doesn't further promote these notions.

Yes. Fair enough.

> 
>> Any thoughts?
> 
> See my reply to Kevin, I'm thinking we need to provide a callback that
> can enlighten the IOMMU layer to be able to do _attach_group() with
> aux or separate IOMMU backed devices.

Thanks for the guide. I will check your reply.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
