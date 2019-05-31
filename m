Return-Path: <SRS0=mJb0=T7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44B0C28CC3
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 13:39:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8247E26974
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 13:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8247E26974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 40AA81186;
	Fri, 31 May 2019 13:39:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9B1791180
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 13:38:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 2B8646C5
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 13:38:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F8DA78;
	Fri, 31 May 2019 06:38:23 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36DC23F5AF;
	Fri, 31 May 2019 06:38:22 -0700 (PDT)
Subject: Re: [PATCH 3/4] iommu: Introduce device fault report API
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <20190523180613.55049-1-jean-philippe.brucker@arm.com>
	<20190523180613.55049-4-jean-philippe.brucker@arm.com>
	<e56244fd-86fd-1fc9-17f7-d00179d586ac@arm.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <023acfae-5c93-9e20-8355-5cd7410c15e7@arm.com>
Date: Fri, 31 May 2019 14:37:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e56244fd-86fd-1fc9-17f7-d00179d586ac@arm.com>
Content-Language: en-US
Cc: "yi.l.liu@linux.intel.com" <yi.l.liu@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"ashok.raj@intel.com" <ashok.raj@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 23/05/2019 19:56, Robin Murphy wrote:
> On 23/05/2019 19:06, Jean-Philippe Brucker wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>
>> Traditionally, device specific faults are detected and handled within
>> their own device drivers. When IOMMU is enabled, faults such as DMA
>> related transactions are detected by IOMMU. There is no generic
>> reporting mechanism to report faults back to the in-kernel device
>> driver or the guest OS in case of assigned devices.
>>
>> This patch introduces a registration API for device specific fault
>> handlers. This differs from the existing iommu_set_fault_handler/
>> report_iommu_fault infrastructures in several ways:
>> - it allows to report more sophisticated fault events (both
>>    unrecoverable faults and page request faults) due to the nature
>>    of the iommu_fault struct
>> - it is device specific and not domain specific.
>>
>> The current iommu_report_device_fault() implementation only handles
>> the "shoot and forget" unrecoverable fault case. Handling of page
>> request faults or stalled faults will come later.
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   drivers/iommu/iommu.c | 127 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/iommu.h |  29 ++++++++++
>>   2 files changed, 156 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 67ee6623f9b2..d546f7baa0d4 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -644,6 +644,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>>   		goto err_free_name;
>>   	}
>>   
>> +	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param), GFP_KERNEL);
>> +	if (!dev->iommu_param) {
>> +		ret = -ENOMEM;
>> +		goto err_free_name;
>> +	}
>> +	mutex_init(&dev->iommu_param->lock);
>> +
> 
> Note that this gets a bit tricky when we come to move to move the 
> fwspec/ops/etc. into iommu_param, since that data can have a longer 
> lifespan than the group association. I'd suggest moving this management 
> out to the iommu_{probe,release}_device() level from the start, but 
> maybe we're happy to come back and change things later as necessary.

I'll do that, but iommu_probe_device() might still be too late.
According to of_iommu_configure() there might be cases where
iommu_probe_device() is called after iommu_fwspec_init(). So when moving
everything to iommu_param, we might need to introduce something like
iommu_get_dev_param() which allocates the param if it doesn't exist.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
