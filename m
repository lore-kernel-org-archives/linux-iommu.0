Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F64C433E0
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 09:37:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691EB23135
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 09:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691EB23135
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F358D203FE;
	Tue, 19 Jan 2021 09:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JASKbGZu4P5; Tue, 19 Jan 2021 09:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A256E203E3;
	Tue, 19 Jan 2021 09:37:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8ECDAC088B;
	Tue, 19 Jan 2021 09:37:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97C0FC013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6A010203E3
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PCa7jTVVHSzw for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:37:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by silver.osuosl.org (Postfix) with ESMTPS id E0FB820029
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:37:28 +0000 (UTC)
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 807B6C0015;
 Tue, 19 Jan 2021 09:37:25 +0000 (UTC)
Date: Tue, 19 Jan 2021 10:37:25 +0100
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
Message-ID: <YAaoVTlCjriJt+iY@aptenodytes>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-7-yong.wu@mediatek.com>
 <20210114192732.GA3401278@robh.at.kernel.org>
 <1610688626.4578.1.camel@mhfsdcap03>
 <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
 <1611048011.14702.6.camel@mhfsdcap03>
MIME-Version: 1.0
In-Reply-To: <1611048011.14702.6.camel@mhfsdcap03>
Cc: youlin.pei@mediatek.com, Rob Herring <robh@kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Evan Green <evgreen@chromium.org>,
 linux-kernel@vger.kernel.org, chao.hao@mediatek.com,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============7926215872788844552=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7926215872788844552==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZpZRInV+koQDOukd"
Content-Disposition: inline


--ZpZRInV+koQDOukd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 19 Jan 21, 17:20, Yong Wu wrote:
> On Mon, 2021-01-18 at 15:49 +0000, Robin Murphy wrote:
> > On 2021-01-15 05:30, Yong Wu wrote:
> > > On Thu, 2021-01-14 at 13:27 -0600, Rob Herring wrote:
> > >> On Mon, Jan 11, 2021 at 07:18:47PM +0800, Yong Wu wrote:
> > >>> "dev->dma_range_map" contains the devices' dma_ranges information,
> > >>> This patch moves dma_range_map before of_iommu_configure. The iommu
> > >>> driver may need to know the dma_address requirements of its iommu
> > >>> consumer devices.
> > >>>
> > >>> CC: Rob Herring <robh+dt@kernel.org>
> > >>> CC: Frank Rowand <frowand.list@gmail.com>
> > >>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > >>> ---
> > >>>   drivers/of/device.c | 3 ++-
> > >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/of/device.c b/drivers/of/device.c
> > >>> index aedfaaafd3e7..1d84636149df 100644
> > >>> --- a/drivers/of/device.c
> > >>> +++ b/drivers/of/device.c
> > >>> @@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, st=
ruct device_node *np,
> > >>>   	dev_dbg(dev, "device is%sdma coherent\n",
> > >>>   		coherent ? " " : " not ");
> > >>>  =20
> > >>> +	dev->dma_range_map =3D map;
> > >>>   	iommu =3D of_iommu_configure(dev, np, id);
> > >>>   	if (PTR_ERR(iommu) =3D=3D -EPROBE_DEFER) {
> > >>>   		kfree(map);
> > >>> +		dev->dma_range_map =3D NULL;
> > >>
> > >> Not really going to matter, but you should probably clear dma_range_=
map
> > >> before what it points to is freed.
> > >>
> > >> With that,
> > >>
> > >> Reviewed-by: Rob Herring <robh@kernel.org>
> > >=20
> > > Thanks for the review. I will move it before "kfree(map)" in next
> > > version.
> >=20
> > Paul noticed that we already have a bug in assigning to this=20
> > unconditionally[1] - I'd totally forgotten about this series when I=20
> > theorised about IOMMU drivers wanting the information earlier, but=20
> > sweeping my inbox now only goes to show I was right to think of it :)
> >=20
> > We should really get something in as a fix independent of this series,=
=20
> > taking both angles into account.
>=20
> Thanks this info. Following your suggestion, Move this into the "if (!
> ret)". Then it is like this:

Thanks for preparing the change :)

>=20
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -163,8 +163,10 @@ int of_dma_configure_id(struct device *dev, struct
> device_node *np,
>  	dev->coherent_dma_mask &=3D mask;
>  	*dev->dma_mask &=3D mask;
>  	/* ...but only set bus limit if we found valid dma-ranges earlier */

Maybe the comment would need some update too, like:
/* ...but only set bus limit and map if we found valid dma-ranges earlier */

> -	if (!ret)
> +	if (!ret) {
>  		dev->bus_dma_limit =3D end;
> +		dev->dma_range_map =3D map;
> +	}
> =20
>  	coherent =3D of_dma_is_coherent(np);
>  	dev_dbg(dev, "device is%sdma coherent\n",
> @@ -172,6 +174,8 @@ int of_dma_configure_id(struct device *dev, struct
> device_node *np,
> =20
>  	iommu =3D of_iommu_configure(dev, np, id);
>  	if (PTR_ERR(iommu) =3D=3D -EPROBE_DEFER) {

And maybe one here, something like:
/* don't touch range map if it wasn't set from a valid dma-ranges */

> +		if (!ret)
> +			dev->dma_range_map =3D NULL;
>  		kfree(map);
>  		return -EPROBE_DEFER;
>  	}
> @@ -181,7 +185,6 @@ int of_dma_configure_id(struct device *dev, struct
> device_node *np,
> =20
>  	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> =20
> -	dev->dma_range_map =3D map;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
>=20
>=20
> If this is ok, I will send this as a independent patch.

With the suggested changes, this looks good to me!

Thanks,

Paul

> >=20
> > Robin.
> >=20
> > [1]=20
> > https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be097c=
7ceb32@arm.com/
> >=20
> > >>
> > >>>   		return -EPROBE_DEFER;
> > >>>   	}
> > >>>  =20
> > >>> @@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, str=
uct device_node *np,
> > >>>  =20
> > >>>   	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> > >>>  =20
> > >>> -	dev->dma_range_map =3D map;
> > >>>   	return 0;
> > >>>   }
> > >>>   EXPORT_SYMBOL_GPL(of_dma_configure_id);
> > >>> --=20
> > >>> 2.18.0
> > >>>
> > >=20
> > > _______________________________________________
> > > iommu mailing list
> > > iommu@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > >=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--ZpZRInV+koQDOukd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmAGqFQACgkQ3cLmz3+f
v9E3gwf8CT7hHXO41OxQvi2MFcgYFzwhZZyobCae68dTmEbC4OQjOxfwex0hT0Fc
fSqWrI33YU977JQ5MA+ZDZKJ9LenssabEikucOUfCCaiTxjy+EK7Sn83ub51okw+
IHa+n83H1G5nwTHPP1fn40z97Lyvk9wgOGRGtkqOuzADCoQ1ouQ6j0m+/nN0xJme
ORP/0J4qvKaZJznz7yDSPNP6QQ4UHXmg8e9CU9Oo9L6IaqH75jOJ0EtZDTrvqetL
Y2AzrZSrGESdcqXGAgO0sPICDorDbvP9dFGTsCeZwuM2lpCyWFRhE4sCQAA86NtG
JsLC4pzVbtkIepjP8eXSMmJf93G32g==
=pOip
-----END PGP SIGNATURE-----

--ZpZRInV+koQDOukd--

--===============7926215872788844552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7926215872788844552==--
