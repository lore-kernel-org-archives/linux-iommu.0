Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF76C11F67
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 18:11:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170D161DDE
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 18:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170D161DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA248403EB;
	Tue, 29 Jun 2021 18:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PseytzEScMyY; Tue, 29 Jun 2021 18:11:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A628240104;
	Tue, 29 Jun 2021 18:11:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BCDBC0010;
	Tue, 29 Jun 2021 18:11:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E141C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 18:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AAA083984
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 18:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U5buaC782xYn for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 18:11:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87C808374F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 18:11:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69480D6E;
 Tue, 29 Jun 2021 11:11:03 -0700 (PDT)
Received: from [10.57.46.146] (unknown [10.57.46.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D75803F694;
 Tue, 29 Jun 2021 11:10:58 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add default domain quirk for Arm Fast
 Models
To: Will Deacon <will@kernel.org>
References: <bf7020acf5ca7306a51d1950e3ff2afe2229e037.1624032324.git.robin.murphy@arm.com>
 <20210629173440.GA7556@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c644a7dd-c721-4cae-f2fa-0fae9b28ae9a@arm.com>
Date: Tue, 29 Jun 2021 19:10:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629173440.GA7556@willie-the-truck>
Content-Language: en-GB
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, andre.przywara@arm.com,
 iommu@lists.linux-foundation.org, maz@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On 2021-06-29 18:34, Will Deacon wrote:
> On Fri, Jun 18, 2021 at 05:24:49PM +0100, Robin Murphy wrote:
>> Arm Fast Models are still implementing legacy virtio-pci devices behind
>> the SMMU, which continue to be problematic as "real hardware" devices
>> (from the point of view of the simulated system) without the mitigating
>> VIRTIO_F_ACCESS_PLATFORM feature.
>>
>> Since we now have the ability to force passthrough on a device-specific
>> basis, let's use it to work around this particular oddity so that people
>> who just want to boot Linux on a model don't have to fiddle around with
>> things to avoid the SMMU getting in the way by default (and I don't have
>> to keep telling them which things...)
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
> 
> Any chance of getting the fastmodels updated instead? It feels like it
> has to happen *eventually*, and then there would be no need for this bodge.

If it's any consolation the JIRA ticket you raised in 2017 is still open...

Robin.

> 
> Will
> 
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 54b2f27b81d4..13cf16e8f45b 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2649,6 +2649,20 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>>   	}
>>   }
>>   
>> +static int arm_smmu_def_domain_type(struct device *dev)
>> +{
>> +	if (dev_is_pci(dev)) {
>> +		struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +		/* Legacy virtio-block devices on Arm Fast Models */
>> +		if (pdev->vendor == 0x1af4 && pdev->device == 0x1001 &&
>> +		    pdev->subsystem_vendor == 0x00ff && pdev->subsystem_device == 0x0002)
>> +			return IOMMU_DOMAIN_IDENTITY;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static struct iommu_ops arm_smmu_ops = {
>>   	.capable		= arm_smmu_capable,
>>   	.domain_alloc		= arm_smmu_domain_alloc,
>> @@ -2673,6 +2687,7 @@ static struct iommu_ops arm_smmu_ops = {
>>   	.sva_bind		= arm_smmu_sva_bind,
>>   	.sva_unbind		= arm_smmu_sva_unbind,
>>   	.sva_get_pasid		= arm_smmu_sva_get_pasid,
>> +	.def_domain_type	= arm_smmu_def_domain_type,
>>   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>>   	.owner			= THIS_MODULE,
>>   };
>> -- 
>> 2.25.1
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
