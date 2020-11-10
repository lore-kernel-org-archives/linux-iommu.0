Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB52DC55ABD
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 13:35:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D20120797
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 13:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cu4E3yWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D20120797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B8A6087374;
	Tue, 10 Nov 2020 13:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hhPFAoPjGGjU; Tue, 10 Nov 2020 13:35:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1A5A287146;
	Tue, 10 Nov 2020 13:35:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06CAEC088B;
	Tue, 10 Nov 2020 13:35:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BDFAC016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 13:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 19B4A862F4
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 13:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CzbvqeOSaVG7 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 13:35:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 04AC9863D5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 13:35:25 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id 11so14688591ljf.2
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 05:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TwpBqZ9wlj7+aBjYzX3QdgPnoVhWXfegb/AHhFFvol8=;
 b=Cu4E3yWJ7MzfCcz1Z/f26Tyr8WutTCFXbfM0UR249wRJakMTDIUbLlBL84QdcbeuHF
 hxLx7t4IVjBj9F21rR+xXYKQ2yQTP25xJGR3vsSvG7hNUgdJ6K2xv7h2AQJobyrHjiTt
 iBCCE8JugddN0iqqsX2rppLtwGBIFie1v8wKAHYQivVxdsqflXEWeGMDRkBR111EJ6EQ
 Sg+gtibz03ieM1v4GlmM5xmEVi5ulmIWru4CkRGrK7l8MXJzHw6nWWTzzhYNmOh6v1Aj
 YmhSxZiX4bYIwl2uIkkTnqntFODGSr8io9hYFZ44SBDIjCzIDylSqo9+Nxjpb0sOQok7
 dQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TwpBqZ9wlj7+aBjYzX3QdgPnoVhWXfegb/AHhFFvol8=;
 b=HMzSqBpxyMl/vXi05zSLpSNjDOZNGa2B+XehS7/2+VHza1MfklkIqrrFLcJjWzbvgQ
 1YxzmneyOqdwRBtRj/9/K7TsSq3tDgomWZ30en0p6Sva9NLOYb+bkFCXFUtn3DMTUcCc
 xIflTZVlS+90qLrw7sK/GtQVfBmHZRdUyFyFFvQuolchKMlqgPjDStlcXZ4GzuphdvIR
 +hnBm2vtS+BY782kgmjgBlIlqaE4sO6c4OT4teZ+tpSxfM++gdGymkfOWIlypKLcJAOZ
 bBvX+Wrmy060OyUQGyQZ8+b8w/oA7I+Rnf3LReR4yZfIBit2yfNvVW548SKdPO36HVTw
 CTUQ==
X-Gm-Message-State: AOAM532+IsrQ0xVT7Antmu8AmY6rJi/OFATb7XLD/MMHIpk9ohJKMsg6
 Vguge7PFtxdB40470K2zMMnxSdGde0ri8IX/ZVNgTg==
X-Google-Smtp-Source: ABdhPJwGVBWeBazu2okiJzWVPEutrrd1hrLuJ+fP/VIU2W3kUAdBSK6UGspEDbJXOApbyIq5kqIDpPZ7r0IoZSyMALc=
X-Received: by 2002:a05:651c:1205:: with SMTP id
 i5mr8918344lja.283.1605015323045; 
 Tue, 10 Nov 2020 05:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
In-Reply-To: <20201106042710.55979-3-john.stultz@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Nov 2020 14:35:12 +0100
Message-ID: <CACRpkdYhfjRBz8GwMyCrOTzjd-Y6-G16xPjH6xhwSHcnaJfuXA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: John Stultz <john.stultz@linaro.org>
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

On Fri, Nov 6, 2020 at 5:27 AM John Stultz <john.stultz@linaro.org> wrote:

> Allow the qcom_scm driver to be loadable as a permenent module.
>
> This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> ensure that drivers that call into the qcom_scm driver are
> also built as modules. While not ideal in some cases its the
> only safe way I can find to avoid build errors without having
> those drivers select QCOM_SCM and have to force it on (as
> QCOM_SCM=n can be valid for those drivers).
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

I applied this patch to the pinctrl tree as well, I suppose
that was the intention. If someone gets upset I can always
pull it out.

Thanks for your perseverance in driving this John.

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
