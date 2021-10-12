Return-Path: <SRS0=nyYM=PA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F3C433FE
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 03:35:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A8360E97
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 03:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1A8360E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72824403EF;
	Tue, 12 Oct 2021 03:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ovp-2BcdWrhL; Tue, 12 Oct 2021 03:35:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 520B040362;
	Tue, 12 Oct 2021 03:35:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B365C000F;
	Tue, 12 Oct 2021 03:35:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B648C000D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 03:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2BD340370
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 03:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o04yZP8_ouiP for <iommu@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 03:35:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8035C40362
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 03:35:07 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id m13so11143476qvk.1
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 20:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EmhQGrBHhBqco3/fKYTerqn3hrMIea7RZ3yw7yTntJk=;
 b=FC1XDkTlI9I/tEz1ohiUY519cWZieN3uOODYV1C8Mv3OPjdtuFF+dqXcKq77X5dTbL
 FITyfzUfZejn0lwoVQeHM4AB2z4b5c5tInY0RTkagZbfu5nYFlWPBc5Zx/zpJMx3zM5T
 4v/o6h1PcKie+43TKXDMoBuLDUJX7aItxVIUwGjHMLdz2mtn+hb6QeNbKqm4fEoCBz6p
 8K8yqovQoXvFiY2FMTkwqAP8uFXwjIjE+AiWX1ww9oZJJ99LE+Hy8oYKAZ8Sy+kQYNFs
 MzLN+AGWmAWrziF0nCvPLEkzSA9KcMArO6SdzuV4FN6wl/LXMiF3A/sm2Jz+cRzHwFSu
 mokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EmhQGrBHhBqco3/fKYTerqn3hrMIea7RZ3yw7yTntJk=;
 b=GUMub4nn7Yxwup2orH2tWgPvFCvy8sXHKFdHY/rtIUFEWesETUPnxKXspPq4CL/Xft
 K5GQGelC0XfsJONLgMokAGcX0Yv2pisMUHMmOMYvZIcgguwlSR4fzMMSulLdktiDUqaH
 KfMA3aZWKUylxObh01KRe2SVz9TABXiPlmNBgBNCJLLc6HcNGuzwigukWrYIojxdDDly
 LKFwWjw1yuRa4XTqSzVogq2L5FvvGoom7GEViwP5j8JXwGyhv2WZ4GXH3abCXq0yVyCA
 TNPgLLR1iFXxdaK3fiqZdc+aA7aWvKK/aPPd/l1oHpYB4wKRVtam81MzsuQKc8yNUeLI
 Ij7Q==
X-Gm-Message-State: AOAM530qin00URWUj7YyqbQjVsxC8jsUArZisbeymo/7vNmF6qayf4vd
 LL1bXK8fto3/fxmtNYlJTVk+BA0wqNZMNdye55+ArrJByfU=
X-Google-Smtp-Source: ABdhPJwYk1vV8P7NVAAIhul2dADSwoQQewMWHAp5qbboSqFlQZFU1gNvtKnlICCH4yrsmE2uME429X0JuBEM+OhICKQ=
X-Received: by 2002:a05:6214:70f:: with SMTP id
 b15mr27855384qvz.16.1634009706228; 
 Mon, 11 Oct 2021 20:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
 <YWJpJnaQ2Nr4PUwr@yoga>
 <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
 <CAA8EJpoD4Th1tdwYQLnZur2oA0xX0LojSrNFLyJqdi6+rnB3YQ@mail.gmail.com>
 <CAK8P3a3JwQP1b0KeLRN0UCMmzFn3+gY2oexYUwGyt2bOqC0P4A@mail.gmail.com>
 <CAA8EJppAx_bweNhQuQuA5pQkWpyvtYNqttL-fiKgqpJpRqHMKw@mail.gmail.com>
 <CAK8P3a3DLP3qPee0us4VZfU7h9ND8vtzA-Lv3a5JVGd=RnxsNg@mail.gmail.com>
In-Reply-To: <CAK8P3a3DLP3qPee0us4VZfU7h9ND8vtzA-Lv3a5JVGd=RnxsNg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 12 Oct 2021 06:34:54 +0300
Message-ID: <CAA8EJposhLFzgXJ3aBXdyvV8ukH+nXQpnY_=uaVBFbgL19QipA@mail.gmail.com>
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

On Mon, 11 Oct 2021 at 12:57, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 11, 2021 at 11:10 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, 11 Oct 2021 at 09:09, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 6:11 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > > On Sun, 10 Oct 2021 at 20:42, Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > The patch seems correct, but it becomes overcomplicated. What about:
> > > > - restoring QCOM_SCM stubs
> > >
> > > The stubs are what has led to the previous bugs in this area to often
> > > go unnoticed for too long, as illustrated by your suggestion
> > >
> > > > - making ARM_SMMU select QCOM_SCM if ARM_SMMU_QCOM
> > >
> > > I assume you meant "select QCOM_SCM if ARCH_QCOM",
> > > after we stop using ARM_SMMU_QCOM?
> > >
> > > > This would have almost the same result as with your patch, but without
> > > > extra ARM_SMMU_QCOM Kconfig symbol.
> > >
> > > The "almost" is the problem: consider the case of
> > >
> > > CONFIG_ARM=y
> > > CONFIG_COMPILE_TEST=y
> > > CONFIG_ARCH_QCOM=n
> > > CONFIG_ARM_SMMU=y
> > > CONFIG_DRM_MSM=m
> > > CONFIG_QCOM_SCM=m (selected by DRM_MSM)
> > >
> > > The stubs here lead to ARM_SMMU linking against the QCOM_SCM
> > > driver from built-in code, which fails because QCOM_SCM itself
> > > is a loadable module.
> >
> > I see. The idealist in me wishes to change my suggestion to
> > 'select QCOM_SCM if ARCH_QCOM || COMPILE_TEST'
> > but I have the subtle feeling that this also might fail somehow.
>
> I think that would actually work, but it has the nasty side-effect
> that simply flipping 'CONFIG_COMPILE_TEST' changes what
> the kernel does, rather than just hiding or unhiding additional
> options.
>
> > > We can move the "select QCOM_SCM" in the ARM_SMMU_QCOM
> > > symbol if we make that a tristate though, if you want to separate it
> > > a little more.
> >
> > This would complicate things a bit, as we would no longer be able to
> > use 'arm-smmu-$(CONFIG_ARM_SMMU_QCOM) +=' construct.
>
> I'm fairly sure we could still use that, Kbuild is smart enough
> to include both 'file-m +=' and 'file-y += ' in 'file.ko', see
> scripts/Makefile.lib:
>
> # If $(foo-objs), $(foo-y), $(foo-m), or $(foo-) exists, foo.o is a
> composite object
> multi-obj-y := $(call multi-search, $(obj-y), .o, -objs -y)
> multi-obj-m := $(call multi-search, $(obj-m), .o, -objs -y -m)
> multi-obj-ym := $(multi-obj-y) $(multi-obj-m)
>
> # Replace multi-part objects by their individual parts,
> # including built-in.a from subdirectories
> real-obj-y := $(call real-search, $(obj-y), .o, -objs -y)
> real-obj-m := $(call real-search, $(obj-m), .o, -objs -y -m)

Ah, I thought Kbuild would accept only  foo-y, please excuse me.

>
> What doesn't work is having a built-in driver in a directory that is
> guarded with a =m symbol, or including a =m object into a =y
> module.
>
>         Arnd



-- 
With best wishes
Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
