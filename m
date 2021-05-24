Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03832C04FF3
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 07:56:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7932610C7
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 07:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7932610C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A1F6401B6;
	Mon, 24 May 2021 07:56:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ToLbTiG7k_in; Mon, 24 May 2021 07:56:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4CA4E400FB;
	Mon, 24 May 2021 07:56:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A427C000E;
	Mon, 24 May 2021 07:56:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA21C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 07:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8527260673
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 07:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i2TVdUWHS7ie for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 07:56:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18AFD6059A
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 07:56:12 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FpTzt3P3Mz9sPf; Mon, 24 May 2021 17:56:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1621842970;
 bh=C/hH2K1GEBPadXoSrKk7V2ObPasOjkp3z+Am5C3tgTM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SlkI23zR6q71HmYnJJ3f9KWdOEkVnA6VgflwcXorCZ+xSlbOn80eH8qqkj1bGiDwr
 KC9B7UJXnzhSsKRs2ic63ipbacchSoGdi4E458+5M7iaEJIuB0k7HuIOJAPxbDK6pB
 dK2O+tSql9Eour4tx4hSxxkcAjj0iCOHwEc2IDJA=
Date: Mon, 24 May 2021 17:56:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YKtcFdW9U2+iW4cM@yekko>
References: <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com> <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com> <YJDFj+sAv41JRIo4@yekko>
 <20210504181537.GC1370958@nvidia.com>
 <7e5c2276-ca1c-a8af-c15f-72a7c83c8bfa@ozlabs.ru>
 <20210505163902.GG1370958@nvidia.com> <YJzCC18cQDdKMR6p@yekko>
 <20210513135030.GF1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210513135030.GF1002214@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============1063051639821322897=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1063051639821322897==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qdaYK/TYh/pdg5Us"
Content-Disposition: inline


--qdaYK/TYh/pdg5Us
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2021 at 10:50:30AM -0300, Jason Gunthorpe wrote:
> On Thu, May 13, 2021 at 04:07:07PM +1000, David Gibson wrote:
> > On Wed, May 05, 2021 at 01:39:02PM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 05, 2021 at 02:28:53PM +1000, Alexey Kardashevskiy wrote:
> > >=20
> > > > This is a good feature in general when let's say there is a linux s=
upported
> > > > device which has a proprietary device firmware update tool which on=
ly exists
> > > > as an x86 binary and your hardware is not x86 - running qemu + vfio=
 in full
> > > > emulation would provide a way to run the tool to update a physical =
device.
> > >=20
> > > That specific use case doesn't really need a vIOMMU though, does it?
> >=20
> > Possibly not, but the mechanics needed to do vIOMMU on different host
> > IOMMU aren't really different from what you need for a no-vIOMMU
> > guest. =20
>=20
> For very simple vIOMMUs this might be true, but this new features of nest=
ing
> PASID, migration, etc, etc all make the vIOMMU complicated and
> emuluating it completely alot harder.

Well, sure, emulating a complex vIOMMU is complex. But "very simple
vIOMMUs" covers the vast majority of currently deployed hardware, and
several are already emulated by qemu.

> Stuffing a vfio-pci into a guest and creating a physical map using a
> single IOASID is comparably trivial.

Note that for PAPR (POWER guest) systems this is not an option: the
PAPR platform *always* has a vIOMMU.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qdaYK/TYh/pdg5Us
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCrXBUACgkQbDjKyiDZ
s5IBMw/6AomCVLmh/8hoxD3OLa7DsF2qksrpcbo5JXuotCrUKLd+NER23oRbTekN
8HQ/YKfUWhmFlGh9NeBcjjUjkm/ru1HFa3vbGfQIrVWxabmQX9vQSjKDc/qvQlKB
ApOyT0PNJuHFy8rZNB7vrpd9zP9xhV1gKLk5nxmmPHeITxA2ZLrZSlfMkRhIG5vP
3xpnCB8KoycgXBsYbLCi50o11TxhVlYWoujMA/I69mLgfqFoxTy3+zz99RtEEnY9
Nqf3jnnpL+5tCu8gBZD2actRlu0jrnXU6nyYleOy89Sr2ZjrOM73cfrkrJjhuTa6
hdQVhb8XgS1HQPiELvT2WCVVQkfAG1ss0HcPi2Wt+JvVnxeQ4kNixS8ZNwh/X9/Q
lMVqY0OsG8Gz38XftHA3oj20IyAKeVYfXkQJLougTadA3/ydrOELNB169PPHtggT
qtgvOFogrmYKJyaGQaQvWIWmHd63OYqVxycbu2fimxeuM4kMxgU5ERWo6caXHLz+
bZfdkrRUW1vCGoMfjqpjG4OgDhnLwz4PUfy7tKdh6Ek4TGe0OUHYxcMcJI28AIii
jnapbsmXzLYgsyHou+UYRwtLPrIOjOpRh3eDRzfRDtI1HQBWG1RBKkJdqUf1r5FW
r45iEZaQ+AdySJsDkfCc7+SDhLx4AO8z6RuoKgukxPR6E5D8Z9c=
=GQEt
-----END PGP SIGNATURE-----

--qdaYK/TYh/pdg5Us--

--===============1063051639821322897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1063051639821322897==--
