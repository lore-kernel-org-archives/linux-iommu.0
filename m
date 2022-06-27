Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A62CCA473
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 17:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88B2860B12;
	Mon, 27 Jun 2022 17:50:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88B2860B12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nKS0flpw5_m; Mon, 27 Jun 2022 17:50:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A21D60ABA;
	Mon, 27 Jun 2022 17:50:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A21D60ABA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFF9FC0039;
	Mon, 27 Jun 2022 17:50:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08A83C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 17:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D644E405A6
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 17:50:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D644E405A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MaUi5XBcEguZ for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 17:50:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D23E400C1
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com
 [209.85.166.180])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D23E400C1
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 17:50:50 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id k7so6526036ils.8
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 10:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JMvotdxdopiZeRt2411RNmh3EgUkyNTiH64o+qllFfk=;
 b=3KDzb0bjEjG2bRHa9oNc//IQBSFXDOL97nifTZhUexgo44gvBQ5laji5gSe1ch0Yaw
 jrUOFztD8lN78o29DYqRlJrn59wc4pzEL69aU8k6fgmx7/MWjQFH/aNye3wBv2ypU1vS
 xerv8jbmNPkQgeYWzOpq2DvBFcXHNo7oRtSsDfXaCU8wWX9u7n4A+hZs+CxBUyQUgaN6
 IPtsN9nsnJ4xTNzc1pc5KsozBapKTbQRCMS9hgHsynzSpRjNVr2AGQg8M2j4bVIhtpUq
 Z3nT596rfMDinmdg7X+BANO6WhrgYadyJxmvBrEFMFp+yDhIh+zkXtZBYW5/ReTEZKYI
 lR8Q==
X-Gm-Message-State: AJIora+L3v+dsNrYLeeOPAtSuC9SCBdkrBPVXXC3BOzWTYxXYxQCEvsj
 0FDatuLZUrd4yNNNR6THsQ==
X-Google-Smtp-Source: AGRyM1vMlh69p3t3S82TZu1a3E/OZD68e6gmsrb96DKcUUIvaZw/486niMVTaLeFL863dLlg1DbVCA==
X-Received: by 2002:a92:da4c:0:b0:2d5:4942:151c with SMTP id
 p12-20020a92da4c000000b002d54942151cmr7774824ilq.54.1656352249605; 
 Mon, 27 Jun 2022 10:50:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a02a109000000b00339e3a22dbbsm5056008jag.21.2022.06.27.10.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 10:50:49 -0700 (PDT)
Received: (nullmailer pid 2661321 invoked by uid 1000);
 Mon, 27 Jun 2022 17:50:46 -0000
Date: Mon, 27 Jun 2022 11:50:46 -0600
From: Rob Herring <robh@kernel.org>
To: sascha hauer <sha@pengutronix.de>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
Message-ID: <20220627175046.GA2644138-robh@kernel.org>
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220623100421.GY1615@pengutronix.de>
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linus walleij <linus.walleij@linaro.org>, ulf hansson <ulf.hansson@linaro.org>,
 eric dumazet <edumazet@google.com>, pavel machek <pavel@ucw.cz>,
 will deacon <will@kernel.org>, Saravana Kannan <saravanak@google.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jun 23, 2022 at 12:04:21PM +0200, sascha hauer wrote:
> On Thu, Jun 23, 2022 at 01:03:43AM -0700, Saravana Kannan wrote:
> > Commit 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> > enabled iommus and dmas dependency enforcement by default. On some
> > systems, this caused the console device's probe to get delayed until the
> > deferred_probe_timeout expires.
> > 
> > We need consoles to work as soon as possible, so mark the console device
> > node with FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> > the probe of the console device for suppliers without drivers. The
> > driver can then make the decision on where it can probe without those
> > suppliers or defer its probe.
> > 
> > Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> > Reported-by: Sascha Hauer <sha@pengutronix.de>
> > Reported-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/of/base.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index d4f98c8469ed..a19cd0c73644 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -1919,6 +1919,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
> >  			of_property_read_string(of_aliases, "stdout", &name);
> >  		if (name)
> >  			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
> > +		if (of_stdout)
> > +			of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
> 
> The device given in the stdout-path property doesn't necessarily have to
> be consistent with the console= parameter. The former is usually
> statically set in the device trees contained in the kernel while the
> latter is dynamically set by the bootloader. So if you change the
> console uart in the bootloader then you'll still run into this trap.
> 
> It's problematic to consult only the device tree for dependencies. I
> found several examples of drivers in the tree for which dma support
> is optional. They use it if they can, but continue without it when
> not available. "hwlock" is another property which consider several
> drivers as optional. Also consider SoCs in early upstreaming phases
> when the device tree is merged with "dmas" or "hwlock" properties,
> but the corresponding drivers are not yet upstreamed. It's not nice
> to defer probing of all these devices for a long time.
> 
> I wonder if it wouldn't be a better approach to just probe all devices
> and record the device(node) they are waiting on. Then you know that you
> don't need to probe them again until the device they are waiting for
> is available.

Can't we have a driver flag 'I have optional dependencies' that will 
trigger probe without all dependencies and then the driver can defer 
probe if required dependencies are not yet met.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
