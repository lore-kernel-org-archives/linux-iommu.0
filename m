Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48660C11F67
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 16:26:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D830B61DCB
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 16:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D830B61DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B49F607D7;
	Tue, 29 Jun 2021 16:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id roU0vyFuwu6f; Tue, 29 Jun 2021 16:26:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 483C36080C;
	Tue, 29 Jun 2021 16:26:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19534C0010;
	Tue, 29 Jun 2021 16:26:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33FF0C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 16:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22F4782B97
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 16:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgDHxuj_bTfi for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 16:26:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7A08829EE
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 16:26:30 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id nd37so37401028ejc.3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6a5ku/KsDYb39XdizodNeqaVTk55z1jvwlHuTYEpkp8=;
 b=Yeu3St5BIPY9uQPow/7Dj5T4H0xOwk/sqNeYD+ScRUuGnKWR6yV2i9pHm5IOInbUXQ
 EMKmNWQ7MXhP3gbwyG8jM8FGqLaNM0r+lwzS58ehwcTZ/XYgXgDW25tc1uLOZtpU5cJT
 SCerYvTA3ku/BP9LkpgTO/TFcZgjn+VLzgOmfjC9+MmD+LGoSjV47Vg362ikPuhl6sNk
 NFG1eFsrweJbQFSZhvgfQSxNBWRKxEdjl2zP48k3xfoIYrVW9482iYl8k9G9MkeIwILh
 MLmjzzikAyo5aYhWK/Bo2IzMlPduW8AM1gAw7dSUtufR8zFOWwMXPEttj4DFZOnLe7Ys
 Zh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6a5ku/KsDYb39XdizodNeqaVTk55z1jvwlHuTYEpkp8=;
 b=S9nUMSK0NZRpPM1bG8MoDskTow1/u/1dE6bKgel6LyBtZx5PFIgOZgrz79sA3sLWOC
 muf1qt69tSjh0rSx2+BIjqBFdGormOmuduqiIjr5/kokjRFtpeGeQKqxsLa7hKEvxeCi
 vEkh8nIjwx69oxLtdb+N6YuzWbUiINOogcKWp2A/cvaC08NcbypZs0jkQ7SWKctqUu4R
 UcvrJySqQDbiiW/+pIKrn89ZCmOQoXp7+fd0uHgoSy5Qvd7lzmBeO8Mlrc76RXyjIkNM
 8tKdbalDmmfwcCO+0XPMi8RxyYCgIX0PO5mNRcComiKfussSZ2xH7bT6PYOpOTL0OoYm
 v/jA==
X-Gm-Message-State: AOAM531pauajd9tqGPFvgzhrAbDdu5TC3fO/LXAH+EZyiy+yXMtu0tK5
 CNYYhgO84q5bBUpp6LMbfQvG+m68k3u3bxfDRoMt2g==
X-Google-Smtp-Source: ABdhPJx5bnrYOid59YrT5k++0MfRlEMWuXkSqyse1E5J44TCy7mTHlhq+BiUEMzcRPQmZqf2Hm9Cm2FTrPfSWbhkP9I=
X-Received: by 2002:a17:907:d9f:: with SMTP id
 go31mr28318107ejc.165.1624983988705; 
 Tue, 29 Jun 2021 09:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
 <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
 <b33c1525-5a74-a985-fd39-f4df8614f210@arm.com>
In-Reply-To: <b33c1525-5a74-a985-fd39-f4df8614f210@arm.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Tue, 29 Jun 2021 18:25:51 +0200
Message-ID: <CABdtJHsz+ycVffJTyekau_OY6ROmoTBWAGd_guikxauT=nnuJQ@mail.gmail.com>
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

