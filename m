Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C6EC48BE8
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 10:34:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628C06101B
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 10:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628C06101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 227FF8380B;
	Wed, 16 Jun 2021 10:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hy3BUBoFXmwH; Wed, 16 Jun 2021 10:34:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E60F83508;
	Wed, 16 Jun 2021 10:34:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4E10C000E;
	Wed, 16 Jun 2021 10:34:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE4C4C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE1468374F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:34:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aeAfPQQ737AE for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 10:34:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5825583508
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:34:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 998E661107;
 Wed, 16 Jun 2021 10:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623839691;
 bh=uJEv3OvJMqswalWvG2rx1DCmioR+VtUOrO7CZGR2Ajw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A6wsFevRhS9CeafwlT529v2rV3Gm9GGwn4GGkmYDghQBgvSltNdLhA2d1VwUgm9YV
 V+BZ/Z7dkVuRC9jA+aF8uUIN4oppwPSoc0YE3UC/NPxsGiCugwhXT7XZEbbeh2pmB/
 M4rdDOJ4s0X9LmiRn4axjJlxF+T4B+Wd1HYLAz0MgEG64RvZ+ZZaXxAxnqcCDwPJej
 pW3zx7fe6lsVprl/vQScwg/OlH7/cEN61iAlussljsV2mRmi/pOkb0n3FbRiUdCHAK
 H6X3SZGPBKP1nePHfXCLHq/6yaW3vQZyt5NRvZBipljaN3xhgyRVkvGP83STRQZ1Xh
 jhhQBOeaewbeQ==
Date: Wed, 16 Jun 2021 16:04:47 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop redundant minItems/maxItems
Message-ID: <YMnTx4GqTWu75o2n@vkoul-mobl>
References: <20210615191543.1043414-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210615191543.1043414-1-robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-remoteproc@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-riscv@lists.infradead.org,
 Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
 linux-rtc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Marc Zyngier <maz@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 David Airlie <airlied@linux.ie>, linux-serial@vger.kernel.org,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Jakub Kicinski <kuba@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-media@vger.kernel.org,
 Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Alessandro Zummo <a.zummo@towertech.it>, Guenter Roeck <linux@roeck-us.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 netdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-crypto@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmaengine@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jonathan Cameron <jic23@kernel.org>
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

On 15-06-21, 13:15, Rob Herring wrote:
> If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> same size as the list is redundant and can be dropped. Note that is DT
> schema specific behavior and not standard json-schema behavior. The tooling
> will fixup the final schema adding any unspecified minItems/maxItems.
> 
> This condition is partially checked with the meta-schema already, but
> only if both 'minItems' and 'maxItems' are equal to the 'items' length.
> An improved meta-schema is pending.

>  .../devicetree/bindings/dma/renesas,rcar-dmac.yaml          | 1 -

>  Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml    | 1 -
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml    | 2 --
>  .../devicetree/bindings/phy/phy-cadence-sierra.yaml         | 2 --
>  .../devicetree/bindings/phy/phy-cadence-torrent.yaml        | 4 ----
>  .../devicetree/bindings/phy/qcom,ipq806x-usb-phy-hs.yaml    | 1 -
>  .../devicetree/bindings/phy/qcom,ipq806x-usb-phy-ss.yaml    | 1 -
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml     | 1 -
>  Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml   | 2 --
>  Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 2 --
>  Documentation/devicetree/bindings/phy/renesas,usb3-phy.yaml | 1 -

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
