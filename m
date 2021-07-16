Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AACC636CA
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 20:41:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9126C613E3
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 20:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9126C613E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5140A60684;
	Fri, 16 Jul 2021 20:41:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCl4-NdEk475; Fri, 16 Jul 2021 20:41:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3356860EC8;
	Fri, 16 Jul 2021 20:41:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4807C001A;
	Fri, 16 Jul 2021 20:41:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45C7EC000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 20:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26E8460EC8
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 20:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9v5b6LNB_PiM for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 20:41:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A37560684
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 20:41:33 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id bu12so17161014ejb.0
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 13:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JEtbxbzRJfypbq28VwtBeys1nMOkBPjKemU4/5xjhFQ=;
 b=b1qbH9mms7hPB38VOsm9cAH4dPo2xvftYVHjhJXCd6FwadDNVflL+ztsiViqaBfhBk
 1Y9jQE4/+HbhCNXt/XeuNvtSXJPpdY0CgwxQ6E59FjtkHKVkSJYZ9Ntr0pxGgj7qsHHe
 KmGVIYuRLwo8q5LR7jaa2wpD3Bem4FLSNMC03wayttR2UrXHyg+MqjhEGDKb3OrkRykb
 rlj8p+q3G8YMY1RdKf/pBfrHBPRcqC6Z/bvE96tkO8ED2L02yC3T1Q0MkDzoXvL9aXpx
 Whm3JB74gWosHqbHfC4jEhzw1rmtCSyQ+UsYp1zo73fSqza5+2WSl6IOqrlh/rQ2cMW0
 F8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JEtbxbzRJfypbq28VwtBeys1nMOkBPjKemU4/5xjhFQ=;
 b=Sq0QHSqV16I4kvVrR+b8VTzGjIRqDr1KxT9fKcGgK4l0WaxCWpgK4N82z4wiaPwP9W
 h5p32Nn5yaMvAL/WdDj1sQOtp266GfDNZWFsPCRfN4ezn3dBajXEb1MpopodkuxrVzpb
 cXeVtxJKJNdWhgcrCV8K4UxL72e6W1ttfycd4usJvgTy0aVZnSJWThJnv8sn9X+Cbplk
 3ZEiFvoC7ps7Ipt9IXfimp6kkk0d2PRnzyEXkXhrKYij9/ISVzBrgJEl4MbF2SUXSDG9
 OI2IqboDOGr3DcG40Q06QQ9EaxnttHZ0IKB1pa8EpL1V66moIBM5LxA9rxLwNHj9fxNF
 A0QA==
X-Gm-Message-State: AOAM530rcm1uQc+h2VjTCXej+fED4bXvu8r/D4O95CR//zfPgTPHRf8C
 5Svu9G0BZ13IrOcjpPNGwfEQdD7m8MCHsqIp/Pm9xA==
X-Google-Smtp-Source: ABdhPJz0X9g33SZknniYh2QG95F1sb+oMutu7eL+RPFrwLiUPi/JM18ZwbLrC4NLYIf0L8onJcpO3lgsDDKeTOges64=
X-Received: by 2002:a17:906:3699:: with SMTP id
 a25mr13618509ejc.452.1626468092286; 
 Fri, 16 Jul 2021 13:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
 <20210716083442.1708-9-shameerali.kolothum.thodi@huawei.com>
 <b73d3408-7b2e-4cab-3b8c-efc22d08d99e@arm.com>
In-Reply-To: <b73d3408-7b2e-4cab-3b8c-efc22d08d99e@arm.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Fri, 16 Jul 2021 22:40:55 +0200
Message-ID: <CABdtJHu-2WxOwkKTa8o+cS_TfNv78Tes_nn3pPutv8q6vCC2CA@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Steven Price <steven.price@arm.com>
Cc: Linuxarm <linuxarm@huawei.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, wanghuiqiang <wanghuiqiang@huawei.com>,
 Hanjun Guo <guohanjun@huawei.com>, yangyicong <yangyicong@huawei.com>,
 Sami Mujawar <Sami.Mujawar@arm.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, Jul 16, 2021 at 3:52 PM Steven Price <steven.price@arm.com> wrote:
>
> On 16/07/2021 09:34, Shameer Kolothum wrote:
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
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c | 48 +++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index f22dbeb1e510..e9fb3d962a86 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -2063,6 +2063,50 @@ err_reset_platform_ops: __maybe_unused;
> >       return err;
> >  }
> >
> > +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> > +{
> > +     struct list_head rmr_list;
> > +     struct iommu_resv_region *e;
> > +     int i, cnt = 0;
> > +     u32 reg;
> > +
> > +     INIT_LIST_HEAD(&rmr_list);
> > +     if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> > +             return;
> > +
> > +     /*
> > +      * Rather than trying to look at existing mappings that
> > +      * are setup by the firmware and then invalidate the ones
> > +      * that do no have matching RMR entries, just disable the
> > +      * SMMU until it gets enabled again in the reset routine.
> > +      */
> > +     reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> > +     reg &= ~ARM_SMMU_sCR0_CLIENTPD;
>
> This looks backwards, the spec states:
>
>   Client Port Disable. The possible values of this bit are:
>   0 - Each SMMU client access is subject to SMMU translation, access
>       control, and attribute generation.
>   1 - Each SMMU client access bypasses SMMU translation, access control,
>       and attribute generation.
>   This bit resets to 1.
>
> And indeed with the current code if sCR0_USFCFG was set when
> sCR0_CLIENTPD is cleared then I get a blank screen until the smmu is reset.
>
> So I believe this should be ORing in the value, i.e.
>
>   reg |= ARM_SMMU_sCR0_CLIENTPD;
>
> And in my testing that works fine even if sCR0_USFCFG is set.

Sorry that is my bad.  It was a hurried and sloppy copy paste on my part.

Thanks for catching it
-Jon

>
> Steve
>
> > +     arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);
> > +
> > +     list_for_each_entry(e, &rmr_list, list) {
> > +             u32 sid = e->fw_data.rmr.sid;
> > +
> > +             i = arm_smmu_find_sme(smmu, sid, ~0);
> > +             if (i < 0)
> > +                     continue;
> > +             if (smmu->s2crs[i].count == 0) {
> > +                     smmu->smrs[i].id = sid;
> > +                     smmu->smrs[i].mask = 0;
> > +                     smmu->smrs[i].valid = true;
> > +             }
> > +             smmu->s2crs[i].count++;
> > +             smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> > +             smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> > +
> > +             cnt++;
> > +     }
> > +
> > +     dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> > +                cnt == 1 ? "" : "s");
> > +     iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> > +}
> > +
> >  static int arm_smmu_device_probe(struct platform_device *pdev)
> >  {
> >       struct resource *res;
> > @@ -2189,6 +2233,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
