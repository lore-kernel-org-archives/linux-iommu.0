Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629C7C43334
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 18:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECBC68333F;
	Wed,  8 Jun 2022 18:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OjZb5Fdb0-8Q; Wed,  8 Jun 2022 18:53:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C662B83264;
	Wed,  8 Jun 2022 18:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78979C0039;
	Wed,  8 Jun 2022 18:53:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44089C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 18:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BD09408E8
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 18:53:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UlLJaY5RjrFw for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 18:53:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 711E6408CC
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 18:53:22 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 a8-20020a05683012c800b0060c027c8afdso5502080otq.10
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jun 2022 11:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cCx4uVeqQeSUmVm0iqQB2vFXf1PboEGJhslplIjAGsc=;
 b=WaOr7XmghJiNu9gTG3SIOlfhSG7LbKKTbMi+1TqlnwPqWHSI0nEXrUXLOiDH0F4EDz
 wa8JrR2zO9/jf51+3fX3SWNicAO5FP/yKsqES+QcDPHVz3Fm7T3U7Th1jqAaw1cC5lOJ
 oLqxA8wjkQckHRLFr6Q2JJ0AbOAAkLSAMgn9nMNRPGwy+raUQhT3nLP9TXlxX3Zb6n5m
 DCFh+yP2etHMA/ZlPu4Ed3pRvCt0j5IQtiGOfkoFkCXdZxH6/EExInr1chbvjh3E9ccm
 kws72qRMZmoBadnVeCDHfZ3BeTKnB5ovFdZp/7SldqZ9I0RkK6FCtdEa6UUEv9R5+Ooc
 9ZVQ==
X-Gm-Message-State: AOAM532+QtklMqrvO9jPTEuZkEiNou64kP4RLIZ3uJKF2UUxv9wfqky1
 aFgtTsImeicGT8ryLzxHSINkmGMo1j/nGg==
X-Google-Smtp-Source: ABdhPJwWykpqMoZYLNHzObIPdWdC5nJbWTQu0Km6/pPOEKk7YFwNervZFCMkntRx/1NW+fneNoOF0w==
X-Received: by 2002:a9d:20ea:0:b0:60b:c168:548b with SMTP id
 x97-20020a9d20ea000000b0060bc168548bmr13617099ota.37.1654714399633; 
 Wed, 08 Jun 2022 11:53:19 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com.
 [209.85.210.50]) by smtp.gmail.com with ESMTPSA id
 g24-20020a544f98000000b00325cda1ffb4sm11555688oiy.51.2022.06.08.11.53.19
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 11:53:19 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id
 j8-20020a9d7d88000000b0060c1484c93eso2363480otn.13
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jun 2022 11:53:19 -0700 (PDT)
X-Received: by 2002:a05:6902:124c:b0:663:9db4:671c with SMTP id
 t12-20020a056902124c00b006639db4671cmr16391806ybu.543.1654714068446; Wed, 08
 Jun 2022 11:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <CAMuHMdXkX-SXtBuTRGJOUnpw9goSP6RFr_PTt_3w_yWgBpWsqg@mail.gmail.com>
 <CAGETcx9f0UBhpp6dM+KJwtYpLx19wwsq6_ygi3En7FrXobOSpA@mail.gmail.com>
 <CAGETcx8VM+xOCe7HEx9FUU-1B9nrX8Q=tE=NjTyb9uX2_8RXLQ@mail.gmail.com>
 <CAMuHMdXzu8Vp=a7fyjOB=xt04aee=vWXV=TcRZeeKUGYFFZ1CA@mail.gmail.com>
 <CAGETcx_Nqo4ju7cWwO3dP3YM2wpCb0jx23OHOReexOjpT5pATA@mail.gmail.com>
In-Reply-To: <CAGETcx_Nqo4ju7cWwO3dP3YM2wpCb0jx23OHOReexOjpT5pATA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jun 2022 20:47:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQCwMQj_ZiOBAzusdCxd8w6NbTqD_7nzykhVs+UWx8Gw@mail.gmail.com>
Message-ID: <CAMuHMdXQCwMQj_ZiOBAzusdCxd8w6NbTqD_7nzykhVs+UWx8Gw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] deferred_probe_timeout logic clean up
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>, Len Brown <len.brown@intel.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Saravana,

