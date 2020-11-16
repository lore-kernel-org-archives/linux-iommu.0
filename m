Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E80C4742C
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 19:57:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6626E20853
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 19:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCYbRXt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6626E20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E1D7A867AC;
	Mon, 16 Nov 2020 19:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E5tKSY0KdryT; Mon, 16 Nov 2020 19:57:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 511AA867AE;
	Mon, 16 Nov 2020 19:57:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3873DC0891;
	Mon, 16 Nov 2020 19:57:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19711C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 19:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F139520762
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 19:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P+uhckQLrN3o for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 19:57:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 91D8820335
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 19:57:04 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id i18so17237314ots.0
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i/jF2vypozoIAWRoRUvExzTm1upLK9kXuTA4kYYBoQM=;
 b=uCYbRXt0REy+9MdFUsPc354Sh1shvPq/44EoBKW8dlVEhWu2PsBHUOlTLgW0pbkcA/
 XY6DrDjfxSubwTt3hnLvxkzczKeKX/tDDl1RvU41VhfRU5uk9JA8Xvie/HPDVmYcwthh
 zADqTYV7qIU2NfqcbnWwMTa/irq1n53tVZD+GFYxd4czNRDmofzXQSLSAVksjfayLJxC
 F2NB+5yuV1S5xfjiBD5YHoM/2YcjZO4mSAdp1mwPbqjBYmSb2Zo8kPiutdp8anKgzGFP
 cZJCQ/ubY2T8mN/fKJj/RJ5pC9O42JAhZOUWzZgiD4ewlW5WLm3zlpaFeqkk9vNy3TIa
 NLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i/jF2vypozoIAWRoRUvExzTm1upLK9kXuTA4kYYBoQM=;
 b=DWIqqBdXXJ2brIKvLIHno/CW555tdYhV0V39lMf8XITi0aoJZu6v2iLhAdph53IHZS
 g86vvYe4s5WAIhHzN8SSn3US7blkwZINDnTVy1u5rX5GArjLRojOjM0aRISeRIOdy12+
 ob/ok6RYVINhSHPkop8F8LtVcmXJ4xVLHaPnbXu/Gc0uHOU0rPdNIqrF2LgUBahOtBpj
 SVJGgeT7k0WKkctxDumSzszQrHmoeMFbVaK94TUzDEFAmZSH7OzJ5VFZFcRGEEDiNzaH
 mnUFsZ9qolqmbNiiRm2DzRkSrqMWYLmyPsZpu0qi1QAnTw1W0PSylcTNhYgRCSsGMVFy
 GTSg==
X-Gm-Message-State: AOAM532kailPLB6MWZr/Q8RUQEUW05JOV01+1IuC80Y+D1bS2W8OFm4u
 weA06gETnZgjoz2TchPTot/IEtwRD7pbXQYQgRNqjystPZ8=
X-Google-Smtp-Source: ABdhPJxq2rLWqbms4p0dfqF261lSEUqJezo2VNYvxSZDGEUqeNo2rc3yzBUfI/Hco8mHWx6SRZ/m0Uc+hY7wn2qh3jc=
X-Received: by 2002:a4a:6802:: with SMTP id p2mr716194ooc.9.1605556131545;
 Mon, 16 Nov 2020 11:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
 <20201116155936.GE2224373@ulmo>
 <20201116163603.GA30507@willie-the-truck>
In-Reply-To: <20201116163603.GA30507@willie-the-truck>
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 16 Nov 2020 11:48:39 -0800
Message-ID: <CALAqxLVDm923WRSB+DVxFacmEtmEPS7Qeq+rW_jbCDMNMWw9PQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: Will Deacon <will@kernel.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jon Hunter <jonathanh@nvidia.com>,
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

On Mon, Nov 16, 2020 at 8:36 AM Will Deacon <will@kernel.org> wrote:
> On Mon, Nov 16, 2020 at 04:59:36PM +0100, Thierry Reding wrote:
> > On Fri, Nov 06, 2020 at 04:27:10AM +0000, John Stultz wrote:
> > Unfortunately, the ARM SMMU module will eventually end up being loaded
> > once the root filesystem has been mounted (for example via SDHCI or
> > Ethernet, both with using just plain, non-IOMMU-backed DMA API) and then
> > initialize, configuring as "fault by default", which then results from a
> > slew of SMMU faults from all the devices that have previously configured
> > themselves without IOMMU support.
>
> I wonder if fw_devlink=on would help here?
>
> But either way, I'd be more inclined to revert this change if it's causing
> problems for !QCOM devices.
>
> Linus -- please can you drop this one (patch 3/3) for now, given that it's
> causing problems?

Agreed. Apologies again for the trouble.

I do feel like the probe timeout to handle optional links is causing a
lot of the trouble here. I expect fw_devlink would solve this, but it
may be awhile before it can be always enabled.  I may see about
pushing the default probe timeout value to be a little further out
than init (I backed away from my last attempt as I didn't want to
cause long (30 second) delays for cases like NFS root, but maybe 2-5
seconds would be enough to make things work better for everyone).

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
