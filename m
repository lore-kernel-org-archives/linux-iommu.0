Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B1EC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 14:46:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A744E611C8
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 14:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A744E611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7625A60B0D;
	Wed, 29 Sep 2021 14:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hPMZcabUqbsb; Wed, 29 Sep 2021 14:46:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 51CB060758;
	Wed, 29 Sep 2021 14:46:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21310C000F;
	Wed, 29 Sep 2021 14:46:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F717C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 14:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E423830DE
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 14:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p9pIrjx9Dy6U for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 14:46:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65CA981020
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 14:46:31 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 c26-20020a056830349a00b0054d96d25c1eso3136273otu.9
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=JgcoX77LyqJgFfCrFyyxOmmlaV13zT4pyPZ6+xdzSpA=;
 b=spTZQ2DbWP0psTWqELtDKdf3ctbS0vkigNQvxkRIwhOKUH8KugD69eFtioiLkoK3Gy
 wtqV+fvcjNiD9+cDbUIXJF+qCw7Y3d8YdkSsHI7IVobxU9CSf3vqhqyWu/Oq2SRFBdHo
 neDrQGuVYezgzLNIKMm1q/0+ChFeu07DQsXdVBLPC5Qj84WxDssil2uJW+0l+TPuEHxn
 Ll6FKrKdGbGmGBGxLGRQmQdKBljtf5QtFgK2eTl3cDvLsBHoaJmId4Ifl7rnnbvBhn0D
 LTj441MSq8B+PPi3TmUJ+3vz8OX7s4Ovl41Aj0dWJafRLB3UbpVpcLmdU8ARwxFqFRiP
 nSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JgcoX77LyqJgFfCrFyyxOmmlaV13zT4pyPZ6+xdzSpA=;
 b=Qx6tgPrjZFLiPzz0wvS6sD5sVdl6YbNEg5FLbvsQUJW/q+bGJsiv2vX3gcpd1NaWCm
 kCiDmbpcqYtG1rspBkkSN4nFqebUJPud+bzX53e57bc3PKiRiO4uzyaUDaIoP67OUgFC
 IO1yY/nWGuArtHS9XdAPXIMgWcv2ziOXJxX9qjg5DzXg2vIPuxKmMtZLZKsNSqqav+WU
 bFY6GqH2Hm/KiRrYmxnQKGmUWl9QuLB5byBxyAEZDdtBb888c45cwy631n/E0uMAm7v8
 tW9csZ/u3nFL21llqJT6sewJaAIq8yDO8xRAmFWqFJ3Nf1W3z8flFjWcdS7+qIPfUBZH
 LYxQ==
X-Gm-Message-State: AOAM530Y3to+rBWyM55eQ7lcgwbOvd3H330JeFDoNHt0dVT2o33swCVg
 YpFllg7c/RIPAiqwXxi++0FmYw==
X-Google-Smtp-Source: ABdhPJy1xutLgHZ1k75FBuuFr8v0/9rSKe4U8iMaiX+gLlBxKTV+rJxW6+Z2BJ3/QZooCn7GiUFhFA==
X-Received: by 2002:a9d:6254:: with SMTP id i20mr324075otk.349.1632926790406; 
 Wed, 29 Sep 2021 07:46:30 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id v14sm5473ook.2.2021.09.29.07.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 07:46:29 -0700 (PDT)
Date: Wed, 29 Sep 2021 09:46:27 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] [RFC] qcom_scm: hide Kconfig symbol
Message-ID: <YVR8Q7LO0weiFin+@yoga>
References: <20210927152412.2900928-1-arnd@kernel.org>
 <20210929095107.GA21057@willie-the-truck>
 <CAK8P3a2QnJkYCoEWhziYYXQusb-25_wUhA5ZTGtBsyfFx3NWzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2QnJkYCoEWhziYYXQusb-25_wUhA5ZTGtBsyfFx3NWzQ@mail.gmail.com>
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

On Wed 29 Sep 05:04 CDT 2021, Arnd Bergmann wrote:

> On Wed, Sep 29, 2021 at 11:51 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, Sep 27, 2021 at 05:22:13PM +0200, Arnd Bergmann wrote:
> > >
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index 124c41adeca1..989c83acbfee 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -308,7 +308,7 @@ config APPLE_DART
> > >  config ARM_SMMU
> > >       tristate "ARM Ltd. System MMU (SMMU) Support"
> > >       depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> > > -     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> > > +     select QCOM_SCM
> > >       select IOMMU_API
> > >       select IOMMU_IO_PGTABLE_LPAE
> > >       select ARM_DMA_USE_IOMMU if ARM
> >
> > I don't want to get in the way of this patch because I'm also tired of the
> > randconfig failures caused by QCOM_SCM. However, ARM_SMMU is applicable to
> > a wide variety of (non-qcom) SoCs and so it seems a shame to require the
> > QCOM_SCM code to be included for all of those when it's not strictly needed
> > at all.
> 
> Good point, I agree that needs to be fixed. I think this additional
> change should do the trick:
> 

ARM_SMMU and QCOM_IOMMU are two separate implementations and both uses
QCOM_SCM. So both of them should select QCOM_SCM.

"Unfortunately" the Qualcomm portion of ARM_SMMU is builtin
unconditionally, so going with something like select QCOM_SCM if
ARCH_QCOM would still require the stubs in qcom_scm.h.

Regards,
Bjorn

> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -308,7 +308,6 @@ config APPLE_DART
>  config ARM_SMMU
>         tristate "ARM Ltd. System MMU (SMMU) Support"
>         depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> -       select QCOM_SCM
>         select IOMMU_API
>         select IOMMU_IO_PGTABLE_LPAE
>         select ARM_DMA_USE_IOMMU if ARM
> @@ -438,7 +437,7 @@ config QCOM_IOMMU
>         # Note: iommu drivers cannot (yet?) be built as modules
>         bool "Qualcomm IOMMU Support"
>         depends on ARCH_QCOM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> -       depends on QCOM_SCM=y
> +       select QCOM_SCM
>         select IOMMU_API
>         select IOMMU_IO_PGTABLE_LPAE
>         select ARM_DMA_USE_IOMMU
> 
> I'll see if that causes any problems for the randconfig builds.
> 
>        Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
