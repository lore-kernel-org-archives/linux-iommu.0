Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87053C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 11:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E04E60E92;
	Tue, 28 Jun 2022 11:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E04E60E92
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YdmebN9V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2M6i5lj78_Po; Tue, 28 Jun 2022 11:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CBB8A60E7E;
	Tue, 28 Jun 2022 11:15:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBB8A60E7E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 842B6C0032;
	Tue, 28 Jun 2022 11:15:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64CFFC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EB5A4091E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:15:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EB5A4091E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YdmebN9V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yqtsvtsvitKz for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 11:15:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABFB9408E0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABFB9408E0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656414939; x=1687950939;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VAm8GqMxSVbXa5l11MJLdH5RISvLfde2v1QEXHVyiio=;
 b=YdmebN9VTTFYBqrXPSMSMTJdyfVgVDZTywSBwg/rahumpiBjSqLDh9Ud
 3ee75T5XfynMWGNN3lcuMFgD1mYLGyOVqFDuA3vHPXA2FLcxwi0b/kq0C
 qjR9vtEktDD8wRPq3YITYQPsnwcoKmAztV4Qo53b4tNvUM1zq2318Acnu
 +eNxPUbHNB5FNXZS0rN+Do6Bpt13+rWzknpx/DDus70c/WYnbm9s7udBv
 UbAv89iPwrAVnzyeNJmt1sApaZsoOnRHavxRnFL/5DpNQylFIyy3bKuA7
 0xlMp6jsjc3zXBzbSfuDEL9+kkk1s1jh0tik9pb6zj8cD7xCM+Fefz1n2 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264752578"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="264752578"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 04:15:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="540456672"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 04:15:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1o69BV-000wl7-8C; Tue, 28 Jun 2022 14:15:09 +0300
Date: Tue, 28 Jun 2022 14:15:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1 0/2] Fix console probe delay when stdout-path isn't set
Message-ID: <Yrrivbk2NSK3loBW@smile.fi.intel.com>
References: <20220628020110.1601693-1-saravanak@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220628020110.1601693-1-saravanak@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
 Tobias Klauser <tklauser@distanz.ch>, linux-mips@vger.kernel.org,
 kernel-team@android.com,
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
 linux-riscv@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 Andy Gross <agross@kernel.org>, linux-serial@vger.kernel.org,
 jakub kicinski <kuba@kernel.org>, will deacon <will@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-mediatek@lists.infradead.org,
 Fabio Estevam <festevam@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
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

On Mon, Jun 27, 2022 at 07:01:01PM -0700, Saravana Kannan wrote:
> Since the series that fixes console probe delay based on stdout-path[1] got
> pulled into driver-core-next, I made these patches on top of them.
> 
> Even if stdout-path isn't set in DT, this patch should take console
> probe times back to how they were before the deferred_probe_timeout
> clean up series[2].

Are you sure it's only limited to the serial drivers?
(just asking, I don't know myself the answer)

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
