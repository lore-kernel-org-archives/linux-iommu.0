Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C29EC49EB7
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:23:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4BE61375
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4BE61375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A811C608EC;
	Wed, 16 Jun 2021 11:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T49xyUFmhqqj; Wed, 16 Jun 2021 11:23:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9BE17600BA;
	Wed, 16 Jun 2021 11:23:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53483C000D;
	Wed, 16 Jun 2021 11:23:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84535C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 644A683A49
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ipBOtakLdmgL for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:23:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E755483279
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:23:50 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 854F3610A3;
 Wed, 16 Jun 2021 11:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623842630;
 bh=g6CqKpNssfWZS4xgbu0WGWsz163g70EJdFAHWCTqK4k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eYOCzbD/nX7TWuCbm9XrKjA3/oTWm6M6tGglF53tP+LfRTkhTPg1lEcDPvvAN/5kv
 TpvEmqiPZ7ocHODbT9grKxc7NCB9VgrVl5YOqLOQs+v6Kmqa7P27AT2DsuVumcXYkn
 eJYr041l67RPIFdp43ga8cCd2GQztUYPutlltYe5nYtMJCzctQKO4NL2j7qqOOCFRj
 QdLcPChjteGN9a8JLCTkIlykZ+sdRwpOO4/ddsFo3rRz1Dpf4rPGW9k2oiGGRGX0We
 SLcaxoqprWifV2sk+hu7OHqudgTBgIM3MyHKAAHwlixdjjdUdOXboI5HAplwQ0Iijd
 cu+AgqnqLHKjQ==
Date: Wed, 16 Jun 2021 12:23:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop redundant minItems/maxItems
Message-ID: <20210616112330.GA6418@sirena.org.uk>
References: <20210615191543.1043414-1-robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210615191543.1043414-1-robh@kernel.org>
X-Cookie: Revenge is a form of nostalgia.
User-Agent: Mutt/1.10.1 (2018-07-13)
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
 Jassi Brar <jassisinghbrar@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, David Airlie <airlied@linux.ie>,
 linux-serial@vger.kernel.org,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Jakub Kicinski <kuba@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-media@vger.kernel.org,
 Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
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
Content-Type: multipart/mixed; boundary="===============2562275139759710356=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2562275139759710356==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 01:15:43PM -0600, Rob Herring wrote:
> If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> same size as the list is redundant and can be dropped. Note that is DT
> schema specific behavior and not standard json-schema behavior. The tooling
> will fixup the final schema adding any unspecified minItems/maxItems.

Acked-by: Mark Brown <broonie@kernel.org>

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDJ3y8ACgkQJNaLcl1U
h9Ac0wf/WFBwvLz68FdAbuGM6JaAVtj45x3dKG5mcCVhDjM9pWq37W7dh2WVOmud
k/ZhAI8WJni++qhNgTpWx5KNYWv7CezEiO3chs59PI3WF8rHTlWmiJDhQKQDDZNv
JhvaSLDPwUaqSCB9Xu6ig804/2ucfzH6InVeCVKXBwTWybMqgTzdbH8JPRmwzUSV
zC8N/oZNAxV9xFHjybuA2tx/GepXnBC89tySI6RfgzD+TpxrKVILAKfDi6Q9omrc
bfiQD+8wZVng2UO520jPulyhnLJf79DYzb7AFiMfYJNib8OMH6hLfixqhZXKhcVg
5tNkJeyp8UZUf1UiAr9jVR9VyjR45g==
=hlC7
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

--===============2562275139759710356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2562275139759710356==--
