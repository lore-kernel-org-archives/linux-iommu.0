Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4300CC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 16:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B809B4060C;
	Tue, 28 Jun 2022 16:17:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B809B4060C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=svPPiUXm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6aeaWeo76EUT; Tue, 28 Jun 2022 16:17:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1635402F2;
	Tue, 28 Jun 2022 16:17:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1635402F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C3B1C0039;
	Tue, 28 Jun 2022 16:17:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C347DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 16:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E286408E6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 16:17:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E286408E6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=svPPiUXm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a5hKndTtpLqY for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 16:17:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F4054408E3
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F4054408E3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 16:17:01 +0000 (UTC)
Received: by mail-yb1-xb29.google.com with SMTP id v185so13532155ybe.8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a+P6wSeN2x0ZvD2/JjzHKyqS9/n/5A6tY5jiA6Lhnb8=;
 b=svPPiUXmjLu4A2+b3rJgoCqrzxWVmAH7KXTvVP4AwaLTDrIN9AN3BtNG2XiV2ycJ8x
 6Y9oMX5BQlCl6K+KL9J1KxqNRcb1MdTb/c18nJgwvmc5rVyOe8EKUyj+KrCbNC70iJoL
 OlJOsi9x5Scvw9W8cP8d/OYBAk6luTiA/PE8w/jzj7tOJ+ICpHFzyCnfh2xqrRn3YVLo
 nvgpT4pJzONw4hikJOgq/y8DRHjrG2lOfrc2hEWRc02ovhuxlfgkK9/gOnTwVGME5DOU
 4AXMX65QfUYiz76GEkrT/465op3M51kj45IkhJmeQobRe1+J32FVHZumFFaJBd9Gan88
 /wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a+P6wSeN2x0ZvD2/JjzHKyqS9/n/5A6tY5jiA6Lhnb8=;
 b=4L5W2yHquBwliLckng9+YGCA65iyRO71SMwlzQtNRFXOrmwXerBR8yN6dpqGQBqgnN
 f/3UHVwEmgHbgN7jSCEcF6BQY/x1de8pMFooIhgHTPMdUD34L/Vna/jcvnCTzuk1MDVE
 yAbpBOQ9FCWnFySlaLE/jTUXuqCPAO/+pQKWZXEUFIvlXiwAvYs+WDiMfpuunpJDzt+l
 F+fU6AZx5MMnr9wkMrFIGewmtaDGXW5KpsSz+hq4AXjv1rz4pEK8DAe954qHahWeSwO4
 IN6JYv8mJMvUkFlfVnX79nXOgr/p7g6csSHwucuhoLIZ6v94PgnR3I6zxqK6eALW+8lM
 ZVuQ==
X-Gm-Message-State: AJIora8sA1y4IcIVR7t41incuXdC9zQgfofgdgK4XGO2gFUogFSEOQGU
 fOk/rAtGQtYAF4omzJ8toGDYaOtIDbDJgPdgIg1/6Q==
X-Google-Smtp-Source: AGRyM1vHa4WRnJlk4sln0xuJGdVhcpu8QS15R2N9PrbVvkglI7Nzwr0PBFdp1lTun6HJ/nUSS1O/TmeoEjFZPidRK0U=
X-Received: by 2002:a25:5bc3:0:b0:669:b722:beb8 with SMTP id
 p186-20020a255bc3000000b00669b722beb8mr20258885ybb.447.1656433020483; Tue, 28
 Jun 2022 09:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220628020110.1601693-1-saravanak@google.com>
 <20220628020110.1601693-3-saravanak@google.com>
 <20220628140025.qpom64ptru4ub6fu@distanz.ch>
In-Reply-To: <20220628140025.qpom64ptru4ub6fu@distanz.ch>
Date: Tue, 28 Jun 2022 09:16:24 -0700
Message-ID: <CAGETcx_7jS3H2cphiXdk=NBfmuPzsusEwPBx75n3PrP6YTnjnA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] serial: Set probe_no_timeout for all DT based
 drivers
To: Tobias Klauser <tklauser@distanz.ch>
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linus walleij <linus.walleij@linaro.org>, Paul Mackerras <paulus@samba.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Peter Korsgaard <jacmet@sunsite.dk>,
 linux-stm32@st-md-mailman.stormreply.com, Karol Gugala <kgugala@antmicro.com>,
 Jerome Brunet <jbrunet@baylibre.com>, linux-samsung-soc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <michal.simek@xilinx.com>,
 Hammer Hsieh <hammerh0314@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Vineet Gupta <vgupta@kernel.org>, len brown <len.brown@intel.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-pm@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-unisoc@lists.infradead.org,
 Scott Branden <sbranden@broadcom.com>, Andrew Jeffery <andrew@aj.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Richard Genoud <richard.genoud@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, pavel machek <pavel@ucw.cz>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 eric dumazet <edumazet@google.com>, Thierry Reding <thierry.reding@gmail.com>,
 sascha hauer <sha@pengutronix.de>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Gabriel Somlo <gsomlo@gmail.com>,
 linux-mips@vger.kernel.org, kernel-team@android.com,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-msm@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Andreas Farber <afaerber@suse.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>, Pali Rohar <pali@kernel.org>,
 heiner kallweit <hkallweit1@gmail.com>, ulf hansson <ulf.hansson@linaro.org>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Al Cooper <alcooperx@gmail.com>,
 linux-tegra@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-aspeed@lists.ozlabs.org, Rob Herring <robh@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Mateusz Holenko <mholenko@antmicro.com>, Alexander Shiyan <shc_work@mail.ru>,
 kevin hilman <khilman@kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Joel Stanley <joel@jms.id.au>, Orson Zhai <orsonzhai@gmail.com>,
 paolo abeni <pabeni@redhat.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Ray Jui <rjui@broadcom.com>, Vladimir Zapolskiy <vz@mleia.com>,
 linux-snps-arc@lists.infradead.org, Timur Tabi <timur@kernel.org>,
 hideaki yoshifuji <yoshfuji@linux-ipv6.org>, iommu@lists.linux-foundation.org,
 Laxman Dewangan <ldewangan@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Baolin Wang <baolin.wang7@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Baruch Siach <baruch@tkos.co.il>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Paul Cercueil <paul@crapouillou.net>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Russell King <linux@armlinux.org.uk>, Andy Gross <agross@kernel.org>,
 linux-serial@vger.kernel.org, jakub kicinski <kuba@kernel.org>,
 will deacon <will@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-mediatek@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Taichi Sugaya <sugaya.taichi@socionext.com>, netdev@vger.kernel.org,
 david ahern <dsahern@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Takao Orito <orito.takao@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
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

On Tue, Jun 28, 2022 at 7:00 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> On 2022-06-28 at 04:01:03 +0200, Saravana Kannan <saravanak@google.com> wrote:
> > diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
> > index 758c4aa203ab..5a6f2f67de4f 100644
> > --- a/drivers/tty/serial/8250/8250_acorn.c
> > +++ b/drivers/tty/serial/8250/8250_acorn.c
> > @@ -114,7 +114,6 @@ static const struct ecard_id serial_cids[] = {
> >  static struct ecard_driver serial_card_driver = {
> >       .probe          = serial_card_probe,
> >       .remove         = serial_card_remove,
> > -     .id_table       = serial_cids,
>
> Is this change intentional? All other drivers are only changed to set
> .probe_no_time and I don't see anything mentioned in the commit message
> re. this driver's change.

No, that's a mistake. Thanks for catching it! I'll check this patch again.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
