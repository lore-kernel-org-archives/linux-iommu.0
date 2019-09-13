Return-Path: <SRS0=dyvA=XI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1457EC49ED7
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 14:44:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52EC20693
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 14:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52EC20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A30711000;
	Fri, 13 Sep 2019 14:44:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BAF221000
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:44:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 37F0483A
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:44:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A350A1000;
	Fri, 13 Sep 2019 07:43:59 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0EFA3F67D;
	Fri, 13 Sep 2019 07:43:58 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu: Report USF more clearly
To: Qian Cai <cai@lca.pw>, will@kernel.org, joro@8bytes.org
References: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
	<1568385318.5576.146.camel@lca.pw>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e33fb57a-04de-1b97-2e8a-c51c17fea248@arm.com>
Date: Fri, 13 Sep 2019 15:43:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1568385318.5576.146.camel@lca.pw>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Douglas Anderson <dianders@chromium.org>,
	linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 13/09/2019 15:35, Qian Cai wrote:
> On Fri, 2019-09-13 at 12:48 +0100, Robin Murphy wrote:
>> Although CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is a welcome tool
>> for smoking out inadequate firmware, the failure mode is non-obvious
>> and can be confusing for end users. Add some special-case reporting of
>> Unidentified Stream Faults to help clarify this particular symptom.
>>
>> CC: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 5 +++++
>>   drivers/iommu/arm-smmu.h | 2 ++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index b7cf24402a94..76ac8c180695 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -499,6 +499,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>>   	dev_err_ratelimited(smmu->dev,
>>   		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
>>   		gfsr, gfsynr0, gfsynr1, gfsynr2);
>> +	if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
>> +	    (gfsr & sGFSR_USF))
>> +		dev_err_ratelimited(smmu->dev,
>> +			"Stream ID %hu may not be described by firmware, try booting with \"arm-smmu.disable_bypass=0\"\n",
>> +			(u16)gfsynr1);
> 
> dev_err_once(), i.e., don't need to remind people to set "arm-
> smmu.disable_bypass=0" multiple times.

Indeed, but in many cases it then quickly gets buried by an unending 
storm of repeated faults (not every console has capture and scrollback...)

Given that it's a "this is why your machine is on fire" kind of message, 
I figured that it's probably best to err on the side of visibility.

Robin.

>>   
>>   	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sGFSR, gfsr);
>>   	return IRQ_HANDLED;
>> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
>> index c9c13b5785f2..46f7e161e83e 100644
>> --- a/drivers/iommu/arm-smmu.h
>> +++ b/drivers/iommu/arm-smmu.h
>> @@ -79,6 +79,8 @@
>>   #define ID7_MINOR			GENMASK(3, 0)
>>   
>>   #define ARM_SMMU_GR0_sGFSR		0x48
>> +#define sGFSR_USF			BIT(2)
>> +
>>   #define ARM_SMMU_GR0_sGFSYNR0		0x50
>>   #define ARM_SMMU_GR0_sGFSYNR1		0x54
>>   #define ARM_SMMU_GR0_sGFSYNR2		0x58
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
