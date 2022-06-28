Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61FDCCA47F
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 02:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E81E60BB0;
	Tue, 28 Jun 2022 02:23:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E81E60BB0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GtISRQAw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id atP50CN1NTkG; Tue, 28 Jun 2022 02:23:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC9A060B9B;
	Tue, 28 Jun 2022 02:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC9A060B9B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9C83C0032;
	Tue, 28 Jun 2022 02:23:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47E73C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 02:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 229D683123
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 02:23:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 229D683123
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=GtISRQAw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oiG_6L4bTYrp for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 02:23:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD1DE830FB
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD1DE830FB
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 02:23:03 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id k9so1474640pfg.5
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 19:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HJxtqab0/tMiakWNEyC3nFz1/Ap3ZwjlyjInjl9oQ08=;
 b=GtISRQAw32VwWkIqJjbS6kPz10YSeb/J+R05thf6bFPMAOY82jKQN3UdU/3Xm5A6wE
 tMPJ9jiXwXd5WIpoNmuhYObSQi+a4vbyn3XjCacf3FIX++nTWeWgUHF+xWdV2kFekLbZ
 0OzYqNi1FmudYoMCCJZeGvG2ye4sCgduv0rk2Zt4nVkQ98BfuFa3NPGjGKGgPVG9KtHY
 DntPc1msd2JalXRAlzsxyFpEjwPnKkzTvOPkfaVuXEaP+ZKelLBEm4Nr7ZrcOOgm/4RV
 HPa6kkD+OJGFCcd57tIyozXxW7wCGRkiieRac/DfVSrfyK1ch327OFoWU4ImG2SclPJ9
 uIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HJxtqab0/tMiakWNEyC3nFz1/Ap3ZwjlyjInjl9oQ08=;
 b=3UbAB1bfWcgisG3tNtHqaKScy6oP/GEGgsF8EXiK0zUkc+R/mgpePUgpealJt835/G
 utMfnL5iC9o21E/SnM+U0gb6mvaPnbEYIVf29bk/xgHaVyqWlJh0eyWjC0cgR30svkK3
 UbvQK1GNYpmkUJ/XdymHRddOTjuNB2FDVA4PRZabEVEc4L277jxP2/zPUbmNbYL+smGg
 Yl/EC4qkDHzvFp3b/TmLg/RS+PaaQ30caLJDEiW0xOi9H519pjNCtHuT6KjfpnQ1TtVl
 c0AUQyyu5HF+MFKGvDSrDBVxrSzt6A9CG5m/+y3b6lecmrRRo6O0SHbl+dWkvHKeU6hc
 AH7g==
X-Gm-Message-State: AJIora8Ur/tQfH0JukwqODGlYMlRARGrR6EO1vEivxoEA0u9E9JvGw6H
 9sdiLHp1RTOzy1B1TEbaHx+vua9hFrVVWTC3adU=
X-Google-Smtp-Source: AGRyM1tkELEQsXZZ9rCiYz26Ox2Bo3COuaabo0ODviEYu2B5j99coTUXvXqjCJz9EcYG+uOHPMvd9KNaBAGlSJExO9A=
X-Received: by 2002:a65:6a0e:0:b0:405:2310:22d0 with SMTP id
 m14-20020a656a0e000000b00405231022d0mr15760605pgu.290.1656382983124; Mon, 27
 Jun 2022 19:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220628020110.1601693-1-saravanak@google.com>
In-Reply-To: <20220628020110.1601693-1-saravanak@google.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Jun 2022 23:22:52 -0300
Message-ID: <CAOMZO5D29QqH_-pktht6yO_Ga7B7KgeGXxzyUHJWGYfGTJr4pw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Fix console probe delay when stdout-path isn't set
To: Saravana Kannan <saravanak@google.com>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Richard Genoud <richard.genoud@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, pavel machek <pavel@ucw.cz>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 eric dumazet <edumazet@google.com>, Thierry Reding <thierry.reding@gmail.com>,
 sascha hauer <sha@pengutronix.de>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Gabriel Somlo <gsomlo@gmail.com>,
 Tobias Klauser <tklauser@distanz.ch>, linux-mips@vger.kernel.org,
 kernel-team@android.com,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-msm@vger.kernel.org, linux-actions@lists.infradead.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Andreas Farber <afaerber@suse.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
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
 linux-riscv@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 Andy Gross <agross@kernel.org>, linux-serial@vger.kernel.org,
 jakub kicinski <kuba@kernel.org>, will deacon <will@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-mediatek@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Taichi Sugaya <sugaya.taichi@socionext.com>, netdev <netdev@vger.kernel.org>,
 david ahern <dsahern@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Takao Orito <orito.takao@socionext.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Mon, Jun 27, 2022 at 11:03 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Since the series that fixes console probe delay based on stdout-path[1] got
> pulled into driver-core-next, I made these patches on top of them.
>
> Even if stdout-path isn't set in DT, this patch should take console
> probe times back to how they were before the deferred_probe_timeout
> clean up series[2].
>
> Fabio/Ahmad/Sascha,
>
> Can you give this a shot please?

This series works fine for me (with and without stdout-path), thanks:

Tested-by: Fabio Estevam <festevam@gmail.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
