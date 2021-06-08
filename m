Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D3C48BCD
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 06:54:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D66C61263
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 06:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D66C61263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 520C3831A0;
	Tue,  8 Jun 2021 06:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id or21LguEkhIn; Tue,  8 Jun 2021 06:54:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 323DD8322E;
	Tue,  8 Jun 2021 06:54:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0445BC0024;
	Tue,  8 Jun 2021 06:54:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F340C000F
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 06:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B0E183168
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 06:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WAfEDSL0KtQp for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 06:54:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F37AD8322A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 06:54:36 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Fzgvs2C2lz9sWD; Tue,  8 Jun 2021 16:54:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623135273;
 bh=OamA9aFyY4QDHhsQAn6QhZV/ZpUjpyrDqT3NoIMfoxQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nAf7BCvi6S19YIwMN4pKDgg8oR+2LFlo6kmh/3Z1V4bzqCDgXBUYDU5/yLTjexgDw
 ccB8KOs21+4grjXuS93i+rQsPRDUleJeOshDJKELE5YtfU3ZKalEppWcDUeqXncrUR
 P3pzuNTOnDKMXyOwTW52a02VG9aX0Rr8cSkwwFCk=
Date: Tue, 8 Jun 2021 16:13:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YL8KfCo8H5aK9Xj+@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com> <YLhsZRc72aIMZajz@yekko>
 <20210603121105.GR1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210603121105.GR1002214@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============0194838050932416428=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0194838050932416428==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZnWbrY5rMXMZUAOB"
Content-Disposition: inline


--ZnWbrY5rMXMZUAOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 09:11:05AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 03, 2021 at 03:45:09PM +1000, David Gibson wrote:
> > On Wed, Jun 02, 2021 at 01:58:38PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 02, 2021 at 04:48:35PM +1000, David Gibson wrote:
> > > > > > 	/* Bind guest I/O page table  */
> > > > > > 	bind_data =3D {
> > > > > > 		.ioasid	=3D gva_ioasid;
> > > > > > 		.addr	=3D gva_pgtable1;
> > > > > > 		// and format information
> > > > > > 	};
> > > > > > 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
> > > > >=20
> > > > > Again I do wonder if this should just be part of alloc_ioasid. Is
> > > > > there any reason to split these things? The only advantage to the
> > > > > split is the device is known, but the device shouldn't impact
> > > > > anything..
> > > >=20
> > > > I'm pretty sure the device(s) could matter, although they probably
> > > > won't usually.=20
> > >=20
> > > It is a bit subtle, but the /dev/iommu fd itself is connected to the
> > > devices first. This prevents wildly incompatible devices from being
> > > joined together, and allows some "get info" to report the capability
> > > union of all devices if we want to do that.
> >=20
> > Right.. but I've not been convinced that having a /dev/iommu fd
> > instance be the boundary for these types of things actually makes
> > sense.  For example if we were doing the preregistration thing
> > (whether by child ASes or otherwise) then that still makes sense
> > across wildly different devices, but we couldn't share that layer if
> > we have to open different instances for each of them.
>=20
> It is something that still seems up in the air.. What seems clear for
> /dev/iommu is that it
>  - holds a bunch of IOASID's organized into a tree
>  - holds a bunch of connected devices

Right, and it's still not really clear to me what devices connected to
the same /dev/iommu instance really need to have in common, as
distinct from what devices connected to the same specific ioasid need
to have in common.

>  - holds a pinned memory cache
>=20
> One thing it must do is enforce IOMMU group security. A device cannot
> be attached to an IOASID unless all devices in its IOMMU group are
> part of the same /dev/iommu FD.

Well, you can't attach a device to an individual IOASID unless all
devices in its group are attached to the same individual IOASID
either, so I'm not clear what benefit there is to enforcing it at the
/dev/iommu instance as well as at the individual ioasid level.

> The big open question is what parameters govern allowing devices to
> connect to the /dev/iommu:
>  - all devices can connect and we model the differences inside the API
>    somehow.
>  - Only sufficiently "similar" devices can be connected
>  - The FD's capability is the minimum of all the connected devices
>=20
> There are some practical problems here, when an IOASID is created the
> kernel does need to allocate a page table for it, and that has to be
> in some definite format.
>=20
> It may be that we had a false start thinking the FD container should
> be limited. Perhaps creating an IOASID should pass in a list
> of the "device labels" that the IOASID will be used with and that can
> guide the kernel what to do?
>=20
> > Right, but at this stage I'm just not seeing a really clear (across
> > platforms and device typpes) boundary for what things have to be per
> > IOASID container and what have to be per IOASID, so I'm just not sure
> > the /dev/iommu instance grouping makes any sense.
>=20
> I would push as much stuff as possible to be per-IOASID..

