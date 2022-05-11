Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E71C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 04:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC58D4022C;
	Wed, 11 May 2022 04:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ueLdxZY2ojS8; Wed, 11 May 2022 04:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E669F4011F;
	Wed, 11 May 2022 04:41:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABD65C0032;
	Wed, 11 May 2022 04:41:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE7E1C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 04:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A961D60F88
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 04:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VxqL_w7_Cgkn for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 04:41:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E673460B47
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 04:41:11 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4Kyj0H2SY8z4ySq; Wed, 11 May 2022 14:41:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1652244063;
 bh=sHvewOFYlGna0u1wgq+jGfV4PmO/Nd3pCM2BMMDwFfk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aL0AMIQz7zxTTw1CWQ2guvaXYst8KKw1mE3OLBWIHsGQAvt1ngmDF9UUyGrefHAv6
 4nBm46ZvnOPvVEz+67cSQDIai7klhE1bkC0pxD4jsHsDtb4voA4HUx29NT8gZuLNnq
 aYpZyfM0OYsCkTm+xQ8LnJnBc1L8My4AW8KIKhY8=
Date: Wed, 11 May 2022 14:40:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Message-ID: <Yns+TCSa6hWbU7wZ@yekko>
References: <YmuDtPMksOj7NOEh@yekko> <20220429124838.GW8364@nvidia.com>
 <Ym+IfTvdD2zS6j4G@yekko> <20220505190728.GV49344@nvidia.com>
 <YnSxL5KxwJvQzd2Q@yekko> <20220506124837.GB49344@nvidia.com>
 <YniuUMCBjy0BaJC6@yekko> <20220509140041.GK49344@nvidia.com>
 <YnoQREfceIoLATDA@yekko> <20220510190009.GO49344@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220510190009.GO49344@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============7594681615751891412=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7594681615751891412==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B98zKEZ8Gd4zroD6"
Content-Disposition: inline


--B98zKEZ8Gd4zroD6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2022 at 04:00:09PM -0300, Jason Gunthorpe wrote:
> On Tue, May 10, 2022 at 05:12:04PM +1000, David Gibson wrote:
> > On Mon, May 09, 2022 at 11:00:41AM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 09, 2022 at 04:01:52PM +1000, David Gibson wrote:
> > >=20
> > > > > The default iommu_domain that the iommu driver creates will be us=
ed
> > > > > here, it is up to the iommu driver to choose something reasonable=
 for
> > > > > use by applications like DPDK. ie PPC should probably pick its bi=
ggest
> > > > > x86-like aperture.
> > > >=20
> > > > So, using the big aperture means a very high base IOVA
> > > > (1<<59)... which means that it won't work at all if you want to att=
ach
> > > > any devices that aren't capable of 64-bit DMA.
> > >=20
> > > I'd expect to include the 32 bit window too..
> >=20
> > I'm not entirely sure what you mean.  Are you working on the
> > assumption that we've extended to allowing multiple apertures, so we'd
> > default to advertising both a small/low aperture and a large/high
> > aperture?
>=20
> Yes

Ok, that works assuming we can advertise multiple windows.

> > > No, this just makes it fragile in the other direction because now
> > > userspace has to know what platform specific things to ask for *or it
> > > doesn't work at all*. This is not a improvement for the DPDK cases.
> >=20
> > Um.. no.  The idea is that userspace requests *what it needs*, not
> > anything platform specific.  In the case of DPDK that would be nothing
> > more than the (minimum) aperture size.  Nothing platform specific
> > about that.
>=20
> Except a 32 bit platform can only maybe do a < 4G aperture, a 64 bit
> platform can do more, but it varies how much more, etc.
>=20
> There is no constant value DPDK could stuff in this request, unless it
> needs a really small amount of IOVA, like 1G or something.

Well, my assumption was that DPDK always wanted an IOVA window to
cover its hugepage buffer space.  So not "constant" exactly, but a
value it will know at start up time.  But I think we cover that more
closely below.

> > > It isn't like there is some hard coded value we can put into DPDK that
> > > will work on every platform. So kernel must pick for DPDK, IMHO. I
> > > don't see any feasible alternative.
> >=20
> > Yes, hence *optionally specified* base address only.
>=20
> Okay, so imagine we've already done this and DPDK is not optionally
> specifying anything :)
>=20
> The structs can be extended so we can add this as an input to creation
> when a driver can implement it.
>=20
> > > The ppc specific driver would be on the generic side of qemu in its
> > > viommu support framework. There is lots of host driver optimization
> > > possible here with knowledge of the underlying host iommu HW. It
> > > should not be connected to the qemu target.
> >=20
> > Thinking through this...
> >=20
> > So, I guess we could have basically the same logic I'm suggesting be
> > in the qemu backend iommu driver instead.  So the target side (machine
> > type, strictly speaking) would request of the host side the apertures
> > it needs, and the host side driver would see if it can do that, based
> > on both specific knowledge of that driver and the query reponses.
>=20
> Yes, this is what I'm thinking
>=20
> > ppc on x86 should work with that.. at least if the x86 aperture is
> > large enough to reach up to ppc's high window.  I guess we'd have the
> > option here of using either the generic host driver or the
> > x86-specific driver.  The latter would mean qemu maintaining an
> > x86-format shadow of the io pagetables; mildly tedious, but doable.
>=20
> The appeal of having userspace page tables is performance, so it is
> tedious to shadow, but it should run faster.

