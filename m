Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715CEC47098
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C77161405
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C77161405
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02C8C83E1D;
	Thu,  3 Jun 2021 06:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EcIK-SYgHrC5; Thu,  3 Jun 2021 06:28:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97B9E83E1E;
	Thu,  3 Jun 2021 06:28:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 843EEC0025;
	Thu,  3 Jun 2021 06:28:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF3D8C0027
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB34860695
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kgWA35VW_A-G for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 06:28:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DE5D606D3
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:25 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FwbYy5dfJz9sW7; Thu,  3 Jun 2021 16:28:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622701702;
 bh=tvTvm+Dl24LNVBeTbS/nrsEf1WQHLIpQC4ZE2VGPiXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XIWeL8pfv1hFR7uvryrMJQJMH7kVJ2DkVkYsCbgup5ANDd7eXd36hQP1+6OmsPoOY
 Qr4is1p7KgscMxSq2k53S8kG8oziuSZxOkevUjHe/alhKyx18zsfGZDcGHCHkX9e+Z
 fBFFO4Hg8cDerJsO8Ye20uMYJJN4hcbODFE8oynU=
Date: Thu, 3 Jun 2021 15:45:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLhsZRc72aIMZajz@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210602165838.GA1002214@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============3202205430785578398=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3202205430785578398==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EejRrltrzRZdStg/"
Content-Disposition: inline


--EejRrltrzRZdStg/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 01:58:38PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 02, 2021 at 04:48:35PM +1000, David Gibson wrote:
> > > > 	/* Bind guest I/O page table  */
> > > > 	bind_data =3D {
> > > > 		.ioasid	=3D gva_ioasid;
> > > > 		.addr	=3D gva_pgtable1;
> > > > 		// and format information
> > > > 	};
> > > > 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
> > >=20
> > > Again I do wonder if this should just be part of alloc_ioasid. Is
> > > there any reason to split these things? The only advantage to the
> > > split is the device is known, but the device shouldn't impact
> > > anything..
> >=20
> > I'm pretty sure the device(s) could matter, although they probably
> > won't usually.=20
>=20
> It is a bit subtle, but the /dev/iommu fd itself is connected to the
> devices first. This prevents wildly incompatible devices from being
> joined together, and allows some "get info" to report the capability
> union of all devices if we want to do that.

Right.. but I've not been convinced that having a /dev/iommu fd
instance be the boundary for these types of things actually makes
sense.  For example if we were doing the preregistration thing
(whether by child ASes or otherwise) then that still makes sense
across wildly different devices, but we couldn't share that layer if
we have to open different instances for each of them.

It really seems to me that it's at the granularity of the address
space (including extended RID+PASID ASes) that we need to know what
devices we have, and therefore what capbilities we have for that AS.

> The original concept was that devices joined would all have to support
> the same IOASID format, at least for the kernel owned map/unmap IOASID
> type. Supporting different page table formats maybe is reason to
> revisit that concept.
>=20
> There is a small advantage to re-using the IOASID container because of
> the get_user_pages caching and pinned accounting management at the FD
> level.

Right, but at this stage I'm just not seeing a really clear (across
platforms and device typpes) boundary for what things have to be per
IOASID container and what have to be per IOASID, so I'm just not sure
the /dev/iommu instance grouping makes any sense.

> I don't know if that small advantage is worth the extra complexity
> though.
>=20
> > But it would certainly be possible for a system to have two
> > different host bridges with two different IOMMUs with different
> > pagetable formats.  Until you know which devices (and therefore
> > which host bridge) you're talking about, you don't know what formats
> > of pagetable to accept.  And if you have devices from *both* bridges
> > you can't bind a page table at all - you could theoretically support
> > a kernel managed pagetable by mirroring each MAP and UNMAP to tables
> > in both formats, but it would be pretty reasonable not to support
> > that.
>=20
> The basic process for a user space owned pgtable mode would be:
>=20
>  1) qemu has to figure out what format of pgtable to use
>=20
>     Presumably it uses query functions using the device label.

No... in the qemu case it would always select the page table format
that it needs to present to the guest.  That's part of the
guest-visible platform that's selected by qemu's configuration.

There's no negotiation here: either the kernel can supply what qemu
needs to pass to the guest, or it can't.  If it can't qemu, will have
to either emulate in SW (if possible, probably using a kernel-managed
IOASID to back it) or fail outright.

