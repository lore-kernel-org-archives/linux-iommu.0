Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75086C11F66
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 07:04:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16A5611AB
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 07:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16A5611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA9956077A;
	Tue, 29 Jun 2021 07:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xrwuyuoi9gdD; Tue, 29 Jun 2021 07:04:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 88700605F6;
	Tue, 29 Jun 2021 07:04:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F331C0010;
	Tue, 29 Jun 2021 07:04:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8412C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 07:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE58940284
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 07:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nPDwgk8RjDiV for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 07:04:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE72E4027E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 07:04:36 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id nd37so34575927ejc.3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NYBTmnbrFY6e4uVDJho3HTMoNaiYI6JT+kpQ+czjgBc=;
 b=ubbHAgyQ+0/up/IYI6m2dbl28D92eV8V1EjvNKM2mtc2mwfewaWs651zFMwhO4/iUI
 V/QngHmNVz57v2VAELy6TB/A4Gs3HKFOsxSYkaPKMric5VI8q4e6RGpFxJl/PZRK1P1Z
 vQ4oWjoToo0geS57I9ByRm6DaObhdZWlbsgO7KhvRq26ssAgNth0DY9kNLw1deDKYXWa
 uaXW70YyHvJdDWVdW3pL97GaulAZCfJvaMkOw06iKlCjLC7LgSO+jV9b2898wO5e2Gyn
 nJKGmytoVCTwXkIaYoRDCttjNxFlnB6CwkjxtO7uz1CO1751NNXBkwrHhAM4i4C0K7MB
 EP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NYBTmnbrFY6e4uVDJho3HTMoNaiYI6JT+kpQ+czjgBc=;
 b=F3cTJo43gZ9QFLws01QyR9IQD/vQfGLcmqPbA6/ZL1pty56fVlCpZk1kX3c6KT8/nW
 wN1elgvLCx3AK6ZhrEqm0sLhfqU6iRlL323an7VNn+xr9nQGole3A9R11Vl7ZH7nknvP
 oqUXE0c4sNB0LxB7PD04NOCL+Esio2DmrfUXleAqxDhq+49U1ThKv38R+FPuPTrlorFy
 e1/wK42pkqxPvNB5rLHWbjEYsDvK2Cod09+kP/SKCzKus21tW0Z6jBsigsQyozA3i/6M
 EbRyT+77M6JpJ2ciSJ7BrPBmshQkpns9eGAtGRokx3lW8LH1ALv7W5yU70IOoi4NLShc
 v4TA==
X-Gm-Message-State: AOAM530q9X3rPTNy8Hmjj2hgs2NfEsSelCkLz5M18wFswrAJp5JG7C5w
 VKcndnmN4GxspiAa8lU9hJ68sYDxsiudL8LMvX715w==
X-Google-Smtp-Source: ABdhPJxtQA+v0rp/NT2snj2jrDToSRx2to2k1C/zj58bDlD0p023vCUDoh9aRvnwnKFJjf8Le0Lu/hijhCo63Uyqk2Q=
X-Received: by 2002:a17:907:c87:: with SMTP id
 gi7mr28276614ejc.452.1624950274959; 
 Tue, 29 Jun 2021 00:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
In-Reply-To: <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Tue, 29 Jun 2021 09:03:57 +0200
Message-ID: <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jun 14, 2021 at 12:06 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-24 12:02, Shameer Kolothum wrote:
> > From: Jon Nettleton <jon@solid-run.com>
> >
> > Check if there is any RMR info associated with the devices behind
> > the SMMU and if any, install bypass SMRs for them. This is to
> > keep any ongoing traffic associated with these devices alive
> > when we enable/reset SMMU during probe().
> >
> > Signed-off-by: Jon Nettleton <jon@solid-run.com>
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
> >   1 file changed, 65 insertions(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 6f72c4d208ca..56db3d3238fc 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
> >       return err;
> >   }
> >
> > +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> > +{
> > +     struct list_head rmr_list;
> > +     struct iommu_resv_region *e;
> > +     int i, cnt = 0;
> > +     u32 smr;
> > +     u32 reg;
> > +
> > +     INIT_LIST_HEAD(&rmr_list);
> > +     if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> > +             return;
> > +
> > +     reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> > +
> > +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> > +             /*
> > +              * SMMU is already enabled and disallowing bypass, so preserve
> > +              * the existing SMRs
> > +              */
> > +             for (i = 0; i < smmu->num_mapping_groups; i++) {
> > +                     smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
>
> To reiterate, just because a bootloader/crashed kernel/whatever may have
> left some configuration behind doesn't mean that it matters (e.g. what
> if these SMRs are pointing at translation contexts?). All we should be
> doing here is setting the relevant RMR accommodations in our "clean
> slate" software state before the reset routine applies it to the
> hardware, just like patch #5 does for SMMUv3.
>
> Trying to safely reset an SMMU when we discover it with CLIENTPD=0 is
> really another issue entirely, and I'd say is beyond the scope of this
> series
>
> > +                     if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> > +                             continue;
>
> Note that that's not even necessarily correct (thanks to EXIDS).
>
> > +                     smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> > +                     smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> > +                     smmu->smrs[i].valid = true;
> > +             }
> > +     }
> > +
> > +     list_for_each_entry(e, &rmr_list, list) {
> > +             u32 sid = e->fw_data.rmr.sid;
> > +
> > +             i = arm_smmu_find_sme(smmu, sid, ~0);
> > +             if (i < 0)
> > +                     continue;
> > +             if (smmu->s2crs[i].count == 0) {
> > +                     smmu->smrs[i].id = sid;
> > +                     smmu->smrs[i].mask = ~0;
>
> This is very wrong (as has now already been pointed out).
>
> > +                     smmu->smrs[i].valid = true;
> > +             }
> > +             smmu->s2crs[i].count++;
> > +             smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> > +             smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> > +             smmu->s2crs[i].cbndx = 0xff;
>
> Nit: cbndx is left uninitialised for bypass/fault entries elsewhere, so
> there's little point touching it here.
>
> > +
> > +             cnt++;
> > +     }
> > +
> > +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> > +             /* Remove the valid bit for unused SMRs */
> > +             for (i = 0; i < smmu->num_mapping_groups; i++) {
> > +                     if (smmu->s2crs[i].count == 0)
> > +                             smmu->smrs[i].valid = false;
> > +             }
>
> If this dance is only about avoiding stream match conflicts when trying
> to reprogram live SMRs, simply turning the SMMU off beforehand would be
> a lot simpler.

Robin,

I am not sure what you mean here, and maybe Steve wants to jump in and
help clarify.

My understanding is that "dance" is required for regions that need to
continue to work
throughout the boot process.  I think the example I have seen the most
is for GOP drivers that
use system memory rather than dedicated VRAM.

-Jon

>
> Robin.
>
> > +     }
> > +
> > +     dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> > +                cnt == 1 ? "" : "s");
> > +     iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> > +}
> > +
> >   static int arm_smmu_device_probe(struct platform_device *pdev)
> >   {
> >       struct resource *res;
> > @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >       }
> >
> >       platform_set_drvdata(pdev, smmu);
> > +
> > +     /* Check for RMRs and install bypass SMRs if any */
> > +     arm_smmu_rmr_install_bypass_smr(smmu);
> > +
> >       arm_smmu_device_reset(smmu);
> >       arm_smmu_test_smr_masks(smmu);
> >
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
