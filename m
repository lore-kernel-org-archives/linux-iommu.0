Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1879DC433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 06:09:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD74460F21
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 06:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD74460F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CE38402BD;
	Mon, 11 Oct 2021 06:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lNmUsXJFdkun; Mon, 11 Oct 2021 06:09:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 760674039B;
	Mon, 11 Oct 2021 06:09:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5044BC000F;
	Mon, 11 Oct 2021 06:09:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C61E6C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 06:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9980240260
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 06:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P-LUkuFxqaqf for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 06:09:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4901440124
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 06:09:04 +0000 (UTC)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5mOZ-1moD250NND-017Ee9 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct
 2021 08:09:02 +0200
Received: by mail-wr1-f48.google.com with SMTP id m22so52466632wrb.0
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 23:09:01 -0700 (PDT)
X-Gm-Message-State: AOAM532ddKzcs8MC7daBY9fZAj0F6jIHcj0EDPYqjQ1uIsVTQ/UbbKsv
 O07MNNu2YaRIAmC5BdXK5SQJ8Qx+qnAIKU/Q5/E=
X-Google-Smtp-Source: ABdhPJzokqOl1FjpKWa7hPmI46vA3MbqNwtIHx5QkXa4cBkJuMWag11qBpJwNxvearH05lPT0JSjYqMCvI8xjMjduAg=
X-Received: by 2002:a05:600c:1548:: with SMTP id
 f8mr6604283wmg.35.1633932541412; 
 Sun, 10 Oct 2021 23:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
 <YWJpJnaQ2Nr4PUwr@yoga>
 <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
 <CAA8EJpoD4Th1tdwYQLnZur2oA0xX0LojSrNFLyJqdi6+rnB3YQ@mail.gmail.com>
In-Reply-To: <CAA8EJpoD4Th1tdwYQLnZur2oA0xX0LojSrNFLyJqdi6+rnB3YQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Oct 2021 08:08:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3JwQP1b0KeLRN0UCMmzFn3+gY2oexYUwGyt2bOqC0P4A@mail.gmail.com>
Message-ID: <CAK8P3a3JwQP1b0KeLRN0UCMmzFn3+gY2oexYUwGyt2bOqC0P4A@mail.gmail.com>
Subject: Re: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Provags-ID: V03:K1:fUwOIA55gbGXKFLp/RO+P1UCYggaIL+79zAfrEsajDvStofh31i
 yy0OKpDMoljJhjKJh0OQDktjUoAlp8esOaeQmv07OqsOyXbH9Bxpl2v7WpqNLwyAxuSANhd
 G8pRIllWMSMSV0sH5mPVLLYLPZLFnO9DFzqeegpYJtHtwQc1h2kFDZ3+5aIke0kJqrKRZ0e
 gB/2qWcTQocYENBGKMxvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IGl4LElLYx4=:Vwgb69WdXDIiuaSQ1G4Z9i
 M6wfe1Renh20h9TLziuotx9SPr2U5wtLQWiaQ0fZrgOj4Dyn1vF3LwrweeVUoynGLHHag7ZrU
 n3VdiodVNwSuXGSXPKzCXuOFp02u7R9nLwvDupxFIPVfGoY73O4q+BvW3mOr6Qb1mMmXKGNIz
 tyxwclcLToeRLypJILpV8XO6eCvOM88otmpea8kEaR924GKCpkwqmll3KQVVPX6ZP3cj9xpiD
 eRp560uGU+K7FS54akdkh6WtRRBqsdzsmo7Yj9NhcjrkoPfpemw/E9X3Thm2waWLMOac3yqUJ
 ctQ48Ao5p+RUYewfTl3Z7MlahI+GNVrzKDy1sdyP3Caz6KJMUWTOR9TNCp7+aFU/2C5lGPo1w
 lhTjCun9AKomuPVvbbFHr3rWOWle06aHQejfQnQISNG/uwqFT6V3CClY6qrnApDe43K+SzvlM
 nG9cqhPus57Kq9xDm1PB5S53C5gUnD6KucEeEIAU4MYo1B7Cx3TTzXwD9pIxwpf+iuJVKQwqh
 VQ8oTnPNiPEeijNnI3BSz6uiLof0m2WnDn1gD8+d/gW1PoyLiva7xBDmedEJGGuBr/9YX0IKi
 fo/Y4eFh8J2jl5yaUv17UhxZNIET4q+EsV0bVuy+k+O2b1SU7XR3XyTkW3X90orwAx4SW0b7x
 uO/yHb6+bCVrlD14V2zHEsKBdTNMUYxJdp2wkk0dBLMQvPLyxzt7ztNKzDSDC1x1a1JvT/J68
 grQ3EPgv7ZGK7Uq93a9Dy/uXDsX5AqcHLUgt/lBuZe3IW4aZFCi/hr+mcseUY3vxpipqUGzOB
 whUA1iHaJMFPddv8lkFwRIBdpihfbWdXFmyICJuA0H+FP6D325cBoZqOQNR7lJJ8hXiVDP+Rg
 FbhAcL6PJ67wJ9ySVkHQ==
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

On Mon, Oct 11, 2021 at 6:11 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> On Sun, 10 Oct 2021 at 20:42, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The patch seems correct, but it becomes overcomplicated. What about:
> - restoring QCOM_SCM stubs

The stubs are what has led to the previous bugs in this area to often
go unnoticed for too long, as illustrated by your suggestion

> - making ARM_SMMU select QCOM_SCM if ARM_SMMU_QCOM

I assume you meant "select QCOM_SCM if ARCH_QCOM",
after we stop using ARM_SMMU_QCOM?

> This would have almost the same result as with your patch, but without
> extra ARM_SMMU_QCOM Kconfig symbol.

The "almost" is the problem: consider the case of

CONFIG_ARM=y
CONFIG_COMPILE_TEST=y
CONFIG_ARCH_QCOM=n
CONFIG_ARM_SMMU=y
CONFIG_DRM_MSM=m
CONFIG_QCOM_SCM=m (selected by DRM_MSM)

The stubs here lead to ARM_SMMU linking against the QCOM_SCM
driver from built-in code, which fails because QCOM_SCM itself
is a loadable module.

We can move the "select QCOM_SCM" in the ARM_SMMU_QCOM
symbol if we make that a tristate though, if you want to separate it
a little more.

        Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
