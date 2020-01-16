Return-Path: <SRS0=QvS0=3F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4D8C33CB1
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 12:14:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074CF207FF
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 12:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074CF207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D1D3E86937;
	Thu, 16 Jan 2020 12:14:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MA-O0mxK-Pe9; Thu, 16 Jan 2020 12:14:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 01D53838D9;
	Thu, 16 Jan 2020 12:14:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA079C1D81;
	Thu, 16 Jan 2020 12:14:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C339C077D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 12:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8A6C7214E9
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 12:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id urgmE9MYVZwv for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jan 2020 12:14:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 682E72042B
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 12:14:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7B61396;
 Thu, 16 Jan 2020 04:14:46 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1BA33F534;
 Thu, 16 Jan 2020 04:14:45 -0800 (PST)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support
To: Auger Eric <eric.auger@redhat.com>, Rob Herring <robh@kernel.org>
References: <20200113143924.11576-1-robh@kernel.org>
 <2ee87a12-1a0e-bd48-0209-b5e205342d44@redhat.com>
 <CAL_JsqKrh0nLuoRgi1-bKyEErwCFpWPRPNVDuoeJrbFMCz60KQ@mail.gmail.com>
 <bc72f4c5-de47-8684-c7d5-0e60a4a78ee2@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <817c6ce6-4cf4-9cf2-1d3b-b94eb8120247@arm.com>
Date: Thu, 16 Jan 2020 12:14:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <bc72f4c5-de47-8684-c7d5-0e60a4a78ee2@redhat.com>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>,
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

On 2020-01-15 4:32 pm, Auger Eric wrote:
> Hi Rob,
> 
> On 1/15/20 3:02 PM, Rob Herring wrote:
>> On Wed, Jan 15, 2020 at 3:21 AM Auger Eric <eric.auger@redhat.com> wrote:
>>>
>>> Hi Rob,
>>>
>>> On 1/13/20 3:39 PM, Rob Herring wrote:
>>>> Arm SMMUv3.2 adds support for TLB range invalidate operations.
>>>> Support for range invalidate is determined by the RIL bit in the IDR3
>>>> register.
>>>>
>>>> The range invalidate is in units of the leaf page size and operates on
>>>> 1-32 chunks of a power of 2 multiple pages. First we determine from the
>>>> size what power of 2 multiple we can use and then adjust the granule to
>>>> 32x that size.
>>>>
>>>> Cc: Eric Auger <eric.auger@redhat.com>
>>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>> Cc: Joerg Roedel <joro@8bytes.org>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>   drivers/iommu/arm-smmu-v3.c | 53 +++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 53 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>>> index e91b4a098215..8b6b3e2aa383 100644
>>>> --- a/drivers/iommu/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>>> @@ -70,6 +70,9 @@
>>>>   #define IDR1_SSIDSIZE                        GENMASK(10, 6)
>>>>   #define IDR1_SIDSIZE                 GENMASK(5, 0)
>>>>
>>>> +#define ARM_SMMU_IDR3                        0xc
>>>> +#define IDR3_RIL                     (1 << 10)
>>>> +
>>>>   #define ARM_SMMU_IDR5                        0x14
>>>>   #define IDR5_STALL_MAX                       GENMASK(31, 16)
>>>>   #define IDR5_GRAN64K                 (1 << 6)
>>>> @@ -327,9 +330,14 @@
>>>>   #define CMDQ_CFGI_1_LEAF             (1UL << 0)
>>>>   #define CMDQ_CFGI_1_RANGE            GENMASK_ULL(4, 0)
>>>>
>>>> +#define CMDQ_TLBI_0_NUM                      GENMASK_ULL(16, 12)
>>>> +#define CMDQ_TLBI_RANGE_NUM_MAX              32
>>>> +#define CMDQ_TLBI_0_SCALE            GENMASK_ULL(24, 20)
>>>>   #define CMDQ_TLBI_0_VMID             GENMASK_ULL(47, 32)
>>>>   #define CMDQ_TLBI_0_ASID             GENMASK_ULL(63, 48)
>>>>   #define CMDQ_TLBI_1_LEAF             (1UL << 0)
>>>> +#define CMDQ_TLBI_1_TTL                      GENMASK_ULL(9, 8)
>>>> +#define CMDQ_TLBI_1_TG                       GENMASK_ULL(11, 10)
>>>>   #define CMDQ_TLBI_1_VA_MASK          GENMASK_ULL(63, 12)
>>>>   #define CMDQ_TLBI_1_IPA_MASK         GENMASK_ULL(51, 12)
>>>>
>>>> @@ -455,9 +463,13 @@ struct arm_smmu_cmdq_ent {
>>>>                #define CMDQ_OP_TLBI_S2_IPA     0x2a
>>>>                #define CMDQ_OP_TLBI_NSNH_ALL   0x30
>>>>                struct {
>>>> +                     u8                      num;
>>>> +                     u8                      scale;
>>>>                        u16                     asid;
>>>>                        u16                     vmid;
>>>>                        bool                    leaf;
>>>> +                     u8                      ttl;
>>>> +                     u8                      tg;
>>>>                        u64                     addr;
>>>>                } tlbi;
>>>>
>>>> @@ -595,6 +607,7 @@ struct arm_smmu_device {
>>>>   #define ARM_SMMU_FEAT_HYP            (1 << 12)
>>>>   #define ARM_SMMU_FEAT_STALL_FORCE    (1 << 13)
>>>>   #define ARM_SMMU_FEAT_VAX            (1 << 14)
>>>> +#define ARM_SMMU_FEAT_RANGE_INV              (1 << 15)
>>>>        u32                             features;
>>>>
>>>>   #define ARM_SMMU_OPT_SKIP_PREFETCH   (1 << 0)
>>>> @@ -856,13 +869,21 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>>>                cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
>>>>                break;
>>>>        case CMDQ_OP_TLBI_NH_VA:
>>>> +             cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
>>>> +             cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
>>>>                cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
>>>>                cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
>>>> +             cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
>>>> +             cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
>>>>                cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
>>>>                break;
>>>>        case CMDQ_OP_TLBI_S2_IPA:
>>>> +             cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
>>>> +             cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
>>>>                cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
>>>>                cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
>>>> +             cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
>>>> +             cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TG, ent->tlbi.tg);
>>>>                cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_IPA_MASK;
>>>>                break;
>>>>        case CMDQ_OP_TLBI_NH_ASID:
>>>> @@ -2022,12 +2043,39 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
>>>>                cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
>>>>        }
>>>>
>>>> +     if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>>>> +             unsigned long tg, scale;
>>>> +
>>>> +             /* Get the leaf page size */
>>>> +             tg = __ffs(smmu_domain->domain.pgsize_bitmap);
>>> it is unclear to me why you can't set tg with the granule parameter.
>>
>> granule could be 2MB sections if THP is enabled, right?
> 
> Ah OK I thought it was a page size and not a block size.

