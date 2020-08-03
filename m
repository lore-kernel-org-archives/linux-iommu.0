Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB76C433E1
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 02:20:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A3E20722
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 02:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A3E20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D23CC20485;
	Mon,  3 Aug 2020 02:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZZEyOX4qlLBR; Mon,  3 Aug 2020 02:20:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5C9BE203FA;
	Mon,  3 Aug 2020 02:20:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 413FBC0051;
	Mon,  3 Aug 2020 02:20:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60BE7C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 02:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E85C87B60
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 02:20:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kbkM+NoVRlmb for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 02:20:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 026AC87B59
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 02:20:30 +0000 (UTC)
IronPort-SDR: OPM4goDuSmqAn2loN+yCx+hVn60OTYEW2ISMyCGmRYiYFEWBP6R6TUGqqiGfMmDiljzEBzyIpL
 /ovjFq+TbrMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="153240894"
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; d="scan'208";a="153240894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2020 19:20:29 -0700
IronPort-SDR: qBWMv2KDbNwROoK6QxaoQTKg3p7yCiwqOsxCFMDmeLzSALxSB3YfchntlexrlpC10igfhQ/2Jw
 Jb+scsqpJqsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; d="scan'208";a="395909209"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2020 19:20:26 -0700
Subject: Re: [PATCH v3 3/4] iommu: Add iommu_aux_get_domain_for_dev()
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-4-baolu.lu@linux.intel.com>
 <20200729142507.182cd18a@x1.home>
 <06fd91c1-a978-d526-7e2b-fec619a458e4@linux.intel.com>
 <20200731121418.0274afb8@x1.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3fd171a2-a5cc-89d7-f539-04eb2faf130f@linux.intel.com>
Date: Mon, 3 Aug 2020 10:15:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731121418.0274afb8@x1.home>
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

On 8/1/20 2:14 AM, Alex Williamson wrote:
> On Fri, 31 Jul 2020 14:30:03 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Alex,
>>
>> On 2020/7/30 4:25, Alex Williamson wrote:
>>> On Tue, 14 Jul 2020 13:57:02 +0800
>>> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>    
>>>> The device driver needs an API to get its aux-domain. A typical usage
>>>> scenario is:
>>>>
>>>>           unsigned long pasid;
>>>>           struct iommu_domain *domain;
>>>>           struct device *dev = mdev_dev(mdev);
>>>>           struct device *iommu_device = vfio_mdev_get_iommu_device(dev);
>>>>
>>>>           domain = iommu_aux_get_domain_for_dev(dev);
>>>>           if (!domain)
>>>>                   return -ENODEV;
>>>>
>>>>           pasid = iommu_aux_get_pasid(domain, iommu_device);
>>>>           if (pasid <= 0)
>>>>                   return -EINVAL;
>>>>
>>>>            /* Program the device context */
>>>>            ....
>>>>
>>>> This adds an API for such use case.
>>>>
>>>> Suggested-by: Alex Williamson<alex.williamson@redhat.com>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/iommu.c | 18 ++++++++++++++++++
>>>>    include/linux/iommu.h |  7 +++++++
>>>>    2 files changed, 25 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index cad5a19ebf22..434bf42b6b9b 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -2817,6 +2817,24 @@ void iommu_aux_detach_group(struct iommu_domain *domain,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(iommu_aux_detach_group);
>>>>    
>>>> +struct iommu_domain *iommu_aux_get_domain_for_dev(struct device *dev)
>>>> +{
>>>> +	struct iommu_domain *domain = NULL;
>>>> +	struct iommu_group *group;
>>>> +
>>>> +	group = iommu_group_get(dev);
>>>> +	if (!group)
>>>> +		return NULL;
>>>> +
>>>> +	if (group->aux_domain_attached)
>>>> +		domain = group->domain;
>>> Why wouldn't the aux domain flag be on the domain itself rather than
>>> the group?  Then if we wanted sanity checking in patch 1/ we'd only
>>> need to test the flag on the object we're provided.
>>
>> Agreed. Given that a group may contain both non-aux and aux devices,
>> adding such flag in iommu_group doesn't make sense.
>>
>>>
>>> If we had such a flag, we could create an iommu_domain_is_aux()
>>> function and then simply use iommu_get_domain_for_dev() and test that
>>> it's an aux domain in the example use case.  It seems like that would
>>> resolve the jump from a domain to an aux-domain just as well as adding
>>> this separate iommu_aux_get_domain_for_dev() interface.  The is_aux
>>> test might also be useful in other cases too.
>>
>> Let's rehearsal our use case.
>>
>>           unsigned long pasid;
>>           struct iommu_domain *domain;
>>           struct device *dev = mdev_dev(mdev);
>>           struct device *iommu_device = vfio_mdev_get_iommu_device(dev);
>>
>> [1]     domain = iommu_get_domain_for_dev(dev);
>>           if (!domain)
>>                   return -ENODEV;
>>
>> [2]     pasid = iommu_aux_get_pasid(domain, iommu_device);
>>           if (pasid <= 0)
>>                   return -EINVAL;
>>
>>            /* Program the device context */
>>            ....
>>
>> The reason why I add this iommu_aux_get_domain_for_dev() is that we need
>> to make sure the domain got at [1] is valid to be used at [2].
>>
>> https://lore.kernel.org/linux-iommu/20200707150408.474d81f1@x1.home/
> 
> Yep, I thought that was a bit of a leap in logic.
> 
>> When calling into iommu_aux_get_pasid(), the iommu driver should make
>> sure that @domain is a valid aux-domain for @iommu_device. Hence, for
>> our use case, it seems that there's no need for a is_aux_domain() api.
>>
>> Anyway, I'm not against adding a new is_aux_domain() api if there's a
>> need elsewhere.
> 
> I think it could work either way, we could have an
> iommu_get_aux_domain_for_dev() which returns NULL if the domain is not
> an aux domain, or we could use iommu_get_domain_for_dev() and the
> caller could test the domain with iommu_is_aux_domain() if they need to
> confirm if it's an aux domain.  The former could even be written using
> the latter, a wrapper of iommu_get_domain_for_dev() that checks aux
> property before returning.

Okay. So iommu_get_domain_for_dev() and iommu_is_aux_domain() are what
we wanted. The iommu_get_domain_for_dev() could be a simple wrapper of
them.

Thanks a lot for the guide. I will implement a new version according to
the feedbacks.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
