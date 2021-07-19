Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B904C07E95
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 19:36:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383D360C41
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 19:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383D360C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAF93605B0;
	Mon, 19 Jul 2021 19:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 893z0SIJS3kH; Mon, 19 Jul 2021 19:36:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 13DDC605AA;
	Mon, 19 Jul 2021 19:36:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9B98C001A;
	Mon, 19 Jul 2021 19:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60D52C000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 19:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 346C4403CD
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 19:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ylt8D3jOyDqO for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 19:36:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6886403CA
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 19:36:06 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id u11so22000812oiv.1
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AsVttpaIz6o+7rFOVPCQbe/BzglpTdJrFiNYOm9U9B4=;
 b=xwBMdYLctnwna9IrwiJvv/IFdbPquUVCJaJF02XKLjARg7WlxJB/ZVtGmpR6HAwm0B
 DAlHudRafT5FK7eCPyfAYclwILvV18U9HWuu2hZRtoN9T+Bw77VtgScRYrx1vCdYlljg
 Iwkn0CtuZQHomiyQ0XeFefYfEq8KrIE0MKe0xvF9Tk4uob+ziMZ5iANeS3APKqwZTqBL
 TOTExV4mKvdgaUSAOiUfnI2rc3QQ2HFMHuiK4+BzFBTfRyzhtilJeMf7h/0DDv2p1abI
 MmF7SoQw7rmLOEZyWTtQUX/prQbprT9Gvc3gUPlbBtx+ehl7grqisfervRPvs/PmOmMX
 ijQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AsVttpaIz6o+7rFOVPCQbe/BzglpTdJrFiNYOm9U9B4=;
 b=JkF6FPuic6U+KwlFLDJk3AdMNFrm/SbF3DyCOQuI1/iyDIfzABWTL/euaviPipBDF3
 OpNnS92ISTMv1eV+i+J1kZSogiQg3o9gf9huHhIqG1YZ2kG8AbjvvuKy/M6ON0wAVrY0
 6u1Ic+lvEjByRM9y+Gyfpasn+GlzMrvV7tZhg7DsDdd/dar1LitDjSUeJm8gFvJGdJY0
 HSqG/V8w9/9UtiHvffRUJcjiULqwHhY/zy5ita+wdz1utb/L+6lo9B2ZMksJtwWvJkyq
 bZ0doIFZOa9OAoFWk8GVkmvSaaJR7WzTiGrwaBJCXIHvkoKGkMH1xiY2KO6STJ9R47K3
 qq8A==
X-Gm-Message-State: AOAM531Y3RVKgxV2CXVWkVzUUcI26eGXt97ixVQyr0ncELyJp4jE5TiR
 n84mYOUaIaHK6VlC1VXlgwRFIA==
X-Google-Smtp-Source: ABdhPJyja+h2hxOE+bpleMjs4kTNsVmCuEisdwIwTMDk7g7JkvErSsBCBiNgF7ZV7Ud5r3tIKV98WQ==
X-Received: by 2002:aca:4406:: with SMTP id r6mr13822205oia.50.1626723365906; 
 Mon, 19 Jul 2021 12:36:05 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id c8sm820849oto.17.2021.07.19.12.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jul 2021 12:36:05 -0700 (PDT)
Date: Mon, 19 Jul 2021 14:36:03 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
Message-ID: <YPXUI0VzpxYO56BU@yoga>
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPJkF21ItYlKODyq@yoga>
 <CALAqxLUzTNiA7u=4_y9pkrh=Q_+vpPgFrhf_6F8-U0XPQU9crQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALAqxLUzTNiA7u=4_y9pkrh=Q_+vpPgFrhf_6F8-U0XPQU9crQ@mail.gmail.com>
Cc: Maulik Shah <mkshah@codeaurora.org>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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

On Mon 19 Jul 14:00 CDT 2021, John Stultz wrote:

> On Fri, Jul 16, 2021 at 10:01 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Tue 06 Jul 23:53 CDT 2021, John Stultz wrote:
> > > Allow the qcom_scm driver to be loadable as a permenent module.
> > >
> > > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > > ensure that drivers that call into the qcom_scm driver are
> > > also built as modules. While not ideal in some cases its the
> > > only safe way I can find to avoid build errors without having
> > > those drivers select QCOM_SCM and have to force it on (as
> > > QCOM_SCM=n can be valid for those drivers).
> > >
> > > Reviving this now that Saravana's fw_devlink defaults to on,
> > > which should avoid loading troubles seen before.
> > >
> >
> > Are you (in this last paragraph) saying that all those who have been
> > burnt by fw_devlink during the last months and therefor run with it
> > disabled will have a less fun experience once this is merged?
> >
> 
> I guess potentially. So way back when this was originally submitted,
> some folks had trouble booting if it was set as a module due to it
> loading due to the deferred_probe_timeout expiring.
> My attempts to change the default timeout value to be larger ran into
> trouble, but Saravana's fw_devlink does manage to resolve things
> properly for this case.
> 

Unfortunately I see really weird things coming out of that, e.g. display
on my db845c is waiting for the USB hub on PCIe to load its firmware,
which typically times out after 60 seconds.

I've stared at it quite a bit and I don't understand how they are
related.

> But if folks are having issues w/ fw_devlink, and have it disabled,
> and set QCOM_SCM=m they could still trip over the issue with the
> timeout firing before it is loaded (especially if they are loading
> modules from late mounted storage rather than ramdisk).
> 

I guess we'll have to force QCOM_SCM=y in the defconfig and hope people
don't make it =m.

> > (I'm picking this up, but I don't fancy the idea that some people are
> > turning the boot process into a lottery)
> 
> Me neither, and I definitely think the deferred_probe_timeout logic is
> way too fragile, which is why I'm eager for fw_devlink as it's a much
> less racy approach to handling module loading dependencies.

Right, deferred_probe_timeout is the main issue here. Without it we
might get some weird probe deferral runs, but either some driver is
missing or it settles eventually.

With deferred_probe_timeout it's rather common for me to see things
end up probe out of order (even more now with fw_devlink finding cyclic
dependencies) and deferred_probe_timeout just breaking things.

> So if you
> want to hold on this, while any remaining fw_devlink issues get
> sorted, that's fine.  But I'd also not cast too much ire at
> fw_devlink, as the global probe timeout approach for handling optional
> links isn't great, and we need a better solution.
> 

There's no end to the possible and valid ways you can setup your
defconfig and run into the probe deferral issues, so I see no point in
holding this one back any longer. I just hope that one day it will be
possible to boot the upstream kernel in a reliable fashion.

Thanks,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
