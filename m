Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1155CCA473
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 18:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FFB183FE5;
	Mon, 27 Jun 2022 18:21:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FFB183FE5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=QfczmHRT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qJA2SQkCH3i; Mon, 27 Jun 2022 18:21:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CA14783FE1;
	Mon, 27 Jun 2022 18:21:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA14783FE1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98B67C0032;
	Mon, 27 Jun 2022 18:21:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D617C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 18:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48B43416AD
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 18:21:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48B43416AD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=QfczmHRT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZFpf8sOXDWy for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 18:21:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DB5241676
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1DB5241676
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 18:21:20 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-3177f4ce3e2so93945447b3.5
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zAvy14WQSJajEvtEq9Z9V458WL9rypKqsSWZ5e8ff+Q=;
 b=QfczmHRT9/HR8HyazKLbsqrs7cCP2iZKaxG/OXGSPnAc8W5YAiaVA0WqjZ3/6QtXqU
 42K81l24QIf3XynW/JKjRGJ7dmfzwI2FUm73m5CnsNDIqxjEz+NWZjbRqeUpE3CO+oZH
 +WHVevlpyQHs4NMeAMNGbQrzcjZNAN6YiP+T/yfSSMD0p0fn3Nshe7kDoUKHwoSYa4N3
 VnE5Z7u+uJPgYCZdcfgQYEKpStJa5alN/Ge9h9ME6zGeGt1uUwucGuzxD4iyBvikWn6I
 UNKi3EkIpSabWBkxoc2zg+IeRkTOZHzN8h/RLyTzMjG2hCOwCIaltZxdV6oluuLg1E7j
 RMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zAvy14WQSJajEvtEq9Z9V458WL9rypKqsSWZ5e8ff+Q=;
 b=r0CgOqj6wbq03TMf0GHqbklTY3x13CHCTXR5tKXPR1hdoJEyl0vl5AvRBgbKVOfnlQ
 m0mtDCGcrx0ypWYOGGz/fZuo4xCmnYoSX9/XBApZ6X+kRbCbaFYdOUmb/uWwtmBgAQDd
 RCdSNJ6qpjyRwTyhps5bp8ZZtwLGg/O2vBvWsw/nAuzoCqKaJjgDXkjd3yju/bANdVL1
 E7yORnhI3kReUWCIoAKI1EfYM8GibHAKSi2ajntTnortW4bblxc10uMR8W4QpiZ81lYL
 aP7lMWeOZITggRT7ZSQWYIS4oArxh7wq1uifoGM+0C+GgLjlJTejiz82J1i1hPOj9U3z
 Bwlg==
X-Gm-Message-State: AJIora8zoDmzrj1R6iRKUbpG6gaR4NsVXG02TTEFLxfY8kNAM/vDpL3N
 XOoHZnpTWC5S6vkJXvqnpxL0Jlc5InVUUDzpnem7sg==
X-Google-Smtp-Source: AGRyM1ut1mmdvIzz+fGssaCHywTk0zdoNUyWRaIm6VKkay06+F6yyhsbCZbfM6hX7GjWG5RLUmdofYrPpF5aZ5NeSXg=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr16855244ywe.126.1656354078827; Mon, 27
 Jun 2022 11:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de>
 <20220627175046.GA2644138-robh@kernel.org>
In-Reply-To: <20220627175046.GA2644138-robh@kernel.org>
Date: Mon, 27 Jun 2022 11:20:42 -0700
Message-ID: <CAGETcx8YSuq+_tiWwShjZBeHd7+CHwLRdvdT6yb3xfEUD7DB0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
To: Rob Herring <robh@kernel.org>
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linus walleij <linus.walleij@linaro.org>, ulf hansson <ulf.hansson@linaro.org>,
 eric dumazet <edumazet@google.com>, pavel machek <pavel@ucw.cz>,
 will deacon <will@kernel.org>, sascha hauer <sha@pengutronix.de>,
 kevin hilman <khilman@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 russell king <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
 jakub kicinski <kuba@kernel.org>, paolo abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <lenb@kernel.org>,
 len brown <len.brown@intel.com>, kernel@pengutronix.de,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
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

On Mon, Jun 27, 2022 at 10:50 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 23, 2022 at 12:04:21PM +0200, sascha hauer wrote:
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
> > >                     of_property_read_string(of_aliases, "stdout", &name);
> > >             if (name)
> > >                     of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
> > > +           if (of_stdout)
> > > +                   of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
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
> Can't we have a driver flag 'I have optional dependencies' that will
> trigger probe without all dependencies and then the driver can defer
> probe if required dependencies are not yet met.

Haha... that's kinda what I'm working on right now. But named
intentionally in a more limited sense of "I can't wait for the
timeout" where fw_devlink will relax and allow the driver to probe
(and have it make the call) once we hit late_initcall(). I'm
explicitly limiting it to "timeout" because we don't want everyone
adding this flag everytime they hit an issue. That'll beat the point
of fw_devlink=on.

Also, setting the flag for a driver to fix one system might break
another system because in the other system the user might want to wait
for the timeout because the supplier drivers would be loaded before
the timeout.

Another option is to restart the timer (if it hasn't expired) when
filesystems get mounted (in addition to the current "when new driver
gets registered). That way, we might be able to drop the timeout from
10s to 5s.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
