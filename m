Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099A5C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 08:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B258817A4;
	Wed, 22 Jun 2022 08:48:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B258817A4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T+Y6FO8p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CJwe_vf1iLKo; Wed, 22 Jun 2022 08:48:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9FE9C817A8;
	Wed, 22 Jun 2022 08:47:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FE9C817A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 967A3C0039;
	Wed, 22 Jun 2022 08:47:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC382C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 174A140C83
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 174A140C83
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=T+Y6FO8p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CglEQA2BWJbw for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:47:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9EBB40C75
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com
 [209.85.219.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9EBB40C75
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:47:16 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id t1so28983497ybd.2
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kp81BI1YGsRbTuF4u1pZcpKCs6UI8Y55+4798O1CWVk=;
 b=T+Y6FO8pX4ioyAi81ZJh+H3jqqKbrzeylZwpyEPnZQ2fKXlT+k8zNUyacEsjt5Isvj
 9cQPAjzfg9a1d+IzZv5DgMGCjW1C2owU1i5Z2wFf0ZushObCV4Fgi/MJaklP1XMjKhz7
 XNB0oEghcMbSalXUZ7bJWHduPIDUXmXgr8otxxk5vlGkL88lww2X366J7JHxVXB+fOlL
 VHnTuHLGCpLb/S2eDPJCKCgHjFPBZZ4yI8h40AIngWqoipfSxqA5d/LTpOd8fL1aqhM8
 397Z4g9oWPb9NicHsMVy99lSPW7lwd4qailMrmu1dsK8Y71wF0alGOcCVYQKc2oM55P4
 zGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kp81BI1YGsRbTuF4u1pZcpKCs6UI8Y55+4798O1CWVk=;
 b=VoLrucRkc362GJC+ioE5yh7Eelmzi4aappvVnNuQUCMxAguVn2dvhkI1Hg/uIgi9eO
 mXBvcXxbMV27CzF5Q3Jq1rxw9EiwHSJY3PABqqblhkJmXRi5wyHcdIpiQcu1TVdRNnwa
 aw07KhdlXymc1RsQTyICMdqXCriGoW1tCo5Dat82n5TfvHk/gxqpdEDvU4B6OHUofV7+
 5aFEByDeuHHZl+7E3tx8iFBNodtHQoF2MvOtn/RBaEnm7nittM/X7dubJPu2GJLHeMQZ
 1UHstCuyrLp3DQ4t0O2NyV5m++qOaFnY0sY2Bfr/2VJIUXmtIMKZPiZpxMZLGhv+XlIl
 4ggA==
X-Gm-Message-State: AJIora/Fb2Gf+olMNVu1Mh7u0lh4bG/1OGFfRF0wDp8NH95T7UQbZTqV
 HkYn4RuU6Y3FLejPPgaOsvqGh2f/vTOGVaiceIpxpw==
X-Google-Smtp-Source: AGRyM1skbX81eTWmx6oS9meEepf1lQ4R1N0UrNlFhHcSYFyL8Map6cXN+y6MD6tuATRRVquGHtXlFiJYYBINvtWwFds=
X-Received: by 2002:a25:7255:0:b0:668:a372:b433 with SMTP id
 n82-20020a257255000000b00668a372b433mr2433058ybc.626.1655887452923; Wed, 22
 Jun 2022 01:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-8-saravanak@google.com>
 <20220622074756.GA1647@pengutronix.de>
In-Reply-To: <20220622074756.GA1647@pengutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Jun 2022 10:44:01 +0200
Message-ID: <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] driver core: Set fw_devlink.strict=1 by default
To: Sascha Hauer <sha@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Kevin Hilman <khilman@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kernel-team@android.com,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel@pengutronix.de,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jun 22, 2022 at 9:48 AM Sascha Hauer <sha@pengutronix.de> wrote:

> This patch has the effect that console UART devices which have "dmas"
> properties specified in the device tree get deferred for 10 to 20
> seconds. This happens on i.MX and likely on other SoCs as well. On i.MX
> the dma channel is only requested at UART startup time and not at probe
> time. dma is not used for the console. Nevertheless with this driver probe
> defers until the dma engine driver is available.
>
> It shouldn't go in as-is.

This affects all machines with the PL011 UART and DMAs specified as
well.

It would be best if the console subsystem could be treated special and
not require DMA devlink to be satisfied before probing.

It seems devlink is not quite aware of the concept of resources that are
necessary to probe vs resources that are nice to have and might be
added after probe. We need a strong devlink for the first category
and maybe a weak devlink for the latter category.

I don't know if this is a generic hardware property for all operating
systems so it could be a DT property such as dma-weak-dependency?
Or maybe compromize and add a linux,dma-weak-dependency;
property?

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
