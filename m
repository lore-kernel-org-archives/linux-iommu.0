Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550E8C433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 07:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFC6360FE1;
	Fri,  1 Jul 2022 07:03:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFC6360FE1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=G4+aGmI0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wq9wCKvKVBM; Fri,  1 Jul 2022 07:03:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9899060FD1;
	Fri,  1 Jul 2022 07:03:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9899060FD1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 730E8C0071;
	Fri,  1 Jul 2022 07:03:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D637C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4406C40260
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:03:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4406C40260
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=G4+aGmI0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PtNitTizm5zS for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 07:02:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 650A240182
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 650A240182
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:02:59 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-318889e6a2cso15081657b3.1
 for <iommu@lists.linux-foundation.org>; Fri, 01 Jul 2022 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3Oxpr/H6WS/cbatfKxunj+Rm+HXq43uwJ9TOx0tf4pg=;
 b=G4+aGmI06EueqwK7C5Qo4w/41Yp3wU/CWyAMnimOU3r1x56NK0xwWd5NnQsEtkPJT1
 j1wWR6jutsCmi+xE7hxYUqJNrQrMI+GL07X5ZYgIgqDAqQnMWhF8y5nc40xNPfhYS3jC
 0nJhLPxfL1eyodYvq4oKHJFLeueGwA5XPbFVGoQA05bmNWxXq8PGbVqamZrTZs9J6qBh
 1fRZx/U4bPFmJBSVu1knm/cNESUDsxYs6X7kurTJA14GFNtyIPF26073epdL9z6eSE2L
 X78efI4BN3icU+xkSEEQMO42kPgo3k8M7uVN2JrWdQyoK9p0Z0nOVmWHNbnRgASj9y0m
 xe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Oxpr/H6WS/cbatfKxunj+Rm+HXq43uwJ9TOx0tf4pg=;
 b=CbRSJ97EQNG1GQDRVpW+ogaYIrhJr3yDBPwfB00yVTGFLf6vcHr4uOX+euxfBSgZgG
 ypt/2M/BN3QVJjmG3bBb3CknZNqhgt5q8fhKYAyhUo1082ld4snxYo0bJ9jpcLXLUPv6
 hp3tcIR2wyzZ5j3YlAIhfNtp9ZUfdwJ7noe9A1P5pVNqp297o6aeCWlcvAcdfc51lRoJ
 FxUdyBm2RsGAVuT/4ULy5HfvXCzzE+znlIV4dRHOqmI+podfp615BrPkBMBh0WIbu6oP
 P051z0s6/RaxpA+u2Z7Nmc5ex0HAfBDEqFz+DwinvI2qg2mnrgxuc8+51bKJUVRQiPDg
 3ZPg==
X-Gm-Message-State: AJIora+4pEqAt0e+MQaduTJeOMl2jOhrVYDNlM4kaGzGrLxRw3+XEDP9
 srkQKq3OFQXi90vD48FrrX+HEzqTG0RblWiR7MOIlA==
X-Google-Smtp-Source: AGRyM1sjHYE6b1ihEm8EzVroyoytiPu2X1qfGuWU3WGWHfolVcCLEjpB4ZdcYExvwYNCmCj3ip+B1gZf6PvcXiQN0KE=
X-Received: by 2002:a81:4896:0:b0:317:f767:95f8 with SMTP id
 v144-20020a814896000000b00317f76795f8mr15214195ywa.218.1656658978077; Fri, 01
 Jul 2022 00:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <4799738.LvFx2qVVIh@steina-w>
 <CAGETcx_1qa=gGT4LVkyPpcA1vFM9FzuJE+0DhL_nFyg5cbFjVg@mail.gmail.com>
 <5265491.31r3eYUQgx@steina-w>
In-Reply-To: <5265491.31r3eYUQgx@steina-w>
Date: Fri, 1 Jul 2022 00:02:22 -0700
Message-ID: <CAGETcx-fLAXnG+1S4MHJwg9t7O6jj6Mp+q25bh==C_Z1CLs-mg@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>,
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

