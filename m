Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACC1C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 12:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7ED4F82503;
	Wed, 18 May 2022 12:42:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hs0k467-FDmg; Wed, 18 May 2022 12:42:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4469B83104;
	Wed, 18 May 2022 12:42:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 042D8C0032;
	Wed, 18 May 2022 12:42:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C008C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 12:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A9E841B47
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 12:42:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aWOHxlDjh5h9 for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 12:42:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF8BF41B42
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 12:42:43 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id j24so2565823wrb.1
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=r0WuRCy57ME9/b73IbyYep69ZR4IeytcwMJ87H82uU4=;
 b=jSk9+R8cxOeyXi6+E2PLQfSYK70xpVuVe83u7ZfgcCItTFwW8cQextP7wiQhazKYby
 Rn+QK29RRxrCkm2pRDX83SnjP+4w93vAUOHStuqpCXO7IjjshbbcbB+pqypG4zPf56eD
 Fh5vvrqvZs2ss7QHRAxfDntjiKalEAcJ7QYr8iGZDeXcu3f2eppi6cWO9d/ZMQniH1Oe
 fZMstEv3t7ymdNlGverS97CjQCQpQtLsHgm4wm/pFrZOPgDs7aPOCsDSFllttmG1kHxR
 3TXaNPTRVlGaGpSyEtk5dnEveoF6q8Ed/Zt7rFC1+E9Fz5gZCvJCDnb4r6DmtWbl4a/r
 Ft/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r0WuRCy57ME9/b73IbyYep69ZR4IeytcwMJ87H82uU4=;
 b=vI8c1N8/Hj2WNeK312eq3XYBzxpKLv1bI6kDwV6Wk0wbbRQVPImyk3ks/HVLthk6PT
 M8OVaCAeQCF1RBAySbQDjn3PhQL5yyTNJk71n1Xa5KhBD2AwZ3ge/Q2R5ZOWAFAB8Yd4
 SFsxvUWSSmBV1SIkJMdG8+wjfqv7WMIlU5DhzpKz6Ob9Rd7N+5e5VPctaiClPgpiZrOY
 FX1OPBmu+rzF4LFXg6L26FJNcHkiQZK54KucISRKIe1uLqQXI25Z8CebHS0BbvTFBYGb
 fC87d51N82fB0x4m9GD6rVZQv4vPYa5iBMieytJU268eqBahLWEHmUR6MDwcjGd/nyDV
 f8zQ==
X-Gm-Message-State: AOAM531ylmaxckcNVb50GMb+OxvJO0miXmqd0tfWvwJwetTIPtb9uIph
 aq5H7k0hqRqnHo7GW/MyXhc=
X-Google-Smtp-Source: ABdhPJy2nI4P7bisbWR4+W5tEvfQfujR3047/B/qd+1mcJvJxceYo6djk+kfpCVY4+oN49C/QJ7DBw==
X-Received: by 2002:adf:f545:0:b0:20e:63b9:37ea with SMTP id
 j5-20020adff545000000b0020e63b937eamr1150863wrp.210.1652877761929; 
 Wed, 18 May 2022 05:42:41 -0700 (PDT)
Received: from orome ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 v65-20020a1cac44000000b003947b59dfdesm5310670wme.36.2022.05.18.05.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 05:42:40 -0700 (PDT)
Date: Wed, 18 May 2022 14:42:38 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v5 2/5] iommu: Implement of_iommu_get_resv_regions()
Message-ID: <YoTpvpHcB5j5x1Gn@orome>
References: <20220512190052.1152377-1-thierry.reding@gmail.com>
 <20220512190052.1152377-3-thierry.reding@gmail.com>
 <20220515111038.GE26732@jannau.net>
MIME-Version: 1.0
In-Reply-To: <20220515111038.GE26732@jannau.net>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Sameer Pujar <spujar@nvidia.com>,
 asahi@lists.linux.dev
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
Content-Type: multipart/mixed; boundary="===============5476295913263245893=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5476295913263245893==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NPNozwqlKWDehmxJ"
Content-Disposition: inline


--NPNozwqlKWDehmxJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 15, 2022 at 01:10:38PM +0200, Janne Grunau wrote:
> On 2022-05-12 21:00:49 +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > This is an implementation that IOMMU drivers can use to obtain reserved
> > memory regions from a device tree node. It uses the reserved-memory DT
> > bindings to find the regions associated with a given device. If these
> > regions are marked accordingly, identity mappings will be created for
> > them in the IOMMU domain that the devices will be attached to.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v5:
> > - update for new "iommu-addresses" device tree bindings
> >=20
> > Changes in v4:
> > - fix build failure on !CONFIG_OF_ADDRESS
> >=20
> > Changes in v3:
> > - change "active" property to identity mapping flag that is part of the
> >   memory region specifier (as defined by #memory-region-cells) to allow
> >   per-reference flags to be used
> >=20
> > Changes in v2:
> > - use "active" property to determine whether direct mappings are needed
> >=20
> >  drivers/iommu/of_iommu.c | 90 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of_iommu.h |  8 ++++
> >  2 files changed, 98 insertions(+)
> >=20
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 5696314ae69e..9e341b5e307f 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -11,12 +11,15 @@
> >  #include <linux/module.h>
> >  #include <linux/msi.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_iommu.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> >  #include <linux/fsl/mc.h>
> > =20
> > +#include <dt-bindings/reserved-memory.h>
> > +
> >  #define NO_IOMMU	1
> > =20
> >  static int of_iommu_xlate(struct device *dev,
> > @@ -172,3 +175,90 @@ const struct iommu_ops *of_iommu_configure(struct =
device *dev,
> > =20
> >  	return ops;
> >  }
> > +
> > +/**
> > + * of_iommu_get_resv_regions - reserved region driver helper for devic=
e tree
> > + * @dev: device for which to get reserved regions
> > + * @list: reserved region list
> > + *
> > + * IOMMU drivers can use this to implement their .get_resv_regions() c=
allback
> > + * for memory regions attached to a device tree node. See the reserved=
-memory
> > + * device tree bindings on how to use these:
> > + *
> > + *   Documentation/devicetree/bindings/reserved-memory/reserved-memory=
=2Etxt
> > + */
> > +void of_iommu_get_resv_regions(struct device *dev, struct list_head *l=
ist)
> > +{
> > +#if IS_ENABLED(CONFIG_OF_ADDRESS)
> > +	struct of_phandle_iterator it;
> > +	int err;
> > +
> > +	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0)=
 {
> > +		struct iommu_resv_region *region;
> > +		struct resource res;
> > +		const __be32 *maps;
> > +		int size;
>=20
> Adding 'if (!of_device_is_available(it.node)) continue;' here would help=
=20
> backwards compatibility. My plan was to add the reserved regions with=20
> "iommu-addresses" with all zero adresses and sizes with status =3D=20
> "disabled" to the devicetree. A bootloader update is required to fill=20
> those.

Yes, good point. My plan was originally to have the bootloader/firmware
generate these nodes in their entirety, but yeah, prepopulating them and
having firmware just fill in updated values and setting status =3D "okay"
seems reasonable to me.

> > +
> > +		memset(&res, 0, sizeof(res));
> > +
> > +		/*
> > +		 * The "reg" property is optional and can be omitted by reserved-mem=
ory regions
> > +		 * that represent reservations in the IOVA space, which are regions =
that should
> > +		 * not be mapped.
> > +		 */
> > +		if (of_find_property(it.node, "reg", NULL)) {
> > +			err =3D of_address_to_resource(it.node, 0, &res);
> > +			if (err < 0) {
> > +				dev_err(dev, "failed to parse memory region %pOF: %d\n",
> > +					it.node, err);
> > +				continue;
> > +			}
> > +		}
> > +
> > +		maps =3D of_get_property(it.node, "iommu-addresses", &size);
> > +		if (maps) {
> > +			const __be32 *end =3D maps + size / sizeof(__be32);
> > +			struct device_node *np;
> > +			unsigned int index =3D 0;
> > +			u32 phandle;
> > +			int na, ns;
> > +
> > +			while (maps < end) {
> > +				phys_addr_t start, end;
> > +				size_t length;
> > +
> > +				phandle =3D be32_to_cpup(maps++);
> > +				np =3D of_find_node_by_phandle(phandle);
> > +				na =3D of_n_addr_cells(np);
> > +				ns =3D of_n_size_cells(np);
> > +
> > +				start =3D of_translate_dma_address(np, maps);
> > +				length =3D of_read_number(maps + na, ns);
>=20
> alternatively we could handle mappings/reservations with length 0 as=20
> error and skip them.

I think we could do both.

Thanks for the feedback,
Thierry

--NPNozwqlKWDehmxJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKE6bsACgkQ3SOs138+
s6GnoQ//ZtatYKK568WV/5A02Y6Y4bGmQfrBw6kNbrHVG8OKoG1PQLnD0xP1anMx
pmZ4hK/aaLHCYeaGvTka7zvBp+qJTJ8C1eM5klaC5QnPlIRMEQlqbSrdYJopAvnv
TdX4oMOUb8CUMkEZiZ75dSc7ullskwt6GXCcp5TLqezlmZVxEGmYCm+/7ZcBFJ60
MbFuUPOZ366DtKo8a70ltZWq8vXhIeiK3muRoLObACIezgZEwOyPRHSATLGw+ppq
Fj36MTdnmxw7DBHm3z/9rF7mvtyiEcSdJpYMKaeuxg32e3/nVc1mhDUf4hm/cra8
CWRts2tbJG45mq94HwkkEX8JUmhfosnznPWxCfNA40e3D4gE6M5iOhh0zneD9DPL
fLV9t5B54ysUDbtWpVZkvBsoJhqjNGd/vXB6zVF89siHq4jEvKt9HO4bZe6NjvvY
g8ZP1upF+8ZhnUfF/W+idNlQ/apg5cikNLgDlg2ldoHsy7oZ0wH0YadZsmSj56zI
kjGfW2U0rng6c3rn0XIAkjDQTR7TmzRETXD3Bg9VPiAQtkjk6Y5NCZQ0RUmPS4xP
l1pkZKAd5ySaD6fMJmg+tFMDv/MoM64nzKDTxTN4uRdE1uSdwNxj8+1huBtyyu49
en+d+Pb/BZ46uK+5bukIOTV8e2NxUq33LhK1+YiClpS59wzS0jk=
=MV9M
-----END PGP SIGNATURE-----

--NPNozwqlKWDehmxJ--

--===============5476295913263245893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5476295913263245893==--
