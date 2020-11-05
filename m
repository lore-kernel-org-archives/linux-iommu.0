Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0141AC55178
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 19:37:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A7B20867
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 19:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhyQlJxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A7B20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E649687311;
	Thu,  5 Nov 2020 19:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QRHiQsb+0ujA; Thu,  5 Nov 2020 19:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4152F8730E;
	Thu,  5 Nov 2020 19:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26112C088B;
	Thu,  5 Nov 2020 19:37:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25B3EC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0B5EA272E3
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BPDjcC3c9KSx for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 19:37:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 8DB6827236
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:37:37 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id t16so2865723oie.11
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 11:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0IeuWIyuaS2pCWkh8SM9vIHTk3Z9xKMgQga1epoP3ng=;
 b=KhyQlJxDU6io8FVXlTraVtbTy3bQuNC6sKWSQlCJoDV3eVUN8R8qBKymBN5FpTznBJ
 4MhBYMa2IuKyTowiy9/fZZPa8rYN0sdd7tu4P2gSHcjnay4/Ewu7Fnkn90lA7bFKqFwU
 yb6Ge7spA+x/jLS4G8ilTQ0oIFhVBUcg0IOm74/C4jRoKRtkmLSh/gFsNOSLkaQvAvkX
 LhSfYwfDvUD2o+ek/F5TywPUJ/TNO/UTLQPZ5VTC7cDsFWpESDgcORcU32pa8PnSWqnO
 98vNzQjj6t5oS5WFavOU9azcEjKsPpiPdpnK/9hEeczBP+OekrcPzv7NotIFDIo4DCVj
 gLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0IeuWIyuaS2pCWkh8SM9vIHTk3Z9xKMgQga1epoP3ng=;
 b=FVzddKHYkJHVOgP6DRl4cDTytUvUyyePk8qd/fBOLU59FEaMVCbwkHCsuKU24CAbMz
 qoFRMGgW+SrIv9UbaVRFI29532se2lGRQf5HmBiq1POU+u4TVBttUcYTzZiSlHwu7eSD
 GpeUam7ORR5V8AZ+9AOg23tn98HHUVWe6d9u2FBIfkBNwJQWqD6JMeyfi74dLV1VhfSG
 FXI3pBNI8fMmpWFjxVUNW04qQCViwxID8Ub4U4grv/WKHOlgbqakqrQnePp2qzq3W9NM
 mlNyLEuKEOxYjEZSdoPoCfsa4t69exybLHJBaDDup3qF2/S6LdJHAoiRYctazljYErdL
 x0Wg==
X-Gm-Message-State: AOAM5337ZPhZDzDGyQIa7GsxBhb8U96Q3C1ww78NzHkuzfFea+DUbvvz
 hjeI9vW1ULAssXs/4G4E+Jd9Sqze9SP9hYH3VBJDpg==
X-Google-Smtp-Source: ABdhPJy6EmV/kijD0O5lYgC/y/tG7BvaOubM7LfjvxCX96j17pkf6e0nRm/f++LPHQRFDQ7t06YdyL9HKphcyBMRX3A=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr587040oia.169.1604605056727;
 Thu, 05 Nov 2020 11:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20201031003845.41137-1-john.stultz@linaro.org>
 <CACRpkda1MV2=0MOMk3t4mr1RczdvfeiNTdbYXX6Jig+6p3TABA@mail.gmail.com>
In-Reply-To: <CACRpkda1MV2=0MOMk3t4mr1RczdvfeiNTdbYXX6Jig+6p3TABA@mail.gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 5 Nov 2020 11:37:26 -0800
Message-ID: <CALAqxLV_GG1tPf9NEHhQN0dtL6DJmOvENVvzdnS-4_o3pNOzoA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] pinctrl: qcom: Allow pinctrl-msm code to be
 loadable as a module
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Todd Kjos <tkjos@google.com>
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

On Thu, Nov 5, 2020 at 6:17 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Oct 31, 2020 at 1:38 AM John Stultz <john.stultz@linaro.org> wrote:
>
> > Tweaks to allow pinctrl-msm code to be loadable as a module.
> >
> > This is needed in order to support having the qcom-scm driver,
> > which pinctrl-msm calls into, configured as a module.
> >
> > This requires that we tweak Kconfigs selecting PINCTRL_MSM to
> > also depend on QCOM_SCM || QCOM_SCM=n so that we match the
> > module setting of QCOM_SCM.
> >
> > Unlike the previous revision of this patch:
> >   https://lore.kernel.org/lkml/20200625001039.56174-5-john.stultz@linaro.org/
> > this version reworks PINCTRL_MSM to be a visible option and
> > instead of having the various SoC specific drivers select
> > PINCTRL_MSM, this switches those configs to depend on
> > PINCTRL_MSM. This avoids adding the oddish looking:
> >   "depend on QCOM_SCM || QCOM_SCM=n"
> > to every SoC specific driver, as that becomes a maintenance
> > headache.
> >
> > We also add PINCTRL_MSM to the arm64 defconfig to avoid
> > surprises as otherwise PINCTRL_MSM/IPQ* options previously
> > enabled, will be off.
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: Maulik Shah <mkshah@codeaurora.org>
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: iommu@lists.linux-foundation.org
> > Cc: linux-gpio@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> > * Module description and whitespace fixes suggested by Bjorn
> > * Added QCOM_SCM || QCOM_SCM=n bits on Kconfigs selecting
> >   PINCTRL_MSM. Reported by both Todd and Bjorn.
> > v3:
> > * Make sure the QCOM_SCM || QCOM_SCM=n trick is commented
> > v4:
> > * Rework "select PINCTRL_MSM" to "depends on PINCTRL_MSM"
> >   to consolidate the QCOM_SCM dependency.
> > v5:
> > * Add PINCTRL_MSM to arm64 defconfig
>
> Bjorn can you have a look at this series?
>
> BTW John  I'm afraid I just merged a new QCOM subdriver so we might
> need to respin this to cover all.
>
> It's an important patch so I'll help out in rebasing it if the only problem is
> that my tree is moving under your feet.

No worries. I'm mostly wanting to make sure there are no objections
with switching PINCTRL_MSM from a selected config to a depended
config.

If that seems ok, I can redo it on whatever point you would like.

I realize I can also split that change out separately from the module
enablement bits as well if its helpful.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
