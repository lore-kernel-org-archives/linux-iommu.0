Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2209C04AAF
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 11:45:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE86720833
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 11:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE86720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7D7FBDCA;
	Thu, 16 May 2019 11:45:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 20CCEDC2
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 11:45:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A31CD87B
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 11:45:42 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CED227F770;
	Thu, 16 May 2019 11:45:41 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C31110021B2;
	Thu, 16 May 2019 11:45:36 +0000 (UTC)
Subject: Re: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE
	reserved memory regions
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	eric.auger.pro@gmail.com, joro@8bytes.org,
	iommu@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	lorenzo.pieralisi@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
	hanjun.guo@linaro.org, sudeep.holla@arm.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
	<20190516100817.12076-7-eric.auger@redhat.com>
	<3e21e370-135e-2eab-dd99-50e19cd53b86@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <403897e7-2af9-3fa9-2264-f66dfeda6fd7@redhat.com>
Date: Thu, 16 May 2019 13:45:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3e21e370-135e-2eab-dd99-50e19cd53b86@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 16 May 2019 11:45:42 +0000 (UTC)
Cc: alex.williamson@redhat.com
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

Hi Jean-Philippe,

On 5/16/19 1:16 PM, Jean-Philippe Brucker wrote:
> On 16/05/2019 11:08, Eric Auger wrote:
>> Note: At the moment the sysfs ABI is not changed. However I wonder
>> whether it wouldn't be preferable to report the direct region as
>> "direct_relaxed" there. At the moment, in case the same direct
>> region is used by 2 devices, one USB/GFX and another not belonging
>> to the previous categories, the direct region will be output twice
>> with "direct" type.
>>
>> This would unblock Shameer's series:
>> [PATCH v6 0/7] vfio/type1: Add support for valid iova list management
>> https://patchwork.kernel.org/patch/10425309/
> 
> Thanks for doing this!
> 
>> which failed to get pulled for 4.18 merge window due to IGD
>> device assignment regression.
>>
>> v2 -> v3:
>> - fix direct type check
>> ---
>>  drivers/iommu/iommu.c | 12 +++++++-----
>>  include/linux/iommu.h |  6 ++++++
>>  2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index ae4ea5c0e6f9..28c3d6351832 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -73,10 +73,11 @@ struct iommu_group_attribute {
>>  };
>>  
>>  static const char * const iommu_group_resv_type_string[] = {
>> -	[IOMMU_RESV_DIRECT]	= "direct",
>> -	[IOMMU_RESV_RESERVED]	= "reserved",
>> -	[IOMMU_RESV_MSI]	= "msi",
>> -	[IOMMU_RESV_SW_MSI]	= "msi",
>> +	[IOMMU_RESV_DIRECT]			= "direct",
>> +	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct",
>> +	[IOMMU_RESV_RESERVED]			= "reserved",
>> +	[IOMMU_RESV_MSI]			= "msi",
>> +	[IOMMU_RESV_SW_MSI]			= "msi",
>>  };
>>  
>>  #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
>> @@ -573,7 +574,8 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
>>  		start = ALIGN(entry->start, pg_size);
>>  		end   = ALIGN(entry->start + entry->length, pg_size);
>>  
>> -		if (entry->type != IOMMU_RESV_DIRECT)
>> +		if (entry->type != IOMMU_RESV_DIRECT &&
>> +		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)
> 
> I'm trying to understand why you need to create direct mappings at all
> for these relaxable regions. In the host the region is needed for legacy
> device features, which are disabled (and cannot be re-enabled) when
> assigning the device to a guest?
This follows Kevin's comment in the thread below:
https://patchwork.kernel.org/patch/10449103/#21957279

In normal DMA API host path, those regions need to be 1-1 mapped. They
are likely to be accessed by the driver or FW at early boot phase or
even during execution, depending on features being used.

That's the reason, according to Kevin we couldn't hide them.

We just know that, in general, they are not used anymore when assigning
the device or if accesses are attempted this generally does not block
the assignment use case. For example, it is said in
https://github.com/qemu/qemu/blob/master/docs/igd-assign.txt that in
legacy IGD assignment use case, there may be "a small numbers of DMAR
faults when initially assigned".

Thanks

Eric


> 
> Thanks,
> Jean
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
