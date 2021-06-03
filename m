Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CD3C47242
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8FE613FA
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8FE613FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9380540515;
	Thu,  3 Jun 2021 06:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1tkGiMBrjBp7; Thu,  3 Jun 2021 06:28:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36C5840510;
	Thu,  3 Jun 2021 06:28:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F25D1C0025;
	Thu,  3 Jun 2021 06:28:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF645C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B57FE405B7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id knI7cY5r-IGU for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 06:28:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEE0D4059A
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:28 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FwbYy71WNz9sXL; Thu,  3 Jun 2021 16:28:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622701702;
 bh=cTwVnIFTZKt9mDLUFydsyzbNUUaTjzx27s1g2jtwlGE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OXJffrQW11S12kndAx7p9k3y4f5O4FtOyPV8J0fuXBCL4hyEJTVYjvAimlktJ2yMz
 UcZAAzo6eIw8Zk1+Luhzl3tSsjZ/2uRSreKspdMFxw2sLjJKyCz+tFpz3uIESF606K
 LskCQb9aCbom1pr+8x3UR2W6C1cNW68J9Az4r1aw=
Date: Thu, 3 Jun 2021 16:26:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLh2APcZFpDoqOKG@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YLch6zbbYqV4PyVf@yekko> <20210602171930.GB1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210602171930.GB1002214@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============4956208400470294329=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4956208400470294329==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FAcR9kiyfl4RJ44h"
Content-Disposition: inline


--FAcR9kiyfl4RJ44h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 02:19:30PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 02, 2021 at 04:15:07PM +1000, David Gibson wrote:
>=20
> > Is there a compelling reason to have all the IOASIDs handled by one
> > FD?
>=20
> There was an answer on this, if every PASID needs an IOASID then there
> are too many FDs.

Too many in what regard?  fd limits?  Something else?

It seems to be there are two different cases for PASID handling here.
One is where userspace explicitly creates each valid PASID and
attaches a separate pagetable for each (or handles each with
MAP/UNMAP).  In that case I wouldn't have expected there to be too
many fds.

Then there's the case where we register a whole PASID table, in which
case I think you only need the one FD.  We can treat that as creating
an 84-bit IOAS, whose pagetable format is (PASID table + a bunch of
pagetables for each PASID).

> It is difficult to share the get_user_pages cache across FDs.

Ah... hrm, yes I can see that.

> There are global properties in the /dev/iommu FD, like what devices
> are part of it, that are important for group security operations. This
> becomes confused if it is split to many FDs.

I'm still not seeing those.  I'm really not seeing any well-defined
meaning to devices being attached to the fd, but not to a particular
IOAS.

> > > I/O address space can be managed through two protocols, according to=
=20
> > > whether the corresponding I/O page table is constructed by the kernel=
 or=20
> > > the user. When kernel-managed, a dma mapping protocol (similar to=20
> > > existing VFIO iommu type1) is provided for the user to explicitly spe=
cify=20
> > > how the I/O address space is mapped. Otherwise, a different protocol =
is=20
> > > provided for the user to bind an user-managed I/O page table to the=
=20
> > > IOMMU, plus necessary commands for iotlb invalidation and I/O fault=
=20
> > > handling.=20
> > >=20
> > > Pgtable binding protocol can be used only on the child IOASID's, impl=
ying=20
> > > IOASID nesting must be enabled. This is because the kernel doesn't tr=
ust=20
> > > userspace. Nesting allows the kernel to enforce its DMA isolation pol=
icy=20
> > > through the parent IOASID.
> >=20
> > To clarify, I'm guessing that's a restriction of likely practice,
> > rather than a fundamental API restriction.  I can see a couple of
> > theoretical future cases where a user-managed pagetable for a "base"
> > IOASID would be feasible:
> >=20
> >   1) On some fancy future MMU allowing free nesting, where the kernel
> >      would insert an implicit extra layer translating user addresses
> >      to physical addresses, and the userspace manages a pagetable with
> >      its own VAs being the target AS
>=20
> I would model this by having a "SVA" parent IOASID. A "SVA" IOASID one
> where the IOVA =3D=3D process VA and the kernel maintains this mapping.

