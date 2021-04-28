Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F01C43460
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 02:42:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF49613F9
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 02:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF49613F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B12740E65;
	Wed, 28 Apr 2021 02:42:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 82EGynVvRUNW; Wed, 28 Apr 2021 02:42:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B609A40E6C;
	Wed, 28 Apr 2021 02:41:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7D96C002A;
	Wed, 28 Apr 2021 02:41:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFA34C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 02:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BF6340E63
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 02:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Plv5Yf9w5wJE for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 02:41:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24C0040E5C
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 02:41:55 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FVNFB5qlnz9t0k; Wed, 28 Apr 2021 12:41:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1619577710;
 bh=zYS8FHQgR+4x1Is9SX0sklQkQez64N0dyEW0WnK7dYw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RlaGucRf+kRUTGfjc81aUxjcmXRbuiSysj4czvzWZJct+fyFUUJYbM8tdN5Hk8r5J
 J7z9guBJPUnsKCgj2b6w/kwrqrR0im7yXjawwRAUdlPGiBpE5H9v/lsnxh0wI3qibQ
 7Tsehr/BhzqV+yWxQOcC1HjWcF4jKyGex4E7/5js=
Date: Wed, 28 Apr 2021 11:23:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
References: <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210427172432.GE1370958@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============2523660301306396395=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2523660301306396395==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nMsVi0/29zgVwne4"
Content-Disposition: inline


