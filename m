Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75347CCA479
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 14:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B11DD415A4;
	Tue, 28 Jun 2022 14:49:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B11DD415A4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eODP6Z4baH-W; Tue, 28 Jun 2022 14:49:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 575A741732;
	Tue, 28 Jun 2022 14:49:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 575A741732
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 545ACC0086;
	Tue, 28 Jun 2022 14:49:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B30CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0770482983
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:18:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0770482983
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zx0SL24Gd5fQ for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 14:18:57 +0000 (UTC)
X-Greylist: delayed 00:18:28 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B61EF827A0
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B61EF827A0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 14:18:57 +0000 (UTC)
Received: by sym2.noone.org (Postfix, from userid 1002)
 id 4LXR7Z2Gb9zvjfm; Tue, 28 Jun 2022 16:00:26 +0200 (CEST)
Date: Tue, 28 Jun 2022 16:00:26 +0200
From: Tobias Klauser <tklauser@distanz.ch>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1 2/2] serial: Set probe_no_timeout for all DT based
 drivers
Message-ID: <20220628140025.qpom64ptru4ub6fu@distanz.ch>
References: <20220628020110.1601693-1-saravanak@google.com>
 <20220628020110.1601693-3-saravanak@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220628020110.1601693-3-saravanak@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Mailman-Approved-At: Tue, 28 Jun 2022 14:49:26 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-06-28 at 04:01:03 +0200, Saravana Kannan <saravanak@google.com> wrote:
> diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
> index 758c4aa203ab..5a6f2f67de4f 100644
> --- a/drivers/tty/serial/8250/8250_acorn.c
> +++ b/drivers/tty/serial/8250/8250_acorn.c
> @@ -114,7 +114,6 @@ static const struct ecard_id serial_cids[] = {
>  static struct ecard_driver serial_card_driver = {
>  	.probe		= serial_card_probe,
>  	.remove		= serial_card_remove,
> -	.id_table	= serial_cids,

Is this change intentional? All other drivers are only changed to set
.probe_no_time and I don't see anything mentioned in the commit message
re. this driver's change.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
