Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B4CC433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 19:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C03824190C;
	Wed,  4 May 2022 19:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B1_4g9kCFoOP; Wed,  4 May 2022 19:45:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 67145418FD;
	Wed,  4 May 2022 19:45:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF97C0039;
	Wed,  4 May 2022 19:45:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE4B6C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC4A240BB7
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=sang-engineering.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iG25NvkSv208 for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 19:45:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E396840488
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=k1; bh=2q9kJ+8J6Nj+noa+ysAgVWxp7HJp
 3YXTWBSQdDFOrJc=; b=fgyqMor8BnT+jCMFTTvVxSewqorJTU4N5FJ0aU8PIag8
 4W70pUpntGfIkHPplckusA1ZSFmtO6vEzkszXgjt0lniXjmK+ga40g67m0uqhey0
 NsgEoY72ww39sYg+FHCmMHBmiHh45LVpx3hd82IsdwMXEzUUk1rpBg9NOM6PYRM=
Received: (qmail 1530016 invoked from network); 4 May 2022 21:38:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 4 May 2022 21:38:33 +0200
X-UD-Smtp-Session: l3s3148p1@gHM5xTTeEJwgAwDtxwyXAP9dq+3qRUcy
Date: Wed, 4 May 2022 21:38:29 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 5/7] dt-bindings: serial: renesas,hscif: R-Car V3U is
 R-Car Gen4
Message-ID: <YnLWNd8+k7zJBjLk@kunai>
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
 <dd734aaa4e5e0b32864b038b79eafe72907fb99f.1651497024.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <dd734aaa4e5e0b32864b038b79eafe72907fb99f.1651497024.git.geert+renesas@glider.be>
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
Content-Type: multipart/mixed; boundary="===============8082932934093529513=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8082932934093529513==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpHmGhsqe2VKaOCt"
Content-Disposition: inline


--lpHmGhsqe2VKaOCt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 03:34:57PM +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--lpHmGhsqe2VKaOCt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJy1jUACgkQFA3kzBSg
KbYcdA/+KOq/qUv5ohpWgXUssCajSQofvIxykUKlRr0VJyOTFZ9AvfuLieks6ef3
SLHqVP+dXXtBULOUYR/KxM3wouSzv6D08bAqiI175AUO2bk06/wzhjp4YTaWRmU5
cABlT8bz/WvfWkvjBBTOQvV/TQdzGdxnlk/UNGsdnHbk6FW5TT3uMZURJtbSbVX9
+SIuK3dtBAAlj17ptceU1pt+gHzmgcXwwsoJXt81IS85p0X+pjosSjmS+4OZZXME
vtvp9bIAx9MCwk0ZE0CwpDiDNXXnpdrj7CKq6gtm+MvLcoANhf5TJ6jrDXXu7+cy
VGov/kaKccz9ZJT9s6n5AylCANBK78a8bzConwx+E5YMSOK+V596Dv6i5dWIJ8vl
WD8jnOvOHM+T+gxJ8srDEnZ/cn1q+eJ1Y42XwiL+zLHwqOc5Fb33DbFdoMaNsshL
IDGVvLtU33r+ofI/ZDpR2+f9YHuAKhVA4AZLXFOvPHCly9XvNjr2nrGjr+WUD86f
YvG6jo+X4HdiFnYcuWIlqtJETIq6nlsJb0l8sJI1RiVf8EgJySKXYewN+Pl5i663
S9+VtROVKYAqtyiADUlkzCo3TtpUpQcRpuAAgDcBPQpbKw0oRf+anBq7cqd0Mkzh
OMR++YqPqnsky1N7TkTlQIKuwIBU9HmEkYPO1kdCBPDd5yoPIE0=
=YkWj
-----END PGP SIGNATURE-----

--lpHmGhsqe2VKaOCt--

--===============8082932934093529513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8082932934093529513==--