On Wed, Jun 8, 2022 at 8:13 PM Saravana Kannan <saravanak@google.com> wrote:
> On Wed, Jun 8, 2022 at 3:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Jun 8, 2022 at 6:17 AM Saravana Kannan <saravanak@google.com> wrote:
> > > On Tue, Jun 7, 2022 at 5:55 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Tue, Jun 7, 2022 at 11:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Wed, Jun 1, 2022 at 12:46 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > This series is based on linux-next + these 2 small patches applies on top:
> > > > > > https://lore.kernel.org/lkml/20220526034609.480766-1-saravanak@google.com/
> > > > > >
> > > > > > A lot of the deferred_probe_timeout logic is redundant with
> > > > > > fw_devlink=on.  Also, enabling deferred_probe_timeout by default breaks
> > > > > > a few cases.
> > > > > >
> > > > > > This series tries to delete the redundant logic, simplify the frameworks
> > > > > > that use driver_deferred_probe_check_state(), enable
> > > > > > deferred_probe_timeout=10 by default, and fixes the nfsroot failure
> > > > > > case.
> > > > > >
> > > > > > The overall idea of this series is to replace the global behavior of
> > > > > > driver_deferred_probe_check_state() where all devices give up waiting on
> > > > > > supplier at the same time with a more granular behavior:
> > > > > >
> > > > > > 1. Devices with all their suppliers successfully probed by late_initcall
> > > > > >    probe as usual and avoid unnecessary deferred probe attempts.
> > > > > >
> > > > > > 2. At or after late_initcall, in cases where boot would break because of
> > > > > >    fw_devlink=on being strict about the ordering, we
> > > > > >
> > > > > >    a. Temporarily relax the enforcement to probe any unprobed devices
> > > > > >       that can probe successfully in the current state of the system.
> > > > > >       For example, when we boot with a NFS rootfs and no network device
> > > > > >       has probed.
> > > > > >    b. Go back to enforcing the ordering for any devices that haven't
> > > > > >       probed.
> > > > > >
> > > > > > 3. After deferred probe timeout expires, we permanently give up waiting
> > > > > >    on supplier devices without drivers. At this point, whatever devices
> > > > > >    can probe without some of their optional suppliers end up probing.
> > > > > >
> > > > > > In the case where module support is disabled, it's fairly
> > > > > > straightforward and all device probes are completed before the initcalls
> > > > > > are done.
> > > > > >
> > > > > > Patches 1 to 3 are fairly straightforward and can probably be applied
> > > > > > right away.
> > > > > >
> > > > > > Patches 4 to 6 are for fixing the NFS rootfs issue and setting the
> > > > > > default deferred_probe_timeout back to 10 seconds when modules are
> > > > > > enabled.
> > > > > >
> > > > > > Patches 7 to 9 are further clean up of the deferred_probe_timeout logic
> > > > > > so that no framework has to know/care about deferred_probe_timeout.
> > > > > >
> > > > > > Yoshihiro/Geert,
> > > > > >
> > > > > > If you can test this patch series and confirm that the NFS root case
> > > > > > works, I'd really appreciate that.
> > > > >
> > > > > Thanks, I gave this a try on various boards I have access to.
> > > > > The results were quite positive. E.g. the compile error I saw on v1
> > > > > (implicit declation of fw_devlink_unblock_may_probe(), which is no longer
> > > > >  used in v2) is gone.
> > > >
> > > > Thanks a lot for testing these.
> > > >
> > > > > However, I'm seeing a weird error when userspace (Debian9 nfsroot) is
> > > > > starting:

> > Setting fw_devlink_strict to true vs. false seems to influence which of
> > two different failures will happen:
> >   - rcar-csi2: probe of feaa0000.csi2 failed with error -22
> >   - rcar-vin: probe of e6ef5000.video failed with error -22
> > The former causes the NULL pointer dereference later.
> > The latter existed before, but I hadn't noticed it, and bisection
> > led to the real culprit (commit 3e52419ec04f9769 ("media: rcar-{csi2,vin}:
> > Move to full Virtual Channel routing per CSI-2 IP").
>
> If you revert that patch, does this series work fine? If yes, are you
> happy with giving this a Tested-by?

Sure, sorry for forgetting that ;-)

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
