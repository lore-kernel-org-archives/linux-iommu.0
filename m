Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92599C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:52:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F95613E3
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F95613E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BB2E4052F;
	Thu,  3 Jun 2021 11:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ldEmdrXG4kcS; Thu,  3 Jun 2021 11:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5BAA6400A7;
	Thu,  3 Jun 2021 11:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37666C000E;
	Thu,  3 Jun 2021 11:52:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B965BC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9247F400CA
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k7gphLnPi7hz for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 11:51:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C78B2400A7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:51:58 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id t3so6749037edc.7
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HFp854olGgFJmXGnnWOBlcDacyWdiAmNy6/uBhlQEwk=;
 b=Q6I36TVtig+AD1IxJypcOMC/R5GDbjL5rYHfQVI8voZFQQHheQ4fHGzCKFBi6rx+gP
 KSDv3H3vFKgsFVp97V0P312PEjXZem0GsixIc2VZ63rcV64kT53ylxZcZj8unJIX0bmV
 VUzXJUbn40RgN/lsT4QO9HcdDmycHjo8DLADYvyEcbmXVath15Bt5NDoMCwAiQde4dPf
 FFLh2nvJ7ud0SIb2ZSpbTsNm8pGXLIyZfvXWMTjaMEGJr9e0dJgVE5SLo5daSOKF7jvS
 au0scHdqkW/nteXgCpXxpGnXxsFHlTNccE1hGdx6a6olMN1WWFv9CA+vUePTEz0vGxcX
 BSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HFp854olGgFJmXGnnWOBlcDacyWdiAmNy6/uBhlQEwk=;
 b=MZnSoSEQ1nha/tt5P9YZGWx+2hYCxVUjbc+3c9fMMvKIG8uchB0XhK/GkYCN5GFMT1
 9FZfhOoKCn8gO6sYbu8rOIq5NAUIO8yTvu4YLALPMpjcgjn27c+mfxb+A72ApZC4aLaW
 Hbyt8xvcDrOssCp4mJMhlSXMblq79u10QmoAAOd2IeKjWYkwI1vZJMagPRw+niEqPRfB
 V6bxDeeqIU+FNUexsSI6m3J4zXhbo6HvPE4HtQn21wQ2i3p7r87e81YXEj3FFRm4P+rU
 YnaGoep5HqXbhNQD1Eis5YmNLjUKvZ2oYb3A0GP5fkyk6bAww6tdkvxiUOfGLkoES3R2
 pXSA==
X-Gm-Message-State: AOAM53126rHd70UwvhhxddnL85RI7w4hqzMFuLGZMOVqempkrgh1hCHH
 EApz+cw679prQiFY7fq7dAB+HUfWgH8iw0upYxI5SQ==
X-Google-Smtp-Source: ABdhPJwltdaiHIpT1D7VO6Zwu05x53ILY/BZkyb0KSc7UMu9ZmCBVI+CsB3LJQQfU7Vz0N4C/z2LGya+ya/1yRX0+sU=
X-Received: by 2002:aa7:db49:: with SMTP id n9mr24789379edt.361.1622721116921; 
 Thu, 03 Jun 2021 04:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <CABdtJHvo7HZ0R1EzLrN2gVKfgcBWz5YRU-KSg==xvHR-01KWkw@mail.gmail.com>
 <32dc72fa-534a-7eb4-dfcc-9bc244845a28@arm.com>
In-Reply-To: <32dc72fa-534a-7eb4-dfcc-9bc244845a28@arm.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Thu, 3 Jun 2021 13:51:19 +0200
Message-ID: <CABdtJHts-fO4pLU1VQddW0ra-tuh7s7j-eb3CJy6cFjv875UJg@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Steven Price <steven.price@arm.com>
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

