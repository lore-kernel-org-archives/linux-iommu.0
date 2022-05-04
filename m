Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458C4C433FE
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 19:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0759941940;
	Wed,  4 May 2022 19:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwPJvex_9zfC; Wed,  4 May 2022 19:45:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8AED418FD;
	Wed,  4 May 2022 19:45:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DD84C0039;
	Wed,  4 May 2022 19:45:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E55AC002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EA8140488
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=sang-engineering.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5eJ1VCbnLF3v for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 19:45:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3ABDA40BB7
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=k1; bh=DKaJkQV3K8J6IK/vWUurE5CYeW7R
 St0BNzaWbBXGQbc=; b=BL2m2kdxPuy/v1XmfB9mVrNsR1D1KKnRdFJw3k5vHxmT
 T+doJV6S2IzBaWiIIIb8v5wuppUVuNltQ6VSmA49dImytrY6aXMYwUu5F5RIlWPa
 ON7NwamnjQkAkrudaP3Q90PMpIAq34yZv2z72LvAI8B10XglZyrlpT7OW0/Inqc=
Received: (qmail 1530318 invoked from network); 4 May 2022 21:38:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 4 May 2022 21:38:56 +0200
X-UD-Smtp-Session: l3s3148p1@FFZ7xjTeFJwgAwDtxwyXAP9dq+3qRUcy
Date: Wed, 4 May 2022 21:38:53 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 7/7] dt-bindings: watchdog: renesas,wdt: R-Car V3U is
 R-Car Gen4
Message-ID: <YnLWTbWHGTiLgcl3@kunai>
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
 <2882a6de3905a57ae62d91060d27521af43c4068.1651497024.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <2882a6de3905a57ae62d91060d27521af43c4068.1651497024.git.geert+renesas@glider.be>
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
Content-Type: multipart/mixed; boundary="===============7265975003480005812=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7265975003480005812==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o2vO8SntDaD9QMef"
Content-Disposition: inline


--o2vO8SntDaD9QMef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 03:34:59PM +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--o2vO8SntDaD9QMef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJy1kwACgkQFA3kzBSg
KbavkQ/+OmT7GWvPk6VRFi3/rfH2FDUsWHjN3KFNjvSThc/aPxG8U6I1sQ0xVwhu
tVm+XuHDA/RifUFDmkFKl0kU6RXCI7UCCfy4Ica2g/EKKq7AvS2YBlPnQJwumr7W
tMlMOj8oQ1kazcC2cyAXWTeeQwkG050rqzTfDw90CBLGtc8YLE1grfKdHuE7rCcV
3Bmex9atRvkCjaVm3fgmLri81M9vu8i6B4X0LwPW97MOhWOCZJcfvlW1glaK3x44
9076ncP3Gh6k0A6oKIyX3p7XQqrCzwoQ7pL+qPwOLiJdhsz2JubuwI0HeYqJhYPI
VgwUqwVZYU66SL1lBgX/4HBkYUine7WprA+3gIEXFwX4LPx275l14HLMdFaKGouJ
qYrlXDgDxW5x2J7SliOtZgvePO11W9tKXNEJ+0oBQXI8c0pPRCGbpcQQGO0tKFRX
djfzEK42Y+II2GEXjvKrKGv6vTbQG/gURzdamEsnTiu7RjRM+h6yqoF74PkbVu4A
BRfwgHSG8LTugfrxl+bR0Ciz8HdDx2b0OC4NwMU4eTE9VhR/+cqtsQAYEbv3NXAK
FTQYTHbiR6JJf3B9E0o/cdpM2v+MkybqAqkZGUAu0v/ErTursF+YTXLl6PSxJ++V
MhNJbDijy84CRo3cvncTBgRjxHWTyNwMlbif6itkeP5GBqcFjOU=
=tLp8
-----END PGP SIGNATURE-----

--o2vO8SntDaD9QMef--

--===============7265975003480005812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7265975003480005812==--
