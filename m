Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E86C433FE
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 07:20:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB0760C4A
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 07:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CB0760C4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52356402A4;
	Mon, 11 Oct 2021 07:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rwudptyIrxLD; Mon, 11 Oct 2021 07:20:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1147A402B5;
	Mon, 11 Oct 2021 07:20:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF176C0011;
	Mon, 11 Oct 2021 07:20:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0FE1C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 07:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F62D402B5
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 07:20:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id weMXfaTJJ8dH for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 07:20:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E4DB402A4
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 07:20:00 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HSVYP2hG1z4xqR; Mon, 11 Oct 2021 18:19:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1633936793;
 bh=3FgvzcR2Ck1W6d0Aewjatt+OQuD0wH338SDHjs7yENI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e+iSlv4nV8sXmsdj+hxaDI9V9ScTpiNerEpS+OlmGVfe1XZ8IaXC23leE83FWUGwE
 qy0QVufZS589IZKMu/Gel6uJN8Y1IUPiSeQfoH33wT+OcGKC7cbUV0MaftJkRQDGfZ
 iJQwN/IJ4lEoi3cPnSonXAsh5fO6wgIxkmTdc02w=
Date: Mon, 11 Oct 2021 17:02:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YWPTWdHhoI4k0Ksc@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com> <YVanJqG2pt6g+ROL@yekko>
 <20211001122225.GK964074@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211001122225.GK964074@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============2428490887239926389=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2428490887239926389==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c4FY1X0lv1C6vj9E"
Content-Disposition: inline


--c4FY1X0lv1C6vj9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 01, 2021 at 09:22:25AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 01, 2021 at 04:13:58PM +1000, David Gibson wrote:
> > On Tue, Sep 21, 2021 at 02:44:38PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Sep 19, 2021 at 02:38:39PM +0800, Liu Yi L wrote:
> > > > This patch adds IOASID allocation/free interface per iommufd. When
> > > > allocating an IOASID, userspace is expected to specify the type and
> > > > format information for the target I/O page table.
> > > >=20
> > > > This RFC supports only one type (IOMMU_IOASID_TYPE_KERNEL_TYPE1V2),
> > > > implying a kernel-managed I/O page table with vfio type1v2 mapping
> > > > semantics. For this type the user should specify the addr_width of
> > > > the I/O address space and whether the I/O page table is created in
> > > > an iommu enfore_snoop format. enforce_snoop must be true at this po=
int,
> > > > as the false setting requires additional contract with KVM on handl=
ing
> > > > WBINVD emulation, which can be added later.
> > > >=20
> > > > Userspace is expected to call IOMMU_CHECK_EXTENSION (see next patch)
> > > > for what formats can be specified when allocating an IOASID.
> > > >=20
> > > > Open:
> > > > - Devices on PPC platform currently use a different iommu driver in=
 vfio.
> > > >   Per previous discussion they can also use vfio type1v2 as long as=
 there
> > > >   is a way to claim a specific iova range from a system-wide addres=
s space.
> > > >   This requirement doesn't sound PPC specific, as addr_width for pc=
i devices
> > > >   can be also represented by a range [0, 2^addr_width-1]. This RFC =
hasn't
> > > >   adopted this design yet. We hope to have formal alignment in v1 d=
iscussion
> > > >   and then decide how to incorporate it in v2.
> > >=20
> > > I think the request was to include a start/end IO address hint when
> > > creating the ios. When the kernel creates it then it can return the
> > > actual geometry including any holes via a query.
> >=20
> > So part of the point of specifying start/end addresses is that
> > explicitly querying holes shouldn't be necessary: if the requested
> > range crosses a hole, it should fail.  If you didn't really need all
> > that range, you shouldn't have asked for it.
> >=20
> > Which means these aren't really "hints" but optionally supplied
> > constraints.
>=20
> We have to be very careful here, there are two very different use
> cases. When we are talking about the generic API I am mostly
> interested to see that applications like DPDK can use this API and be
> portable to any IOMMU HW the kernel supports. I view the fact that
> there is VFIO PPC specific code in DPDK as a failing of the kernel to
> provide a HW abstraction.

I would agree.  At the time we were making this, we thought there were
irreconcilable differences between what could be done with the x86 vs
ppc IOMMUs.  Turns out we just didn't think it through hard enough to
find a common model.

> This means we cannot define an input that has a magic HW specific
> value.

I'm not entirely sure what you mean by that.

> DPDK can never provide that portably. Thus all these kinds of
> inputs in the generic API need to be hints, if they exist at all.

I don't follow your reasoning.  First, note that in qemu these valus
are *target* hardware specific, not *host* hardware specific.  If
those requests aren't honoured, qemu cannot faithfully emulate the
target hardware and has to fail.  That's what I mean when I say this
is not a constraint, not a hint.

