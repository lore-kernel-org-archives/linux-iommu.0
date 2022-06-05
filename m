Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3CBCCA483
	for <iommu@archiver.kernel.org>; Sun,  5 Jun 2022 03:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E61144047C;
	Sun,  5 Jun 2022 03:45:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 725kXRBHd6Ph; Sun,  5 Jun 2022 03:45:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D10B140022;
	Sun,  5 Jun 2022 03:45:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1A81C0032;
	Sun,  5 Jun 2022 03:45:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34E3DC002D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1510241701
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PO5wbLAri5GU for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jun 2022 03:45:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18B0A416EC
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:45:45 +0000 (UTC)
Received: by mail-yb1-xb2b.google.com with SMTP id i11so20235404ybq.9
 for <iommu@lists.linux-foundation.org>; Sat, 04 Jun 2022 20:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u927xqlaG4+M+ycErvXLDv/hJjpEjGMZ02h0/MOu0dE=;
 b=ehj6NFZQv8BDVJJlJnUvvcDSXp9LpCqfvnmr5AXmU20WA3jQqH6sOl5be/5V6xWW+t
 i6e5y2mRwk2MV3UEKvTcTRXkOUeJZYrrczsFw+5q64C+0kLefCc4fK+oOEk6SmfB4YBP
 kkamPTLmuhJB011WNvofNqiRM5wg40Y+7zX0rei48rYtP3kEkpky6NpnOkPYqmuK7nYN
 oTPwGWjuof4MrzV/WUiIydLaUqeiDYDhhmpboRu0PgShxoo9F1xB2iZ69uUQJ5kfrYWy
 Jnwt0lMMEEKuEqbAm6O/urhy4l7obV+Pmh17DWGaW5a3DJaZVV3+PbaTSg8l6KGLEMX4
 v7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u927xqlaG4+M+ycErvXLDv/hJjpEjGMZ02h0/MOu0dE=;
 b=kGV4f0jxPz+GN+aMJxukN5cVief1lhWCFkgYwiSshHhtnrPhAiZSjeg7hx5FZT0Z/1
 pvqwYbB3ELnT4+BTPGKOvZXoFpsYQkLibMsHN7iVXQPFFpv5ekWG4LOE8myAmNhd9kdR
 aeZCD/AEQuGb7U3xrkOQ78HK94zu46aaVWhXbH6v7JE4vEsG/sCBOczN2H6KK3SctoCs
 mR3fP0qvGoFdlUPM2S9JDSiN76BiHb4SxiBxTxHCBwRXWOyatB1GAvL5RP7tlzSWhpCY
 72ji5JymktywxQbMyPuaaL6SXyw8Du/to/XE0vis5Ygmca2f8mdsTvHdGYNLSGsgwhjs
 S1zg==
X-Gm-Message-State: AOAM533uG7GRrR1oELItBC/2elarFLa8qBl/RUMQkwUpRvVBPKbU6WyA
 ZI1D2zuqPqlddjiW46Htc2e1ukO2ouYCQHu6619NIQ==
X-Google-Smtp-Source: ABdhPJwXtoaNM32RInd5ZTKb8WwYpukxL2Izf1ybTZRPqnFQCNw5sfzLXMWMQyk9Vor1Gw8PdsE5l0dAUAlKBxb7VNQ=
X-Received: by 2002:a05:6902:1009:b0:660:3a01:84eb with SMTP id
 w9-20020a056902100900b006603a0184ebmr19585298ybt.80.1654400744733; Sat, 04
 Jun 2022 20:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <YpSFBNfGDpy3rqEV@linutronix.de>
In-Reply-To: <YpSFBNfGDpy3rqEV@linutronix.de>
Date: Sat, 4 Jun 2022 20:45:09 -0700
Message-ID: <CAGETcx9wya9L2voMAFBc04LMKcEY97kwVCgdt0MDqU8cjoQKMw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/9] deferred_probe_timeout logic clean up
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 John Stultz <jstultz@google.com>, Pavel Machek <pavel@ucw.cz>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 Daniel Scally <djrscally@gmail.com>, iommu@lists.linux-foundation.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org,
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

On Mon, May 30, 2022 at 1:49 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-05-26 01:15:39 [-0700], Saravana Kannan wrote:
> > Yoshihiro/Geert,
> Hi Saravana,
>
> > If you can test this patch series and confirm that the NFS root case
> > works, I'd really appreciate that.
>
> The two patches you sent earlier, plus this series, plus
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7ff7fbb006431..829d9b1f7403f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1697,8 +1697,6 @@ static int fw_devlink_may_probe(struct device *dev, void *data)
>   */
>  void __init fw_devlink_unblock_may_probe(void)
>  {
> -       struct device_link *link, *ln;
> -
>         if (!fw_devlink_flags || fw_devlink_is_permissive())
>                 return;
>
> and it compiles + boots without a delay.

Thanks for testing! I missed your reply until now and I ended up
sending out a v2 a few days back. That's a much better series IMO
because it only temporarily ignores dependencies and only when NFS
root mounting might not work. If you can test that too (and it
shouldn't have the useless variable), I'd appreciate it.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
