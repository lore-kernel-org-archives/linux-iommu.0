Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7423C433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 10:35:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9848520739
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 10:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9848520739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 61F4289470;
	Wed,  8 Jul 2020 10:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R7CpLxnrQIyR; Wed,  8 Jul 2020 10:35:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D270589465;
	Wed,  8 Jul 2020 10:35:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9355C077B;
	Wed,  8 Jul 2020 10:35:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CC0DC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 10:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 483328946E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 10:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 42nFrGUXXrET for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 10:35:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F025E89465
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 10:35:38 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 52AA1AC53;
 Wed,  8 Jul 2020 10:35:37 +0000 (UTC)
Message-ID: <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Jeremy Linton <jeremy.linton@arm.com>, Christoph Hellwig <hch@lst.de>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
Date: Wed, 08 Jul 2020 12:35:34 +0200
In-Reply-To: <e6504dc5-4169-edf9-d08e-17a378a1ef7a@arm.com>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
 <e6504dc5-4169-edf9-d08e-17a378a1ef7a@arm.com>
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============4554653512517183671=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4554653512517183671==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-bnAJ3XLxuxNA1ZPiHOdm"


--=-bnAJ3XLxuxNA1ZPiHOdm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jim,

On Tue, 2020-07-07 at 17:08 -0500, Jeremy Linton wrote:
> Hi,
>=20
> I spun this up on my 8G model using the PFTF firmware from:
>=20
> https://github.com/pftf/RPi4/releases
>=20
> Which allows me to switch between ACPI/DT on the machine. In DT mode it=
=20
> works fine now,=20

Nice, would that count as a Tested-by from you?

> but with ACPI I continue to have failures unless I=20
> disable CMA via cma=3D0 on the kernel command line.=20

Yes, I see why, in atomic_pool_expand() memory is allocated from CMA withou=
t
checking its correctness. That calls for a separate fix. I'll try to think =
of
something.

> It think that is because
>=20
> using DT:
>=20
> [    0.000000] Reserved memory: created CMA memory pool at
> 0x0000000037400000, size 64 MiB
>=20
>=20
> using ACPI:
> [    0.000000] cma: Reserved 64 MiB at 0x00000000f8000000
>=20
> Which is AFAIK because the default arm64 CMA allocation is just below=20
> the arm64_dma32_phys_limit.

As I'm sure you know, we fix the CMA address trough DT, isn't that possible
trough ACPI?

Regards,
Nicolas


--=-bnAJ3XLxuxNA1ZPiHOdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8FoXYACgkQlfZmHno8
x/4A1Af/cSs8xlWTPpYUFQ6HpjKk8LJ80zIBr1nld7DKsJH3aV7pkT2+pDvdro26
g4qSXpPsH+9Ru29z1eViXhXNwyazsyXUCHOY66QdlFVFtWnD8wYqxQj7cWCyiRwE
+DiHDBRH69MusXE+11rstR2JBJDISdNYxyLAEAByDRfxq0CHYLI2mIY69Qdu3qK/
G8Udgvqpjc+S7ywvgxVMOVIxKRdq+QpkjaToQt0u8V1VGaKqQ61lNVOYzmCRyeIF
4f3Y+nBqL36I5n5GWY/qmNurJkcy7JuEYXtf6+0bupSM7wHbPCTxweaL4kKaJEwn
/JaA8YIaJjTDqEpYesnAiuSGN/ckTw==
=PfbY
-----END PGP SIGNATURE-----

--=-bnAJ3XLxuxNA1ZPiHOdm--


--===============4554653512517183671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4554653512517183671==--

