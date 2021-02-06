Return-Path: <SRS0=mSd7=HI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C24C433DB
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 01:26:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA97F64E46
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 01:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA97F64E46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D2E9203D4;
	Sat,  6 Feb 2021 01:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K54TExo2u8qj; Sat,  6 Feb 2021 01:26:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3D6D020360;
	Sat,  6 Feb 2021 01:26:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E646C08A1;
	Sat,  6 Feb 2021 01:26:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0735AC013A
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 01:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E6F7286C52
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 01:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AD0sQJ1yjyUb for <iommu@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 01:25:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0EAD586C51
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 01:25:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B28764F9D;
 Sat,  6 Feb 2021 01:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612574755;
 bh=/OO95ptKWwAfPKnln79sj7p50JlIFunorcpU1Za6txs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pGgQmtxfWDXFXdKv2lSHbQ8Hffg6ZF3khCddSyZagHNacjnJaiAhbckTqDOXSlJJw
 smcT7P+JGZSL/MjDF4Cr8Rs6HfFWATUw/sTBGhUPRRRpjDs3haoC8wG9ic1njvO/iK
 rA1Cyzbi+mBzO9SFOe5WFmN5JDg7RgiYb53u4NFEFWBc78kD1AKiH1wec60VpnljyX
 5yAvAzFuWeaQAaZ5McL28B12bYT5mLA0y/C30Ug7IchPcpGuxmaACHs+AUk24p6dwI
 S3tKhxddOqP8c9w+NOQxMKcPulyOZs43cf5XSh7rqi9xUyn0TiyVcGfr8ZD7n7HFTi
 xaZJjX6p2Okig==
Date: Sat, 6 Feb 2021 02:25:51 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: Fix undocumented compatible strings in
 examples
Message-ID: <20210206012551.GB3847@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Daniel Palmer <daniel@thingy.jp>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Avi Fishman <avifishman70@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-watchdog@vger.kernel.org
References: <20210202205544.24812-1-robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210202205544.24812-1-robh@kernel.org>
Cc: Tomer Maimon <tmaimon77@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 Tali Perry <tali.perry1@gmail.com>, Daniel Palmer <daniel@thingy.jp>,
 linux-i2c@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============1046908141975955608=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1046908141975955608==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 02:55:42PM -0600, Rob Herring wrote:
> Running 'dt-validate -m' will flag any compatible strings missing a schem=
a.
> Fix all the errors found in DT binding examples. Most of these are just
> typos.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Daniel Palmer <daniel@thingy.jp>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> Cc: Tali Perry <tali.perry1@gmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Vincent Cheng <vincent.cheng.xh@renesas.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Wolfram Sang <wsa@kernel.org> # for I2C


--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmAd8B4ACgkQFA3kzBSg
KbbdSRAAtkrymAGNS5LGn321fm8TqaN3fodZIhNLfeeWULr/eImrk2RJCYzunjC6
Nb8wJvEywJuB1E4YzkiFTgWxKVeLmFnUFodUSlufnefhzGl4Q+2udtIlUr3CqBaM
K7b7RS452nISpyzJHTBfdWr4VwEUOHqmrYXG3jLExytI6Enrun7qqY6hu7WwXUIT
tZ7CUUP30kMy3K1ahkItDx0SGBRf5hWrG+KAzSj9cyZKHFBaIv3WKV/bUMC6OC+Y
h83LhJP40pBTFZWlk+jwchtr4ZWNF6GG9vuIcXWI35Y9tYUDsX0fWnRj3LSMdp8u
QMK0sZFo4oIejPXH61NxPWZ6IHVcy21veXay4ZXApxNjsuwyitBb7/aRrJDEoJsr
MlS6IMR7MXnujHlxwoJ+3sSIvPhRyeWgTC1pmp4qL2LwImDHrooS3pJANxAl7Ws6
+RKt3Mkf0w5k5r2HiukAHI7Lywkwb74sit3LU3D6awsZicpRT9c/tNlGnTNsl6Hu
+Mu9JP+//QSe+eRhOsXCnwMl8eEutYWvPadijYg87IbPxat3uDuiQz5E7S5dMTSR
UerC7itsB9z9Hpb8zDdQAboNPdw04c+kfWn53Mu7cxhvxhzYyf+jZsu8tMIG60Bb
LheRj95DOtU9bnIaQ8NdiBy3k9LESOW9ULADetyHoQZLM5Qb7Zk=
=d/1y
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

--===============1046908141975955608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1046908141975955608==--
