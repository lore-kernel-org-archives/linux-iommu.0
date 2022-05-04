Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8326AC433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 19:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3446C40488;
	Wed,  4 May 2022 19:45:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8wD749uLz4qw; Wed,  4 May 2022 19:45:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29D8940BB9;
	Wed,  4 May 2022 19:45:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 046DBC0039;
	Wed,  4 May 2022 19:45:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34638C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2113840BBD
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CzmaXohkc0hs for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 19:45:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3126F40BB9
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=k1; bh=ypaHt/gCH7WLZLu40BT33XSQpK/4
 ss/4B4jmKMSFmDs=; b=IpqmC+h0ARmt4ZrTC/OE9hktcApK3Y0EyBODO53Em6I8
 j6uUQebYSiIZvmBSEvFlfL24uaADWgDrojDNLGcbtUUSIOJ+x/VpfSMq31SjgvyI
 LkeYKWIU7Yy6EyWK0Dna03f8/LPA9NRa2YshMjUxNspOESe4uBvWL/ELCpxcaTY=
Received: (qmail 1529857 invoked from network); 4 May 2022 21:38:21 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 4 May 2022 21:38:21 +0200
X-UD-Smtp-Session: l3s3148p1@1jphxDTeDpwgAwDtxwyXAP9dq+3qRUcy
Date: Wed, 4 May 2022 21:38:16 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 3/7] dt-bindings: iommu: renesas, ipmmu-vmsa: R-Car V3U is
 R-Car Gen4
Message-ID: <YnLWKI96LJFyRpmB@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vinod Koul <vkoul@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1651497024.git.geert+renesas@glider.be>
 <d351ca12724d5b306119bd8dcd9bfac09ba2a925.1651497024.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <d351ca12724d5b306119bd8dcd9bfac09ba2a925.1651497024.git.geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, dmaengine@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============1715370265827600976=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1715370265827600976==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eMFhS0QRgLutzDxL"
Content-Disposition: inline


--eMFhS0QRgLutzDxL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 03:34:55PM +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--eMFhS0QRgLutzDxL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJy1igACgkQFA3kzBSg
KbavUg/9GkMkKXNrP4y33nPOCLKwKDRM+QSTQrIw+PVdnvDGBsJAoJn8KZzs9rQW
/nMtxPBOYBYDV9sDpCG+dDl0HV6BYWVXiwYdqSjO8japfck6DPe0krshczW+zeV1
iWvRxt+8BL/UuaBuOXkWw6AeevZSqkDZu3m93FfFXi3um2AbxNV/B1MVmlqxnjzd
vrPLCaSjHep+/3DF5CteLJPk0+jcrDfF0fDduOEETw/flwsms1sd7X7NI7C62mlU
C/yPO+mKMHgV/87WcBrqkjUDFz0hTXJiZDOKFueJpXYTYObqxXePp1Rtbeol92dn
KQl08/XBnhi/ZZ9vMzp/ZZpNDCUNSHBB3mN2+vKTjYJphfH6XCpeZdp8Fb7DeC/s
h12Aeq6NQI6ZwePIhW3aZaCuWpCJUCPlSFb4E3BjlAXS0Itrh9p1N1AybNQZ9emz
G773cTTg0vMYc1NSgm+CDZUZ3nwShsiF8NeI3Qz1m4oZ4bNqB2mw8D1Do2IiG4N+
dXogXOIfOptAz2l6tdyhf3R+cKeZg8XYBENRRg7fQgRl0CWeIxX8g/GVDEJ1ebOM
6fjZxezJv/XvSFi7c9fwSqiDkzvgy9LGbXLUQL/iZvxbYIZs4RLst1TMRfqOF5pU
BeKGCd95d5RYRxLXBCM308u3kySTQENSKw+GxGqqyd0kJiD4A5k=
=3zCL
-----END PGP SIGNATURE-----

--eMFhS0QRgLutzDxL--

--===============1715370265827600976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1715370265827600976==--
