Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C8CC47093
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:29:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E7A611CA
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E7A611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D51060891;
	Wed,  2 Jun 2021 07:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZlFWvy0I8OJu; Wed,  2 Jun 2021 07:29:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 315F4608A6;
	Wed,  2 Jun 2021 07:29:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACDA2C0025;
	Wed,  2 Jun 2021 07:29:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D81B1C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C76D682532
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O60nK_4ylHpt for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:29:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0D74836E1
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:18 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Fw0yh4N0nz9sW4; Wed,  2 Jun 2021 17:29:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622618956;
 bh=uGza2ambRaw52uUD6+0AHLe+nMsKVTQGJ2WrG5YyBgM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tjx74IuRulizpaNftVChf7BNNeGl+1EoQNhIlUofWpJQxeibH3wdkpHdG2F9SnY3M
 /+XTbp+kE+ukN9tHYbjk6ddIPAas4n4QjEsZOYxVxc7/4EeaRuhvn2Mb03GDarZYdi
 vRQ/ZSkrrqyNesAQVv650ekDxOUzfDCcA7V0Fxwg=
Date: Wed, 2 Jun 2021 17:22:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLcxpYDkT1h7hIbQ@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210528233649.GB3816344@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============7325152437516531267=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7325152437516531267==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j/FYRtVn/XN5nkYp"
Content-Disposition: inline


--j/FYRtVn/XN5nkYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 28, 2021 at 08:36:49PM -0300, Jason Gunthorpe wrote:
> On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
>=20
> > 2.1. /dev/ioasid uAPI
> > +++++++++++++++++
> >=20
> > /*
> >   * Check whether an uAPI extension is supported.=20
> >   *
> >   * This is for FD-level capabilities, such as locked page pre-registra=
tion.=20
> >   * IOASID-level capabilities are reported through IOASID_GET_INFO.
> >   *
> >   * Return: 0 if not supported, 1 if supported.
> >   */
> > #define IOASID_CHECK_EXTENSION	_IO(IOASID_TYPE, IOASID_BASE + 0)
>=20
> =20
> > /*
> >   * Register user space memory where DMA is allowed.
> >   *
> >   * It pins user pages and does the locked memory accounting so sub-
> >   * sequent IOASID_MAP/UNMAP_DMA calls get faster.
> >   *
> >   * When this ioctl is not used, one user page might be accounted
> >   * multiple times when it is mapped by multiple IOASIDs which are
> >   * not nested together.
> >   *
> >   * Input parameters:
> >   *	- vaddr;
> >   *	- size;
> >   *
> >   * Return: 0 on success, -errno on failure.
> >   */
> > #define IOASID_REGISTER_MEMORY	_IO(IOASID_TYPE, IOASID_BASE + 1)
> > #define IOASID_UNREGISTER_MEMORY	_IO(IOASID_TYPE, IOASID_BASE + 2)
>=20
> So VA ranges are pinned and stored in a tree and later references to
> those VA ranges by any other IOASID use the pin cached in the tree?
>=20
> It seems reasonable and is similar to the ioasid parent/child I
> suggested for PPC.
>=20
> IMHO this should be merged with the all SW IOASID that is required for
> today's mdev drivers. If this can be done while keeping this uAPI then
> great, otherwise I don't think it is so bad to weakly nest a physical
> IOASID under a SW one just to optimize page pinning.

Right, I think we can simplify the interface by modelling the
preregistration as a nesting layer.  Well, mostly.. the wrinkle is
that generally you can't do anything with an ioasid until you've
attached devices to it, but that doesn't really make sense for the
prereg layer.  I expect we can find some way to deal with that,
though.

Actually... to simplify that "weak nesting" concept I wonder if we
want to expand to 3 ways of specifying the pagetables for the ioasid:
  1) kernel managed (MAP/UNMAP)
  2) user managed (BIND/INVALIDATE)
  3) pass-though (IOVA=3D=3Dparent address)

Obviously pass-through wouldn't be allowed in all circumstances.

