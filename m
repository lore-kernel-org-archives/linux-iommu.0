Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DD8C433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 20:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B97841881;
	Tue, 19 Apr 2022 20:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ScXr4k1uu3qw; Tue, 19 Apr 2022 20:15:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B9ED541820;
	Tue, 19 Apr 2022 20:15:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9680CC002F;
	Tue, 19 Apr 2022 20:15:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5D8EC002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9BA9F403E5
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20gkP3wBCXin for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 20:15:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7DD44012D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:15:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F401E1063;
 Tue, 19 Apr 2022 13:15:52 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B021B3F73B;
 Tue, 19 Apr 2022 13:15:50 -0700 (PDT)
Message-ID: <2768d617-1c61-3b12-e32f-3901881ebe3d@arm.com>
Date: Tue, 19 Apr 2022 21:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
 <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
 <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
 <Yloj6GM+yykImKvp@Asurada-Nvidia> <20220419200233.GN64706@ziepe.ca>
 <Yl8WF9R7tubSgREw@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yl8WF9R7tubSgREw@Asurada-Nvidia>
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, christophe.jaillet@wanadoo.fr,
 tglx@linutronix.de, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2022-04-19 21:05, Nicolin Chen wrote:
> On Tue, Apr 19, 2022 at 05:02:33PM -0300, Jason Gunthorpe wrote:
> 
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> index d816759a6bcf..e280568bb513 100644
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>> @@ -183,7 +183,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>>>   {
>>>          struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
>>>          struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
>>> -       size_t size = end - start + 1;
>>> +       size_t size = end - start;
>>
>> +1 to this bug fix. You should send a formal patch for stable with a fixes/etc
>>
>> mmu notifiers uses 'end' not 'last' in alignment with how VMA's work:
>>
>> include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address
> 
> Thanks for the review!
> 
> Yea, I will send a new patch.

Yup, +1 from me too - this is exactly the kind of thing I suspected - 
and I reckon it might even be worth a comment in the code here that mm's 
"end" is an exclusive limit, to help us remember in future. If there 
doesn't look to be any way for completely arbitrarily-aligned addresses 
to slip through then I'd be tempted to leave it at that (i.e. reason 
that if the infinite loop can only happen due to catastrophic failure 
then it's beyond the scope of things that are worth trying to mitigate), 
but I'll let Jean and Will have the final say there.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
