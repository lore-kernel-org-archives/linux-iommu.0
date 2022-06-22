Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE305C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 07:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C4F040C70;
	Wed, 22 Jun 2022 07:48:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C4F040C70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dqjciubWP1Dx; Wed, 22 Jun 2022 07:48:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C5E7F400DD;
	Wed, 22 Jun 2022 07:48:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5E7F400DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A422BC0032;
	Wed, 22 Jun 2022 07:48:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17244C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F36EC40A02
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:48:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F36EC40A02
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wcWwwl_wHqhd for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 07:48:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2090400DD
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2090400DD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:48:52 +0000 (UTC)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1o3v5s-0000nJ-UD; Wed, 22 Jun 2022 09:48:08 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1o3v5g-0000yF-8I; Wed, 22 Jun 2022 09:47:56 +0200
Date: Wed, 22 Jun 2022 09:47:56 +0200
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 7/9] driver core: Set fw_devlink.strict=1 by default
Message-ID: <20220622074756.GA1647@pengutronix.de>
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-8-saravanak@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220601070707.3946847-8-saravanak@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From: Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel@pengutronix.de,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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

On Wed, Jun 01, 2022 at 12:07:03AM -0700, Saravana Kannan wrote:
> Now that deferred_probe_timeout is non-zero by default, fw_devlink will
> never permanently block the probing of devices. It'll try its best to
> probe the devices in the right order and then finally let devices probe
> even if their suppliers don't have any drivers.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As mentioned here:

https://lore.kernel.org/lkml/20220622062027.994614-1-peng.fan@oss.nxp.com/

This patch has the effect that console UART devices which have "dmas"
properties specified in the device tree get deferred for 10 to 20
seconds. This happens on i.MX and likely on other SoCs as well. On i.MX
the dma channel is only requested at UART startup time and not at probe
time. dma is not used for the console. Nevertheless with this driver probe
defers until the dma engine driver is available.

It shouldn't go in as-is.

Sascha

> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 61fdfe99b348..977b379a495b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1613,7 +1613,7 @@ static int __init fw_devlink_setup(char *arg)
>  }
>  early_param("fw_devlink", fw_devlink_setup);
>  
> -static bool fw_devlink_strict;
> +static bool fw_devlink_strict = true;
>  static int __init fw_devlink_strict_setup(char *arg)
>  {
>  	return strtobool(arg, &fw_devlink_strict);
> -- 
> 2.36.1.255.ge46751e96f-goog
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
