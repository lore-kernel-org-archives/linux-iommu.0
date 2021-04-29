Return-Path: <SRS0=7BBB=J2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8827C433ED
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 04:18:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564CC61450
	for <iommu@archiver.kernel.org>; Thu, 29 Apr 2021 04:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564CC61450
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2850A419CA;
	Thu, 29 Apr 2021 04:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxtNF6xnjBuP; Thu, 29 Apr 2021 04:18:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3DC2419B7;
	Thu, 29 Apr 2021 04:18:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EB31C000E;
	Thu, 29 Apr 2021 04:18:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BF19C0001
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 04:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05780419C9
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 04:18:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TmaOiKzs8JbC for <iommu@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 04:18:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 319D7419B7
 for <iommu@lists.linux-foundation.org>; Thu, 29 Apr 2021 04:18:15 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FW2Kx1MK8z9sjD; Thu, 29 Apr 2021 14:18:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1619669893;
 bh=hsi/0KQt96DzQmNT580YEU9V2UkP5TGhmJvkh107yvI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FKTV6jhUCQG6QGXO0yH4rJ0e1PKhM4eKJ+VPACBqzzyMB7lNfd0pf0uJyRsuOpKkS
 4a4aXtGWyzp1xpv7GbZy9pee3/Zw4bA7PCSLwHPsjZJ1McFkwdWmOJSIfyF2xZ3zAn
 i8zpShOOVMxVTYpefxWG3AmPchYbPYKTcg30OJRc=
Date: Thu, 29 Apr 2021 13:04:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YIoiJRY3FM7xH2bH@yekko>
References: <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210428145622.GU1370958@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============4268219068598090486=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4268219068598090486==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XZCPoS4KxluW8njQ"
Content-Disposition: inline