But when I say the constraint is optional, I mean that things which
don't have that requirement - like DPDK - shouldn't apply the
constraint.

> As 'address space size hint'/'address space start hint' is both
> generic, useful, and providable by DPDK I think it is OK.

Size is certainly providable, and probably useful.  For DPDK, I don't
think start is useful.

> PPC can use
> it to pick which of the two page table formats to use for this IOAS if
> it wants.

Clarification: it's not that each window has a specific page table
format.  The two windows are independent of each other, which means
you can separately select the page table format for each one (although
the 32-bit one generally won't be big enough that there's any point
selecting something other than a 1-level TCE table).  When I say
format here, I basically mean number of levels and size of each level
- the IOPTE (a.k.a. TCE) format is the same in each case.

> The second use case is when we have a userspace driver for a specific
> HW IOMMU. Eg a vIOMMU in qemu doing specific PPC/ARM/x86 acceleration.
> We can look here for things to make general, but I would expect a
> fairly high bar. Instead, I would rather see the userspace driver
> communicate with the kernel driver in its own private language, so
> that the entire functionality of the unique HW can be used.

I don't think we actually need to do this.  Or rather, we might want
to do this for maximum performance in some cases, but I think we can
have something that at least usually works without having explicit
host =3D=3D target logic for each case.  I believe this can work (at least
when using kernel managed IO page tables) in a lot of cases even with
a different vIOMMU from the host IOMMU.

e.g. suppose the host is some x86 (or arm, or whatever) machine with
an IOMMU capable of translating any address from 0..2^60, with maybe
the exception of an IO hole somewhere between 2GiB and 4GiB.

qemu wants to emulate a PAPR vIOMMU, so it says (via interfaces yet to
be determined) that it needs an IOAS where things can be mapped in the
range 0..2GiB (for the 32-bit window) and 2^59..2^59+1TiB (for the
64-bit window).

Ideally the host /dev/iommu will say "ok!", since both those ranges
are within the 0..2^60 translated range of the host IOMMU, and don't
touch the IO hole.  When the guest calls the IO mapping hypercalls,
qemu translates those into DMA_MAP operations, and since they're all
within the previously verified windows, they should work fine.

> So, when it comes to providing exact ranges as an input parameter we
> have to decide if that is done as some additional general data, or if
> it should be part of a IOAS_FORMAT_KERNEL_PPC. In this case I suggest
> the guiding factor should be if every single IOMMU implementation can
> be updated to support the value.

No, I don't think that needs to be a condition.  I think it's
perfectly reasonable for a constraint to be given, and for the host
IOMMU to just say "no, I can't do that".  But that does mean that each
of these values has to have an explicit way of userspace specifying "I
don't care", so that the kernel will select a suitable value for those
instead - that's what DPDK or other userspace would use nearly all the
time.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c4FY1X0lv1C6vj9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFj01YACgkQbDjKyiDZ
s5LivQ//QuYS8q96WD/zaOZ9PRmjMCgR+dYJG7ktIUwBHYmFv8mldxWKiOWOh+N2
0IdBTHH2CeHlyajmhiNzJNRgWI671zsUnlyPw6qZMGVmGKzrhzI7fwFcVq45TNf0
5qfh4qc6avuFqMgOoJlqHHgn4+JJ9PUQC9p9lLjvYQfYMEwJ8TnIMpHs+rJsGI7b
VrnpBO9bo9TQPNm9TcBc35zXGt0FeZX6IBCxtctYSGTjZ73JIWet42XhEzR7BV2o
ZSeP6QOzXHOBtNbN0HSX0XQ5NDUmEGhaL2hPfMx+dn74M3f/1atVkXdFwrKExGTi
VJl8hFvt612Ixv57sa98dKmy0BC+cab+xxhgdifhWULZLFNLlBPyCT/bfXuC8JEB
vS9v+yU8fsObQt/X5hP85uwnqwijJemcROJ4XwIkskiyDXzRfPppZu1+Xr3mKS1E
Lb0qCKTIu7l7VUyVKEHNBl53vcOmEawFMeusjW8HssyZMMnwR3OwsDhHTKLZqdYa
fE05SdgHOYlZWIQBjLk2gJ4Nsw2GBRG9Arw/6GZVFpjvn0UNnsYiHrxR9RnwZwBd
qU9vFtRUh54IkMln8yIYjbQ2ZnOIXGsXKwItzvq7B1ejp4cV+jYOyKtfYAzKLk3G
Qq9Njo2JNGF8hQ1FWiNAbykETfcEUtdbADvNqlOBduPAkCXfWEI=
=MZfA
-----END PGP SIGNATURE-----

--c4FY1X0lv1C6vj9E--

--===============2428490887239926389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2428490887239926389==--
