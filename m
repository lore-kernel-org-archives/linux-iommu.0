Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD8CC4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 04:51:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290B160F02
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 04:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 290B160F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D67B94027C;
	Mon, 26 Jul 2021 04:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RbvMbVy4eE17; Mon, 26 Jul 2021 04:51:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 62EEB400AF;
	Mon, 26 Jul 2021 04:51:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB5FC001A;
	Mon, 26 Jul 2021 04:51:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F046CC000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 04:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5DFF4016A
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 04:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ufxzXi_xqz9p for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:51:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02689400AF
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 04:51:15 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4GY6vM69gcz9sXS; Mon, 26 Jul 2021 14:51:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1627275071;
 bh=m73aMwFAP2jX6K+txI2EzFyqB+BK7DxD/uN54E+hYsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hR01nIz9yvwruRVsDjsLsA11K6SjOp0rkFowl4U1BXLQKr5E7PW7MStn100w57W4B
 pa4kSaKetQIWAx9e3cEXlIoOPI1YpsFZ2ZpYOc7R9nPz/G5xmIS5DBTwyG73cqBeIE
 HG61vumB0/yRTl5OU50a00+Sa1RiaRltN3MNej3M=
Date: Mon, 26 Jul 2021 14:50:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <YP4/KJoYfbaf5U94@yekko>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============8979119405736636286=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8979119405736636286==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7aEjQs3lu4EVkJXc"
Content-Disposition: inline


--7aEjQs3lu4EVkJXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 09, 2021 at 07:48:44AM +0000, Tian, Kevin wrote:
> /dev/iommu provides an unified interface for managing I/O page tables for=
=20
> devices assigned to userspace. Device passthrough frameworks (VFIO, vDPA,=
=20
> etc.) are expected to use this interface instead of creating their own lo=
gic to=20
> isolate untrusted device DMAs initiated by userspace.=20
>=20
> This proposal describes the uAPI of /dev/iommu and also sample sequences=
=20
> with VFIO as example in typical usages. The driver-facing kernel API prov=
ided=20
> by the iommu layer is still TBD, which can be discussed after consensus i=
s=20
> made on this uAPI.
>=20
> It's based on a lengthy discussion starting from here:
> 	https://lore.kernel.org/linux-iommu/20210330132830.GO2356281@nvidia.com/=
=20
>=20
> v1 can be found here:
> 	https://lore.kernel.org/linux-iommu/PH0PR12MB54811863B392C644E5365446DC3=
E9@PH0PR12MB5481.namprd12.prod.outlook.com/T/
>=20
> This doc is also tracked on github, though it's not very useful for v1->v=
2=20
> given dramatic refactoring:
> 	https://github.com/luxis1999/dev_iommu_uapi

Thanks for all your work on this, Kevin.  Apart from the actual
semantic improvements, I'm finding v2 significantly easier to read and
understand than v1.