On Tue, Jun 29, 2021 at 3:23 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-29 08:03, Jon Nettleton wrote:
> > On Mon, Jun 14, 2021 at 12:06 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2021-05-24 12:02, Shameer Kolothum wrote:
> >>> From: Jon Nettleton <jon@solid-run.com>
> >>>
> >>> Check if there is any RMR info associated with the devices behind
> >>> the SMMU and if any, install bypass SMRs for them. This is to
> >>> keep any ongoing traffic associated with these devices alive
> >>> when we enable/reset SMMU during probe().
> >>>
> >>> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> >>> Signed-off-by: Steven Price <steven.price@arm.com>
> >>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >>> ---
> >>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
> >>>    1 file changed, 65 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> index 6f72c4d208ca..56db3d3238fc 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>> @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
> >>>        return err;
> >>>    }
> >>>
> >>> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> >>> +{
> >>> +     struct list_head rmr_list;
> >>> +     struct iommu_resv_region *e;
> >>> +     int i, cnt = 0;
> >>> +     u32 smr;
> >>> +     u32 reg;
> >>> +
> >>> +     INIT_LIST_HEAD(&rmr_list);
> >>> +     if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> >>> +             return;
> >>> +
> >>> +     reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> >>> +
> >>> +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> >>> +             /*
> >>> +              * SMMU is already enabled and disallowing bypass, so preserve
> >>> +              * the existing SMRs
> >>> +              */
> >>> +             for (i = 0; i < smmu->num_mapping_groups; i++) {
> >>> +                     smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> >>
> >> To reiterate, just because a bootloader/crashed kernel/whatever may have
> >> left some configuration behind doesn't mean that it matters (e.g. what
> >> if these SMRs are pointing at translation contexts?). All we should be
> >> doing here is setting the relevant RMR accommodations in our "clean
> >> slate" software state before the reset routine applies it to the
> >> hardware, just like patch #5 does for SMMUv3.
> >>
> >> Trying to safely reset an SMMU when we discover it with CLIENTPD=0 is
> >> really another issue entirely, and I'd say is beyond the scope of this
> >> series
> >>
> >>> +                     if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> >>> +                             continue;
> >>
> >> Note that that's not even necessarily correct (thanks to EXIDS).
> >>
> >>> +                     smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> >>> +                     smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> >>> +                     smmu->smrs[i].valid = true;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     list_for_each_entry(e, &rmr_list, list) {
> >>> +             u32 sid = e->fw_data.rmr.sid;
> >>> +
> >>> +             i = arm_smmu_find_sme(smmu, sid, ~0);
> >>> +             if (i < 0)
> >>> +                     continue;
> >>> +             if (smmu->s2crs[i].count == 0) {
> >>> +                     smmu->smrs[i].id = sid;
> >>> +                     smmu->smrs[i].mask = ~0;
> >>
> >> This is very wrong (as has now already been pointed out).
> >>
> >>> +                     smmu->smrs[i].valid = true;
> >>> +             }
> >>> +             smmu->s2crs[i].count++;
> >>> +             smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> >>> +             smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> >>> +             smmu->s2crs[i].cbndx = 0xff;
> >>
> >> Nit: cbndx is left uninitialised for bypass/fault entries elsewhere, so
> >> there's little point touching it here.
> >>
> >>> +
> >>> +             cnt++;
> >>> +     }
> >>> +
> >>> +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
> >>> +             /* Remove the valid bit for unused SMRs */
> >>> +             for (i = 0; i < smmu->num_mapping_groups; i++) {
> >>> +                     if (smmu->s2crs[i].count == 0)
> >>> +                             smmu->smrs[i].valid = false;
> >>> +             }
> >>
> >> If this dance is only about avoiding stream match conflicts when trying
> >> to reprogram live SMRs, simply turning the SMMU off beforehand would be
> >> a lot simpler.
> >
> > Robin,
> >
> > I am not sure what you mean here, and maybe Steve wants to jump in and
> > help clarify.
> >
> > My understanding is that "dance" is required for regions that need to
> > continue to work
> > throughout the boot process.  I think the example I have seen the most
> > is for GOP drivers that
> > use system memory rather than dedicated VRAM.
>
> All that is required is to install bypass SMEs for the relevant streams
> before enabling the SMMU. That much is achieved by the
> list_for_each_entry(e, &rmr_list, list) loop setting up initial state
> followed by arm_smmu_device_reset(). The "dance" I'm referring to is the
> additional reading out of (possibly nonsense) SMR state beforehand to
> pre-bias the SMR allocator, then trying to clean up the remnants afterwards.
>
> If we're going to pretend to be robust against finding the SMMU already
> enabled *with* live traffic ongoing, there's frankly an awful lot more
> care we'd need to take beyond here (and for some aspects there's still
> no right answer). If on the other hand we're implicitly assuming that
> any boot-time enabled SMRs exactly match the RMR configuration anyway,
> then simply disabling the SMMU until we enable it again in the reset
> routine still preserves the necessary bypass behaviour for RMR streams
> while sidestepping any issues related to reprogramming live SMMU state.
>
> Robin.
>
> >>> +     }
> >>> +
> >>> +     dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> >>> +                cnt == 1 ? "" : "s");
> >>> +     iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> >>> +}
> >>> +
> >>>    static int arm_smmu_device_probe(struct platform_device *pdev)
> >>>    {
> >>>        struct resource *res;
> >>> @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >>>        }
> >>>
> >>>        platform_set_drvdata(pdev, smmu);
> >>> +
> >>> +     /* Check for RMRs and install bypass SMRs if any */
> >>> +     arm_smmu_rmr_install_bypass_smr(smmu);
> >>> +
> >>>        arm_smmu_device_reset(smmu);
> >>>        arm_smmu_test_smr_masks(smmu);
> >>>
> >>>

