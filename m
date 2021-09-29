Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DF4C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 18:30:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921C061501
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 18:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 921C061501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E22340133;
	Wed, 29 Sep 2021 18:30:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z3pDxQgwszR0; Wed, 29 Sep 2021 18:30:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B580640122;
	Wed, 29 Sep 2021 18:30:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65BB1C000F;
	Wed, 29 Sep 2021 18:30:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62925C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A24B80EF3
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:30:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xcqlEPfyx8P3 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 18:30:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53BDE80EEE
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:30:50 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B47C0615E0
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632940249;
 bh=gjF28VMTIug2m1bl/FU/M9snQ4rR61AFv5fVsRKalNI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CISl9Rl7R+M6haM6b37hM8Y55j2HAbcMi0eojp8x2X5LO3rMaVS5sudmIbZDpY2Fa
 v3jkZlxqIQsgk7xdc/KNDPDNwnRYggSWDCUgB/s/FiZxlhlKX24dWHVpR7Wt0mlN/7
 mhK6ym9B69BkMQdp4WI4pKJ+rr90hmai+tmZp9rhMJtK7ONWh9AhmLAFD2pHKhaUG3
 HMRbEb2CCpVxIrKjjd6yE6ttU5SikyGGITOLPKJu1L7QFLNrx8p43TXVkgBvbCSBJk
 HoUf+R5uDfbywO7AlRlXS5uX8pbpj5u56JSH5+uMScUwkPlS/zeQ1/1lCIAk541NMv
 d88464bdH/fHQ==
Received: by mail-wr1-f46.google.com with SMTP id x20so5794347wrg.10
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 11:30:49 -0700 (PDT)
X-Gm-Message-State: AOAM531AKSqlQ45iQsMPn1okqwpIn78RixJ5CWjiVorQ2LNQ+qWvS+NM
 h2YdlmaTbRLgM//HI2cyCZmAhLwRWwPZJlX3SS8=
X-Google-Smtp-Source: ABdhPJznh64DeD5YLkqLyCdpGZrw2eJDCFhsGINcOBsXO/6p1u7dAzpxKDez727ElHRBigRMgHpji/X6aGMkMR1n8h4=
X-Received: by 2002:a05:6000:1561:: with SMTP id
 1mr1607418wrz.369.1632940247984; 
 Wed, 29 Sep 2021 11:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210927152412.2900928-1-arnd@kernel.org>
 <20210929095107.GA21057@willie-the-truck>
 <CAK8P3a2QnJkYCoEWhziYYXQusb-25_wUhA5ZTGtBsyfFx3NWzQ@mail.gmail.com>
 <YVR8Q7LO0weiFin+@yoga>
In-Reply-To: <YVR8Q7LO0weiFin+@yoga>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 29 Sep 2021 20:30:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Kk6Y1Hs98z2UFEis8cWekREFt8YKg2Nbu3G5WQJ7Fag@mail.gmail.com>
Message-ID: <CAK8P3a2Kk6Y1Hs98z2UFEis8cWekREFt8YKg2Nbu3G5WQJ7Fag@mail.gmail.com>
Subject: Re: [PATCH] [RFC] qcom_scm: hide Kconfig symbol
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Airlie <airlied@linux.ie>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, ath10k@lists.infradead.org,
 Will Deacon <will@kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andy Gross <agross@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-sunxi@lists.linux.dev,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Paul <sean@poorly.run>,
 Kalle Valo <kvalo@codeaurora.org>, Alex Elder <elder@kernel.org>,
 Networking <netdev@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 freedreno <freedreno@lists.freedesktop.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Sep 29, 2021 at 4:46 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 29 Sep 05:04 CDT 2021, Arnd Bergmann wrote:
>
> > On Wed, Sep 29, 2021 at 11:51 AM Will Deacon <will@kernel.org> wrote:
> > > On Mon, Sep 27, 2021 at 05:22:13PM +0200, Arnd Bergmann wrote:
> > > >
> > > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > > index 124c41adeca1..989c83acbfee 100644
> > > > --- a/drivers/iommu/Kconfig
> > > > +++ b/drivers/iommu/Kconfig
> > > > @@ -308,7 +308,7 @@ config APPLE_DART
> > > >  config ARM_SMMU
> > > >       tristate "ARM Ltd. System MMU (SMMU) Support"
> > > >       depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> > > > -     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> > > > +     select QCOM_SCM
> > > >       select IOMMU_API
> > > >       select IOMMU_IO_PGTABLE_LPAE
> > > >       select ARM_DMA_USE_IOMMU if ARM
> > >
> > > I don't want to get in the way of this patch because I'm also tired of the
> > > randconfig failures caused by QCOM_SCM. However, ARM_SMMU is applicable to
> > > a wide variety of (non-qcom) SoCs and so it seems a shame to require the
> > > QCOM_SCM code to be included for all of those when it's not strictly needed
> > > at all.
> >
> > Good point, I agree that needs to be fixed. I think this additional
> > change should do the trick:
> >
>
> ARM_SMMU and QCOM_IOMMU are two separate implementations and both uses
> QCOM_SCM. So both of them should select QCOM_SCM.

Right, I figured that out later as well.

> "Unfortunately" the Qualcomm portion of ARM_SMMU is builtin
> unconditionally, so going with something like select QCOM_SCM if
> ARCH_QCOM would still require the stubs in qcom_scm.h.

Yes, sounds good. I also noticed that I still need one hack in there
if I do this:

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 55690af1b25d..36c304a8fc9b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -427,6 +427,9 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct
arm_smmu_device *smmu)
 {
        const struct device_node *np = smmu->dev->of_node;

+       if (!IS_ENABLED(CONFIG_QCOM_SCM))
+               return ERR_PTR(-ENXIO);
+
 #ifdef CONFIG_ACPI
        if (np == NULL) {
                /* Match platform for ACPI boot */


Otherwise it still breaks with ARM_SMMU=y and QCOM_SCM=m.

Splitting out the qualcomm portion of the arm_smmu driver using
a separate 'bool' symbol should also work, if  you prefer that
and can suggest a name and help text for that symbol. It would
look like

diff --git a/drivers/iommu/arm/arm-smmu/Makefile
b/drivers/iommu/arm/arm-smmu/Makefile
index e240a7bcf310..b0cc01aa20c9 100644
--- a/drivers/iommu/arm/arm-smmu/Makefile
+++ b/drivers/iommu/arm/arm-smmu/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
-arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
+arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o
+arm_smmu-$(CONFIG_ARM_SMMU_QCOM) += arm-smmu-qcom.o
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 9f465e146799..2c25cce38060 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -215,7 +215,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct
arm_smmu_device *smmu)
            of_device_is_compatible(np, "nvidia,tegra186-smmu"))
                return nvidia_smmu_impl_init(smmu);

-       smmu = qcom_smmu_impl_init(smmu);
+       if (IS_ENABLED(CONFIG_ARM_SMMU_QCOM))
+               smmu = qcom_smmu_impl_init(smmu);

        if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
                smmu->impl = &mrvl_mmu500_impl;



       Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
