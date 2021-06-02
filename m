Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F3EC47097
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:29:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F55F6138C
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F55F6138C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70A0C60705;
	Wed,  2 Jun 2021 07:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gkhe68BSYkrf; Wed,  2 Jun 2021 07:29:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69E4560A72;
	Wed,  2 Jun 2021 07:29:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46825C000D;
	Wed,  2 Jun 2021 07:29:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4529EC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36CEB40177
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K77I7mxRWQZJ for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:29:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47EA14034B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:19 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Fw0yh2jB1z9sRK; Wed,  2 Jun 2021 17:29:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622618956;
 bh=wRTXISEDG4M4DX/zss0f7Qzb084HLLHwM9+VOjbsb30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lL5edZqsHApE5ojrB2pugjW4EUYLQAKJsvhpxMZWKqD3/R30sjiww/j/KA5oVyOlf
 EFuc8g4DkNHF56DmKY23KMC4GoekI3p7htRDahtPDv2mprfp6WFyGUDYctzvF/Ulzi
 0PrvfoZg/qj7iKwvbsZthkJI6mOhOdlTAkRfT+KU=
Date: Wed, 2 Jun 2021 16:48:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLcpw5Kx61L7TVmR@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210528195839.GO1002214@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============3324687444453014019=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3324687444453014019==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hex0SSC4iy2pvQ2b"
Content-Disposition: inline


--Hex0SSC4iy2pvQ2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 28, 2021 at 04:58:39PM -0300, Jason Gunthorpe wrote:
> On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
> >=20
> > 5. Use Cases and Flows
> >=20
> > Here assume VFIO will support a new model where every bound device
> > is explicitly listed under /dev/vfio thus a device fd can be acquired w=
/o=20
> > going through legacy container/group interface. For illustration purpose
> > those devices are just called dev[1...N]:
> >=20
> > 	device_fd[1...N] =3D open("/dev/vfio/devices/dev[1...N]", mode);
> >=20
> > As explained earlier, one IOASID fd is sufficient for all intended use =
cases:
> >=20
> > 	ioasid_fd =3D open("/dev/ioasid", mode);
> >=20
> > For simplicity below examples are all made for the virtualization story.
> > They are representative and could be easily adapted to a non-virtualiza=
tion
> > scenario.
>=20
> For others, I don't think this is *strictly* necessary, we can
> probably still get to the device_fd using the group_fd and fit in
> /dev/ioasid. It does make the rest of this more readable though.

Leaving aside whether group fds should exist, while they *do* exist
binding to an IOASID should be done on the group not an individual
device.

[snip]
> > 	/* if dev1 is ENQCMD-capable mdev, update CPU PASID=20
> > 	  * translation structure through KVM
> > 	  */
> > 	pa_data =3D {
> > 		.ioasid_fd	=3D ioasid_fd;
> > 		.ioasid		=3D gva_ioasid;
> > 		.guest_pasid	=3D gpasid1;
> > 	};
> > 	ioctl(kvm_fd, KVM_MAP_PASID, &pa_data);
>=20
> Make sense
>=20
> > 	/* Bind guest I/O page table  */
> > 	bind_data =3D {
> > 		.ioasid	=3D gva_ioasid;
> > 		.addr	=3D gva_pgtable1;
> > 		// and format information
> > 	};
> > 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
>=20
> Again I do wonder if this should just be part of alloc_ioasid. Is
> there any reason to split these things? The only advantage to the
> split is the device is known, but the device shouldn't impact
> anything..

I'm pretty sure the device(s) could matter, although they probably
won't usually.  But it would certainly be possible for a system to
have two different host bridges with two different IOMMUs with
different pagetable formats.  Until you know which devices (and
therefore which host bridge) you're talking about, you don't know what
formats of pagetable to accept.  And if you have devices from *both*
bridges you can't bind a page table at all - you could theoretically
support a kernel managed pagetable by mirroring each MAP and UNMAP to
tables in both formats, but it would be pretty reasonable not to
support that.

> > 5.6. I/O page fault
> > +++++++++++++++
> >=20
> > (uAPI is TBD. Here is just about the high-level flow from host IOMMU dr=
iver
> > to guest IOMMU driver and backwards).
> >=20
> > -   Host IOMMU driver receives a page request with raw fault_data {rid,=
=20
> >     pasid, addr};
> >=20
> > -   Host IOMMU driver identifies the faulting I/O page table according =
to
> >     information registered by IOASID fault handler;
> >=20
> > -   IOASID fault handler is called with raw fault_data (rid, pasid, add=
r), which=20
> >     is saved in ioasid_data->fault_data (used for response);
> >=20
> > -   IOASID fault handler generates an user fault_data (ioasid, addr), l=
inks it=20
> >     to the shared ring buffer and triggers eventfd to userspace;
>=20
> Here rid should be translated to a labeled device and return the
> device label from VFIO_BIND_IOASID_FD. Depending on how the device
> bound the label might match to a rid or to a rid,pasid

I like the idea of labelling devices when they're attached, it makes
extension to non-PCI devices much more obvious that having to deal
with concrete RIDs.

But, remember we can only (reliably) determine rid up to the group
boundary.  So if you're labelling devices, all devices in a group
would have to have the same label.  Or you attach the label to a group
not a device, which would be a reason to represent the group as an
object again.

> > -   Upon received event, Qemu needs to find the virtual routing informa=
tion=20
> >     (v_rid + v_pasid) of the device attached to the faulting ioasid. If=
 there are=20
