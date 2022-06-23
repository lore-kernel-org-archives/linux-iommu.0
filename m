Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37DDCCA47C
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 23:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F40040103;
	Thu, 23 Jun 2022 23:14:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F40040103
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=cmIBzn0G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OHwy7ub_6AWB; Thu, 23 Jun 2022 23:14:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A638400E4;
	Thu, 23 Jun 2022 23:14:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A638400E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CD6EC0039;
	Thu, 23 Jun 2022 23:14:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2264C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 23:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA19142566
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 23:13:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA19142566
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=cmIBzn0G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tk3tDnXd7Frx for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 23:13:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4564842552
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4564842552
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 23:13:58 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-2ef5380669cso8712257b3.9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q4rQdhnWLSWo14RnjtXWJNi2g5jmxMvqoaFVDnX2E5Q=;
 b=cmIBzn0GUySKMskyqJKDVgDVN/8vHWzNfjJ+BREUrbPM7OiFQy/ATX7aLRhZ8MANv1
 DeCxgq5hoHNltsRta4mLMJ5CVkKh4hfP6LVOwSV/7ivHGPCIqDCrcZofNe4RU/N40PFA
 084lsyuhYt6X1dulYD/2vojMLUtCUUuNjPCYYrjag+23v4QnctG6vuufvkN8P84KHpsZ
 1smdglM09EjAq6n/VWxttVgTknSAAilZfUXcBMOYhadXU9RaXikEWNdJ2rEO52JTzByf
 AZX6K773hR1jhsQBFWv6Jdd8yXumqgqHK9g5FERmM19ObNBe6obaPeOOW1hv8UESqekO
 6hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q4rQdhnWLSWo14RnjtXWJNi2g5jmxMvqoaFVDnX2E5Q=;
 b=fz3EvwLrEjulmt3DJhBkDpRmCKxs+D4yOW2BMRYPBhMUaGdECBC2Hm5pCKRuk1/W3L
 50Rhn3woaXaBv9773aZkWc4lZK1bkfHkwUtfKe5M7eRjLmB7aouXcB8svA23zJgny8g7
 SnTeD8S7yEcVw3btUL8O5GN54b1LFcTPk16m/e2OXYGIIu6zU8qMF/ejbMRlOuAsphiT
 TO7lD1TEt2wV1J3X/jJwSdPPYWQBU7nzM3g/8g/YkAjB9gHmtCx9XsZfP7etfQ6kApce
 cZ2mZxJ4mxVzpdeV32pxXe4mQyqDHb0siY/PUZLv5R+sGNebsA7s6Ab391fqLR3vWprP
 IxnA==
X-Gm-Message-State: AJIora/oY9OuA8mrLrLGTVANKk7fG221YAlOp8mMojNQFprb0jm7BvMr
 Vp1AaeyzcgNKacleC6DBonlGF3y/Si5gDdCaDiKRmg==
X-Google-Smtp-Source: AGRyM1tmOAvKbstD4mNEDSzf5ARhyGW/aO0E7tWlKoUjb1ZKcoDOPfJmrPrA9mjxTsX3Z0whnYeMEFOcEVoRWtE94Ys=
X-Received: by 2002:a0d:dfd5:0:b0:317:f0d4:505b with SMTP id
 i204-20020a0ddfd5000000b00317f0d4505bmr12968633ywe.518.1656026036778; Thu, 23
 Jun 2022 16:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de>
 <CAGETcx_eVkYtVX9=TOKnhpP2_ZpJwRDoBye3i7ND2u5Q-eQfPg@mail.gmail.com>
 <20220623203716.GA1615@pengutronix.de>