That makes sense.  Needs a different name to avoid Intel and PCI
specificness, but having a trivial "pagetable format" which just says
IOVA =3D=3D user address is nice idea.

> Since the uAPI is so general I do have a general expecation that the
> drivers/iommu implementations might need to be a bit more complicated,
> like if the HW can optimize certain specific graphs of IOASIDs we
> would still model them as graphs and the HW driver would have to
> "compile" the graph into the optimal hardware.
>=20
> This approach has worked reasonable in other kernel areas.

That seems sensible.

> >   2) For a purely software virtual device, where its virtual DMA
> >      engine can interpet user addresses fine
>=20
> This also sounds like an SVA IOASID.

Ok.

> Depending on HW if a device can really only bind to a very narrow kind
> of IOASID then it should ask for that (probably platform specific!)
> type during its attachment request to drivers/iommu.
>=20
> eg "I am special hardware and only know how to do PLATFORM_BLAH
> transactions, give me an IOASID comatible with that". If the only way
> to create "PLATFORM_BLAH" is with a SVA IOASID because BLAH is
> hardwired to the CPU ASID  then that is just how it is.

Fair enough.

> > I wonder if there's a way to model this using a nested AS rather than
> > requiring special operations.  e.g.
> >=20
> > 	'prereg' IOAS
> > 	|
> > 	\- 'rid' IOAS
> > 	   |
> > 	   \- 'pasid' IOAS (maybe)
> >=20
> > 'prereg' would have a kernel managed pagetable into which (for
> > example) qemu platform code would map all guest memory (using
> > IOASID_MAP_DMA).  qemu's vIOMMU driver would then mirror the guest's
> > IO mappings into the 'rid' IOAS in terms of GPA.
> >=20
> > This wouldn't quite work as is, because the 'prereg' IOAS would have
> > no devices.  But we could potentially have another call to mark an
> > IOAS as a purely "preregistration" or pure virtual IOAS.  Using that
> > would be an alternative to attaching devices.
>=20
> It is one option for sure, this is where I was thinking when we were
> talking in the other thread. I think the decision is best
> implementation driven as the datastructure to store the
> preregsitration data should be rather purpose built.

Right.  I think this gets nicer now that we're considering more
specific options at IOAS creation time, and different "types" of
IOAS.  We could add a "preregistration" IOAS type, which supports
MAP/UNMAP of user addresses, and allows *no* devices to be attached,
but does allow other IOAS types to be added as children.

>=20
> > > /*
> > >   * Map/unmap process virtual addresses to I/O virtual addresses.
> > >   *
> > >   * Provide VFIO type1 equivalent semantics. Start with the same=20
> > >   * restriction e.g. the unmap size should match those used in the=20
> > >   * original mapping call.=20
> > >   *
> > >   * If IOASID_REGISTER_MEMORY has been called, the mapped vaddr
> > >   * must be already in the preregistered list.
> > >   *
> > >   * Input parameters:
> > >   *	- u32 ioasid;
> > >   *	- refer to vfio_iommu_type1_dma_{un}map
> > >   *
> > >   * Return: 0 on success, -errno on failure.
> > >   */
> > > #define IOASID_MAP_DMA	_IO(IOASID_TYPE, IOASID_BASE + 6)
> > > #define IOASID_UNMAP_DMA	_IO(IOASID_TYPE, IOASID_BASE + 7)
> >=20
> > I'm assuming these would be expected to fail if a user managed
> > pagetable has been bound?
>=20
> Me too, or a SVA page table.
>=20
> This document would do well to have a list of imagined page table
> types and the set of operations that act on them. I think they are all
> pretty disjoint..

