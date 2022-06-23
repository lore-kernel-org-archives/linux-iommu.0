Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1CBCCA47F
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 08:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0156384574;
	Thu, 23 Jun 2022 08:04:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0156384574
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=VTQtFvKL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZQknohBofPbj; Thu, 23 Jun 2022 08:04:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA83684581;
	Thu, 23 Jun 2022 08:04:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA83684581
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84730C0032;
	Thu, 23 Jun 2022 08:04:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 312A2C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B1E941A4C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:04:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B1E941A4C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=VTQtFvKL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ULShKgdgL4Zc for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:04:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB77741A34
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB77741A34
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:04:52 +0000 (UTC)
Received: by mail-yb1-xb2e.google.com with SMTP id p69so22758046ybc.5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aJdGY8if0kKaADIOnNz/K5T0O1hT/jUoomceGsgv8qg=;
 b=VTQtFvKLR234TeEsJG9hJ1cv/fTlg/g75r8DUnXK6ZHcXDiNZlsJYB9CHo/M+MtXXm
 kHxKIuNF0rtlBZTftpqriI4HPVkNAF8Kgf2nEavzZoQhhOEgRbl56Yidg8QEwndgSNmo
 guDcAYV+JbY07aCqXNXOm0MAQ374EyPk3ywDSm8OW4cMFCwWkHtQXObbRqfIV1Au2qL/
 2xJX/OVUmoI0Ru+JwXOHrC9gjW8I3BqdmxJTIj+bkS/ZKg4cBj3SDMQZSf2iggQyehVV
 s0m81yWPr2B/Nu8wqEz2Z07cBjk9Ng0bbJAp4gpara4efxy5PPr9RgZdjjBJiDIEtWTH
 KYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aJdGY8if0kKaADIOnNz/K5T0O1hT/jUoomceGsgv8qg=;
 b=sk75AFmQYH01r2XjwmZigOcsi3PdVqVPetF4dplHyeeSUYftiHwr7u/XwVGRHe89Lj
 TK+ca9sYn6SmfCZS0blb3R8PSYgj8Oq4upRISByyceRwbfYxs+XaKj2xQxBV02NAIDaW
 ZklZqkQ/iLb9TNHI58yQPgEnaRK6tV8IGW3SOYUwJhGw8YupNXR5Em3yuXb+yCFMLbfZ
 feiZA6Vpw7vznkFpZl7t+BBJ8f00nPL9/Ce64zMqqzCeBGBX+T9VdFCm3FMVolHNUAjs
 dPqxaqnhxFKGVZiLs1hmexNrwFJcw7H5dhmQE6GeG0DBCZNUQ0tOA7NSFYurnst9lY35
 IAWQ==
X-Gm-Message-State: AJIora9d1faii69rG1Y2hUqRO20WjxwdMs7J+24lPdD5IzkZGuutxSZP
 0ROyCTjne6iw/atpVNg58NVSFlLl55OAsLH3GsYnsw==
X-Google-Smtp-Source: AGRyM1vSa06Bo2VNf1pFNqSEQ2ygrs7ov2BN88IdRJyYwpujxiov2K55jHdtpFFoYamFYqbsbeU9U6O7j7pmqWeF7uU=
X-Received: by 2002:a25:d8c8:0:b0:669:5f5b:7d75 with SMTP id
 p191-20020a25d8c8000000b006695f5b7d75mr8205442ybg.80.1655971491674; Thu, 23
 Jun 2022 01:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220622215912.550419-1-saravanak@google.com>
 <20220622215912.550419-2-saravanak@google.com>
 <20220623065031.GX1615@pengutronix.de>
In-Reply-To: <20220623065031.GX1615@pengutronix.de>
Date: Thu, 23 Jun 2022 01:04:14 -0700
Message-ID: <CAGETcx_TaR+_Z9bf-Gsx3pXC9QwSUT85TTwALj5KjaOY1oNK8g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: fw_devlink: Allow firmware to mark
 devices as best effort
To: Sascha Hauer <sha@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Peng Fan <peng.fan@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Pavel Machek <pavel@ucw.cz>,
 Will Deacon <will@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-acpi@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kernel-team@android.com,
 Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>,
 kernel@pengutronix.de, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 Daniel Scally <djrscally@gmail.com>, iommu@lists.linux-foundation.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
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

On Wed, Jun 22, 2022 at 11:50 PM Sascha Hauer <sha@pengutronix.de> wrote:
>
> On Wed, Jun 22, 2022 at 02:59:10PM -0700, Saravana Kannan wrote:
> > When firmware sets the FWNODE_FLAG_BEST_EFFORT flag for a fwnode,
> > fw_devlink will do a best effort ordering for that device where it'll
> > only enforce the probe/suspend/resume ordering of that device with
> > suppliers that have drivers. The driver of that device can then decide
> > if it wants to defer probe or probe without the suppliers.
> >
> > This will be useful for avoid probe delays of the console device that
> > were caused by commit 71066545b48e ("driver core: Set
> > fw_devlink.strict=1 by default").
> >
> > Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> > Reported-by: Sascha Hauer <sha@pengutronix.de>
> > Reported-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c    | 3 ++-
> >  include/linux/fwnode.h | 4 ++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 839f64485a55..61edd18b7bf3 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -968,7 +968,8 @@ static void device_links_missing_supplier(struct device *dev)
> >
> >  static bool dev_is_best_effort(struct device *dev)
> >  {
> > -     return fw_devlink_best_effort && dev->can_match;
> > +     return (fw_devlink_best_effort && dev->can_match) ||
> > +             dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT;
>
> Check for dev->fwnode first. I am running in a NULL pointer exception
> here for a device that doesn't have a fwnode.

Oops. Fixed and sent out a v2.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