In-Reply-To: <20220623203716.GA1615@pengutronix.de>
Date: Thu, 23 Jun 2022 16:13:20 -0700
Message-ID: <CAGETcx-mCu+M0HhhX+bTNpzEswviJj2U8eCefLv3ezr29Nd+wA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
To: sascha hauer <sha@pengutronix.de>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jun 23, 2022 at 1:37 PM sascha hauer <sha@pengutronix.de> wrote:
>
> On Thu, Jun 23, 2022 at 10:26:46AM -0700, Saravana Kannan wrote:
> > On Thu, Jun 23, 2022 at 3:05 AM sascha hauer <sha@pengutronix.de> wrote:
> > >
> > > On Thu, Jun 23, 2022 at 01:03:43AM -0700, Saravana Kannan wrote:
> > > > Commit 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> > > > enabled iommus and dmas dependency enforcement by default. On some
> > > > systems, this caused the console device's probe to get delayed until the
> > > > deferred_probe_timeout expires.
> > > >
> > > > We need consoles to work as soon as possible, so mark the console device
> > > > node with FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> > > > the probe of the console device for suppliers without drivers. The
> > > > driver can then make the decision on where it can probe without those
> > > > suppliers or defer its probe.
> > > >
> > > > Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> > > > Reported-by: Sascha Hauer <sha@pengutronix.de>
> > > > Reported-by: Peng Fan <peng.fan@nxp.com>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > Tested-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/of/base.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > > index d4f98c8469ed..a19cd0c73644 100644
> > > > --- a/drivers/of/base.c
> > > > +++ b/drivers/of/base.c
> > > > @@ -1919,6 +1919,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
> > > >                       of_property_read_string(of_aliases, "stdout", &name);
> > > >               if (name)
> > > >                       of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
> > > > +             if (of_stdout)
> > > > +                     of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
> > >
> > > The device given in the stdout-path property doesn't necessarily have to
> > > be consistent with the console= parameter. The former is usually
> > > statically set in the device trees contained in the kernel while the
> > > latter is dynamically set by the bootloader. So if you change the
> > > console uart in the bootloader then you'll still run into this trap.
> > >
> > > It's problematic to consult only the device tree for dependencies. I
> > > found several examples of drivers in the tree for which dma support
> > > is optional. They use it if they can, but continue without it when
> > > not available. "hwlock" is another property which consider several
> > > drivers as optional. Also consider SoCs in early upstreaming phases
> > > when the device tree is merged with "dmas" or "hwlock" properties,
> > > but the corresponding drivers are not yet upstreamed. It's not nice
> > > to defer probing of all these devices for a long time.
> > >
> > > I wonder if it wouldn't be a better approach to just probe all devices
> > > and record the device(node) they are waiting on. Then you know that you
> > > don't need to probe them again until the device they are waiting for
> > > is available.
> >
> > That actually breaks things in a worse sense. There are cases where
> > the consumer driver is built in and the optional supplier driver is
> > loaded at boot. Without fw_devlink and the deferred probe timeout, we
> > end up probing the consumer with limited functionality. With the
> > current setup, sure we delay some probes a bit but at least everything
> > works with the right functionality. And you can reduce or remove the
> > delay if you want to optimize it.
>
> We have optional and mandatory resources. In this situation a driver has
> to decide what to do. Either it continues with limited resources or it
> defers probing. Some drivers try to allocate the optional resources at
> open time so that they are able to use them once they are available.  We
> could even think of an asynchronous callback into a driver when a
> resource becomes available. Whether we put this decision what is
> optional or not into the driver or in the framework doesn't make a
> difference to the problem, it is still the same: When a resource is not
> yet available we have no idea if and when it becomes available, if it's
> worth waiting for it or not.
>
> The difference is that with my proposal (which isn't actually mine but
> from my collegue Lucas) a driver can decide very fine grained how it
> wants to deal with the situation. With fw_devlink we try to put this
> intelligence into the framework and it seems there are quite some quirks
> necessary to get that running for everyone.

That's one possible solution, but for that to work, all drivers with
optional suppliers would need to be changed to take advantage of this
callback to work correctly when the optional suppliers become
available. We could add this callback, but it would be a long time
before the callback handles all/most cases of optional suppliers.

One of the goals of fw_devlink is so that people can stop having to
play initcall chicken where they try to tune their initcall levels wrt
to the chain of suppliers to avoid probe failures or minimize deferred
probed. Technically with deferred probes and proper error handling,
people shouldn't have to play initcall chicken, but we still have a
lot of those. Adding this callback is just going to make writing
drivers even harder. And there are tons of drivers that can't do
proper clean up and some drivers can't even be unbound once they are
bound.

Also, if I'm not mistaken (I could be), stuff like pinctrl is setup
before we even get to driver->probe(). So when the pinctrl supplier
becomes available, the driver would need to unbind fully and rebind.
What if there's a current user of the device?

> Anyway, we have fw_devlink now and actually I think the dependency graph
> that we have with fw_devlink is quite nice to resolve the natural probe
> order. But why do we have to put an extra penalty on drivers whose
> resources are not yet available?  Probe devices with complete resources
> as long as you find them, execute more initcalls as long as there are
> any, but when there are no more left, you could start probing devices
> with incomplete resources, why wait for another ten seconds?

The timeout is defining how long after the most recent module load
that we give up waiting for more modules to be loaded. On a Pixel 6
with serial console output, the timeout of 5 seconds would work
because the worst case gap between two module loads is ~2.8 seconds
(so 5 seconds for some margin). The default is this high to
accommodate slow storage devices where mounting all the filesystems
can take time (think HDD or network FS). The default is configured for
correctness so that we can maximize functionality across systems, but
people can optimize for the specific case.

> For me it's no problem when the UART probes late, we have earlycon which
> can be used to debug problems that arise before the UART probes, but
> what nags is the ten seconds delay. zero would be a much saner value for
> me.

Having said all that, I empathize with your annoyance at the delay.
Open to ideas of making this better without making the default
functionality worse.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
