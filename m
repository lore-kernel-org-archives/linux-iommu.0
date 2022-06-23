Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120BCC43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 17:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97A9760AC1;
	Thu, 23 Jun 2022 17:30:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 97A9760AC1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=L4dJOWUZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KJ5Uo0TVzZcb; Thu, 23 Jun 2022 17:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68AE160B32;
	Thu, 23 Jun 2022 17:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68AE160B32
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DC7DC0039;
	Thu, 23 Jun 2022 17:30:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A11FC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 17:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C7CD84736
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 17:30:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C7CD84736
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=L4dJOWUZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ARirkK6kJcbj for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 17:30:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9DF2846E9
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9DF2846E9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 17:30:53 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-3177f4ce3e2so1315867b3.5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KOXrqOWcfMdTsdtXrpYVXi48JcFuUmjoexhlnfOOTGg=;
 b=L4dJOWUZH8Ao72MwmMu0hlQebn/kw9JPayp5sizpod+mvJoa+Jk2c12U6dtGJw0ocL
 FY0ahsSAadsHrWKiB46J+rcLToO2J7UvF9dIoPD0dwYD6fCgiC2WdrEctFh7m2vONz1A
 i5kKXCDjiPHGInQZUAkTQeJKWzgc8xBF9HzM08vnWaL+MuxZ5JvD3IF2Be6NowkMVSgg
 S+ucsFZ/JWQdteDBkGi0njXsklqZaAIz/FkVYezBWUTLcJOSi+wYLYWfkqidiVZs/Mft
 8KjS3VdHIM1qyN71zTYrpDaez/WAciLANIBuy1v8KewlMSrgXXmZL/60tdhF7JlBxcPw
 T2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KOXrqOWcfMdTsdtXrpYVXi48JcFuUmjoexhlnfOOTGg=;
 b=cQ9tMuroiupIk1fQmwxbFQWMP3FZAMCyBjdjsID9TrtA1vaTsuMWRhs8jfUSKei7dn
 3pLAxvXuVWVCiAirGTYwre8ypvqiuzvT5pVSjZhE3n8/iOzJlw8A/AOasSgWENr/nfXa
 eJJ9hAMWrXs6J55fK9e0s3rHonv8h+o6wbCzGLIgNfj5uzxoZpHPpcUnoasFohCiwTmb
 kGpATP1r1KRB/V7wHxwt1Rb5LCkJsV+GwRtQ9EsETZsuJUJ4vV7gVdbw6ZjTgZBG54bh
 bU8hYkMldqv6goS7qXflxiaAdUl0UhHJduzoO2N262Gqia9Udjuld/KuqZWTjWEJcIfF
 HXuQ==
X-Gm-Message-State: AJIora8081JHI6T5AlvuBhFbiCgSBhVFfEGqLAqVuOhlZpHCJPyPR2fo
 yUmcdbgFKp1aCGOoCjlcbjXvmMQHWbwd7WxpP0Wxrw==
X-Google-Smtp-Source: AGRyM1ul3O6ILFZqI77UreHIjC0wH+ddqVeLDfmwfl1PMnWdistPwRhbAXTfwUjlgyKKpmHDt2j86FuzSHATEelndGs=
X-Received: by 2002:a0d:dfd5:0:b0:317:f0d4:505b with SMTP id
 i204-20020a0ddfd5000000b00317f0d4505bmr11413939ywe.518.1656005452363; Thu, 23
 Jun 2022 10:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de> <YrSXKkYfr+Hinsuu@smile.fi.intel.com>
In-Reply-To: <YrSXKkYfr+Hinsuu@smile.fi.intel.com>
Date: Thu, 23 Jun 2022 10:30:16 -0700
Message-ID: <CAGETcx8axPpXFv9Cc59nWrgW9_fYqZUYmNPUg83CTHTBZDC-ZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
 Rob Herring <robh+dt@kernel.org>, hideaki yoshifuji <yoshfuji@linux-ipv6.org>,
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

On Thu, Jun 23, 2022 at 9:39 AM Andy Shevchenko
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

We already do this with fw_devlink for DT based systems and we do
effectively just probe the devices in graph order (by deferring any
attempts that happen too early and before it even gets to the driver).
The problem is the knowledge of what's considered an optional vs
mandatory dependency and that's affected by the global state of driver
support in the kernel.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
