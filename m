Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D863CC433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 11:17:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49E420791
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 11:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49E420791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 75B168887C;
	Tue, 23 Jun 2020 11:17:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id onIcyRAnhtJl; Tue, 23 Jun 2020 11:17:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C053388731;
	Tue, 23 Jun 2020 11:17:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7F0CC0893;
	Tue, 23 Jun 2020 11:17:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58151C0890
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 11:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 42D4B88545
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 11:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EhXcDqfnEcPL for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 11:16:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5224B884CC
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 11:16:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB441F1;
 Tue, 23 Jun 2020 04:16:58 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BD7E3F6CF;
 Tue, 23 Jun 2020 04:16:56 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To: Thierry Reding <thierry.reding@gmail.com>,
 Krishna Reddy <vdumpa@nvidia.com>
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-2-vdumpa@nvidia.com> <20200623102927.GD4098287@ulmo>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5f29c794-406a-db13-d6d0-75dcb0d0b0cc@arm.com>
Date: Tue, 23 Jun 2020 12:16:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623102927.GD4098287@ulmo>
Content-Language: en-GB
Cc: snikam@nvidia.com, praithatha@nvidia.com, bhuntsman@nvidia.com,
 linux-kernel@vger.kernel.org, mperttunen@nvidia.com, talho@nvidia.com,
 iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

On 2020-06-23 11:29, Thierry Reding wrote:
[...]
>> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
>> index c75b9d957b702..52c84c30f83e4 100644
>> --- a/drivers/iommu/arm-smmu-impl.c
>> +++ b/drivers/iommu/arm-smmu-impl.c
>> @@ -160,6 +160,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>>   	 */
>>   	switch (smmu->model) {
>>   	case ARM_MMU500:
>> +		if (of_device_is_compatible(smmu->dev->of_node,
>> +					    "nvidia,tegra194-smmu-500"))
>> +			return nvidia_smmu_impl_init(smmu);
> 
> Should NVIDIA_TEGRA194_SMMU be a separate value for smmu->model,
> perhaps? That way we avoid this somewhat odd check here.

No, this is simply in the wrong place. The design here is that we pick 
up anything related to the basic SMMU IP (model) first, then make any 
platform-specific integration checks. That way a platform-specific init 
function can see the model impl set and subclass it if necessary 
(although nobody's actually done that yet). The setup for Cavium is just 
a short-cut since their model is unique to their integration, so the 
lines get a bit blurred and there's little benefit to trying to separate 
it out.

In short, put this down below with the other of_device_is_compatible() 
checks.

>>   		smmu->impl = &arm_mmu500_impl;
>>   		break;
>>   	case CAVIUM_SMMUV2:
>> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
> 
> I wonder if it would be better to name this arm-smmu-tegra.c to make it
> clearer that this is for a Tegra chip. We do have regular expressions in
> MAINTAINERS that catch anything with "tegra" in it to make this easier.

There was a notion that these would be grouped by vendor, but if there's 
a strong preference for all NVIDIA-SoC-related stuff to be named "Tegra" 
then I'm not going to complain too much.

>> new file mode 100644
>> index 0000000000000..dafc293a45217
>> --- /dev/null
>> +++ b/drivers/iommu/arm-smmu-nvidia.c
>> @@ -0,0 +1,161 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Nvidia ARM SMMU v2 implementation quirks
> 
> s/Nvidia/NVIDIA/
> 
>> +// Copyright (C) 2019 NVIDIA CORPORATION.  All rights reserved.
> 
> I suppose this should now also include 2020.
> 
>> +
>> +#define pr_fmt(fmt) "nvidia-smmu: " fmt
> 
> Same here. Might be worth making this "tegra-smmu: " for consistency.

On the other hand, a log prefix that is literally the name of a 
completely unrelated driver seems more confusing to users than useful. 
Same for the function naming - the tegra_smmu_* namespace is already 
owned by that driver.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
