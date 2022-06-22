Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFA1C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 19:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A59041A0C;
	Wed, 22 Jun 2022 19:41:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A59041A0C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=G8X3vA4e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oPHxSmtm26-O; Wed, 22 Jun 2022 19:41:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 221CF4190F;
	Wed, 22 Jun 2022 19:41:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 221CF4190F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7008C0032;
	Wed, 22 Jun 2022 19:41:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D61DC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 19:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57BF760773
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 19:41:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57BF760773
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=G8X3vA4e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jIDys-cpkxL1 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 19:40:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1167E60BE3
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1167E60BE3
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 19:40:58 +0000 (UTC)
Received: by mail-yb1-xb34.google.com with SMTP id l11so31922076ybu.13
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=639SSWBKWeFVnHTVsnIzN/TZ7k1h9fmNPATWBIChIyw=;
 b=G8X3vA4e0jP9t9yyHPeLuRESdA24DMIkCfPu5Bfly53+tjcz8sJhQ87fS6AXPhrj4D
 Un0+CsiNBNRkm4IMgtVYtfnz51k0ntH+Z/3iFO1RMOODYIqV/UBhtGLiE6uMxkRDcJnF
 nBzwU3BLS98dR46DcTYYm16g7QD+8x51mtncSUWBF2CT0gxsflBQY1tA+debjqlmAe/q
 QlIdhuNK1QLuPaAil54LAi0aU9ZBoGbjoKHY+saslronaFmEGNRD4FcpKtnLjn9L/jCM
 gkuC3dDE+vRq/hUVUcyd3LzadOyq92dTU7kKgQlsx31ixW959JxLJACf7pjhr7yqWvBy
 3Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=639SSWBKWeFVnHTVsnIzN/TZ7k1h9fmNPATWBIChIyw=;
 b=yMcXVGYNPx9V3btSHj348nQz4TwJjJEUuVo0uUuCQDmqmOlpIJ158U1xpTo0XyH9OR
 QU15KI/Qon2NFJY+lVa4VsOXnLhnkG7CrzmN+a/fl2+dzTfHzo/GCaQRki3XfUr7YUvI
 byKfc9Ikx9H2SpuJN0ZjXOmM2AomG8A+XDAKngo+R0AsOEvXQwT7jyD1zJO3Bih2yiwA
 2At1StnMyRDqU6Sgjieei4AwSOf/2h9qFymyrrmjD4TsSvXWcvASa+qy0ObCAfGeyEg8
 52efu8yzQPRT28jzuwtS2imcmrP6CDZJh7RDrUVJ+Kb47ncdFQh/mKDPpQdQcJ55CQIB
 p2MA==
X-Gm-Message-State: AJIora9xu+na6RqZ95kcGBLSL6cHooFEj5PbST96nLwXHWz+NIAAo6WH
 NlN7eF/YrmlOaerPpLGT2kaZz2TS5GAq1mwJj6zl/A==
X-Google-Smtp-Source: AGRyM1uGAbZ+vgElx+1b7AwZLGy2A0tJFHcsPRwmnxA3B57ZLQRr7LNkm5trT+iojrHOETV01ceBq2pLIkgfpdHeMcA=
X-Received: by 2002:a25:cad1:0:b0:668:69b5:bbba with SMTP id
 a200-20020a25cad1000000b0066869b5bbbamr5789800ybg.352.1655926857785; Wed, 22
 Jun 2022 12:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-8-saravanak@google.com>
 <20220622074756.GA1647@pengutronix.de>
 <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
In-Reply-To: <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
Date: Wed, 22 Jun 2022 12:40:21 -0700
Message-ID: <CAGETcx_qm7DWbNVTLfF9jTgGA8uH8oAQzbPcMDh4L6+5mdRFog@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] driver core: Set fw_devlink.strict=1 by default
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Sascha Hauer <sha@pengutronix.de>, Kevin Hilman <khilman@kernel.org>,
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jun 22, 2022 at 1:44 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jun 22, 2022 at 9:48 AM Sascha Hauer <sha@pengutronix.de> wrote:
>
> > This patch has the effect that console UART devices which have "dmas"
> > properties specified in the device tree get deferred for 10 to 20
> > seconds. This happens on i.MX and likely on other SoCs as well. On i.MX
> > the dma channel is only requested at UART startup time and not at probe
> > time. dma is not used for the console. Nevertheless with this driver probe
> > defers until the dma engine driver is available.

FYI, if most of the drivers are built in, you could set
deferred_probe_timeout=1 to reduce the impact of this (should drop
down to 1 to 2 seconds). Is that an option until we figure out
something better?

Actually, why isn't earlyconsole being used? That doesn't get blocked
on anything and the main point of that is to have console working from
really early on.

> >
> > It shouldn't go in as-is.
>
> This affects all machines with the PL011 UART and DMAs specified as
> well.
>
> It would be best if the console subsystem could be treated special and
> not require DMA devlink to be satisfied before probing.

If we can mark the console devices somehow before their drivers probe
them, I can make fw_devlink give them special treatment. Is there any
way I could identify them before their drivers probe?

> It seems devlink is not quite aware of the concept of resources that are
> necessary to probe vs resources that are nice to have and might be
> added after probe.

Correct, it can't tell them apart. Which is why it tries its best to
enforce them, get most of them ordered properly and then gives up
enforcing the rest after deferred_probe_timeout= expires. There's a
bit more nuance than what I explained here (explained in earlier
commit texts, LPC talks), but that's the gist of it. That's what's
going on in this case Sascha is pointing out.z

> We need a strong devlink for the first category
> and maybe a weak devlink for the latter category.
>
> I don't know if this is a generic hardware property for all operating
> systems so it could be a DT property such as dma-weak-dependency?
>
> Or maybe compromize and add a linux,dma-weak-dependency;
> property?

The linux,dma-weak-dependency might be an option, but then if the
kernel version changes and we want to enforce it because we now have a
dma driver (not related to Shasha's example) support, then the
fw_devlink still can't enforce it because of that property. But maybe
that's okay? The consumer can try to use dma and defer probe if it
fails?

Another option is to mark console devices in DT with some property and
we can give special treatment for those without waiting for
deferred_probe_timeout= to expire.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
