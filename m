Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36493C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 01:10:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C077D6056B
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 01:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C077D6056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8233C6066D;
	Tue,  3 Aug 2021 01:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HlxZ5vhN1zen; Tue,  3 Aug 2021 01:10:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 58C4060602;
	Tue,  3 Aug 2021 01:10:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3688BC0010;
	Tue,  3 Aug 2021 01:10:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62A91C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 01:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41338400D4
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 01:10:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id slnsxJpXyAdk for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 01:10:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B67B2400C8
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 01:10:13 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id j2so23372273wrx.9
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 18:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cwfRDlhi4nw1htqUjvNDRczeQ0/VaPFUSYWqPgi8u+Y=;
 b=ZweXXMfeU0KJi/8/pjiXrS3//QcwgI4bRE1dTQEC/En+mp2Fzl5ZY5RqvnYeRYqj18
 7eOcAgD8yuDaoid5lmVArFNy5UD2/hYtayFhdpZX3dWx6ife6WXfdAZnyvHcumgauD6J
 6Kxyedhg5BBMfGDZlwlnTaDGW6eetSAvcsYjRSDc3hoaARyBshyf8C7WepZ4Yq7pYk+y
 8jyngsKBYLoHaCXHkNTDKU5PVa9kjA5uXqf9duY0bwCxJQKh9PUQ78xmpmlslphdreR9
 ROjKMFRs95AkcIoGjjzEd+R6u8C3+AzfQclC6WihqLRMkywHPiV0qR4sskcRZhwJPhOv
 4Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cwfRDlhi4nw1htqUjvNDRczeQ0/VaPFUSYWqPgi8u+Y=;
 b=hcbNT2kwILwXtqyFOaVCmo27LgKe9OMKlfqmC8sjsZoz61njhkYYyrVXLP6lTNbmfO
 SP/UFV10aCa0iQkOjsYSleOmkF2T4nd3Ir5JTjmw0F8aFGAptBMTR54wBeVZ6k3gKqOI
 whoKiiqZ/VwgXcVtE/I/BA4YgSip9rI1jTMDipXtCw9njWt1hqKVQR9FQJeleWE0askN
 wxM+GwZh8Wk0dDglBSr0vftwj1OXgD6mx9laCvqwOtUXK3Y2NdNjk/NffKkIENmCBPd/
 yIqvoR7BrQ4pEG9l4Z+9OsYhGwyJVDduD5Q1emmUYHNzGsWi4tl/dG3WcWiHEbxXgECc
 Steg==
X-Gm-Message-State: AOAM531OEVEwvxVWnJ9K9gYk6BS0xrx7t0n8EHmlo9gtrVBmjFLk6wxb
 K/1vpntbcnztj/E2d+dm22ICsQ4O0ll5Haq2t5Y=
X-Google-Smtp-Source: ABdhPJwLpmDvUbuYbcJzZuoOee6sTseIK6hg03LmLgFOFqG4+uh1U7lqcT3Qttal7+3I2dABf/jzbXRnAo/kilcgfRM=
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr19403081wrm.327.1627953011815; 
 Mon, 02 Aug 2021 18:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210727093322.13202-1-saiprakash.ranjan@codeaurora.org>
 <20210802161206.GA29168@willie-the-truck>
In-Reply-To: <20210802161206.GA29168@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 2 Aug 2021 18:14:25 -0700
Message-ID: <CAF6AEGueDncLYzw9ic=2wkfidOBcG_HcquH7K0ya9xEfY5oteg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to
 system pm callbacks
To: Will Deacon <will@kernel.org>
Cc: Taniya Das <tdas@codeaurora.org>, Rob Clark <robdclark@chromium.org>,
 Rajendra Nayak <rnayak@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, srimuc <srimuc@codeaurora.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Aug 2, 2021 at 9:12 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jul 27, 2021 at 03:03:22PM +0530, Sai Prakash Ranjan wrote:
> > Some clocks for SMMU can have parent as XO such as gpu_cc_hub_cx_int_clk
> > of GPU SMMU in QTI SC7280 SoC and in order to enter deep sleep states in
> > such cases, we would need to drop the XO clock vote in unprepare call and
> > this unprepare callback for XO is in RPMh (Resource Power Manager-Hardened)
> > clock driver which controls RPMh managed clock resources for new QTI SoCs
> > and is a blocking call.
> >
> > Given we cannot have a sleeping calls such as clk_bulk_prepare() and
> > clk_bulk_unprepare() in arm-smmu runtime pm callbacks since the iommu
> > operations like map and unmap can be in atomic context and are in fast
> > path, add this prepare and unprepare call to drop the XO vote only for
> > system pm callbacks since it is not a fast path and we expect the system
> > to enter deep sleep states with system pm as opposed to runtime pm.
> >
> > This is a similar sequence of clock requests (prepare,enable and
> > disable,unprepare) in arm-smmu probe and remove.
> >
> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > Co-developed-by: Rajendra Nayak <rnayak@codeaurora.org>
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
>
> [+Rob]
>
> How does this work with that funny GPU which writes to the SMMU registers
> directly? Does the SMMU need to remain independently clocked for that to
> work or is it all in the same clock domain?

AFAIU the device_link stuff should keep the SMMU clocked as long as
the GPU is alive, so I think this should work out ok.. ie. the SMMU
won't suspend while the GPU is not suspended.

BR,
-R


> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index d3c6f54110a5..9561ba4c5d39 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -2277,6 +2277,13 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> >
> >  static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> >  {
> > +     int ret;
> > +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +     ret = clk_bulk_prepare(smmu->num_clks, smmu->clks);
> > +     if (ret)
> > +             return ret;
> > +
> >       if (pm_runtime_suspended(dev))
> >               return 0;
>
> If we subsequently fail to enable the clks in arm_smmu_runtime_resume()
> should we unprepare them again?
>
> Will
>
> > @@ -2285,10 +2292,19 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> >
> >  static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> >  {
> > +     int ret = 0;
> > +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> >       if (pm_runtime_suspended(dev))
> > -             return 0;
> > +             goto clk_unprepare;
> >
> > -     return arm_smmu_runtime_suspend(dev);
> > +     ret = arm_smmu_runtime_suspend(dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +clk_unprepare:
> > +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> > +     return ret;
> >  }
> >
> >  static const struct dev_pm_ops arm_smmu_pm_ops = {
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