> Either way this seems like a smart direction
>=20
> > /*
> >   * Allocate an IOASID.=20
> >   *
> >   * IOASID is the FD-local software handle representing an I/O address=
=20
> >   * space. Each IOASID is associated with a single I/O page table. User=
=20
> >   * must call this ioctl to get an IOASID for every I/O address space t=
hat is
> >   * intended to be enabled in the IOMMU.
> >   *
> >   * A newly-created IOASID doesn't accept any command before it is=20
> >   * attached to a device. Once attached, an empty I/O page table is=20
> >   * bound with the IOMMU then the user could use either DMA mapping=20
> >   * or pgtable binding commands to manage this I/O page table.
>=20
> Can the IOASID can be populated before being attached?

I don't think it reasonably can.  Until attached, you don't actually
know what hardware IOMMU will be backing it, and therefore you don't
know it's capabilities.  You can't really allow mappings if you don't
even know allowed IOVA ranges and page size.

> >   * Device attachment is initiated through device driver uAPI (e.g. VFI=
O)
> >   *
> >   * Return: allocated ioasid on success, -errno on failure.
> >   */
> > #define IOASID_ALLOC	_IO(IOASID_TYPE, IOASID_BASE + 3)
> > #define IOASID_FREE	_IO(IOASID_TYPE, IOASID_BASE + 4)
>=20
> I assume alloc will include quite a big structure to satisfy the
> various vendor needs?
>=20
> > /*
> >   * Get information about an I/O address space
> >   *
> >   * Supported capabilities:
> >   *	- VFIO type1 map/unmap;
> >   *	- pgtable/pasid_table binding
> >   *	- hardware nesting vs. software nesting;
> >   *	- ...
> >   *
> >   * Related attributes:
> >   * 	- supported page sizes, reserved IOVA ranges (DMA mapping);
> >   *	- vendor pgtable formats (pgtable binding);
> >   *	- number of child IOASIDs (nesting);
> >   *	- ...
> >   *
> >   * Above information is available only after one or more devices are
> >   * attached to the specified IOASID. Otherwise the IOASID is just a
> >   * number w/o any capability or attribute.
>=20
> This feels wrong to learn most of these attributes of the IOASID after
> attaching to a device.

Yes... but as above, we have no idea what the IOMMU's capabilities are
until devices are attached.

> The user should have some idea how it intends to use the IOASID when
> it creates it and the rest of the system should match the intention.
>=20
> For instance if the user is creating a IOASID to cover the guest GPA
> with the intention of making children it should indicate this during
> alloc.
>=20
> If the user is intending to point a child IOASID to a guest page table
> in a certain descriptor format then it should indicate it during
> alloc.
>=20
> device bind should fail if the device somehow isn't compatible with
> the scheme the user is tring to use.

[snip]
> > 2.2. /dev/vfio uAPI
> > ++++++++++++++++
>=20
> To be clear you mean the 'struct vfio_device' API, these are not
> IOCTLs on the container or group?
>=20
> > /*
> >    * Bind a vfio_device to the specified IOASID fd
> >    *
> >    * Multiple vfio devices can be bound to a single ioasid_fd, but a si=
ngle
> >    * vfio device should not be bound to multiple ioasid_fd's.
> >    *
> >    * Input parameters:
> >    *  - ioasid_fd;
> >    *
> >    * Return: 0 on success, -errno on failure.
> >    */
> > #define VFIO_BIND_IOASID_FD           _IO(VFIO_TYPE, VFIO_BASE + 22)
> > #define VFIO_UNBIND_IOASID_FD _IO(VFIO_TYPE, VFIO_BASE + 23)
>=20
> This is where it would make sense to have an output "device id" that
> allows /dev/ioasid to refer to this "device" by number in events and
> other related things.

The group number could be used for that, even if there are no group
fds.  You generally can't identify things more narrowly than group
anyway.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--j/FYRtVn/XN5nkYp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC3MZ8ACgkQbDjKyiDZ
s5Lp5hAAruXb3NLVtuLjvyAaqaKjXI0hJf+T5aYV2GsPEuBFfL3eejzD0+HE4dI8
Ww0npi2zKzGpAmFoPvMvfpYsANsnmLH5MdHs2DJ9WxFPGvSF67gZLc44rx1XBc2T
7IboRgMjF5kcKo0HFI+M7pkuvkwMEkkzZzMj7LQtSGOdyFewTJO24aSQZPwTv+JR
/+MXWXQqI1zkfOIVm8kCHqtAcz5Z6IlXJ1JYeRxLBZou8j1JJqkq1Xt/pEXhI1oZ
uIuoQxBwBOEoqBtnlmvUWPYfZ8MI0LnJdMWvBAkqFwzMMgkzfqxM4+hV8OfVBRyh
R6ZIVtEyNT5EuoTVLz8HEPUMgdMNgu9xObrZBRXJpzv/+lV010P44354bz3VxEvi
sgwjcCNYH8ZXNq3LuJOs1ApKoSwrE+FDNxJe5RmHVNp0ORzRqVeZ33JZS+sSk/CI
aem0ComVy47umR3JTjjiq+mBhQDISCIh7efu4tYLZsLbE3zKeHEfq7s87v8yYVcG
tcUzKYNMUONch/X+ChfbmubBr4aVxpgZ1BU3UzfTmQUWybljRVTdMA5qOsBewNIY
g9AMwr4/JWlA74pERIu+EDqPLAXt4DRHf7kmiG/uKTlZenCopwn3QGs40W+dAF7Y
82Etp785d9v9Yg8v5JMKc4nNcY4MK2ilEd0QVB+sK3kX3Zea6CM=
=TTLB
-----END PGP SIGNATURE-----

--j/FYRtVn/XN5nkYp--

--===============7325152437516531267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7325152437516531267==--
