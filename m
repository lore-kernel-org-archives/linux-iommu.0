Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E15FC47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 08:53:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10056613E7
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 08:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10056613E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D721E40510;
	Thu,  3 Jun 2021 08:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BkGGbh9cgRWG; Thu,  3 Jun 2021 08:53:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A606400DB;
	Thu,  3 Jun 2021 08:53:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7604DC000D;
	Thu,  3 Jun 2021 08:53:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D951C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 08:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 515E583E45
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 08:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C1pv4GNNZufO for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 08:53:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52D0A83E1F
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 08:53:31 +0000 (UTC)
Received: by mail-vs1-xe32.google.com with SMTP id i29so2591394vsr.11
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Myemz5k16Nb16eM+VNAAZnl9WcdJHNpws7yrBRTSzQ8=;
 b=FIiLMwkjVLQwvIDeLZi02NT81EiYl8Vfp2TJ4+4aniF2IcsesHL+BydP/wXTPVWmgI
 SBAcJ2BAoTaOeIrGslJ5XmYP49OoR3Tu4uRa3pvDMs5SBYgCy+yG4VRr4v6lMaBYnDLc
 SKOeIG230/Eizv18tylHUlXlsoTt3u48K+zr+c9e31PVBp+K0OMj/IAUWRemEvdT+Or1
 p1zgDyza8IIruANBM7NvSo8ggNoATA7iKA4qQO+XsS0UTBvAR6KHhUpDQo/0CcRjMH3n
 mOIamavU9Bjb/bEFlzcfgqPwYMjHD5VeKXFFJyQKqgskoI/jocKzYi8bTUUQCfuW9xer
 xung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Myemz5k16Nb16eM+VNAAZnl9WcdJHNpws7yrBRTSzQ8=;
 b=hQWXTaxCl9WRDDogT6DIzQ5gQfmpQJ/g5JIOTTyrh2npcMvaeqJbazUM+yqZm6sEgK
 QUSNp6jZza9Xlb1XRkag3eCxuNlmB7BP0pRgTgK2+uPQZUu4NxbjqsYlB3+rHurPGwmE
 /LY8Fwti4d/6CJhWO5Xwz+BGJ54k/xL8EAsQEvDzPwxKbccipcVwXyg9tsFUKpqUtWFg
 kjwx3dsT/ciT6XYBOLH7Cz2BDcFdP2CuMZC3rXaKxHXhg+ThQKbVkFTPSOEghe34Hrm5
 jLoLUNtxpQgQXtNHAz9eUS73bwCeZd0LUckh2Gehze+la1i2msQMZyAUIN5FiylJUZGU
 Rz8g==
X-Gm-Message-State: AOAM531M1Yq8UN4HxnbsD0R+rt66L5kVjQp2vMmy3Ju0e2PLQTpC04x0
 giqadbPqHaQ/s0ent2QWGWnpnZdlFbYrLgCBufo7tQ==
X-Google-Smtp-Source: ABdhPJxj+4IT8+6qr07qq87ubJ2nmPl8BZS/9F8+PlebID2YL/LATooVU+fmNI4LSTztODs2WUyyuopyqMoKE7EXvwM=
X-Received: by 2002:a67:b406:: with SMTP id x6mr7014288vsl.10.1622710410065;
 Thu, 03 Jun 2021 01:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Thu, 3 Jun 2021 10:52:53 +0200
Message-ID: <CABdtJHvo7HZ0R1EzLrN2gVKfgcBWz5YRU-KSg==xvHR-01KWkw@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
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

