Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47500C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 19:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDB734191F;
	Wed, 22 Jun 2022 19:10:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDB734191F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=q0iBpeFz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DMY5G5DGYo_j; Wed, 22 Jun 2022 19:10:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20A30418F1;
	Wed, 22 Jun 2022 19:10:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20A30418F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 001A6C0032;
	Wed, 22 Jun 2022 19:10:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 983D1C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 19:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CC1D8419F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 19:10:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CC1D8419F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=q0iBpeFz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LX_W7j-ANCUa for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 19:10:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FD0884188
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FD0884188
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 19:10:08 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-3185f5623edso12343497b3.1
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m2EKhR0TRoyufPiu9Flo4efSG9iVQ7Sr7NIfxXnG//E=;
 b=q0iBpeFzXmVjuV9RJ2U0tO6ECKKIgXqLxhTrd/XuqGhMkas+He99laUPoyLdnfoNFL
 +PttCvM62NPrGDH6bN6Tam5nPc4Jt6Lhqq9iRLcdZDXmODHt/VANxFARtdqBpIOWNqbl
 AatF7ctiFGf72C+0OC82zliefxVYa8dtkAaYmnq0JCPtTgfz1cWUVQ87m5452KZkW/cW
 SPNNeBKYphGmdKaYImVx82HxgMYh2fon8Z8I1JzFAAU0CLZraMDpT8R9qd8YGH1YLF5l
 z+/MLbNzdLViy90RdBW0wFmvw6BnGUFs9HZsF90abo3WhbF4Ja8pDA24KBOpYxV847T2
 I7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m2EKhR0TRoyufPiu9Flo4efSG9iVQ7Sr7NIfxXnG//E=;
 b=fDoPHSIhfV6HWxj3/RZCuOmRint3r+mWSXpkH3MzPMqYOxY/UbUiUMsixLQdup7vMR
 LBL9OHm48kKDrT+7QzMxk4yte01usSzyEgvDHQthFNxz5fd8OS7izBZPZpiWu/T5rOqh
 JARCNv3cYCf+makaEWi+Ka8WVqOje01gS4zYftftab0bq/p+oap5fP9axEvW9h/Fh2yK
 8h4CNpJu3zPgcBVQxifWLXYHe/fmk/nrWoysGOg0+8H40Ws4JJpbC0M3likpJVgVPyXn
 OI/M2qroBIobyfg8Ss5Kvw+FCeN9Mgdrr8Z3x2Rj+cegy/LxbNDk20Wcj6yjq7xTMDby
 GT3w==
X-Gm-Message-State: AJIora87oFnrgkLej1x78GR+u7QcGBURw8XvgZoFYPtmh6LouTFdTaTE
 meZCpCMHDk4lRdEKD4t/5Ciuh9jYwhZ0/BS8TpwZ/Q==
X-Google-Smtp-Source: AGRyM1solygMwSWCkiPF1NFwzx5BeilY1scDMXVDLNy5qaonwBsI4xn5J0zOBjmp0RWdt2LaZxnizqSGP3n3TRaTEKc=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr6074480ywe.126.1655925007151; Wed, 22
 Jun 2022 12:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
 <YrKhkmj3jCQA39X/@atomide.com>
In-Reply-To: <YrKhkmj3jCQA39X/@atomide.com>
Date: Wed, 22 Jun 2022 12:09:31 -0700
Message-ID: <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kernel-team@android.com,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
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

On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Saravana Kannan <saravanak@google.com> [220621 19:29]:
> > On Tue, Jun 21, 2022 at 12:28 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > Hi,
> > >
> > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > Now that fw_devlink=on by default and fw_devlink supports
> > > > "power-domains" property, the execution will never get to the point
> > > > where driver_deferred_probe_check_state() is called before the supplier
> > > > has probed successfully or before deferred probe timeout has expired.
> > > >
> > > > So, delete the call and replace it with -ENODEV.
> > >
> > > Looks like this causes omaps to not boot in Linux next.
> >
> > Can you please point me to an example DTS I could use for debugging
> > this? I'm assuming you are leaving fw_devlink=on and not turning it
> > off or putting it in permissive mode.
>
> Sure, this seems to happen at least with simple-pm-bus as the top
> level interconnect with a configured power-domains property:
>
> $ git grep -A10 "ocp {" arch/arm/boot/dts/*.dtsi | grep -B3 -A4 simple-pm-bus

Thanks for the example. I generally start looking from dts (not dtsi)
files in case there are some DT property override/additions after the
dtsi files are included in the dts file. But I'll assume for now
that's not the case. If there's a specific dts file for a board I can
look from that'd be helpful to rule out those kinds of issues.

For now, I looked at arch/arm/boot/dts/omap4.dtsi.

>
> This issue is no directly related fw_devlink. It is a side effect of
> removing driver_deferred_probe_check_state(). We no longer return
> -EPROBE_DEFER at the end of driver_deferred_probe_check_state().

Yes, I understand the issue. But driver_deferred_probe_check_state()
was deleted because fw_devlink=on should have short circuited the
probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
probe function and hitting this -ENOENT failure. That's why I was
asking the other questions.

> > > On platform_probe() genpd_get_from_provider() returns
> > > -ENOENT.
> >
> > This error is with the series I assume?
>
> On the first probe genpd_get_from_provider() will return -ENOENT in
> both cases. The list is empty on the first probe and there are no
> genpd providers at this point.
>
> Earlier with driver_deferred_probe_check_state(), the initial -ENOENT
> ends up getting changed to -EPROBE_DEFER at the end of
> driver_deferred_probe_check_state(), we are now missing that.

Right, I was aware -ENOENT would be returned if we got this far. But
the point of this series is that you shouldn't have gotten that far
before your pm domain device is ready. Hence my questions from the
earlier reply.

Can I get answers to rest of my questions in the first reply please?
That should help us figure out why fw_devlink let us get this far.
Summarize them here to make it easy:
* Are you running with fw_devlink=on?
* Is the"ti,omap4-prm-inst"/"ti,omap-prm-inst" built-in in this case?
* If it's not built-in, can you please try deferred_probe_timeout=0
and deferred_probe_timeout=30 and see if either one of them help?
* Can I get the output of "ls -d supplier:*" and "cat
supplier:*/status" output from the sysfs dir for the ocp device
without this series where it boots properly.

Thanks,
Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
