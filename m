Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB89CC11F66
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 13:23:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4EF61DC2
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 13:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4EF61DC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 194CD402B8;
	Tue, 29 Jun 2021 13:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WVi23vMsB5Oy; Tue, 29 Jun 2021 13:23:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35D6A4046E;
	Tue, 29 Jun 2021 13:23:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3B05C001B;
	Tue, 29 Jun 2021 13:23:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6EF4C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 13:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B442F4045E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 13:23:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5SOcMbgmy5Z9 for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 13:23:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 444BE402B8
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 13:23:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43A0D106F;
 Tue, 29 Jun 2021 06:22:58 -0700 (PDT)
Received: from [10.57.46.146] (unknown [10.57.46.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 906FD3F718;
 Tue, 29 Jun 2021 06:22:56 -0700 (PDT)
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Jon Nettleton <jon@solid-run.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
 <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b33c1525-5a74-a985-fd39-f4df8614f210@arm.com>
Date: Tue, 29 Jun 2021 14:22:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
Content-Language: en-GB
Cc: Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, wanghuiqiang <wanghuiqiang@huawei.com>,
 Hanjun Guo <guohanjun@huawei.com>, yangyicong <yangyicong@huawei.com>,
 Sami.Mujawar@arm.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On 2021-06-29 08:03, Jon Nettleton wrote:
> On Mon, Jun 14, 2021 at 12:06 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-05-24 12:02, Shameer Kolothum wrote:
>>> From: Jon Nettleton <jon@solid-run.com>
>>>
>>> Check if there is any RMR info associated with the devices behind
>>> the SMMU and if any, install bypass SMRs for them. This is to
>>> keep any ongoing traffic associated with these devices alive
>>> when we enable/reset SMMU during probe().
>>>
>>> Signed-off-by: Jon Nettleton <jon@solid-run.com>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
>>>    1 file changed, 65 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> index 6f72c4d208ca..56db3d3238fc 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
>>>        return err;
>>>    }
>>>
>>> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
>>> +{
>>> +     struct list_head rmr_list;
>>> +     struct iommu_resv_region *e;
>>> +     int i, cnt = 0;
>>> +     u32 smr;
>>> +     u32 reg;
>>> +
>>> +     INIT_LIST_HEAD(&rmr_list);
>>> +     if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
>>> +             return;
>>> +
>>> +     reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
>>> +
>>> +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
>>> +             /*
>>> +              * SMMU is already enabled and disallowing bypass, so preserve
>>> +              * the existing SMRs
>>> +              */
>>> +             for (i = 0; i < smmu->num_mapping_groups; i++) {
>>> +                     smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
>>
>> To reiterate, just because a bootloader/crashed kernel/whatever may have
>> left some configuration behind doesn't mean that it matters (e.g. what
>> if these SMRs are pointing at translation contexts?). All we should be
>> doing here is setting the relevant RMR accommodations in our "clean
>> slate" software state before the reset routine applies it to the
>> hardware, just like patch #5 does for SMMUv3.
>>
>> Trying to safely reset an SMMU when we discover it with CLIENTPD=0 is
>> really another issue entirely, and I'd say is beyond the scope of this
>> series
>>
>>> +                     if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
>>> +                             continue;
>>
>> Note that that's not even necessarily correct (thanks to EXIDS).
>>
>>> +                     smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
>>> +                     smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
>>> +                     smmu->smrs[i].valid = true;
>>> +             }
>>> +     }
>>> +
>>> +     list_for_each_entry(e, &rmr_list, list) {
>>> +             u32 sid = e->fw_data.rmr.sid;
>>> +
>>> +             i = arm_smmu_find_sme(smmu, sid, ~0);
>>> +             if (i < 0)
>>> +                     continue;
>>> +             if (smmu->s2crs[i].count == 0) {
>>> +                     smmu->smrs[i].id = sid;
>>> +                     smmu->smrs[i].mask = ~0;
>>
>> This is very wrong (as has now already been pointed out).
>>
>>> +                     smmu->smrs[i].valid = true;
>>> +             }
>>> +             smmu->s2crs[i].count++;
>>> +             smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
>>> +             smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
>>> +             smmu->s2crs[i].cbndx = 0xff;
>>
>> Nit: cbndx is left uninitialised for bypass/fault entries elsewhere, so
>> there's little point touching it here.
>>
>>> +
>>> +             cnt++;
>>> +     }
>>> +
>>> +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
>>> +             /* Remove the valid bit for unused SMRs */
>>> +             for (i = 0; i < smmu->num_mapping_groups; i++) {
>>> +                     if (smmu->s2crs[i].count == 0)
>>> +                             smmu->smrs[i].valid = false;
>>> +             }
>>
>> If this dance is only about avoiding stream match conflicts when trying
>> to reprogram live SMRs, simply turning the SMMU off beforehand would be
>> a lot simpler.
> 
> Robin,
> 
> I am not sure what you mean here, and maybe Steve wants to jump in and
> help clarify.
> 
> My understanding is that "dance" is required for regions that need to
> continue to work
> throughout the boot process.  I think the example I have seen the most
> is for GOP drivers that
> use system memory rather than dedicated VRAM.

All that is required is to install bypass SMEs for the relevant streams 
before enabling the SMMU. That much is achieved by the 
list_for_each_entry(e, &rmr_list, list) loop setting up initial state 
followed by arm_smmu_device_reset(). The "dance" I'm referring to is the 
additional reading out of (possibly nonsense) SMR state beforehand to 
pre-bias the SMR allocator, then trying to clean up the remnants afterwards.

If we're going to pretend to be robust against finding the SMMU already 
enabled *with* live traffic ongoing, there's frankly an awful lot more 
care we'd need to take beyond here (and for some aspects there's still 
no right answer). If on the other hand we're implicitly assuming that 
any boot-time enabled SMRs exactly match the RMR configuration anyway, 
then simply disabling the SMMU until we enable it again in the reset 
routine still preserves the necessary bypass behaviour for RMR streams 
while sidestepping any issues related to reprogramming live SMMU state.

Robin.

>>> +     }
>>> +
>>> +     dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
>>> +                cnt == 1 ? "" : "s");
>>> +     iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
>>> +}
>>> +
>>>    static int arm_smmu_device_probe(struct platform_device *pdev)
>>>    {
>>>        struct resource *res;
>>> @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>        }
>>>
>>>        platform_set_drvdata(pdev, smmu);
>>> +
>>> +     /* Check for RMRs and install bypass SMRs if any */
>>> +     arm_smmu_rmr_install_bypass_smr(smmu);
>>> +
>>>        arm_smmu_device_reset(smmu);
>>>        arm_smmu_test_smr_masks(smmu);
>>>
>>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