Right.  With the possible exception that I can imagine a call for
several types which all support MAP/UNMAP, but have other different
characteristics.

> Your presentation of 'kernel owns the table' vs 'userspace owns the
> table' is a useful clarification to call out too
>=20
> > > 5. Use Cases and Flows
> > >=20
> > > Here assume VFIO will support a new model where every bound device
> > > is explicitly listed under /dev/vfio thus a device fd can be acquired=
 w/o=20
> > > going through legacy container/group interface. For illustration purp=
ose
> > > those devices are just called dev[1...N]:
> > >=20
> > > 	device_fd[1...N] =3D open("/dev/vfio/devices/dev[1...N]", mode);
> >=20
> > Minor detail, but I'd suggest /dev/vfio/pci/DDDD:BB:SS.F for the
> > filenames for actual PCI functions.  Maybe /dev/vfio/mdev/something
> > for mdevs.  That leaves other subdirs of /dev/vfio free for future
> > non-PCI device types, and /dev/vfio itself for the legacy group
> > devices.
>=20
> There are a bunch of nice options here if we go this path
>=20
> > > 5.2. Multiple IOASIDs (no nesting)
> > > ++++++++++++++++++++++++++++
> > >=20
> > > Dev1 and dev2 are assigned to the guest. vIOMMU is enabled. Initially
> > > both devices are attached to gpa_ioasid.
> >=20
> > Doesn't really affect your example, but note that the PAPR IOMMU does
> > not have a passthrough mode, so devices will not initially be attached
> > to gpa_ioasid - they will be unusable for DMA until attached to a
> > gIOVA ioasid.
>=20
> I think attachment should always be explicit in the API. If the user
> doesn't explicitly ask for a device to be attached to the IOASID then
> the iommu driver is free to block it.
>=20
> If you want passthrough then you have to create a passthrough IOASID
> and attach every device to it. Some of those attaches might be NOP's
> due to groups.

Agreed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FAcR9kiyfl4RJ44h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC4dgAACgkQbDjKyiDZ
s5K/jw/9Ht15/kL6FaoswulEdiuVCAgKdvNuVPejylpQTRm13DobP4fblnMQCx32
ioYph9Pw4ZWZTpGOI0mgIaIyUMY9yDVfhzYN2Q+ZqgIBRGkixn0Mwal3thGYWvdf
MJIcRNt6hAHFG9JUn4CaUcDt48nNrTAjp3p09iLNNKdOAs1BQ/AaPoQTQrMTMkJl
W7nWIZJbxgl7/chTwhVy25Tc5/Yf7PvrknCuPeRQ4MtkoDM3Q7yItWjIt3R9gNvK
Fh7rKb0KUOSS2TXgIzGlC951k9c/ZdWTY6+6Dw9+wwXXeq3Ub1zkQQ/yZ8O0jRa5
x+Te7OHCuk+heSCImstELpazPS7CZHfTSYoLuGLeFvu0+ElvSInV2TAHlWyjZ7Q4
0Or6ozRA5A6ZedHkGGp59x64+sY1cRcQ9zEXwhntw23S0ELah3Gmx3i8RQ7Sedes
O4LJ6owbWvdZ3Cr/2hRyJ7Y5YGmVGqB0Pc3VBburnhpleel+aT73twAxDQNzLLvz
8VgelhT9YG938EIw/7imS0Bnd306KYAepjYsWRYO6kUxoQQcHlt5gACvxczJWmyX
Q5axuhpCCEmQFfMKNtulH9pFP54j8ry5KGQRllFTjDzxyUdUmk02pOA/vI5ts/CA
e0puS1gwhbkFn1TNeHHNhOYiBUvHNJAyRLy81Z7mS6vUYBkymqQ=
=Oa53
-----END PGP SIGNATURE-----

--FAcR9kiyfl4RJ44h--

--===============4956208400470294329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4956208400470294329==--