I agree.  But the question is what's *not* possible to be per-IOASID,
so what's the semantic boundary that defines when things have to be in
the same /dev/iommu instance, but not the same IOASID.

> > > I don't know if that small advantage is worth the extra complexity
> > > though.
> > >=20
> > > > But it would certainly be possible for a system to have two
> > > > different host bridges with two different IOMMUs with different
> > > > pagetable formats.  Until you know which devices (and therefore
> > > > which host bridge) you're talking about, you don't know what formats
> > > > of pagetable to accept.  And if you have devices from *both* bridges
> > > > you can't bind a page table at all - you could theoretically support
> > > > a kernel managed pagetable by mirroring each MAP and UNMAP to tables
> > > > in both formats, but it would be pretty reasonable not to support
> > > > that.
> > >=20
> > > The basic process for a user space owned pgtable mode would be:
> > >=20
> > >  1) qemu has to figure out what format of pgtable to use
> > >=20
> > >     Presumably it uses query functions using the device label.
> >=20
> > No... in the qemu case it would always select the page table format
> > that it needs to present to the guest.  That's part of the
> > guest-visible platform that's selected by qemu's configuration.
>=20
> I should have said "vfio user" here because apps like DPDK might use
> this path

Ok.

> > >  4) For the next device qemu would have to figure out if it can re-use
> > >     an existing IOASID based on the required proeprties.
> >=20
> > Nope.  Again, what devices share an IO address space is a guest
> > visible part of the platform.  If the host kernel can't supply that,
> > then qemu must not start (or fail the hotplug if the new device is
> > being hotplugged).
>=20
> qemu can always emulate.

No, not always, only sometimes.  The host side IOVA has to be able to
process all the IOVAs that the guest might generate, and it needs to
have an equal or smaller pagesize than the guest expects.

> If the config requires to devices that cannot
> share an IOASID because the local platform is wonky then qemu needs to
> shadow and duplicate the IO page table from the guest into two IOASID
> objects to make it work. This is a SW emulation option.
>=20
> > For this reason, amongst some others, I think when selecting a kernel
> > managed pagetable we need to also have userspace explicitly request
> > which IOVA ranges are mappable, and what (minimum) page size it
> > needs.
>=20
> It does make sense
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZnWbrY5rMXMZUAOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC/CnsACgkQbDjKyiDZ
s5I04A/9GiD0mWZD0hcg3FJQ1EJF8YAtKTovMnsTqnTBXEbggWeJt/F/K8oYSB1A
bjZ8iT9srlxb2RudsBL9TV2vIPB4wXPq7oincGx903VngPDLl0D2LsFuKlGB61pg
UFt7cVzTptTR7qQIPR5zQdn6/RpVotJEMNjzg996apMusfPq+Ql5kkLnSh9MAVSw
2K1KISP7IREoY5VfaO4OTix8xoL47+w/QjiPjJdLWcUaNaZp+IIM3210SJa0tqN4
oyHol4yIPSL7BQpXr0yug8OprHFD/pUtXrP+UL4pSn42cKoL6gG4dhK0wm/sOBkN
oTEFCOAhXfrfzoBr0TzCrKKlgvGuyc4ibgdJjSFLe+hQ5iioojIVND+fpxAJJ7Tq
2sT2gtweRR1Jp46vxbzUmkKCkMCHK7HV14Li5RjfB7jyYITf2962huFZEBvgOucI
NLzpJ0dBGw5fwL96C2n/LlSIPrMLed42FYfT+kdI6pAwOvhq1b32OAG7RwHxn2Kr
jml6jkyfGa7fQ0/Jm15ku1PS9TKJFvz9dPELwvCC5EtlftwqcSDy0abdAOKz8zBY
+aL0TTv1LPQ/fLNChZpijWbYItAbM8IaQGk+ASukWwMnfP5WTZtl8Lueio5GdK3u
o3r1uRcV8efyHAZkke/yeUm8iuOcYRZuVTRoBZGqGQRXRvHzMNU=
=gbUa
-----END PGP SIGNATURE-----

--ZnWbrY5rMXMZUAOB--

--===============0194838050932416428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0194838050932416428==--
