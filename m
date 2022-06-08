Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6115CCA47B
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 21:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6817160670;
	Wed,  8 Jun 2022 21:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HsHsSE2C3gL3; Wed,  8 Jun 2022 21:08:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E7E760087;
	Wed,  8 Jun 2022 21:08:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D38C0039;
	Wed,  8 Jun 2022 21:08:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6793CC002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 21:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4840F408E0
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 21:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 711pPOBVVyEQ for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 21:08:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 419A4400A6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 21:08:22 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-30fdbe7467cso187104287b3.1
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jun 2022 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b5ReOqAs2o3gzeqG3OL7V4il5yL5akHyIyGPxcacfBA=;
 b=Ba4mwhCNe1k/SVYGgiax1RHLVYaE16PYm+5fiQboXFgD/ag+N5cvz705MN4rVjpIPI
 20mqv9SEpUPx3PtChBxCddPxC3gpwz6N5PF+G0ZElhJAMs7eaWr/Z+J8nMSxF5pOKofY
 CLFQyzIeUPghYqThB66mUFHJcWTC93ASqEVRt3LVLl9QPXBD+PYs/yU2uLqcxreGwdik
 4HASNcsIvuV/mOpjIf/knlk/2pymeg4ut2QXPF/hi4finuKXsMk29G9quSLgCq5XjL9S
 aWkJqkdgxfW8i8wPGvE0N8YcrI2ZFizB9Lbxi1u9CnGJusfu9M2jfO6bciIlSU/xqWwh
 708Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b5ReOqAs2o3gzeqG3OL7V4il5yL5akHyIyGPxcacfBA=;
 b=BznhHjnAP0VQRccADa1ln/wreeE4t50EhqjGd2tfBJVpEWFIYYsyzaa3b2CoS1yPsv
 R+iQ7ocuWmDrOTotfMCbjsJWK0SfhmOR6pfE4sD+4eW6MneMd92/pNC0AJfslJxU9v3R
 0ln8KzdgiQLOLRkxmmX72kU8B+6SbtN0EKLJx1r4mNyyYIKuuBtopOFZL7F8iqi5hO1G
 U845wXgI9Lq3s/1NnLJAuSijRh67Vv5llrWj1aagyiXpbiLYw68NUNN6DZwSE4eo539y
 yC0WnAZLdMJ9mEx1ta99UaOJiok9xa+qZvzRWlfFoRxmlaY+LQLB2hqWLX/CHA83gRwl
 isDg==
X-Gm-Message-State: AOAM531786+TvTZmKMlnE2Z/4746tY81pHfsOpfsPf68xbYJ1GVAl9ZQ
 eH1qHgTErgJLVaRsEhpT1+jzG2ibZSWNx/GgmcNj8A==
X-Google-Smtp-Source: ABdhPJwApqB8Aa/s/hWKyN1cGMg0w6J6U6ZpPLsgPu6Z8rVbvyvZo/4KRS+qCvxDCZ36rJaIIDOHULExfT8EFh33Nno=
X-Received: by 2002:a0d:c984:0:b0:30c:c95c:21d0 with SMTP id
 l126-20020a0dc984000000b0030cc95c21d0mr41306613ywd.218.1654722500963; Wed, 08
 Jun 2022 14:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <CAMuHMdXkX-SXtBuTRGJOUnpw9goSP6RFr_PTt_3w_yWgBpWsqg@mail.gmail.com>
 <CAGETcx9f0UBhpp6dM+KJwtYpLx19wwsq6_ygi3En7FrXobOSpA@mail.gmail.com>
 <CAGETcx8VM+xOCe7HEx9FUU-1B9nrX8Q=tE=NjTyb9uX2_8RXLQ@mail.gmail.com>
 <CAMuHMdXzu8Vp=a7fyjOB=xt04aee=vWXV=TcRZeeKUGYFFZ1CA@mail.gmail.com>
 <CAGETcx_Nqo4ju7cWwO3dP3YM2wpCb0jx23OHOReexOjpT5pATA@mail.gmail.com>
 <CAMuHMdXQCwMQj_ZiOBAzusdCxd8w6NbTqD_7nzykhVs+UWx8Gw@mail.gmail.com>
