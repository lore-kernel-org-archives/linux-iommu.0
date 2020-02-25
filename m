Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E40C35E04
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 18:08:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300C1206E6
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wf6YPZR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300C1206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EDE6185FDB;
	Tue, 25 Feb 2020 18:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GZ5RLUuPsTfB; Tue, 25 Feb 2020 18:08:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E2A485FD7;
	Tue, 25 Feb 2020 18:08:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18DF4C1D87;
	Tue, 25 Feb 2020 18:08:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E8A5C089F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 18:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 74CEB20131
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 18:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BV7+BaTf1b1t for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 18:08:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 6142120BF9
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582654118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IV9iCfY5c3a7JirX2PZ8bK4FpcRRJ4TVXDCckUK82Y=;
 b=Wf6YPZR1HhoKCAEb6XDKbIB2hZMPrB3zt+bFlg7+RKDhdNIH+egJYjcbf5vUgF+t0m7jzC
 fez+b0192PvXeE5KFwXZJO/j6+1a7DIkzqYi6wGfKyNFAUcsOarGF15JSe8UDIAeB6GYUI
 TaGoFH7AMRcGKactw8K+4jKrpyli66U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-mkytsSLnM3-EPh-T7JujmQ-1; Tue, 25 Feb 2020 13:08:25 -0500
X-MC-Unique: mkytsSLnM3-EPh-T7JujmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98A151902EC6;
 Tue, 25 Feb 2020 18:08:22 +0000 (UTC)