--XZCPoS4KxluW8njQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 28, 2021 at 11:56:22AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 28, 2021 at 10:58:29AM +1000, David Gibson wrote:
> > On Tue, Apr 27, 2021 at 02:12:12PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Apr 27, 2021 at 03:08:46PM +1000, David Gibson wrote:
> > > > > Starting from a BDF the general pseudo code is:
> > > > >  device_name =3D first_directory_of("/sys/bus/pci/devices/BDF/vfi=
o/")
> > > > >  device_fd =3D open("/dev/vfio/"+device_name)
> > > > >  ioasidfd =3D open("/dev/ioasid")
> > > > >  ioctl(device_fd, JOIN_IOASID_FD, ioasidfd)
> > > >=20
> > > > This line is the problem.
> > > >=20
> > > > [Historical aside: Alex's early drafts for the VFIO interface looked
> > > > quite similar to this.  Ben Herrenschmidt and myself persuaded him =
it
> > > > was a bad idea, and groups were developed instead.  I still think i=
t's
> > > > a bad idea, and not just for POWER]
> > >=20
> > > Spawning the VFIO device FD from the group FD is incredibly gross from
> > > a kernel design perspective. Since that was done the struct
> > > vfio_device missed out on a sysfs presence and doesn't have the
> > > typical 'struct device' member or dedicated char device you'd expect a
> > > FD based subsystem to have.
> > >=20
> > > This basically traded normal usage of the driver core for something
> > > that doesn't serve a technical usage. Given we are now nearly 10 years
> > > later and see that real widely deployed applications are not doing
> > > anything special with the group FD it makes me question the wisdom of
> > > this choice.
> >=20
> > I'm really not sure what "anything special" would constitute here.
>=20
> Well, really anything actually. All I see in, say, dpdk, is open the
> group fd, get a device fd, do the container dance and never touch the
> group fd again or care about groups in any way. It seems typical of
> this class of application.

Well, sure, the only operation you do on the group itself is attach it
to the container (and then every container operation can be thought of
as applying to all its attached groups).  But that attach operation
really is fundamentally about the group.  It always, unavoidably,
fundamentally affects every device in the group - including devices
you may not typically think about, like bridges and switches.

That is *not* true of the other device operations, like poking IO.

> If dpdk is exposing other devices to a risk it certainly hasn't done
> anything to make that obvious.

And in practice I suspect it will just break if you give it a >1
device group.

> > > Okay, that is fair, but let's solve that problem directly. For
> > > instance netlink has been going in the direction of adding a "extack"
> > > from the kernel which is a descriptive error string. If the failing
> > > ioctl returned the string:
> > >=20
> > >   "cannot join this device to the IOASID because device XXX in the
> > >    same group #10 is in use"
> >=20
> > Um.. is there a sane way to return strings from an ioctl()?
>=20
> Yes, it can be done, a string buffer pointer and length in the input
> for instance.

I suppose.  Rare enough that I expect everyone will ignore it, alas :/.

> > Getting the device fds from the group fd kind of follows, because it's
> > unsafe to do basically anything on the device unless you already
> > control the group (which in this case means attaching it to a
> > container/ioasid).  I'm entirely open to ways of doing that that are
> > less inelegant from a sysfs integration point of view, but the point
> > is you must manage the group before you can do anything at all with
> > individual devices.
>=20
> I think most likely VFIO is going to be the only thing to manage a
> multi-device group.

You don't get to choose that.  You could explicitly limit other things
to only one-device groups, but that would be an explicit limitation.
Essentially any device can end up in a multi-device group, if you put
it behind a PCIe to PCI bridge, or a PCIe switch which doesn't support
access controls.

The groups are still there, whether or not other things want to deal
with them.

> I see things like VDPA being primarily about PASID, and an IOASID that
> is matched to a PASID is inherently a single device IOMMU group.

I don't know enough about PASID to make sense of that.

> > I don't see why.  I mean, sure, you don't want explicitly the *vfio*
> > group as such.  But IOMMU group is already a cross-subsystem concept
> > and you can explicitly expose that in a different way.
>=20
> Yes, and no, the kernel drivers in something like VDPA have decided
> what device and group they are in before we get to IOASID. It is
> illogical to try to retro-actively bolt in a group concept to their
> APIs.

Again, I don't know enough about VDPA to make sense of that.  Are we
essentially talking non-PCI virtual devices here?  In which case you
could define the VDPA "bus" to always have one-device groups.

> > Again, I realy think this is necessary complexity.  You're right that
> > far too little of the userspace properly understands group
> > restrictions.. but these come from real hardware limitations, and I
> > don't feel like making it *less* obvious in the interface is going to
> > help that.
>=20
> The appeal of making it less obvious is we can have a single
> simplified API flow so that an application that doesn't understand or
> care about groups can have uniformity.

I don't think simplified-but-wrong is a good goal.  The thing about
groups is that if they're there, you can't just "not care" about them,
they affect you whether you like it or not.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XZCPoS4KxluW8njQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCKIiMACgkQbDjKyiDZ
s5Ko9RAAruwUcNc8D5emb4+A75xQ5FhpAN1TX0gJbsRkNbWI5YyofP4isXd7e5vJ
m+5diAhMg7KO37NKLSM5UW4wUotGlmqoDUHbUzWAqTPWsoDFcxUyNnmRJs8VQf5N
UScJmiRZBuh3x/6WB2YpKxY0qGf8FD0yWLDjR8QFKcJPeQyvSkmo7qvVjflt4Y9T
buzgdN+mZ5l3GasBfx3w6HE8s9OlIfD2D5vv1uosc8q+eJcq3axUk83hCqqIQteA
xaNkfFXhuc3DRSTKkAL+B/snZWiG3O9AGOlDM86kHOFAihbH71bIcsgnMjZRSynA
RYed6WpcYXyjxsPxvtLwxTHN4eHS9OGqLVSWnkHS6S5CREbNokA0Uyr1tCWx+V7j
WefMR7fVnWrN6M7ZA3RLiA8Mw5Pd1ObB3kp1FoROqrHaCQe5V3YzyjTENWawSNKx
Dm5os40SkM/6jGXqxtVmLu8qv66RadGR7Hgn9T8YEv99afPgnG5WqoVzXpXmDSqt
29yjzQrDIvz8LO/jDU6dcvIjv9ELV1D4A7AMmWDYrCPEmu2+T6GKSYm60G1aDuYK
/Sd/Mg7HX8hZvTRDrt9BfAt0QC0cWsM6z598wI56cJ+XSy661uStb8wnnVGawlKJ
9VKxystpE/ry52y2kevd0N2OWa5V1AyGVDKdi5GU2h2iVgK1tO8=
=BkOW
-----END PGP SIGNATURE-----

--XZCPoS4KxluW8njQ--

--===============4268219068598090486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4268219068598090486==--