>     The
>     kernel code should look at the entire device path through all the
>     IOMMU HW to determine what is possible.
>=20
>     Or it already knows because the VM's vIOMMU is running in some
>     fixed page table format, or the VM's vIOMMU already told it, or
>     something.

Again, I think you have the order a bit backwards.  The user selects
the capabilities that the vIOMMU will present to the guest as part of
the qemu configuration.  Qemu then requests that of the host kernel,
and either the host kernel supplies it, qemu emulates it in SW, or
qemu fails to start.

Guest visible properties of the platform never (or *should* never)
depend implicitly on host capabilities - it's impossible to sanely
support migration in such an environment.

>  2) qemu creates an IOASID and based on #1 and says 'I want this format'

Right.

>  3) qemu binds the IOASID to the device.=20
>=20
>     If qmeu gets it wrong then it just fails.

Right, though it may be fall back to (partial) software emulation.  In
practice that would mean using a kernel-managed IOASID and walking the
guest IO pagetables itself to mirror them into the host kernel.

>  4) For the next device qemu would have to figure out if it can re-use
>     an existing IOASID based on the required proeprties.

Nope.  Again, what devices share an IO address space is a guest
visible part of the platform.  If the host kernel can't supply that,
then qemu must not start (or fail the hotplug if the new device is
being hotplugged).

> You pointed to the case of mixing vIOMMU's of different platforms. So
> it is completely reasonable for qemu to ask for a "ARM 64 bit IOMMU
> page table mode v2" while running on an x86 because that is what the
> vIOMMU is wired to work with.

Yes.

> Presumably qemu will fall back to software emulation if this is not
> possible.

Right.  But even in this case it needs to do some checking of the
capabilities of the backing IOMMU.  At minimum the host IOMMU needs to
be able to map all the IOVAs that the guest expects to be mappable,
and the host IOMMU needs to support a pagesize that's a submultiple of
the pagesize expected in the guest.

For this reason, amongst some others, I think when selecting a kernel
managed pagetable we need to also have userspace explicitly request
which IOVA ranges are mappable, and what (minimum) page size it
needs.

> One interesting option for software emulation is to just transform the
> ARM page table format to a x86 page table format in userspace and use
> nested bind/invalidate to synchronize with the kernel. With SW nesting
> I suspect this would be much faster

It should be possible *if* the backing IOMMU can support the necessary
IOVAs and pagesizes (and maybe some other things I haven't thought
of).  If not, you're simply out of luck and there's no option but to
fail to start the guest.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EejRrltrzRZdStg/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC4bGMACgkQbDjKyiDZ
s5LRMw/+JL6Q80qX5eLnqmvOpmL173sBPtccpEnj3PkrT3v9OiCP7e4m7+nh0VYr
9lc9+Ncd1N6sObm/kKLFKchg22naoWAHS81Kxr+voYHm9eRNZ7PXj3OY5HHfWt+J
nDVTyjKO9rO0YmOfwnK5zWDT2pAwDpiIu/I7xauWvqxDto+6fHv3n7EBqYJV4zE6
HG4QA7Vw8gQ0B3kSBvDIqNPDy1UDgFMpNey8itb9UIWN9fj1loY1QnF3mvlvWyeN
F3XOpbsHiJTHSPuu3/2FzGA9RNJykeaTbHc1hcUOnltE86xl1Sr4Sy0WHBkTb7I1
olgVcPP92BJROWIMB+25EvpsqsCg7crQqMJAcSi40d7oBygFPJUV/xhLi7RZJFp6
jvT58i5/fijTFlIztyw18L/uMa22Px0WB0dnNxoARw/b8tzfPgj3sBjKitvfE5t7
j330FEH6qeCli/uWZgkE3ishY8ez+X8NQ0K35PA13f/HPfk4PicAGt3doJ5jcAzY
FRewezCWCuqQd7v7gbQ7+b44pAViToj6PYrIrSUw7iH+I/5pSin6Fv6RX9HAHG0r
G/HvP5bxJ3ziTyBSuSd1/vmPHCuNLRJ1tgHdPVr9iyvOO+IMUSfd5ADrOc0wrVde
lmVI5DqOhyurHERtW8SWSOSvL47JxLwAX+9tVzzQ0Y48Fb07Ixk=
=uCMk
-----END PGP SIGNATURE-----

--EejRrltrzRZdStg/--

--===============3202205430785578398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3202205430785578398==--