--nMsVi0/29zgVwne4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2021 at 02:24:32PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 27, 2021 at 02:50:45PM +1000, David Gibson wrote:
>=20
> > > > I say this because the SPAPR looks quite a lot like PASID when it h=
as
> > > > APIs for allocating multiple tables and other things. I would be
> > > > interested to hear someone from IBM talk about what it is doing and
> > > > how it doesn't fit into today's IOMMU API.
> >=20
> > Hm.  I don't think it's really like PASID.  Just like Type1, the TCE
> > backend represents a single DMA address space which all devices in the
> > container will see at all times.  The difference is that there can be
> > multiple (well, 2) "windows" of valid IOVAs within that address space.
> > Each window can have a different TCE (page table) layout.  For kernel
> > drivers, a smallish translated window at IOVA 0 is used for 32-bit
> > devices, and a large direct mapped (no page table) window is created
> > at a high IOVA for better performance with 64-bit DMA capable devices.
> >
> > With the VFIO backend we create (but don't populate) a similar
> > smallish 32-bit window, userspace can create its own secondary window
> > if it likes, though obvious for userspace use there will always be a
> > page table.  Userspace can choose the total size (but not address),
> > page size and to an extent the page table format of the created
> > window.  Note that the TCE page table format is *not* the same as the
> > POWER CPU core's page table format.  Userspace can also remove the
> > default small window and create its own.
>=20
> So what do you need from the generic API? I'd suggest if userspace
> passes in the required IOVA range it would benefit all the IOMMU
> drivers to setup properly sized page tables and PPC could use that to
> drive a single window. I notice this is all DPDK did to support TCE.

Yes.  My proposed model for a unified interface would be that when you
create a new container/IOASID, *no* IOVAs are valid.  Before you can
map anything you would have to create a window with specified base,
size, pagesize (probably some flags for extension, too).  That could
fail if the backend IOMMU can't handle that IOVA range, it could be a
backend no-op if the requested window lies within a fixed IOVA range
the backend supports, or it could actually reprogram the back end for
the new window (such as for POWER TCEs).  Regardless of the hardware,
attempts to map outside the created window(s) would be rejected by
software.

I expect we'd need some kind of query operation to expose limitations
on the number of windows, addresses for them, available pagesizes etc.

> > The second wrinkle is pre-registration.  That lets userspace register
> > certain userspace VA ranges (*not* IOVA ranges) as being the only ones
> > allowed to be mapped into the IOMMU.  This is a performance
> > optimization, because on pre-registration we also pre-account memory
> > that will be effectively locked by DMA mappings, rather than doing it
> > at DMA map and unmap time.
>=20
> This feels like nesting IOASIDs to me, much like a vPASID.
>=20
> The pre-registered VA range would be the root of the tree and the
> vIOMMU created ones would be children of the tree. This could allow
> the map operations of the child to refer to already prepped physical
> memory held in the root IOASID avoiding the GUP/etc cost.

Huh... I never thought of it that way, but yeah, that sounds like it
could work.  More elegantly than the current system in fact.

> Seems fairly genericish, though I'm not sure about the kvm linkage..

I think it should be doable.  We'd basically need to give KVM a handle
on the parent AS, and the child AS, and the guest side handle (what
PAPR calls a "Logical IO Bus Number" - liobn).  KVM would then
translate H_PUT_TCE etc. hypercalls on that liobn into calls into the
IOMMU subsystem to map bits of the parent AS into the child.  We'd
probably have to have some requirements that either parent AS is
identity-mapped to a subset of the userspace AS (effectively what we
have now) or that parent AS is the same as guest physical address.
Not sure which would work better.

> > I like the idea of a common DMA/IOMMU handling system across
> > platforms.  However in order to be efficiently usable for POWER it
> > will need to include multiple windows, allowing the user to change
> > those windows and something like pre-registration to amortize
> > accounting costs for heavy vIOMMU load.
>=20
> I have a feeling /dev/ioasid is going to end up with some HW specific
> escape hatch to create some HW specific IOASID types and operate on
> them in a HW specific way.
>=20
> However, what I would like to see is that something simple like DPDK
> can have a single implementation - POWER should implement the standard
> operations and map them to something that will work for it.
>=20
> As an ideal, only things like the HW specific qemu vIOMMU driver
> should be reaching for all the special stuff.

I'm hoping we can even avoid that, usually.  With the explicitly
created windows model I propose above, it should be able to: qemu will
create the windows according to the IOVA windows the guest platform
expects to see and they either will or won't work on the host platform
IOMMU.  If they do, generic maps/unmaps should be sufficient.  If they
don't well, the host IOMMU simply cannot emulate the vIOMMU so you're
out of luck anyway.

> In this way the kernel IOMMU driver and the qemu user vIOMMU driver
> would form something of a classical split user/kernel driver pattern.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nMsVi0/29zgVwne4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCIuRkACgkQbDjKyiDZ
s5JI7w/6Au7f8pxE7QiVg8+0d9G/vNb4Ul6gpHkzbATg1EbCEKhFhLpIAGiTKJoU
O+q0juaB4n9rJ1aSsXEIZKvOoLOIg8bco2vcXkjglr0uIzNeMSxBo+N4IZjk2CMG
MDd7oZbdl3dnyK7yib95P5m/sN05qJodaBZYc9ZqKcvU3hbZMZGArwKqdeE1MDtu
tUevf42QsQ0ByzxeR4suyQWNjSiS+kKguz8HWtjQFfWkvGXEykkp+BQyGT+1Qe7g
iz6/J4LjXR68dU7IBw/mQB+h5BL+A2LEuiC+JcPDEEQj/HcwewfZjPCEqguEg7YL
dps63m/j7sV8SLbkQQOKJAPWXki5XmJW184XQVz4ih0Bl7j0ycz4rLVaZEmc1/2T
5ngx/YWJ7aloZk6dSVmO8fgVilnT2HUU6axia/1So10l/z2j3Us3ivun6wtoS7QU
+rDI6fCBmgNhaqdDq5D4eziKsESoJFkOWUGjwjuLeXTmcG+FweBUltesY+TKXymv
IOI9/kc5MTkdS0Hhb91wM06G2UTpNfh590eWpDwhUP3b2wcNdsBZGXvPK7E/7Y9D
IlA/m1Fd1H3CC7p93qYSv5dbFziDFuGzOVlCZyTXd2+6R8kT+FXi1wGglgxJ4Puh
FMsAJqsG0G/JoU7T4mDtIZPVgBvqwIcDxQSs2FFB4r1mN+e0kXQ=
=x6Md
-----END PGP SIGNATURE-----

--nMsVi0/29zgVwne4--

--===============2523660301306396395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2523660301306396395==--
