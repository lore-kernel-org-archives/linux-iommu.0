Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DA5C433E0
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 09:13:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540EA2333D
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 09:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540EA2333D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B786020478;
	Tue, 19 Jan 2021 09:13:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OzBC3vLdYSw0; Tue, 19 Jan 2021 09:13:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 40017200ED;
	Tue, 19 Jan 2021 09:13:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C797C088B;
	Tue, 19 Jan 2021 09:13:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62E67C013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3EEFF8670E
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:13:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NSirspdxlKtX for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:13:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BB6618560F
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:13:17 +0000 (UTC)
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 702B24001D;
 Tue, 19 Jan 2021 09:13:11 +0000 (UTC)
Date: Tue, 19 Jan 2021 10:13:10 +0100
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
Message-ID: <YAaipp7Srf6uUdFZ@aptenodytes>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-7-yong.wu@mediatek.com>
 <20210114192732.GA3401278@robh.at.kernel.org>
 <1610688626.4578.1.camel@mhfsdcap03>
 <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
MIME-Version: 1.0
In-Reply-To: <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
Cc: youlin.pei@mediatek.com, Rob Herring <robh@kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============7645857448736174541=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7645857448736174541==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9JUkddB3RODiIlTw"
Content-Disposition: inline


--9JUkddB3RODiIlTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon 18 Jan 21, 15:49, Robin Murphy wrote:
> On 2021-01-15 05:30, Yong Wu wrote:
> > On Thu, 2021-01-14 at 13:27 -0600, Rob Herring wrote:
> > > On Mon, Jan 11, 2021 at 07:18:47PM +0800, Yong Wu wrote:
> > > > "dev->dma_range_map" contains the devices' dma_ranges information,
> > > > This patch moves dma_range_map before of_iommu_configure. The iommu
> > > > driver may need to know the dma_address requirements of its iommu
> > > > consumer devices.
> > > >=20
> > > > CC: Rob Herring <robh+dt@kernel.org>
> > > > CC: Frank Rowand <frowand.list@gmail.com>
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >   drivers/of/device.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > > index aedfaaafd3e7..1d84636149df 100644
> > > > --- a/drivers/of/device.c
> > > > +++ b/drivers/of/device.c
> > > > @@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, st=
ruct device_node *np,
> > > >   	dev_dbg(dev, "device is%sdma coherent\n",
> > > >   		coherent ? " " : " not ");
> > > > +	dev->dma_range_map =3D map;
> > > >   	iommu =3D of_iommu_configure(dev, np, id);
> > > >   	if (PTR_ERR(iommu) =3D=3D -EPROBE_DEFER) {
> > > >   		kfree(map);
> > > > +		dev->dma_range_map =3D NULL;
> > >=20
> > > Not really going to matter, but you should probably clear dma_range_m=
ap
> > > before what it points to is freed.
> > >=20
> > > With that,
> > >=20
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >=20
> > Thanks for the review. I will move it before "kfree(map)" in next
> > version.
>=20
> Paul noticed that we already have a bug in assigning to this
> unconditionally[1] - I'd totally forgotten about this series when I
> theorised about IOMMU drivers wanting the information earlier, but sweepi=
ng
> my inbox now only goes to show I was right to think of it :)
>=20
> We should really get something in as a fix independent of this series,
> taking both angles into account.

Okay, I can also fix this while fixing my case. So we'd go for setting
dev->dma_range_map =3D map; under the if (!ret).

Then I think the error case for of_iommu_configure should be to set
dev->dma_range_map =3D NULL; only if map !=3D NULL (otherwise we'd be overw=
riting
and leaking the previously-set map).

I think a comment to remind that dev->dma_range_map can be set prior to this
function would be useful too.

What do you think?

Cheers,

Paul

> Robin.
>=20
> [1] https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be09=
7c7ceb32@arm.com/
>=20
> > >=20
> > > >   		return -EPROBE_DEFER;
> > > >   	}
> > > > @@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, str=
uct device_node *np,
> > > >   	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> > > > -	dev->dma_range_map =3D map;
> > > >   	return 0;
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(of_dma_configure_id);
> > > > --=20
> > > > 2.18.0
> > > >=20
> >=20
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--9JUkddB3RODiIlTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmAGoqYACgkQ3cLmz3+f
v9GonQf/efUk6Macghd2ipStYZpoRfxYwHOuemUNFudMoUEZ3WfF8oq65Qp+I6jx
5f0iHYTgcPXsTDkMgyPINgSmcuagEYEDUH+IkPoJBvZZ8T2/oI5E0y4xGbbpLtfK
hGfAg1spG4E0akpjq/2wNSYkiUiVIdXsFHPXrMNez3j0Z8VJKTBoETeb88QoAOaJ
KtcJHmcIW3Gi2fYp/EMBbe+oMbairUCcnnqXZLZjYRSfHl+4EpH9T/FmaI2rtgoE
xXedTQFz7axYSXPqHR0WWkg0P876yNO+jkd387VvBvC9AxZYMyFngHVDYM4e4Edx
eE2MYAMyuHp/V4AlneqACADHWyS/oQ==
=2EGZ
-----END PGP SIGNATURE-----

--9JUkddB3RODiIlTw--

--===============7645857448736174541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7645857448736174541==--
