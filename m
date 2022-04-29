Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086E5C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 06:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A1D64408E2;
	Fri, 29 Apr 2022 06:53:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GV1dKmC9nr8y; Fri, 29 Apr 2022 06:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 555E940004;
	Fri, 29 Apr 2022 06:53:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01C4DC0039;
	Fri, 29 Apr 2022 06:53:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDDEDC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C49D683FEC
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BqfhclorEOfO for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 06:53:41 +0000 (UTC)
X-Greylist: delayed 00:09:30 by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEE5E83FB7
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:53:41 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4KqNHs6pdwz4ySn; Fri, 29 Apr 2022 16:44:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1651214649;
 bh=c+bgy/t0AsZWnmanT6NiNllspL4TZOIBuNXP/TG/nxA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HVFiGh8OOepaZ4YC0zDVDroNRIZC6ico59RdMbYPnewRiN9q1kLbq1ks4/SPIfr3/
 SqFyYmQiyKMnApgFIktTrz8rRG3oVr2ePk7enApGRDP41KlZXQPVI7A28J6FnXx6hL
 k6f086X6yYYrbfa7WcYhbfbBPZCleFZKL1HPWK44=
Date: Fri, 29 Apr 2022 16:20:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Message-ID: <YmuDtPMksOj7NOEh@yekko>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323165125.5efd5976.alex.williamson@redhat.com>
 <20220324003342.GV11336@nvidia.com>
 <20220324160403.42131028.alex.williamson@redhat.com>
 <YmqqXHsCTxVb2/Oa@yekko> <20220428151037.GK8364@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220428151037.GK8364@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============1971344252453368403=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1971344252453368403==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDvb63UsTUPHrpWS"
Content-Disposition: inline


--qDvb63UsTUPHrpWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 28, 2022 at 12:10:37PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 29, 2022 at 12:53:16AM +1000, David Gibson wrote:
>=20
> > 2) Costly GUPs.  pseries (the most common ppc machine type) always
> > expects a (v)IOMMU.  That means that unlike the common x86 model of a
> > host with IOMMU, but guests with no-vIOMMU, guest initiated
> > maps/unmaps can be a hot path.  Accounting in that path can be
> > prohibitive (and on POWER8 in particular it prevented us from
> > optimizing that path the way we wanted).  We had two solutions for
> > that, in v1 the explicit ENABLE/DISABLE calls, which preaccounted
> > based on the IOVA window sizes.  That was improved in the v2 which
> > used the concept of preregistration.  IIUC iommufd can achieve the
> > same effect as preregistration using IOAS_COPY, so this one isn't
> > really a problem either.
>=20
> I think PPC and S390 are solving the same problem here. I think S390
> is going to go to a SW nested model where it has an iommu_domain
> controlled by iommufd that is populated with the pinned pages, eg
> stored in an xarray.
>=20
> Then the performance map/unmap path is simply copying pages from the
> xarray to the real IOPTEs - and this would be modeled as a nested
> iommu_domain with a SW vIOPTE walker instead of a HW vIOPTE walker.
>=20
> Perhaps this is agreeable for PPC too?

Uh.. maybe?  Note that I'm making these comments based on working on
this some years ago (the initial VFIO for ppc implementation in
particular).  I'm no longer actively involved in ppc kernel work.

> > 3) "dynamic DMA windows" (DDW).  The IBM IOMMU hardware allows for 2 IO=
VA
> > windows, which aren't contiguous with each other.  The base addresses
> > of each of these are fixed, but the size of each window, the pagesize
> > (i.e. granularity) of each window and the number of levels in the
> > IOMMU pagetable are runtime configurable.  Because it's true in the
> > hardware, it's also true of the vIOMMU interface defined by the IBM
> > hypervisor (and adpoted by KVM as well).  So, guests can request
> > changes in how these windows are handled.  Typical Linux guests will
> > use the "low" window (IOVA 0..2GiB) dynamically, and the high window
> > (IOVA 1<<60..???) to map all of RAM.  However, as a hypervisor we
> > can't count on that; the guest can use them however it wants.
>=20
> As part of nesting iommufd will have a 'create iommu_domain using
> iommu driver specific data' primitive.
>=20
> The driver specific data for PPC can include a description of these
> windows so the PPC specific qemu driver can issue this new ioctl
> using the information provided by the guest.