Received: from gondolin (ovpn-116-60.ams2.redhat.com [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 915BB2718C;
 Tue, 25 Feb 2020 18:08:15 +0000 (UTC)
Date: Tue, 25 Feb 2020 19:08:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200225190802.753cffef.cohuck@redhat.com>
In-Reply-To: <20200224194953.37c0d6b8.pasic@linux.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com>
 <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
 <20200221032727.GC2298@umbus.fritz.box>
 <20200221140639.54928efe.pasic@linux.ibm.com>
 <20200221104724-mutt-send-email-mst@kernel.org>
 <20200221190702.68fd57fc.pasic@linux.ibm.com>
 <20200224033314.GC1751@umbus.fritz.box>
 <20200224194953.37c0d6b8.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Michael Mueller <mimu@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============7584847127456607323=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============7584847127456607323==
Content-Type: multipart/signed; boundary="Sig_/7XSgLlA.c4LHCPdTbS+mPE=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/7XSgLlA.c4LHCPdTbS+mPE=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Feb 2020 19:49:53 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 24 Feb 2020 14:33:14 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Feb 21, 2020 at 07:07:02PM +0100, Halil Pasic wrote: =20
> > > On Fri, 21 Feb 2020 10:48:15 -0500
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >  =20
> > > > On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote: =20
> > > > > On Fri, 21 Feb 2020 14:27:27 +1100
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >  =20
> > > > > > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wro=
te: =20
> > > > > > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeg=
er wrote: =20
> > > > > > > > >From a users perspective it makes absolutely perfect sense=
 to use the =20
> > > > > > > > bounce buffers when they are NEEDED.=20
> > > > > > > > Forcing the user to specify iommu_platform just because you=
 need bounce buffers
> > > > > > > > really feels wrong. And obviously we have a severe performa=
nce issue
> > > > > > > > because of the indirections. =20
> > > > > > >=20
> > > > > > > The point is that the user should not have to specify iommu_p=
latform.
> > > > > > > We need to make sure any new hypervisor (especially one that =
might require
> > > > > > > bounce buffering) always sets it, =20
> > > > > >=20
> > > > > > So, I have draft qemu patches which enable iommu_platform by de=
fault.
> > > > > > But that's really because of other problems with !iommu_platfor=
m, not
> > > > > > anything to do with bounce buffering or secure VMs.
> > > > > >=20
> > > > > > The thing is that the hypervisor *doesn't* require bounce buffe=
ring.
> > > > > > In the POWER (and maybe s390 as well) models for Secure VMs, it=
's the
> > > > > > *guest*'s choice to enter secure mode, so the hypervisor has no=
 reason
> > > > > > to know whether the guest needs bounce buffering.  As far as th=
e
> > > > > > hypervisor and qemu are concerned that's a guest internal detai=
l, it
> > > > > > just expects to get addresses it can access whether those are G=
PAs
> > > > > > (iommu_platform=3Doff) or IOVAs (iommu_platform=3Don). =20
> > > > >=20
> > > > > I very much agree!
> > > > >  =20
> > > > > >  =20
> > > > > > > as was a rather bogus legacy hack =20
> > > > > >=20
> > > > > > It was certainly a bad idea, but it was a bad idea that went in=
to a
> > > > > > public spec and has been widely deployed for many years.  We ca=
n't
> > > > > > just pretend it didn't happen and move on.
> > > > > >=20
> > > > > > Turning iommu_platform=3Don by default breaks old guests, some =
of which
> > > > > > we still care about.  We can't (automatically) do it only for g=
uests
> > > > > > that need bounce buffering, because the hypervisor doesn't know=
 that
> > > > > > ahead of time. =20

We could default to iommu_platform=3Don on s390 when the host has active
support for protected virtualization... but that's just another kind of
horrible, so let's just pretend I didn't suggest it.

> > > > >=20
> > > > > Turning iommu_platform=3Don for virtio-ccw makes no sense whatsov=
er,
> > > > > because for CCW I/O there is no such thing as IOMMU and the addre=
sses
> > > > > are always physical addresses. =20
> > > >=20
> > > > Fix the name then. The spec calls is ACCESS_PLATFORM now, which
> > > > makes much more sense. =20
> > >=20
> > > I don't quite get it. Sorry. Maybe I will revisit this later. =20
> >=20
> > Halil, I think I can clarify this.
> >=20
> > The "iommu_platform" flag doesn't necessarily have anything to do with
> > an iommu, although it often will.  Basically it means "access guest
> > memory via the bus's normal DMA mechanism" rather than "access guest
> > memory using GPA, because you're the hypervisor and you can do that".
> >  =20
>=20
> Unfortunately, I don't think this is what is conveyed to the end users.
> Let's see what do we have documented:
>=20
> Neither Qemu user documentation
> (https://www.qemu.org/docs/master/qemu-doc.html) nor online help:
> qemu-system-s390x -device virtio-net-ccw,?|grep iommu
>   iommu_platform=3D<bool>  - on/off (default: false)
> has any documentation on it.

Now, that's 'helpful' -- this certainly calls out for a bit of doc...

>=20
> But libvirt does have have documenttion on the knob that contros
> iommu_platform for QEMU (when  QEMU is managed by libvirt):
> """
> Virtio-related options=20
>=20
> QEMU's virtio devices have some attributes related to the virtio
> transport under the driver element: The iommu attribute enables the use
> of emulated IOMMU by the device. The attribute ats controls the Address
> Translation Service support for PCIe devices. This is needed to make use
> of IOTLB support (see IOMMU device). Possible values are on or off.
> Since 3.5.0=20
> """
> (https://libvirt.org/formatdomain.html#elementsVirtio)
>=20
> Thus it seems the only available documentation says that it "enables the =
use
> of emulated IOMMU by the device".
>=20
> And for vhost-user we have
> """
> When the ``VIRTIO_F_IOMMU_PLATFORM`` feature has not been negotiated:
>=20
> * Guest addresses map to the vhost memory region containing that guest
>   address.
>=20
> When the ``VIRTIO_F_IOMMU_PLATFORM`` feature has been negotiated:
>=20
> * Guest addresses are also called I/O virtual addresses (IOVAs).  They ar=
e
>   translated to user addresses via the IOTLB.
> """
> (docs/interop/vhost-user.rst)
>=20
> > For the case of ccw, both mechanisms end up being the same thing,
> > since CCW's normal DMA *is* untranslated GPA access.
> >  =20
>=20
> Nod.
>=20
> > For this reason, the flag in the spec was renamed to ACCESS_PLATFORM,
> > but the flag in qemu still has the old name.
> >  =20
>=20
> Yes, the name in the spec is more neutral.
>=20
> > AIUI, Michael is saying you could trivially change the name in qemu
> > (obviously you'd need to alias the old name to the new one for
> > compatibility).
> >  =20
>=20
> I could, and the I could also ask the libvirt guys to change <driver
> iommu=3D'X'> to <driver access_platform=3D'X'> or similar and to change =
=20
> their documentation to something that is harder to comprehend. Although
> I'm not sure they would like the idea.

Hopefully, the documentation can be changed to something that is _not_
harder to comprehend :) (with a bit more text, I suppose.) Renaming to
something like access_platform seems like a good idea, even with the
required compat dance.

>=20
> >=20
> > Actually, the fact that ccw has no translation makes things easier for
> > you: you don't really have any impediment to turning ACCESS_PLATFORM
> > on by default, since it doesn't make any real change to how things
> > work. =20
>=20
> Yeah, it should not, in theory, but currently it does in practice.
> Currently vhost will try to do the IOTLB dance (Jason has a patch that
> should help with that), and we get the 'use dma api' side effects in the
> guest (e.g. virtqueue's data go <2G + some overhead).

Nod.

>=20
> >=20
> > The remaining difficulty is that the virtio driver - since it can sit
> > on multiple buses - won't know this, and will reject the
> > ACCESS_PLATFORM flag, even though it could just do what it normally
> > does on ccw and it would work. =20
>=20
> Right ACCESS_PLATFORM is a funny feature where the device refuses to
> work if the driver does not ack.
>=20
> >=20
> > For that case, we could consider a hack in qemu where for virtio-ccw
> > devices *only* we allow the guest to nack the ACCESS_PLATFORM flag and
> > carry on anyway.  Normally we insist that the guest accept the
> > ACCESS_PLATFORM flag if offered, because on most platforms they
> > *don't* amount to the same thing. =20
>=20
> Jason found a nice way to differentiate between needs translation and
> does not need translation. But that patch still requires the ack by the
> driver (and as Michael has pointed out we have to consider migration).
>=20
> I'm afraid that  F_IOMMU_PLATFORM means different things in different
> contexts, and that this ain't sufficiently documented. I'm tempted to do
> a proper write-up on this (let's hope my motivation will and my time
> will allow). I would also very much like to have Conny's opinion on this.

More documentation is never a bad idea; but I'm afraid I don't have any
further insights at the moment.

--Sig_/7XSgLlA.c4LHCPdTbS+mPE=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5VYoIACgkQ3s9rk8bw
L6/mjRAAoslzkMKwoGgYUCinI1dNjxuvwTQ8vr4DZ1zeWi+bPXfDsBvjciNW1lh9
ikehLfdOu8vvx+e6AAnc12h5QPs+GgBeIIE8mPZVHaXcX1nVoKLr7LB0ByguUNNh
zRGYp+Fd0ESEsjUYVDsvTQOHuS0bwEHCVc3Nr+K9znpSXuS4N8eHcKMMBnCDGqvM
tUcr7TAISLjiasCihiRMpld0enauOLO5DdlfQCMRHSvWAdxT3brcGjxbBFJ+tR/t
hUphD5u5TTiKUMvBmpWRjCxihJnvN9lYn1CKa/HEo4wjhBzG48ZzrJ2K+NkP1kEh
fgIt2DnBDebZ5fmWZF2hbuAXl6BWqZ0szMcbarIezxBxjmY22tRtue+6DMyQHrHd
eW0OVK6v3b4niqA65Ica2tR/YNLrkDMWJRPeHBfsSWlIQdBuSZxPmymgaXdWexUQ
j7zBC9yxCqMmZj4RFsNS/UGD8aGu6zvV4Ks7KJRhPx09/vP/BKWzSNTh7xozyTKM
q5Q8VW46cebaHtUd6l2c+7eEJQQXYyc94lXkUVbY18uK9LvAXF2nYtW1OS6ahc6U
QQ6jmXUqME6Z/ou2jJUCowu0r/+c7etX3mPtk+UmZq6VAiGJrPgUX8lJ6Qkfus1S
NiNXjpGhkgoDqPF6LUZv6sq7zzx6G/qfaLhIYpEldryZDC4KxTs=
=x9eH
-----END PGP SIGNATURE-----

--Sig_/7XSgLlA.c4LHCPdTbS+mPE=--


--===============7584847127456607323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7584847127456607323==--

