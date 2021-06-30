Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC6C11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 11:07:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3A861C75
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 11:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3A861C75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33B0C41480;
	Wed, 30 Jun 2021 11:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1WtEXY3lcJyO; Wed, 30 Jun 2021 11:07:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DBA2A4147E;
	Wed, 30 Jun 2021 11:07:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD2CAC001A;
	Wed, 30 Jun 2021 11:07:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34FE9C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 11:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EDD4406A1
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 11:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QTz7h35DLdP5 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 11:07:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id E04754148E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 11:07:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA73411D4;
 Wed, 30 Jun 2021 04:07:10 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E6D33F5A1;
 Wed, 30 Jun 2021 04:07:08 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add default domain quirk for Arm Fast
 Models
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
References: <bf7020acf5ca7306a51d1950e3ff2afe2229e037.1624032324.git.robin.murphy@arm.com>
 <20210629173440.GA7556@willie-the-truck> <87h7hfybmb.wl-maz@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <60c3dccb-b6a8-2f04-7994-80d51a70d49f@arm.com>
Date: Wed, 30 Jun 2021 12:07:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87h7hfybmb.wl-maz@kernel.org>
Content-Language: en-GB
Cc: mark.rutland@arm.com, andre.przywara@arm.com,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
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

On 2021-06-30 09:56, Marc Zyngier wrote:
> On Tue, 29 Jun 2021 18:34:40 +0100,
> Will Deacon <will@kernel.org> wrote:
>>
>> On Fri, Jun 18, 2021 at 05:24:49PM +0100, Robin Murphy wrote:
>>> Arm Fast Models are still implementing legacy virtio-pci devices behind
>>> the SMMU, which continue to be problematic as "real hardware" devices
>>> (from the point of view of the simulated system) without the mitigating
>>> VIRTIO_F_ACCESS_PLATFORM feature.
>>>
>>> Since we now have the ability to force passthrough on a device-specific
>>> basis, let's use it to work around this particular oddity so that people
>>> who just want to boot Linux on a model don't have to fiddle around with
>>> things to avoid the SMMU getting in the way by default (and I don't have
>>> to keep telling them which things...)
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>
>> Any chance of getting the fastmodels updated instead? It feels like it
>> has to happen *eventually*, and then there would be no need for this bodge.
> 
> That'd be ideal. What are the chances of that happening before the Sun
> turns into a black hole?

We'll try making some noise again internally and see where that goes, 
but given the progress over the last 4 years I'd be inclined to posit a 
new theory of the universe eventually ending in one giant event 0x10.

>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 54b2f27b81d4..13cf16e8f45b 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -2649,6 +2649,20 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>>>   	}
>>>   }
>>>   
>>> +static int arm_smmu_def_domain_type(struct device *dev)
>>> +{
>>> +	if (dev_is_pci(dev)) {
>>> +		struct pci_dev *pdev = to_pci_dev(dev);
>>> +
>>> +		/* Legacy virtio-block devices on Arm Fast Models */
>>> +		if (pdev->vendor == 0x1af4 && pdev->device == 0x1001 &&
>>> +		    pdev->subsystem_vendor == 0x00ff && pdev->subsystem_device == 0x0002)
>>> +			return IOMMU_DOMAIN_IDENTITY;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
> 
> Could this be expressed as a PCI quirk instead? It would at least keep
> the ID matching out of the SMMU driver...

I don't think so - getting the information from the PCI layer to the 
IOMMU layer at the right place and time to influence the default domain 
choice would seemingly need some uglier and even less popular 
infrastructure adding. It's something that only the IOMMU layer has any 
need to be aware of, and the def_domain_type callback essentially exists 
for this kind of special-casing - compare intel-iommu's 
device_def_domain_type() for example. If we accept a workaround at all, 
I do believe this is the least-worst option.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
