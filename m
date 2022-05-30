Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A81C433F5
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 09:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12A4560AFC;
	Mon, 30 May 2022 09:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wf0ia_l2p1rH; Mon, 30 May 2022 09:47:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ECF1561159;
	Mon, 30 May 2022 09:47:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD86FC0032;
	Mon, 30 May 2022 09:47:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42D90C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CF4583F0D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:47:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dbOfFv2xhvmf for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 09:47:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5842483F0A
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:47:21 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id rq11so19765354ejc.4
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/k2m83LaODmcLsyS0dbBoJk+VKnEiUhqE8c6BRPwNpA=;
 b=HEdtIu9h1Ee4llxxfLUHdT6WXTT7YVh7HuJ1UWwgpaAZEzYcK8Kt18Rc0y6hhxh/pk
 gNEh0cjdDf/DymaC3VMDJfzt8hACMMSArRNFzvgV2rASP/QOIxu5SVhVDBmuBaF6jSqH
 pE7Z+UNUl0L+YpcyxdWHlt+wnBHwJZV6FpL32JVe2MnfNBn8UF1zu7hi0PqUJB5JrUta
 PzgzVuMmyO9cQBNDseiGyFnSevNpMoE0l5EdZjqKzsaGAyssfHObZ+KUH6ErxYptI92w
 d+o7sRvi1EM4ocHQV9T1yTo01whLdcagvrS5NvenSKkHgxAUoXpqgSIjqaOGUKnRw74d
 T+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/k2m83LaODmcLsyS0dbBoJk+VKnEiUhqE8c6BRPwNpA=;
 b=dsxBDrWGMNhYWXlauKPu1y+FFCldx7IOKCKoMqZSW7K9mNkwvZWfl3d73bXJGWUq0H
 Vp3tghBcN5Upq0p7sVFKXy9352tGA++AWNK6PTRiQ0xrESz3uQIZLortYrUSGJNHcLSg
 omIb3OKCLvfuUyHVy+d/p/FtHaj93AOx82uDDw4TZD+EJE2rew8itK7Az+ITVrPjgUAH
 BGSTTy4YgeaerNXMvcvKbpprHVyKCGRGc2ZIMW04dkQgdtsiziruS8xRmV8+F7hUwPLe
 oIKjo89bR67NcRQJbAd+4N0RRrhO7Y5Rz5c194NWdkAI52UllJFkHM1EeepgPrw8ZioZ
 tBXw==
X-Gm-Message-State: AOAM532f8jyVpa2TRsfEwMf/Pud+/LOSW88LDV04EWU4eaz2uXIAutoj
 0m4fwEtuq64kOdpqKomimMyIL9xJa26nxQEJO6M=
X-Google-Smtp-Source: ABdhPJz2Y4PPvobMreDaaaGYBcFdlzgaDp1D8UrIIx2/xRRkK7/L2BM9dOFFBRp5uNmzREpsNBcvOr4GVqLWfEZBHGw=
X-Received: by 2002:a17:907:6e04:b0:6f4:d6f3:c72a with SMTP id
 sd4-20020a1709076e0400b006f4d6f3c72amr47585054ejc.636.1653904039317; Mon, 30
 May 2022 02:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <20220526081550.1089805-8-saravanak@google.com>
In-Reply-To: <20220526081550.1089805-8-saravanak@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 30 May 2022 11:46:43 +0200
Message-ID: <CAHp75VcJRfQO6oJpVUoGK4JQpr3Wbff9vgkm8+q8fn8cxohQug@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] driver core: Add fw_devlink_unblock_may_probe()
 helper function
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 John Stultz <jstultz@google.com>, Pavel Machek <pavel@ucw.cz>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Android Kernel Team <kernel-team@android.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Len Brown <lenb@kernel.org>,
 Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev <netdev@vger.kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, May 26, 2022 at 1:22 PM Saravana Kannan <saravanak@google.com> wrote:
>
> This function can be used during the kernel boot sequence to forcefully
> override fw_devlink=on and unblock the probing of all devices that have
> a driver.
>
> It's mainly meant to be called from late_initcall() or
> late_initcall_sync() where a device needs to probe before the kernel can
> mount rootfs.

...

> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 9a81c4410b9f..0770edda7068 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -13,6 +13,7 @@
>  #include <linux/list.h>
>  #include <linux/bits.h>
>  #include <linux/err.h>
> +#include <linux/init.h>
>
>  struct fwnode_operations;
>  struct device;
> @@ -199,5 +200,6 @@ extern bool fw_devlink_is_strict(void);
>  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
>  void fwnode_links_purge(struct fwnode_handle *fwnode);
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> +void __init fw_devlink_unblock_may_probe(void);

I don't think you need init.h and __init here. Important is that you
have it in the C-file. Am I wrong?

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
