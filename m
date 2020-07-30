Return-Path: <SRS0=+Z17=BJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60546C433E0
	for <iommu@archiver.kernel.org>; Thu, 30 Jul 2020 02:46:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336D222BEA
	for <iommu@archiver.kernel.org>; Thu, 30 Jul 2020 02:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336D222BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0612A86354;
	Thu, 30 Jul 2020 02:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BmQS5XmVJvZT; Thu, 30 Jul 2020 02:46:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F6A58632F;
	Thu, 30 Jul 2020 02:46:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53918C004F;
	Thu, 30 Jul 2020 02:46:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99CECC004D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 02:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8F19D87697
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 02:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UK+M5Gj6zKXO for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 02:46:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B9A7C875F4
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 02:46:30 +0000 (UTC)
IronPort-SDR: dvLcMF+O3wOAmLflupPdXwdBX6tiXOfO/qq86Z221Hm7BZRoM27O2w+Plm2CFZXu1SmD8RSYDr
 g2AeLFdbh6xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="169651674"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="169651674"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 19:46:30 -0700
IronPort-SDR: 0iJ7hBD9wyNkQ0O5ISSl6IT4NwwZIo8wpg/gAFopSKoJ5cAqj8JDZihqnOYhqnpMw7UrdG+sE+
 qJaypzmRJj9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="394841270"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2020 19:46:27 -0700
Subject: Re: [PATCH v3 4/4] vfio/type1: Use iommu_aux_at(de)tach_group() APIs
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-5-baolu.lu@linux.intel.com>
 <20200729143258.22533170@x1.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <af6c95a7-3238-1cbd-8656-014c12498587@linux.intel.com>
Date: Thu, 30 Jul 2020 10:41:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729143258.22533170@x1.home>
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

On 7/30/20 4:32 AM, Alex Williamson wrote:
> On Tue, 14 Jul 2020 13:57:03 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Replace iommu_aux_at(de)tach_device() with iommu_aux_at(de)tach_group().
>> It also saves the IOMMU_DEV_FEAT_AUX-capable physcail device in the
>> vfio_group data structure so that it could be reused in other places.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 44 ++++++---------------------------
>>   1 file changed, 7 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 5e556ac9102a..f8812e68de77 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -100,6 +100,7 @@ struct vfio_dma {
>>   struct vfio_group {
>>   	struct iommu_group	*iommu_group;
>>   	struct list_head	next;
>> +	struct device		*iommu_device;
>>   	bool			mdev_group;	/* An mdev group */
>>   	bool			pinned_page_dirty_scope;
>>   };
>> @@ -1627,45 +1628,13 @@ static struct device *vfio_mdev_get_iommu_device(struct device *dev)
>>   	return NULL;
>>   }
>>   
>> -static int vfio_mdev_attach_domain(struct device *dev, void *data)
>> -{
>> -	struct iommu_domain *domain = data;
>> -	struct device *iommu_device;
>> -
>> -	iommu_device = vfio_mdev_get_iommu_device(dev);
>> -	if (iommu_device) {
>> -		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
>> -			return iommu_aux_attach_device(domain, iommu_device);
>> -		else
>> -			return iommu_attach_device(domain, iommu_device);
>> -	}
>> -
>> -	return -EINVAL;
>> -}
>> -
>> -static int vfio_mdev_detach_domain(struct device *dev, void *data)
>> -{
>> -	struct iommu_domain *domain = data;
>> -	struct device *iommu_device;
>> -
>> -	iommu_device = vfio_mdev_get_iommu_device(dev);
>> -	if (iommu_device) {
>> -		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
>> -			iommu_aux_detach_device(domain, iommu_device);
>> -		else
>> -			iommu_detach_device(domain, iommu_device);
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>   static int vfio_iommu_attach_group(struct vfio_domain *domain,
>>   				   struct vfio_group *group)
>>   {
>>   	if (group->mdev_group)
>> -		return iommu_group_for_each_dev(group->iommu_group,
>> -						domain->domain,
>> -						vfio_mdev_attach_domain);
>> +		return iommu_aux_attach_group(domain->domain,
>> +					      group->iommu_group,
>> +					      group->iommu_device);
> 
> No, we previously iterated all devices in the group and used the aux
> interface only when we have an iommu_device supporting aux.  If we
> simply assume an mdev group only uses an aux domain we break existing
> users, ex. SR-IOV VF backed mdevs.  Thanks,

Oh, yes. Sorry! I didn't consider the physical device backed mdevs
cases.

Looked into this part of code, it seems that there's a lock issue here.
The group->mutex is held in iommu_group_for_each_dev() and will be
acquired again in iommu_attach_device().

How about making it like:

static int vfio_iommu_attach_group(struct vfio_domain *domain,
                                    struct vfio_group *group)
{
         if (group->mdev_group) {
                 struct device *iommu_device = group->iommu_device;

                 if (WARN_ON(!iommu_device))
                         return -EINVAL;

                 if (iommu_dev_feature_enabled(iommu_device, 
IOMMU_DEV_FEAT_AUX))
                         return iommu_aux_attach_device(domain->domain, 
iommu_device);
                 else
                         return iommu_attach_device(domain->domain, 
iommu_device);
         } else {
                 return iommu_attach_group(domain->domain, 
group->iommu_group);
         }
}

The caller (vfio_iommu_type1_attach_group) has guaranteed that all mdevs
in an iommu group should be derived from a same physical device.

Any thoughts?

> 
> Alex

Best regards,
baolu

> 
> 
>>   	else
>>   		return iommu_attach_group(domain->domain, group->iommu_group);
>>   }
>> @@ -1674,8 +1643,8 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
>>   				    struct vfio_group *group)
>>   {
>>   	if (group->mdev_group)
>> -		iommu_group_for_each_dev(group->iommu_group, domain->domain,
>> -					 vfio_mdev_detach_domain);
>> +		iommu_aux_detach_group(domain->domain, group->iommu_group,
>> +				       group->iommu_device);
>>   	else
>>   		iommu_detach_group(domain->domain, group->iommu_group);
>>   }
>> @@ -2007,6 +1976,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   			return 0;
>>   		}
>>   
>> +		group->iommu_device = iommu_device;
>>   		bus = iommu_device->bus;
>>   	}
>>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
