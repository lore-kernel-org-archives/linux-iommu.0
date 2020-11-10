Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331F9C55ABD
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 18:52:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FAF206F1
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 18:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rlrl4p2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FAF206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 059A8864E6;
	Tue, 10 Nov 2020 18:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KtDNuq4UvX7c; Tue, 10 Nov 2020 18:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 063E785FB4;
	Tue, 10 Nov 2020 18:52:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFC97C0889;
	Tue, 10 Nov 2020 18:51:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10FE6C016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 18:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 023C9865D0
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 18:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EZM44dLRAufl for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 18:51:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 55C55864D8
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 18:51:58 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id o25so14710633oie.5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 10:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=826np2PxKqFL3zSQ2fpJeZlz2mlRc601JZEk4tIHC1M=;
 b=Rlrl4p2Y6lZvqNR8E24S8da/cXQGeB1M27W/LlGW4hy5KNmaQobM8OTxClsc9Yl5uN
 6SPIANnQNxRhyZlcmHsQuyKTUs5CNu9s79IZ5oREJd0xETjA0dTCuGgA40DnTG+bxdGR
 LwEzdv2py8dGpXOoswmeHQY3Dt3slRmwRzEIqIEma59rg+BfjtznkGKOOELPMtcZCzyx
 YnaccValyI4B96qYUYEubMPqCHg/AuvnL+7UJvM9EHpSkhRjz2si2cKUJT3gn/A5xsSE
 i7/de52Op0WPOYrVperu3vFx8kGFYvWM+e2clE/EiCAiiG7SbVWdO7g9ZIbnbpz2PWWg
 Be4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=826np2PxKqFL3zSQ2fpJeZlz2mlRc601JZEk4tIHC1M=;
 b=iu5Y2QeXCJnJC9Q/NMughtOOiKGHPzN1YvyAuHnER5f/NunLSdKvHyjPjixLrL7h4e
 KAnXS2LZh8d7ygXJVb+xY7scqFBX/ALNk+KcO6B3ksa2K1pLj5Q1wSwl9J+Vp5lb1wSi
 rdEgZ42Q0bWzqh6jcMUHoMH0teQxtFXezTVj80HAHt/fUKG2DrSAsAYvgpxV/0Tb8yLL
 VX1fCsi+bSn/WXTVcshZbKmfSmsFx0Az1Q9CV1mEiJbxQNASq5VFFgLD1YtQe1ce4O5A
 e4JBTTGaGf1P9xmBaIJGb7H5jfp4qqpYR73V1xTcsQhDsMuEps61/fwvOsoWmRd2yQF+
 NpEA==
X-Gm-Message-State: AOAM530xufXxNzxJiNK4Q6QNhTZT+47KPFcjBu31O5vbcNdfl9oO9wev
 F4+Xrgm6tFzdQRr0eVjZptJdyqenLVqA9z4rf/OhWA==
X-Google-Smtp-Source: ABdhPJx88dzHpuYy9bRpNGryBDTkX3nWTsEfw1TsuASXA/NUJ1dZb2sTcAyETEW/Ic3NbIkjRbQ8kWz0+ErBnlh8dlU=
X-Received: by 2002:aca:c3d6:: with SMTP id t205mr380138oif.10.1605034317546; 
 Tue, 10 Nov 2020 10:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
 <CACRpkdYhfjRBz8GwMyCrOTzjd-Y6-G16xPjH6xhwSHcnaJfuXA@mail.gmail.com>
In-Reply-To: <CACRpkdYhfjRBz8GwMyCrOTzjd-Y6-G16xPjH6xhwSHcnaJfuXA@mail.gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 10 Nov 2020 10:51:46 -0800
Message-ID: <CALAqxLXigwvauJgvN5FxoND60zybYw1L78POHY6KoxP2_gpkFA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
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

On Tue, Nov 10, 2020 at 5:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Nov 6, 2020 at 5:27 AM John Stultz <john.stultz@linaro.org> wrote:
>
> > Allow the qcom_scm driver to be loadable as a permenent module.
> >
...
> I applied this patch to the pinctrl tree as well, I suppose
> that was the intention. If someone gets upset I can always
> pull it out.

Will: You ok with this?

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
