Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE11C433DF
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 10:03:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8272C22249
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 10:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8272C22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D20F08826C;
	Thu, 15 Oct 2020 10:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wYa3AG9O3S1a; Thu, 15 Oct 2020 10:03:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E827C88266;
	Thu, 15 Oct 2020 10:03:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B21C4C0052;
	Thu, 15 Oct 2020 10:03:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEF89C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 10:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B80D62044F
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 10:03:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sgVE0T1gAVaQ for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 10:03:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 807C4203F1
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 10:03:18 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 74A35AD52;
 Thu, 15 Oct 2020 10:03:16 +0000 (UTC)
Message-ID: <5eb3087cf1759f1b64c41831df86713be2a8be9d.camel@suse.de>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 15 Oct 2020 12:03:15 +0200
In-Reply-To: <20201015054244.GD12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de>
 <20201015054244.GD12218@lst.de>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com, robin.murphy@arm.com,
 jeremy.linton@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-rpi-kernel@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 ardb@kernel.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============2192968252926824411=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2192968252926824411==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-DdaQVRcydG0pvZBFwUQg"


--=-DdaQVRcydG0pvZBFwUQg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 07:42 +0200, Christoph Hellwig wrote:
> > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > +{
> > +	phys_addr_t max_cpu_addr =3D PHYS_ADDR_MAX;
> > +	struct of_range_parser parser;
> > +	phys_addr_t subtree_max_addr;
> > +	struct device_node *child;
> > +	phys_addr_t cpu_end =3D 0;
> > +	struct of_range range;
> > +	const __be32 *ranges;
> > +	int len;
> > +
> > +	if (!np)
> > +		np =3D of_root;
>=20
> Requiring of_root to be passed explicitly would seem more natural
> to me than the magic NULL argument.  There doesn't seem to be any
> precedent for that kind of calling convention either.

I inspired that behavior from __of_find_all_nodes(). I'll change it.


--=-DdaQVRcydG0pvZBFwUQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IHmMACgkQlfZmHno8
x/6x2wf3cODezG/BkxVJ0lm2jJwlIZdgVp6ej6JYJYQvyHPC1WK/PAQWv9VIZkFs
GkeoZcY+R3e8DJl3ka1/MMzqgpnhNJyK3WA0oYNO2fui0l/zj8Lx434XoPRckQjv
25uH8IkIVnU+uuPlCA4jrLrZRhRXsym29I2LS4qb6hMgOjR9rpjnv3dcUUgBzV0M
0oj7uENKePzPXrUfdSzyw/LWsWenHxgk6gzTSrbXeQ3L3x3NEEOfj1GdkOhaVgT+
v6vTCd2JIlcXT++CJjPaRMQKh1ymDOTnCixIvyQmsCc+kcVFTXhGqw0iBBc9uQzr
5wdzzRu2njggoZZdIr3y0OATsR/b
=L2vU
-----END PGP SIGNATURE-----

--=-DdaQVRcydG0pvZBFwUQg--


--===============2192968252926824411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2192968252926824411==--