In hindsight, @granule might be more accurately called @leaf_size - for 
a non-leaf invalidate, it should always be the actual granule (i.e. page 
size), per __arm_lpae_unmap(). Even if we're knocking out a level 1 
table, we don't walk the whole thing to find leaves at level 2 and/or 
level 1 to invalidate, we just knock out the range at page granularity 
to be safe. However for leaf invalidations we know exactly what we're 
taking out, so @granule may be a block size if appropriate (that 
definitely used to be the case, and I don't *think* the gather ops 
changed it).

> I requested this feature a long time ago for virtual SMMUv3. With
> DPDK/VFIO the guest was sending page TLB invalidation for each page
> (granule=4K or 64K) part of the hugepage buffer and those were trapped
> by the VMM. This stalled qemu.

Heh, I remember that being awkward to comment on at the time since we 
were already speccing out 3.2 internally :)

Robin.

>>>> +
>>>> +             /* Determine the power of 2 multiple number of pages */
>>>> +             scale = __ffs(size / (1UL << tg));
>>>> +             cmd.tlbi.scale = scale;
>>>> +
>>>> +             cmd.tlbi.num = CMDQ_TLBI_RANGE_NUM_MAX - 1;
>>> Also could you explain why you use CMDQ_TLBI_RANGE_NUM_MAX.
>>
>> How's this:
>> /* The invalidation loop defaults to the maximum range */
> I would have expected num=0 directly. Don't we invalidate the &size in
> one shot as 2^scale * pages of granularity @tg? I fail to understand
> when NUM > 0.
> 
> 
> Thanks
> 
> Eric
>>
>> And perhaps I'll move it next to setting granule.
>>
>>>> +
>>>> +             /* Convert page size of 12,14,16 (log2) to 1,2,3 */
>>>> +             cmd.tlbi.tg = ((tg - ilog2(SZ_4K)) / 2) + 1;
>>>> +
>>>> +             /* Determine what level the granule is at */
>>>> +             cmd.tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>>>> +
>>>> +             /* Adjust granule to the maximum range */
>>>> +             granule = CMDQ_TLBI_RANGE_NUM_MAX * (1 << scale) * (1UL << tg);
>>> spec says
>>> Range = ((NUM+1)*2 ^ SCALE )*Translation_Granule_Size
>>
>> (NUM+1) can be 1-32. I went with the logical max for
>> CMDQ_TLBI_RANGE_NUM_MAX rather than the NUM field value max.
>>
>> Rob
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
