Return-Path: <SRS0=Te3Q=WX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E33FC3A5A3
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 07:03:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DEC206BF
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 07:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DEC206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9AB701055;
	Tue, 27 Aug 2019 07:03:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CB5D91052
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 07:03:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D932A1FB
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 07:03:47 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id F3D93B0DA;
	Tue, 27 Aug 2019 07:03:45 +0000 (UTC)
Date: Tue, 27 Aug 2019 09:03:41 +0200
From: Petr Tesarik <ptesarik@suse.cz>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 10/11] arm64: edit zone_dma_bits to fine tune
	dma-direct min mask
Message-ID: <20190827090341.2bf6b336@ezekiel.suse.cz>
In-Reply-To: <4d8d18af22d6dcd122bc9b4d9c2bd49e8443c746.camel@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
	<20190820145821.27214-11-nsaenzjulienne@suse.de>
	<20190826070633.GB11331@lst.de>
	<4d8d18af22d6dcd122bc9b4d9c2bd49e8443c746.camel@suse.de>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, frowand.list@gmail.com,
	Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
	f.fainelli@gmail.com, will@kernel.org,
	devicetree@vger.kernel.org, marc.zyngier@arm.com,
	robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, phill@raspberryi.org,
	mbrugger@suse.com, eric@anholt.net, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, wahrenst@gmx.net,
	akpm@linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============6019951043736438163=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============6019951043736438163==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vmjhQR+jY/bQH=VqrrKvOyt"; protocol="application/pgp-signature"

--Sig_/vmjhQR+jY/bQH=VqrrKvOyt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Aug 2019 13:08:50 +0200
Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:

> On Mon, 2019-08-26 at 09:06 +0200, Christoph Hellwig wrote:
> > On Tue, Aug 20, 2019 at 04:58:18PM +0200, Nicolas Saenz Julienne wrote:=
 =20
> > > -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> > > +	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> > >  		arm64_dma_phys_limit =3D max_zone_dma_phys();
> > > +		zone_dma_bits =3D ilog2((arm64_dma_phys_limit - 1) &
> > > GENMASK_ULL(31, 0)) + 1; =20
> > =20
> Hi Christoph,
> thanks for the rewiews.
>=20
> > This adds a way too long line. =20
>=20
> I know, I couldn't find a way to split the operation without making it ev=
en
> harder to read. I'll find a solution.

If all else fails, move the code to an inline function and call it e.g.
phys_limit_to_dma_bits().

Just my two cents,
Petr T

--Sig_/vmjhQR+jY/bQH=VqrrKvOyt
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl1k1c0ACgkQqlA7ya4P
R6ffZggAphWovRbYbJElIMDB+201+43NCpSH8dbZwe3UrJ+1DHzEn4OEldBRpcAv
CuA2/u6GyA8wgnGpCAKj9HNHWSx9VeFoCmf6kPVHFtoC0hnJyJtCCWS1O9B1nqXR
3h1Dw+6F/4wh14vqUucVvfseO/T1VV1QtfsczxBy2xEvcTZGhBjo7LEKeABa2yRm
CoPLGyNtTtNkAhXeSeVJUcuquOjdqrcU+RlCH5EIZZagAvXuNLryEsjjUfD4Lx35
RBeRcO+KmGJvAYuelWr/lqtO5ZUnD4OXoFE6fV7AvvJCD6RIHngLS4EXDIkGAaqd
kWlLtSieXZDEl0mMBdQBfSVcByyzKA==
=RDo8
-----END PGP SIGNATURE-----

--Sig_/vmjhQR+jY/bQH=VqrrKvOyt--

--===============6019951043736438163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6019951043736438163==--
