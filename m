Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F26C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 20:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90B324032A;
	Thu, 23 Jun 2022 20:38:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90B324032A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JNONvG9wTcna; Thu, 23 Jun 2022 20:38:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26452401E1;
	Thu, 23 Jun 2022 20:38:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26452401E1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3107C0032;
	Thu, 23 Jun 2022 20:38:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B856C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 20:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F0DE417A1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 20:38:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F0DE417A1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bvc3HY84N1Ru for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 20:38:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62EFB416D4
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62EFB416D4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 20:38:13 +0000 (UTC)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1o4TZo-0005zb-EL; Thu, 23 Jun 2022 22:37:20 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1o4TZk-0004Od-6x; Thu, 23 Jun 2022 22:37:16 +0200
Date: Thu, 23 Jun 2022 22:37:16 +0200
From: sascha hauer <sha@pengutronix.de>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
Message-ID: <20220623203716.GA1615@pengutronix.de>
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de>
 <CAGETcx_eVkYtVX9=TOKnhpP2_ZpJwRDoBye3i7ND2u5Q-eQfPg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx_eVkYtVX9=TOKnhpP2_ZpJwRDoBye3i7ND2u5Q-eQfPg@mail.gmail.com>
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

On Thu, Jun 23, 2022 at 10:26:46AM -0700, Saravana Kannan wrote:
> On Thu, Jun 23, 2022 at 3:05 AM sascha hauer <sha@pengutronix.de> wrote:
> >
> > On Thu, Jun 23, 2022 at 01:03:43AM -0700, Saravana Kannan wrote:
> > > Commit 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> > > enabled iommus and dmas dependency enforcement by default. On some
> > > systems, this caused the console device's probe to get delayed until the
> > > deferred_probe_timeout expires.
> > >
> > > We need consoles to work as soon as possible, so mark the console device
> > > node with FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> > > the probe of the console device for suppliers without drivers. The
> > > driver can then make the decision on where it can probe without those
> > > suppliers or defer its probe.
> > >
> > > Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> > > Reported-by: Sascha Hauer <sha@pengutronix.de>
> > > Reported-by: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > Tested-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/of/base.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > index d4f98c8469ed..a19cd0c73644 100644
> > > --- a/drivers/of/base.c
> > > +++ b/drivers/of/base.c
> > > @@ -1919,6 +1919,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
> > >                       of_property_read_string(of_aliases, "stdout", &name);
> > >               if (name)
> > >                       of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
> > > +             if (of_stdout)
> > > +                     of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
> >
> > The device given in the stdout-path property doesn't necessarily have to
> > be consistent with the console= parameter. The former is usually
> > statically set in the device trees contained in the kernel while the
> > latter is dynamically set by the bootloader. So if you change the
> > console uart in the bootloader then you'll still run into this trap.
> >
> > It's problematic to consult only the device tree for dependencies. I
> > found several examples of drivers in the tree for which dma support
> > is optional. They use it if they can, but continue without it when
> > not available. "hwlock" is another property which consider several
> > drivers as optional. Also consider SoCs in early upstreaming phases
> > when the device tree is merged with "dmas" or "hwlock" properties,
> > but the corresponding drivers are not yet upstreamed. It's not nice
> > to defer probing of all these devices for a long time.
> >
> > I wonder if it wouldn't be a better approach to just probe all devices
> > and record the device(node) they are waiting on. Then you know that you
> > don't need to probe them again until the device they are waiting for
> > is available.
> 
> That actually breaks things in a worse sense. There are cases where
> the consumer driver is built in and the optional supplier driver is
> loaded at boot. Without fw_devlink and the deferred probe timeout, we
> end up probing the consumer with limited functionality. With the
> current setup, sure we delay some probes a bit but at least everything
> works with the right functionality. And you can reduce or remove the
> delay if you want to optimize it.

We have optional and mandatory resources. In this situation a driver has
to decide what to do. Either it continues with limited resources or it
defers probing. Some drivers try to allocate the optional resources at
open time so that they are able to use them once they are available.  We
could even think of an asynchronous callback into a driver when a
resource becomes available. Whether we put this decision what is
optional or not into the driver or in the framework doesn't make a
difference to the problem, it is still the same: When a resource is not
yet available we have no idea if and when it becomes available, if it's
worth waiting for it or not.

The difference is that with my proposal (which isn't actually mine but
from my collegue Lucas) a driver can decide very fine grained how it
wants to deal with the situation. With fw_devlink we try to put this
intelligence into the framework and it seems there are quite some quirks
necessary to get that running for everyone.

Anyway, we have fw_devlink now and actually I think the dependency graph
that we have with fw_devlink is quite nice to resolve the natural probe
order. But why do we have to put an extra penalty on drivers whose
resources are not yet available?  Probe devices with complete resources
as long as you find them, execute more initcalls as long as there are
any, but when there are no more left, you could start probing devices
with incomplete resources, why wait for another ten seconds?

For me it's no problem when the UART probes late, we have earlycon which
can be used to debug problems that arise before the UART probes, but
what nags is the ten seconds delay. zero would be a much saner value for
me.

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
