Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1843C388F7
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 08:14:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9120223BD
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 08:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9120223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 239D387514;
	Wed,  4 Nov 2020 08:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YH3lT0ADaMRJ; Wed,  4 Nov 2020 08:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D035287188;
	Wed,  4 Nov 2020 08:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8388C088B;
	Wed,  4 Nov 2020 08:14:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5319DC0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 08:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3E2138608D
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 08:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TCx7nCaF6Hry for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 08:14:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 156DD86081
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 08:14:17 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id A455BFDD;
 Wed,  4 Nov 2020 03:14:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 04 Nov 2020 03:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=XXFAaRSb32pxervJ1Zv7TKZ0W1s
 w+VVFPoX3IFt124k=; b=iCwoYVLLUuVNNTENXSZz+PtAZLQH0NKPIcbefvT6PAz
 8tNPUABoqO+CJOiPRKxLT77evcmvx99BOPBIVjGOlUnMc2ahCWKNczXUMNhN1Qy1
 6WLapO/of98Ad3Y5qA0R0QuxhGJss8NWIdpN2yIoCetNyZ4W5GlO3sf1RhBlGPpd
 L7fOWZDcMH00O6m9ZkuW02wWh+jm1eCkVAB4uLXOV0991EDg9x6rEwE2LasMz2D1
 mzFmFDXzdZ4DOBt0TfuGpqNACvWEefe3T4ta178S7CSXR6g8tGx772bOSvIBh3pk
 X63RPUU9PmFv5GTiH5jWMSm6zYnwMV1zzhk4JqkvqQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XXFAaR
 Sb32pxervJ1Zv7TKZ0W1sw+VVFPoX3IFt124k=; b=paXXPDf3g4w2iHpy7gvEr+
 WWbQX+cocXbs7LnYqP7myPSy9nGA2kWSgaoH3ExVLATUNre/rDp/eVzzWw5kmA6M
 xsIXpAYV4C/ja7niS/cqY2FARy5nQksloiNyA4hwoDyHwwQ4xtLDZrB+3XTZuahw
 t+bSL4JaBeIdKgCjZ2tbiS72uVSk7IS3yysiY/75OJfW+IrSIwD0Vht8QfJBTXNq
 OGrLs/N+9jSiXf/jCGMhqFbsB/J8yMdUZecKW58h9h9IhK618if6bktxR/NlFHpk
 brV+Jw09uzy2XJS+3QcqTS19CNhGnN3fhPcV4MAV6GRMSR6UQMfbEX5ar45KetWQ
 ==
X-ME-Sender: <xms:1mKiX9Uw7IzIEenw8GEh7Bxgnf68CeebqvVMP6DXsP8SIwOfA_FNcQ>
 <xme:1mKiX9lEwja08z2fB_8rYkMXpeBD7OUQeWBugc8CE-SmCSKFfTzeShMJeoA790gyx
 1GKXcwAgfhDClQ_jdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtgedguddugecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
 mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
 htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
 heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:1mKiX5ae_ncy_0iLL_K73gy0kfa6uzRxio7UfwfhB0QcC_NGb9PBdg>
 <xmx:1mKiXwW2D2UVSmXop5Vr6IM_Q_Q4HzsadzAwj-ZzTN_tzDm1_ZGyxA>
 <xmx:1mKiX3nCGITQ660Ht2PtiifK258kb2m8rUY6OPWDIih-t34sHfHtjQ>
 <xmx:2GKiX1W3mvCko0ApKlkI6NDW5jRTTxv-cEEqAhfUsb-yXNDsSgxF3A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id D3DE3328037B;
 Wed,  4 Nov 2020 03:14:13 -0500 (EST)
Date: Wed, 4 Nov 2020 09:14:11 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: use of dma_direct_set_offset in (allwinner) drivers
Message-ID: <20201104081411.bnt5kixgunaczbzj@gilmour.lan>
References: <20201103095538.GA19136@lst.de>
MIME-Version: 1.0
In-Reply-To: <20201103095538.GA19136@lst.de>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, iommu@lists.linux-foundation.org,
 Yong Deng <yong.deng@magewell.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============1973347491188991805=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1973347491188991805==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dpottggxee74tnew"
Content-Disposition: inline


--dpottggxee74tnew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Tue, Nov 03, 2020 at 10:55:38AM +0100, Christoph Hellwig wrote:
> Linux 5.10-rc1 switched from having a single dma offset in struct device
> to a set of DMA ranges, and introduced a new helper to set them,
> dma_direct_set_offset.
>=20
> This in fact surfaced that a bunch of drivers that violate our layering
> and set the offset from drivers, which meant we had to reluctantly
> export the symbol to set up the DMA range.
>=20
> The drivers are:
>=20
> drivers/gpu/drm/sun4i/sun4i_backend.c
>=20
>   This just use dma_direct_set_offset as a fallback.  Is there any good
>   reason to not just kill off the fallback?
>=20
> drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
>=20
>   Same as above.

So, the history of this is:

  - We initially introduced the support for those two controllers
    assuming that there was a direct mapping between the physical and
    DMA addresses. It turns out it didn't and the DMA accesses were
    going through a secondary, dedicated, bus that didn't have the same
    mapping of the RAM than the CPU.

    4690803b09c6 ("drm/sun4i: backend: Offset layer buffer address by DRAM =
starting address")

  - This dedicated bus is undocumented and barely used in the vendor
    kernel so this was overlooked, and it's fairly hard to get infos on
    it for all the SoCs we support. We added the DT support for it
    though on some SoCs we had enough infos to do so:

    c43a4469402f ("dt-bindings: interconnect: Add a dma interconnect name")
    22f88e311399 ("ARM: dts: sun5i: Add the MBUS controller")

    This explains the check on the interconnect property

  - However, due to the stable DT rule, we still need to operate without
    regressions on older DTs that wouldn't have that property (and for
    SoCs we haven't figured out). Hence the fallback.

> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
>=20
>   This driver unconditionally sets the offset.  Why can't we do this
>   in the device tree?
>=20
> drivers/staging/media/sunxi/cedrus/cedrus_hw.c
>=20
>   Same as above.
>

We should make those two match the previous ones, but we'll have the
same issue here eventually. Most likely they were never ran on an SoC
for which we have the MBUS figured out.

Maxime

--dpottggxee74tnew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6Ji0wAKCRDj7w1vZxhR
xfhqAQCGVXPQjuqueGxzvosMw+xeQPBqXhmwv85fYyeue+LdyAEA32seUuD5LvjK
NYOXbQBiz2tBS6ESieNJ73KOZrgtHgs=
=h/j1
-----END PGP SIGNATURE-----

--dpottggxee74tnew--

--===============1973347491188991805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1973347491188991805==--
