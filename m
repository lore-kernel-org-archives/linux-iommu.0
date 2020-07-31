Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6DCC433DF
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 06:30:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26AE208E4
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 06:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26AE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C38086A32;
	Fri, 31 Jul 2020 06:30:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q-IkIG6a8JAs; Fri, 31 Jul 2020 06:30:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C666C86A14;
	Fri, 31 Jul 2020 06:30:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADAB3C0050;
	Fri, 31 Jul 2020 06:30:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F40DC004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 06:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 936058863B
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 06:30:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ohGj6Bwh1d-E for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 06:30:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A2B7D88638
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 06:30:10 +0000 (UTC)
IronPort-SDR: 3LXu2QWw12Zob5cz3Ck2QkROf5k1vDaIHjyFvuxVAwAXqGqHhjwpCl0Ud9MzrgQH4cqR6ha/u/
 7+IrxqHo4G8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="236601927"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; d="scan'208";a="236601927"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 23:30:09 -0700
IronPort-SDR: zX0i7UjX9khEP8dd1fClb0ZgGv4jktjUAWeeAPNWqdnllhKOSoYF4zKfKXMGsBk6HaRnhUzDgA
 XHE5s3SdIx7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; d="scan'208";a="321320272"
Received: from daisygao-mobl.ccr.corp.intel.com (HELO [10.254.211.68])
 ([10.254.211.68])
 by orsmga008.jf.intel.com with ESMTP; 30 Jul 2020 23:30:04 -0700
Subject: Re: [PATCH v3 3/4] iommu: Add iommu_aux_get_domain_for_dev()
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-4-baolu.lu@linux.intel.com>
 <20200729142507.182cd18a@x1.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <06fd91c1-a978-d526-7e2b-fec619a458e4@linux.intel.com>
Date: Fri, 31 Jul 2020 14:30:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729142507.182cd18a@x1.home>
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

On 2020/7/30 4:25, Alex Williamson wrote:
> On Tue, 14 Jul 2020 13:57:02 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> The device driver needs an API to get its aux-domain. A typical usage
>> scenario is:
>>
>>          unsigned long pasid;
>>          struct iommu_domain *domain;
>>          struct device *dev = mdev_dev(mdev);
>>          struct device *iommu_device = vfio_mdev_get_iommu_device(dev);
>>
>>          domain = iommu_aux_get_domain_for_dev(dev);
>>          if (!domain)
>>                  return -ENODEV;
>>
>>          pasid = iommu_aux_get_pasid(domain, iommu_device);
>>          if (pasid <= 0)
>>                  return -EINVAL;
>>
>>           /* Program the device context */
>>           ....
>>
>> This adds an API for such use case.
>>
>> Suggested-by: Alex Williamson<alex.williamson@redhat.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 18 ++++++++++++++++++
>>   include/linux/iommu.h |  7 +++++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index cad5a19ebf22..434bf42b6b9b 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2817,6 +2817,24 @@ void iommu_aux_detach_group(struct iommu_domain *domain,
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_aux_detach_group);
>>   
>> +struct iommu_domain *iommu_aux_get_domain_for_dev(struct device *dev)
>> +{
>> +	struct iommu_domain *domain = NULL;
>> +	struct iommu_group *group;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
>> +
>> +	if (group->aux_domain_attached)
>> +		domain = group->domain;
> Why wouldn't the aux domain flag be on the domain itself rather than
> the group?  Then if we wanted sanity checking in patch 1/ we'd only
> need to test the flag on the object we're provided.

Agreed. Given that a group may contain both non-aux and aux devices,
adding such flag in iommu_group doesn't make sense.

> 
> If we had such a flag, we could create an iommu_domain_is_aux()
> function and then simply use iommu_get_domain_for_dev() and test that
> it's an aux domain in the example use case.  It seems like that would
> resolve the jump from a domain to an aux-domain just as well as adding
> this separate iommu_aux_get_domain_for_dev() interface.  The is_aux
> test might also be useful in other cases too.

Let's rehearsal our use case.

         unsigned long pasid;
         struct iommu_domain *domain;
         struct device *dev = mdev_dev(mdev);
         struct device *iommu_device = vfio_mdev_get_iommu_device(dev);

[1]     domain = iommu_get_domain_for_dev(dev);
         if (!domain)
                 return -ENODEV;

[2]     pasid = iommu_aux_get_pasid(domain, iommu_device);
         if (pasid <= 0)
                 return -EINVAL;

          /* Program the device context */
          ....

The reason why I add this iommu_aux_get_domain_for_dev() is that we need
to make sure the domain got at [1] is valid to be used at [2].

https://lore.kernel.org/linux-iommu/20200707150408.474d81f1@x1.home/

When calling into iommu_aux_get_pasid(), the iommu driver should make
sure that @domain is a valid aux-domain for @iommu_device. Hence, for
our use case, it seems that there's no need for a is_aux_domain() api.

Anyway, I'm not against adding a new is_aux_domain() api if there's a
need elsewhere.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
