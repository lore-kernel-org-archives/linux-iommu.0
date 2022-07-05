Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6886AC433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 09:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6E5281DCA;
	Tue,  5 Jul 2022 09:17:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6E5281DCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HsYsnH_Sra3Z; Tue,  5 Jul 2022 09:17:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4571823DD;
	Tue,  5 Jul 2022 09:17:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4571823DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB84C0032;
	Tue,  5 Jul 2022 09:17:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03AA1C002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 09:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3CF960674
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 09:17:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3CF960674
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SH6TWzlBz3p8 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 09:17:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73A0A6066D
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73A0A6066D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 09:17:53 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id 15so5503551vko.13
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 02:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8zMI7hf4Fvo1gks6+DJgLH8iax3WJOoRMgpJl0b4G5s=;
 b=hLEiuwX0pw+Bru04A6KibnUBeQFd9aPy8UexLPAgA0xPO3qlj3MBlqkT3fGa7hW5Wy
 8Mt4P8EMR73Cee4MNdvbDs/3BuS1k5rA2/CmS+tZZZ/9A1q6EPn5h+2QSoFcdeDEVpUx
 8zJp0faEbTqF3IfU1jE9p9CccnJAbYBOlJN8f8ofh0SwuruTfR6jVyn+kX5bm8ZjzM51
 JZCanY2SV/v/AhvWqADturdaFq10qusbKZDXNfwj69VbN1Gud6b/MltgLmBW4mFNSLdK
 gJTkXw8EffD+gNakQireFuETq4/whH3ic7jKiHnpeuL2CI8iH7GddD8gjwSxSNDiEfPz
 w3Tw==
X-Gm-Message-State: AJIora8ztRxRqJD2ZXeiT9iA8+mDsevmC7QEHrwblW8O4ArgHpDG61hJ
 s8Oh+tP6dhWz3nCCviEZGsj5/17wq1o3wQ==
X-Google-Smtp-Source: AGRyM1uP6Zo0lNBhanyUhWopN3H53u/XAdtJfaYQ32fPsJfxz99tTWnB/ASnaNxW3sVK8JJzRJU7AA==
X-Received: by 2002:a1f:3055:0:b0:373:f1e0:aa57 with SMTP id
 w82-20020a1f3055000000b00373f1e0aa57mr3208172vkw.36.1657012672087; 
 Tue, 05 Jul 2022 02:17:52 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com.
 [209.85.222.44]) by smtp.gmail.com with ESMTPSA id
 a4-20020a9f3744000000b0038290663410sm2689750uae.13.2022.07.05.02.17.51
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Jul 2022 02:17:51 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id c7so4358248uak.1
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 02:17:51 -0700 (PDT)
X-Received: by 2002:a81:9209:0:b0:31c:b1b7:b063 with SMTP id
 j9-20020a819209000000b0031cb1b7b063mr6920267ywg.383.1657012293585; Tue, 05
 Jul 2022 02:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-4-saravanak@google.com>
In-Reply-To: <20220601070707.3946847-4-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Jul 2022 11:11:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWo_wRwV-i_iyTxVnEsf3Th9GBAG+wxUQMQGnw1t2ijTg@mail.gmail.com>
Message-ID: <CAMuHMdWo_wRwV-i_iyTxVnEsf3Th9GBAG+wxUQMQGnw1t2ijTg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] net: mdio: Delete usage of
 driver_deferred_probe_check_state()
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>, Len Brown <len.brown@intel.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
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

Hi Saravana,

On Wed, Jun 1, 2022 at 2:44 PM Saravana Kannan <saravanak@google.com> wrote:
> Now that fw_devlink=on by default and fw_devlink supports interrupt
> properties, the execution will never get to the point where
> driver_deferred_probe_check_state() is called before the supplier has
> probed successfully or before deferred probe timeout has expired.
>
> So, delete the call and replace it with -ENODEV.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch, which is now commit f8217275b57aa48d ("net:
mdio: Delete usage of driver_deferred_probe_check_state()") in
driver-core/driver-core-next.

Seems like I missed something when providing my T-b for this series,
sorry for that.

arch/arm/boot/dts/r8a7791-koelsch.dts has:

    &ether {
            pinctrl-0 = <&ether_pins>, <&phy1_pins>;
            pinctrl-names = "default";

            phy-handle = <&phy1>;
            renesas,ether-link-active-low;
            status = "okay";

            phy1: ethernet-phy@1 {
                    compatible = "ethernet-phy-id0022.1537",
                                 "ethernet-phy-ieee802.3-c22";
                    reg = <1>;
                    interrupt-parent = <&irqc0>;
                    interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
                    micrel,led-mode = <1>;
                    reset-gpios = <&gpio5 22 GPIO_ACTIVE_LOW>;
            };
    };

Despite the interrupts property, &ether is now probed before irqc0
(interrupt-controller@e61c0000 in arch/arm/boot/dts/r8a7791.dtsi),
causing the PHY not finding its interrupt, and resorting to polling:

    -Micrel KSZ8041RNLI ee700000.ethernet-ffffffff:01: attached PHY
driver (mii_bus:phy_addr=ee700000.ethernet-ffffffff:01, irq=185)
    +Micrel KSZ8041RNLI ee700000.ethernet-ffffffff:01: attached PHY
driver (mii_bus:phy_addr=ee700000.ethernet-ffffffff:01, irq=POLL)

Reverting this commit, and commit 9cbffc7a59561be9 ("driver core:
Delete driver_deferred_probe_check_state()") fixes that.

> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -47,9 +47,7 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
>          * just fall back to poll mode
>          */
>         if (rc == -EPROBE_DEFER)
> -               rc = driver_deferred_probe_check_state(&phy->mdio.dev);
> -       if (rc == -EPROBE_DEFER)
> -               return rc;
> +               rc = -ENODEV;
>
>         if (rc > 0) {
>                 phy->irq = rc;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