On Thu, Jun 3, 2021 at 1:27 PM Steven Price <steven.price@arm.com> wrote:
>
> On 03/06/2021 09:52, Jon Nettleton wrote:
> > On Mon, May 24, 2021 at 1:04 PM Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com> wrote:
> >>
> >> From: Jon Nettleton <jon@solid-run.com>
> >>
> >> Check if there is any RMR info associated with the devices behind
> >> the SMMU and if any, install bypass SMRs for them. This is to
> >> keep any ongoing traffic associated with these devices alive
> >> when we enable/reset SMMU during probe().
> >>
> >> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >> ---
> >>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
> >>  1 file changed, 65 insertions(+)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >> index 6f72c4d208ca..56db3d3238fc 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >> @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
> >>         return err;
> >>  }
> >>
> >> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> >> +{
> >> +       struct list_head rmr_list;
> >> +       struct iommu_resv_region *e;
> >> +       int i, cnt = 0;
> >> +       u32 smr;
> >> +       u32 reg;
> >> +
> >> +       INIT_LIST_HEAD(&rmr_list);
> >> +       if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> >> +               return;
> >> +
> >> +       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> >> +
> >> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> >> +               /*
> >> +                * SMMU is already enabled and disallowing bypass, so preserve
> >> +                * the existing SMRs
> >> +                */
> >> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> >> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> >> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> >> +                               continue;
> >> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> >> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> >> +                       smmu->smrs[i].valid = true;
> >> +               }
> >> +       }
> >> +
> >> +       list_for_each_entry(e, &rmr_list, list) {
> >> +               u32 sid = e->fw_data.rmr.sid;
> >> +
> >> +               i = arm_smmu_find_sme(smmu, sid, ~0);
> >> +               if (i < 0)
> >> +                       continue;
> >> +               if (smmu->s2crs[i].count == 0) {
> >> +                       smmu->smrs[i].id = sid;
> >> +                       smmu->smrs[i].mask = ~0;
>
> Looking at this code again, that mask looks wrong! According to the SMMU
> spec MASK[i]==1 means ID[i] is ignored. I.e. this means completely
> ignore the ID...
>
> I'm not at all sure why they designed the hardware that way round.
>
> >> +                       smmu->smrs[i].valid = true;
> >> +               }
> >> +               smmu->s2crs[i].count++;
> >> +               smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> >> +               smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> >> +               smmu->s2crs[i].cbndx = 0xff;
> >> +
> >> +               cnt++;
> >> +       }
> >> +
> >> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> >> +               /* Remove the valid bit for unused SMRs */
> >> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> >> +                       if (smmu->s2crs[i].count == 0)
> >> +                               smmu->smrs[i].valid = false;
> >> +               }
> >> +       }
> >> +
> >> +       dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> >> +                  cnt == 1 ? "" : "s");
> >> +       iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> >> +}
> >> +
> >>  static int arm_smmu_device_probe(struct platform_device *pdev)
> >>  {
> >>         struct resource *res;
> >> @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >>         }
> >>
> >>         platform_set_drvdata(pdev, smmu);
> >> +
> >> +       /* Check for RMRs and install bypass SMRs if any */
> >> +       arm_smmu_rmr_install_bypass_smr(smmu);
> >> +
> >>         arm_smmu_device_reset(smmu);
> >>         arm_smmu_test_smr_masks(smmu);
> >>
> >> --
> >> 2.17.1
> >>
> >
> > Shameer and Robin
> >
> > I finally got around to updating edk2 and the HoneyComb IORT tables to
> > reflect the new standards.
> > Out of the box the new patchset was generating errors immediatly after
> > the smmu bringup.
> >
> > arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x2080000140,
> > fsynr=0x1d0040, cbfrsynra=0x4000, cb=0
> >
> > These errors were generated even with disable_bypass=0
> >
> > I tracked down the issue to
> >
> > This code is skipped as Robin said would be correct
>
> If you're skipping the first bit of code, then that (hopefully) means
> that the SMMU is disabled...
>
> >> +       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> >> +               /*
> >> +                * SMMU is already enabled and disallowing bypass, so preserve
> >> +                * the existing SMRs
> >> +                */
> >> +               for (i = 0; i < smmu->num_mapping_groups; i++) {
> >> +                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> >> +                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> >> +                               continue;
> >> +                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> >> +                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> >> +                       smmu->smrs[i].valid = true;
> >> +               }[    2.707729] arm-smmu: setting up rmr list on 0x4000
> > [    2.712598] arm-smmu: s2crs count is 0 smrs index 0x0
> > [    2.717638] arm-smmu: s2crs count is 0 smrs id is 0x4000
> > [    2.722939] arm-smmu: s2crs count is 0 smrs mask is 0x8000
> > [    2.728417] arm-smmu arm-smmu.0.auto:        preserved 1 boot mapping
> >
> >> +       }
> >
> > Then this code block was hit which is correct
> >
> >> +               if (smmu->s2crs[i].count == 0) {
> >> +                       smmu->smrs[i].id = sid;
> >> +                       smmu->smrs[i].mask = ~0;
> >> +                       smmu->smrs[i].valid = true;
> >> +               }
> >
> > The mask was causing the issue.  If I think ammended that segment to read
> > the mask as setup by the hardware everything was back to functioning both
> > with and without disable_bypass set.
>
> ...so reading a mask from it doesn't sounds quite right.
>
> Can you have a go with a corrected mask of '0' rather than all-1s and
> see if that helps? My guess is that the mask of ~0 was causing multiple
> matches in the SMRs which is 'UNPREDICTABLE'.
>
> Sadly in my test setup there's only the one device behind the SMMU so
> I didn't spot this (below patch works for me, but that's not saying
> much).
>
> Steve
>
> --->8---
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 56db3d3238fc..44831d0c78e4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2079,7 +2079,7 @@ static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
>                         continue;
>                 if (smmu->s2crs[i].count == 0) {
>                         smmu->smrs[i].id = sid;
> -                       smmu->smrs[i].mask = ~0;
> +                       smmu->smrs[i].mask = 0;
>                         smmu->smrs[i].valid = true;
>                 }
>                 smmu->s2crs[i].count++;

Yes this works fine. Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