Shameer,

Sorry for the delays.  Here is a diff of the changes that should
address the issues pointed out by Robin,
I have tested that this works as expected on my HoneyComb LX2160A.

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index ab7b9db77625..a358bd326d0b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2068,29 +2068,21 @@ static void
arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
        struct list_head rmr_list;
        struct iommu_resv_region *e;
        int i, cnt = 0;
-       u32 smr;
        u32 reg;

        INIT_LIST_HEAD(&rmr_list);
        if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
                return;

-       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
+       /* Rather than trying to look at existing mappings that
+        * are setup by the firmware and then invalidate the ones
+        * that do no have matching RMR entries, just disable the
+        * SMMU until it gets enabled again in the reset routine.
+        */

-       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
-               /*
-                * SMMU is already enabled and disallowing bypass, so preserve
-                * the existing SMRs
-                */
-               for (i = 0; i < smmu->num_mapping_groups; i++) {
-                       smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
-                       if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
-                               continue;
-                       smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
-                       smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
-                       smmu->smrs[i].valid = true;
-               }
-       }
+       reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
+       reg &= ~ARM_SMMU_sCR0_CLIENTPD;
+       arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);

        list_for_each_entry(e, &rmr_list, list) {
                u32 sid = e->fw_data.rmr.sid;
@@ -2100,25 +2092,16 @@ static void
arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
                        continue;
                if (smmu->s2crs[i].count == 0) {
                        smmu->smrs[i].id = sid;
-                       smmu->smrs[i].mask = ~0;
+                       smmu->smrs[i].mask = 0;
                        smmu->smrs[i].valid = true;
                }
                smmu->s2crs[i].count++;
                smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
                smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
-               smmu->s2crs[i].cbndx = 0xff;

                cnt++;
        }

-       if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
-               /* Remove the valid bit for unused SMRs */
-               for (i = 0; i < smmu->num_mapping_groups; i++) {
-                       if (smmu->s2crs[i].count == 0)
-                               smmu->smrs[i].valid = false;
-               }
-       }
-
        dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
                   cnt == 1 ? "" : "s");
        iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);

Please include that in your next patch series.  Let me know if you
want me to send you the patch direct
off the list.

Thanks,
Jon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
