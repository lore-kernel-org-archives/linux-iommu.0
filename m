Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6C2C32753
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 17:35:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE1E206C2
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 17:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE1E206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D815EC96;
	Wed, 14 Aug 2019 17:35:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7528EC91
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 17:35:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 056C487E
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 17:35:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74608344;
	Wed, 14 Aug 2019 10:35:24 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CBEB3F694;
	Wed, 14 Aug 2019 10:35:23 -0700 (PDT)
Subject: Re: [PATCH 01/15] iommu/arm-smmu: Convert GR0 registers to bitfields
To: Will Deacon <will@kernel.org>
References: <cover.1565369764.git.robin.murphy@arm.com>
	<910cad718be01904db20ce73d8d54e7481290136.1565369764.git.robin.murphy@arm.com>
	<20190814172030.accr7azgkkkwumt2@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4d53b058-0024-02cd-27bb-7a44b766c847@arm.com>
Date: Wed, 14 Aug 2019 18:35:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190814172030.accr7azgkkkwumt2@willie-the-truck>
Content-Language: en-GB
Cc: gregory.clement@bootlin.com, iommu@lists.linux-foundation.org,
	bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org
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

On 14/08/2019 18:20, Will Deacon wrote:
> On Fri, Aug 09, 2019 at 06:07:38PM +0100, Robin Murphy wrote:
>> FIELD_PREP remains a terrible name, but the overall simplification will
>> make further work on this stuff that much more manageable. This also
>> serves as an audit of the header, wherein we can impose a consistent
>> grouping and ordering of the offset and field definitions
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm-smmu-regs.h | 126 ++++++++++++++++------------------
>>   drivers/iommu/arm-smmu.c      |  51 +++++++-------
>>   2 files changed, 84 insertions(+), 93 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
>> index 1c278f7ae888..d189f025537a 100644
>> --- a/drivers/iommu/arm-smmu-regs.h
>> +++ b/drivers/iommu/arm-smmu-regs.h
>> @@ -10,111 +10,101 @@
>>   #ifndef _ARM_SMMU_REGS_H
>>   #define _ARM_SMMU_REGS_H
>>   
>> +#include <linux/bits.h>
>> +
>>   /* Configuration registers */
>>   #define ARM_SMMU_GR0_sCR0		0x0
>> -#define sCR0_CLIENTPD			(1 << 0)
>> -#define sCR0_GFRE			(1 << 1)
>> -#define sCR0_GFIE			(1 << 2)
>> -#define sCR0_EXIDENABLE			(1 << 3)
>> -#define sCR0_GCFGFRE			(1 << 4)
>> -#define sCR0_GCFGFIE			(1 << 5)
>> -#define sCR0_USFCFG			(1 << 10)
>> -#define sCR0_VMIDPNE			(1 << 11)
>> -#define sCR0_PTM			(1 << 12)
>> -#define sCR0_FB				(1 << 13)
>> -#define sCR0_VMID16EN			(1 << 31)
>> -#define sCR0_BSU_SHIFT			14
>> -#define sCR0_BSU_MASK			0x3
>> +#define sCR0_VMID16EN			BIT(31)
>> +#define sCR0_BSU			GENMASK(15, 14)
>> +#define sCR0_FB				BIT(13)
>> +#define sCR0_PTM			BIT(12)
>> +#define sCR0_VMIDPNE			BIT(11)
>> +#define sCR0_USFCFG			BIT(10)
>> +#define sCR0_GCFGFIE			BIT(5)
>> +#define sCR0_GCFGFRE			BIT(4)
>> +#define sCR0_EXIDENABLE			BIT(3)
>> +#define sCR0_GFIE			BIT(2)
>> +#define sCR0_GFRE			BIT(1)
>> +#define sCR0_CLIENTPD			BIT(0)
>>   
>>   /* Auxiliary Configuration register */
>>   #define ARM_SMMU_GR0_sACR		0x10
>>   
>>   /* Identification registers */
>>   #define ARM_SMMU_GR0_ID0		0x20
>> +#define ID0_S1TS			BIT(30)
>> +#define ID0_S2TS			BIT(29)
>> +#define ID0_NTS				BIT(28)
>> +#define ID0_SMS				BIT(27)
>> +#define ID0_ATOSNS			BIT(26)
>> +#define ID0_PTFS_NO_AARCH32		BIT(25)
>> +#define ID0_PTFS_NO_AARCH32S		BIT(24)
>> +#define ID0_CTTW			BIT(14)
>> +#define ID0_NUMIRPT			GENMASK(23, 16)
> 
> nit: assuming this should be above ID0_CTTW so things are in descending
> bit order?

Bah, indeed it should. Fixed now.
> Other than that, looks good to me.

Thanks!

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
