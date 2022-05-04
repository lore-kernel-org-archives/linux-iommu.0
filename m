Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77543C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 19:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 138BE41941;
	Wed,  4 May 2022 19:44:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hSLmxYOgh5Gg; Wed,  4 May 2022 19:44:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3563418FD;
	Wed,  4 May 2022 19:44:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DC1FC0039;
	Wed,  4 May 2022 19:44:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C151C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 333DF83F91
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=sang-engineering.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OJFLH7o7chCT for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 19:44:41 +0000 (UTC)
X-Greylist: delayed 00:06:38 by SQLgrey-1.8.0
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5495E83F7D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=k1; bh=T0SMZXN87mfbGYdslVIzxN731a69
 yFRI35AcyNOGoKA=; b=cJ05izlUVZhs3a/OGCJhfaEPDq8PXcukKlu8Il9yxvUk
 yBZmk8Rqb+YW7lWH/akUJAQbXT/au+b1AV3NRXOp9KEdeMM+HxUsj7/PQqiQeXoo
 gGmCVFhDMdmBFzurUEl0hzInZw8baa9qFG4wqyLb5xlTiZYy8VuOoO3J3wJO6PM=
Received: (qmail 1529521 invoked from network); 4 May 2022 21:37:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 4 May 2022 21:37:56 +0200
X-UD-Smtp-Session: l3s3148p1@fBecwjTeCpwgAwDtxwyXAP9dq+3qRUcy
Date: Wed, 4 May 2022 21:37:47 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/7] dt-bindings: gpio: renesas,rcar-gpio: R-Car V3U is
 R-Car Gen4
Message-ID: <YnLWCzLESZ3NwNg7@kunai>
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
 <5628a862688bd9d3b4f6c66cb338671211058641.1651497024.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <5628a862688bd9d3b4f6c66cb338671211058641.1651497024.git.geert+renesas@glider.be>
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
Content-Type: multipart/mixed; boundary="===============3544315367846388045=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3544315367846388045==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YNJ34uo+OPtBXoDU"
Content-Disposition: inline


--YNJ34uo+OPtBXoDU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 03:34:53PM +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--YNJ34uo+OPtBXoDU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJy1gUACgkQFA3kzBSg
Kbacvg/+M5weBbp8eucQzeQfhiSXmoUq8Y085EPJPVnSs9VIxmDp6QiVP3OYgeZb
mRyvi3cG+gfUGSnZZs+0VDmQBPHCz2V7d731JxT0LVhv/uJz/ItLPzrlIWO50KcD
Qdeo2KKaVnm99fZLzjh+NLUEz3miB20m16D61q7tdMyJ4RoVPHV4vhks0XO8PBTU
c/reVsCjoxzwHbhNaRKmDbhzwtvOdLG4HyWDJU98ZD3p//Pakjb3E0ke//Ka6Jwu
CRVqd4iih7pq/VXCJRQfFihTRcWN6WQFu7CqtJI0zZijuKMRHrFbzB6jmao8D6Oy
GRiRFwjfgoc+emlOKRGUy8C3puUnn4zBJlSHdnHYjXyMdsHS2W0aCtrT4U1cXBuR
geyysQdp07zxfSVLA/4c7Ct+wF98JJXFlJ0ccFTRRwtRUrRpcvq0PuWEF0VaWoSM
t9OvT5PWv3wQAOTcP1En5UP0wZUXOJznRcGOOinvCVVYAlcjP9oDQqDTkdRFwYdz
HJXj7xpF290VMZh0uC0zleU632ngk5UA8N4mnEKLGRo6jppkZWRrxKt/CU0T4upC
MGnS/oywZKz2PKoQeO+6QX75pRe8DdVjYNiNHYyiFYMsc/gw1mJ1tKgplWZvdmZU
Ooarfwc9vDJQX5C4HeXnNLdsIKtmxzspIs2+nAM/tpIcVi3AZz8=
=k7OO
-----END PGP SIGNATURE-----

--YNJ34uo+OPtBXoDU--

--===============3544315367846388045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3544315367846388045==--
