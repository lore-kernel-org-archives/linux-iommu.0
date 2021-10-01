Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BDC4321E
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 06:30:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0EB61A7E
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 06:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E0EB61A7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF5D640670;
	Fri,  1 Oct 2021 06:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SQMdOKz3dC8q; Fri,  1 Oct 2021 06:30:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F7954068D;
	Fri,  1 Oct 2021 06:30:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D9A2C0028;
	Fri,  1 Oct 2021 06:30:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A134C000F
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 06:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 195E740671
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 06:30:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hdkqjP-DNtIz for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 06:30:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3374A40658
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 06:30:48 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HLKxG5GSnz4xbT; Fri,  1 Oct 2021 16:30:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1633069842;
 bh=tuj7Sx6SMNyzgf92S3PRjpvS8Ufz0Db3Xwwl9IFP8Hs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TKQL9PMTi9o+MuKwqWHkZGuaAPcT+9o70w+u+0FgZXxwuwMWkOdTxnrShioro6Hd2
 9yWdYkETPDD2hMFDTPbpfeyWr81rou1I+aq00UZmnqNaG17L9vFkpGKzqpN06d2iEM
 1SJP15auciJg6X/+m4KF1IizBOwGs0UE4GmBIeoc=
Date: Fri, 1 Oct 2021 16:13:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YVanJqG2pt6g+ROL@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210921174438.GW327412@nvidia.com>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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
Content-Type: multipart/mixed; boundary="===============7093491052370841039=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7093491052370841039==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JTmojUz8JowWR2jU"
Content-Disposition: inline


--JTmojUz8JowWR2jU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2021 at 02:44:38PM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 19, 2021 at 02:38:39PM +0800, Liu Yi L wrote:
> > This patch adds IOASID allocation/free interface per iommufd. When
> > allocating an IOASID, userspace is expected to specify the type and
> > format information for the target I/O page table.
> >=20
> > This RFC supports only one type (IOMMU_IOASID_TYPE_KERNEL_TYPE1V2),
> > implying a kernel-managed I/O page table with vfio type1v2 mapping
> > semantics. For this type the user should specify the addr_width of
> > the I/O address space and whether the I/O page table is created in
> > an iommu enfore_snoop format. enforce_snoop must be true at this point,
> > as the false setting requires additional contract with KVM on handling
> > WBINVD emulation, which can be added later.
> >=20
> > Userspace is expected to call IOMMU_CHECK_EXTENSION (see next patch)
> > for what formats can be specified when allocating an IOASID.
> >=20
> > Open:
> > - Devices on PPC platform currently use a different iommu driver in vfi=
o.
> >   Per previous discussion they can also use vfio type1v2 as long as the=
re
> >   is a way to claim a specific iova range from a system-wide address sp=
ace.
> >   This requirement doesn't sound PPC specific, as addr_width for pci de=
vices
> >   can be also represented by a range [0, 2^addr_width-1]. This RFC hasn=
't
> >   adopted this design yet. We hope to have formal alignment in v1 discu=
ssion
> >   and then decide how to incorporate it in v2.
>=20
> I think the request was to include a start/end IO address hint when
> creating the ios. When the kernel creates it then it can return the
> actual geometry including any holes via a query.

So part of the point of specifying start/end addresses is that
explicitly querying holes shouldn't be necessary: if the requested
range crosses a hole, it should fail.  If you didn't really need all
that range, you shouldn't have asked for it.

Which means these aren't really "hints" but optionally supplied
constraints.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JTmojUz8JowWR2jU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFWpyUACgkQbDjKyiDZ
s5IGlg//alLq8rOP9c6VW4SoUf7Dw0IUnMOnXGk0Bq4d3IOxACK9H4AxImJ8KVHo
LxiFw8PLJbd+ZoSZEjBhDx4p1i01UuBQDEOJL6tXkeZuIIhBjsgDdGdGRa44pDrD
HajXTrRUoelS8W+v721yYDMHti4WQRx5/drW0t8GrxmcS5lP9rc+zlvSze28WTsv
WZcfLDHTq5pSij8bGRWMeTonXf5jtHh7IGk7AnsFYaMraHyRTc3xD0rrpogbW03f
9BSPm1jbbqagdL0vsd5Nake1Ko/7Y1eRD3SxkL1KT2wEKQJhyOV6UwToXjKlLLLn
2DIDpGXoFcb9jTbmDaRyfwFWVsq40QWz1x+BBBmiw0zQ2x+Si+nIXU3QC0dGfxKm
QqHaC1MmS4EHToeOCAQoi9dvXSG+rgdW6/d8JzLbjnt+nJKVajUYybP1v7fCacYr
ZWobUX9ONlgMUrPCPU8SVX/J+ykWsYWzJGGwZmv5CYEs4tTzovV62LK2yTf6P4RN
tfq4gSCAHkS03eYgZt2znel63WQTIagm0+XiXjR45e7c+EnUeP+GIiAC1s7+agE8
OrEC3YHn/c34TTlgzIwPj++PHrKndEsT3+IDzadnKhWtz3Auqv6I8sX772nvtqaS
72zLbSgadyOLJDjrCATWXQD6r4xGN/V6w29KG6G8sioYn9DsPuA=
=erif
-----END PGP SIGNATURE-----

--JTmojUz8JowWR2jU--

--===============7093491052370841039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7093491052370841039==--
