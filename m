Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D82CC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 22:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D669B6131A;
	Wed, 22 Jun 2022 22:34:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D669B6131A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=J4pi/aKD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ZgE4O_3NOHG; Wed, 22 Jun 2022 22:34:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9ED5660BE8;
	Wed, 22 Jun 2022 22:34:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9ED5660BE8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 799F3C0039;
	Wed, 22 Jun 2022 22:34:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A9E5C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 22:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5559D845C5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 22:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5559D845C5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=J4pi/aKD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o4rKepPCtADj for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 22:34:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCAAE845C3
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCAAE845C3
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 22:34:27 +0000 (UTC)
Received: by mail-yb1-xb36.google.com with SMTP id u9so22528960ybq.3
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WKylA8pYtIvxwg5/dZiB/uZdIVVN/P980vi4sBmsa8g=;
 b=J4pi/aKDOGnb+AER5hiC/Ur9ZSPqxLhl9mnB71A7+WIlfY2oiT/T5y5JfIyXfOCApX
 pLilMQlV84wpeyWcdPvtM97nw68tnuZyysLqMtJ7DRRJ6ajeonNGzDXJprWOIg8xBf0y
 NTH6Wl1a1nlYUaFdI4qtAMzn8cW7xPEjL5f7QJ94kT2HJ1ci6OAaAPqD1UX+0NL/zHh7
 304JDEDsF/c/vE8OS7ScZ5S8psqurQ00bjxfdujGxOif8q+MEh1dX6y/brQOOJs5BypF
 iAv8odstd+qJJe5X1KPMo+1qvBAD62prH31qb5OR0/0XW3vKz526q1m+3AN2s9rHhIps
 PBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WKylA8pYtIvxwg5/dZiB/uZdIVVN/P980vi4sBmsa8g=;
 b=mnH3Xb70iLax3lWIFwN095xRPyM4DuTDC4tC1QmvPdmOszcmJ6YKOeXo+mg6ug21jD
 D4Huqv0GJGNdAcqo8gJ3T2VySP2G7YKjHwOZyW1T+h9IjgVD+UdyT9tbUz/6dmkKmZJq
 Ce0eo2xoQ8mAkRV+os0N4Iv33M9fsDHXkPtVKbX80AW3si4omhqnRYoZHdG/1LfgizKF
 AtHrOmdJtOxFcIQ6A8qm5rpwPUfNj+l126mlzf8oquBFPextbqrmlrUKanEh7dDWdJ7C
 P9aoB/j5jLI8TPlN5fxJ/WJ1HHHgxS/AVOVdsy6IiGj25GBVm8q6I3i7wpB7NTtxdfoS
 I85w==
X-Gm-Message-State: AJIora+vVPFPJSTq/WSzMbcNGntZzexVbcWNH2kKUkDw4ylL/Zzxl0LK
 qFvprXFDLZoR/RBnoUWZldvCrqpS6KNdEv+pvMO0vA==
X-Google-Smtp-Source: AGRyM1vtP8cTHTShZ6uWcl+OVMszNehOV5bCtDdbKW/msmtH+Wdf1HHxNjR1QJIjKUG41gGaaaYuCgB7moTXz8XY7EE=
X-Received: by 2002:a25:d112:0:b0:669:17:8d98 with SMTP id
 i18-20020a25d112000000b0066900178d98mr6124766ybg.447.1655937266678; 
 Wed, 22 Jun 2022 15:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220622215912.550419-1-saravanak@google.com>
 <DU0PR04MB941733BFD323D3542B7F75A888B29@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB941733BFD323D3542B7F75A888B29@DU0PR04MB9417.eurprd04.prod.outlook.com>
Date: Wed, 22 Jun 2022 15:33:50 -0700
Message-ID: <CAGETcx-h4iDx+WG+HnN0_ej0qtLOp66oOXvkppm060TRCG3_Jg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Fix console probe delay due to fw_devlink
To: Peng Fan <peng.fan@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Sascha Hauer <sha@pengutronix.de>, Kevin Hilman <khilman@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
 Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

On Wed, Jun 22, 2022 at 3:32 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH v1 0/2] Fix console probe delay due to fw_devlink
> >
> > fw_devlink.strict=1 has been enabled by default. This was delaying the probe
> > of console devices. This series fixes that.
> >
> > Sasha/Peng,
> >
> > Can you test this please?
>
> Thanks, just give a test on i.MX8MP-EVK, works well now.
>
> Tested-by: Peng Fan <peng.fan@nxp.com> #i.MX8MP-EVK

Lol, that was quick! Thanks!

-Saravana

>
> Thanks,
> Peng.
>
> >
> > -Saravana
> >
> > Cc: Sascha Hauer <sha@pengutronix.de>
> > Cc: Peng Fan <peng.fan@nxp.com>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Heiner Kallweit <hkallweit1@gmail.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: kernel-team@android.com
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: iommu@lists.linux-foundation.org
> > Cc: netdev@vger.kernel.org
> > Cc: linux-gpio@vger.kernel.org
> > Cc: kernel@pengutronix.de
> >
> > Saravana Kannan (2):
> >   driver core: fw_devlink: Allow firmware to mark devices as best effort
> >   of: base: Avoid console probe delay when fw_devlink.strict=1
> >
> >  drivers/base/core.c    | 3 ++-
> >  drivers/of/base.c      | 2 ++
> >  include/linux/fwnode.h | 4 ++++
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