In-Reply-To: <CAMuHMdXQCwMQj_ZiOBAzusdCxd8w6NbTqD_7nzykhVs+UWx8Gw@mail.gmail.com>
Date: Wed, 8 Jun 2022 14:07:44 -0700
Message-ID: <CAGETcx8UO=4mk31tU4QaWU3RaNM_myA9woe0idBp6p7+X5AEgg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] deferred_probe_timeout logic clean up
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>, Len Brown <len.brown@intel.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jun 8, 2022 at 11:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Wed, Jun 8, 2022 at 8:13 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Wed, Jun 8, 2022 at 3:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Jun 8, 2022 at 6:17 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Tue, Jun 7, 2022 at 5:55 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > On Tue, Jun 7, 2022 at 11:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Wed, Jun 1, 2022 at 12:46 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > > This series is based on linux-next + these 2 small patches applies on top:
> > > > > > > https://lore.kernel.org/lkml/20220526034609.480766-1-saravanak@google.com/
> > > > > > >
> > > > > > > A lot of the deferred_probe_timeout logic is redundant with
> > > > > > > fw_devlink=on.  Also, enabling deferred_probe_timeout by default breaks
> > > > > > > a few cases.
> > > > > > >
> > > > > > > This series tries to delete the redundant logic, simplify the frameworks
> > > > > > > that use driver_deferred_probe_check_state(), enable
> > > > > > > deferred_probe_timeout=10 by default, and fixes the nfsroot failure
> > > > > > > case.
> > > > > > >
> > > > > > > The overall idea of this series is to replace the global behavior of
> > > > > > > driver_deferred_probe_check_state() where all devices give up waiting on
> > > > > > > supplier at the same time with a more granular behavior:
> > > > > > >
> > > > > > > 1. Devices with all their suppliers successfully probed by late_initcall
> > > > > > >    probe as usual and avoid unnecessary deferred probe attempts.
> > > > > > >
> > > > > > > 2. At or after late_initcall, in cases where boot would break because of
> > > > > > >    fw_devlink=on being strict about the ordering, we
> > > > > > >
> > > > > > >    a. Temporarily relax the enforcement to probe any unprobed devices
> > > > > > >       that can probe successfully in the current state of the system.
> > > > > > >       For example, when we boot with a NFS rootfs and no network device
> > > > > > >       has probed.
> > > > > > >    b. Go back to enforcing the ordering for any devices that haven't
> > > > > > >       probed.
> > > > > > >
> > > > > > > 3. After deferred probe timeout expires, we permanently give up waiting
> > > > > > >    on supplier devices without drivers. At this point, whatever devices
> > > > > > >    can probe without some of their optional suppliers end up probing.
> > > > > > >
> > > > > > > In the case where module support is disabled, it's fairly
> > > > > > > straightforward and all device probes are completed before the initcalls
> > > > > > > are done.
> > > > > > >
> > > > > > > Patches 1 to 3 are fairly straightforward and can probably be applied
> > > > > > > right away.
> > > > > > >
> > > > > > > Patches 4 to 6 are for fixing the NFS rootfs issue and setting the
> > > > > > > default deferred_probe_timeout back to 10 seconds when modules are
> > > > > > > enabled.
> > > > > > >
> > > > > > > Patches 7 to 9 are further clean up of the deferred_probe_timeout logic
> > > > > > > so that no framework has to know/care about deferred_probe_timeout.
> > > > > > >
> > > > > > > Yoshihiro/Geert,
> > > > > > >
> > > > > > > If you can test this patch series and confirm that the NFS root case
> > > > > > > works, I'd really appreciate that.
> > > > > >
> > > > > > Thanks, I gave this a try on various boards I have access to.
> > > > > > The results were quite positive. E.g. the compile error I saw on v1
> > > > > > (implicit declation of fw_devlink_unblock_may_probe(), which is no longer
> > > > > >  used in v2) is gone.
> > > > >
> > > > > Thanks a lot for testing these.
> > > > >
> > > > > > However, I'm seeing a weird error when userspace (Debian9 nfsroot) is
> > > > > > starting:
>
> > > Setting fw_devlink_strict to true vs. false seems to influence which of
> > > two different failures will happen:
> > >   - rcar-csi2: probe of feaa0000.csi2 failed with error -22
> > >   - rcar-vin: probe of e6ef5000.video failed with error -22
> > > The former causes the NULL pointer dereference later.
> > > The latter existed before, but I hadn't noticed it, and bisection
> > > led to the real culprit (commit 3e52419ec04f9769 ("media: rcar-{csi2,vin}:
> > > Move to full Virtual Channel routing per CSI-2 IP").
> >
> > If you revert that patch, does this series work fine? If yes, are you
> > happy with giving this a Tested-by?
>
> Sure, sorry for forgetting that ;-)
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

+few folks who I forgot to add.

Geert,

Thanks for the extensive testing!

Linus W, Ulf, Kevin, Will, Rob, Vladimir,

Can I get your reviews for the deletion of
driver_deferred_probe_check_state() please? We can finally remove it
and have frameworks not needing to know about it.

Greg, Rafael,

Can you review the wait_for_init_devices_probe() patch and the other
trivial driver core changes please?

David/Jakub,

Do the IP4 autoconfig changes look reasonable to you?

Thanks,
Saravana


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
