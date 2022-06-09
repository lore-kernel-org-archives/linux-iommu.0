Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3DFCCA473
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 19:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED38F41D1A;
	Thu,  9 Jun 2022 19:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s-iEYsvWuXMQ; Thu,  9 Jun 2022 19:29:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3C8B141D0F;
	Thu,  9 Jun 2022 19:29:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5BFC0032;
	Thu,  9 Jun 2022 19:29:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B3F8C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 19:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA5CA840B3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 19:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TzuDS36zcs0D for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 19:29:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A23684070
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 19:29:48 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-31332df12a6so103840767b3.4
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jun 2022 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HbcNyn+HuFJHLYrnJ6EuEvt+66n5lvubcLNAe9RjZOU=;
 b=AFugph41ubSXHoryjcn9zN9/Y2cQG8LpkjnjP7KA/6gxAEo6tx7yw+owOJLQJ7GRdj
 AKgvhnyfINe6Fm+FiL9XL4L81yzjkr7NGdTeY4zz7GQp6mZQ6gytLnvPlH7WtcUin1GU
 yx1uwAh7bMyGuUJDZbETE6j2RxETbqyAMcxTWH1EfgrXJ06AbU8ZHlLM8itKzwxtatsY
 n3bCV01x/wF5UQbMprXgWXgMUnaYlBapVZbq25diSf9SnVGY8Pea0V2ZRfioG7ONZO2r
 VBRjo4a+bwVjXI+yKamT9typkG7zIM8JryiY8d8QmOmviHIjZI3x52miRKJ9ZEzfG5XI
 483A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HbcNyn+HuFJHLYrnJ6EuEvt+66n5lvubcLNAe9RjZOU=;
 b=Pre9xICMXwlQk9MesliUIAwrbJgA/9NCEk8250kMPx3F1mnFIVBSidjLEB5rU0gRps
 vu8Var5GxpkydOO1VNSResCPq1yyPVmhwQf3PlMrcEkyWu3SpItokhAneeSxhCTGlSaw
 ZAHKsAnUcJTHAhixoOMOrm0UZNQHGLyZc/IoLu9lm1ZRmokLwkdcUEWOVDovo1Nx9ieo
 Az5APq+HF3PBgaskaGNa7nqKSN+sTGRQwp1GIWUow+We5a8glTIrAuff2fwKZwF0o5vm
 lyM+Ib2lJlOH37jNyL2YwcU+sfB9KIKRKmm/benqIScuDZsIEhMoG0TZfNRVIak3hWa5
 WnDg==
X-Gm-Message-State: AOAM530Nh48EufgorNit7aT7d5pBCi1IkqLVdRTBo0XKZVV3eFlbQFZD
 OSgPGZ8u3uIHU1LM7cmLW8cdi5rtcH0gw6v+0zpk8g==
X-Google-Smtp-Source: ABdhPJyTAoRSU+Qa4z02/PWmP9RT6ooOnsyoWThxzzVkk4VpdwuVCgxr8qWarGWvAQ0mS4kZlsB0Jx5s9qGrxlCEhf0=
X-Received: by 2002:a81:830f:0:b0:313:3918:5cf with SMTP id
 t15-20020a81830f000000b00313391805cfmr16723753ywf.126.1654802987678; Thu, 09
 Jun 2022 12:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com>
 <CAPDyKFpZTmt71LgQ9vNE4_iRff-OBkDWkHrc7y9zQ7o_Z_UYFA@mail.gmail.com>
In-Reply-To: <CAPDyKFpZTmt71LgQ9vNE4_iRff-OBkDWkHrc7y9zQ7o_Z_UYFA@mail.gmail.com>
Date: Thu, 9 Jun 2022 12:29:11 -0700
Message-ID: <CAGETcx95P3iPOJs+qm9tNXHschbhf3LP0T0gwm_v6m2AOhzhDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
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

On Thu, Jun 9, 2022 at 4:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 1 Jun 2022 at 09:07, Saravana Kannan <saravanak@google.com> wrote:
> >
> > Now that fw_devlink=on by default and fw_devlink supports
> > "power-domains" property, the execution will never get to the point
> > where driver_deferred_probe_check_state() is called before the supplier
> > has probed successfully or before deferred probe timeout has expired.
> >
> > So, delete the call and replace it with -ENODEV.
>
> With fw_devlink=on by default - does that mean that the parameter
> can't be changed?
>
> Or perhaps the point is that we don't want to go back, but rather drop
> the fw_devlink parameter altogether when moving forward?

Good question. For now, keeping fw_devlink=off and
fw_devlink=permissive as debugging options that I can ask people to
try if some probe is getting blocked.

Or maybe if some ultra low memory use case wants to avoid create
device links, fwnode links, etc and can build everything in and have
init/probe happen in the right order.

But in the long run, I see a strong possibility for
fw_devlink=off/permissive being removed. I'd still want to keep it for
implementing =rpm where it'd also automatically enable PM runtime
tracking, but I don't understand that well enough yet to do it by
default.

> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Just a minor nitpick below. Nevertheless, feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

>
> > ---
> >  drivers/base/power/domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 739e52cd4aba..3e86772d5fac 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> >                 mutex_unlock(&gpd_list_lock);
> >                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
> >                         __func__, PTR_ERR(pd));
> > -               return driver_deferred_probe_check_state(base_dev);
>
> Adding a brief comment about why -EPROBE_DEFER doesn't make sense
> here, would be nice.

Will do once all the reviews comeout/when I send v3.

I'm thinking something like:
/* fw_devlink will take care of retrying for missing suppliers */

-Saravana

>
> > +               return -ENODEV;
> >         }
> >
> >         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
>
> Kind regards
> Uffe
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
