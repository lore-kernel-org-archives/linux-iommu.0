Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E0C433DF
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 10:05:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DF320776
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 10:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DF320776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4429087EEC;
	Thu, 15 Oct 2020 10:05:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UASnWNpAqx7l; Thu, 15 Oct 2020 10:05:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A974F87EDD;
	Thu, 15 Oct 2020 10:05:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FC2BC07FF;
	Thu, 15 Oct 2020 10:05:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA4CCC0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 10:05:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D80508826C
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 10:05:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OELZ_0CcoMpj for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 10:05:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6852A88266
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 10:05:50 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 07720AC5F;
 Thu, 15 Oct 2020 10:05:49 +0000 (UTC)
Message-ID: <e14f6d6b12962da6cd32462b02b0bf051444894b.camel@suse.de>
Subject: Re: [PATCH v3 6/8] arm64: mm: Set ZONE_DMA size based on
 devicetree's dma-ranges
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 15 Oct 2020 12:05:47 +0200
In-Reply-To: <20201015053948.GB12218@lst.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-7-nsaenzjulienne@suse.de>
 <20201015053948.GB12218@lst.de>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-rpi-kernel@lists.infradead.org, robin.murphy@arm.com, ardb@kernel.org,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============4819153422766304565=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4819153422766304565==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-OaOQtpsUFcwLROOxxpTG"


--=-OaOQtpsUFcwLROOxxpTG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 07:39 +0200, Christoph Hellwig wrote:
> On Wed, Oct 14, 2020 at 09:12:08PM +0200, Nicolas Saenz Julienne wrote:
> > +	zone_dma_bits =3D min(zone_dma_bits,
> > +			    (unsigned int)ilog2(of_dma_get_max_cpu_address(NULL)));
>=20
> Plase avoid pointlessly long lines.  Especially if it is completely trivi=
al
> by using either min_t or not overindenting like here.

Noted


--=-OaOQtpsUFcwLROOxxpTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IHvsACgkQlfZmHno8
x/511ggAimtLNT1WNeWV5A+8xmnbf6JaeGSMxX4cRu7fCOEQY3+w1xLBF994fK2Z
kHNQZKeMTUpyU5J1peNUeL52DcoXp3z8htpZnX/w3v1RR8SRfii+A/t0d0uFKMeo
v7Fs/E4MHQDQWCfOBFCZM3htkNroqUEPAqYokg3He813rN9XLva43uK4ZovOHOC6
9JN/hGr8SIH4ETOtshdRr5vOtXWfDNAvF1xXn/7GBiZQvK4JqYn+xQQH2+Of8X+G
hF6lOhwA0/OZr33K5Dg0E+8wBDFGYwkX8UQ4BQpQC6vplNalO7Uo3TtQdqrEPB6W
L9yUr3CbkmXh5Uo5Wl5oa/bf5phnpw==
=NZRQ
-----END PGP SIGNATURE-----

--=-OaOQtpsUFcwLROOxxpTG--


--===============4819153422766304565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4819153422766304565==--

