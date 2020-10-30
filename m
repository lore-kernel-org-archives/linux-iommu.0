Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51173C61DD8
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 06:09:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A992A2223F
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 06:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgxkN2Fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A992A2223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0202D8442D;
	Fri, 30 Oct 2020 06:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IIkMtfz5gA3; Fri, 30 Oct 2020 06:09:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 641BD8472A;
	Fri, 30 Oct 2020 06:09:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3864DC0859;
	Fri, 30 Oct 2020 06:09:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0545C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 06:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A404587080
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 06:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vXbrk5mmacT4 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 06:09:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E42CD8707E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 06:09:34 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id n11so4673255ota.2
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OHv3qXD9Nsz5SAwNQFVqE8iplEapZHDVektBwmjGoKQ=;
 b=lgxkN2Fiq0uQ+gFWcLDxMWjgOVcYPPlJM7bC4PRz2pSd+ehz1CZNpVLED6kwZy5nsc
 jH9c4wXmRVZR8puuWHpatKJBb4XPHAcf6kcYw9ssDOd6ZZo22m+2C1ayerMeni7E1s6d
 87p67dmH+pYH13N0VkV7Lv/SyzKEbUsu79/2B2G5xGo1boHvSZvw+ferESovUGFc5Jss
 cgUF8AwDVRuDjL1wVuhYNjpYYEOF5GwBMD3ijyGmFSBuY6/r92ESfiK2Z2/M6qHofEQY
 Gfq/h6GY422vzTK5+dwfvtC2XnfYtti1gk0XTuwQpwtpU4/3kIcQhQmWv+R4jFTp1E+C
 VvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OHv3qXD9Nsz5SAwNQFVqE8iplEapZHDVektBwmjGoKQ=;
 b=s1Feqm7NchIlbEe63YV2BZ+FND/0CFSrv3+dkbZsPJHsijdCpB0j95e5GiGdsWq/Qd
 fuODuj2eMU3Q1CRxeP2oi/wmJT2QTXG+V1vGAGEcg+FSsocTb+w5qOu4br6xflz2ie2Y
 JuYnR3P9A3on436aYy+Lw4YFpHNCmFqeI4PSVSRGlw3gg7oNqVL/jjh0t79HMcmoZcUq
 vSaX+fVM8E4DE47BPunPwowb+uPMdki4/xliNPSo8bnTXv0GtL0xHW1ihatwtwMkjrLl
 arKUujGSYpvWUAubm505Qc7jnX+ZJSCjl/iX+lz6ASDTtr2triv1wtNknEg0nt9jd0G4
 7BQg==
X-Gm-Message-State: AOAM533KoTPqcFjfNgi7dUzktNgmgn6erH+uvPWHUFcOYIwpGNRhGRZ7
 jDJdx6Lyn9x1w+3Uicmh0JHt7mMGh/ReQL/ECGAMCg==
X-Google-Smtp-Source: ABdhPJy+qBsU/PGTXqQlbB+9AAjGvJ/8yyf5j0GKrjlrXDXbjKlnjfleDVvxRlBaDOzesvGrgg6pDipyuVyjHj8F22Q=
X-Received: by 2002:a05:6830:400c:: with SMTP id
 h12mr561860ots.102.1604038173959; 
 Thu, 29 Oct 2020 23:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-6-john.stultz@linaro.org>
 <20200702141825.GA16941@willie-the-truck>
 <CALAqxLVZ2EhutYjOt7Be1RgnYwHT6-4m6DxA-t1wuxuSy=6yDQ@mail.gmail.com>
 <20200710075411.GA30011@willie-the-truck>
 <CALAqxLWadLrxckRHRAR0Q417RnFKquQJbRfO_DLEVH56cykRow@mail.gmail.com>
 <20200713204133.GA3731@willie-the-truck>
 <CALAqxLUDVEq4ds2Wbic6uaK3=dELKKO4eGQxjHFFz19GeUFd_w@mail.gmail.com>
 <20201028135118.GA28554@willie-the-truck>
In-Reply-To: <20201028135118.GA28554@willie-the-truck>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 29 Oct 2020 23:09:21 -0700
Message-ID: <CALAqxLWyam_+R6KubTpFKrWkHGPXrqa+6Tz=BDxeP3t_gSqHCg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: Will Deacon <will@kernel.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Todd Kjos <tkjos@google.com>
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

On Wed, Oct 28, 2020 at 6:51 AM Will Deacon <will@kernel.org> wrote:
> On Tue, Oct 27, 2020 at 10:53:47PM -0700, John Stultz wrote:
> > Alternatively, I'm considering trying to switch the module dependency
> > annotation so that the CONFIG_QCOM_SCM modularity depends on ARM_SMMU
> > being a module. But that is sort of putting the restriction on the
> > callee instead of the caller (sort of flipping the meaning of the
> > depends), which feels prone to later trouble (and with multiple users
> > of CONFIG_QCOM_SCM needing similar treatment, it would make it
> > difficult to discover the right combination of configs needed to allow
> > it to be a module).
> >
> > Anyway, I wanted to reach out to see if you had any further ideas
> > here. Sorry for letting such a large time gap pass!
>
> Well we can always go with your original hack, if it helps?
>
> https://lore.kernel.org/linux-iommu/20200714075603.GE4277@willie-the-truck/

Yea. After trying a few more ideas that didn't pan out, I think I'm
going to fall back to that. :(

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