Hmm.. not sure if that works.  At the moment, qemu (for example) needs
to set up the domains/containers/IOASes as it constructs the machine,
because that's based on the virtual hardware topology.  Initially they
use the default windows (0..2GiB first window, second window
disabled).  Only once the guest kernel is up and running does it issue
the hypercalls to set the final windows as it prefers.  In theory the
guest could change them during runtime though it's unlikely in
practice.  They could change during machine lifetime in practice,
though, if you rebooted from one guest kernel to another that uses a
different configuration.

*Maybe* IOAS construction can be deferred somehow, though I'm not sure
because the assigned devices need to live somewhere.

> The main issue is that internally to the iommu subsystem the
> iommu_domain aperture is assumed to be a single window. This kAPI will
> have to be improved to model the PPC multi-window iommu_domain.

Right.

> If this API is not used then the PPC driver should choose some
> sensible default windows that makes things like DPDK happy.
>=20
> > Then, there's handling existing qemu (or other software) that is using
> > the VFIO SPAPR_TCE interfaces.  First, it's not entirely clear if this
> > should be a goal or not: as others have noted, working actively to
> > port qemu to the new interface at the same time as making a
> > comprehensive in-kernel compat layer is arguably redundant work.
>=20
> At the moment I think I would stick with not including the SPAPR
> interfaces in vfio_compat, but there does seem to be a path if someone
> with HW wants to build and test them?
>=20
> > You might be able to do this by simply failing this outright if
> > there's anything other than exactly one IOMMU group bound to the
> > container / IOAS (which I think might be what VFIO itself does now).
> > Handling that with a device centric API gets somewhat fiddlier, of
> > course.
>=20
> Maybe every device gets a copy of the error notification?

Alas, it's harder than that.  One of the things that can happen on an
EEH fault is that the entire PE gets suspended (blocking both DMA and
MMIO, IIRC) until the proper recovery steps are taken.  Since that's
handled at the hardware/firmware level, it will obviously only affect
the host side PE (=3D=3D host iommu group).  However the interfaces we
have only allow things to be reported to the guest at the granularity
of a guest side PE (=3D=3D container/IOAS =3D=3D guest host bridge in
practice).  So to handle this correctly when guest PE !=3D host PE we'd
need to synchronize suspended / recovery state between all the host
PEs in the guest PE.  That *might* be technically possible, but it's
really damn fiddly.

> ie maybe this should be part of vfio_pci and not part of iommufd to
> mirror how AER works?
>=20
> It feels strange to put in device error notification to iommufd, is
> that connected the IOMMU?

Only in that operates at the granularity of a PE, which is mostly an
IOMMU concept.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qDvb63UsTUPHrpWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoULxWu4/Ws0dB+XtgypY4gEwYSIFAmJrg60ACgkQgypY4gEw
YSKpug/+JhSOHfV6E38TUvKJitl9BMUyaVvi5y6Mm+TahO4cJKulYR+3eLG5/QeJ
3V4XyJrQg7OanDqCNYKu71jEtIIOHkEoxO0qqV7SD77H4btWb6sFMq2jHmrOhfWW
hp3ElTAqusvEFunlwghG5uk+edjgqHgEJSAqlmXWeRIds5SEWhz5nPWiFouNjp7H
WzbQd6HiRqyG9NnFIvqOyHu5igfz1bqlJsiaHEp3JhNw/4AJp+yZqwkvw2/TPxUQ
dUqkpFyb9+K6hju/dlGxsAlQlSwyCXBYDf8aSji3HOmvtx8LBLrCUxJpILibqD4y
qzAYj7pIniOcQabjS0oe2v2uqpdh/UCVjdtRa7ZLeXgatXEBEFsX6ZKydAr5ZB59
mD9/Ofxvb48x/hgb/gGMrQSiabxxNrh1boi7xH2v0YzASWLF1rDSJT0DFn/epqoe
/LKqV7rnrYG8qvvSM/rzwqaObqQmY9okG/yHB4luGMGpRZxtGdjlTlsSRzi1T9W9
0dJkSv53UrqVSycfpXCMk6zWEMn/lLqETcHmxq0s//KDTZBFoy974wJcMxbcFrsE
F5QvONn2gxU26pK3DgTR1DwxP8muK/x90+qTob/+KsHcQ6E6v9JtQa+y49HVPMiJ
hzwT3Nbo2kneXwGsLFR1bfcVVpYkwMj8TGpLHjj2dD1ybXTbxcc=
=ipZz
-----END PGP SIGNATURE-----

--qDvb63UsTUPHrpWS--

--===============1971344252453368403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1971344252453368403==--
