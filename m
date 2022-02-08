Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247E5C433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 15:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7DA660ED9;
	Tue,  8 Feb 2022 15:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUMep_jDf7ME; Tue,  8 Feb 2022 15:28:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E25B606FF;
	Tue,  8 Feb 2022 15:28:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 678C3C0011;
	Tue,  8 Feb 2022 15:28:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B611AC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 15:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A42CD60A46
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 15:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVpjWuOVVOsZ for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 15:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1F0E606FF
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 15:28:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A18B2B;
 Tue,  8 Feb 2022 07:28:57 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02BD33F73B;
 Tue,  8 Feb 2022 07:28:54 -0800 (PST)
Message-ID: <f54af077-41a3-e8c3-4349-ecc7f83520a4@arm.com>
Date: Tue, 8 Feb 2022 15:28:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] iommu/arm-smmu: Use platform_irq_count() to get the
 interrupt count
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
References: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
 <20220208151932.GB1802@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220208151932.GB1802@willie-the-truck>
Cc: Rob Clark <robdclark@chromium.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>, Xin Tan <tanxin.ctf@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Prabhakar <prabhakar.csengg@gmail.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
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

On 2022-02-08 15:19, Will Deacon wrote:
> On Thu, Dec 23, 2021 at 02:14:35PM +0000, Robin Murphy wrote:
>> On 2021-12-23 13:00, Lad Prabhakar wrote:
>>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
>>> allocation of IRQ resources in DT core code, this causes an issue
>>> when using hierarchical interrupt domains using "interrupts" property
>>> in the node as this bypasses the hierarchical setup and messes up the
>>> irq chaining.
>>>
>>> In preparation for removal of static setup of IRQ resource from DT core
>>> code use platform_get_irq_count().
>>
>> Nit: platform_irq_count()
>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++------
>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> index 4bc75c4ce402..4844cd075644 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -2105,12 +2105,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>    	if (IS_ERR(smmu))
>>>    		return PTR_ERR(smmu);
>>> -	num_irqs = 0;
>>> -	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
>>> -		num_irqs++;
>>> -		if (num_irqs > smmu->num_global_irqs)
>>> -			smmu->num_context_irqs++;
>>> -	}
>>> +	num_irqs = platform_irq_count(pdev);
>>> +	if (num_irqs < 0)
>>> +		return num_irqs;
>>> +
>>> +	if (num_irqs > smmu->num_global_irqs)
>>> +		smmu->num_context_irqs += (num_irqs - smmu->num_global_irqs);
>>
>> This seems a bit overcomplicated. I reckon:
>>
>> 	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
>> 	if (num_irqs <= smmu->num_global_irqs) {
>> 		dev_err(...
>>
>> should do it.
>>
>> However, FYI I have some patches refactoring most of the IRQ stuff here that
>> I plan to post next cycle (didn't quite have time to get them done for 5.17
>> as I'd hoped...), so unless this needs to go in right now as an urgent fix,
>> I'm happy to take care of removing platform_get_resource() as part of that
>> if it's easier.
> 
> Did you get anywhere with this? December 23rd is long forgotten by now ;)

Yup: 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/b2a40caaf1622eb35c555074a0d72f4f0513cff9

I'm still cleaning up the PMU driver that justifies the whole thing, but 
I can send that patch now if you reckon it's not complete nonsense out 
of context. Otherwise, I'll aim to get the whole lot out next week.


Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
