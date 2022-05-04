Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7063DC433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 19:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03CF183F93;
	Wed,  4 May 2022 19:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TyBwb3RCTyGD; Wed,  4 May 2022 19:44:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EB77883F7D;
	Wed,  4 May 2022 19:44:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C56CDC0039;
	Wed,  4 May 2022 19:44:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CF44C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AECC40BB9
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=sang-engineering.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I9JBMMjf5UEY for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 19:44:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 77AD040488
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=k1; bh=TGgkgf23iNHhaoSkxSXOTrm86Jx7
 Qux/bkGK37Em5mg=; b=vDllpQVtu4fhUACN74336A5z58Y29/6f8YoYskgikImC
 RdDwgzAwHwGuCbTT20UjUZgVKA1+idTa1TTlmC7jTA3g2Px4LG6jmnnVLhLoH6eE
 t6We6MOGK+ZQfClRvR835fqxwuAAJOeAWmab7BZkJ/FnSEieuT2Ym6vw19JHRx4=
Received: (qmail 1529673 invoked from network); 4 May 2022 21:38:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 4 May 2022 21:38:07 +0200
X-UD-Smtp-Session: l3s3148p1@GrSuwzTeDJwgAwDtxwyXAP9dq+3qRUcy
Date: Wed, 4 May 2022 21:38:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/7] dt-bindings: i2c: renesas,rcar-i2c: R-Car V3U is
 R-Car Gen4
Message-ID: <YnLWHLIqhTfoP8Mt@kunai>
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
 <a0402ff46027196953fe9c13f60576d40c5aea4c.1651497024.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <a0402ff46027196953fe9c13f60576d40c5aea4c.1651497024.git.geert+renesas@glider.be>
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
Content-Type: multipart/mixed; boundary="===============2818736341603660395=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2818736341603660395==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kGLyuym/HQTEyUai"
Content-Disposition: inline


--kGLyuym/HQTEyUai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 03:34:54PM +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  I2C on R-Car V3U also supports some extra features (e.g. Slave
> Clock Stretch Select), which are supported by other R-Car Gen4 SoCs, but
> not by any other R-Car Gen3 SoC.
>=20
> Hence move its compatible value to the R-Car Gen4 section.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--kGLyuym/HQTEyUai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJy1hwACgkQFA3kzBSg
KbYOqw//bJ23ewfmiFVcdK0TufqW6sqkNrE0FzNmzZxZ0mDbeLG8bT9fMik5BI1B
dorQJi9Goqzg+o/TwnvsdWU474QRZ4SIEXmSS8n1af4LaYYHR3iY6F3kvYSgoVgB
bjiTXCqwcIKMRVkKqFd+oi6rT0snYpkYKOqu/itKeQOdyqf5736rk78mEZjH84c3
fwoaFApckiRhMER0ewSndwRCUTxcB46XxLe6rYZpTD5i4gzi0WPTt6XG9T7BWzqq
GkW5Gzzob9PZuIsVFsB+e6WMrBapTp5TqyDxR+97AtF/ri2OwJSini0GKFx4udfz
CDXY4LlNuQxZSucu2vpa0e9UuOZh7KfseUl8ymO7cx2U/1/+TvCWIlQzdHiQEGrV
HGYox7x64M/jpi2+g5hFjWNNbvP7e+lLjjtHut8JNbS+TjlZpRU8OLxcNc1t5CCc
f8IRqsbQqkJLHiYW4Jj2ZB4i+SVyxBT9EcXbSorzjrZmFRsfdcu/qS0zcTJcH4hT
GwvvGQFJJ+T16JpT7MtEuNTgjXuoX6P7oOU2f/s6Utnhh55goss0GfIF51ecnC6M
x+2lYPLI9nv9BkYlMaiONKIdSs6BA/rpbss+xpfBbW+D1r37mXRkGLTxQ3fNet+3
OG1OD4Ao6IGh2cliDjrzWH4CLs+8jZgNzj5l5HNKTQAgVdFYhqk=
=f8MG
-----END PGP SIGNATURE-----

--kGLyuym/HQTEyUai--

--===============2818736341603660395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2818736341603660395==--
