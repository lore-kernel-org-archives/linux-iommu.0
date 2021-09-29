Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24522C433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 10:05:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD754613D3
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 10:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD754613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 995DA80ECB;
	Wed, 29 Sep 2021 10:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmSNOk0tGUPP; Wed, 29 Sep 2021 10:05:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 808E480EB1;
	Wed, 29 Sep 2021 10:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F44DC0011;
	Wed, 29 Sep 2021 10:05:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CFD7C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 048E3415BF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KeQhJRU-gazO for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 10:05:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75B0C415BB
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:05:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06A8B613DA
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632909914;
 bh=Xxn9/SD1dYhlDwttos3PuGBQ5U/2yCNeeOkyqW/lvMU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ORjEaY8oVoBe/kc1cZJj2pdtkHjlj8HbwEZxZTWQ2RJxE3GmpxNBmdNmOnphEgvSX
 ZOxvvBYGhy3vPJuqA7LfPTEfGfZd04jb5pa8GODKkdyshK6wcZoWwPGMWC+MS9U+hB
 xbVhK4m/Jq2Iwa6W/3givlEv93HsBHlrwK8xareW519JavUdMcvSDsFayE2ZD0oN8U
 pIltEb8rvFoy0z9I8Y2vMLwBlDucBVUKGTbifrVUXnBcQOBZxHm/pShHiIlrwCdByI
 22paW8ns7SMXCobLPJLkLp0xaLAaB7vuo8aCGQL+Oy4kg80h0CJMOIrD0tYnYvfS9M
 gE71ALaohzM2g==
Received: by mail-wm1-f41.google.com with SMTP id
 i6-20020a1c3b06000000b0030d05169e9bso2557071wma.4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 03:05:13 -0700 (PDT)
X-Gm-Message-State: AOAM5308Cgq9JHALwsz7rXwjf1N41y8quxS57A62ekkb8omHWtXB4JXG
 zcP9GYp0cC4QQZD9DyGy1bRd91lV1WK3A01x3yM=
X-Google-Smtp-Source: ABdhPJxj45zzIMnN/HHyq+6nU2KpFjlg3Tr2+Q2ZpxFzEZguNBmccSscTdNWt05AmI9I9AwUnU3a/laQUUwcLa8ETFA=
X-Received: by 2002:a05:600c:896:: with SMTP id
 l22mr9378065wmp.173.1632909912585; 
 Wed, 29 Sep 2021 03:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210927152412.2900928-1-arnd@kernel.org>
 <20210929095107.GA21057@willie-the-truck>
In-Reply-To: <20210929095107.GA21057@willie-the-truck>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 29 Sep 2021 12:04:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2QnJkYCoEWhziYYXQusb-25_wUhA5ZTGtBsyfFx3NWzQ@mail.gmail.com>
Message-ID: <CAK8P3a2QnJkYCoEWhziYYXQusb-25_wUhA5ZTGtBsyfFx3NWzQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] qcom_scm: hide Kconfig symbol
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Airlie <airlied@linux.ie>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, ath10k@lists.infradead.org,
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

On Wed, Sep 29, 2021 at 11:51 AM Will Deacon <will@kernel.org> wrote:
> On Mon, Sep 27, 2021 at 05:22:13PM +0200, Arnd Bergmann wrote:
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 124c41adeca1..989c83acbfee 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -308,7 +308,7 @@ config APPLE_DART
> >  config ARM_SMMU
> >       tristate "ARM Ltd. System MMU (SMMU) Support"
> >       depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> > -     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> > +     select QCOM_SCM
> >       select IOMMU_API
> >       select IOMMU_IO_PGTABLE_LPAE
> >       select ARM_DMA_USE_IOMMU if ARM
>
> I don't want to get in the way of this patch because I'm also tired of the
> randconfig failures caused by QCOM_SCM. However, ARM_SMMU is applicable to
> a wide variety of (non-qcom) SoCs and so it seems a shame to require the
> QCOM_SCM code to be included for all of those when it's not strictly needed
> at all.

Good point, I agree that needs to be fixed. I think this additional
change should do the trick:

--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -308,7 +308,6 @@ config APPLE_DART
 config ARM_SMMU
        tristate "ARM Ltd. System MMU (SMMU) Support"
        depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
-       select QCOM_SCM
        select IOMMU_API
        select IOMMU_IO_PGTABLE_LPAE
        select ARM_DMA_USE_IOMMU if ARM
@@ -438,7 +437,7 @@ config QCOM_IOMMU
        # Note: iommu drivers cannot (yet?) be built as modules
        bool "Qualcomm IOMMU Support"
        depends on ARCH_QCOM || (COMPILE_TEST && !GENERIC_ATOMIC64)
-       depends on QCOM_SCM=y
+       select QCOM_SCM
        select IOMMU_API
        select IOMMU_IO_PGTABLE_LPAE
        select ARM_DMA_USE_IOMMU

I'll see if that causes any problems for the randconfig builds.

       Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
