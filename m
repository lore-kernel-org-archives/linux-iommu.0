Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A695FC43334
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 07:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34FA760B2A;
	Mon,  4 Jul 2022 07:08:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34FA760B2A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.a=rsa-sha256 header.s=key1 header.b=fI6PIOcC;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.a=rsa-sha256 header.s=key1 header.b=LDsL/qkg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CDwllqcGMYuF; Mon,  4 Jul 2022 07:08:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1FC160B0E;
	Mon,  4 Jul 2022 07:07:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1FC160B0E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0B74C0032;
	Mon,  4 Jul 2022 07:07:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19792C002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 07:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E13F860B2A
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 07:07:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E13F860B2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hhx0vxaJRzKr for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 07:07:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B03FE60B0E
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B03FE60B0E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 07:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1656918475; x=1688454475;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AgnZ/0GTsI5N0Vyb3VmA0aulIyEF8kyx7iX2ZYUNwqY=;
 b=fI6PIOcCNHbueT+UWd4e8oeNh64huXABoRcBiayGlgaAHgxauL7Jou8c
 SeEuYKRhvKoqJUsitl8F7gVGEN/Txos9m/as6NABcR8Zoi6YtUPZRh71m
 cexVjuZU+cg9FiKuEumI0D4jOV8yULYaf1A8HHtQuwIyEoWa0zK4JJEyn
 y4zvUO5L7Zvk0TKXnp9bcxpJAfAcnTRL0AB+p00eBX9BFjGJC3tlrQAli
 ecj1y7sZtYlK4De5ODGRrZjJd1s5RbDvrenBbyVcIevFVdMaeMBvAIdCx
 WeerA93nTOf+4rByiy0Enhf9hmO5OnDZC9bC2MqW8ddV8LBnJuekilEZw w==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650924000"; d="scan'208";a="24825060"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
 by mx1-pgp.tq-group.com with ESMTP; 04 Jul 2022 09:07:52 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
 by tq-pgp-pr1.tq-net.de (PGP Universal service);
 Mon, 04 Jul 2022 09:07:52 +0200
X-PGP-Universal: processed;
 by tq-pgp-pr1.tq-net.de on Mon, 04 Jul 2022 09:07:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1656918472; x=1688454472;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AgnZ/0GTsI5N0Vyb3VmA0aulIyEF8kyx7iX2ZYUNwqY=;
 b=LDsL/qkgTLzLCiPw0J1xSWUct9sHyZrn+x98rgSroq34z+NFujNwgraa
 cq1AbZNacqmgfIS3WcoWHUGz0pf3QZvd+UR5qyDOfUODNyR9g+UdqTJSz
 H7qUPSd+RW8A1BUbFQNrAYR9nfOdFhQuMqrkmAjDEE9UH8tHhIsG3fJ6Y
 FVPSBOHKjmmGquzgpSVNx0vt/WECg3USZVHgWZ3p34RIYbLqrfwqNFGeT
 ekkBex+cCC0951V4IKOqgDWDqqMCgPhCvxXuMQJzxBbU/1ODpLglwlkKv
 5oC5SqlB3Ue39Dgh9nt2YTZw3swiPA6vJei+ZVfZT964Seidcqdvez+rj A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650924000"; d="scan'208";a="24825059"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 04 Jul 2022 09:07:51 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6A945280071;
 Mon,  4 Jul 2022 09:07:51 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
Date: Mon, 04 Jul 2022 09:07:48 +0200
Message-ID: <5717577.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAGETcx-fLAXnG+1S4MHJwg9t7O6jj6Mp+q25bh==C_Z1CLs-mg@mail.gmail.com>
References: <20220601070707.3946847-1-saravanak@google.com>
 <5265491.31r3eYUQgx@steina-w>
 <CAGETcx-fLAXnG+1S4MHJwg9t7O6jj6Mp+q25bh==C_Z1CLs-mg@mail.gmail.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Am Freitag, 1. Juli 2022, 09:02:22 CEST schrieb Saravana Kannan:
> On Thu, Jun 30, 2022 at 11:02 PM Alexander Stein
> 
> <alexander.stein@ew.tq-group.com> wrote:
> > Hi Saravana,
> > 
> > Am Freitag, 1. Juli 2022, 02:37:14 CEST schrieb Saravana Kannan:
> > > On Thu, Jun 23, 2022 at 5:08 AM Alexander Stein
> > > 
> > > <alexander.stein@ew.tq-group.com> wrote:
> > > > Hi,
> > > > 
> > > > Am Dienstag, 21. Juni 2022, 09:28:43 CEST schrieb Tony Lindgren:
> > > > > Hi,
> > > > > 
> > > > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > > > Now that fw_devlink=on by default and fw_devlink supports
> > > > > > "power-domains" property, the execution will never get to the
> > > > > > point
> > > > > > where driver_deferred_probe_check_state() is called before the
> > > > > > supplier
> > > > > > has probed successfully or before deferred probe timeout has
> > > > > > expired.
> > > > > > 
> > > > > > So, delete the call and replace it with -ENODEV.
> > > > > 
> > > > > Looks like this causes omaps to not boot in Linux next. With this
> > > > > simple-pm-bus fails to probe initially as the power-domain is not
> > > > > yet available. On platform_probe() genpd_get_from_provider() returns
> > > > > -ENOENT.
> > > > > 
> > > > > Seems like other stuff is potentially broken too, any ideas on
> > > > > how to fix this?
> > > > 
> > > > I think I'm hit by this as well, although I do not get a lockup.
> > > > In my case I'm using
> > > > arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts and probing of
> > > > 38320000.blk-ctrl fails as the power-domain is not (yet) registed.
> > > 
> > > Ok, took a look.
> > > 
> > > The problem is that there are two drivers for the same device and they
> > > both initialize this device.
> > > 
> > >     gpc: gpc@303a0000 {
> > >     
> > >         compatible = "fsl,imx8mq-gpc";
> > >     
> > >     }
> > > 
> > > $ git grep -l "fsl,imx7d-gpc" -- drivers/
> > > drivers/irqchip/irq-imx-gpcv2.c
> > > drivers/soc/imx/gpcv2.c
> > > 
> > > IMHO, this is a bad/broken design.
> > > 
> > > So what's happening is that fw_devlink will block the probe of
> > > 38320000.blk-ctrl until 303a0000.gpc is initialized. And it stops
> > > blocking the probe of 38320000.blk-ctrl as soon as the first driver
> > > initializes the device. In this case, it's the irqchip driver.
> > > 
> > > I'd recommend combining these drivers into one. Something like the
> > > patch I'm attaching (sorry for the attachment, copy-paste is mangling
> > > the tabs). Can you give it a shot please?
> > 
> > I tried this patch and it delayed the driver initialization (those of UART
> > as
> > well BTW). Unfortunately the driver fails the same way:
> Thanks for testing the patch!
> 
> > > [    1.125253] imx8m-blk-ctrl 38320000.blk-ctrl: error -ENODEV: failed
> > > to
> > 
> > attach power domain "bus"
> > 
> > More than that it even introduced some more errors:
> > > [    0.008160] irq: no irq domain found for gpc@303a0000 !
> 
> So the idea behind my change was that as long as the irqchip isn't the
> root of the irqdomain (might be using the terms incorrectly) like the
> gic, you can make it a platform driver. And I was trying to hack up a
> patch that's the equivalent of platform_irqchip_probe() (which just
> ends up eventually calling the callback you use in IRQCHIP_DECLARE().
> I probably made some mistake in the quick hack that I'm sure if
> fixable.
> 
> > > [    0.013251] Failed to map interrupt for
> > > /soc@0/bus@30400000/timer@306a0000
> 
> However, this timer driver also uses TIMER_OF_DECLARE() which can't
> handle failure to get the IRQ (because it's can't -EPROBE_DEFER). So,
> this means, the timer driver inturn needs to be converted to a
> platform driver if it's supposed to work with the IRQCHIP_DECLARE()
> being converted to a platform driver.
> 
> But that's a can of worms not worth opening. But then I remembered
> this simpler workaround will work and it is pretty much a variant of
> the workaround that's already in the gpc's irqchip driver to allow two
> drivers to probe the same device (people really should stop doing
> that).
> 
> Can you drop my previous hack patch and try this instead please? I'm
> 99% sure this will work.
> 
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c
> b/drivers/irqchip/irq-imx-gpcv2.c index b9c22f764b4d..8a0e82067924 100644
> --- a/drivers/irqchip/irq-imx-gpcv2.c
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -283,6 +283,7 @@ static int __init imx_gpcv2_irqchip_init(struct
> device_node *node,
>          * later the GPC power domain driver will not be skipped.
>          */
>         of_node_clear_flag(node, OF_POPULATED);
> +       fwnode_dev_initialized(domain->fwnode, false);
>         return 0;
>  }

Just to be sure here, I tried this patch on top of next-20220701 but 
unfortunately this doesn't fix the original problem either. The timer errors 
are gone though.
The probe of imx8m-blk-ctrl got slightly delayed (from 0.74 to 0.90s printk 
time) but results in the identical error message.

Best regards,
Alexander



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