On Mon, May 24, 2021 at 1:04 PM Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> From: Jon Nettleton <jon@solid-run.com>
>
> Check if there is any RMR info associated with the devices behind
> the SMMU and if any, install bypass SMRs for them. This is to
> keep any ongoing traffic associated with these devices alive
> when we enable/reset SMMU during probe().
>
> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 6f72c4d208ca..56db3d3238fc 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
>         return err;
>  }
>
> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> +{
> +       struct list_head rmr_list;
> +       struct iommu_resv_region *e;
> +       int i, cnt = 0;
> +       u32 smr;
> +       u32 reg;
> +
> +       INIT_LIST_HEAD(&rmr_list);
> +       if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> +               return;
> +
> +       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> +
> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> +               /*
> +                * SMMU is already enabled and disallowing bypass, so preserve
> +                * the existing SMRs
> +                */
> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> +                               continue;
> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> +                       smmu->smrs[i].valid = true;
> +               }
> +       }
> +
> +       list_for_each_entry(e, &rmr_list, list) {
> +               u32 sid = e->fw_data.rmr.sid;
> +
> +               i = arm_smmu_find_sme(smmu, sid, ~0);
> +               if (i < 0)
> +                       continue;
> +               if (smmu->s2crs[i].count == 0) {
> +                       smmu->smrs[i].id = sid;
> +                       smmu->smrs[i].mask = ~0;
> +                       smmu->smrs[i].valid = true;
> +               }
> +               smmu->s2crs[i].count++;
> +               smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> +               smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> +               smmu->s2crs[i].cbndx = 0xff;
> +
> +               cnt++;
> +       }
> +
> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> +               /* Remove the valid bit for unused SMRs */
> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> +                       if (smmu->s2crs[i].count == 0)
> +                               smmu->smrs[i].valid = false;
> +               }
> +       }
> +
> +       dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> +                  cnt == 1 ? "" : "s");
> +       iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> +}
> +
>  static int arm_smmu_device_probe(struct platform_device *pdev)
>  {
>         struct resource *res;
> @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>         }
>
>         platform_set_drvdata(pdev, smmu);
> +
> +       /* Check for RMRs and install bypass SMRs if any */
> +       arm_smmu_rmr_install_bypass_smr(smmu);
> +
>         arm_smmu_device_reset(smmu);
>         arm_smmu_test_smr_masks(smmu);
>
> --
> 2.17.1
>

Shameer and Robin

I finally got around to updating edk2 and the HoneyComb IORT tables to
reflect the new standards.
Out of the box the new patchset was generating errors immediatly after
the smmu bringup.

arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x2080000140,
fsynr=0x1d0040, cbfrsynra=0x4000, cb=0

These errors were generated even with disable_bypass=0

I tracked down the issue to

This code is skipped as Robin said would be correct

> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> +               /*
> +                * SMMU is already enabled and disallowing bypass, so preserve
> +                * the existing SMRs
> +                */
> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> +                               continue;
> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> +                       smmu->smrs[i].valid = true;
> +               }[    2.707729] arm-smmu: setting up rmr list on 0x4000
[    2.712598] arm-smmu: s2crs count is 0 smrs index 0x0
[    2.717638] arm-smmu: s2crs count is 0 smrs id is 0x4000
[    2.722939] arm-smmu: s2crs count is 0 smrs mask is 0x8000
[    2.728417] arm-smmu arm-smmu.0.auto:        preserved 1 boot mapping

> +       }

Then this code block was hit which is correct

> +               if (smmu->s2crs[i].count == 0) {
> +                       smmu->smrs[i].id = sid;
> +                       smmu->smrs[i].mask = ~0;
> +                       smmu->smrs[i].valid = true;
> +               }

The mask was causing the issue.  If I think ammended that segment to read
the mask as setup by the hardware everything was back to functioning both
with and without disable_bypass set.

Some debug from that section when it is working

[    2.712598] arm-smmu: s2crs count is 0 smrs index 0x0
[    2.717638] arm-smmu: s2crs count is 0 smrs id is 0x4000
[    2.722939] arm-smmu: s2crs count is 0 smrs mask is 0x8000
[    2.728417] arm-smmu arm-smmu.0.auto:        preserved 1 boot mapping

Robin if anything jumps out at you let me know, otherwise I will debug further.

-Jon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