[snip]
> 1.2. Attach Device to I/O address space
> +++++++++++++++++++++++++++++++++++++++
>=20
> Device attach/bind is initiated through passthrough framework uAPI.
>=20
> Device attaching is allowed only after a device is successfully bound to
> the IOMMU fd. User should provide a device cookie when binding the=20
> device through VFIO uAPI. This cookie is used when the user queries=20
> device capability/format, issues per-device iotlb invalidation and=20
> receives per-device I/O page fault data via IOMMU fd.
>=20
> Successful binding puts the device into a security context which isolates=
=20
> its DMA from the rest system. VFIO should not allow user to access the=20
> device before binding is completed. Similarly, VFIO should prevent the=20
> user from unbinding the device before user access is withdrawn.
>=20
> When a device is in an iommu group which contains multiple devices,
> all devices within the group must enter/exit the security context
> together. Please check {1.3} for more info about group isolation via
> this device-centric design.
>=20
> Successful attaching activates an I/O address space in the IOMMU,
> if the device is not purely software mediated. VFIO must provide device
> specific routing information for where to install the I/O page table in=
=20
> the IOMMU for this device. VFIO must also guarantee that the attached=20
> device is configured to compose DMAs with the routing information that=20
> is provided in the attaching call. When handling DMA requests, IOMMU=20
> identifies the target I/O address space according to the routing=20
> information carried in the request. Misconfiguration breaks DMA
> isolation thus could lead to severe security vulnerability.
>=20
> Routing information is per-device and bus specific. For PCI, it is=20
> Requester ID (RID) identifying the device plus optional Process Address=
=20
> Space ID (PASID). For ARM, it is Stream ID (SID) plus optional Sub-Stream=
=20
> ID (SSID). PASID or SSID is used when multiple I/O address spaces are=20
> enabled on a single device. For simplicity and continuity reason the=20
> following context uses RID+PASID though SID+SSID may sound a clearer=20
> naming from device p.o.v. We can decide the actual naming when coding.
>=20
> Because one I/O address space can be attached by multiple devices,=20
> per-device routing information (plus device cookie) is tracked under=20
> each IOASID and is used respectively when activating the I/O address=20
> space in the IOMMU for each attached device.
>=20
> The device in the /dev/iommu context always refers to a physical one=20
> (pdev) which is identifiable via RID. Physically each pdev can support=20
> one default I/O address space (routed via RID) and optionally multiple=20
> non-default I/O address spaces (via RID+PASID).
>=20
> The device in VFIO context is a logic concept, being either a physical
> device (pdev) or mediated device (mdev or subdev). Each vfio device
> is represented by RID+cookie in IOMMU fd. User is allowed to create=20
> one default I/O address space (routed by vRID from user p.o.v) per=20
> each vfio_device. VFIO decides the routing information for this default
> space based on device type:
>=20
> 1)  pdev, routed via RID;
>=20
> 2)  mdev/subdev with IOMMU-enforced DMA isolation, routed via=20
>     the parent's RID plus the PASID marking this mdev;
>=20
> 3)  a purely sw-mediated device (sw mdev), no routing required i.e. no
>     need to install the I/O page table in the IOMMU. sw mdev just uses=20
>     the metadata to assist its internal DMA isolation logic on top of=20
>     the parent's IOMMU page table;
>=20
> In addition, VFIO may allow user to create additional I/O address spaces
> on a vfio_device based on the hardware capability. In such case the user=
=20
> has its own view of the virtual routing information (vPASID) when marking=
=20
> these non-default address spaces. How to virtualize vPASID is platform
> specific and device specific. Some platforms allow the user to fully=20
> manage the PASID space thus vPASIDs are directly used for routing and
> even hidden from the kernel. Other platforms require the user to=20
> explicitly register the vPASID information to the kernel when attaching=
=20
> the vfio_device. In this case VFIO must figure out whether vPASID should=
=20
> be directly used (pdev) or converted to a kernel-allocated pPASID (mdev)=
=20
> for physical routing. Detail explanation about PASID virtualization can=
=20
> be found in {1.4}.
>=20
> For mdev both default and non-default I/O address spaces are routed
> via PASIDs. To better differentiate them we use "default PASID" (or=20
> defPASID) when talking about the default I/O address space on mdev. When=
=20
> vPASID or pPASID is referred in PASID virtualization it's all about the=
=20
> non-default spaces. defPASID and pPASID are always hidden from userspace=
=20
> and can only be indirectly referenced via IOASID.

That said, I'm still finding the various ways a device can attach to
an ioasid pretty confusing.  Here are some thoughts on some extra
concepts that might make it easier to handle [note, I haven't thought
this all the way through so far, so there might be fatal problems with
this approach].

 * DMA address type

    This represents the format of the actual "over the wire" DMA
    address.  So far I only see 3 likely options for this 1) 32-bit,
    2) 64-bit and 3) PASID, meaning the 84-bit PASID+address
    combination.

 * DMA identifier type

    This represents the format of the "over the wire"
    device-identifying information that the IOMMU receives.  So "RID",
    "RID+PASID", "SID+SSID" would all be DMA identifier types.  We
    could introduce some extra ones which might be necessary for
    software mdevs.

