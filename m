Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE38C4742C
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 19:41:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C7F2076E
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 19:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tasZqXsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C7F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F34E886416;
	Mon, 16 Nov 2020 19:41:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gn-P72J7+BTY; Mon, 16 Nov 2020 19:41:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 38BF585191;
	Mon, 16 Nov 2020 19:41:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2943DC0891;
	Mon, 16 Nov 2020 19:41:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 708ECC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 19:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6A08085FD5
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 19:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXqOGqiD7aXC for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 19:41:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9C04A85FB9
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 19:41:07 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id f11so6331010oij.6
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 11:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6keoknQ1MsKwnGp8atRoEQd/F72ZsuKmob9p0v6BNfM=;
 b=tasZqXsCQKKnY90DDBOFueK9bf/kmpGBOAMyvne0z9yM75iExvuVlnIk0btPNoCiCW
 yBmB+CMAN2cCImV2JGL6cpu714isOmHVLvsDEAO62hR3/dtTAQjN1lWQes+JEayo9rmB
 500b83lVZ/U5gjKhj7DHSvEwv0Dq75nbcJd3BKzd82GcHv2oH0iq+catANFxSt/ijASr
 sV5A7ECRSgg5x8ZJrv9XEQ94yyPRPGBZVW8MxWLb/Z4w5TaBkabO1CCmTtqPoREqgHS9
 lE0Iqa6FxfaQU7AcM3ngJPdJSY0Hw/6W+vD+vLQepB7oE+fQA7uoAEuYolzsyADOj3AO
 O8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6keoknQ1MsKwnGp8atRoEQd/F72ZsuKmob9p0v6BNfM=;
 b=m0AztsWGdTvWOz1nSrdj0q2FDQF2NDDxikAEQpz76jglF3XYHWwx9q7DwP6uQwyM7Q
 J7rFgzhlHxebIJwHVy3wUHVfaaujucquC2RJx14huw+4ounvBgUtUeDe5SYundYuwieQ
 7xdmY9UWL5WiXCcvE9bFKOoQe4bawG/9wmrPSL2hwitbjA60RmZRkSLPIGzj+WP1Or26
 XW/+firuJojimJAFs/BzAs9xtUrvvfjtFGa/ZJWkGlbeg/2R8eKocUEwYiK+udJLPQ1v
 FFo1orPJya/bacd3ycpM9v8pbEY4S2yLO0QaTsF81ErMVjYbkJeZZ8zXfAlYtdpk7s99
 w1Yg==
X-Gm-Message-State: AOAM531CIsv4mLmiimeh86pmYqiIjNxWysmuLP4q039gFr/Fnexn8W/g
 qWycSCrZdjwwbfD+KBW1n7otwf3dGLfdHrhqGXMmxw==
X-Google-Smtp-Source: ABdhPJwJgF7lB1wdlG4FfTWlBxtm5nm8SQZOWNMyXCDlUcOypoXNgjIFwoE/Hheuqlcxou/pA7ro3Cacgg/Nbmah4fU=
X-Received: by 2002:aca:c3d6:: with SMTP id t205mr218361oif.10.1605555666955; 
 Mon, 16 Nov 2020 11:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
 <20201116155936.GE2224373@ulmo>
In-Reply-To: <20201116155936.GE2224373@ulmo>
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 16 Nov 2020 11:40:55 -0800
Message-ID: <CALAqxLXhpE-vw_jL-0_fc1eg-aU5_sLwoNAUiPdUUHx2ubxrkw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jon Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
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

On Mon, Nov 16, 2020 at 7:59 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Fri, Nov 06, 2020 at 04:27:10AM +0000, John Stultz wrote:
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 04878caf6da49..c64d7a2b65134 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -248,6 +248,7 @@ config SPAPR_TCE_IOMMU
> >  config ARM_SMMU
> >       tristate "ARM Ltd. System MMU (SMMU) Support"
> >       depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> > +     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> >       select IOMMU_API
> >       select IOMMU_IO_PGTABLE_LPAE
> >       select ARM_DMA_USE_IOMMU if ARM
>
> This, in conjunction with deferred probe timeout, causes mayhem on
> Tegra186. The problem, as far as I can tell, is that there are various
> devices that are hooked up to the ARM SMMU, but if ARM SMMU ends up
> being built as a loadable module, then those devices will initialize
> without IOMMU support (because deferred probe will timeout before the
> ARM SMMU module can be loaded from the root filesystem).
>
> Unfortunately, the ARM SMMU module will eventually end up being loaded
> once the root filesystem has been mounted (for example via SDHCI or
> Ethernet, both with using just plain, non-IOMMU-backed DMA API) and then
> initialize, configuring as "fault by default", which then results from a
> slew of SMMU faults from all the devices that have previously configured
> themselves without IOMMU support.

Oof. My apologies for the trouble. Thanks so much for the report.

Out of curiosity, does booting with deferred_probe_timeout=30 avoid
the issue for you?

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
