Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E6FC433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 19:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E17483F7D;
	Wed,  4 May 2022 19:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ji_vXbds4iyF; Wed,  4 May 2022 19:45:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9130383F91;
	Wed,  4 May 2022 19:45:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BBA2C0039;
	Wed,  4 May 2022 19:45:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92127C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F9A34190C
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=sang-engineering.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kOrEbfvOYeBV for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 19:45:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73E0C418FD
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=k1; bh=ngAP9WaE103CcVR6TpfcCwecyQ1Y
 p9lzXNJqrlwo9Uk=; b=tdc9vEkSlQD5hLFKQzQXP/qOAGjuSjiAPwf3CNwUEAUy
 fC1ZJkKynTmGZiVtn1wsl9kwWDWCB3t7w2ZxjuW9BN+8Xgxq1I9ynv02dFS1w2Ir
 BK/2Hh6cv+6zlXAVasinTy+ywbbZpCgd4zbdkxyt/duZjiJRhVxGootLB/6cmVQ=
Received: (qmail 1530193 invoked from network); 4 May 2022 21:38:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 4 May 2022 21:38:46 +0200
X-UD-Smtp-Session: l3s3148p1@yOj4xTTeEpwgAwDtxwyXAP9dq+3qRUcy
Date: Wed, 4 May 2022 21:38:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 6/7] dt-bindings: serial: renesas,scif: R-Car V3U is
 R-Car Gen4
Message-ID: <YnLWRBd+0mBz2Mlu@kunai>
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
 <c57ed00e85778380776330be6183c6861d843c22.1651497024.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <c57ed00e85778380776330be6183c6861d843c22.1651497024.git.geert+renesas@glider.be>
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
Content-Type: multipart/mixed; boundary="===============1323333704118013115=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1323333704118013115==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pq/4T+atuXnzKk57"
Content-Disposition: inline


--pq/4T+atuXnzKk57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 03:34:58PM +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--pq/4T+atuXnzKk57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJy1kQACgkQFA3kzBSg
KbYhXRAAheR3oRo4kTkVTqR4eUJWkgxmlymaB5ikgDBkUJ3X+8rJeTP6Mwhwz+z1
KD1VMBmTQHrOKBmZYlxicXmKz8pT9AKo3l6E8EyUV++1QOXM9xsZOTUq2w75En8W
Hwme0UIkglapbvbTxqeWPDGMMdCjPGITU8jhtvaXRBgmbaURItmbDaS7Xf3a2jE9
MCA1zC67LTEx6HNDXqIgK1A2y6YUGbKg1U7LiJr+nVkDES2EdWvlddkx583+QJYG
txboM96b6UHT4w1p2gybsBOLqbvHeNxZf5n7owzdjt4Mds5KY71Ke8oHj6gfYmht
sTALjTQQDNGHiD19KuP4ZFhMoZTTY83evZO1ImVP5zLRTga4YuKaT7fEEzBVIOMp
4yApV7mo1QwhWJorwDFHPCsmg4oT+xu4VBkwC5PZ2WIWQ0TXbTddKoMTYdq94wpH
8w03Mk48dt7RTQ2oMzsPt6/R5irhTmIfna0mOqdBxD1sFibVSpaRHlp+fIKof2ii
XYrqaidIYux5hKVaUC1xQ3XRy8AoJs0LYlpo8wu10Vekc+r8rnf8MCWlNnORQlwD
Q8RYR8zPj2QBNe+FQrbWV53O4K82LbMsGCPWUlR63O747yhWPgN2oBTJFSgEI6rj
OpZWdzQrjWFECbdER6SJPg5Vwf6z/ReooJwyMXf2IBrQjiWXS5s=
=GRyn
-----END PGP SIGNATURE-----

--pq/4T+atuXnzKk57--

--===============1323333704118013115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1323333704118013115==--
