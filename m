Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF662C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 09:09:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829C360F5B
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 09:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 829C360F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53A7B403B9;
	Mon, 11 Oct 2021 09:09:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id msRyVhhVrq5G; Mon, 11 Oct 2021 09:09:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 373E6403C2;
	Mon, 11 Oct 2021 09:09:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 006B2C000F;
	Mon, 11 Oct 2021 09:09:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A1FDC000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 09:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27F7C60778
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 09:09:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9ytTsB1EIpq for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:09:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A53260723
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 09:09:33 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id p4so15898017qki.3
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mmIaLKrbsPcdQfNFBZqmZSPhrHWq8Kaob/N8FHo8Fls=;
 b=bngqbi74I3OBcqTY+RIZ8kWeuOyHiNmThFK5GldqFngvi3XfTkB/kMa4N7aEWxGf4C
 kmh669p4sU54vplIHzevZ6ejfSTv8hQ21EVKnM3Jwjd1juoNN9ok18sOGEGqKGm5O9aH
 yhIP76S1l/RUi3QUGSxRbqeKPvS+o6qroqohq5p8ltaBoa+yfGFdtK5ZE3EMpU4WKzMe
 CJMphtVwLtgfuCENg9doUy6BDJckfpz3LduUs/nX7anoP4IElpegKccrPUZlfiuoxQCR
 waBzIhbVBdiKwgqZ5Bw+t2UKyjagxdCSTYIJcAMPGNUOLWOYTDu/jgsdMw45ow121n44
 6s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mmIaLKrbsPcdQfNFBZqmZSPhrHWq8Kaob/N8FHo8Fls=;
 b=SQhkbArF/Ce1lZ2R6fa4idOXWH0LV6K/EBQJeMOfQAjUZsZ8fw4PRsXxZMxXC7BA9c
 YJc/8tbfEZCgfJLAodVme5KKFIplVmif6kFLiKikHhsq+M7Qbf8tpiFINqccyHyy4G0q
 qA9rFTZJCvL9lIn8OnMHQvgFeaXkyuSNCStcScV2j9xy8t19MIlK1mKbARUFyne9UZtR
 Dt6wlWDKhR5coqzsUTIFY1wYFdHWBkSwlbJZvfDgxs//o/XGfeivIH/Kd9IPFnyt+/n/
 uHMaaDRSO3GlMUyp1bBMys0Lqi1ADnpqcKODla7ibAp3o7lj0nYk+9jPte/pHrfWibCj
 o/mw==
X-Gm-Message-State: AOAM530Z4Wna0srtbK8M7XdFLk2nopzGb19EOgriSz1mhN+FhE8kjx+G
 FQ5GtZp8Zif0BQKPWTY32VaxVhEQRQRtxgZ/YxzxtA==
X-Google-Smtp-Source: ABdhPJzCAxoh0kT9ewt0cklMxy0VT0v9K2ZuPa0Z4w1Vsd8VSQc2Y+VzTMDaIihHeM05/lPiH0fVvh6FpbA5nCRCiuM=
X-Received: by 2002:a37:bac6:: with SMTP id
 k189mr13621788qkf.186.1633943372114; 
 Mon, 11 Oct 2021 02:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
 <YWJpJnaQ2Nr4PUwr@yoga>
 <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
 <CAA8EJpoD4Th1tdwYQLnZur2oA0xX0LojSrNFLyJqdi6+rnB3YQ@mail.gmail.com>
 <CAK8P3a3JwQP1b0KeLRN0UCMmzFn3+gY2oexYUwGyt2bOqC0P4A@mail.gmail.com>
In-Reply-To: <CAK8P3a3JwQP1b0KeLRN0UCMmzFn3+gY2oexYUwGyt2bOqC0P4A@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 11 Oct 2021 12:09:21 +0300
Message-ID: <CAA8EJppAx_bweNhQuQuA5pQkWpyvtYNqttL-fiKgqpJpRqHMKw@mail.gmail.com>
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

On Mon, 11 Oct 2021 at 09:09, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 11, 2021 at 6:11 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> > On Sun, 10 Oct 2021 at 20:42, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The patch seems correct, but it becomes overcomplicated. What about:
> > - restoring QCOM_SCM stubs
>
> The stubs are what has led to the previous bugs in this area to often
> go unnoticed for too long, as illustrated by your suggestion
>
> > - making ARM_SMMU select QCOM_SCM if ARM_SMMU_QCOM
>
> I assume you meant "select QCOM_SCM if ARCH_QCOM",
> after we stop using ARM_SMMU_QCOM?
>
> > This would have almost the same result as with your patch, but without
> > extra ARM_SMMU_QCOM Kconfig symbol.
>
> The "almost" is the problem: consider the case of
>
> CONFIG_ARM=y
> CONFIG_COMPILE_TEST=y
> CONFIG_ARCH_QCOM=n
> CONFIG_ARM_SMMU=y
> CONFIG_DRM_MSM=m
> CONFIG_QCOM_SCM=m (selected by DRM_MSM)
>
> The stubs here lead to ARM_SMMU linking against the QCOM_SCM
> driver from built-in code, which fails because QCOM_SCM itself
> is a loadable module.

I see. The idealist in me wishes to change my suggestion to
'select QCOM_SCM if ARCH_QCOM || COMPILE_TEST'
but I have the subtle feeling that this also might fail somehow.

>
> We can move the "select QCOM_SCM" in the ARM_SMMU_QCOM
> symbol if we make that a tristate though, if you want to separate it
> a little more.

This would complicate things a bit, as we would no longer be able to
use 'arm-smmu-$(CONFIG_ARM_SMMU_QCOM) +=' construct.

-- 
With best wishes
Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
