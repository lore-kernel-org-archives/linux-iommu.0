Return-Path: <SRS0=y66L=6D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE95C54F70
	for <iommu@archiver.kernel.org>; Sun, 19 Apr 2020 18:15:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD5D214AF
	for <iommu@archiver.kernel.org>; Sun, 19 Apr 2020 18:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmRFpgh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD5D214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A388A2047C;
	Sun, 19 Apr 2020 18:15:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Non-encoded 8-bit data (char C3 hex): To:
	...ar.gat@arm.com>, Heiko St\303\274bner <heiko@sn[...]
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dXirVdO+G+sU; Sun, 19 Apr 2020 18:15:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F2DFF203A8;
	Sun, 19 Apr 2020 18:15:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3D27C07FF;
	Sun, 19 Apr 2020 18:15:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 270D1C0177
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 18:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0D3E02047C
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 18:15:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Non-encoded 8-bit data (char C3 hex): To:
 ...ar.gat@arm.com>, Heiko St\303\274bner <heiko@sn[...]
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mm0JyDH4-Jcg for <iommu@lists.linux-foundation.org>;
 Sun, 19 Apr 2020 18:15:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 73790203A8
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 18:15:19 +0000 (UTC)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1BC5D20771;
 Sun, 19 Apr 2020 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587320119;
 bh=p4n++5U0A4OCyfDu3fVqzBUhH4zBoXeoQg5Bhyjk5vs=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=RmRFpgh9qOnCZcBjur/bkO1wxz/Io0VUZRVX9CVb6z+EdzgjT/udTJBdTVjGD2kKt
 5W/mfVhMfxRmQDNmeSobboeL1B0AOsKg6aKQG6X8KtW/eCqhdMm7SObo/IXpu5XC8a
 amuXOAvjV+246gBjLzZUgEN7lSf6GsXiOxk2wF2Q=
MIME-Version: 1.0
In-Reply-To: <1587030553-5990-1-git-send-email-hadar.gat@arm.com>
References: <1587030553-5990-1-git-send-email-hadar.gat@arm.com>
Subject: Re: [PATCH v2] of_device: removed #include that caused a recursion in
 included headers
From: Stephen Boyd <sboyd@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@linux.ie>,
	David S.Miller <davem@davemloft.net>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hadar Gat <hadar.gat@arm.com>, Heiko Stübner <heiko@sntech.de>,
	JC Kuo <jckuo@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pierali si <"lore nzo.pieralisi"@arm.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Richard Weinberger <richard@nod.at>, Rob Clark <robdclark@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, Sean Paul <sean@poorly.run>,
	Shawn Guo <shawnguo@kernel.org>, Stefan Agner <stefan@agner.ch>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>
Date: Sun, 19 Apr 2020 11:15:18 -0700
Message-ID: <158732011837.132238.3255039844840932086@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Cc: linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Hadar Gat <hadar.gat@arm.com>, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ofir Drang <ofir.drang@arm.com>, Gilad Ben-Yossef <gilad@benyossef.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
 freedreno@lists.freedesktop.org
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

Quoting Hadar Gat (2020-04-16 02:49:03)
> Both of_platform.h and of_device.h were included each other.
> In of_device.h, removed unneeded #include to of_platform.h
> and added include to of_platform.h in the files that needs it.
> 
> Signed-off-by: Hadar Gat <hadar.gat@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org> # clk
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