I doubt the difference is meaningful in the context of an emulated
guest, though.

> > So... is there any way of backing out of this gracefully.  We could
> > detach the device, but in the meantime ongoing DMA maps from
> > previous devices might have failed. =20
>=20
> This sounds like a good use case for qemu to communicate ranges - but
> as I mentioned before Alex said qemu didn't know the ranges..

Yeah, I'm a bit baffled by that, and I don't know the context.  Note
that there are at least two different very different users of the host
IOMMU backends in: one is for emulation of guest DMA (with or without
a vIOMMU).  In that case the details of the guest platform should let
qemu know the ranges.  There's also a VFIO based NVME backend; that
one's much more like a "normal" userspace driver, where it doesn't
care about the address ranges (because they're not guest visible).

> > We could pre-attach the new device to a new IOAS and check the
> > apertures there - but when we move it to the final IOAS is it
> > guaranteed that the apertures will be (at least) the intersection of
> > the old and new apertures, or is that just the probable outcome.=20
>=20
> Should be guarenteed

Ok; that would need to be documented.

> > Ok.. you convinced me.  As long as we have some way to handle the
> > device hotplug case, we can work with this.
>=20
> I like the communicate ranges for hotplug, so long as we can actually
> implement it in qemu - I'm a bit unclear on that honestly.
>=20
> > Ok, I see.  That can certainly be done.  I was really hoping we could
> > have a working, though non-optimized, implementation using just the
> > generic interface.
>=20
> Oh, sure that should largely work as well too, this is just an
> additional direction people may find interesting and helps explain why
> qemu should have an iommu layer inside.

> > "holes" versus "windows".  We can choose either one; I think "windows"
> > rather than "holes" makes more sense, but it doesn't really matter.
>=20
> Yes, I picked windows aka ranges for the uAPI - we translate the holes
> from the groups into windows and intersect them with the apertures.

Ok.

> > > > Another approach would be to give the required apertures / pagesizes
> > > > in the initial creation of the domain/IOAS.  In that case they would
> > > > be static for the IOAS, as well as the underlying iommu_domains: any
> > > > ATTACH which would be incompatible would fail.
> > >=20
> > > This is the device-specific iommu_domain creation path. The domain can
> > > have information defining its aperture.
> >=20
> > But that also requires managing the pagetables yourself; I think tying
> > these two concepts together is inflexible.
>=20
> Oh, no, those need to be independent for HW nesting already
>=20
> One device-specific creation path will create the kernel owned
> map/unmap iommu_domain with device-specific parameters to allow it to
> be the root of a nest - ie specify S2 on ARM.
>=20
> The second device-specific creation path will create the user owned
> iommu_domain with device-specific parameters, with the first as a
> parent.
>=20
> So you get to do both.

Ah! Good to know.

> > > Which is why the current scheme is fully automatic and we rely on the
> > > iommu driver to automatically select something sane for DPDK/etc
> > > today.
> >=20
> > But the cost is that the allowable addresses can change implicitly
> > with every ATTACH.
>=20
> Yes, dpdk/etc don't care.

Well... as long as nothing they've already mapped goes away.

> > I see the problem if you have an app where there's a difference
> > between the smallest window it can cope with versus the largest window
> > it can take advantage of.  Not sure if that's likely in pratice.
> > AFAIK, DPDK will alway require it's hugepage memory pool mapped, can't
> > deal with less, can't benefit from more.  But maybe there's some use
> > case for this I haven't thought of.
>=20
> Other apps I've seen don't even have a fixed memory pool, they just
> malloc and can't really predict how much IOVA they
> need. "approximately the same amount as a process VA" is a reasonable
> goal for the kernel to default too.

Hm, ok, I guess that makes sense.

> A tunable to allow efficiency from smaller allocations sounds great -
> but let's have driver support before adding the uAPI for
> it. Intel/AMD/ARM support to have fewer page table levels for instance
> would be perfect.
> =20
> > Ok... here's a revised version of my proposal which I think addresses
> > your concerns and simplfies things.
> >=20
> > - No new operations, but IOAS_MAP gets some new flags (and IOAS_COPY
> >   will probably need matching changes)
> >=20
> > - By default the IOVA given to IOAS_MAP is a hint only, and the IOVA
> >   is chosen by the kernel within the aperture(s).  This is closer to
> >   how mmap() operates, and DPDK and similar shouldn't care about
> >   having specific IOVAs, even at the individual mapping level.
> >
> > - IOAS_MAP gets an IOMAP_FIXED flag, analagous to mmap()'s MAP_FIXED,
> >   for when you really do want to control the IOVA (qemu, maybe some
> >   special userspace driver cases)
>=20
> We already did both of these, the flag is called
> IOMMU_IOAS_MAP_FIXED_IOVA - if it is not specified then kernel will
> select the IOVA internally.

Ok, great.

> > - ATTACH will fail if the new device would shrink the aperture to
> >   exclude any already established mappings (I assume this is already
> >   the case)
>=20
> Yes

Good to know.

> > - IOAS_MAP gets an IOMAP_RESERVE flag, which operates a bit like a
> >   PROT_NONE mmap().  It reserves that IOVA space, so other (non-FIXED)
> >   MAPs won't use it, but doesn't actually put anything into the IO
> >   pagetables.
> >     - Like a regular mapping, ATTACHes that are incompatible with an
> >       IOMAP_RESERVEed region will fail
> >     - An IOMAP_RESERVEed area can be overmapped with an IOMAP_FIXED
> >       mapping
>=20
> Yeah, this seems OK, I'm thinking a new API might make sense because
> you don't really want mmap replacement semantics but a permanent
> record of what IOVA must always be valid.
>=20
> IOMMU_IOA_REQUIRE_IOVA perhaps, similar signature to
> IOMMUFD_CMD_IOAS_IOVA_RANGES:
>=20
> struct iommu_ioas_require_iova {
>         __u32 size;
>         __u32 ioas_id;
>         __u32 num_iovas;
>         __u32 __reserved;
>         struct iommu_required_iovas {
>                 __aligned_u64 start;
>                 __aligned_u64 last;
>         } required_iovas[];
> };

Sounds reasonable.

> > So, for DPDK the sequence would be:
> >=20
> > 1. Create IOAS
> > 2. ATTACH devices
> > 3. IOAS_MAP some stuff
> > 4. Do DMA with the IOVAs that IOAS_MAP returned
> >=20
> > (Note, not even any need for QUERY in simple cases)
>=20
> Yes, this is done already
>=20
> > For (unoptimized) qemu it would be:
> >=20
> > 1. Create IOAS
> > 2. IOAS_MAP(IOMAP_FIXED|IOMAP_RESERVE) the valid IOVA regions of the
> >    guest platform
> > 3. ATTACH devices (this will fail if they're not compatible with the
> >    reserved IOVA regions)
> > 4. Boot the guest
> >=20
> >   (on guest map/invalidate) -> IOAS_MAP(IOMAP_FIXED) to overmap part of
> >                                the reserved regions
> >   (on dev hotplug) -> ATTACH (which might fail, if it conflicts with the
> >                       reserved regions)
> >   (on vIOMMU reconfiguration) -> UNMAP/MAP reserved regions as
> >                                  necessary (which might fail)
>=20
> OK, I will take care of it

Hooray!  Long contentious thread eventually reaches productive
resolution :).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B98zKEZ8Gd4zroD6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoULxWu4/Ws0dB+XtgypY4gEwYSIFAmJ7PkEACgkQgypY4gEw
YSLJpBAAqNEsY85RNVUdVRENVy1x15/CVZFcYsI4GTZYFhdXEPYAKPVJec2BtyqA
uhru5JNF9ESGAhb2UmzFrDa1Y7cNMROmfR7aijQk/ivh4vMx1Lyhb1ehHbvhekJz
2K4rC4sAW9HfPtQAbUGTVdiSwdA76gVqGun+LyHywYSTlMR/qE/7WbG7BFCghVT/
+BbUFcShdBRr0mZv+Dq0EIEDLRJgPDWLU3JGdo5WZ0VCml6awKfHB0WbmLXlve1E
CUvk55sEaL+BRanjRwh1Cgm3MkUukqL75CH+7VAMBmv4eznZH99VAHfxdTNmftzi
NIw75ZjBcldj2mvTq3CW+gfFF1DtUmTzfbsNUBF4fJCP5xLPa/i4QXv1DvckMX2k
EVfwdyYXShLw8lsSkLCIPYL3IjMhXlCLYvdwR/QfF5lAZS160WbM+UOpEaXFiVIR
K9leb8o7+jNQnSS1pbvP7UPS3TEZqsc021fmW1FpPexp6nB+zKdke+YkOZrhzL1p
16m6YKwmF2m9lv7TebTiB8u0rhpYo3iXUty7Ur882J+lfI4YjKLcgKNzJTMDh1J5
LzvHKmfhApC0EImKCkkoxjh8TtUitZ0mCZixoXSf7uhANsBJpSgPMEiWggxNGtmy
vk4qp/xFpe++ZDgBI336cWFdVDxsf/2I0B0Y0GG3F/tHe8LAJZc=
=bxTP
-----END PGP SIGNATURE-----

--B98zKEZ8Gd4zroD6--

--===============7594681615751891412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7594681615751891412==--
