Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E935C433EF
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 14:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6B55605D5;
	Mon, 29 Nov 2021 14:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xe86q4VZBGyN; Mon, 29 Nov 2021 14:54:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B4D0860664;
	Mon, 29 Nov 2021 14:54:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CB57C001C;
	Mon, 29 Nov 2021 14:54:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA675C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 14:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B30A660664
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 14:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n4bVclvB0ogk for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 14:54:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFFB1605D5
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 14:54:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F18AD1042;
 Mon, 29 Nov 2021 06:54:25 -0800 (PST)
Received: from [10.57.34.182] (unknown [10.57.34.182])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D1C3F766;
 Mon, 29 Nov 2021 06:54:21 -0800 (PST)
Message-ID: <b192ad88-5e4e-6f32-1cc7-7a50fc0676a1@arm.com>
Date: Mon, 29 Nov 2021 14:54:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
Content-Language: en-GB
To: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
 <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com> <87czmjdnw9.ffs@tglx>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <87czmjdnw9.ffs@tglx>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
 Tero Kristo <kristo@kernel.org>, Megha Dey <megha.dey@intel.com>
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

On 2021-11-29 14:42, Thomas Gleixner wrote:
> On Mon, Nov 29 2021 at 13:13, Robin Murphy wrote:
>> On 2021-11-29 10:55, Will Deacon wrote:
>>>> -	}
>>>> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>>>> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
>>>> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>>>
>>> Prviously, if retrieval of the MSI failed then we'd fall back to wired
>>> interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
>>> we make the assignments to smmu->*irq here conditional on the MSI being
>>> valid, please?
>>
>> I was just looking at that too, but reached the conclusion that it's
>> probably OK, since consumption of this value later is gated on
>> ARM_SMMU_FEAT_PRI, so the fact that it changes from 0 to an error value
>> in the absence of PRI should make no practical difference.
> 
> It's actually 0 when the vector cannot be found.

Oh, -1 for my reading comprehension but +1 for my confidence in the 
patch then :)

I'll let Will have the final say over how cautious we really want to be 
here, but as far as I'm concerned it's a welcome cleanup as-is. Ditto 
for patch #32 based on the same reasoning, although I don't have a 
suitable test platform on-hand to sanity-check that one.

Cheers,
Robin.

>> If we don't have MSIs at all, we'd presumably still fail earlier
>> either at the dev->msi_domain check or upon trying to allocate the
>> vectors, so we'll still fall back to any previously-set wired values
>> before getting here.  The only remaining case is if we've
>> *successfully* allocated the expected number of vectors yet are then
>> somehow unable to retrieve one or more of them - presumably the system
>> has to be massively borked for that to happen, at which point do we
>> really want to bother trying to reason about anything?
> 
> Probably not. At that point something is going to explode sooner than
> later in colorful ways.
> 
> Thanks,
> 
>          tglx
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
