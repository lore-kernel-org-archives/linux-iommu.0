Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B73FC433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 09:57:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E560260F21
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 09:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E560260F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5CC9402AC;
	Mon, 11 Oct 2021 09:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g3-GZuT85dIJ; Mon, 11 Oct 2021 09:57:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3467400A4;
	Mon, 11 Oct 2021 09:57:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C195C000F;
	Mon, 11 Oct 2021 09:57:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE7C3C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 09:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFCC240372
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 09:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kRGb_5eCsith for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:57:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9621C40339
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 09:57:12 +0000 (UTC)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M6DrU-1mgTl90Xu4-006bcg for <iommu@lists.linux-foundation.org>; Mon, 11 Oct
 2021 11:57:11 +0200
Received: by mail-wr1-f43.google.com with SMTP id t2so54276339wrb.8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 02:57:10 -0700 (PDT)
X-Gm-Message-State: AOAM533lLV5OiFb/V5fs5od39D0DCVsVz7Xg+LdyxQzAPsGrxFYknMFX
 VtWp6g+hF9MOQUO2bk8c7SC98lX1c7ASEgxaWLY=
X-Google-Smtp-Source: ABdhPJxAE0aTicIaLYe2qnN2pp2cTh2YlBgwyXsBeIGZ6xRxR2Cgvhms/FkNW5VQT+nJ6ErHbjgjqQ/uoPWW1e+ZyE4=
X-Received: by 2002:a05:600c:1548:: with SMTP id
 f8mr7487209wmg.35.1633946230518; 
 Mon, 11 Oct 2021 02:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
 <YWJpJnaQ2Nr4PUwr@yoga>
 <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
 <CAA8EJpoD4Th1tdwYQLnZur2oA0xX0LojSrNFLyJqdi6+rnB3YQ@mail.gmail.com>
 <CAK8P3a3JwQP1b0KeLRN0UCMmzFn3+gY2oexYUwGyt2bOqC0P4A@mail.gmail.com>
 <CAA8EJppAx_bweNhQuQuA5pQkWpyvtYNqttL-fiKgqpJpRqHMKw@mail.gmail.com>