On Thu, Jun 30, 2022 at 11:02 PM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Saravana,
>
> Am Freitag, 1. Juli 2022, 02:37:14 CEST schrieb Saravana Kannan:
> > On Thu, Jun 23, 2022 at 5:08 AM Alexander Stein
> >
> > <alexander.stein@ew.tq-group.com> wrote:
> > > Hi,
> > >
> > > Am Dienstag, 21. Juni 2022, 09:28:43 CEST schrieb Tony Lindgren:
> > > > Hi,
> > > >
> > > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > > Now that fw_devlink=on by default and fw_devlink supports
> > > > > "power-domains" property, the execution will never get to the point
> > > > > where driver_deferred_probe_check_state() is called before the
> > > > > supplier
> > > > > has probed successfully or before deferred probe timeout has expired.
> > > > >
> > > > > So, delete the call and replace it with -ENODEV.
> > > >
> > > > Looks like this causes omaps to not boot in Linux next. With this
> > > > simple-pm-bus fails to probe initially as the power-domain is not
> > > > yet available. On platform_probe() genpd_get_from_provider() returns
> > > > -ENOENT.
> > > >
> > > > Seems like other stuff is potentially broken too, any ideas on
> > > > how to fix this?
> > >
> > > I think I'm hit by this as well, although I do not get a lockup.
> > > In my case I'm using
> > > arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts and probing of
> > > 38320000.blk-ctrl fails as the power-domain is not (yet) registed.
> >
> > Ok, took a look.
> >
> > The problem is that there are two drivers for the same device and they
> > both initialize this device.
> >
> >     gpc: gpc@303a0000 {
> >         compatible = "fsl,imx8mq-gpc";
> >     }
> >
> > $ git grep -l "fsl,imx7d-gpc" -- drivers/
> > drivers/irqchip/irq-imx-gpcv2.c
> > drivers/soc/imx/gpcv2.c
> >
> > IMHO, this is a bad/broken design.
> >
> > So what's happening is that fw_devlink will block the probe of
> > 38320000.blk-ctrl until 303a0000.gpc is initialized. And it stops
> > blocking the probe of 38320000.blk-ctrl as soon as the first driver
> > initializes the device. In this case, it's the irqchip driver.
> >
> > I'd recommend combining these drivers into one. Something like the
> > patch I'm attaching (sorry for the attachment, copy-paste is mangling
> > the tabs). Can you give it a shot please?
>
> I tried this patch and it delayed the driver initialization (those of UART as
> well BTW). Unfortunately the driver fails the same way:

Thanks for testing the patch!

> > [    1.125253] imx8m-blk-ctrl 38320000.blk-ctrl: error -ENODEV: failed to
> attach power domain "bus"
>
> More than that it even introduced some more errors:
> > [    0.008160] irq: no irq domain found for gpc@303a0000 !

So the idea behind my change was that as long as the irqchip isn't the
root of the irqdomain (might be using the terms incorrectly) like the
gic, you can make it a platform driver. And I was trying to hack up a
patch that's the equivalent of platform_irqchip_probe() (which just
ends up eventually calling the callback you use in IRQCHIP_DECLARE().
I probably made some mistake in the quick hack that I'm sure if
fixable.

> > [    0.013251] Failed to map interrupt for
> > /soc@0/bus@30400000/timer@306a0000

However, this timer driver also uses TIMER_OF_DECLARE() which can't
handle failure to get the IRQ (because it's can't -EPROBE_DEFER). So,
this means, the timer driver inturn needs to be converted to a
platform driver if it's supposed to work with the IRQCHIP_DECLARE()
being converted to a platform driver.

But that's a can of worms not worth opening. But then I remembered
this simpler workaround will work and it is pretty much a variant of
the workaround that's already in the gpc's irqchip driver to allow two
drivers to probe the same device (people really should stop doing
that).

Can you drop my previous hack patch and try this instead please? I'm
99% sure this will work.

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index b9c22f764b4d..8a0e82067924 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -283,6 +283,7 @@ static int __init imx_gpcv2_irqchip_init(struct
device_node *node,
         * later the GPC power domain driver will not be skipped.
         */
        of_node_clear_flag(node, OF_POPULATED);
+       fwnode_dev_initialized(domain->fwnode, false);
        return 0;
 }

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
