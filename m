Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53EFC432C0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 16:20:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2E520665
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 16:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2E520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5B86E8558D;
	Wed, 27 Nov 2019 16:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FLIFTJ7t6ZTr; Wed, 27 Nov 2019 16:20:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1DF3C8555A;
	Wed, 27 Nov 2019 16:20:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED090C1DD5;
	Wed, 27 Nov 2019 16:20:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9C9EC0881
 for <iommu@lists.linuxfoundation.org>; Wed, 27 Nov 2019 16:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 93243864A6
 for <iommu@lists.linuxfoundation.org>; Wed, 27 Nov 2019 16:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMW0dnPJqFkl for <iommu@lists.linuxfoundation.org>;
 Wed, 27 Nov 2019 16:20:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B89BD845C5
 for <iommu@lists.linuxfoundation.org>; Wed, 27 Nov 2019 16:20:24 +0000 (UTC)
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id F114EA7B67EB051CEB9B;
 Wed, 27 Nov 2019 16:20:21 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 27 Nov 2019 16:20:21 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 16:20:21 +0000
Subject: Re: [PATCH] iommu/arm-smmu: support SMMU module probing from the IORT
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ard Biesheuvel
 <ardb@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
 <20191122174125.21030-1-ardb@kernel.org>
 <20191125160445.GA24078@e121166-lin.cambridge.arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <bf5b8665-c599-511c-25d2-f9ebadb41870@huawei.com>
Date: Wed, 27 Nov 2019 16:20:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191125160445.GA24078@e121166-lin.cambridge.arm.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linuxfoundation.org, isaacm@codeaurora.org,
 saravanak@google.com, jean-philippe@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, will@kernel.org,
 robin.murphy@arm.com
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

On 25/11/2019 16:04, Lorenzo Pieralisi wrote:
> On Fri, Nov 22, 2019 at 06:41:25PM +0100, Ard Biesheuvel wrote:
>> Add support for SMMU drivers built as modules to the ACPI/IORT device
>> probing path, by deferring the probe of the master if the SMMU driver is
>> known to exist but has not been loaded yet. Given that the IORT code
>> registers a platform device for each SMMU that it discovers, we can
>> easily trigger the udev based autoloading of the SMMU drivers by making
>> the platform device identifier part of the module alias.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>   drivers/acpi/arm64/iort.c   | 4 ++--
>>   drivers/iommu/arm-smmu-v3.c | 1 +
>>   drivers/iommu/arm-smmu.c    | 1 +
>>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> I think it is best if Will picks this up and add it to the
> series that modularize the SMMU drivers:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Tested-by: John Garry <john.garry@huawei.com> # only manual smmu ko loading

> 
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 5a7551d060f2..a696457a9b11 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -850,9 +850,9 @@ static inline bool iort_iommu_driver_enabled(u8 type)
>>   {
>>   	switch (type) {
>>   	case ACPI_IORT_NODE_SMMU_V3:
>> -		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
>> +		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
>>   	case ACPI_IORT_NODE_SMMU:
>> -		return IS_BUILTIN(CONFIG_ARM_SMMU);
>> +		return IS_ENABLED(CONFIG_ARM_SMMU);
>>   	default:
>>   		pr_warn("IORT node type %u does not describe an SMMU\n", type);
>>   		return false;
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 7669beafc493..bf6a1e8eb9b0 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -3733,4 +3733,5 @@ module_platform_driver(arm_smmu_driver);
>>   
>>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>>   MODULE_AUTHOR("Will Deacon <will@kernel.org>");
>> +MODULE_ALIAS("platform:arm-smmu-v3");
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index d55acc48aee3..db5106b0955b 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -2292,4 +2292,5 @@ module_platform_driver(arm_smmu_driver);
>>   
>>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>>   MODULE_AUTHOR("Will Deacon <will@kernel.org>");
>> +MODULE_ALIAS("platform:arm-smmu");
>>   MODULE_LICENSE("GPL v2");
>> -- 
>> 2.20.1
>>
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