So, every single DMA transaction has both DMA address and DMA
identifier information attached.  In some cases we get to choose how
we split the availble information between identifier and address, more
on that later.

 * DMA endpoint

    An endpoint would represent a DMA origin which is identifiable to
    the IOMMU.  I'm using the new term, because while this would
    sometimes correspond one to one with a device, there would be some
    cases where it does not.

    a) Multiple devices could be a single DMA endpoint - this would
    be the case with non-ACS bridges or PCIe to PCI bridges where
    devices behind the bridge can't be distinguished from each other.
    Early versions might be able to treat all VFIO groups as single
    endpoints, which might simplify transition

    b) A single device could supply multiple DMA endpoints, this would
    be the case with PASID capable devices where you want to map
    different PASIDs to different IOASes.

    **Caveat: feel free to come up with a better name than "endpoint"

    **Caveat: I'm not immediately sure how to represent these to
    userspace, and how we do that could have some important
    implications for managing their lifetime

Every endpoint would have a fixed, known DMA address type and DMA
identifier type (though I'm not sure if we need/want to expose the DMA
identifier type to userspace).  Every IOAS would also have a DMA
address type fixed at IOAS creation.

An endpoint can only be attached to one IOAS at a time.  It can only
be attached to an IOAS whose DMA address type matches the endpoint.

Most userspace managed IO page formats would imply a particular DMA
address type, and also a particular DMA address type for their
"parent" IOAS.  I'd expect kernel managed IO page tables to be able to
be able to handle most combinations.

/dev/iommu would work entirely (or nearly so) in terms of endpoint
handles, not device handles.  Endpoints are what get bound to an IOAS,
and endpoints are what get the user chosen endpoint cookie.

Getting endpoint handles from devices is handled on the VFIO/device
side.  The simplest transitional approach is probably for a VFIO pdev
groups to expose just a single endpoint.  We can potentially make that
more flexible as a later step, and other subsystems might have other
needs.

Example A:  VFIO userspace driver, with non-PASID capable device(s)

  IOAS A1
    IOPT format: Kernel managed
    DMA address type: 64-bit
    Parent DMA address type: Root (User Virtual Address)

     =3D> 1 or more VFIO group endpoints attached
      DMA address type: 64-bit

     Driver manually maps userspace address ranges into A1, and
     doesn't really care what IOVAs it uses.


Example B: Qemu passthrough, no-vIOMMU

  IOAS B1
    IOPT format: Kernel managed
    DMA address type: 64-bit
    Parent DMA address type: Root (User Virtual Address)

     =3D> 1 or more VFIO group endpoints attached
       DMA address type: 64-bit

     Qemu maps guest memory ranges into B1, using IOVAs equal to GPA.

Example C: Qemu passthrough, non-PASID paravirtual vIOMMU

  IOAS C1
    IOPT format: Kernel managed
    DMA address type: 64-bit
    Parent DMA address type: Root (User Virtual Address)

    Qemu maps guest memory ranges into C1, using IOVas equal to GPA

    IOAS C2
      IOPT format: Kernel managed
      DMA address type: 64-bit
      Parent DMA address type: 64-bit

      =3D> 1 or more VFIO group endpoints attached
        DMA address type: 64-bit

      Qemu implements vIOMMU hypercalls updating guest IOMMU domain 0
      to change mappings in C2.

    IOAS C3, C4, ...

      As C2, but for other guest IOMMU domains.

