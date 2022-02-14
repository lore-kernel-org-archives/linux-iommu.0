Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799F3C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 12:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 232DE818CA;
	Mon, 14 Feb 2022 12:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FPNTwb32FAeq; Mon, 14 Feb 2022 12:40:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0A77F813BB;
	Mon, 14 Feb 2022 12:40:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3883C0011;
	Mon, 14 Feb 2022 12:40:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53036C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32D0C60EBF
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:40:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U1-WdEuztrR4 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 12:40:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A89D60B22
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:40:22 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B5B0AB80E91;
 Mon, 14 Feb 2022 12:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4250FC340E9;
 Mon, 14 Feb 2022 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644842418;
 bh=IQKHs148sOwzSOJ9x7YM1yay1qSuKlbeZzKnX8pviEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rWhH+LSokZ3Zs/QiXpu8o5Ki+KnAslQZ/LWSTzG9fMRcf+8pxIVHNAgtUU1oj6cvU
 ueXKCU7WZKJ/wRK68K+zEAjeJMdaM7s47AyvQ25N8LoFbUMh7pKIayN3VgCmqiQ99S
 EQR52sV8lX24QDh5Y6RmFhExf1wnMLker7AQ7F8D4NFlTeWtaasxrCVfhF99LVv4oK
 GCeaHeVIzO4MU8vxm/xgXbvG8u+tFoMpgRZSLd4+HwKHyKf5X75+YbpnFVMkkgUSk6
 fDvjyddaRrvSTNImWVKyRUoZuzRyOMhMV3cPUcakLZra9OnBOGXZW/szRhs+oQ3MYF
 1e2CJ3Ew+jpfQ==
Date: Mon, 14 Feb 2022 12:40:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 20/23] ASoC: codecs: wcd938x: Make use of the helper
 component_compare/release_of
Message-ID: <YgpNqLQzpx4J6d8K@sirena.org.uk>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
 <20220214060819.7334-21-yong.wu@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <20220214060819.7334-21-yong.wu@mediatek.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Takashi Iwai <tiwai@suse.com>, James Wang <james.qian.wang@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 srv_heupstream@mediatek.com, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============6405730017056005306=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6405730017056005306==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kmbocLNYrfZ7Ic0Q"
Content-Disposition: inline


--kmbocLNYrfZ7Ic0Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 14, 2022 at 02:08:16PM +0800, Yong Wu wrote:
> Use the common compare/release helpers from component.

What's the story with dependencies here?  I've just got this one patch
with no cover letter...

--kmbocLNYrfZ7Ic0Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKTagACgkQJNaLcl1U
h9ChNwf9H0Bf8Q4NJFX6MpkURJU1WTUkJZ8s9zjT9F5003kszR2qdhtG8TCUYisF
m+Ywr7okO1EGsbMSae1gxr0q5In/J/buVsEnIjl42Be7doIn1xXcDB+3tjDyi4aH
ZN/sHluDMyiwzeBgN2jiu99gsgHDVXThtPOdyMLab2QMCVo6PEox6vsKyIb6vO2F
Rl7BLwS916U45mWEFF/XAJLWV7QPG5f43JvKlSkjKLgJhFP8H/cxKzlNZclRAdEi
fSWK497fgwmyoHrXr2inZNyDmAh20f9np1WMgLBl2sJwN8LnmWSDpp76C/XfRV0T
Qp7CAMe19I/TqvJsaFw7oluNeBT7Yg==
=2URH
-----END PGP SIGNATURE-----

--kmbocLNYrfZ7Ic0Q--

--===============6405730017056005306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6405730017056005306==--
