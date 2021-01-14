Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE81C433DB
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 16:30:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743642065E
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 16:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743642065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09BB386BB8;
	Thu, 14 Jan 2021 16:30:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4HdK6Nmkhch; Thu, 14 Jan 2021 16:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10EF386BB7;
	Thu, 14 Jan 2021 16:30:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5254C0893;
	Thu, 14 Jan 2021 16:30:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9242C013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 16:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E4AD586288
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 16:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RbwOLl3JMqPB for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 16:30:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AE79D85534
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 16:30:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCEAEED1;
 Thu, 14 Jan 2021 08:30:26 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D6C63F70D;
 Thu, 14 Jan 2021 08:30:25 -0800 (PST)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Handle duplicated Stream IDs from
 other masters
To: Ajay Kumar <ajaykumar.rs1989@gmail.com>
References: <CGME20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b@epcas5p1.samsung.com>
 <20210107093340.15279-1-ajaykumar.rs@samsung.com>
 <20210107130319.GA2986@willie-the-truck>
 <5e047da1-6619-c716-927c-ae07a90f1597@arm.com>
 <CADe9J7Er0wnP5ZZbWM1CkUx7ry0znKr05Lvx7PEMdHuwKr_RZQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a47fbbc0-e904-006b-9bc4-92eca915f76b@arm.com>
Date: Thu, 14 Jan 2021 16:30:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CADe9J7Er0wnP5ZZbWM1CkUx7ry0znKr05Lvx7PEMdHuwKr_RZQ@mail.gmail.com>
Content-Language: en-GB
Cc: mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>, robh+dt@kernel.org,
 Will Deacon <will@kernel.org>, Ajay Kumar <ajaykumar.rs@samsung.com>,
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

On 2021-01-12 20:29, Ajay Kumar wrote:
> On Tue, Jan 12, 2021 at 12:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-01-07 13:03, Will Deacon wrote:
>>> On Thu, Jan 07, 2021 at 03:03:40PM +0530, Ajay Kumar wrote:
>>>> When PCI function drivers(ex:pci-endpoint-test) are probed for already
>>>> initialized PCIe-RC(Root Complex), and PCIe-RC is already bound to SMMU,
>>>> then we encounter a situation where the function driver tries to attach
>>>> itself to the smmu with the same stream-id as PCIe-RC and re-initialize
>>>> an already initialized STE. This causes ste_live BUG_ON() in the driver.
>>
>> Note that this is actually expected behaviour, since Stream ID aliasing
>> has remained officially not supported until a sufficiently compelling
>> reason to do so appears. I always thought the most likely scenario would
>> be a legacy PCI bridge with multiple devices behind it, but even that
>> seems increasingly improbable for a modern SMMUv3-based system to ever see.
> Thanks to Will and Robin for reviewing this. I am pretty new to PCI,
> sorry about that.
> I assumed that the support for stream-id alias is already handled as
> part of this patch:
> https://www.spinics.net/lists/arm-kernel/msg626087.html
> which prevents STE re-initialization. But, what I do not understand is
> why the path
> taken by the arm-smmu-v3 driver misses the aforementioned check for my usecase.

That case is where a single device, due to combinations of PCI DMA 
aliasing conditions, has multiple IDs of its own, and two or more of 
those IDs also happen to end up the same as each other. What you have is 
two distinct devices both claiming the same ID, since apparently they 
both represent the same underlying physical device (I don't know how the 
endpoint and pcieport drivers interoperate and/or coexist, but I can 
easily imagine that some liberties may be taken that the IOMMU layer 
doesn't really anticipate).

>>> I don't understand why the endpoint is using the same stream ID as the root
>>> complex in this case. Why is that? Is the grouping logic not working
>>> properly?
>>
>> It's not so much that it isn't working properly, it's more that it needs
>> to be implemented at all ;)
> The pci_endpoint_test picks up the same of_ DMA config node as the PCI RC
> because they sit on the same PCI bus [via pci_dma_configure( )]
> While in the arm-smmu-v3 driver, I can see that the pci_device_group( ) hands
> over the same iommu group as the Root Complex to the newly added master
> device (pci_endpoint_test in our case) because they share the same stream ID.
> Shouldn't they?

I'd imagine it's most likely that the PCI grouping rules are just 
putting everything together due to a lack of ACS. Either way, I'm pretty 
sure the PCI logic *doesn't* consider actual PCI devices having 
overlapping Requester IDs, because that isn't a real thing (how would 
config accesses work?). You can consider yourself lucky that the devices 
do happen to be grouped already in your particular case, but that 
doesn't change the fact that there's basically no point in trying to 
handle Stream ID aliasing within groups without properly implementing 
the grouping-by-Stream-ID logic in the first place (note that even 
distinct ACS-isolated PCI endpoints could still alias beyond the host 
bridge at the SMMU input if the system's translation from Requester ID 
space to Stream ID space isn't 1:1)

>>>> There is an already existing check in the driver to manage duplicated ids
>>>> if duplicated ids are added in same master device, but there can be
>>>> scenarios like above where we need to extend the check for other masters
>>>> using the same stream-id.
>>>>
>>>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++++
>>>>    1 file changed, 33 insertions(+)
>>>
>>> It doesn't feel like the driver is the right place to fix this, as the same
>>> issue could surely occur for other IOMMUs too, right? In which case, I think
>>> we should avoid getting into the situation where different groups have
>>> overlapping stream IDs.
>>
>> Yes, this patch does not represent the correct thing to do either way.
>> The main reason that Stream ID aliasing hasn't been supported so far is
>> that the required Stream ID to group lookup is rather awkward, and
>> adding all of that complexity just for the sake of a rather unlikely
>> possibility seemed dubious. However, PRI support has always had a more
>> pressing need to implement almost the same thing (Stream ID to device),
>> so once that lands we can finally get round to adding the rest of proper
>> group support relatively easily.
> I hope the support will be added soon. Also, can you point me to few drivers
> which already handle this type of stream-ID aliasing?

We handle it in the SMMUv2 driver - the way that architecture does 
stream mapping makes it really easy to hang group pointers off the S2CRs 
and have arm_smmu_master_alloc_smes() and arm_smmu_device_group() work 
nicely together. Unfortunately it's not feasible to take the same 
approach for SMMUv3, since the Stream Table there may be up to 2^32 
entries (vs. up to 128 S2CRs), and there just isn't enough room to 
encode a group pointer directly in an STE itself (you don't want to 
imagine how much time I've spent trying to think up schemes for that...)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