Example D: Qemu passthrough, non-PASID virtual-IOPT vIOMMU

  IOAS D1
    IOPT format: Kernel managed
    DMA address type: 64-bit
    Parent DMA address type: Root (User Virtual Address)

    Qemu maps guest memory ranges into C1, using IOVAs equal to GPA

    IOAS D2
      IOPT format: x86 IOPT (non-PASID)
      DMA address type: 64-bit
      Parent DMA address type: 64-bit

      =3D> 1 or more VFIO group endpoints attached
        DMA address type: 64-bit

      Qemu configures D2 to point at the guest IOPT root.  Guest IOTLB
      flushes are trapped and translated to flushes on D2.

      With nested-IOMMU capable host hardware, /dev/iommu will
      configure the host IOMMU to use D1's IOPT as the L1 and D2's
      IOPT as the L2 for the relevant endpoints

      With a host-IOMMU that isn't nested capable, /dev/iommu will
      shadow the combined D1+D2 mappings into the host IOPT for the
      relevant endpoints.

    IOAS D3, D4, ...
      As D2, but for other guest IOMMU domains

Example E: Userspace driver, single-PASID mdev

  IOAS E1
    IOPT format: Kernel managed
    DMA address type: 64-bit
    Parent DMA address type: Root (User Virtual Address)

    =3D> mdev endpoint attached
      DMA address type: 64-bit
      DMA identifier type: RID+PASID

    Userspace maps the ranges it wants to use, not caring about IOVA

Example F: Userspace driver, PASID capable dev (option 1)

  IOAS F1
    IOPT format: Kernel managed
    DMA address type: PASID
    Parent DMA address type: Root (User Virtual Address)

    =3D> all-PASID endpoint for device
      DMA address type: PASID
      DMA identifier type: RID

    Driver maps in whatever chunks of memory it wants.  Note that
    every IO_MAP operation supplies both a PASID and address (because
    that's the format of a "PASID" type IOVA).


Example G: Userspace driver, PASID capable dev (option 2)

  IOAS G1
    IOPT format: Kernel managed
    DMA address type: 64-bit
    Parent DMA address type: Root (User Virtual Address)

    =3D> one-PASID endpoint for device
      DMA address type: 64-bit
      DMA identifier type: RID+PASID

    Driver makes mappings for a single PASID into G1.  IO_MAP
    operations include only a 64-bit address, because the PASID is
    implied by the choice of IOAS/endpoint

  IOAS G2, G3, ...
    As G1 but for different PASIDs


More examples are possible, of course.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7aEjQs3lu4EVkJXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmD+PygACgkQbDjKyiDZ
s5LMew/8C8rGZdQ1rV2dXaP1zT+uo367BPuqdBT9BdE4OKXqlTmJd1WoUeyiTG+N
+6wMiYuHeUCF20QQnN/hSsbgh0aMGrZBGKa9ZoTAXdc5gEdgh/RM/dEr7UCcbgxL
zQ6E9j1p8sbd/HyPg7QbyoLO0DuNjfRLbB17XtDpBh5qM+TirquOAMBfjV1j2dNJ
b48lMBbaInNDYPVTeRDAOkaQv5Anv07a8PrQe60+WR03P92IegpQMi49JnkruC10
N8X71z9XYhHN9VFGpqUZJPwOn69ss4jpENrJ5C84lodaKqTlpxKjLLxHaaBFBdj0
dNGwoZj1LLYayWmFBMbF0+Vui5LTsIWZTLD7DDT4lPuJBKiToiUNMf0JTKDJwVCh
0jc/hSDnK3cqJ2K5NS+TF7hwCvQKXa/6gLVOPHZPUdSuz2je9NtY1P/1Y59RNw17
l3Ss1hhKjlKj/AmIc9bTuICYNBt+0xhvzS8Js9pNmv1CFMDy/Ht5Di8mYWQV5Z9a
zPCto3LMb7l963tWp52R+QdOiDUQuw0O3AXuBrrPDteXUm7Df4VqbFYGiSRKV4wj
P+atBgrv9YGVzq7K/GiBblulluWhwQgo2zmbdcNmzLbSrRwyFBTb6DM1tARKukyZ
WUjWgfg/f3ipnSn7nrpW6oKTKu7ho4l+9XNFudXKKuRELv2wuUI=
=AVNu
-----END PGP SIGNATURE-----

--7aEjQs3lu4EVkJXc--

--===============8979119405736636286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8979119405736636286==--
