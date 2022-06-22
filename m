Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4C1C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 22:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6A3C41A24;
	Wed, 22 Jun 2022 22:31:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6A3C41A24
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=NebdBOf6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CR0KFV-cI91T; Wed, 22 Jun 2022 22:31:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C624C418F5;
	Wed, 22 Jun 2022 22:31:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C624C418F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B31EC0039;
	Wed, 22 Jun 2022 22:31:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8EE4C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 22:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B391F6131A
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 22:31:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B391F6131A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=NebdBOf6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w7GF41NYIfNw for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 22:31:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0F7E61302
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0F7E61302
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 22:31:00 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-317a66d62dfso116490157b3.7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9SfIkHxS+Q1Jb8k0oSMqRlf7MlpWHzDTC+soyTtijyM=;
 b=NebdBOf6fdS4nX2gfyfe8m1T6/C9zAE+3VIuCNVBM6MPWjXuoJzdqqPsTsUAR6pfvG
 xA4MVTApPXt06pwHKnuxwV1EYeC4UcXbEXYkkIdwQyxlj/bO1PmEbgnS2x2hgpF3lHP4
 h4UqwgdlMJTc14qMEg5zU9/3ErEGdK4mjOqA8Eftkugl+g7j+weQvtGSUWigyARlr1O/
 Bs+mhgd3gJiFyzFiiuJ+PVCKt6Z+Vtj9jRHkqKHTlRfColtigSBwNJxsrLimrFlpRpDJ
 QixEZsgjs01NM5W7QvGFsEB3Zd0eeS22AhTr5GnnlvMKF4SYTr1gGHBVfrUyl3Ptpb/A
 t32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9SfIkHxS+Q1Jb8k0oSMqRlf7MlpWHzDTC+soyTtijyM=;
 b=5NOnMrXEAhXLhEUMtMBsUQBevQUiNrvlpoNxRhw8A/Fj4HDC8FFUeE6tWv5ER/gl5S
 3v/QA1hFbwCX8a/p93nat2owheKZCCsMrRuzqMFA4vJncNzPgxKPTjUdlnv/08DuzqJT
 6IGre6Rmzex9p85+eIBCiF5k9SNxCAjkfbArbLRqi8yr+xV6lCdz05fZUP9+68NkZo77
 gvzVzN/UbJKX+YJWiusO5Hd5ay03xOtxhq1UMk13hZ0T7ocQSkDQ95JuLjnOGZdzaG4y
 ImNUpWvtaeXPIA0MLolOom/eb8yiPYi6jg5pYBNBiWwXPxoX6ShammF+V+W56C4XeZai
 QOYg==
X-Gm-Message-State: AJIora+DUuGAvpL5nbV8LhF73+1CiRtWIgCI1QhXwTjxS1603gxbeGrc
 zce3beHR8g+/nRJCPMsz0y0yXiPQlt3kmqlKMEo0mw==
X-Google-Smtp-Source: AGRyM1uYQIJJIqU5tgV6IO3uAtRp3fBa6488p3xRR/8VoSm4ObswB9eZF/y0HTd/1fbTAGXMYHZo8GPW9b+ZXRnH0VI=
X-Received: by 2002:a81:8486:0:b0:317:a4af:4e0a with SMTP id
 u128-20020a818486000000b00317a4af4e0amr6985709ywf.455.1655937059385; Wed, 22
 Jun 2022 15:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-8-saravanak@google.com>
 <20220622074756.GA1647@pengutronix.de>
 <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
 <CAGETcx_qm7DWbNVTLfF9jTgGA8uH8oAQzbPcMDh4L6+5mdRFog@mail.gmail.com>
 <CAGETcx8i9R51T-mGuV9_LUz-GXDCncpRWQ1Rj_7i2JrvCttq3w@mail.gmail.com>
In-Reply-To: <CAGETcx8i9R51T-mGuV9_LUz-GXDCncpRWQ1Rj_7i2JrvCttq3w@mail.gmail.com>
Date: Wed, 22 Jun 2022 15:30:23 -0700
Message-ID: <CAGETcx9XnyceCRBhgQc_YAYyJRca_Q-GPD8sh0cgCCuohzG16A@mail.gmail.com>
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

On Wed, Jun 22, 2022 at 1:35 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Jun 22, 2022 at 12:40 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Jun 22, 2022 at 1:44 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Wed, Jun 22, 2022 at 9:48 AM Sascha Hauer <sha@pengutronix.de> wrote:
> > >
> > > > This patch has the effect that console UART devices which have "dmas"
> > > > properties specified in the device tree get deferred for 10 to 20
> > > > seconds. This happens on i.MX and likely on other SoCs as well. On i.MX
> > > > the dma channel is only requested at UART startup time and not at probe
> > > > time. dma is not used for the console. Nevertheless with this driver probe
> > > > defers until the dma engine driver is available.
> >
> > FYI, if most of the drivers are built in, you could set
> > deferred_probe_timeout=1 to reduce the impact of this (should drop
> > down to 1 to 2 seconds). Is that an option until we figure out
> > something better?
> >
> > Actually, why isn't earlyconsole being used? That doesn't get blocked
> > on anything and the main point of that is to have console working from
> > really early on.
> >
> > > >
> > > > It shouldn't go in as-is.
> > >
> > > This affects all machines with the PL011 UART and DMAs specified as
> > > well.
> > >
> > > It would be best if the console subsystem could be treated special and
> > > not require DMA devlink to be satisfied before probing.
> >
> > If we can mark the console devices somehow before their drivers probe
> > them, I can make fw_devlink give them special treatment. Is there any
> > way I could identify them before their drivers probe?
> >
> > > It seems devlink is not quite aware of the concept of resources that are
> > > necessary to probe vs resources that are nice to have and might be
> > > added after probe.
> >
> > Correct, it can't tell them apart. Which is why it tries its best to
> > enforce them, get most of them ordered properly and then gives up
> > enforcing the rest after deferred_probe_timeout= expires. There's a
> > bit more nuance than what I explained here (explained in earlier
> > commit texts, LPC talks), but that's the gist of it. That's what's
> > going on in this case Sascha is pointing out.z
> >
> > > We need a strong devlink for the first category
> > > and maybe a weak devlink for the latter category.
> > >
> > > I don't know if this is a generic hardware property for all operating
> > > systems so it could be a DT property such as dma-weak-dependency?
> > >
> > > Or maybe compromize and add a linux,dma-weak-dependency;
> > > property?
> >
> > The linux,dma-weak-dependency might be an option, but then if the
> > kernel version changes and we want to enforce it because we now have a
> > dma driver (not related to Shasha's example) support, then the
> > fw_devlink still can't enforce it because of that property. But maybe
> > that's okay? The consumer can try to use dma and defer probe if it
> > fails?
> >
> > Another option is to mark console devices in DT with some property and
> > we can give special treatment for those without waiting for
> > deferred_probe_timeout= to expire.
>
> Heh, looks like there's already a property for that: stdout-path.
>
> Let me send a series that'll use that to give special treatment to
> console devices.

Here's the fix.
https://lore.kernel.org/lkml/20220622215912.550419-1-saravanak@google.com/

Sascha, can you give it a shot?

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
