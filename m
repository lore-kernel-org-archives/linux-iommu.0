Return-Path: <SRS0=MlyH=OW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD797C433F5
	for <iommu@archiver.kernel.org>; Sat,  2 Oct 2021 06:13:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4822361A8F
	for <iommu@archiver.kernel.org>; Sat,  2 Oct 2021 06:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4822361A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36D2940853;
	Sat,  2 Oct 2021 06:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7QgfZUaVsPP; Sat,  2 Oct 2021 06:13:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E08B840821;
	Sat,  2 Oct 2021 06:13:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5953C000F;
	Sat,  2 Oct 2021 06:13:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E462C000D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 06:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4385C60606
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 06:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XFnxcHOy-OST for <iommu@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 06:13:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A530605CD
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 06:13:51 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HLxWC2h8Rz4xbR; Sat,  2 Oct 2021 16:13:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1633155223;
 bh=ClY2unyrJyQWFTOjfDEmqDjBYJTZcBwuvTppM9Pk0jQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g2RgXqUu61b7LKmEoAqOoux9n87/etpqXLqTujl4z/ZqNqo6ROa0ipnfuFY8R+fpb
 nXToxcUyv/vEC9BbMtsaFIuwBGjMyhjL5EapY121T8NrqtkuVWn+YN81MKbUrVR3Mk
 +KFej0UvUcP30Jy7cRcRAK7yk9IwZAXWrO09gC74=
Date: Sat, 2 Oct 2021 14:21:38 +1000
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YVfeUkW7PWQeYFJQ@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com> <YVaoamAaqayk1Hja@yekko>
 <20211001122505.GL964074@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211001122505.GL964074@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============4777198991669571575=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4777198991669571575==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J9KDzT2u912KymBn"
Content-Disposition: inline


--J9KDzT2u912KymBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 01, 2021 at 09:25:05AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 01, 2021 at 04:19:22PM +1000, david@gibson.dropbear.id.au wro=
te:
> > On Wed, Sep 22, 2021 at 11:09:11AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 22, 2021 at 03:40:25AM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Wednesday, September 22, 2021 1:45 AM
> > > > >=20
> > > > > On Sun, Sep 19, 2021 at 02:38:39PM +0800, Liu Yi L wrote:
> > > > > > This patch adds IOASID allocation/free interface per iommufd. W=
hen
> > > > > > allocating an IOASID, userspace is expected to specify the type=
 and
> > > > > > format information for the target I/O page table.
> > > > > >
> > > > > > This RFC supports only one type (IOMMU_IOASID_TYPE_KERNEL_TYPE1=
V2),
> > > > > > implying a kernel-managed I/O page table with vfio type1v2 mapp=
ing
> > > > > > semantics. For this type the user should specify the addr_width=
 of
> > > > > > the I/O address space and whether the I/O page table is created=
 in
> > > > > > an iommu enfore_snoop format. enforce_snoop must be true at thi=
s point,
> > > > > > as the false setting requires additional contract with KVM on h=
andling
> > > > > > WBINVD emulation, which can be added later.
> > > > > >
> > > > > > Userspace is expected to call IOMMU_CHECK_EXTENSION (see next p=
atch)
> > > > > > for what formats can be specified when allocating an IOASID.
> > > > > >
> > > > > > Open:
> > > > > > - Devices on PPC platform currently use a different iommu drive=
r in vfio.
> > > > > >   Per previous discussion they can also use vfio type1v2 as lon=
g as there
> > > > > >   is a way to claim a specific iova range from a system-wide ad=
dress space.
> > > > > >   This requirement doesn't sound PPC specific, as addr_width fo=
r pci
> > > > > devices
> > > > > >   can be also represented by a range [0, 2^addr_width-1]. This =
RFC hasn't
> > > > > >   adopted this design yet. We hope to have formal alignment in =
v1
> > > > > discussion
> > > > > >   and then decide how to incorporate it in v2.
> > > > >=20
> > > > > I think the request was to include a start/end IO address hint wh=
en
> > > > > creating the ios. When the kernel creates it then it can return t=
he
> > > >=20
> > > > is the hint single-range or could be multiple-ranges?
> > >=20
> > > David explained it here:
> > >=20
> > > https://lore.kernel.org/kvm/YMrKksUeNW%2FPEGPM@yekko/
> >=20
> > Apparently not well enough.  I've attempted again in this thread.
> >=20
> > > qeumu needs to be able to chooose if it gets the 32 bit range or 64
> > > bit range.
> >=20
> > No. qemu needs to supply *both* the 32-bit and 64-bit range to its
> > guest, and therefore needs to request both from the host.
>=20
> As I understood your remarks each IOAS can only be one of the formats
> as they have a different PTE layout. So here I ment that qmeu needs to
> be able to pick *for each IOAS* which of the two formats it is.

No.  Both windows are in the same IOAS.  A device could do DMA
simultaneously to both windows.  More realstically a 64-bit DMA
capable and a non-64-bit DMA capable device could be in the same group
and be doing DMAs to different windows simultaneously.

> > Or rather, it *might* need to supply both.  It will supply just the
> > 32-bit range by default, but the guest can request the 64-bit range
> > and/or remove and resize the 32-bit range via hypercall interfaces.
> > Vaguely recent Linux guests certainly will request the 64-bit range in
> > addition to the default 32-bit range.
>=20
> And this would result in two different IOAS objects

There might be two different IOAS objects for setup, but at some point
they need to be combined into one IOAS to which the device is actually
attached.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J9KDzT2u912KymBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFX3k8ACgkQbDjKyiDZ
s5LXKxAAgo51nOaQtxRDoMJ4C/l/AUYRxZ82OlaL1mT1g13qDkSlNTm6MMuWyhET
lQwij9zggi4g7sVBDBogYy7D7YdOFjmaIWjukC0X8pFs+WPxOSknYB5qFB15IqN1
RqhhdyxVspx5p4lhuME3BKqzKPRFoJTgBpG/FunT6EFQYBM4JoDPJ+whX7FOu0ZE
ixa3/UloLTbM7ieyykLS5HDH8pEJtgRAzl1pkl73lzJ1BTBD0i0ODC3ifqCscPUG
HR+5dguFw4Wf7RVZECi4VbRy23ebXAzS0V7gcNOAlZp3Ut+YS4AHtd8MxNv26Nzh
CTZzbmapeU1yHo5EEcv5o9nIE+wrUTt8cl2xew9g7h2X50c2qf+haEsxrEMYhW+v
ZOG4hx/buszpmppTOksqCiXVJ4X5t4FFuSPz9s8j68E759Qir1yI5SgqmFkOLfDj
n6tzwqJJkXfdPKNDHi2/7JTeFGQSTYAWJKoGsFli2OPOx0OjPZzbqxvPcUrk3COk
KhzX62baQjCtyQ5vKNIqeYOjUkvmrOTm7pPsJKCruEiOc+4hZcPBJZptDHy64VSv
PY3IT2z8jQMvIbO0sNWW4xBo6d7DJ0ERNcM6tI1uaM31SNTmjiUyUHqYU1xVuELb
1MpsSqYTBJdy38M8Qz0ANW6dqX4z3U8xOXzjIWZzrcYxSzl7XBg=
=amnN
-----END PGP SIGNATURE-----

--J9KDzT2u912KymBn--

--===============4777198991669571575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4777198991669571575==--
