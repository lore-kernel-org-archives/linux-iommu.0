Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7884C35657
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 17:19:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AB224650
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 17:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AB224650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4872C8440A;
	Fri, 21 Feb 2020 17:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2V6OSrmL85MW; Fri, 21 Feb 2020 17:19:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 96CFA834A3;
	Fri, 21 Feb 2020 17:19:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F4C8C1D81;
	Fri, 21 Feb 2020 17:19:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6351BC013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 17:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 529958440A
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 17:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zDZAfgcTlf-r for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 17:19:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3F324834A3
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 17:19:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6756B30E;
 Fri, 21 Feb 2020 09:19:34 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E1253F68F;
 Fri, 21 Feb 2020 09:19:33 -0800 (PST)
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation
 support
To: Rob Herring <robh@kernel.org>
References: <20200117211628.27888-1-robh@kernel.org>
 <2d04f201-3457-08ad-db8e-735f8315d74e@redhat.com>
 <7ac3f864-6c39-76e9-ee4a-21be03abc044@arm.com>
 <CAL_JsqJRSD-7U8UH1tevBdD2P6qPWzApQLpXU-SVBmZ8=Yiy0A@mail.gmail.com>
 <d49b62f2-74f4-c3e0-ad97-a4fedd169b27@arm.com>
 <CAL_JsqKY1_WmwLOKySwBasyZ5Kb=Rx-Y6m8bDppRKVxzoY58xg@mail.gmail.com>
 <49847ca9-3ee8-4c08-a772-a93f10aa817f@arm.com>
 <CAL_JsqJam8qO-XAfQTXNZ0y_gLdOx0LAX28XnKjXd2yh7y3_Uw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <67635b64-5db4-8425-e513-62d96a359906@arm.com>
Date: Fri, 21 Feb 2020 17:19:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJam8qO-XAfQTXNZ0y_gLdOx0LAX28XnKjXd2yh7y3_Uw@mail.gmail.com>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On 21/02/2020 4:47 pm, Rob Herring wrote:
> On Fri, Feb 21, 2020 at 10:19 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 20/02/2020 5:54 pm, Rob Herring wrote:
>>> On Mon, Feb 17, 2020 at 1:17 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 13/02/2020 9:49 pm, Rob Herring wrote:
>>>>> On Thu, Jan 30, 2020 at 11:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>>>
>>>>>> On 30/01/2020 3:06 pm, Auger Eric wrote:
>>>>>>> Hi Rob,
>>>>>>> On 1/17/20 10:16 PM, Rob Herring wrote:
>>>>>>>> Arm SMMUv3.2 adds support for TLB range invalidate operations.
>>>>>>>> Support for range invalidate is determined by the RIL bit in the IDR3
>>>>>>>> register.
>>>>>>>>
>>>>>>>> The range invalidate is in units of the leaf page size and operates on
>>>>>>>> 1-32 chunks of a power of 2 multiple pages. First, we determine from the
>>>>>>>> size what power of 2 multiple we can use. Then we calculate how many
>>>>>>>> chunks (1-31) of the power of 2 size for the range on the iteration. On
>>>>>>>> each iteration, we move up in size by at least 5 bits.
>>>>>>>>
>>>>>>>> Cc: Eric Auger <eric.auger@redhat.com>
>>>>>>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>>>>> Cc: Joerg Roedel <joro@8bytes.org>
>>>>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>>>
>>>>>
>>>>>>>> @@ -2003,7 +2024,7 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>>>>>>>>      {
>>>>>>>>         u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
>>>>>>>>         struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>>>>> -    unsigned long start = iova, end = iova + size;
>>>>>>>> +    unsigned long start = iova, end = iova + size, num_pages = 0, tg = 0;
>>>>>>>>         int i = 0;
>>>>>>>>         struct arm_smmu_cmdq_ent cmd = {
>>>>>>>>                 .tlbi = {
>>>>>>>> @@ -2022,12 +2043,50 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>>>>>>>>                 cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
>>>>>>>>         }
>>>>>>>>
>>>>>>>> +    if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>>>>>>>> +            /* Get the leaf page size */
>>>>>>>> +            tg = __ffs(smmu_domain->domain.pgsize_bitmap);
>>>>>>>> +
>>>>>>>> +            /* Convert page size of 12,14,16 (log2) to 1,2,3 */
>>>>>>>> +            cmd.tlbi.tg = ((tg - ilog2(SZ_4K)) / 2) + 1;
>>>>>>
>>>>>> Given the comment, I think "(tg - 10) / 2" would suffice ;)
>>>>>
>>>>> Well, duh...
>>>>>
>>>>>>
>>>>>>>> +
>>>>>>>> +            /* Determine what level the granule is at */
>>>>>>>> +            cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>>>>>>
>>>>>> Is it possible to rephrase that with logs and shifts to avoid the division?
>>>>>
>>>>> Well, with a loop is the only other way I came up with:
>>>>>
>>>>> bpl = tg - 3;
>>>>> ttl = 3;
>>>>> mask = BIT(bpl) - 1;
>>>>> while ((granule & (mask << ((4 - ttl) * bpl + 3))) == 0)
>>>>>        ttl--;
>>>>>
>>>>> Doesn't seem like much improvement to me given we have h/w divide...
>>>>
>>>> Sure, it doesn't take too many extra instructions to start matching
>>>> typical IDIV latency, so there's no point being silly if there really
>>>> isn't a clean alternative.
>>>>
>>>> Some quick scribbling suggests "4 - ilog2(granule) / 10" might actually
>>>> be close enough, but perhaps that's a bit too cheeky.
>>>
>>> How does divide by 10 save a divide?
>>
>> Well, by that point I was more just thinking about the smallest
>> expression, since *some* division seems unavoidable. Although GCC does
>> apparently still think that transforming constant division is a win ;)
> 
> Okay. Still, divide by 10 happens to work, but it is very much not
> obvious. It also doesn't work for level 1 and 16 or 64KB pages (though

(FWIW the more subtle part of the trick is that 16K doesn't allow level 
1 blocks, and even in the vanishingly unlikely 64K level 1 case TTL=0 
isn't "wrong")

> we'll never see that granule). Subtracting 3 is not that obvious
> either, but is at least in the spec for calculating the bits per
> level.
> 
> I think we've spent enough time micro-optimizing this and have better
> things to worry about.

Agreed! Invalidation performance has just been the bogeyman for so long 
that it's an area to which I've become overly sensitive.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
