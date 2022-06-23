Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034B6C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 17:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C40D42527;
	Thu, 23 Jun 2022 17:22:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C40D42527
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ICBM68moUQel; Thu, 23 Jun 2022 17:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E5428424F5;
	Thu, 23 Jun 2022 17:22:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5428424F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9FC1C0039;
	Thu, 23 Jun 2022 17:22:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C05DEC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 17:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9391060B05
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 17:22:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9391060B05
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q_aGYjpwUkQT for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 17:22:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E40C960A9D
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com
 [209.85.219.175])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E40C960A9D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 17:22:44 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id i7so150092ybe.11
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 10:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QzySQcL24GEYxXoJc82RsC0c2BhGDpj4k4DOkY9xrS0=;
 b=NIfJ+QBjXIp/hvGTsTNjkwTIbssODiHgeq3YKSbFMelS9hXW1v1uJYyxgvhp7en0W9
 0Uy9yIzcntEBj45tM6pRN9WmBf7/yOf9h3GYnoh8yWDzAo7JjfPjVduMJqzUrOBRY1Lh
 o4j0flZVzBde0ZEaSkmVkI9edlkxk/tPQuIcftZyttPrt7RuQHH8BzCYA/vT9iBP3qIn
 3F45/xch0Y1m4C1hg5z73iwwuAq4rTkaQeciz9RcvtsueskZ3s2Cap9c61PlPUQw8UNW
 NbXirjGmzcDdwE84Y71SkFZuiI2eQ2/yQ+OB/oWnv1b75gz4KxNdlkwD0PBgrBes8Ss6
 3Vcg==
X-Gm-Message-State: AJIora8y7CGQ0OMGB3Ga/tpGDZEI3ekw3xFqMHRz5+KhY5eNKw163Ea1
 hDhkk281Jb8Ip9W1kRX/8yP5ozWfo+UuD88nSeU=
X-Google-Smtp-Source: AGRyM1vlR+G3ynXaQ+rOy9k5hMBPieUkqHmh9QChAgpgAs7VODTNv3swHyAeiQ4sYXpc/+o+j6AcUnENYWlbLbMDoS8=
X-Received: by 2002:a05:6902:1141:b0:669:3f2a:c6bb with SMTP id
 p1-20020a056902114100b006693f2ac6bbmr10551083ybu.365.1656004963776; Thu, 23
 Jun 2022 10:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de> <YrSXKkYfr+Hinsuu@smile.fi.intel.com>
In-Reply-To: <YrSXKkYfr+Hinsuu@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jun 2022 19:22:32 +0200
Message-ID: <CAJZ5v0girHMO5v=KMXmTuXNjrfx+1gi8ma25mNc+gt=3U8pppA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linus walleij <linus.walleij@linaro.org>, ulf hansson <ulf.hansson@linaro.org>,
 eric dumazet <edumazet@google.com>, pavel machek <pavel@ucw.cz>,
 will deacon <will@kernel.org>, sascha hauer <sha@pengutronix.de>,
 Saravana Kannan <saravanak@google.com>, kevin hilman <khilman@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, russell king <linux@armlinux.org.uk>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 jakub kicinski <kuba@kernel.org>, paolo abeni <pabeni@redhat.com>,
 "Cc: Android Kernel" <kernel-team@android.com>, Len Brown <lenb@kernel.org>,
 len brown <len.brown@intel.com>, Sascha Hauer <kernel@pengutronix.de>,
 Linux PM <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, hideaki yoshifuji <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 david ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev <netdev@vger.kernel.org>,
 "david s. miller" <davem@davemloft.net>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, heiner kallweit <hkallweit1@gmail.com>
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

On Thu, Jun 23, 2022 at 6:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 23, 2022 at 12:04:21PM +0200, sascha hauer wrote:
> > On Thu, Jun 23, 2022 at 01:03:43AM -0700, Saravana Kannan wrote:
>
> ...
>
> > I wonder if it wouldn't be a better approach to just probe all devices
> > and record the device(node) they are waiting on. Then you know that you
> > don't need to probe them again until the device they are waiting for
> > is available.
>
> There may be no device, but resource. And we become again to the something like
> deferred probe ugly hack.
>
> The real solution is to rework device driver model in the kernel that it will
> create a graph of dependencies and then simply follow it. But actually it should
> be more than 1 graph, because there are resources and there are power, clock and
> resets that may be orthogonal to the higher dependencies (like driver X provides
> a resource to driver Y).

There is one graph, or it wouldn't be possible to shut down the system orderly.

The problem is that this graph is generally dynamic, especially during
system init, and following dependencies in transient states is
generally hard.

Device links allow the already known dependencies to be recorded and
taken into account later, so we already have a graph for those.

The unknown dependencies obviously cannot be used for creating a graph
of any sort, though, and here we are in the business of guessing what
the unknown dependencies may be IIUC.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