> >     multiple, pick a random one. This should be fine since the purpose =
is to
> >     fix the I/O page table on the guest;
>=20
> The device label should fix this
> =20
> > -   Qemu finds the pending fault event, converts virtual completion dat=
a=20
> >     into (ioasid, response_code), and then calls a /dev/ioasid ioctl to=
=20
> >     complete the pending fault;
> >=20
> > -   /dev/ioasid finds out the pending fault data {rid, pasid, addr} sav=
ed in=20
> >     ioasid_data->fault_data, and then calls iommu api to complete it wi=
th
> >     {rid, pasid, response_code};
>=20
> So resuming a fault on an ioasid will resume all devices pending on
> the fault?
>=20
> > 5.7. BIND_PASID_TABLE
> > ++++++++++++++++++++
> >=20
> > PASID table is put in the GPA space on some platform, thus must be upda=
ted
> > by the guest. It is treated as another user page table to be bound with=
 the=20
> > IOMMU.
> >=20
> > As explained earlier, the user still needs to explicitly bind every use=
r I/O=20
> > page table to the kernel so the same pgtable binding protocol (bind, ca=
che=20
> > invalidate and fault handling) is unified cross platforms.
> >
> > vIOMMUs may include a caching mode (or paravirtualized way) which, once=
=20
> > enabled, requires the guest to invalidate PASID cache for any change on=
 the=20
> > PASID table. This allows Qemu to track the lifespan of guest I/O page t=
ables.
> >
> > In case of missing such capability, Qemu could enable write-protection =
on
> > the guest PASID table to achieve the same effect.
> >=20
> > 	/* After boots */
> > 	/* Make vPASID space nested on GPA space */
> > 	pasidtbl_ioasid =3D ioctl(ioasid_fd, IOASID_CREATE_NESTING,
> > 				gpa_ioasid);
> >=20
> > 	/* Attach dev1 to pasidtbl_ioasid */
> > 	at_data =3D { .ioasid =3D pasidtbl_ioasid};
> > 	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);
> >=20
> > 	/* Bind PASID table */
> > 	bind_data =3D {
> > 		.ioasid	=3D pasidtbl_ioasid;
> > 		.addr	=3D gpa_pasid_table;
> > 		// and format information
> > 	};
> > 	ioctl(ioasid_fd, IOASID_BIND_PASID_TABLE, &bind_data);
> >=20
> > 	/* vIOMMU detects a new GVA I/O space created */
> > 	gva_ioasid =3D ioctl(ioasid_fd, IOASID_CREATE_NESTING,
> > 				gpa_ioasid);
> >=20
> > 	/* Attach dev1 to the new address space, with gpasid1 */
> > 	at_data =3D {
> > 		.ioasid		=3D gva_ioasid;
> > 		.flag 		=3D IOASID_ATTACH_USER_PASID;
> > 		.user_pasid	=3D gpasid1;
> > 	};
> > 	ioctl(device_fd1, VFIO_ATTACH_IOASID, &at_data);
> >=20
> > 	/* Bind guest I/O page table. Because SET_PASID_TABLE has been
> > 	  * used, the kernel will not update the PASID table. Instead, just
> > 	  * track the bound I/O page table for handling invalidation and
> > 	  * I/O page faults.
> > 	  */
> > 	bind_data =3D {
> > 		.ioasid	=3D gva_ioasid;
> > 		.addr	=3D gva_pgtable1;
> > 		// and format information
> > 	};
> > 	ioctl(ioasid_fd, IOASID_BIND_PGTABLE, &bind_data);
>=20
> I still don't quite get the benifit from doing this.
>=20
> The idea to create an all PASID IOASID seems to work better with less
> fuss on HW that is directly parsing the guest's PASID table.
>=20
> Cache invalidate seems easy enough to support
>=20
> Fault handling needs to return the (ioasid, device_label, pasid) when
> working with this kind of ioasid.
>=20
> It is true that it does create an additional flow qemu has to
> implement, but it does directly mirror the HW.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hex0SSC4iy2pvQ2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC3KcEACgkQbDjKyiDZ
s5I9MA/+KLEL4S2rT7+vVvtYMGshHBiNPVG7KHTKbttVIgsw0M1awKtV5gZJnXWP
qO+J9JxQ5jmvPWjQjppt9ViWsswUK9dyd2CHuKUBgpE2kDRC67snpDG3VTTW274N
cee6RrMXOvXx56BX/Y/Ytktzm5vejtnHyo6kmWvLkXjZ94zVO1jXo/m3n4WyOREM
/N9tP7KzfrPLfPKS00DDQXfTKjVEyFSbZ4j+4cdP+YejEA3wV5E+oWcVvO4FaiZi
njLX6aYpowzO+dMlDm51gYoANnORtHyxsdeuf39L5glLgEu7qKulUDRqjLeH+Mpj
kxoPRbCKekjrGAqpV0up9cNC0YG1vyW4DZwBmICAb4d+CMcE7CmX93xwgMrma2SL
gRPaMqCDqiNaWeB4a1jDfjxIsl4jxjBCcxMYdKKhUUFbO73dnYONr8acS27MU05O
mA2igLvfBJGAZNvk+v8jyj8Ec3ecZO7C7rhXE3Qooe1geGBqhPUWgy8u6j8YNyAI
14myX2eeFmSHLSogE1a5L/VPFrMmpuRJatQKyprzZ0EnZRwoSr0rILhoN0j7pl3T
E2I/Q2cCk8dTDC4K1Xy2DFxFg2zZGlcw0SQCB1E9hi1ly2/5XTJswljZMATiM6gB
kWXkBcTbb5yBy0ZWs0y65n4tyzmAJYFdRbdQlBHkbouIvftzcAc=
=Te+B
-----END PGP SIGNATURE-----

--Hex0SSC4iy2pvQ2b--

--===============3324687444453014019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3324687444453014019==--
