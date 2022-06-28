Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC68CCA480
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 13:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF59341635;
	Tue, 28 Jun 2022 13:41:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF59341635
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hGw9T6Ca
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yoT-FNvj-jll; Tue, 28 Jun 2022 13:41:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5BAA7415C3;
	Tue, 28 Jun 2022 13:41:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BAA7415C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E02DC0032;
	Tue, 28 Jun 2022 13:41:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99533C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 807E740607
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 807E740607
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=hGw9T6Ca
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c3eHYOzQjB54 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:41:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 968FB40217
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 968FB40217
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:41:43 +0000 (UTC)
Received: by mail-yb1-xb34.google.com with SMTP id v38so11566852ybi.3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l0lBZBoRWVZwKeLsg5bhh62sfkY43Fuz7vbWyvz07jo=;
 b=hGw9T6CarZQ/NMBim5LFKd5YTY/o2ySRURtSkju9ltnp+I2dfsm1E743dkEP7vIdI2
 EF0DRNKbp1NoePxE8d03JMmSXIQyxTYmcA6StyWwY4r+YQPVJD8cCVXjq4KFryi4BOBX
 R1mZO/ER1L2SAM2BBGv6AMAXI5Jfk4vSpWXci5dnkjMyWFiBRxV+lukWKp040ydV0UYw
 pi8tg+vw420tIDHBWpl4HD2i87IuVJPBeZxJfEHlBvY0Am4KybIx85T311V7Sc3PDZDd
 4o1lrjtE8IrlXi97SmhrBQzUpnLpRq4Op7bcrYUqg0s8X0We4xxPIjbi6qZfZCCR6FAX
 0Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l0lBZBoRWVZwKeLsg5bhh62sfkY43Fuz7vbWyvz07jo=;
 b=pvAVYO9ERNgf5Qx6KdvOuMAunAmKmXxIlWFFTW2qrAhOd4DedZxtRE7O++6CSY9Kcy
 RxdQmqSGVJwLa2+nCkwEiyM1AQz+kt2u7Pdj3S3BC6kOIpsxWm5pYU9GsRkrCZp6DtId
 Myi6CA1crRthIWVRsy+5J5HEYC2GbiuMmqA17tOLR0KbuYBubPg1/WhVp7mLO7RjNTZg
 wI72gaXdoAmqqFw5foeaNfqUUDrq2ZaLUfg8+URvYE7RdeVYZHqrFVl3k91AkyFEvkJt
 MfLRgBqNdMOoYB/jZxur0FReLzmKOxYGaTeodMA7tospk7Gbx+D5c0xscMp4GWxo19S+
 cPAg==
X-Gm-Message-State: AJIora/+vgRLAsmA/qE6969W/RCIF8/12hYcY61Xssan8tgTyTPvSeju
 7VVpeqVfDQSIOm3URVUdNSkKoZrn6ZLsIHuNaKn1sw==
X-Google-Smtp-Source: AGRyM1vMJc6mshbdVpv82z3JrgHLSlBVD5A4IKCtkqq06YBNSTzatN88O/XMo49PG0TuIqgDUg33Srr26PKhV2f0pQk=
X-Received: by 2002:a25:1f57:0:b0:669:b6fa:167e with SMTP id
 f84-20020a251f57000000b00669b6fa167emr20917137ybf.295.1656423702377; Tue, 28
 Jun 2022 06:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de>
In-Reply-To: <20220623100421.GY1615@pengutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Jun 2022 15:41:30 +0200
Message-ID: <CACRpkdY+MfDHGw4QrFy=A64y7dSrno26vuKbt_AnFbVm9y_hoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
To: sascha hauer <sha@pengutronix.de>
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, ulf hansson <ulf.hansson@linaro.org>,
 eric dumazet <edumazet@google.com>, pavel machek <pavel@ucw.cz>,
 will deacon <will@kernel.org>, Saravana Kannan <saravanak@google.com>,
 kevin hilman <khilman@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 russell king <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
 jakub kicinski <kuba@kernel.org>, paolo abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <lenb@kernel.org>,
 len brown <len.brown@intel.com>, kernel@pengutronix.de,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
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

On Thu, Jun 23, 2022 at 12:05 PM sascha hauer <sha@pengutronix.de> wrote:

> Also consider SoCs in early upstreaming phases
> when the device tree is merged with "dmas" or "hwlock" properties,
> but the corresponding drivers are not yet upstreamed. It's not nice
> to defer probing of all these devices for a long time.

Actually this drives a truck through the entire approach in a way.

It is perfectly legal to have a device tree with dmas specified
but leave them unused in the operating system. DT just describes
what hardware is there, it does not mandate that the OS
implement drivers for all of it.

This approach really needs that the resolution mechanism
is aware of whether:

1. a driver exist for the resource at all so it will eventually resolve

2. if that driver is compiled in or module at all (IS_ENABLED())

3. If the resource should be grabbed early or optionally later
    such as dmas for console UART

Only then can the mechanism work in the generic case.

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
