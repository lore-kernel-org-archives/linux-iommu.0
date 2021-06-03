Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FA9C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:27:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B98613E7
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B98613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5593E400EF;
	Thu,  3 Jun 2021 11:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7FIw_IObwoK; Thu,  3 Jun 2021 11:27:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC1C7400E7;
	Thu,  3 Jun 2021 11:27:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD1CFC000E;
	Thu,  3 Jun 2021 11:27:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 438EDC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C2AF400EB
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:27:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uEnguaqIay-5 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 11:27:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13423400E7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:27:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755B11063;
 Thu,  3 Jun 2021 04:27:33 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7189B3F774;
 Thu,  3 Jun 2021 04:27:31 -0700 (PDT)
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Jon Nettleton <jon@solid-run.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <CABdtJHvo7HZ0R1EzLrN2gVKfgcBWz5YRU-KSg==xvHR-01KWkw@mail.gmail.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <32dc72fa-534a-7eb4-dfcc-9bc244845a28@arm.com>
Date: Thu, 3 Jun 2021 12:27:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABdtJHvo7HZ0R1EzLrN2gVKfgcBWz5YRU-KSg==xvHR-01KWkw@mail.gmail.com>
Content-Language: en-GB
Cc: Linuxarm <linuxarm@huawei.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, wanghuiqiang <wanghuiqiang@huawei.com>,
 Hanjun Guo <guohanjun@huawei.com>, yangyicong <yangyicong@huawei.com>,
 Sami.Mujawar@arm.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 03/06/2021 09:52, Jon Nettleton wrote:
> On Mon, May 24, 2021 at 1:04 PM Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com> wrote:
>>
>> From: Jon Nettleton <jon@solid-run.com>
>>
>> Check if there is any RMR info associated with the devices behind
>> the SMMU and if any, install bypass SMRs for them. This is to
>> keep any ongoing traffic associated with these devices alive
>> when we enable/reset SMMU during probe().
>>
>> Signed-off-by: Jon Nettleton <jon@solid-run.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 6f72c4d208ca..56db3d3238fc 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
>>         return err;
>>  }
>>
>> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
>> +{
>> +       struct list_head rmr_list;
>> +       struct iommu_resv_region *e;
>> +       int i, cnt = 0;
>> +       u32 smr;
>> +       u32 reg;
>> +
>> +       INIT_LIST_HEAD(&rmr_list);
>> +       if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
>> +               return;
>> +
>> +       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
>> +
>> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
>> +               /*
>> +                * SMMU is already enabled and disallowing bypass, so preserve
>> +                * the existing SMRs
>> +                */
>> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
>> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
>> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
>> +                               continue;
>> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
>> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
>> +                       smmu->smrs[i].valid = true;
>> +               }
>> +       }
>> +
>> +       list_for_each_entry(e, &rmr_list, list) {
>> +               u32 sid = e->fw_data.rmr.sid;
>> +
>> +               i = arm_smmu_find_sme(smmu, sid, ~0);
>> +               if (i < 0)
>> +                       continue;
>> +               if (smmu->s2crs[i].count == 0) {
>> +                       smmu->smrs[i].id = sid;
>> +                       smmu->smrs[i].mask = ~0;

Looking at this code again, that mask looks wrong! According to the SMMU
spec MASK[i]==1 means ID[i] is ignored. I.e. this means completely
ignore the ID...

I'm not at all sure why they designed the hardware that way round.

>> +                       smmu->smrs[i].valid = true;
>> +               }
>> +               smmu->s2crs[i].count++;
>> +               smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
>> +               smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
>> +               smmu->s2crs[i].cbndx = 0xff;
>> +
>> +               cnt++;
>> +       }
>> +
>> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
>> +               /* Remove the valid bit for unused SMRs */
>> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
>> +                       if (smmu->s2crs[i].count == 0)
>> +                               smmu->smrs[i].valid = false;
>> +               }
>> +       }
>> +
>> +       dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
>> +                  cnt == 1 ? "" : "s");
>> +       iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
>> +}
>> +
>>  static int arm_smmu_device_probe(struct platform_device *pdev)
>>  {
>>         struct resource *res;
>> @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>         }
>>
>>         platform_set_drvdata(pdev, smmu);
>> +
>> +       /* Check for RMRs and install bypass SMRs if any */
>> +       arm_smmu_rmr_install_bypass_smr(smmu);
>> +
>>         arm_smmu_device_reset(smmu);
>>         arm_smmu_test_smr_masks(smmu);
>>
>> --
>> 2.17.1
>>
> 
> Shameer and Robin
> 
> I finally got around to updating edk2 and the HoneyComb IORT tables to
> reflect the new standards.
> Out of the box the new patchset was generating errors immediatly after
> the smmu bringup.
> 
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x2080000140,
> fsynr=0x1d0040, cbfrsynra=0x4000, cb=0
> 
> These errors were generated even with disable_bypass=0
> 
> I tracked down the issue to
> 
> This code is skipped as Robin said would be correct

If you're skipping the first bit of code, then that (hopefully) means
that the SMMU is disabled...

>> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
>> +               /*
>> +                * SMMU is already enabled and disallowing bypass, so preserve
>> +                * the existing SMRs
>> +                */
>> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
>> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
>> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
>> +                               continue;
>> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
>> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
>> +                       smmu->smrs[i].valid = true;
>> +               }[    2.707729] arm-smmu: setting up rmr list on 0x4000
> [    2.712598] arm-smmu: s2crs count is 0 smrs index 0x0
> [    2.717638] arm-smmu: s2crs count is 0 smrs id is 0x4000
> [    2.722939] arm-smmu: s2crs count is 0 smrs mask is 0x8000
> [    2.728417] arm-smmu arm-smmu.0.auto:        preserved 1 boot mapping
> 
>> +       }
> 
> Then this code block was hit which is correct
> 
>> +               if (smmu->s2crs[i].count == 0) {
>> +                       smmu->smrs[i].id = sid;
>> +                       smmu->smrs[i].mask = ~0;
>> +                       smmu->smrs[i].valid = true;
>> +               }
> 
> The mask was causing the issue.  If I think ammended that segment to read
> the mask as setup by the hardware everything was back to functioning both
> with and without disable_bypass set.

...so reading a mask from it doesn't sounds quite right.

Can you have a go with a corrected mask of '0' rather than all-1s and
see if that helps? My guess is that the mask of ~0 was causing multiple
matches in the SMRs which is 'UNPREDICTABLE'.

Sadly in my test setup there's only the one device behind the SMMU so
I didn't spot this (below patch works for me, but that's not saying
much).

Steve

--->8---
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 56db3d3238fc..44831d0c78e4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2079,7 +2079,7 @@ static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
                        continue;
                if (smmu->s2crs[i].count == 0) {
                        smmu->smrs[i].id = sid;
-                       smmu->smrs[i].mask = ~0;
+                       smmu->smrs[i].mask = 0;
                        smmu->smrs[i].valid = true;
                }
                smmu->s2crs[i].count++;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
