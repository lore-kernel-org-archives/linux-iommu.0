Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6167EC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 12:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB6A9410E4;
	Thu, 23 Jun 2022 12:15:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB6A9410E4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.a=rsa-sha256 header.s=key1 header.b=XGEJTaiX;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.a=rsa-sha256 header.s=key1 header.b=HqDs5ssF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UYGKLnuToq_K; Thu, 23 Jun 2022 12:15:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C144410E5;
	Thu, 23 Jun 2022 12:15:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C144410E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F9B0C0032;
	Thu, 23 Jun 2022 12:15:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29F95C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 12:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0433A410E4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 12:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0433A410E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3uUi3h6WjZkZ for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 12:15:55 +0000 (UTC)
X-Greylist: delayed 00:07:12 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3393040447
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3393040447
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1655986555; x=1687522555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9/CCr0snWfftSFhkeAYUhF2+vCU0/VTKAyn0ef5b+1M=;
 b=XGEJTaiXBLPDi4Ojo8+SaWm5Lcl9L4B1JdlBrZb1SUeyLJl/jGVAz9k+
 tS68yvor1wRoDEGRlbLcOM3AH35BLLUI7a7O5o0l3hlNX0u7dhTNW3mRt
 NEUvdvYBya0QlW9Hnbcl4vVqApPXR/nCXKxptTKNisjyAWVh3Ul/1/tPn
 UO71io8gNJRSwMmGfPXdXt7WwTN61de3av9Wi3z18fNZ4LmE2C7OHJpTI
 aQ9owiQO2XEnHxPP/HqOewzy6nA0q/Gj/eNmDIBrFwvVplGcn8lwXhnNR
 YS8BSZlgBtBrG6e0hZkNbkRtbERKrq73VnKeXP8Z309IVdklQXPKcYfgh w==;
X-IronPort-AV: E=Sophos;i="5.92,216,1650924000"; d="scan'208";a="24631790"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
 by mx1-pgp.tq-group.com with ESMTP; 23 Jun 2022 14:08:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
 by tq-pgp-pr1.tq-net.de (PGP Universal service);
 Thu, 23 Jun 2022 14:08:39 +0200
X-PGP-Universal: processed;
 by tq-pgp-pr1.tq-net.de on Thu, 23 Jun 2022 14:08:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1655986119; x=1687522119;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9/CCr0snWfftSFhkeAYUhF2+vCU0/VTKAyn0ef5b+1M=;
 b=HqDs5ssF8L1EkiBFh2ujtpvauytr8wW9ynjPp2xOnD4EQm4zS6BPcHVl
 lxCOGE9jVnfEHBD/8sdZQllqvQTP/1hCMj4QZY6SY4Dsotw+F09xiTIbq
 kPGuT6sVq23fcovCydMWi8mwrwIkHuq0JdWTnYE+8HL1BZeE7m/EB/0Z2
 jXy8EAKffPqzrkqqO6YcQzKY7pIfLm1sMMrgzEp3d8Y8kwIXrn9ZM9Ms+
 zqG3kEyie1oOETmmWcRSdR2GYyqnkSUJwZUXPsUDFrdSKw9PLlNJufhlU
 z97RAyDul51fuxwcMhrOWtYtivSC6bw3XtK+NKpUAday6W/pIZCXrl64Z w==;
X-IronPort-AV: E=Sophos;i="5.92,216,1650924000"; d="scan'208";a="24631789"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 23 Jun 2022 14:08:39 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C37F4280056;
 Thu, 23 Jun 2022 14:08:38 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Saravana Kannan <saravanak@google.com>, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
Date: Thu, 23 Jun 2022 14:08:38 +0200
Message-ID: <4799738.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <YrFzK6EiVvXmzVG6@atomide.com>
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com>
 <YrFzK6EiVvXmzVG6@atomide.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

Am Dienstag, 21. Juni 2022, 09:28:43 CEST schrieb Tony Lindgren:
> Hi,
> 
> * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > Now that fw_devlink=on by default and fw_devlink supports
> > "power-domains" property, the execution will never get to the point
> > where driver_deferred_probe_check_state() is called before the supplier
> > has probed successfully or before deferred probe timeout has expired.
> > 
> > So, delete the call and replace it with -ENODEV.
> 
> Looks like this causes omaps to not boot in Linux next. With this
> simple-pm-bus fails to probe initially as the power-domain is not
> yet available. On platform_probe() genpd_get_from_provider() returns
> -ENOENT.
> 
> Seems like other stuff is potentially broken too, any ideas on
> how to fix this?

I think I'm hit by this as well, although I do not get a lockup.
In my case I'm using arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts 
and probing of 38320000.blk-ctrl fails as the power-domain is not (yet) 
registed. See the (filtered) dmesg output:

> [    0.744245] PM: Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@0 [    0.744756] PM:
> Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@2 [    0.745012] PM:
> Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@3 [    0.745268] PM:
> Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@4 [    0.746121] PM:
> Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@7 [    0.746400] PM:
> Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@8 [    0.746665] PM:
> Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@9 [    0.746927] PM:
> Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@a [    0.748870]
> imx8m-blk-ctrl 38320000.blk-ctrl: error -ENODEV: failed to attach bus power
> domain [    1.265279] PM: Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@5 [    1.265861] PM:
> Added domain provider from
> /soc@0/bus@30000000/gpc@303a0000/pgc/power-domain@6

blk-ctrl@38320000 requires the power-domain 'pgc_vpu', which is power-domain@6 
in pgc.

Best regards,
Alexander

> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> > 
> >  drivers/base/power/domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 739e52cd4aba..3e86772d5fac 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev,
> > struct device *base_dev,> 
> >  		mutex_unlock(&gpd_list_lock);
> >  		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
> >  		
> >  			__func__, PTR_ERR(pd));
> > 
> > -		return driver_deferred_probe_check_state(base_dev);
> > +		return -ENODEV;
> > 
> >  	}
> >  	
> >  	dev_dbg(dev, "adding to PM domain %s\n", pd->name);




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