In-Reply-To: <CAA8EJppAx_bweNhQuQuA5pQkWpyvtYNqttL-fiKgqpJpRqHMKw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Oct 2021 11:56:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3DLP3qPee0us4VZfU7h9ND8vtzA-Lv3a5JVGd=RnxsNg@mail.gmail.com>
Message-ID: <CAK8P3a3DLP3qPee0us4VZfU7h9ND8vtzA-Lv3a5JVGd=RnxsNg@mail.gmail.com>
Subject: Re: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Provags-ID: V03:K1:okT0LJvJMJqq3dvl9ijf8qtlnHwl6b8yJnFg67PU/ny6Gi7cT+l
 vPVlcLJmUB+3qejGk3AiV6YlaJ1hLvcoJLe7FNvcH2A+L7F+BjOeQ+AmpTLxzlOhtkELKzI
 Vr455B/N50gBQKzbb1P/grHTjX6VVJpwkGRQZOTqLqnHM+DhyySRNmgTDVMetPjtnNfk91V
 9H3+mnJ5IgTND4CX82UbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QH6D3Ky3v4U=:XVYzkaexdDCg+KyKOSvxqP
 g8YIY60euF/t71Nd5sCNz4v9hfI6ffkZ/RMxKUfAaSGJp2q2as5NqZ/9yDy3fG0Ffm3Y6Uekj
 3r2mL6XA2AsrSIG0MADq2xzJ4B2EIMGdemGyKQaDBZ/HWOiDj1Qrhj3AC4n3jklZlkqBoSbPT
 KrQRBBdkRlnX4v2L8vFMF6GFFJak0GZpgD6W3gzv0wAXlfSMJSGUccGay4bOlfwscEjuH3zu+
 S8RWZdIgrFXTIzrH6u8jg2Wa1Ce4iGDffGaDChpYtPPX8z6M2AUJ5m8ahMRaS2vGRDxIadV/U
 ZtDAfwG+GqeaP5yvlzwkiyoilldHy+CeHXNipqFV3YEUjR4Ajjz2lbkadTMNskui+TIqMe+rV
 pE0/yhnXOTdLrGE/Ka0WTlSflh3Utp+jVDOohbMowbTSKwmswGgY7/xa5mfdjaZxMMXqFj4lj
 wRdxfp3e9PDOJu/UnBCUSBgBz0L3JANrUlpdzeqsuDf5JdNYsXptefsFnmM2yiqS1iObwFZAr
 N5nYX5qPvMYuG6dB93GtGdNGhxVQPbNqjyy3KXN7kt+OoC/gtbivT4CGIHRAw2gWSPHu9MnPK
 r8wNA3XtM0X6j7b0819Gu1nFewIUczCC6lFg0XpSK4xHRpjoIGkZm7OJfBB9PSqJvZbPLcCbB
 jpPs4s6R5fQk2my5lw7fh4wTm8MVSHnvpKFdDjX4mqez5bvNVkEEcv5x+dWE8sbpDQrIigkzO
 FuyfENvLE4XP0EReEaHrzCqsOLkl46/krd7pU0XUuGW6PtAojfDWodlpPYzyI+B+4UnXxhknl
 6x+cya709OJ8gu6zcfq3EWHzAf03I44givCZi4p+OKzYrKHQ1LYITzTgF9y71tWPfa58ynrGZ
 ajYsHoo9BSN9SA4az5gg==
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Mon, Oct 11, 2021 at 11:10 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 11 Oct 2021 at 09:09, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Oct 11, 2021 at 6:11 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > > On Sun, 10 Oct 2021 at 20:42, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > The patch seems correct, but it becomes overcomplicated. What about:
> > > - restoring QCOM_SCM stubs
> >
> > The stubs are what has led to the previous bugs in this area to often
> > go unnoticed for too long, as illustrated by your suggestion
> >
> > > - making ARM_SMMU select QCOM_SCM if ARM_SMMU_QCOM
> >
> > I assume you meant "select QCOM_SCM if ARCH_QCOM",
> > after we stop using ARM_SMMU_QCOM?
> >
> > > This would have almost the same result as with your patch, but without
> > > extra ARM_SMMU_QCOM Kconfig symbol.
> >
> > The "almost" is the problem: consider the case of
> >
> > CONFIG_ARM=y
> > CONFIG_COMPILE_TEST=y
> > CONFIG_ARCH_QCOM=n
> > CONFIG_ARM_SMMU=y
> > CONFIG_DRM_MSM=m
> > CONFIG_QCOM_SCM=m (selected by DRM_MSM)
> >
> > The stubs here lead to ARM_SMMU linking against the QCOM_SCM
> > driver from built-in code, which fails because QCOM_SCM itself
> > is a loadable module.
>
> I see. The idealist in me wishes to change my suggestion to
> 'select QCOM_SCM if ARCH_QCOM || COMPILE_TEST'
> but I have the subtle feeling that this also might fail somehow.

I think that would actually work, but it has the nasty side-effect
that simply flipping 'CONFIG_COMPILE_TEST' changes what
the kernel does, rather than just hiding or unhiding additional
options.

> > We can move the "select QCOM_SCM" in the ARM_SMMU_QCOM
> > symbol if we make that a tristate though, if you want to separate it
> > a little more.
>
> This would complicate things a bit, as we would no longer be able to
> use 'arm-smmu-$(CONFIG_ARM_SMMU_QCOM) +=' construct.

I'm fairly sure we could still use that, Kbuild is smart enough
to include both 'file-m +=' and 'file-y += ' in 'file.ko', see
scripts/Makefile.lib:

# If $(foo-objs), $(foo-y), $(foo-m), or $(foo-) exists, foo.o is a
composite object
multi-obj-y := $(call multi-search, $(obj-y), .o, -objs -y)
multi-obj-m := $(call multi-search, $(obj-m), .o, -objs -y -m)
multi-obj-ym := $(multi-obj-y) $(multi-obj-m)

# Replace multi-part objects by their individual parts,
# including built-in.a from subdirectories
real-obj-y := $(call real-search, $(obj-y), .o, -objs -y)
real-obj-m := $(call real-search, $(obj-m), .o, -objs -y -m)

What doesn't work is having a built-in driver in a directory that is
guarded with a =m symbol, or including a =m object into a =y
module.

        Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
