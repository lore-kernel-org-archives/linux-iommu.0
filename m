Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF3C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 04:11:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8D9603E5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 04:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF8D9603E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 969EF40395;
	Mon, 11 Oct 2021 04:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SF3aaOCkl51I; Mon, 11 Oct 2021 04:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 57B2540390;
	Mon, 11 Oct 2021 04:11:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C228C000F;
	Mon, 11 Oct 2021 04:11:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEEDFC000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 04:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F6A040392
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 04:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MC-TmL2Ja95u for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 04:11:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77E2640390
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 04:11:20 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id o12so3516892qtq.7
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 21:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yJkzv/qLRuMHpfFpS4P34KqTWJ3Vx+EAHqhp1ZZOPqI=;
 b=g7nfie8pkWJr8W9Kqw/m1Vzt+2qKlzvyuggXbDSXZwyI3x53OnoV+ClCoAT6bMqbo+
 Fw9xw9Q+uutz8BMZkylGG9FSYeCVHjZlVmRe4dG9eAzOFyL8OtwLXuwyJMGujzhjOCqT
 4xbpCjnVe8bTFEsxJpdMDp1oRQjQVP9rkw3UjLxf7y75Pt82JMC26UcvpJHuYPifUF7x
 hse5hvFMSgnTujr4TFfW8sleWouVyzHOPNRji5xM7EcFK0c+HMaln5X+EUOu8swmQQBm
 0CzyD03a0bQfFRESp5UrOPO3KClKDCJz72DEewHOE/75UzuGCOABNP+DD+3sFpi+ZGi6
 9RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yJkzv/qLRuMHpfFpS4P34KqTWJ3Vx+EAHqhp1ZZOPqI=;
 b=dqj4ShMdUXJhT4j/qfFjCqSUZGogkN/cEkNKygpIHEYVdGZdgLgONJRn172jL9Gt/L
 Fc4EOWloRg/IM/5eIOGRnfmwqYLXdbM25Qq0w7XaGej615xAnR1NBjNu1Ua79UoeEC82
 fE0uIYrhLX0cZafECVJ4b+Zp+taMe3iQi38bdO2FeC/Pdm8pf+yO66/TlQB8Nm2j7IWN
 r5eLj6ojaNp2Qw+3kuJ4ZWTjYWm+v8Fjaa2lgPx+aGNYFh/whF9YmRuSbWCcascZvINp
 hCaNNdMVUmuLWxFDKdKl5ULqqneNxCwysDj/LiLhstXKpbXbVJoyOW1ul7+20AvZcPVF
 PTKw==
X-Gm-Message-State: AOAM5315we82W3DICA7Js/ztGiTwlEAhE15ztXPpjzd916InjvOsDGEU
 +jlJewie2qovPOO5r6gbqnXPsdGjla0qw0HQpun8eQ==
X-Google-Smtp-Source: ABdhPJxRuJ9TkoBbKOvVwOudaBHMqMs50XuLzRSTTUx4oR/M2EB3whe37CwIsMGxez4j3kIQ4T8PvHWhehH7hl2PAYo=
X-Received: by 2002:ac8:1011:: with SMTP id z17mr12653163qti.388.1633925479158; 
 Sun, 10 Oct 2021 21:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
 <YWJpJnaQ2Nr4PUwr@yoga>
 <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
In-Reply-To: <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 11 Oct 2021 07:11:07 +0300
Message-ID: <CAA8EJpoD4Th1tdwYQLnZur2oA0xX0LojSrNFLyJqdi6+rnB3YQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Kalle Valo <kvalo@codeaurora.org>
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

On Sun, 10 Oct 2021 at 20:42, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Oct 10, 2021 at 6:17 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Sat 09 Oct 21:33 CDT 2021, Dmitry Baryshkov wrote:
> >
> > > After commit 424953cf3c66 ("qcom_scm: hide Kconfig symbol") arm-smmu got
> > > qcom_smmu_impl_init() call guarded by IS_ENABLED(CONFIG_ARM_SMMU_QCOM).
> > > However the CONFIG_ARM_SMMU_QCOM Kconfig entry does not exist, so the
> > > qcom_smmu_impl_init() is never called.
> > >
> > > So, let's fix this by always calling qcom_smmu_impl_init(). It does not
> > > touch the smmu passed unless the device is a non-Qualcomm one. Make
> > > ARM_SMMU select QCOM_SCM for ARCH_QCOM.
>
> Sorry about this bug. I was sure I had it working, but I lost part of the commit
> during a rebase, and my randconfig builds still succeeded without it, so I
> sent a wrong version.
>
> > Arnd's intention was to not force QCOM_SCM to be built on non-Qualcomm
> > devices. But as Daniel experienced, attempting to boot most Qualcomm
> > boards without this results in a instant reboot.
> >
> > I think it's okay if we tinker with CONFIG_ARM_SMMU_QCOM for v5.16, but
> > we're getting late in v5.15 so I would prefer if we make sure this works
> > out of the box.
>
> Yes, makes sense. For reference, see below for how I would fix this properly,
> this is what I had intended to have in the patch. Feel free to pick
> either version
> as the immediate bugfix. I'll give the below a little more randconfig testing
> overnight though. The pasted version of the patch is probably
> whitespace-damaged,
> let me know if you would like me to send it as a proper patch.
>
>        Arnd
>
> 8<-----
> Subject: iommu: fix ARM_SMMU_QCOM compilation
>
> My previous bugfix ended up making things worse for the QCOM IOMMU
> driver when it forgot to add the Kconfig symbol that is getting used to
> control the compilation of the SMMU implementation specific code
> for Qualcomm.
>
> Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c5c71b7ab7e8..2dfe744ddd97 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -311,6 +311,7 @@ config ARM_SMMU
>         select IOMMU_API
>         select IOMMU_IO_PGTABLE_LPAE
>         select ARM_DMA_USE_IOMMU if ARM
> +       select QCOM_SCM if ARM_SMMU_QCOM
>         help
>           Support for implementations of the ARM System MMU architecture
>           versions 1 and 2.
> @@ -355,6 +356,13 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>           'arm-smmu.disable_bypass' will continue to override this
>           config.
>
> +config ARM_SMMU_QCOM
> +       def_bool y
> +       depends on ARM_SMMU && ARCH_QCOM
> +       help
> +         When running on a Qualcomm platform that has the custom variant
> +         of the ARM SMMU, this needs to be built into the SMMU driver.
> +
>  config ARM_SMMU_V3
>         tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>         depends on ARM64

The patch seems correct, but it becomes overcomplicated. What about:
- restoring QCOM_SCM stubs
- making ARM_SMMU select QCOM_SCM if ARM_SMMU_QCOM

This would have almost the same result as with your patch, but without
extra ARM_SMMU_QCOM Kconfig symbol.

-- 
With best wishes
Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
