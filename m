Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C7C47080
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 07:56:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1DD61151
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 07:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1DD61151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 588F6400D0;
	Mon, 24 May 2021 07:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3xBYdonqenXo; Mon, 24 May 2021 07:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E8B04011C;
	Mon, 24 May 2021 07:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6A9EC000E;
	Mon, 24 May 2021 07:56:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0BD2C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 07:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84D4A6065A
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 07:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QjesQaKmR7rE for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 07:56:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18B6760638
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 07:56:12 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FpTzt2xr8z9sVb; Mon, 24 May 2021 17:56:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1621842970;
 bh=InewljPhmAOTWYZHVp4VOTrqC6xVPS1gpvd0iL+ut3E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J6rgbmYWtWWFhis3zi8yS6ODwbnCocdCkiCq6jcT9h+IGBldzkb1d9+nzD3rxVuH5
 Jk3OOLGFmEKKEwbmJGkIJUDXfFaHoMV4tt3UufGErccsUlFMjkwUCRXMC551zlOudA
 QRghIo8vqbSdvbE+5dd7CFBWpZgkQsjgmPS/xxbE=
Date: Mon, 24 May 2021 17:52:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YKtbWo7PwIlXjFIV@yekko>
References: <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210513135938.GG1002214@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============1593780307741255234=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1593780307741255234==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xFSu4L1A5HGCzvT5"
Content-Disposition: inline


--xFSu4L1A5HGCzvT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2021 at 10:59:38AM -0300, Jason Gunthorpe wrote:
> On Thu, May 13, 2021 at 03:48:19PM +1000, David Gibson wrote:
> > On Mon, May 03, 2021 at 01:15:18PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 29, 2021 at 01:04:05PM +1000, David Gibson wrote:
> > > > Again, I don't know enough about VDPA to make sense of that.  Are we
> > > > essentially talking non-PCI virtual devices here?  In which case you
> > > > could define the VDPA "bus" to always have one-device groups.
> > >=20
> > > It is much worse than that.
> > >=20
> > > What these non-PCI devices need is for the kernel driver to be part of
> > > the IOMMU group of the underlying PCI device but tell VFIO land that
> > > "groups don't matter"
> >=20
> > I don't really see a semantic distinction between "always one-device
> > groups" and "groups don't matter".  Really the only way you can afford
> > to not care about groups is if they're singletons.
>=20
> The kernel driver under the mdev may not be in an "always one-device"
> group.

I don't really understand what you mean by that.

> It is a kernel driver so the only thing we know and care about is that
> all devices in the HW group are bound to kernel drivers.
>=20
> The vfio device that spawns from this kernel driver is really a
> "groups don't matter" vfio device because at the IOMMU layer it should
> be riding on the physical group of the kernel driver.  At the VFIO
> layer we no longer care about the group abstraction because the system
> guarentees isolation in some other way.

Uh.. I don't really know how mdevs are isolated from each other.  I
thought it was because the physical device providing the mdevs
effectively had an internal IOMMU (or at least DMA permissioning) to
isolate the mdevs, even though the physical device may not be fully
isolated.

In that case the virtual mdev is effectively in a singleton group,
which is different from the group of its parent device.

If the physical device had a bug which meant the mdevs *weren't*
properly isolated from each other, then those mdevs would share a
group, and you *would* care about it.  Depending on how the isolation
failed the mdevs might or might not also share a group with the parent
physical device.

> The issue is a software one of tightly coupling IOMMU HW groups to
> VFIO's API and then introducing an entire class of VFIO mdev devices
> that no longer care about IOMMU HW groups at all.

The don't necessarily care about the IOMMU groups of the parent
physical hardware, but they have their own IOMMU groups as virtual
hardware devices.

> Currently mdev tries to trick this by creating singleton groups, but
> it is very ugly and very tightly coupled to a specific expectation of
> the few existing mdev drivers. Trying to add PASID made it alot worse.
>=20
> > Aside: I'm primarily using "group" to mean the underlying hardware
> > unit, not the vfio construct on top of it, I'm not sure that's been
> > clear throughout.
>=20
> Sure, that is obviously fixed, but I'm not interested in that.
>=20
> I'm interested in having a VFIO API that makes sense for vfio-pci
> which has a tight coupling to the HW notion of a IOMMU and also vfio
> mdev's that have no concept of a HW IOMMU group.
>=20
> > So.. your model assumes that every device has a safe quiescent state
> > where it won't do any harm until poked, whether its group is
> > currently kernel owned, or owned by a userspace that doesn't know
> > anything about it.
>=20
> This is today's model, yes. When you run dpdk on a multi-group device
> vfio already ensures that all the device groups remained parked and
> inaccessible.

I'm not really following what you're saying there.

If you have a multi-device group, and dpdk is using one device in it,
VFIO *does not* (and cannot) ensure that other devices in the group
are parked and inaccessible.  It ensures that they're parked at the
moment the group moves from kernel to userspace ownership, but it
can't prevent dpdk from accessing and unparking those devices via peer
to peer DMA.

> > At minimum this does mean that in order to use one device in the group
> > you must have permission to use *all* the devices in the group -
> > otherwise you may be able to operate a device you don't have
> > permission to by DMAing to its registers from a device you do have
> > permission to.
>=20
> If the administator configures the system with different security
> labels for different VFIO devices then yes removing groups makes this
> more tricky as all devices in the group should have the same label.

That seems a bigger problem than "more tricky".  How would you propose
addressing this with your device-first model?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xFSu4L1A5HGCzvT5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCrW1gACgkQbDjKyiDZ
s5L8LA/+K9fJGyKxF6JllYmsqBLe6zJi+OJzQLUxg7DgLfhjonnF4bVOTWY93W46
zlcPOo826mL/lHBo0tkVFEuXc1n+J1gf2x/aoh++n3F6Y+ygSjiFYbNmu7n+zjXn
0g2LY282Kd8s9rUKC4pdDlfgd8Vxz08pSG1j9JPAAiJdYkexXjwWSUK5amy+LK5l
/VCO8esU0JDdO1OOAQwVJQChlcKgG0ZJjwiph98q2THjUhr4yUoyBERxIiXxWW9q
7iiGfsstJQ4SMd9PofVqivdBPb9IjJqCnu+Ub+Suf3FoOQfh5fNhLs62p+7w02Ni
L8yDlMNWNiyLuyYCp9A1RyDilUJubfbe14nHnMrwAe3ZBxWsNNfV/g3xvsE+tA2/
znlztP9HDGi3OvUFjr/XSNM1iGTD7cqTgBBDHCmPC/A6ZPgLCxzXTVtUFyjflPUe
IIIU0MNcFgeYN+KuuhJ92x3dk4vGoL0EhoKUnOA7EfIwsS0yl/mz+tVxA+2awZL8
kxN1OtCL24PhdmIGijUDdtwLuOiTByUYU3rmMzFLo4Q+Qw3TOoRDnbwIFUtavjaX
DTsDnquuhQewmhCPM1jYaBk1pNOEmEwc0BGZZQ/1a0X85wYAr76IHf+b4fU9l3wU
4Q5ymMTGV//jwCpSZ/kRRACpaECJp+vRVvhV6Fg0jx7udWDV8Xc=
=rcx7
-----END PGP SIGNATURE-----

--xFSu4L1A5HGCzvT5--

--===============1593780307741255234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1593780307741255234==--
