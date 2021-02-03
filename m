Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD66C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 11:56:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5969C64F74
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 11:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5969C64F74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17B0785AFF;
	Wed,  3 Feb 2021 11:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xz6URYvQLd0i; Wed,  3 Feb 2021 11:56:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B434E85A2E;
	Wed,  3 Feb 2021 11:56:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97F6BC0FA7;
	Wed,  3 Feb 2021 11:56:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21754C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 11:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0804486650
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 11:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yAlVCaDXyZ0i for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 11:56:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7CC52865D4
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 11:56:05 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B2493AEE7;
 Wed,  3 Feb 2021 11:56:02 +0000 (UTC)
Message-ID: <fcf4d0934a1523975c325c9911c1830a2121b27a.camel@suse.de>
Subject: Re: [PATCH 3/3] dt-bindings: Fix errors in 'if' schemas
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Date: Wed, 03 Feb 2021 12:55:58 +0100
In-Reply-To: <20210202205544.24812-3-robh@kernel.org>
References: <20210202205544.24812-1-robh@kernel.org>
 <20210202205544.24812-3-robh@kernel.org>
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomer Maimon <tmaimon77@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Jeffery <andrew@aj.id.au>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>, dri-devel@lists.freedesktop.org,
 Tali Perry <tali.perry1@gmail.com>, Eric Anholt <eric@anholt.net>,
 Daniel Palmer <daniel@thingy.jp>, linux-i2c@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, linux-leds@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Scott Branden <sbranden@broadcom.com>, Avi Fishman <avifishman70@gmail.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============0614600841417969528=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0614600841417969528==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-5GqMeNDA14mTF3lYuG5p"


--=-5GqMeNDA14mTF3lYuG5p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-02-02 at 14:55 -0600, Rob Herring wrote:
> Properties in if/then schemas weren't getting checked by the meta-schemas=
.
> Enabling meta-schema checks finds several errors.
>=20
> The use of an 'items' schema (as opposed to the list form) is wrong in
> some cases as it applies to all entries. 'contains' is the correct schema
> to use in the case of multiple entries.
>=20
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-crypto@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-5GqMeNDA14mTF3lYuG5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAaj04ACgkQlfZmHno8
x/7Bywf9Ghk5CuwNSJHbRiqlKJ1q12tWeWcLF7LmZIFgm2sawjY0skG82SyJfJow
cwKef8GMfZ51OrlO4VmeoOJ1sK8zmq6rkPz24dgE0Fe82CRAXneaxyr+m19SOgll
vmrtNrEQpRqlVrOTo4A2jAufrJtStlw2VAy0jJT/QlRlyRwArJoUskuIqwNzj7wF
KbgUjHD7GbVhRHlbfhsY7TdO6MYB4iKQek7IgiYoK8lB8TexlKr2ygDdBj1aXs4u
omTYdJANyOFSbFAmnWfl3ScKeyS7lVHPUZybV6rHp6YDt+k1vjRivIzZXOLXrv14
i2YyoJudc8K5ZBi0AE6j2Y0njKpi9A==
=vnPw
-----END PGP SIGNATURE-----

--=-5GqMeNDA14mTF3lYuG5p--


--===============0614600841417969528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0614600841417969528==--

