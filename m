Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648CBC43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 10:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE41584730;
	Thu, 23 Jun 2022 10:06:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE41584730
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7j5bscoiDrfX; Thu, 23 Jun 2022 10:06:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8352A84728;
	Thu, 23 Jun 2022 10:06:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8352A84728
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44594C0039;
	Thu, 23 Jun 2022 10:06:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9564C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 10:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F84E84730
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 10:06:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F84E84730
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QltWYJ4VHX4Q for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 10:06:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65C8784728
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65C8784728
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 10:06:02 +0000 (UTC)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1o4JhK-0001s4-PU; Thu, 23 Jun 2022 12:04:26 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1o4JhF-0006Dc-DA; Thu, 23 Jun 2022 12:04:21 +0200
Date: Thu, 23 Jun 2022 12:04:21 +0200
From: sascha hauer <sha@pengutronix.de>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
Message-ID: <20220623100421.GY1615@pengutronix.de>
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220623080344.783549-3-saravanak@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linus walleij <linus.walleij@linaro.org>, ulf hansson <ulf.hansson@linaro.org>,
 eric dumazet <edumazet@google.com>, pavel machek <pavel@ucw.cz>,
 will deacon <will@kernel.org>, kevin hilman <khilman@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, russell king <linux@armlinux.org.uk>,
 linux-acpi@vger.kernel.org, jakub kicinski <kuba@kernel.org>,
 paolo abeni <pabeni@redhat.com>, kernel-team@android.com,
 Len Brown <lenb@kernel.org>, len brown <len.brown@intel.com>,
 kernel@pengutronix.de, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 hideaki yoshifuji <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 david ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 Daniel Scally <djrscally@gmail.com>, iommu@lists.linux-foundation.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org,
 "david s. miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
 heiner kallweit <hkallweit1@gmail.com>
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

On Thu, Jun 23, 2022 at 01:03:43AM -0700, Saravana Kannan wrote:
> Commit 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> enabled iommus and dmas dependency enforcement by default. On some
> systems, this caused the console device's probe to get delayed until the
> deferred_probe_timeout expires.
> 
> We need consoles to work as soon as possible, so mark the console device
> node with FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> the probe of the console device for suppliers without drivers. The
> driver can then make the decision on where it can probe without those
> suppliers or defer its probe.
> 
> Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> Reported-by: Sascha Hauer <sha@pengutronix.de>
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Tested-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/of/base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index d4f98c8469ed..a19cd0c73644 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1919,6 +1919,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
>  			of_property_read_string(of_aliases, "stdout", &name);
>  		if (name)
>  			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
> +		if (of_stdout)
> +			of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;

The device given in the stdout-path property doesn't necessarily have to
be consistent with the console= parameter. The former is usually
statically set in the device trees contained in the kernel while the
latter is dynamically set by the bootloader. So if you change the
console uart in the bootloader then you'll still run into this trap.

It's problematic to consult only the device tree for dependencies. I
found several examples of drivers in the tree for which dma support
is optional. They use it if they can, but continue without it when
not available. "hwlock" is another property which consider several
drivers as optional. Also consider SoCs in early upstreaming phases
when the device tree is merged with "dmas" or "hwlock" properties,
but the corresponding drivers are not yet upstreamed. It's not nice
to defer probing of all these devices for a long time.

I wonder if it wouldn't be a better approach to just probe all devices
and record the device(node) they are waiting on. Then you know that you
don't need to probe them again until the device they are waiting for
is available.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
