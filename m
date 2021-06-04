Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C8C07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 08:20:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6B361421
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 08:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6B361421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 489C3414C2;
	Fri,  4 Jun 2021 08:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wqHNV3UyQ3_c; Fri,  4 Jun 2021 08:20:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82EC4414C1;
	Fri,  4 Jun 2021 08:20:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6567FC000D;
	Fri,  4 Jun 2021 08:20:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 177E0C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 08:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4B80843DA
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 08:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zr0KwDLc8xp2 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 08:20:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A0C48436E
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 08:20:05 +0000 (UTC)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FxFrl428tz6G7N6;
 Fri,  4 Jun 2021 16:13:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 4 Jun 2021 10:20:00 +0200
Received: from [10.47.80.115] (10.47.80.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 4 Jun 2021
 09:20:00 +0100
Subject: Re: [PATCH v10 1/3] iommu: Enhance IOMMU default DMA mode build
 options
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, <joro@8bytes.org>,
 <will@kernel.org>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <robin.murphy@arm.com>
References: <1622728715-209296-1-git-send-email-john.garry@huawei.com>
 <1622728715-209296-2-git-send-email-john.garry@huawei.com>
 <0e54ff0f-c668-354e-1ec8-7536c701d3a8@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <285ba65e-4c65-4320-13d9-60c4d72d82cb@huawei.com>
Date: Fri, 4 Jun 2021 09:19:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <0e54ff0f-c668-354e-1ec8-7536c701d3a8@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.80.115]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
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


>>   
>>   	  If unsure, say N here.
>>   
>> +choice
>> +	prompt "IOMMU default DMA mode"
>> +	depends on IOMMU_API
> 
> config INTEL_IOMMU
>          depends on PCI_MSI && ACPI && (X86 || IA64)
> 
> config AMD_IOMMU
>          depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
> 
> config ARM_SMMU_V3
>          depends on ARM64
> 
> "depends on ARM_SMMU_V3 || INTEL_IOMMU || AMD_IOMMU" may need to be added, because it doesn't work on other platforms.
> 
> or "depends on X86 || IA64 || X86_64 || ARM64"

I suppose so. But I don't think that any other archs use the value from 
iommu_dma_strict anyway.

> 
>> +
>> +	default IOMMU_DEFAULT_STRICT
>> +	help
>> +	  This option allows an IOMMU DMA mode to be chosen at build time, to
>> +	  override the default DMA mode of each ARCH, removing the need to
>> +	  pass in kernel parameters through command line. It is still possible
>> +	  to provide ARCH-specific or common boot options to override this
>> +	  option.
>> +
>> +	  If unsure, keep the default.
>> +
>> +config IOMMU_DEFAULT_LAZY
>> +	bool "lazy"
>> +	help
>> +	  Support lazy mode, where for every IOMMU DMA unmap operation, the
>> +	  flush operation of IOTLB and the free operation of IOVA are deferred.
>> +	  They are only guaranteed to be done before the related IOVA will be
>> +	  reused.
>> +
>> +config IOMMU_DEFAULT_STRICT
>> +	bool "strict"
>> +	help
>> +	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
>> +	  the free operation of IOVA are guaranteed to be done in the unmap
>> +	  function.
>> +
>> +	  This mode is safer than the two above, but it maybe slower in some
>> +	  high performace scenarios.
>> +
>> +endchoice
>> +
>>   config OF_IOMMU
>>   	def_bool y
>>   	depends on OF && IOMMU_API
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 966426a96520..177b0dafc535 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -29,7 +29,8 @@ static struct kset *iommu_group_kset;
>>   static DEFINE_IDA(iommu_group_ida);
>>   
>>   static unsigned int iommu_def_domain_type __read_mostly;
>> -static bool iommu_dma_strict __read_mostly = true;
>> +static bool iommu_dma_strict __read_mostly =
>> +			IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
> 
> Currently, a maximum of 100 columns are allowed in a row.

Sure, but some people still prefer limiting to 80, and codingstyle
doc mentions a preference for 80.

But if you really think I should change, then that's ok.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
